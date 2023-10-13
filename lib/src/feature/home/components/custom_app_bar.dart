
import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/service/auth_service.dart';

class CustomLogOutAppBar extends StatelessWidget {
  const CustomLogOutAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: null,
      actions: [
        IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Are you sure"),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("No"),
                        ),
                        TextButton(
                          onPressed: () {
                            AuthService.signOut();
                            Navigator.pop(context);
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.logout,
              color: AppColors.red,
            ),)
      ],
    );
  }
}
