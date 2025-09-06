import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_cubit_grid/cubit/notecubit_cubit.dart';
import 'package:note_cubit_grid/models/user_model.dart';
import 'login.dart';

class SignUpPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Column(
        children: [
          Text("Welcome Again"),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "User Name",
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
              if (emailController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty) {
                var check = await context
                    .read<NotecubitCubit>()
                    .appDataBase
                    .checkUserExisted(emailController.text);
                if (check) {
                  context.read<NotecubitCubit>().appDataBase.createUser(
                    UserModel(
                      user_name: nameController.text,
                      user_email: emailController.text,
                      user_password: passwordController.text,
                      user_id: 0,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("User Already existed")),
                  );
                }
              } else {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("fill all the details")));
              }
            },
            child: Text("SignUp"),
          ),
          SizedBox(height: 10),
          Text("Already Have Account?"),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            child: Text("Login"),
          ),
        ],
      ),
    );
  }
}
