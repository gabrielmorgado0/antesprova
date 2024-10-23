// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:tese2k/main.dart';
import '../biometria/biometria_service.dart'; // Pode ser necessário se houver funcionalidade de biometria
import 'package:tese2k/pages/materia.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  bool _isBiometricSupported = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricSupport();
  }

  Future<void> _checkBiometricSupport() async {
    bool canCheckBiometrics = await auth.canCheckBiometrics;
    setState(() {
      _isBiometricSupported = canCheckBiometrics;
    });
    if (_isBiometricSupported) {
      _authenticateBiometrics();
    }
  }

  Future<void> _authenticateBiometrics() async {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Autentique-se para continuar',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (authenticated) {
        // Navegue para a próxima tela após autenticação bem-sucedida
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MateriasScreen()),
        );
      }
    } catch (e) {
      print('Erro na autenticação biométrica: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, size: 35),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 200,width: 200),
            SizedBox(height: 32),//image network
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder()
              ),
            ),

            SizedBox(height: 16),

            TextFormField(
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder()
              ),
            ),

            SizedBox(height: 9),
            ElevatedButton(
              onPressed: () {},
              child: Text('Recuperar Senha',
              style: TextStyle(fontWeight: FontWeight.bold
              ),
              ),
            ),

            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MateriasScreen()));
              },
              child: Text("Entrar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white
              ),
            ),
            SizedBox(height: 20),

                      // Botão de autenticação biométrica
                      if (_isBiometricSupported)
                        ElevatedButton.icon(
                          onPressed: _authenticateBiometrics,
                          icon: Icon(Icons.fingerprint),
                          label: Text('Entrar com biometria'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        )
          ],
        ),
      )
    );
  }
}
