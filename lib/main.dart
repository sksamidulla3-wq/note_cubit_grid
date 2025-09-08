import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_cubit_grid/screens/add&update_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cubit/notecubit_cubit.dart';
import 'database/db.dart';
import 'onboarding/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool(AppDataBase.login) ?? false;

  runApp(
    BlocProvider(
      create: (ctx) => NotecubitCubit(appDataBase: AppDataBase.instance),
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: isLoggedIn ? MyHomePage(title: "My Notes") : LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final random = Random();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<NotecubitCubit>().getAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title),
        actions: [
          IconButton(onPressed: (){
            context.read<NotecubitCubit>().appDataBase.loggedOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=> LoginPage()));
          }, icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: BlocBuilder<NotecubitCubit, NotecubitState>(
        builder: (context, state) {
          if (state is NotecubitLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is NotecubitErrorState) {
            return Center(child: Text(state.errorMsg));
          }
          if (state is NotecubitLoadedState) {
            return state.mData.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(5),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                          ),
                      itemCount: state.mData.length,
                      itemBuilder: (ctx, index) {
                        var currData = state.mData[index];
                        return GridTile(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => AddUpdatePage(
                                    isEdit: true,
                                    notes: currData,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.black),
                                color: Colors
                                    .primaries[random.nextInt(
                                      Colors.primaries.length,
                                    )]
                                    .shade300,
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(currData.note_title),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(currData.note_desc),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: () {
                                        showDialog(context: context, builder: (ctx) => AlertDialog(
                                          title: Text("Are you sure want to delete the note?"),
                                          actions: [
                                            TextButton(onPressed: (){
                                              context.read<NotecubitCubit>().deleteNotes(currData.note_id);
                                              Navigator.pop(context);
                                            }, child: Text("Yes")),
                                            TextButton(onPressed: (){
                                              Navigator.pop(context);
                                            }, child: Text("No")),
                                          ],
                                        ));
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 18,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Center(child: Text("No Note Added Yet!!"));
          }
          return Container(child: Text("data"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: CircleBorder(side: BorderSide(color: Colors.black)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (ctx) => AddUpdatePage(isEdit: false,)),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
