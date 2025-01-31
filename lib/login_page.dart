import 'package:charity_marathon/registration_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Создание глобального ключа формы для управления состоянием
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // Метод для отправки данных
  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Если форма валидна, сохранить данные
      String email = _emailController.text;
      String password = _passwordController.text;

      // Здесь можно добавить логику для отправки данных (например, на сервер)
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Вход выполнен!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Градиентный фон
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Theme.of(context).primaryColor, Color.fromRGBO(1, 125, 67, 1)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400), // Максимальная ширина карточки
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Form(
                    key: _formKey, // Передаем ключ формы
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Логотип
                        Image.asset('assets/logo.png', height: 120),
                        SizedBox(height: 10),
                        // Название
                        Text(
                          "Charity Marathon 2025",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
                        ),
                        SizedBox(height: 10),
                        // Приветственный текст
                        Text(
                          "Войдите, чтобы продолжить помогать миру!",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(height: 20),
                        // Поле ввода email
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Введите email';
                            }
                            // Проверка формата email
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Введите корректный email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        // Поле ввода пароля
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: "Пароль",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Введите пароль';
                            }
                            if (value.length < 6) {
                              return 'Пароль должен быть не менее 6 символов';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        // Кнопка входа
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700],
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text("Войти", style: TextStyle(fontSize: 16)),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Ссылка для перехода на страницу регистрации
                        TextButton(
                          onPressed: () {
                            // Переход на страницу регистрации
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => RegistrationPage()),
                            );
                          },
                          child: Text(
                            "Нет аккаунта? Зарегистрироваться",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
