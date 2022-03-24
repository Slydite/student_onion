import 'package:flutter/material.dart';
import 'package:resize/resize.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'wifilocal.dart';
import 'package:provider/provider.dart';

class WifiPage extends StatefulWidget {
  const WifiPage({Key? key}) : super(key: key);

  @override
  State<WifiPage> createState() => _WifiPageState();
}

bool _passwordVisible = false;

class _WifiPageState extends State<WifiPage> {
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;

    _controller.addListener(() {
      setState(() {
        if (_controller.value) {
          _checked = true;
        } else {
          _checked = false;
        }
      });
    });
  }

  final _controller = ValueNotifier<bool>(false);
  bool _checked = false;

  bool _isElevated = false;
  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[
        Color.fromARGB(255, 174, 0, 243),
        Color.fromARGB(255, 250, 85, 250)
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
    final Shader linearGradient2 = LinearGradient(
      colors: <Color>[
        Color.fromARGB(255, 231, 134, 231),
        Color.fromARGB(255, 174, 0, 243),
      ],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Consumer<Credentials>(builder: (context, state, child) {
      return Scaffold(
        body: Container(
          alignment: Alignment.topCenter,
          child: SizedBox(
              height: 95.vh,
              width: 95.vw,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text('BITS WiFi Autologin',
                              style: TextStyle(
                                  // color: Colors.white,
                                  foreground: Paint()..shader = linearGradient,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30)),
                        ),
                        const SizedBox(height: 100),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 25.0, horizontal: 10.0),
                              filled: true,
                              fillColor: Color.fromARGB(255, 30, 35, 38),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18))),
                              labelText: 'Username',
                              hintText: 'Enter your Username',
                              hintStyle: TextStyle(color: Colors.white38),
                              labelStyle: TextStyle(
                                  foreground: Paint()..shader = linearGradient2,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          keyboardType: TextInputType.text,
                          //controller: _userPasswordController,
                          obscureText:
                              !_passwordVisible, //This will obscure text dynamically
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 25.0, horizontal: 10.0),
                            filled: true,
                            fillColor: Color.fromARGB(255, 30, 35, 38),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(color: Colors.white38),
                            labelStyle: TextStyle(
                                foreground: Paint()..shader = linearGradient2,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            // Here is key idea
                            suffixIcon: IconButton(
                              icon: ShaderMask(
                                shaderCallback: (bounds) {
                                  return RadialGradient(
                                    center: Alignment.topLeft,
                                    radius: 0.5,
                                    colors: [
                                      Color.fromARGB(255, 174, 0, 243),
                                      Color.fromARGB(255, 231, 134, 231)
                                    ],
                                    tileMode: TileMode.mirror,
                                  ).createShader(bounds);
                                },
                                child: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isElevated = !_isElevated;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 200,
                            ),
                            height: 50,
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _isElevated
                                      ? Text('Delete',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold))
                                      : Text('Save',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 30, 35, 38),
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: !_isElevated
                                  ? [
                                      const BoxShadow(
                                        color: Colors.white,
                                        offset: Offset(4, 4),
                                        blurRadius: 15,
                                        spreadRadius: 0.1,
                                      ),
                                      const BoxShadow(
                                        color: Colors.blue,
                                        offset: Offset(-4, -4),
                                        blurRadius: 15,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            ElevatedButton(
                              // <-- ElevatedButton
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 30, 35, 38),
                              ),
                              child: Text(
                                'Manually Login',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: 60.vw,
                                    child: Text('AutoLogin Service',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  //SizedBox(width: 10),
                                  AdvancedSwitch(
                                    controller: _controller,
                                    activeColor: Colors.blue,
                                    inactiveColor: Colors.grey,
                                    activeChild: Text('ON'),
                                    inactiveChild: Text('OFF'),
                                    borderRadius: BorderRadius.all(
                                        const Radius.circular(15)),
                                    width: 65.0,
                                    height: 30.0,
                                    enabled: true,
                                    disabledOpacity: 0.5,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
      );
    });
  }
}

void _login() {}
//TODO: Add keyboard enter thingy
//TODO: Add Save and clear button
//TODO: Add functionality