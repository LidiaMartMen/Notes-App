import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app_riverpod/data/user_service.dart';
import 'package:notes_app_riverpod/utils/extensions.dart';


class RegisterScreen extends StatelessWidget {
  //Inicializar los controladores de texto:
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
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
                validator: (name){
                  if(name == null || name.isEmpty){
                    return 'Ingrese su nombre de usuario';
                  } return null;
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
                validator: (password){
                  if(password == null || password.isEmpty){
                    return 'Ingrese su contraseña';
                  } return null;
                },
              ),
              const SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () {
                  //Validar el formulario:
                  if(Form.of(context).validate()){
                     //Acceder al nombre y contraseña:
                  final name = nameController.text;
                  final password = passwordController.text;

                  //Guardar usuario en SharedPreferences:
                  UserService.saveUserInfo(name, password);

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
