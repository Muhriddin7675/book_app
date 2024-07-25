import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../presenter/page/profil/profil_bloc.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    return BlocBuilder<ProfilBloc, ProfilState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 120,
              width: 120,
              child: state.pickedImage == null
                  ? const Text(
                      textAlign: TextAlign.center,
                      'No image selected',
                      style: TextStyle(fontSize: 14),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.file(
                        File(state.pickedImage!.path),
                        height: 120,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    final pickedFile = await picker.pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      if (!context.mounted) return;
                      context.read<ProfilBloc>().add(ProfilImageSelected(image: pickedFile));
                    }
                  },
                  icon: const Icon(
                    Icons.add_a_photo,
                    size: 24,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      if (!context.mounted) return;
                      context.read<ProfilBloc>().add(ProfilImageSelected(image: pickedFile));
                    }
                  },
                  icon: const Icon(
                    Icons.photo_library,
                    size: 24,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
