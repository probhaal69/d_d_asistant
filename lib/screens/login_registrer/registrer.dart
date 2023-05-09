import 'package:flutter/material.dart';
import 'package:d_d_asistant/models/models.dart';

import '../../models/validar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  Future<dynamic> _register() async {
    if (!isFormularioCompleto(_usernameController.text, _emailController.text, _passwordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Faltan datos')),
      );
      return;
    }
    if (!isValidEmail(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email no valido')),
      );
      return;
    }
    if (!isValidPassword(_passwordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contraseña no valida, como minimo 5 caracteres, una mayuscula, una minuscula, un numero y un caracter especial')),
      );
      return;
    }
    final respuesta = await registrarUsuario(_usernameController.text,_emailController.text, _passwordController.text);
    switch (respuesta) {
      case 200:
      case 201:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registrado con exito')),
        );
        Navigator.of(context).pushReplacementNamed('/login');
        break;
      case 409:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email ya existe')),
        );
        break;
      case 500:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error registrando usuario')),
        );
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar sesión')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(title: const Text('Registro')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Nombre de usuario'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Correo electrónico'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _register,
                child: const Text('Registrarse'),
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                child: const Text('Inisiar sesion'),
              ),
        ],
      ),
      ),
    ),
    );
  }
}