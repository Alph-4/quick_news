import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
          userCard(),
          const SizedBox(height: 20),
          ListTile(
            onTap: () {
              // TODO:
            },
            title: const Text('Edit Profile'),
          ),
          const SizedBox(height: 20),
          ListTile(
            onTap: () {
              // TODO: go to store app page
            },
            title: const Text('Rate App'),
          ),
          const SizedBox(height: 20),
          ListTile(
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
}

Widget userCard() {
  return Card(
    child: Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          CachedNetworkImage(
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.contain,
            imageUrl: LocalUser().profileImageUrl!,
            imageBuilder: (context, imageProvider) {
              // you can access to imageProvider
              return CircleAvatar(
                radius: 25,
                // or any widget that use imageProvider like (PhotoView)
                backgroundImage: imageProvider,
              );
            },
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
