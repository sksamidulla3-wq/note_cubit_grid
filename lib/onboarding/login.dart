import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_cubit_grid/cubit/notecubit_cubit.dart';
import 'package:note_cubit_grid/database/db.dart';
import 'package:note_cubit_grid/main.dart';
import 'package:note_cubit_grid/onboarding/singup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Welcome Again"),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.pink),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.pink),
                ),
              ),
            ),
            SizedBox.square(dimension: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.pink),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.pink),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var check = await context
                    .read<NotecubitCubit>()
                    .appDataBase
                    .authenticateUser(
                      emailController.text,
                      passwordController.text,
                    );
                if (check) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => MyHomePage(title: "Notes App Cubit"),
                    ),
                  );
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Login Successfully")));
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Invalid Details")));
                }
              },
              child: Text("Login"),
            ),
            SizedBox.square(dimension: 10),
            Text("New User?"),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) {
                      return SignUpPage();
                    },
                  ),
                );
              },
              child: Text("Sign"),
            ),
          ],
        ),
      ),
    );
  }
}
