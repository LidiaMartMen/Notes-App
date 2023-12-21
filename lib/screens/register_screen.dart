// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app_riverpod/data/entities/entities.dart';
import 'package:notes_app_riverpod/data/user_service.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';

class RegisterScreen extends StatelessWidget {
  //Inicializar los controladores de texto:
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //Añade un formKey al Form:
  final _formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Note App',
                style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: colors.primary),
              ),
              const SizedBox(
                height: 90,
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: 'Nombre de usuario',
                    hintStyle: context.textTheme.titleMedium),
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return 'Ingrese su nombre de usuario';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true, //para que se oculte la contraseña
                decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintStyle: context.textTheme.titleSmall),
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return 'Ingrese su contraseña';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () async {
                  //Validar el formulario:
                  if (_formKey.currentState?.validate() ?? false) {
                    //Acceder al nombre y contraseña:
                    final name = nameController.text;
                    final password = passwordController.text;
                   

                    //Obtener lista de usuarios:
                    final savedUserList = await UserService.getUsersList();

                    //Comprobar si hay un usuario ya registrado con ese nombre:
                    if (savedUserList.any((user) => user.name == name)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Nombre de usuario ya existe')));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Usuario registrado correctamente')));
                          
                      //Guardar usuario en SharedPreferences:
                      final newUser = User(name, password);
                      await UserService.addUser(newUser);
                    }

                    //Ir a la pantalla de inicio sesión:
                    context.push('/login');
                  }
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: colors.primary),
                child: Text(
                  'Guardar usuario',
                  style: context.textTheme.titleSmall
                      ?.copyWith(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
