import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_news/src/data/local/model/local_user.dart';
import 'package:quick_news/src/ui/profile/profile_view_model.dart';

class EditProfilPage extends ConsumerStatefulWidget {
  const EditProfilPage({super.key});

  @override
  _EditProfilPageState createState() => _EditProfilPageState();
}

class _EditProfilPageState extends ConsumerState<EditProfilPage> {
  final _formKey = GlobalKey<FormState>();
  File? _imageFile;

  late TextEditingController emailController;
  late TextEditingController displayNameController;
  late TextEditingController initialAccountSizeController;

  @override
  void initState() {
    super.initState();

    emailController = TextEditingController();
    displayNameController = TextEditingController();
    initialAccountSizeController = TextEditingController();

    emailController.text = LocalUser().email!;
    displayNameController.text = LocalUser().displayName!;
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    displayNameController.dispose();
    initialAccountSizeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel = ref.read(profileViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            content(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                child: FilledButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await profileViewModel.saveProfile(
                          displayName: displayNameController.text,
                          initialAccountSize: double.parse(
                            initialAccountSizeController.text,
                          ),
                          imageFile: _imageFile,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Profile updated successfully')),
                        );
                        Navigator.of(context).pop();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Failed to update profile')),
                        );
                      }
                    }
                  },
                  child: const Text('Save Profile'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget content() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!) as ImageProvider
                      : (LocalUser().profileImageUrl != null &&
                              LocalUser().profileImageUrl!.isNotEmpty)
                          ? NetworkImage(LocalUser().profileImageUrl!)
                          : null,
                  child: LocalUser().profileImageUrl == null
                      ? const Icon(Icons.camera_alt, size: 50)
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: displayNameController,
              decoration: const InputDecoration(
                labelText: 'Display Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a display name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: initialAccountSizeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Initial Account Size',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the initial account size';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
}
