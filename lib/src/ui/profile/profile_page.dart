import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quick_news/src/data/local/model/local_user.dart';
import 'package:quick_news/src/ui/contact_us/contact_page.dart';
import 'package:quick_news/src/ui/theme/app_theme.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool _isDarkMode = false;
  File? _imageFile;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO:
            },
          ),
          IconButton(
            icon: _isDarkMode
                ? const Icon(Icons.lightbulb_outline)
                : const Icon(Icons.lightbulb),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
              ref.read(appThemeModeProvider.notifier).state =
                  _isDarkMode ? ThemeMode.dark : ThemeMode.light;
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          userCard(_imageFile),
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.person),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              // TODO:
            },
            title: const Text('Edit Profile'),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.star),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              // TODO: go to store app page
            },
            title: const Text('Rate App'),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.favorite),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ContactPage(),
                ),
              );
            },
            title: const Text('Favorites Article'),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: Icon(Icons.mail),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ContactPage(),
                ),
              );
            },
            title: const Text('Send Suggestions'),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Version 1.0.0'),
          ),
        ],
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

  Widget userCard(File? imageFile) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Center(
              child: GestureDetector(
                onTap: () => _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: imageFile != null
                      ? FileImage(imageFile!) as ImageProvider
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
            const SizedBox(
              width: 16,
            ),
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocalUser().displayName!,
                    ),
                    Text(
                      LocalUser().email!,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
