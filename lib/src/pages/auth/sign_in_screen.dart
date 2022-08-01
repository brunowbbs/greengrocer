import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/widgets/custom_text_field.dart';
import 'package:greengrocer/src/pages_routes/app_pages.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formaKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Nome do App
                    const Text.rich(
                      TextSpan(
                        style: TextStyle(fontSize: 40),
                        children: [
                          TextSpan(
                            text: "Green",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "grocer",
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Categorias
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(fontSize: 20),
                        child: AnimatedTextKit(
                            repeatForever: true,
                            pause: Duration.zero,
                            animatedTexts: [
                              FadeAnimatedText("Frutas"),
                              FadeAnimatedText("Verduras"),
                              FadeAnimatedText("Legumes"),
                              FadeAnimatedText("Carnes"),
                              FadeAnimatedText("Cereais"),
                              FadeAnimatedText("Laticínios")
                            ]),
                      ),
                    ),
                  ],
                ),
              ),

              //Formulário
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(0),
                  ),
                ),
                child: Form(
                  key: _formaKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Input email
                      CustomTextField(
                        controller: emailController,
                        icon: Icons.email,
                        label: "Email",
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'Digite seu email';
                          }
                          //validação do getX
                          if (!email.isEmail) return "Digite um email válido";

                          return null;
                        },
                      ),

                      //Input senha
                      CustomTextField(
                        controller: passwordController,
                        icon: Icons.lock,
                        label: "Senha",
                        isSecret: true,
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return "Digite sua senha";
                          }
                          if (password.length < 7) {
                            return 'Digite uma senha com pelo menos 7 caracteres';
                          }
                          return null;
                        },
                      ),

                      //Botão entrar
                      SizedBox(
                        height: 50,
                        child: GetX<AuthController>(
                          builder: (_) {
                            return ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                if (_formaKey.currentState!.validate()) {
                                  String email = emailController.text;
                                  String password = passwordController.text;

                                  print(email);
                                  print(password);
                                } else {
                                  print("Campos não válidos");
                                }
                              },
                              child: const Text(
                                "Entrar",
                                style: TextStyle(fontSize: 16),
                              ),
                            );
                          },
                        ),
                      ),

                      //Botão Esqueceu a senha
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Esqueceu a senha?",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),

                      //Divisor
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Text("   ou   "),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            )
                          ],
                        ),
                      ),

                      //Botão de novo usuário
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          /*onPressed: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (c) {
                            return SignUpScreen();
                          })),*/
                          onPressed: () => Get.toNamed(PagesRoutes.signUpRoute),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: const BorderSide(
                              width: 2,
                              color: Colors.greenAccent,
                            ),
                          ),
                          child: const Text(
                            "Criar conta",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
