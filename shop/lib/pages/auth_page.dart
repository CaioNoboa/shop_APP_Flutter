import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/components/auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 0.5),
                  Color.fromRGBO(255, 188, 117, 0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 25),
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 70,
                      ),
                      transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
            
                      /* '..' é cascade operator.
                        Isso indica que será realizado algo e o resultado disso será usado no segundo método.
                        É utilizado quando há conflito entre métodos.
                        No caso, rotatioZ espera receber Matrix4. Se colocarmos ponto translate, que retorna void, dá problema.
                        Mas ao usarmos o cascade operator, resolvemos a imcompatibilidade.
            
                        Ex.:
                          uma lista a que recebe inteiros, podemos fazer:
                            a.add(1);
                            a.add(2);
                            a.add(3);
            
                            Não podemos fazer:
                            a.add(1).add(2).add(3)
                            Pq add retorna void, daí os outros add não esperam receber void
            
                            Daí podemos fazer
                            a..add(1)..add(2)..add(3)
                      */
            
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        'Minha Loja',
                        style: TextStyle(
                          fontSize: 45,
                          fontFamily: 'Anton',
                          color: Theme.of(context).textTheme.displaySmall?.color,
                        ),
                      ),
                    ),
                    AuthForm(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
