import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:login_page/dashboard/dashboard.dart';
import 'package:login_page/login/login-service.dart';
import 'package:login_page/themes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surface,
      body: Stack(
        children: [
          Container(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              Theme.of(context).brightness == Brightness.light
                  ? 'assets/subtle.png'
                  : 'assets/subtledark.png',
              width: 0.8 * MediaQuery.of(context).size.width,
              // was nog te donker :D
              opacity: const AlwaysStoppedAnimation(.3),
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const CustomLoginHeader(),
                  const LoginContainer(),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(
                      'https://www.emgroup.be - v3.23.40.10',
                      style: TextStyle(color: theme.primary),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomLoginHeader extends StatelessWidget {
  const CustomLoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ColorScheme theme = Theme.of(context).colorScheme;
    return SizedBox(
      height: screenSize.height * 0.22,
      child: Stack(
        children: [
          ClipPath(
            clipper: CustomLoginHeaderClipper(),
            child: Container(color: theme.primary),
          ),
          Center(
              child: Text(('My Time'),
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: Colors.white)))
        ],
      ),
    );
  }
}

class CustomLoginHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double ovalWidth = (size.width / 47.79) * 100;
    final double ovalHeight = size.height * 1.67;
    final double left = ovalWidth * -0.03;
    final double top = ovalHeight * -0.4;
    Path path = Path();
    path.addOval(Rect.fromLTWH(left, top, ovalWidth, ovalHeight));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class LoginContainer extends StatelessWidget {
  const LoginContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        Image.asset(
            Theme.of(context).brightness == Brightness.light
                ? 'assets/logo_highres.png'
                : 'assets/em_dark.png',
            height: 100,
            fit: BoxFit.fitHeight),
        const SizedBox(height: 32),
        const LoginFieldsUI()
      ],
    );
  }
}

class LoginFieldsUI extends StatefulWidget {
  const LoginFieldsUI({super.key});

  @override
  State<LoginFieldsUI> createState() => _LoginFieldsUIState();
}

class _LoginFieldsUIState extends State<LoginFieldsUI> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    void setHidePassword(bool hideData) {
      setState(() {
        hidePassword = hideData;
      });
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginTextField(
                label: 'Gebruikersnaam', controller: usernameController),
            const SizedBox(height: 16),
            LoginTextField(
                label: 'Wachtwoord',
                controller: passwordController,
                isSensitiveData: true,
                hideData: hidePassword,
                toggleHideData: setHidePassword),
            const SizedBox(height: 16),
            LoginButton(
                formKey: _formKey, setHideSensitiveData: setHidePassword),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text('Wachtwoord vergeten?'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginTextField extends StatefulWidget {
  const LoginTextField(
      {required this.label,
      required this.controller,
      super.key,
      this.isSensitiveData = false,
      this.hideData = false,
      this.toggleHideData});

  final String label;
  final TextEditingController controller;
  final bool isSensitiveData;
  final bool hideData;
  final void Function(bool)? toggleHideData;

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    Widget? suffixIcon = widget.isSensitiveData
        ? IconButton(
            icon:
                Icon(widget.hideData ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                widget.toggleHideData!(!widget.hideData);
              });
            },
          )
        : null;

    return TextFormField(
      controller: widget.controller,
      obscureText: widget.hideData && widget.isSensitiveData,
      decoration: InputDecoration(
          labelText: widget.label,
          fillColor: Theme.of(context).colorScheme.background,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          suffixIcon: suffixIcon),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '${widget.label} is verplicht';
        }
        return null;
      },
    );
  }
}

class LoginButton extends StatefulWidget {
  const LoginButton(
      {required this.formKey, required this.setHideSensitiveData, super.key});

  final GlobalKey<FormState> formKey;
  final void Function(bool) setHideSensitiveData;

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  late LoginService loginService;
  bool _isLoading = false;

  void _onButtonPress() async {
    if (_isLoading) {
      return;
    }

    // Simulate a network request
    if (widget.formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      bool loginCredentialsValid =
          await loginService.login('username', 'password');

      if (loginCredentialsValid) {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DashboardPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = Offset(1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.easeInOutCubic;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
          (route) => false, // Remove all previous routes
        );
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loginService = LoginService();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;

    SizedBox spinner = const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 3.0,
      ),
    );

    return TextButton(
      onPressed: _isLoading ? null : _onButtonPress,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(theme.primary),
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      ),
      child: _isLoading
          ? spinner
          : const Text('Inloggen', style: TextStyle(color: Colors.white)),
    );
  }
}
