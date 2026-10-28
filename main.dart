import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'stubs.dart';
class AppLocalizations {
  static const Map<String, Map<String, String>> _localizedStrings = {
    'en': {
      'app_title': 'Farming App',
      'sign_in': 'Sign In',
      'sign_up': 'Sign Up',
      'email': 'Email',
      'password': 'Password',
      'forgot_password': 'Forgot Password?',
      'welcome': 'Welcome to Farming App',
      'tools': 'Tools',
      'calendar': 'Calendar',
      'chatbot': 'Chat',
    },
    'ar': {
      'app_title': 'تطبيق الزراعة',
      'sign_in': 'تسجيل الدخول',
      'sign_up': 'إنشاء حساب',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'forgot_password': 'هل نسيت كلمة المرور؟',
      'welcome': 'أهلا بك في تطبيق الزراعة',
      'tools': 'الأدوات',
      'calendar': 'التقويم',
      'chatbot': 'الدردشة',
    },
  };

  static String translate(String key, String languageCode) {
    return _localizedStrings[languageCode]?[key] ?? key;
  }
}

void main() {
  runApp(const PlantApp());
}

class PlantApp extends StatefulWidget {
  const PlantApp({super.key});

  @override
  State<PlantApp> createState() => _PlantAppState();
}

class _PlantAppState extends State<PlantApp> {
  String _language = 'en';
  bool _isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: SplashScreen(
        onLanguageChange: (lang) => setState(() => _language = lang),
        onThemeChange: (_) => setState(() => _isDarkMode = true),
        currentLanguage: _language,
        isDarkMode: _isDarkMode,
      ),
    );
  }
}

// =====================================================
// SPLASH SCREEN
// =====================================================

class SplashScreen extends StatefulWidget {
  final Function(String) onLanguageChange;
  final Function(bool) onThemeChange;
  final String currentLanguage;
  final bool isDarkMode;

  const SplashScreen({
    super.key,
    required this.onLanguageChange,
    required this.onThemeChange,
    required this.currentLanguage,
    required this.isDarkMode,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);
    _scaleAnimation = Tween<double>(begin: 0.86, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _slideAnimation = Tween<double>(begin: 24, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward().then((_) {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OnboardingScreen(
              onLanguageChange: widget.onLanguageChange,
              onThemeChange: widget.onThemeChange,
              currentLanguage: widget.currentLanguage,
              isDarkMode: widget.isDarkMode,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1536147116438-62679a5e01f2?q=80&w=1000&auto=format&fit=crop'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.45),
                        Colors.black.withValues(alpha: 0.82),
                        const Color(0xFF050806),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -60,
                right: -40,
                child: Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF64DD17).withValues(alpha: 0.12),
                  ),
                ),
              ),
              Positioned(
                bottom: -70,
                left: -50,
                child: Container(
                  width: 210,
                  height: 210,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF00E676).withValues(alpha: 0.10),
                  ),
                ),
              ),
              SafeArea(
                child: Center(
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.35),
                                blurRadius: 24,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF64DD17), Color(0xFF00E676)],
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Icon(Icons.eco_rounded, size: 44, color: Colors.black),
                              ),
                              const SizedBox(height: 18),
                              const Text(
                                'Nabt Farming',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Smart agriculture for every farmer',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.78),
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: 180,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: Colors.white12,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: FractionallySizedBox(
                                    widthFactor: _controller.value,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: const LinearGradient(
                                          colors: [Color(0xFF64DD17), Color(0xFF00E676)],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

}

class AuthScreen extends StatelessWidget {
  final bool isSignUp;
  final Function(String) onLanguageChange;
  final Function(bool) onThemeChange;
  final String currentLanguage;
  final bool isDarkMode;

  const AuthScreen({
    super.key,
    required this.isSignUp,
    required this.onLanguageChange,
    required this.onThemeChange,
    required this.currentLanguage,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1536147116438-62679a5e01f2?q=80&w=1000&auto=format&fit=crop'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.45),
                    Colors.black.withValues(alpha: 0.82),
                    const Color(0xFF050806),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -60,
            right: -40,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF64DD17).withValues(alpha: 0.12),
              ),
            ),
          ),
          Positioned(
            bottom: -70,
            left: -50,
            child: Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00E676).withValues(alpha: 0.10),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.35),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF64DD17), Color(0xFF00E676)],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.eco_rounded, color: Colors.black, size: 22),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Nabt Farming',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        Text(
                          isSignUp ? 'Create Account' : 'Welcome Back',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isSignUp
                              ? 'Start your smart farming journey in minutes.'
                              : 'Sign in to continue managing your farm.',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.78),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 22),
                        _buildLabel('Email Address'),
                        _buildTextField(
                          isPassword: false,
                          hint: 'you@example.com',
                          prefixIcon: Icons.mail_outline_rounded,
                        ),
                        const SizedBox(height: 16),
                        _buildLabel('Password'),
                        _buildTextField(
                          isPassword: true,
                          hint: '••••••••',
                          prefixIcon: Icons.lock_outline_rounded,
                        ),
                        if (isSignUp) ...[
                          const SizedBox(height: 16),
                          _buildLabel('Confirm Password'),
                          _buildTextField(
                            isPassword: true,
                            hint: '••••••••',
                            prefixIcon: Icons.verified_user_outlined,
                          ),
                        ],
                        if (!isSignUp)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                                );
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF64DD17), Color(0xFF00E676)],
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MainNavigation(
                                      onLanguageChange: onLanguageChange,
                                      onThemeChange: onThemeChange,
                                      currentLanguage: currentLanguage,
                                      isDarkMode: isDarkMode,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    isSignUp ? 'Create Account' : 'Sign In',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.arrow_forward_rounded, color: Colors.black, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 22),
                        _buildDivider(),
                        const SizedBox(height: 16),
                        Center(
                          child: Text(
                            isSignUp ? 'Or sign up with' : 'Or sign in with',
                            style: TextStyle(color: Colors.white.withValues(alpha: 0.72), fontSize: 13),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: _socialButton(
                                iconUrl:
                                    'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/1200px-Google_%22G%22_logo.svg.png',
                                label: 'Google',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _socialButton(
                                iconUrl: 'https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_(2019).png',
                                label: 'Facebook',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AuthScreen(
                                    isSignUp: !isSignUp,
                                    onLanguageChange: onLanguageChange,
                                    onThemeChange: onThemeChange,
                                    currentLanguage: currentLanguage,
                                    isDarkMode: isDarkMode,
                                  ),
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                text: isSignUp ? 'Already have an account? ' : 'Don\'t have an account? ',
                                style: TextStyle(color: Colors.white.withValues(alpha: 0.88), fontSize: 14),
                                children: [
                                  TextSpan(
                                    text: isSignUp ? 'Sign In' : 'Sign Up',
                                    style: const TextStyle(
                                      color: Color(0xFF64DD17),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets to keep code clean ---

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.92),
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required bool isPassword,
    required String hint,
    required IconData prefixIcon,
  }) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.50)),
        prefixIcon: Icon(prefixIcon, color: Colors.white70, size: 20),
        suffixIcon: isPassword ? const Icon(Icons.visibility_off_outlined, color: Colors.white60, size: 20) : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        filled: true,
        fillColor: Colors.black.withValues(alpha: 0.35),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.20), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF00E676), width: 2),
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.28))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('Or', style: TextStyle(color: Colors.white.withValues(alpha: 0.70))),
        ),
        Expanded(child: Divider(color: Colors.white.withValues(alpha: 0.28))),
      ],
    );
  }

  Widget _socialButton({required String iconUrl, required String label}) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(iconUrl, width: 18, height: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1536147116438-62679a5e01f2?q=80&w=1000&auto=format&fit=crop'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.48),
                    Colors.black.withValues(alpha: 0.86),
                    const Color(0xFF040805),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -64,
            right: -50,
            child: Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF64DD17).withValues(alpha: 0.11),
              ),
            ),
          ),
          Positioned(
            bottom: -90,
            left: -60,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00E676).withValues(alpha: 0.10),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.36),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.white.withValues(alpha: 0.10),
                                side: BorderSide(color: Colors.white.withValues(alpha: 0.20)),
                              ),
                              icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Forgot Password',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF64DD17), Color(0xFF00E676)],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.lock_reset_rounded, color: Colors.black, size: 34),
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Center(
                          child: Text(
                            'Reset your password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Enter your email and we will send you reset instructions.',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.76),
                              fontSize: 13,
                              height: 1.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Email Address',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.92),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'you@example.com',
                            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.50)),
                            prefixIcon: const Icon(Icons.mail_outline_rounded, color: Colors.white70, size: 20),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                            filled: true,
                            fillColor: Colors.black.withValues(alpha: 0.35),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.20), width: 1.2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(color: Color(0xFF00E676), width: 2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF64DD17), Color(0xFF00E676)],
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Reset link sent (UI only)')),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.transparent,
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Send Reset Link',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.send_rounded, color: Colors.black, size: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Center(
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Back to Sign In',
                              style: TextStyle(
                                color: Color(0xFF64DD17),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  final Function(String) onLanguageChange;
  final Function(bool) onThemeChange;
  final String currentLanguage;
  final bool isDarkMode;

  const OnboardingScreen({
    super.key,
    required this.onLanguageChange,
    required this.onThemeChange,
    required this.currentLanguage,
    required this.isDarkMode,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Data for the three screens
  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Plant life matters\ntoo.",
      "subtitle": "Take a snap of plant you want to discover\nand understand.",
      "viewType": "Magnified view",
      "image": "assets/bg1.jpg", // Replace with your local path
    },
    {
      "title": "Daily care for\nyour plants.",
      "subtitle": "Get detailed information about the plant\nyou see.",
      "viewType": "Detailed View",
      "image": "assets/bg2.jpg", // Replace with your local path
    },
    {
      "title": "Know the season\nyour plants love.",
      "subtitle": "Set up a reminders and keep your plant\nhealthy and strong!",
      "viewType": "Clear View",
      "image": "assets/bg3.jpg", // Replace with your local path
    },
  ];

  void _goToAuth() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AuthScreen(
          isSignUp: true,
          onLanguageChange: widget.onLanguageChange,
          onThemeChange: widget.onThemeChange,
          currentLanguage: widget.currentLanguage,
          isDarkMode: widget.isDarkMode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) => setState(() => _currentPage = page),
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return _buildPageContent(index);
            },
          ),
          Positioned(
            top: 58,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.30),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.eco_rounded,
                    color: const Color(0xFF64DD17).withValues(alpha: 0.95),
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'Nabt',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 52,
            right: 20,
            child: TextButton(
              onPressed: _goToAuth,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black.withValues(alpha: 0.30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.white.withValues(alpha: 0.20)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text('Skip', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ),
          ),
          Positioned(
            bottom: 28,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.42),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_onboardingData.length, (index) => _buildIndicator(index == _currentPage)),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    height: 54,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF64DD17), Color(0xFF00E676)],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage < 2) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 380),
                            curve: Curves.easeOutCubic,
                          );
                      } else {
                          _goToAuth();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentPage == 2 ? 'Get Started' : 'Continue',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_rounded, color: Colors.black, size: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _currentPage == 2 ? 'Ready to begin your farming journey.' : 'Swipe to explore more features.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.78),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
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

  Widget _buildPageContent(int index) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_onboardingData[index]["image"]!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.18),
                Colors.black.withValues(alpha: 0.55),
                Colors.black.withValues(alpha: 0.86),
              ],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 92, 24, 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
                  ),
                  child: Text(
                    _onboardingData[index]["viewType"]!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  _onboardingData[index]["title"]!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 38,
                    fontWeight: FontWeight.w800,
                    height: 1.08,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  _onboardingData[index]["subtitle"]!,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.80),
                    fontSize: 15,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.70), width: 1.2),
                        image: DecorationImage(
                          image: AssetImage(_onboardingData[index]["image"]!),
                          fit: BoxFit.none,
                          scale: 3.1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        index == 0
                            ? 'Capture and identify plant health instantly.'
                            : index == 1
                                ? 'Track care tips and improve growth daily.'
                                : 'Follow seasonal guidance for better yield.',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.78),
                          fontSize: 13,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 6,
      width: isActive ? 30 : 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF64DD17) : Colors.white.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}



class MainNavigation extends StatefulWidget {
  final Function(String) onLanguageChange;
  final Function(bool) onThemeChange;
  final String currentLanguage;
  final bool isDarkMode;

  const MainNavigation({
    super.key,
    required this.onLanguageChange,
    required this.onThemeChange,
    required this.currentLanguage,
    required this.isDarkMode,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(),                                              // Home - Index 0
      MarketPage(isDarkMode: widget.isDarkMode),                    // Market - Index 1
      EducationPage(isDarkMode: widget.isDarkMode),                 // Learning - Index 2
      ToolsPage(currentLanguage: widget.currentLanguage), // Tools - Index 3
      ProfilePage(
        currentLanguage: widget.currentLanguage,
        onLanguageChange: widget.onLanguageChange,
        onThemeChange: widget.onThemeChange,
        isDarkMode: widget.isDarkMode,
      ),        // Profile - Index 4
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      extendBody: true,
      bottomNavigationBar: Container(
        height: 84,
        margin: const EdgeInsets.fromLTRB(18, 0, 18, 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.16),
                    Colors.white.withValues(alpha: 0.07),
                  ],
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedAlign(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    alignment: Alignment(
                      -1.0 + (_currentIndex * (2.0 / 4)),
                      0,
                    ),
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFFC0FF72).withValues(alpha: 0.5),
                            const Color(0xFFFFB39E).withValues(alpha: 0.2),
                            Colors.transparent,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFC0FF72).withValues(alpha: 0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildGlowIcon(Icons.home_outlined, 0),
                      _buildGlowIcon(Icons.shopping_bag_outlined, 1),
                      _buildGlowIcon(Icons.school_outlined, 2),
                      _buildGlowIcon(Icons.build_circle_outlined, 3),
                      _buildGlowIcon(Icons.person_outline, 4),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlowIcon(IconData icon, int index) {
    bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: isActive ? 1.15 : 1.0,
        child: Icon(
          icon,
          color: isActive ? const Color(0xFFC0FF72) : Colors.white.withValues(alpha: 0.5),
          size: 26,
        ),
      ),
    );
  }

}



class MarketPage extends StatefulWidget {
  final bool isDarkMode;

  const MarketPage({super.key, required this.isDarkMode});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  late TextEditingController _searchController;
  String _searchQuery = "";
  String _selectedCategory = "Indoor Plants";

  final List<Map<String, dynamic>> marketCategories = const [
    {"title": "Indoor Plants", "titleAr": "نباتات داخلية", "icon": Icons.chair_outlined},
    {"title": "Fertilizers", "titleAr": "أسمدة", "icon": Icons.grass_outlined},
    {"title": "Pots & Planters", "titleAr": "أصص وأوعية", "icon": Icons.inventory_2_outlined},
    {"title": "Gardening Tools", "titleAr": "أدوات الحديقة", "icon": Icons.handyman_outlined},
    {"title": "Vegetables", "titleAr": "خضروات", "icon": Icons.local_florist_outlined},
    {"title": "Fruits", "titleAr": "فواكه", "icon": Icons.apple_outlined},
    {"title": "Herbs", "titleAr": "أعشاب", "icon": Icons.spa_outlined},
    {"title": "Flowers", "titleAr": "زهور", "icon": Icons.local_florist},
    {"title": "Grains", "titleAr": "حبوب", "icon": Icons.grain_outlined},
  ];

  final List<Map<String, String>> featuredDeals = const [
    {
      "name": "Premium Monstera Adansonii",
      "subtitle": "Starter Kit",
      "price": "4,500 DZD",
      "image": "https://images.unsplash.com/photo-1614594975525-e45190c55d0b?w=1200&q=80"
    },
    {
      "name": "Quality Potting Soil",
      "subtitle": "Organic Mix",
      "price": "1,200 DZD",
      "image": "https://images.unsplash.com/photo-1464226184884-fa280b87c399?w=1200&q=80"
    },
  ];

  final Map<String, List<Map<String, String>>> categoryProducts = const {
    "Indoor Plants": [
      {"name": "Small Cactus", "price": "850 DZD", "image": "https://images.unsplash.com/photo-1459411552884-841db9b3cc2a?w=800&q=80"},
      {"name": "Snake Plant", "price": "1,600 DZD", "image": "https://images.unsplash.com/photo-1485955900006-10f4d324d411?w=800&q=80"},
      {"name": "Peace Lily", "price": "1,900 DZD", "image": "https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?w=800&q=80"},
      {"name": "ZZ Plant", "price": "2,300 DZD", "image": "https://images.unsplash.com/photo-1463320898484-cdee8141c787?w=800&q=80"},
      {"name": "Rubber Plant", "price": "2,150 DZD", "image": "https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?w=800&q=80"},
      {"name": "Pothos", "price": "1,450 DZD", "image": "https://images.unsplash.com/photo-1485955900006-10f4d324d411?w=800&q=80"},
    ],
    "Fertilizers": [
      {"name": "Organic Compost", "price": "1,100 DZD", "image": "https://images.unsplash.com/photo-1464226184884-fa280b87c399?w=800&q=80"},
      {"name": "NPK 20-20-20", "price": "1,450 DZD", "image": "https://images.unsplash.com/photo-1622383563227-04401ab4e5ea?w=800&q=80"},
      {"name": "Seaweed Extract", "price": "1,900 DZD", "image": "https://images.unsplash.com/photo-1534710961216-75c88202f43e?w=800&q=80"},
      {"name": "Vermicompost", "price": "1,250 DZD", "image": "https://images.unsplash.com/photo-1591857177580-dc82b9ac4e1e?w=800&q=80"},
      {"name": "Foliar Booster", "price": "1,700 DZD", "image": "https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=800&q=80"},
      {"name": "Root Stimulator", "price": "2,050 DZD", "image": "https://images.unsplash.com/photo-1471194402529-8e0f5a675de6?w=800&q=80"},
    ],
    "Pots & Planters": [
      {"name": "Ceramic Pot", "price": "1,100 DZD", "image": "https://images.unsplash.com/photo-1485955900006-10f4d324d411?w=800&q=80"},
      {"name": "Hanging Planter", "price": "1,300 DZD", "image": "https://images.unsplash.com/photo-1477554193778-9562c28588c0?w=800&q=80"},
      {"name": "Clay Pot Set", "price": "2,400 DZD", "image": "https://images.unsplash.com/photo-1592150621744-aca64f48394a?w=800&q=80"},
      {"name": "Self-Watering Pot", "price": "2,100 DZD", "image": "https://images.unsplash.com/photo-1463936575829-25148e1db1b8?w=800&q=80"},
      {"name": "Concrete Planter", "price": "1,950 DZD", "image": "https://images.unsplash.com/photo-1459156212016-c812468e2115?w=800&q=80"},
      {"name": "Mini Succulent Pots", "price": "900 DZD", "image": "https://images.unsplash.com/photo-1459411552884-841db9b3cc2a?w=800&q=80"},
    ],
    "Gardening Tools": [
      {"name": "Pruning Scissor", "price": "1,950 DZD", "image": "https://images.unsplash.com/photo-1591123120675-6f7f1aae0e5b?w=800&q=80"},
      {"name": "Garden Trowel", "price": "850 DZD", "image": "https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?w=800&q=80"},
      {"name": "Water Spray Bottle", "price": "600 DZD", "image": "https://images.unsplash.com/photo-1583947582886-f40ec95dd752?w=800&q=80"},
      {"name": "Hand Rake", "price": "780 DZD", "image": "https://images.unsplash.com/photo-1464226184884-fa280b87c399?w=800&q=80"},
      {"name": "Gloves Set", "price": "1,050 DZD", "image": "https://images.unsplash.com/photo-1471194402529-8e0f5a675de6?w=800&q=80"},
      {"name": "Watering Can", "price": "1,400 DZD", "image": "https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=800&q=80"},
    ],
    "Vegetables": [
      {"name": "Tomato Seedling", "price": "450 DZD", "image": "https://images.unsplash.com/photo-1563565375-f3fdfdbefa83?w=800&q=80"},
      {"name": "Cucumber Seedling", "price": "420 DZD", "image": "https://images.unsplash.com/photo-1563565375-f3fdfdbefa83?w=800&q=80"},
      {"name": "Pepper Plant", "price": "500 DZD", "image": "https://images.unsplash.com/photo-1622206151226-18ca2c9ab4a1?w=800&q=80"},
      {"name": "Lettuce Pack", "price": "380 DZD", "image": "https://images.unsplash.com/photo-1622206151226-18ca2c9ab4a1?w=800&q=80"},
      {"name": "Carrot Seeds", "price": "300 DZD", "image": "https://images.unsplash.com/photo-1447175008436-054170c2e979?w=800&q=80"},
      {"name": "Onion Bulbs", "price": "360 DZD", "image": "https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?w=800&q=80"},
    ],
    "Fruits": [
      {"name": "Apple Sapling", "price": "1,950 DZD", "image": "https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?w=800&q=80"},
      {"name": "Orange Sapling", "price": "2,200 DZD", "image": "https://images.unsplash.com/photo-1590502593747-42a996133562?w=800&q=80"},
      {"name": "Lemon Tree", "price": "2,100 DZD", "image": "https://images.unsplash.com/photo-1590502593747-42a996133562?w=800&q=80"},
      {"name": "Strawberry Pack", "price": "780 DZD", "image": "https://images.unsplash.com/photo-1464965911861-746a04b4bca6?w=800&q=80"},
      {"name": "Grape Vine", "price": "1,700 DZD", "image": "https://images.unsplash.com/photo-1537640538966-79f369143f8f?w=800&q=80"},
      {"name": "Pomegranate Sapling", "price": "1,850 DZD", "image": "https://images.unsplash.com/photo-1541344999736-83eca272f6fc?w=800&q=80"},
    ],
    "Herbs": [
      {"name": "Mint Pot", "price": "420 DZD", "image": "https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=800&q=80"},
      {"name": "Basil Pot", "price": "450 DZD", "image": "https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=800&q=80"},
      {"name": "Rosemary", "price": "480 DZD", "image": "https://images.unsplash.com/photo-1474440692490-2e83ae13ba29?w=800&q=80"},
      {"name": "Thyme", "price": "390 DZD", "image": "https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=800&q=80"},
      {"name": "Parsley", "price": "370 DZD", "image": "https://images.unsplash.com/photo-1524593166156-312f362cada0?w=800&q=80"},
      {"name": "Coriander", "price": "360 DZD", "image": "https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=800&q=80"},
    ],
    "Flowers": [
      {"name": "Rose Plant", "price": "900 DZD", "image": "https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?w=800&q=80"},
      {"name": "Jasmine", "price": "850 DZD", "image": "https://images.unsplash.com/photo-1562690868-60bbe7293e94?w=800&q=80"},
      {"name": "Lavender", "price": "980 DZD", "image": "https://images.unsplash.com/photo-1470509037663-253afd7f0f51?w=800&q=80"},
      {"name": "Sunflower", "price": "720 DZD", "image": "https://images.unsplash.com/photo-1470509037663-253afd7f0f51?w=800&q=80"},
      {"name": "Tulip Bundle", "price": "1,150 DZD", "image": "https://images.unsplash.com/photo-1468327768560-75b778cbb551?w=800&q=80"},
      {"name": "Orchid", "price": "1,500 DZD", "image": "https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=800&q=80"},
    ],
    "Grains": [
      {"name": "Wheat Seeds", "price": "640 DZD", "image": "https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&q=80"},
      {"name": "Barley Seeds", "price": "620 DZD", "image": "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800&q=80"},
      {"name": "Corn Seeds", "price": "700 DZD", "image": "https://images.unsplash.com/photo-1551754655-cd27e38d2076?w=800&q=80"},
      {"name": "Oats Pack", "price": "590 DZD", "image": "https://images.unsplash.com/photo-1509440159596-0249088772ff?w=800&q=80"},
      {"name": "Rice Seeds", "price": "680 DZD", "image": "https://images.unsplash.com/photo-1586201375761-83865001e31c?w=800&q=80"},
      {"name": "Sorghum Seeds", "price": "560 DZD", "image": "https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&q=80"},
    ],
  };

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> get _filteredFeaturedDeals {
    if (_searchQuery.isEmpty) return featuredDeals;
    return featuredDeals
        .where((item) =>
            (item['name'] ?? '').toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (item['subtitle'] ?? '').toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  List<Map<String, String>> get _filteredNewArrivals {
    final selected = List<Map<String, String>>.from(
      categoryProducts[_selectedCategory] ?? const <Map<String, String>>[],
    );
    final sharedByUser = NabtMarketStore.sharedProducts
        .where((item) => (item['category'] ?? '') == _selectedCategory)
        .map((item) => Map<String, String>.from(item))
        .toList();
    final merged = <Map<String, String>>[...sharedByUser, ...selected];
    if (_searchQuery.isEmpty) return merged;
    return merged.where((item) {
      final name = (item['name'] ?? '').toLowerCase();
      final category = (item['category'] ?? '').toLowerCase();
      return name.contains(_searchQuery.toLowerCase()) || category.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const Color pageBackground = Color(0xFF0B0F12);
    const Color cardBackground = Color(0xFF171C21);
    const Color primaryText = Colors.white;
    const Color secondaryText = Colors.white70;
    const Color accentGreen = Color(0xFF64DD17);
    const Color cyanAccent = Color(0xFF31D6FF);

    return Container(
      decoration: const BoxDecoration(
        color: pageBackground,
        image: DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1464226184884-fa280b87c399?w=1600&q=80'),
          fit: BoxFit.cover,
          opacity: 0.06,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Plant Market\nمتجر النباتات',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: primaryText, height: 1.15),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Cart',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NabtCartCheckoutPage()),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart_outlined, color: accentGreen, size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                decoration: BoxDecoration(
                  color: cardBackground,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _searchQuery = value),
                  style: const TextStyle(color: primaryText),
                  decoration: InputDecoration(
                    hintText: 'Search for plants, pots, tools...\nابحث عن نباتات، أصص، أدوات...',
                    hintStyle: const TextStyle(color: secondaryText, fontSize: 13),
                    prefixIcon: const Icon(Icons.search_rounded, color: cyanAccent),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: secondaryText),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Market Categories',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryText),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 106,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: marketCategories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final item = marketCategories[index];
                    return Container(
                      width: 144,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cardBackground,
                        borderRadius: BorderRadius.circular(20),
                        gradient: (item['title'] == _selectedCategory)
                            ? LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFF64DD17).withValues(alpha: 0.14),
                                  const Color(0xFF31D6FF).withValues(alpha: 0.14),
                                ],
                              )
                            : null,
                        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          setState(() {
                            _selectedCategory = item['title'] as String;
                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item['icon'] as IconData, color: cyanAccent, size: 22),
                            const SizedBox(height: 6),
                            Text(item['title'] as String, style: const TextStyle(color: primaryText, fontWeight: FontWeight.w600, fontSize: 12)),
                            const SizedBox(height: 2),
                            Text(item['titleAr'] as String, style: const TextStyle(color: secondaryText, fontSize: 10)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Featured Deals',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryText),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 304,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filteredFeaturedDeals.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => _buildFeaturedDealCard(context, _filteredFeaturedDeals[index]),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                '$_selectedCategory Products',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: primaryText),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filteredNewArrivals.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.76,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => _buildNewArrivalCard(context, _filteredNewArrivals[index]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedDealCard(BuildContext context, Map<String, String> deal) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NabtProductDetailsPage(product: _toProductMap(deal))),
        );
      },
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: const Color(0xFF171C21),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: _buildImageFromSource(
                deal['image']!,
                height: 145,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    deal['name']!,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(deal['subtitle']!, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 8),
                  Text(deal['price']!, style: const TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _addMarketItemToCart(deal);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${deal['name']} added to cart'),
                            action: SnackBarAction(
                              label: 'View Cart',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const NabtCartCheckoutPage()),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF64DD17),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        minimumSize: const Size.fromHeight(40),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Add to Cart'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewArrivalCard(BuildContext context, Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NabtProductDetailsPage(product: _toProductMap(item))),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF171C21),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                child: _buildImageFromSource(item['image']!, fit: BoxFit.cover, width: double.infinity),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 4),
                  Text(item['price']!, style: const TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.bold, fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, String> _toProductMap(Map<String, String> item) {
    return {
      'name': item['name'] ?? 'Plant Item',
      'image': item['image'] ?? 'https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?w=900&q=80',
      'category': item['subtitle'] ?? 'Market Item',
      'price': item['price'] ?? '0 DZD',
    };
  }

  Widget _buildImageFromSource(
    String source, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    if (source.startsWith('http')) {
      return Image.network(source, width: width, height: height, fit: fit);
    }
    return Image.file(File(source), width: width, height: height, fit: fit);
  }

  void _addMarketItemToCart(Map<String, String> item) {
    final rawPrice = (item['price'] ?? '0').replaceAll('DZD', '').replaceAll(',', '').trim();
    final parsedPrice = double.tryParse(rawPrice) ?? 0;
    NabtCartStore.addToCart({
      'title': item['name'] ?? 'Plant Item',
      'price': parsedPrice,
      'qty': 1,
      'image': item['image'] ?? 'https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?w=900&q=80',
      'selected': true,
    });
  }
}

// Product detail page (full-screen prototype)
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Full Image Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Image.network(
              'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?q=80&w=800',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Navigation
          Positioned(
            top: 50,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.black54,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // 3. Details Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Premium Aloe", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text("\$25.00", style: TextStyle(fontSize: 24, color: Color(0xFF64DD17), fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text("Vegetables | High Quality", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 25),
                  const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 10),
                  const Text(
                    "This high-quality organic plant is grown locally in Algeria. It requires moderate sunlight and minimal water. Perfect for indoor and outdoor decoration.",
                    style: TextStyle(color: Colors.white70, height: 1.5),
                  ),
                  const Spacer(),

                  // 4. Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A1A1A),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ChatPage()),
                            );
                          },
                          child: const Text("Chat with Vendor", style: TextStyle(color: Color(0xFF64DD17))),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF64DD17), Color(0xFF00E676)],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            ),
                            onPressed: () {},
                            child: const Text("Buy Now", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailScreen extends StatefulWidget {
  final Map<String, String> product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late PageController _pageController;
  int _currentImageIndex = 0;
  int _quantity = 1;
  bool _isWishlisted = false;
  double _zoomScale = 1.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentImageIndex = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<String> _productImages = [
    "https://plus.unsplash.com/premium_photo-1661833100239-de8f260b6f8c?w=800",
    "https://images.unsplash.com/photo-1592921870789-04563e271ab1?w=800&q=80",
    "https://images.unsplash.com/photo-1509207736528-cda5be79d074?w=800&q=80",
    "https://images.unsplash.com/photo-1518531933037-91b2f5f229cc?w=800&q=80",
  ];

  final List<Map<String, String>> _reviews = [
    {"user": "Sarah M.", "rating": "5", "comment": "Amazing product! Arrived in perfect condition.", "date": "2 days ago"},
    {"user": "John D.", "rating": "4", "comment": "Good quality, shipping took longer than expected.", "date": "1 week ago"},
  ];

  final List<Map<String, String>> _relatedProducts = [
    {"name": "Cherry Plant", "price": "\$18.00", "image": "https://images.unsplash.com/photo-1585518419759-66ed635b4545?w=400&q=80"},
    {"name": "Mint Herb", "price": "\$9.00", "image": "https://images.unsplash.com/photo-1599599810694-b5ac4dd37e86?w=400&q=80"},
    {"name": "Basil Leaf", "price": "\$8.00", "image": "https://images.unsplash.com/photo-1580809361436-42a7ec9b3dbb?w=400&q=80"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
            // 1. SWIPEABLE IMAGE GALLERY
          SliverAppBar(
            expandedHeight: 400,
            floating: false,
            pinned: true,
            backgroundColor: Colors.black,
            leading: CircleAvatar(
              backgroundColor: Colors.black87,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            actions: [
              CircleAvatar(
                backgroundColor: Colors.black87,
                child: IconButton(
                  icon: const Icon(Icons.share, color: Color(0xFF64DD17)),
                  onPressed: _shareProduct,
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                backgroundColor: Colors.black87,
                child: IconButton(
                  icon: Icon(
                    _isWishlisted ? Icons.favorite : Icons.favorite_border,
                    color: _isWishlisted ? Colors.red : Color(0xFF64DD17),
                  ),
                  onPressed: () => setState(() => _isWishlisted = !_isWishlisted),
                ),
              ),
              const SizedBox(width: 10),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
                physics: const BouncingScrollPhysics(),
                itemCount: _productImages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onDoubleTap: () {
                      setState(() {
                        _zoomScale = _zoomScale == 1.0 ? 2.0 : 1.0;
                      });
                    },
                    child: Transform.scale(
                      scale: _zoomScale,
                      child: Image.network(
                        _productImages[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Container(color: Colors.grey[800], child: const Icon(Icons.image_not_supported)),
                      ),
                    ),
                  );
                },
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: _buildImageDots(),
            ),
          ),

          // 2. PRODUCT DETAILS
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title & Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product["name"] ?? "Premium Plant",
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildRatingRow(),
                  const SizedBox(height: 15),

                  // Price Section
                  _buildPriceSection(),
                  const SizedBox(height: 20),

                  // Product Description
                  _buildDescriptionSection(),
                  const SizedBox(height: 20),

                  // Quantity Selector
                  _buildQuantitySelector(),
                  const SizedBox(height: 25),

                  // Action Buttons
                  _buildActionButtons(),
                  const SizedBox(height: 30),

                  // Product Specifications
                  _buildSpecificationsTable(),
                  const SizedBox(height: 30),

                  // Seller Information
                  _buildSellerInfo(),
                  const SizedBox(height: 30),

                  // Shipping Information
                  _buildShippingInfo(),
                  const SizedBox(height: 30),

                  // Return Policy
                  _buildReturnPolicy(),
                  const SizedBox(height: 30),

                  // Customer Reviews
                  _buildReviewsSection(),
                  const SizedBox(height: 30),

                  // Related Products
                  _buildRelatedProducts(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageDots() {
    return Container(
      color: Colors.black.withValues(alpha: 0.7),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_productImages.length, (index) {
          return Container(
            width: _currentImageIndex == index ? 12 : 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: _currentImageIndex == index ? Color(0xFF64DD17) : Colors.grey,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildRatingRow() {
    return Row(
      children: [
        Row(
          children: List.generate(5, (index) => Icon(Icons.star, color: Color(0xFF64DD17), size: 16)),
        ),
        const SizedBox(width: 10),
        const Text("4.8 (234 reviews)", style: TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _buildPriceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("\$25.00", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF64DD17))),
            const SizedBox(width: 15),
            Text("\$35.00", style: TextStyle(fontSize: 18, decoration: TextDecoration.lineThrough, color: Colors.grey)),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
              child: const Text("29% OFF", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 10),
        const Text(
          "Premium organic plant grown locally with exceptional care. Perfect for indoor and outdoor decoration. Requires moderate sunlight and minimal watering.",
          style: TextStyle(color: Colors.white70, height: 1.6),
        ),
        const SizedBox(height: 15),
        const Text("Key Features:", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 8),
        _buildFeatureItem("🌱 Organic & pesticide-free"),
        _buildFeatureItem("💧 Low maintenance watering"),
        _buildFeatureItem("☀️ Moderate sunlight needs"),
        _buildFeatureItem("🏡 Perfect for homes and offices"),
      ],
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: const TextStyle(color: Colors.white70)),
    );
  }

  Widget _buildQuantitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Quantity", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: Color(0xFF64DD17)),
                onPressed: () => setState(() {
                  if (_quantity > 1) _quantity--;
                }),
              ),
              Text(_quantity.toString(), style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.add, color: Color(0xFF64DD17)),
                onPressed: () => setState(() => _quantity++),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1A1A1A),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  side: const BorderSide(color: Color(0xFF64DD17), width: 2),
                ),
                onPressed: _addToCart,
                icon: const Icon(Icons.shopping_cart, color: Color(0xFF64DD17)),
                label: const Text("Add to Cart", style: TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF64DD17),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _buyNow,
                icon: const Icon(Icons.flash_on, color: Colors.black),
                label: const Text("Buy Now", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey, width: 1),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _reportProduct,
                icon: const Icon(Icons.flag, color: Colors.grey),
                label: const Text("Report", style: TextStyle(color: Colors.grey)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey, width: 1),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: _chatWithSeller,
                icon: const Icon(Icons.chat, color: Colors.grey),
                label: const Text("Chat", style: TextStyle(color: Colors.grey)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSpecificationsTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Specifications", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 15),
        _buildSpecRow("Weight", "500g"),
        _buildSpecRow("Dimensions", "25cm x 20cm x 30cm"),
        _buildSpecRow("Material", "Natural Soil & Pot"),
        _buildSpecRow("Origin Country", "Algeria"),
        _buildSpecRow("Production Date", "March 2024"),
      ],
    );
  }

  Widget _buildSpecRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSellerInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Seller Information", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFF64DD17),
                child: const Text("GG", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Green Garden Store", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Row(children: List.generate(5, (i) => Icon(Icons.star, color: Color(0xFF64DD17), size: 14))),
                        const SizedBox(width: 8),
                        const Text("4.9 (1,234 products)", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF64DD17)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SellerProfilePage()),
                    );
                  },
                  child: const Text("Visit Store", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShippingInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Shipping Information", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 12),
          _buildInfoRow("🚚 Shipping Cost", "\$2.50"),
          _buildInfoRow("⏱️ Estimated Delivery", "3-5 business days"),
          _buildInfoRow("🌍 Delivery Locations", "Across Algeria"),
        ],
      ),
    );
  }

  Widget _buildReturnPolicy() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Return Policy", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 12),
          _buildInfoRow("📅 Return Period", "30 days"),
          _buildInfoRow("💰 Refund Conditions", "Full refund if unopened"),
          _buildInfoRow("📦 Return Shipping", "Free returns"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Customer Reviews", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            TextButton(
              onPressed: () {},
              child: const Text("See all", style: TextStyle(color: Color(0xFF64DD17))),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ..._reviews.map((review) => _buildReviewItem(review)),
      ],
    );
  }

  Widget _buildReviewItem(Map<String, String> review) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(review["user"]!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              Text(review["date"]!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: List.generate(int.parse(review["rating"]!), (i) => Icon(Icons.star, color: Color(0xFF64DD17), size: 14)),
          ),
          const SizedBox(height: 8),
          Text(review["comment"]!, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildRelatedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Related Products", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 15),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _relatedProducts.length,
            itemBuilder: (context, index) {
              final product = _relatedProducts[index];
              return Container(
                width: 140,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(color: Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(product["image"]!, height: 100, fit: BoxFit.cover, width: double.infinity),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product["name"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
                          const SizedBox(height: 4),
                          Text(product["price"]!, style: const TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _addToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NabtCartCheckoutPage(
          initialItems: [
            {
              'title': widget.product['name'] ?? 'Premium Olive Seedling - شتلة زيتون ممتازة',
              'price': 3900.0,
              'qty': _quantity,
              'image': widget.product['image'] ??
                  'https://images.unsplash.com/photo-1457530378978-8bac673b8062?w=800&q=80',
            }
          ],
        ),
      ),
    );
  }

  void _buyNow() {
    _addToCart();
  }

  void _shareProduct() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Product shared successfully! 📤"),
        backgroundColor: Color(0xFF64DD17),
      ),
    );
  }

  void _reportProduct() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Report Product", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 15),
            ListTile(
              title: const Text("Inappropriate content", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Report submitted. Thank you! ✓")),
                );
              },
            ),
            ListTile(
              title: const Text("Fake product", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Report submitted. Thank you! ✓")),
                );
              },
            ),
            ListTile(
              title: const Text("Counterfeit item", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Report submitted. Thank you! ✓")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _chatWithSeller() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ChatPage()),
    );
  }
}


class EducationPage extends StatefulWidget {
  final bool isDarkMode;

  const EducationPage({super.key, required this.isDarkMode});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  late TextEditingController _searchController;
  String _searchQuery = '';

  final List<Map<String, dynamic>> learningCategories = const [
    {
      "label": "Indoor Plants",
      "labelAr": "النباتات الداخلية",
      "icon": Icons.chair_outlined,
      "heroImage": "https://images.unsplash.com/photo-1485955900006-10f4d324d411?w=1200&q=80",
      "highlightCourse": "Indoor Plants Starter Plan",
      "highlightCourseAr": "خطة بداية للنباتات الداخلية",
      "progress": 0.58,
      "lessons": [
        {"title": "Choosing the right pot", "duration": "8 min", "level": "Beginner"},
        {"title": "Humidity and airflow", "duration": "10 min", "level": "Beginner"},
        {"title": "Seasonal repotting guide", "duration": "12 min", "level": "Intermediate"},
      ],
      "tips": [
        "Rotate pots weekly for balanced growth",
        "Keep leaves clean to improve photosynthesis",
        "Avoid overwatering in winter",
      ],
      "articles": [
        {"title": "Best Plants for Low Light", "image": "https://images.unsplash.com/photo-1497250681960-ef046c08a56e?w=900&q=80"},
        {"title": "Why Indoor Leaves Turn Yellow", "image": "https://images.unsplash.com/photo-1512428813834-c702c7702b78?w=900&q=80"},
      ]
    },
    {
      "label": "Diseases",
      "labelAr": "الأمراض",
      "icon": Icons.healing_outlined,
      "heroImage": "https://images.unsplash.com/photo-1625246333195-78d9c38ad449?w=1200&q=80",
      "highlightCourse": "Fast Disease Detection Basics",
      "highlightCourseAr": "أساسيات الكشف السريع عن الأمراض",
      "progress": 0.71,
      "lessons": [
        {"title": "Spotting leaf rust early", "duration": "9 min", "level": "Beginner"},
        {"title": "Fungal vs bacterial signs", "duration": "11 min", "level": "Intermediate"},
        {"title": "When to isolate infected plants", "duration": "7 min", "level": "Beginner"},
      ],
      "tips": [
        "Inspect leaf undersides twice per week",
        "Use clean tools between plants",
        "Treat early to reduce crop loss",
      ],
      "articles": [
        {"title": "How to Stop Leaf Rust Quickly", "image": "https://images.unsplash.com/photo-1534710961216-75c88202f43e?w=900&q=80"},
        {"title": "Organic Disease Control Methods", "image": "https://images.unsplash.com/photo-1586771107445-d3ca888129ff?w=900&q=80"},
      ]
    },
    {
      "label": "Plant Types",
      "labelAr": "أنواع النباتات",
      "icon": Icons.eco_outlined,
      "heroImage": "https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?w=1200&q=80",
      "highlightCourse": "Know Your Plant Families",
      "highlightCourseAr": "تعرّف على عائلات النباتات",
      "progress": 0.42,
      "lessons": [
        {"title": "Annuals vs perennials", "duration": "6 min", "level": "Beginner"},
        {"title": "Herbs, shrubs, and trees", "duration": "10 min", "level": "Beginner"},
        {"title": "Crop selection by climate", "duration": "13 min", "level": "Intermediate"},
      ],
      "tips": [
        "Start with varieties adapted to your region",
        "Group plants by water needs",
        "Track seasonal performance in notes",
      ],
      "articles": [
        {"title": "Top Drought-Resistant Crops", "image": "https://images.unsplash.com/photo-1471194402529-8e0f5a675de6?w=900&q=80"},
        {"title": "Understanding Root Systems", "image": "https://images.unsplash.com/photo-1464226184884-fa280b87c399?w=900&q=80"},
      ]
    },
    {
      "label": "Watering Basics",
      "labelAr": "أساسيات السقي",
      "icon": Icons.water_drop_outlined,
      "heroImage": "https://images.unsplash.com/photo-1563514227147-6d2ff665a6a0?w=1200&q=80",
      "highlightCourse": "Smart Irrigation Fundamentals",
      "highlightCourseAr": "أساسيات الري الذكي",
      "progress": 0.64,
      "lessons": [
        {"title": "When to water by soil touch", "duration": "7 min", "level": "Beginner"},
        {"title": "Drip irrigation efficiency", "duration": "10 min", "level": "Intermediate"},
        {"title": "Avoiding root rot", "duration": "8 min", "level": "Beginner"},
      ],
      "tips": [
        "Water early morning for better absorption",
        "Adjust frequency by temperature",
        "Mulch helps retain soil moisture",
      ],
      "articles": [
        {"title": "How Much Water Does Your Crop Need?", "image": "https://images.unsplash.com/photo-1591857177580-dc82b9ac4e1e?w=900&q=80"},
        {"title": "Irrigation Mistakes to Avoid", "image": "https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=900&q=80"},
      ]
    },
  ];

  final List<Map<String, String>> latestArticles = const [
    {
      "title": "How to Save a Dying Plant?",
      "titleAr": "كيف تنقذ نبتة تحتضر؟",
      "image": "https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?w=900&q=80"
    },
    {
      "title": "Best Plants for Low Light",
      "titleAr": "أفضل النباتات للإضاءة المنخفضة",
      "image": "https://images.unsplash.com/photo-1485955900006-10f4d324d411?w=900&q=80"
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredCategories {
    if (_searchQuery.isEmpty) return learningCategories;
    return learningCategories.where((category) {
      final label = (category['label'] as String).toLowerCase();
      final labelAr = (category['labelAr'] as String).toLowerCase();
      final course = (category['highlightCourse'] as String).toLowerCase();
      return label.contains(_searchQuery) || labelAr.contains(_searchQuery) || course.contains(_searchQuery);
    }).toList();
  }

  List<Map<String, String>> get _filteredArticles {
    if (_searchQuery.isEmpty) return latestArticles;
    return latestArticles.where((article) {
      final title = (article['title'] ?? '').toLowerCase();
      final titleAr = (article['titleAr'] ?? '').toLowerCase();
      return title.contains(_searchQuery) || titleAr.contains(_searchQuery);
    }).toList();
  }

  void _openCategory(BuildContext context, Map<String, dynamic> category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LearningCategoryDetailPage(category: category),
      ),
    );
  }

  void _openArticle(BuildContext context, Map<String, String> article) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ArticleDetailPage(article: article)),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color bg = Color(0xFF0B0F12);
    const Color card = Color(0xFF171C21);
    const Color accent = Color(0xFF64DD17);
    const Color cyanAccent = Color(0xFF31D6FF);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bg,
        title: const Text(
          'Plant Education',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.trim().toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search for plant info or lessons...',
                  hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.45)),
                  prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF31D6FF)),
                  suffixIcon: _searchQuery.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                          icon: const Icon(Icons.close_rounded, color: Colors.white54),
                        ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 22),
            if (_searchQuery.isNotEmpty) ...[
              const Text(
                'Search Results',
                style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              if (_filteredCategories.isEmpty && _filteredArticles.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: card,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                  ),
                  child: const Text(
                    'No matching categories or articles found.',
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              else ...[
                ..._filteredCategories.map((category) => _buildSearchResultTile(
                      title: category['label'] as String,
                      subtitle: category['labelAr'] as String,
                      icon: category['icon'] as IconData,
                      color: const Color(0xFF64DD17),
                      onTap: () => _openCategory(context, category),
                    )),
                ..._filteredArticles.map((article) => _buildSearchResultTile(
                      title: article['title']!,
                      subtitle: article['titleAr'] ?? 'Article',
                      icon: Icons.article_outlined,
                      color: const Color(0xFF31D6FF),
                      onTap: () => _openArticle(context, article),
                    )),
              ],
              const SizedBox(height: 16),
            ],
            const Text(
              'Learning Categories',
              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 98,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filteredCategories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final item = _filteredCategories[index];
                  return _buildCategoryChip(
                    context: context,
                    icon: item['icon'] as IconData,
                    title: item['label'] as String,
                    subtitle: item['labelAr'] as String,
                    onTap: () {
                      _openCategory(context, item);
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Featured Courses',
              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: accent.withValues(alpha: 0.28)),
                boxShadow: [
                  BoxShadow(
                    color: cyanAccent.withValues(alpha: 0.12),
                    blurRadius: 18,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1592150621744-aca64f48394a?w=1200&q=80',
                      height: 190,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Course: Beginners Guide to Plant Care',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'الدورة: دليل المبتدئين للعناية بالنباتات',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: 0.62,
                            minHeight: 8,
                            backgroundColor: Colors.white.withValues(alpha: 0.12),
                            valueColor: const AlwaysStoppedAnimation<Color>(accent),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('62% completed', style: TextStyle(color: Color(0xFF31D6FF), fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Latest Articles',
              style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ..._filteredArticles.map((article) => _buildLatestArticleCard(context, article)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 138,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF64DD17).withValues(alpha: 0.14),
              const Color(0xFF31D6FF).withValues(alpha: 0.14),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: const Color(0xFF31D6FF), size: 22),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
            const SizedBox(height: 2),
            Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestArticleCard(BuildContext context, Map<String, String> article) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArticleDetailPage(article: article)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF171C21),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(20)),
              child: Image.network(
                article['image']!,
                width: 112,
                height: 92,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article['title']!,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      article['titleAr']!,
                      style: const TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF64DD17), size: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF171C21),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.2),
          child: Icon(icon, color: color, size: 18),
        ),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 12)),
        trailing: const Icon(Icons.open_in_new_rounded, color: Colors.white54, size: 18),
      ),
    );
  }
}

class LearningCategoryDetailPage extends StatelessWidget {
  final Map<String, dynamic> category;
  const LearningCategoryDetailPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final String title = category['label'] as String;
    final String titleAr = category['labelAr'] as String;
    final String heroImage = category['heroImage'] as String;
    final String highlightCourse = category['highlightCourse'] as String;
    final String highlightCourseAr = category['highlightCourseAr'] as String;
    final double progress = (category['progress'] as num).toDouble();
    final List<Map<String, String>> lessons = (category['lessons'] as List<dynamic>)
        .map((e) => Map<String, String>.from(e as Map))
        .toList();
    final List<String> tips = List<String>.from(category['tips'] as List<dynamic>);
    final List<Map<String, String>> articles = (category['articles'] as List<dynamic>)
        .map((e) => Map<String, String>.from(e as Map))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0F12),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Image.network(
                    heroImage,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black.withValues(alpha: 0.65), Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Text(titleAr, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _learningSectionCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Featured Course', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(highlightCourse, style: const TextStyle(color: Color(0xFF31D6FF), fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(highlightCourseAr, style: const TextStyle(color: Colors.white60, fontSize: 12)),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 9,
                      backgroundColor: Colors.white.withValues(alpha: 0.12),
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF64DD17)),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('${(progress * 100).toStringAsFixed(0)}% completed', style: const TextStyle(color: Color(0xFF64DD17), fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Text('Top Lessons', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...lessons.map(_buildLessonTile),
            const SizedBox(height: 12),
            const Text('Quick Tips', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tips
                  .map(
                    (tip) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF171C21),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                      ),
                      child: Text(tip, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            const Text('Related Articles', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...articles.map((article) => _buildArticleTile(context, article)),
          ],
        ),
      ),
    );
  }

  Widget _learningSectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF171C21),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: child,
    );
  }

  Widget _buildLessonTile(Map<String, String> lesson) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF171C21),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0x2231D6FF),
          child: Icon(Icons.play_arrow_rounded, color: Color(0xFF31D6FF)),
        ),
        title: Text(lesson['title']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text('${lesson['duration']} • ${lesson['level']}', style: const TextStyle(color: Colors.white60, fontSize: 12)),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF64DD17), size: 14),
      ),
    );
  }

  Widget _buildArticleTile(BuildContext context, Map<String, String> article) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArticleDetailPage(article: article)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF171C21),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
              child: Image.network(article['image']!, width: 92, height: 76, fit: BoxFit.cover),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(article['title']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.open_in_new_rounded, color: Color(0xFF31D6FF), size: 18),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _searchController;
  String _searchQuery = "";
  final List<Map<String, dynamic>> _homeStories = [
    {'name': 'Your Story', 'image': 'https://picsum.photos/seed/my-story/200/200', 'seen': false, 'isMine': true, 'isCreate': true},
    {'name': 'Nora', 'image': 'https://picsum.photos/seed/story-nora/200/200', 'seen': false, 'isMine': false},
    {'name': 'Samir', 'image': 'https://picsum.photos/seed/story-samir/200/200', 'seen': false, 'isMine': false},
    {'name': 'Yasmine', 'image': 'https://picsum.photos/seed/story-yasmine/200/200', 'seen': false, 'isMine': false},
    {'name': 'Ahmed', 'image': 'https://picsum.photos/seed/story-ahmed/200/200', 'seen': false, 'isMine': false},
    {'name': 'Farm Lab', 'image': 'https://picsum.photos/seed/story-farmlab/200/200', 'seen': false, 'isMine': false},
  ];

  final List<Map<String, dynamic>> _homeFeedPosts = [
    {
      'farmer': 'Nora from Blida',
      'location': 'Blida, Algeria',
      'caption': 'Fresh basil harvest today 🌿 quality is perfect for market buyers.',
      'image': 'https://images.unsplash.com/photo-1464226184884-fa280b87c399?w=1200&q=80',
      'likes': 1248,
      'comments': 89,
      'liked': false,
      'saved': false,
      'commentList': <String>['Great harvest 👏', 'Looks fresh!'],
      'product': 'Organic Basil Bundle',
      'price': '850 DZD',
    },
    {
      'farmer': 'Samir from Oran',
      'location': 'Oran, Algeria',
      'caption': 'Irrigation check done ✅ tomato lines are healthy and growing fast.',
      'image': 'https://images.unsplash.com/photo-1471193945509-9ad0617afabf?w=1200&q=80',
      'likes': 932,
      'comments': 54,
      'liked': false,
      'saved': false,
      'commentList': <String>['Amazing update'],
      'product': '',
      'price': '',
    },
    {
      'farmer': 'Yasmine from Setif',
      'location': 'Setif, Algeria',
      'caption': 'Monstera cuttings ready for sale 🌱 DM for details.',
      'image': 'https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?w=1200&q=80',
      'likes': 2041,
      'comments': 146,
      'liked': false,
      'saved': false,
      'commentList': <String>['I need 2 cuttings please'],
      'product': 'Monstera Cutting',
      'price': '2,300 DZD',
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      // Handle the picked image
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image selected: ${image.name}"), backgroundColor: const Color(0xFF64DD17)),
      );
    }
  }

  Future<void> _captureImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      // Handle the captured image
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Photo captured: ${image.name}"), backgroundColor: const Color(0xFF64DD17)),
      );
    }
  }

  List<Map<String, dynamic>> get allSearchItems {
    return [
      {"type": "tool", "name": "Plant ID", "icon": Icons.qr_code_scanner, "label": "Plant ID"},
      {"type": "tool", "name": "Disease ID", "icon": Icons.healing, "label": "Disease ID"},
      {"type": "tool", "name": "Water Counter", "icon": Icons.water_drop_outlined, "label": "Water Counter"},
      {"type": "tool", "name": "Toxicity", "icon": Icons.warning_amber_outlined, "label": "Toxicity"},
      {"type": "category", "name": "Vegetables", "img": "https://images.unsplash.com/photo-1597362860722-39e72f76b74e?q=80&w=200"},
      {"type": "category", "name": "Fruits", "img": "https://images.unsplash.com/photo-1610832958506-aa56368176cf?q=80&w=200"},
      {"type": "category", "name": "Herbs", "img": "https://images.unsplash.com/photo-1509223197845-458d87318791?q=80&w=200"},
      {"type": "category", "name": "Flowers", "img": "https://images.unsplash.com/photo-1490750967868-88aa4486c946?q=80&w=200"},
      {"type": "disease", "name": "Rust Fungi Guide", "desc": "How to protect your field crops."},
      {"type": "disease", "name": "Leaf Spot Disease", "desc": "Identify and treat leaf spots early."},
    ];
  }

  List<Map<String, dynamic>> get filteredItems {
    if (_searchQuery.isEmpty) return [];
    return allSearchItems.where((item) =>
      item['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
      (item.containsKey('desc') && item['desc'].toLowerCase().contains(_searchQuery.toLowerCase()))
    ).toList();
  }

  List<String> get searchSuggestions {
    final Set<String> suggestions = {};
    for (final item in allSearchItems) {
      if (item['name'].toLowerCase().startsWith(_searchQuery.toLowerCase())) {
        suggestions.add(item['name']);
      }
    }
    return suggestions.toList();
  }

  void _handleSearchSelection(Map<String, dynamic> item) {
    if (item['type'] == 'tool' && item['name'] == 'Disease ID') {
      _openDiseaseDiagnosisPicker();
    } else if (item['type'] == 'category') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryProductsPage(categoryName: item['name']),
        ),
      );
    } else if (item['type'] == 'disease') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DiseasesPage()),
      );
    }
  }

  String _formatHomeCount(int value) {
    if (value >= 1000) {
      final k = value / 1000;
      return k >= 10 ? '${k.toStringAsFixed(0)}k' : '${k.toStringAsFixed(1)}k';
    }
    return '$value';
  }

  Widget _buildHomeImageFromSource(String source, {BoxFit fit = BoxFit.cover}) {
    if (source.startsWith('http')) {
      return Image.network(source, fit: fit);
    }
    return Image.file(File(source), fit: fit);
  }

  Future<void> _addHomeStory() async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: const Color(0xFF12181D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined, color: Color(0xFF2DE091)),
                title: const Text('Take Photo', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pop(context, ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined, color: Color(0xFF2DE091)),
                title: const Text('Choose from Gallery', style: TextStyle(color: Colors.white)),
                onTap: () => Navigator.pop(context, ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );

    if (source == null) return;
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source, imageQuality: 90);
    if (picked == null || !mounted) return;

    setState(() {
      final existingMyStoryIndex = _homeStories.indexWhere((s) => (s['ownedByMe'] as bool?) ?? false);
      final newStory = {
        'name': 'You',
        'image': picked.path,
        'seen': false,
        'isMine': false,
        'ownedByMe': true,
        'isCreate': false,
      };

      if (existingMyStoryIndex >= 0) {
        _homeStories[existingMyStoryIndex] = newStory;
      } else {
        _homeStories.insert(1, newStory);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Story added successfully')));
  }

  Future<void> _openHomeStoryViewer(int initialIndex) async {
    if (initialIndex < 0 || initialIndex >= _homeStories.length) {
      return;
    }

    final selectedStory = _homeStories[initialIndex];
    final isCreate = (selectedStory['isCreate'] as bool?) ?? false;
    if (isCreate) {
      return;
    }

    final filteredStories = _homeStories.where((s) => !((s['isCreate'] as bool?) ?? false)).toList();
    final storyItems = filteredStories
        .map((story) => {
              'title': (story['name'] ?? 'Story').toString(),
              'image': (story['image'] ?? '').toString(),
            })
        .toList();

    final filteredIndex = filteredStories.indexWhere((story) => story['image'] == selectedStory['image'] && story['name'] == selectedStory['name']);
    final startIndex = filteredIndex < 0 ? 0 : filteredIndex;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NabtStoryViewerPage(stories: storyItems, initialIndex: startIndex),
      ),
    );

    if (!mounted) return;
    setState(() {
      if (initialIndex >= 0 && initialIndex < _homeStories.length) {
        _homeStories[initialIndex]['seen'] = true;
      }
    });
  }

  void _toggleHomeLike(int index) {
    setState(() {
      final post = _homeFeedPosts[index];
      final liked = post['liked'] as bool;
      post['liked'] = !liked;
      post['likes'] = (post['likes'] as int) + (liked ? -1 : 1);
    });
  }

  void _toggleHomeSave(int index) {
    setState(() {
      final post = _homeFeedPosts[index];
      post['saved'] = !(post['saved'] as bool);
    });
  }

  void _shareHomePost(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Post from ${_homeFeedPosts[index]['farmer']} shared')),
    );
  }

  void _openHomeFarmerProfile(Map<String, dynamic> post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FarmerProfilePage(
          farmerData: {
            'name': post['farmer'],
            'farmName': post['farmer'],
            'location': post['location'],
            'image': post['image'],
            'followers': '2.4k',
            'farmSize': '14 hectares',
            'crops': 'Vegetables, Herbs',
            'products': [
              {
                'name': (post['product'] ?? 'Farm Product').toString().isEmpty ? 'Farm Product' : post['product'],
                'image': post['image'],
                'price': (post['price'] ?? '1200 DZD').toString().isEmpty ? '1200 DZD' : post['price'],
              }
            ],
          },
        ),
      ),
    );
  }

  void _openHomeCommentsSheet(int index) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF12181D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final comments = _homeFeedPosts[index]['commentList'] as List<String>;
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 14,
                bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Comments', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text('• ${comments[i]}', style: const TextStyle(color: Colors.white70)),
                      ),
                    ),
                  ),
                  TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF151D23),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final text = controller.text.trim();
                        if (text.isEmpty) return;
                        setState(() {
                          (_homeFeedPosts[index]['commentList'] as List<String>).insert(0, text);
                          _homeFeedPosts[index]['comments'] = (_homeFeedPosts[index]['comments'] as int) + 1;
                        });
                        setModalState(() {});
                        controller.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2DE091),
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Add Comment'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _buyHomePostProduct(Map<String, dynamic> post) {
    final rawPrice = (post['price'] ?? '').toString();
    final price = double.tryParse(rawPrice.replaceAll('DZD', '').replaceAll(',', '').trim()) ?? 0;
    final title = (post['product'] ?? '').toString();
    if (title.isEmpty) {
      return;
    }

    NabtCartStore.addToCart({
      'title': title,
      'price': price,
      'qty': 1,
      'selected': true,
      'image': (post['image'] ?? '').toString(),
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NabtCartCheckoutPage()),
    );
  }

  void _openHomePostProductDetails(Map<String, dynamic> post) {
    final title = (post['product'] ?? '').toString();
    if (title.isEmpty) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NabtProductDetailsPage(
          product: {
            'name': title,
            'image': (post['image'] ?? '').toString(),
            'price': (post['price'] ?? '').toString(),
            'category': 'Farm Product',
          },
          sellerData: {
            'name': post['farmer'],
            'farmName': post['farmer'],
            'location': post['location'],
            'image': post['image'],
          },
        ),
      ),
    );
  }

  Future<void> _openDiseaseDiagnosisPicker() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF12181D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Disease Diagnosis',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 14),
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined, color: Color(0xFF2DE091)),
                  title: const Text('Take Photo', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('Open camera and scan leaf disease', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  onTap: () async {
                    Navigator.pop(context);
                    final picker = ImagePicker();
                    try {
                      final photo = await picker.pickImage(source: ImageSource.camera, imageQuality: 90);
                      if (photo != null && mounted) {
                        Navigator.push(
                          this.context,
                          MaterialPageRoute(
                            builder: (context) => NabtAIDiagnosticPage(imagePath: photo.path),
                          ),
                        );
                      }
                    } catch (_) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        const SnackBar(content: Text('Camera access is required for diagnosis')),
                      );
                    }
                  },
                ),
                const Divider(color: Colors.white24),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined, color: Color(0xFF2DE091)),
                  title: const Text('Choose from Gallery', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('Select a plant image to scan', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  onTap: () async {
                    Navigator.pop(context);
                    final picker = ImagePicker();
                    final image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 90);
                    if (image != null && mounted) {
                      Navigator.push(
                        this.context,
                        MaterialPageRoute(
                          builder: (context) => NabtAIDiagnosticPage(imagePath: image.path),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openAICameraTypePicker() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF12181D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AI Camera Scan',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(Icons.qr_code_scanner, color: Color(0xFF2DE091)),
                  title: const Text('Plant ID', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('Identify plant type and full details', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  onTap: () {
                    Navigator.pop(context);
                    _openAICameraSourcePicker('plant');
                  },
                ),
                const Divider(color: Colors.white24),
                ListTile(
                  leading: const Icon(Icons.warning_amber_outlined, color: Color(0xFFFFB74D)),
                  title: const Text('Toxicity ID', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('Check if plant is safe to eat + toxicity %', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  onTap: () {
                    Navigator.pop(context);
                    _openAICameraSourcePicker('toxicity');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openAICameraSourcePicker(String scanType) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF12181D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  scanType == 'plant' ? 'Plant ID - Choose Method' : 'Toxicity ID - Choose Method',
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined, color: Color(0xFF2DE091)),
                  title: const Text('Take Photo', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('Open camera and scan now', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  onTap: () async {
                    Navigator.pop(context);
                    final picker = ImagePicker();
                    try {
                      final photo = await picker.pickImage(source: ImageSource.camera, imageQuality: 90);
                      if (photo != null && mounted) {
                        Navigator.push(
                          this.context,
                          MaterialPageRoute(
                            builder: (context) => NabtAICameraScanResultPage(
                              scanType: scanType,
                              imagePath: photo.path,
                            ),
                          ),
                        );
                      }
                    } catch (_) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        const SnackBar(content: Text('Camera permission is required')),
                      );
                    }
                  },
                ),
                const Divider(color: Colors.white24),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined, color: Color(0xFF2DE091)),
                  title: const Text('Choose from Gallery', style: TextStyle(color: Colors.white)),
                  subtitle: const Text('Pick an image to analyze', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  onTap: () async {
                    Navigator.pop(context);
                    final picker = ImagePicker();
                    final image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 90);
                    if (image != null && mounted) {
                      Navigator.push(
                        this.context,
                        MaterialPageRoute(
                          builder: (context) => NabtAICameraScanResultPage(
                            scanType: scanType,
                            imagePath: image.path,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning,',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Rahma!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeMessagesPage()),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1E1E),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 24),
                              Positioned(
                                right: -2,
                                top: -2,
                                child: CircleAvatar(
                                  radius: 5,
                                  backgroundColor: const Color(0xFF4CAF50),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MeteoPage()),
                        ),
                        child: const WeatherWidget(compact: true),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Quick Access',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 106,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _quickActionButton(
                    icon: Icons.health_and_safety_outlined,
                    label: 'Disease\nDiagnosis',
                    onTap: _openDiseaseDiagnosisPicker,
                  ),
                  const SizedBox(width: 12),
                  _quickActionButton(
                    icon: Icons.camera_alt_rounded,
                    label: 'AI Camera\nScan',
                    isHighlighted: true,
                    onTap: _openAICameraTypePicker,
                  ),
                  const SizedBox(width: 12),
                  _quickActionButton(
                    icon: Icons.quiz_outlined,
                    label: 'Plant\nQuiz',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const QuizPage())),
                  ),
                  const SizedBox(width: 12),
                  _quickActionButton(
                    icon: Icons.forum_outlined,
                    label: 'Expert\nChat',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NabtCommunityForumPage())),
                  ),
                  const SizedBox(width: 12),
                  _quickActionButton(
                    icon: Icons.bookmark_outline_rounded,
                    label: 'Saved\nItems',
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ModernSavedItemsPage())),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Stories',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 10),
            _instagramStoriesRow(),
            const SizedBox(height: 18),
            const Text(
              'Posts Feed',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 10),
            _instagramFeedSection(),
          ],
        ),
      ),
    );
  }

  Widget _quickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isHighlighted = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 86,
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isHighlighted ? const Color(0xFF2DE091) : const Color(0xFF151D23),
                border: Border.all(color: Colors.white24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: isHighlighted ? Colors.black : Colors.white, size: 28),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _instagramStoriesRow() {
    return SizedBox(
      height: 98,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _homeStories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final story = _homeStories[index];
          final isMine = (story['isMine'] as bool?) ?? false;
          final isCreate = (story['isCreate'] as bool?) ?? false;
          final ownedByMe = (story['ownedByMe'] as bool?) ?? false;
          final seen = (story['seen'] as bool?) ?? false;

          return GestureDetector(
            onTap: () {
              if (isCreate) {
                final myStoryIndex = _homeStories.indexWhere((s) => (s['ownedByMe'] as bool?) ?? false);
                if (myStoryIndex >= 0) {
                  _openHomeStoryViewer(myStoryIndex);
                } else {
                  _addHomeStory();
                }
              } else {
                _openHomeStoryViewer(index);
              }
            },
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 62,
                      height: 62,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: seen
                            ? const LinearGradient(colors: [Color(0xFF5E6872), Color(0xFF5E6872)])
                            : const LinearGradient(colors: [Color(0xFF2DE091), Color(0xFF31D6FF)]),
                      ),
                      child: ClipOval(
                        child: _buildHomeImageFromSource((story['image'] ?? '').toString()),
                      ),
                    ),
                    if (isMine)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: _addHomeStory,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2DE091),
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFF0B0F12), width: 2),
                            ),
                            child: const Icon(Icons.add, color: Colors.black, size: 13),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  isCreate && ownedByMe ? 'My Story' : (story['name'] ?? '').toString(),
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _instagramFeedSection() {
    return Column(
      children: List.generate(_homeFeedPosts.length, (index) {
        final post = _homeFeedPosts[index];
        final liked = (post['liked'] as bool?) ?? false;
        final saved = (post['saved'] as bool?) ?? false;
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF151D23),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                child: GestureDetector(
                  onTap: () => _openHomeFarmerProfile(post),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: Color(0xFF2DE091),
                        child: Icon(Icons.person, color: Colors.black, size: 18),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text((post['farmer'] ?? '').toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                            Text((post['location'] ?? '').toString(), style: const TextStyle(color: Colors.white60, fontSize: 11)),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.white54),
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                  onTap: () {
                    if ((post['product'] ?? '').toString().isNotEmpty) {
                      _openHomePostProductDetails(post);
                    }
                  },
                  child: _buildHomeImageFromSource((post['image'] ?? '').toString()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _toggleHomeLike(index),
                          child: Icon(liked ? Icons.favorite : Icons.favorite_border, color: liked ? Colors.redAccent : Colors.white70, size: 20),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => _openHomeCommentsSheet(index),
                          child: const Icon(Icons.mode_comment_outlined, color: Colors.white70, size: 20),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => _shareHomePost(index),
                          child: const Icon(Icons.send_outlined, color: Colors.white70, size: 20),
                        ),
                        if ((post['product'] ?? '').toString().isNotEmpty) ...[
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _buyHomePostProduct(post),
                            child: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF2DE091), size: 20),
                          ),
                        ],
                        const Spacer(),
                        GestureDetector(
                          onTap: () => _toggleHomeSave(index),
                          child: Icon(saved ? Icons.bookmark : Icons.bookmark_border, color: saved ? const Color(0xFF2DE091) : Colors.white70, size: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('${_formatHomeCount(post['likes'] as int)} likes', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text((post['caption'] ?? '').toString(), style: const TextStyle(color: Colors.white70, height: 1.35)),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => _openHomeCommentsSheet(index),
                      child: Text('View all ${post['comments']} comments', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                    ),
                    if ((post['product'] ?? '').isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F151A),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFF2DE091).withValues(alpha: 0.35)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text((post['product'] ?? '').toString(), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 3),
                                  Text((post['price'] ?? '').toString(), style: const TextStyle(color: Color(0xFF2DE091), fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => _buyHomePostProduct(post),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2DE091),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text('Buy'),
                            ),
                          ],
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _gardenStatusCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF151D23),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              'https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?w=1200&q=80',
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(Icons.notifications_active_outlined, color: Color(0xFF2DE091)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Your Monstera needs water in 2 days',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _educationHighlightCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage('https://picsum.photos/seed/education-highlight/1200/700'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                'How to treat Leaf Spot disease',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EducationPage(isDarkMode: true)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2DE091),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Start Learning'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _marketPickCard({
    required String name,
    required String price,
    required String image,
    required VoidCallback onAdd,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF151D23),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(image, height: 100, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Text(price, style: const TextStyle(color: Color(0xFF2DE091), fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onAdd,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2DE091),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Add to Cart'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _homeVerticalProductsSection() {
    final products = [
      {
        'name': 'Monstera Deliciosa',
        'price': '2,800 DZD',
        'image': 'https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?w=1200&q=80',
      },
      {
        'name': 'Snake Plant',
        'price': '2,100 DZD',
        'image': 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=1200&q=80',
      },
      {
        'name': 'Peace Lily',
        'price': '1,950 DZD',
        'image': 'https://images.unsplash.com/photo-1593691509543-c55fb32e5e18?w=1200&q=80',
      },
    ];

    return Column(
      children: products.map((product) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF151D23),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white24),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(14)),
                child: Image.network(
                  product['image']!,
                  width: 110,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name']!,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        product['price']!,
                        style: const TextStyle(color: Color(0xFF2DE091), fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 32,
                        child: ElevatedButton(
                          onPressed: () {
                            NabtCartStore.addToCart({
                              'title': product['name'],
                              'price': double.tryParse(product['price']!.replaceAll('DZD', '').replaceAll(',', '').trim()) ?? 0,
                              'qty': 1,
                              'selected': true,
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${product['name']} added to cart')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2DE091),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text('Add to Cart'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _homeFarmersFeedSection() {
    final posts = [
      {
        'farmer': 'Yasmine from Blida',
        'caption': 'Today I transplanted basil and mint 🌱',
        'image': 'https://images.unsplash.com/photo-1464226184884-fa280b87c399?w=1200&q=80',
      },
      {
        'farmer': 'Samir from Oran',
        'caption': 'Early morning irrigation completed ✅',
        'image': 'https://images.unsplash.com/photo-1471193945509-9ad0617afabf?w=1200&q=80',
      },
      {
        'farmer': 'Nora from Setif',
        'caption': 'Leaf health is improving after treatment 🍃',
        'image': 'https://images.unsplash.com/photo-1457530378978-8bac673b8062?w=1200&q=80',
      },
    ];

    return Column(
      children: posts.map((post) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF151D23),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
                child: Text(
                  post['farmer']!,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  post['image']!,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  post['caption']!,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1453904300235-0f2f60b15b5d?q=80&w=1000'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withValues(alpha: 0.1), Colors.black],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            // Top Left: Region + Weather
            Positioned(
              top: 10,
              left: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Setif",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.wb_sunny, color: Color(0xFF64DD17), size: 16),
                      const SizedBox(width: 5),
                      const Text(
                        "28°C, Sunny",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Top Right: Camera Icon
            Positioned(
              top: 10,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: const Color(0xFF1A1A1A),
                      title: const Text("Camera Options", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      content: const Text("Choose an option:", style: TextStyle(color: Colors.grey)),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _captureImageFromCamera();
                          },
                          child: const Text("Take Photo", style: TextStyle(color: Color(0xFF64DD17))),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _pickImageFromGallery();
                          },
                          child: const Text("Choose from Gallery", style: TextStyle(color: Color(0xFF64DD17))),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                        ),
                      ],
                    ),
                  );
                },
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            // Bottom Left: Greeting
            Positioned(
              bottom: 0,
              left: 0,
              child: const Text(
                "Hi Abby,\nLet's grow together!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmartSearchBar() {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() => _searchQuery = value);
          },
          decoration: InputDecoration(
            hintText: "Search tools, categories, diseases...",
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(Icons.search, color: Color(0xFF64DD17)),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchQuery = "");
                    },
                  )
                : null,
            filled: true,
            fillColor: const Color(0xFF1A1A1A),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Color(0xFFB2FF59), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Color(0xFF00E676), width: 2),
            ),
          ),
        ),
        // Search Suggestions
        if (_searchQuery.isNotEmpty && searchSuggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: searchSuggestions.take(5).map((suggestion) {
                return GestureDetector(
                  onTap: () {
                    _searchController.text = suggestion;
                    setState(() => _searchQuery = suggestion);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.search, size: 16, color: Colors.grey),
                        const SizedBox(width: 10),
                        Text(
                          suggestion,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildSearchResultItem(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => _handleSearchSelection(item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            if (item['type'] == 'tool')
              Icon(item['icon'], color: const Color(0xFF64DD17), size: 24)
            else if (item['type'] == 'category')
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(item['img']),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            else
              const Icon(Icons.article_outlined, color: Colors.orange, size: 24),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  if (item.containsKey('desc'))
                    Text(
                      item['desc'],
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Color(0xFF64DD17), size: 14),
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyQuiz(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF64DD17).withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("WEEKLY QUIZ", style: TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 8),
                const Text("Test your skills and win points!", style: TextStyle(fontSize: 15, color: Colors.white)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QuizPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF64DD17), foregroundColor: Colors.black),
                  child: const Text("Start Quiz"),
                )
              ],
            ),
          ),
          const Icon(Icons.emoji_events_outlined, size: 60, color: Colors.white24),
        ],
      ),
    );
  }

  Widget _buildToolsGrid() {
    final List<Map<String, dynamic>> tools = [
      {"icon": Icons.qr_code_scanner, "label": "Plant ID"},
      {"icon": Icons.healing, "label": "Disease ID"},
      {"icon": Icons.water_drop_outlined, "label": "Water Counter"},
      {"icon": Icons.warning_amber_outlined, "label": "Toxicity"},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 1.5,
      ),
      itemCount: tools.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (tools[index]['label'] == "Disease ID") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NabtAIDiagnosticPage()),
              );
            } else {
              _showPickerOptions(context, tools[index]['label']);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(tools[index]['icon'], color: const Color(0xFF64DD17), size: 30),
                const SizedBox(height: 10),
                Text(tools[index]['label'], style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPickerOptions(BuildContext context, String toolName) {

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Scan for $toolName", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 25),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined, color: Color(0xFF64DD17)),
              title: const Text("Take a Photo", style: TextStyle(color: Colors.white)),
              subtitle: const Text("Identify plants and trees etc.", style: TextStyle(color: Colors.grey, fontSize: 12)),
              onTap: () {
                Navigator.pop(context);
                _capturePhotoTool(context);
              },
            ),
            const Divider(color: Colors.white10),
            ListTile(
              leading: const Icon(Icons.image_outlined, color: Color(0xFF64DD17)),
              title: const Text("Choose from Gallery", style: TextStyle(color: Colors.white)),
              subtitle: const Text("Upload an image of plants", style: TextStyle(color: Colors.grey, fontSize: 12)),
              onTap: () {
                Navigator.pop(context);
                _pickFromGalleryTool(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _capturePhotoTool(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    
    if (photo != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScanningScreen(imagePath: photo.path)),
      );
    }
  }

  Future<void> _pickFromGalleryTool(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
      if (image != null && mounted) {
    }
  }

  Widget _buildCategoryGrid() {
    final List<Map<String, String>> categories = [
      {"name": "Vegetables", "img": "https://images.unsplash.com/photo-1597362860722-39e72f76b74e?q=80&w=200"},
      {"name": "Fruits", "img": "https://images.unsplash.com/photo-1610832958506-aa56368176cf?q=80&w=200"},
      {"name": "Herbs", "img": "https://images.unsplash.com/photo-1509223197845-458d87318791?q=80&w=200"},
      {"name": "Flowers", "img": "https://images.unsplash.com/photo-1490750967868-88aa4486c946?q=80&w=200"},
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.6,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryProductsPage(categoryName: category['name']!),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(category['img']!),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.5), BlendMode.darken),
              ),
            ),
            alignment: Alignment.center,
            child: Text(category['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }

  Widget _buildDiseaseArticles(BuildContext context) {
    final List<Map<String, String>> diseases = [
      {
        "title": "Rust Fungi Guide",
        "desc": "How to protect your field crops.",
        "image": "https://images.unsplash.com/photo-1490750967868-88aa4486c946?q=80&w=200",
        "content": "UNDERSTANDING RUST FUNGI\n\nRust fungi is one of the most destructive crop diseases worldwide, affecting wheat, barley, and other cereal crops. This disease causes significant economic losses in agricultural systems globally. Rust fungi appears as brownish powdery spots on leaves and stems, which is actually the fungal spore stage.\n\nThere are three main types of rust: red rust (urediniospores), black rust (teliospores), and yellow rust (aecial stage). Each type has different environmental preferences and affects crops at different times of the growing season.\n\nIDENTIFICATION AND SYMPTOMS:\nThe disease manifests as pustules that rupture to release rust-colored powder. Infected leaves may become yellow and eventually die. In severe cases, the entire crop can be affected, leading to devastating yield losses of up to 50% or more.\n\nCONDITIONS FAVORING GROWTH:\n• Cool temperatures (10-20°C) combined with high humidity\n• Morning dew and rain\n• Crowded plant spacing reducing air circulation\n• Alkaline soils\n• Nitrogen-rich environments\n\nPREVENTION STRATEGIES:\n1. Plant resistant varieties - This is the most effective method. Modern wheat and barley varieties have been bred for rust resistance.\n2. Crop rotation - Avoid planting susceptible crops in the same field consecutively\n3. Proper spacing - Ensure adequate distance between plants for air circulation\n4. Sanitation - Remove infected crop residues immediately after harvest\n5. Monitor regularly - Early detection prevents widespread infection\n\nTREATMENT OPTIONS:\nWhen prevention fails, fungicides can be effective if applied correctly and at the right time. Triazole fungicides are effective against most rust species. Strobilurins provide preventive and curative action. Combine fungicides with proper cultural practices for best results.\n\nTIMING IS CRITICAL: Apply fungicides at the first sign of disease appearance. Waiting too long reduces effectiveness. Weather conditions affect fungicide efficacy - avoid spraying during rain or extreme heat.\n\nLONG-TERM MANAGEMENT:\nImplement an integrated pest management approach combining resistant varieties, crop rotation, field sanitation, and timely fungicide applications. Monitor weather forecasts and use disease forecasting tools to predict rust occurrence and determine optimal spray timing."
      },
      {
        "title": "Leaf Spot Disease",
        "desc": "Identify and treat leaf spots early.",
        "image": "https://images.unsplash.com/photo-1610832958506-aa56368176cf?q=80&w=200",
        "content": "COMPREHENSIVE GUIDE TO LEAF SPOT DISEASE\n\nLeaf spot disease is a group of fungal and bacterial diseases that create necrotic spots on plant leaves. This disease affects a wide range of crops including tomatoes, potatoes, beans, and ornamental plants. Multiple pathogens can cause leaf spots, making diagnosis and treatment important for effective management.\n\nthe disease typically begins as water-soaked lesions that develop into tan or brown spots with concentric rings. Yellow halos often surround the spots as the host plant tries to compartmentalize the infection. In severe cases, entire leaves can become necrotic and drop from the plant.\n\nDISEASE PROGRESSION:\nLeaf spot diseases usually start on lower leaves and progress upward as the disease advances. This pattern occurs because lower leaves experience higher humidity and are older, making them more susceptible to infection. The disease spreads through water splash from rain or irrigation.\n\nFACTORS AFFECTING SEVERITY:\n• High humidity (above 85%)\n• Temperatures between 18-28°C\n• Prolonged leaf wetness periods\n• Overhead irrigation creating wet foliage\n• Plant stress from poor nutrition\n• Overcrowding reducing air circulation\n\nIDENTIFICATION TIPS:\n1. Look for spots with distinct rings or halos\n2. Note the sequence - typically lower leaves first\n3. Spot color varies: brown, tan, purple, or black depending on pathogen\n4. Bacterial spots have water-soaked appearance with yellow halo\n5. Fungal spots may have concentric rings and spore patterns\n\nMANAGEMENT STRATEGIES:\nCultural practices form the foundation of control:\n• Remove infected leaves promptly to reduce spore production\n• Water plants at soil level only, never overhead\n• Ensure proper spacing for air circulation through canopy\n• Apply mulch to prevent spore splash from soil to leaves\n• Practice crop rotation to reduce soil-borne inoculum\n• Use disease-free seeds and certified healthy transplants\n\nCHEMICAL AND BIOLOGICAL CONTROLS:\nFungicides containing copper or mancozeb provide good control against fungal leaf spots. Strobilurins offer both preventive and curative activity. For bacterial leaf spots, copper-based bactericides are the primary option. Biological fungicides containing Bacillus subtilis show promise in research trials.\n\nSPRAY PROGRAMS:\nBegin preventive sprays when environmental conditions favor disease development. Spray every 7-10 days depending on disease pressure. Continue through the growing season or until disease pressure decreases. Always follow label directions and rotate fungicide modes of action to prevent resistance development."
      },
      {
        "title": "Powdery Mildew",
        "desc": "White powder coating on leaves.",
        "image": "https://images.unsplash.com/photo-1490750967868-88aa4486c946?q=80&w=200",
        "content": "POWDERY MILDEW: A COMPLETE MANAGEMENT GUIDE\n\nPowdery mildew is one of the most recognizable plant diseases, characterized by a white, flour-like coating on leaves, stems, and flowers. Unlike most fungal diseases that favor wet conditions, powdery mildew thrives in warm, dry weather with moderate humidity (40-50%), making it unique among fungal pathogens. This disease affects hundreds of plant species including cucurbits, grapes, apples, ornamentals, and many vegetables.\n\nTHE DISEASE PROCESS:\nThe powdery mildew fungus lives on the leaf surface, sending haustoria into epidermal cells to extract nutrients. This superficial nature makes it relatively easy to control with organic methods. The white coating consists of fungal mycelium and conidia (asexual spores) that spread through the air to infect new leaves.\n\nCLINICAL SYMPTOMS:\n• White powdery coating on upper leaf surfaces (sometimes undersides)\n• Leaves may curl or become distorted\n• Flowering may be delayed or prevented\n• Fruit development can be affected\n• Severely infected leaves may turn yellow and drop\n• Young leaves more susceptible than mature leaves\n\nCONDITIONS PROMOTING DISEASE:\n• Temperatures between 15-25°C (optimal around 20°C)\n• Low humidity despite fungal name - fungal matting prevents water penetration\n• Overhead shade reducing direct sunlight\n• Moderate air movement to spread spores\n• Dense plant canopies trapping moisture\n• High nitrogen fertilization creating succulent growth\n\nCULTURAL MANAGEMENT:\n1. Select resistant varieties - Many cultivars have built-in resistance\n2. Improve air circulation - Prune unnecessary branches, space plants properly\n3. Reduce nitrogen - High nitrogen creates susceptible new growth\n4. Manage humidity - Remove excess shade, avoid overhead irrigation\n5. Monitor plants - Early detection allows easier control\n6. Remove infected leaves - Reduces inoculum load\n\nORGANIC TREATMENT OPTIONS:\n• Sulfur dust or spray - Most effective organic fungicide, apply every 7-10 days\n• Neem oil - Disrupts fungal reproduction, apply weekly\n• Potassium bicarbonate - Contact fungicide with preventive properties\n• Baking soda spray - Mix 1 tablespoon per gallon water with horticultural oil\n• Milk spray - Mix 1 part milk with 9 parts water, apply weekly (surprisingly effective)\n\nCHEMICAL CONTROLS:\n• Triazoles - Systemic triazole fungicides provide both preventive and curative control\n• Strobilurins - Single-site agents with rapid action\n• Sulfites - Various sulfur-based formulations available\n• Rotation programs - Alternate fungicide modes of action to prevent resistance\n\nSPRAY TIMING AND APPLICATION:\nBegin applications when conditions favor disease development. Spray thoroughly covering all leaf surfaces. Apply every 7-10 days through the growing season. Sulfur should not be applied within 2 weeks of oil applications. Avoid spraying during extreme heat above 30°C as sulfur can phytotoxic on sensitive plants.\n\nPREVENTIVE PROGRAM:\nThe best approach combines cultural practices with regular preventive sprays. This is more effective than waiting for visible symptoms before treating."
      },
      {
        "title": "Early Blight",
        "desc": "Common in tomato and potato crops.",
        "image": "https://images.unsplash.com/photo-1509223197845-458d87318791?q=80&w=200",
        "content": "EARLY BLIGHT: RECOGNITION, PREVENTION, AND TREATMENT\n\nEarly blight, caused by Alternaria solani, is a devastating fungal disease affecting tomato and potato crops worldwide. This disease causes significant economic losses annually, with some estimates suggesting yield reductions of 50% or more in untreated fields. The disease appears in lower leaves first and progresses upward, eventually causing premature defoliation and exposing fruit to sunscald.\n\nDISEASE CHARACTERISTICS:\nEarly blight produces characteristic brown, circular lesions with concentric rings resembling a target or bull's-eye pattern. These ring patterns form as the fungus kills tissue in expanding circles. A yellow halo often surrounds individual lesions as the plant attempts to compartmentalize the infection. Affected leaves eventually turn yellow and drop from the plant.\n\nINFECTION CYCLE:\nThe fungus overwinters in crop debris and soil. In spring, spores are produced and spread by water splash, especially from overhead irrigation or rain. Temperature between 20-25°C combined with leaf wetness periods of 12 hours or more favor infection. The disease typically appears 3-4 weeks after transplanting.\n\nSYMPTOM PROGRESSION:\nInitially, small brown spots appear on lower leaves. Within a few days, concentric rings develop within spots. Yellow halos expand around lesions. Adjacent spots merge together, covering entire leaflets. Petioles (leaf stems) then become infected, eventually girdling and causing leaf drop. In severe cases, defoliation exposes developing fruit to intense sunlight, causing sunscald.\n\nMULT-TACTIC MANAGEMENT APPROACH:\n\n1. CULTURAL PRACTICES:\n• Crop rotation - Use at least 2-3 year rotations with non-solanaceous crops\n• Remove lower leaves - Prune lower 6-8 inches of leaves from tomato plants\n• Mulching - Apply 3-4 inches of mulch to prevent spore splash from soil\n• Irrigation method - Use drip irrigation to keep foliage dry\n• Spacing - Ensure adequate plant spacing for air circulation\n• Sanitation - Remove crop residue completely after harvest; spores survive in debris\n\n2. RESISTANT VARIETIES:\nPlant tomato and potato varieties with resistance to early blight. Many modern cultivars carry Alternaria resistance genes. Resistant varieties show significantly slower disease progression.\n\n3. PREVENTIVE FUNGICIDE PROGRAM:\nBegin preventive sprays when weather favors disease development or 3-4 weeks after transplanting. Efficacy depends on coverage - spray both sides of all leaves. Key fungicide options include:\n• Chlorothalonil - Multi-site fungicide, excellent protective coverage\n• Mancozeb - Broad-spectrum fungicide with multi-site action\n• Triazoles - Systemic fungicides with curative properties\n• Strobilurins - Single-site contact fungicides\n\nAPPLICATION SCHEDULE:\nSpray every 7-10 days depending on disease pressure and weather conditions. Increase frequency during periods of high humidity and frequent rain. Continue spraying until late in the season or until disease pressure subsides. Rotate fungicides with different modes of action to prevent resistance development.\n\nMONITORING FOR SUCCESS:\nRegularly inspect lower leaves for early symptoms. When caught early, intervention is more effective. Track weather conditions and increase spray frequency when conditions favor disease. Keep good records of spray applications and disease level to refine management for future seasons."
      },
      {
        "title": "Root Rot Disease",
        "desc": "Affects roots causing plant wilting.",
        "image": "https://images.unsplash.com/photo-1545241047-6083a3684587?q=80&w=200",
        "content": "ROOT ROT DISEASE: IDENTIFICATION, PREVENTION, AND MANAGEMENT\n\nRoot rot is among the most destructive diseases in agriculture because damage occurs underground where symptoms often go unnoticed until severe plant damage occurs. Multiple fungal pathogens cause root rot including Phytophthora, Fusarium, and Rhizoctonia species. Once root rot becomes apparent above ground through plant wilting, significant root tissue destruction has already occurred, making prevention far more important than cure.\n\nPATHOGEN CHARACTERISTICS:\nPhytophthora species thrive in wet, poorly drained soils, spreading through contaminated water and soil. Fusarium species produce persistent spores in soil that survive for years. Rhizoctonia species prefer soil temperatures of 15-25°C and persist in crop residue. Understanding which pathogen causes problems in your field helps tailor management strategies.\n\nCAUSATIVE FACTORS:\n• Poor soil drainage creating waterlogged conditions\n• Heavy clay soils retaining excessive moisture\n• Overwatering or excessive irrigation\n• Using non-sterile potting media in greenhouses\n• Soil pH below 5.5 favoring root rot pathogens\n• Plant stress from nutrient deficiency making roots more susceptible\n• Continuous monoculture of susceptible crops\n\nEARLY WARNING SIGNS:\n1. Wilting despite adequate soil moisture (often the first symptom)\n2. Purple or brown discoloration of stems starting at soil line\n3. Reduced root mass - mostly brown instead of white\n4. Foul smell from damaged root tissue\n5. Slow plant growth and stunting\n6. Yellow leaves not responding to fertilizer\n7. Poor nutrient uptake despite adequate fertilization\n\nCONFIRMATION:\nDig plants and examine roots. Healthy roots are white and firm. Diseased roots are brown, soft, mushy, and pull apart easily. Look for dark discoloration extending from root tips. Smell the roots - root rot produces characteristic unpleasant odor from anaerobic decomposition.\n\nPREVENTION - THE BEST STRATEGY:\n\n1. SOIL MANAGEMENT:\n• Improve drainage through raised beds or tile drainage systems\n• Add organic matter to improve soil structure\n• Maintain soil pH at 6.0-7.0 (less favorable for most pathogens)\n• Avoid soil compaction which reduces oxygen and increases disease\n• Conduct soil tests to identify limiting factors\n\n2. IRRIGATION MANAGEMENT:\n• Use drip irrigation rather than overhead sprinklers\n• Water only enough to meet plant needs, never overwater\n• Install soil moisture monitoring devices to assess water needs\n• Water early morning to allow soil to dry during day\n• Ensure water drains completely after each irrigation\n\n3. PATHOGEN EXCLUSION:\n• Use disease-free seeds and transplants from certified sources\n• Sanitize tools, greenhouse benches, and equipment between uses\n• Clean pots and flats with 10% bleach solution\n• Remove plant debris promptly to reduce inoculum sources\n• Establish sanitation procedures for foot traffic\n\n4. CULTURAL PRACTICES:\n• Rotate crops - avoid planting same family in same location annually\n• Use resistant varieties when available\n• Provide adequate plant nutrition especially potassium\n• Space plants properly for air circulation\n• Maintain pH in optimal range for your crop\n\n5. BIOLOGICAL APPROACHES:\n• Beneficial microbes like Bacillus and Trichoderma can suppress pathogens\n• Mycorrhizal fungi improve plant health and disease resistance\n• Soil microbes compete with pathogens for resources\n\nCHEMICAL TREATMENTS:\nOnce root rot is confirmed, options are limited because roots are underground. Metalaxyl (Ridomil) is effective against Phytophthora but not other root rot pathogens. Fungicides must reach root zone through soil or irrigation water. Treatment success is limited once significant damage has occurred.\n\nMULTI-YEAR MANAGEMENT:\nFor fields with history of root rot:\n• Take 2-3 year break from susceptible crops\n• Build soil health through crop rotation and organic matter\n• Implement preventive practices from start of next crop rotation\n• Monitor first crops for early symptoms\n• Gradual transition back to susceptible crops as soil health improves\n\nWHEN REPLANTING:\n• Select resistant varieties\n• Optimize soil conditions before planting\n• Use disease-free transplants\n• Implement strict preventive program\n• Monitor closely for early symptoms"
      },
      {
        "title": "Fungal Disease Management",
        "desc": "Integrated strategies and best practices.",
        "image": "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=200",
        "content": "INTEGRATED FUNGAL DISEASE MANAGEMENT: COMPREHENSIVE STRATEGIES\n\nSuccessful management of fungal diseases requires understanding that no single approach works perfectly for all situations. Instead, a combination of strategies - cultural practices, resistant varieties, biological controls, and carefully-timed fungicide applications - provides the most reliable disease suppression while reducing chemical usage and development of resistance.\n\nTHE FOUNDATION: CULTURAL PRACTICES\n\nCultural practices are the foundation of any disease management program. These practices are ecological approaches that create an environment unfavorable for fungal pathogens without relying on chemical inputs.\n\nSanitation and Hygiene:\n• Remove and destroy diseased plant material promptly\n• Clean tools, equipment, and hands between plants to prevent pathogen spread\n• Disinfect greenhouse structures, benches, and propagation equipment\n• Clean growing containers thoroughly between crops\n• Remove volunteer seedlings that harbor pathogens\n• Do not compost potentially infected plant material\n\nWater Management:\n• Apply water at soil level using drip irrigation\n• Avoid overhead irrigation that wets foliage\n• Water early morning allowing drying through day\n• Reduce irrigation frequency as plants mature\n• Maintain soil moisture but avoid waterlogging\n• Collect and dispose of runoff water to prevent pathogen spread\n\nAir Circulation and Spacing:\n• Space plants to allow air movement through canopy\n• Remove lower leaves to improve light penetration\n• Prune suckers and unnecessary growth in tomatoes\n• Install fans if natural air circulation is inadequate\n• Avoid overcrowding seedlings in propagation\n• Position plants to maximize sun exposure\n\nCrop Rotation:\n• Rotate crops to different fields yearly\n• Use 2-3 year rotations with non-host plant families\n• Include break crops that suppress soil-borne pathogens\n• Maintain records of crop locations and history\n• Plan rotations several years in advance\n\nVARIETY SELECTION\n\nResistant varieties are the most economical and environmentally sound disease management tool. Modern plant breeding has produced varieties with excellent resistance to major fungal diseases.\n\nUnderstanding Resistance Designations:\n• V - Resistance to Verticillium wilt\n• F/FF/FFF - Resistance to different Fusarium races\n• N - Resistance to root-knot nematode\n• T - Resistance to Tobacco mosaic virus\n• A - Resistance to Alternaria species\n• L - Resistance to Septoria leaf spot\n\nWhen selecting varieties:\n• Match resistance genes to diseases present in your area\n• Rotate varieties to prevent resistance breakdown\n• Plant certified disease-free seed from reputable suppliers\n• Keep proper records of variety performance\n• Share information with other growers\n\nBIOLOGICAL CONTROLS\n\nBiological control agents compete with pathogens or directly suppress them through various mechanisms.\n\nBiofungicides Available:\n• Bacillus subtilis products suppress multiple fungal pathogens\n• Trichoderma harzianum colonizes roots and produces antibiotic compounds\n• Bacillus pumilus metabolites inhibit fungal growth\n• Pseudomonas fluorescens produces compounds toxic to pathogens\n• Ampelomyces quisqualis is hyperparasitic on powdery mildew fungi\n\nOrganic Control Materials:\n• Sulfur dust - effective against powdery mildews, apply early and frequently\n• Neem oil - fungistatic against various pathogens, preventive application needed\n• Potassium bicarbonate - multi-site contact and systemic activity\n• Oils - horticultural oils disrupt fungal reproduction\n• Copper sulfate - multi-site fungicide, approved for organic production\n\nFUNGICIDE DECISION-MAKING\n\nWhen cultural practices and resistant varieties are insufficient, fungicides become necessary. Strategic timing and selection maximize effectiveness while minimizing resistance development.\n\nFungicide Classes and Modes of Action:\n\nMulti-site Fungicides (Low Resistance Risk):\n• Chlorothalonil - protective coverage, excellent disease suppression\n• Mancozeb - broad spectrum, multi-site action\n• Copper compounds - approved organic, site accumulation concerns\n\nSingle-site Fungicides (Higher Resistance Risk):\n• Triazoles - systemic, preventive and curative\n• Strobilurins - single-site inhibitors of cellular respiration\n• Benzimidazoles - systemic with resistance issues in many pathogens\n• Quinolines - for limited number of pathogens\n\nResistance Management:\n• Rotate fungicide classes every 2-3 spray cycles\n• Never apply same single-site fungicide consecutively\n• Mix multi-site with single-site fungicides when possible\n• Monitor efficacy and change program if effectiveness declines\n• Track all fungicide applications for rotation planning\n\nSPRAY PROGRAM DEVELOPMENT\n\nEffective programs balance multiple considerations:\n\nTiming Decisions:\n• Begin preventive sprays when environmental conditions favor disease\n• Spray more frequently during susceptible growth stages\n• Spray before rain or high humidity periods when possible\n• Skip sprays when conditions don't favor disease development\n• Increase frequency if disease pressure increases\n\nApplication Technique:\n• Ensure thorough coverage of all leaf surfaces\n• Spray until dripping for complete coverage\n• Include both upper and lower leaf surfaces\n• Spray early morning or late afternoon (not during heat)\n• Avoid spraying when rain is forecasted within 12 hours\n• Follow all label directions regarding safety and application rates\n\nMONITORING AND RECORD KEEPING\n\nDetailled records enable program optimization:\n• Scout fields regularly for disease symptoms\n• Track weather conditions favoring disease development\n• Record spray application dates, products used, and conditions\n• Maintain disease incidence ratings\n• Evaluate program effectiveness\n• Identify improvements for next season\n\nCONCLUSION\n\nSuccessful fungal disease management combines multiple tactics in an integrated approach. No single method provides complete control, but combination of cultural practices, resistant varieties, careful monitoring, and judicious fungicide use provides excellent disease suppression while being economically and environmentally sustainable for long-term success."
      },
    ];
    
    return Column(
      children: List.generate(diseases.length, (index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DiseaseDetailPage(
                  title: diseases[index]['title']!,
                  description: diseases[index]['desc']!,
                  content: diseases[index]['content']!,
                  image: diseases[index]['image']!,
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(diseases[index]['image']!, width: 60, height: 60, fit: BoxFit.cover),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(diseases[index]['title']!, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      Text(diseases[index]['desc']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Color(0xFF64DD17), size: 14),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTrendingList() {
    final List<String> plants = [
      "https://images.unsplash.com/photo-1545241047-6083a3684587?q=80&w=400",
      "https://images.unsplash.com/photo-1509423350716-97f9360b4e09?q=80&w=400",
      "https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=400"
    ];

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: plants.length,
        itemBuilder: (context, index) {
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(image: NetworkImage(plants[index]), fit: BoxFit.cover),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.8)],
                ),
              ),
              padding: const EdgeInsets.all(12),
              alignment: Alignment.bottomLeft,
              child: const Text("Peace Lily", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          );
        },
      ),
    );
  }
}

// =====================================================
// DISEASE DETAIL PAGE
// =====================================================

class DiseaseDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String content;
  final String image;

  const DiseaseDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.content,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.network(
                image,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Content with green accent
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xFF64DD17), width: 1),
                    ),
                    child: Text(
                      content,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Back Button
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Back to Articles"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF64DD17),
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// SELLER PROFILE PAGE
// =====================================================

class SellerProfilePage extends StatefulWidget {
  const SellerProfilePage({super.key});

  @override
  State<SellerProfilePage> createState() => _SellerProfilePageState();
}

class _SellerProfilePageState extends State<SellerProfilePage> {
  bool _isFollowing = false;

  final Map<String, dynamic> _sellerInfo = {
    "name": "Green Garden Store",
    "rating": 4.9,
    "reviews": 1234,
    "products": 156,
    "yearsActive": 5,
    "shippingReliability": "98%",
    "returnPolicy": "30 days",
    "bio": "Premium organic plants and gardening supplies. We provide high-quality, sustainably grown plants with expert care instructions for every customer.",
  };

  final List<Map<String, String>> _sellerProducts = [
    {"name": "Tomato Plant", "price": "\$15.00", "image": "https://images.unsplash.com/photo-1592921870789-04563e271ab1?w=400"},
    {"name": "Mint Herb", "price": "\$9.00", "image": "https://images.unsplash.com/photo-1599599810694-b5ac4dd37e86?w=400"},
    {"name": "Basil Leaf", "price": "\$8.00", "image": "https://images.unsplash.com/photo-1580809361436-42a7ec9b3dbb?w=400"},
    {"name": "Rose Bush", "price": "\$24.00", "image": "https://images.unsplash.com/photo-1563241527-3004b8f0a263?w=400"},
    {"name": "Lavender", "price": "\$12.00", "image": "https://images.unsplash.com/photo-1490750967868-88aa4486c946?w=400"},
    {"name": "Cactus", "price": "\$18.00", "image": "https://images.unsplash.com/photo-1509207736528-cda5be79d074?w=400"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // Header with back button
          SliverAppBar(
            expandedHeight: 0,
            pinned: true,
            backgroundColor: Color(0xFF1A1A1A),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text("Seller Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),

          // Seller Profile Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Seller Header Section
                _buildSellerHeader(),

                const SizedBox(height: 25),

                // Seller Bio
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "About Store",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _sellerInfo["bio"],
                        style: const TextStyle(color: Colors.white70, height: 1.6),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // Seller Stats
                _buildSellerStats(),

                const SizedBox(height: 25),

                // Seller Products Gallery
                _buildSellerProducts(),

                const SizedBox(height: 30),

                // Additional Info
                _buildAdditionalInfo(),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSellerHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Store Logo/Avatar
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF64DD17),
              boxShadow: [BoxShadow(color: Color(0xFF64DD17).withValues(alpha: 0.3), blurRadius: 20, spreadRadius: 5)],
            ),
            child: const Center(
              child: Text(
                "GG",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),

          // Seller Name
          Text(
            _sellerInfo["name"],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),

          // Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: List.generate(5, (i) => Icon(Icons.star, color: Color(0xFF64DD17), size: 18)),
              ),
              const SizedBox(width: 8),
              Text(
                "${_sellerInfo["rating"]} (${_sellerInfo["reviews"]} reviews)",
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF64DD17),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    setState(() => _isFollowing = !_isFollowing);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(_isFollowing ? "Following store! ⭐" : "Unfollowed store"),
                        backgroundColor: Color(0xFF64DD17),
                      ),
                    );
                  },
                  child: Text(
                    _isFollowing ? "Following ✓" : "Follow Store",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF64DD17), width: 2),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatPage()),
                    );
                  },
                  child: const Text(
                    "Chat",
                    style: TextStyle(
                      color: Color(0xFF64DD17),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSellerStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            _buildStatItem("${_sellerInfo["products"]}", "Available Products"),
            _buildStatItem("${_sellerInfo["yearsActive"]}", "Years Active"),
            _buildStatItem(_sellerInfo["shippingReliability"], "Shipping Reliability"),
            _buildStatItem(_sellerInfo["returnPolicy"], "Return Policy"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF64DD17),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildSellerProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Featured Products",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("View All", style: TextStyle(color: Color(0xFF64DD17))),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _sellerProducts.length,
            itemBuilder: (context, index) {
              final product = _sellerProducts[index];
              return Container(
                width: 150,
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  color: Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.network(
                        product["image"]!,
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product["name"]!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product["price"]!,
                            style: const TextStyle(
                              color: Color(0xFF64DD17),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAdditionalInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Store Information",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            _buildInfoRow("📦 Shipping Reliability", _sellerInfo["shippingReliability"]),
            _buildInfoRow("🔄 Return Policy", _sellerInfo["returnPolicy"]),
            _buildInfoRow("⏱️ Years Active", "${_sellerInfo["yearsActive"]} years"),
            _buildInfoRow("⭐ Average Rating", _sellerInfo["rating"].toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          Text(value, style: const TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// =====================================================
// SETTINGS PAGE
// =====================================================

class SettingsPage extends StatefulWidget {
  final Function(String) onLanguageChange;
  final Function(bool) onThemeChange;
  final String currentLanguage;
  final bool isDarkMode;

  const SettingsPage({
    super.key,
    required this.onLanguageChange,
    required this.onThemeChange,
    required this.currentLanguage,
    required this.isDarkMode,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool _darkMode;
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _twoFactorAuth = false;
  late String _language;
  
  // Payment Methods
  final List<Map<String, String>> _paymentMethods = [
    {'type': 'Card', 'name': 'Visa ending in 4242', 'icon': '💳'},
    {'type': 'Cash', 'name': 'On Delivery', 'icon': '💵'},
  ];
  
  // Sessions
  final List<Map<String, String>> _sessions = [
    {'device': 'iPhone', 'location': 'Setif, Algeria', 'date': 'Today at 10:30 AM'},
    {'device': 'MacBook', 'location': 'Setif, Algeria', 'date': 'Yesterday'},
  ];

  @override
  void initState() {
    super.initState();
    _language = widget.currentLanguage;
    _darkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text("Settings", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          // Profile Section
          _buildSectionHeader("Profile"),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: const Color(0xFF64DD17),
                      child: const Text("RU", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Rahma User", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          const Text("rahma@email.com", style: TextStyle(color: Colors.white70, fontSize: 13)),
                          const SizedBox(height: 4),
                          const Text("+1 (555) 123-4567", style: TextStyle(color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF64DD17),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Edit Profile - Coming Soon")),
                      );
                    },
                    child: const Text("Edit Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),

          // App Settings Section
          _buildSectionHeader("App Settings"),
          _buildSettingOption(
            icon: Icons.language,
            title: "Language",
            subtitle: _language == 'en' ? '🇬🇧 English' : (_language == 'ar' ? '🇸🇦 العربية' : '🇫🇷 Français'),
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: const Color(0xFF1A1A1A),
                builder: (context) => _buildLanguageSelector(),
              );
            },
          ),
          _buildSwitchSetting(
            icon: Icons.dark_mode,
            title: "Dark Mode",
            value: true,
            onChanged: (value) {
              setState(() => _darkMode = true);
              widget.onThemeChange(true);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Dark mode is fixed for all pages")),
              );
            },
          ),
          _buildSwitchSetting(
            icon: Icons.notifications,
            title: "Push Notifications",
            value: _pushNotifications,
            onChanged: (value) => setState(() => _pushNotifications = value),
          ),
          _buildSwitchSetting(
            icon: Icons.email,
            title: "Email Notifications",
            value: _emailNotifications,
            onChanged: (value) => setState(() => _emailNotifications = value),
          ),

          // Payment & Wallet Section
          _buildSectionHeader("Payment & Wallet"),
          _buildSettingOption(
            icon: Icons.credit_card,
            title: "Payment Methods",
            subtitle: "Manage your payment options",
            onTap: () => _showPaymentMethodsDialog(),
          ),
          _buildSettingOption(
            icon: Icons.wallet,
            title: "Wallet Balance",
            subtitle: "\$125.50",
            onTap: () {},
          ),

          // Privacy & Security Section
          _buildSectionHeader("Privacy & Security"),
          _buildSettingOption(
            icon: Icons.lock,
            title: "Change Password",
            onTap: () => _showChangePasswordDialog(),
          ),
          _buildSwitchSetting(
            icon: Icons.security,
            title: "Two-Factor Authentication",
            value: _twoFactorAuth,
            onChanged: (value) => setState(() => _twoFactorAuth = value),
          ),
          _buildSettingOption(
            icon: Icons.devices,
            title: "Manage Sessions",
            onTap: () => _showManageSessionsDialog(),
          ),

          // Help & Support Section
          _buildSectionHeader("Help & Support"),
          _buildSettingOption(
            icon: Icons.help,
            title: "FAQ",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("FAQ - Coming Soon")),
              );
            },
          ),
          _buildSettingOption(
            icon: Icons.chat,
            title: "Contact Support",
            subtitle: "Chat, Email, Call",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Contact Support - Coming Soon")),
              );
            },
          ),

          // About Section
          _buildSectionHeader("About"),
          _buildSettingOption(
            icon: Icons.description,
            title: "Privacy Policy",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Privacy Policy - Coming Soon")),
              );
            },
          ),
          _buildSettingOption(
            icon: Icons.gavel,
            title: "Terms & Conditions",
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Terms & Conditions - Coming Soon")),
              );
            },
          ),
          _buildSettingOption(
            icon: Icons.info,
            title: "App Version",
            subtitle: "1.0.0 (Build 1)",
            onTap: () {},
          ),

          // Logout Button
          Container(
            margin: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: const Color(0xFF1A1A1A),
                    title: const Text("Logout", style: TextStyle(color: Colors.white)),
                    content: const Text("Are you sure you want to logout?", style: TextStyle(color: Colors.white70)),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel", style: TextStyle(color: Color(0xFF64DD17))),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Logged out successfully")),
                          );
                        },
                        child: const Text("Logout", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("Logout", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showPaymentMethodsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text("Payment Methods", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ..._paymentMethods.map((method) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF64DD17).withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Text(method['icon']!, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(method['type']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          Text(method['name']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    ),
                    Icon(Icons.check_circle, color: const Color(0xFF64DD17), size: 20),
                  ],
                ),
              )),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Add Payment Method - Coming Soon")),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Add New Method"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF64DD17),
                    foregroundColor: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close", style: TextStyle(color: Color(0xFF64DD17))),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    bool obscureOld = true;
    bool obscureNew = true;
    bool obscureConfirm = true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          title: const Text("Change Password", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: oldPasswordController,
                  obscureText: obscureOld,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Current Password",
                    labelStyle: const TextStyle(color: Color(0xFF64DD17)),
                    filled: true,
                    fillColor: Colors.black.withValues(alpha: 0.5),
                    suffixIcon: IconButton(
                      icon: Icon(obscureOld ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => obscureOld = !obscureOld),
                      color: const Color(0xFF64DD17),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: newPasswordController,
                  obscureText: obscureNew,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "New Password",
                    labelStyle: const TextStyle(color: Color(0xFF64DD17)),
                    filled: true,
                    fillColor: Colors.black.withValues(alpha: 0.5),
                    suffixIcon: IconButton(
                      icon: Icon(obscureNew ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => obscureNew = !obscureNew),
                      color: const Color(0xFF64DD17),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: obscureConfirm,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Confirm New Password",
                    labelStyle: const TextStyle(color: Color(0xFF64DD17)),
                    filled: true,
                    fillColor: Colors.black.withValues(alpha: 0.5),
                    suffixIcon: IconButton(
                      icon: Icon(obscureConfirm ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => obscureConfirm = !obscureConfirm),
                      color: const Color(0xFF64DD17),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                if (newPasswordController.text == confirmPasswordController.text) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Password changed successfully"), backgroundColor: Color(0xFF64DD17)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Passwords do not match"), backgroundColor: Colors.red),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF64DD17)),
              child: const Text("Change", style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }

  void _showManageSessionsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text("Manage Sessions", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Active Sessions", style: TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              ..._sessions.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, String> session = entry.value;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFF64DD17).withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        session['device']!.contains('iPhone') ? Icons.phone_iphone : Icons.laptop,
                        color: const Color(0xFF64DD17),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(session['device']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            Text(session['location']!, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                            Text(session['date']!, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                          ],
                        ),
                      ),
                      if (index != 0)
                        GestureDetector(
                          onTap: () {
                            setState(() => _sessions.removeAt(index));
                            Navigator.pop(context);
                            _showManageSessionsDialog();
                          },
                          child: const Icon(Icons.close, color: Colors.red, size: 20),
                        ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() => _sessions.clear());
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("All sessions logged out"), backgroundColor: Color(0xFF64DD17)),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Logout All Sessions", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close", style: TextStyle(color: Color(0xFF64DD17))),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF64DD17),
        ),
      ),
    );
  }

  Widget _buildSettingOption({
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF64DD17)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(color: Colors.white70)) : null,
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildSwitchSetting({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF64DD17)),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: Color(0xFF64DD17),
      ),
    );
  }

  Widget _buildLanguageSelector() {
    Map<String, String> languages = {
      'en': '🇬🇧 English',
      'ar': '🇸🇦 العربية (Arabic)',
      'fr': '🇫🇷 Français (French)',
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Select Language",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        ...languages.entries.map((entry) => ListTile(
          title: Text(entry.value, style: const TextStyle(color: Colors.white)),
          trailing: _language == entry.key ? const Icon(Icons.check, color: Color(0xFF64DD17)) : null,
          onTap: () {
            setState(() => _language = entry.key);
            widget.onLanguageChange(entry.key);
            Navigator.pop(context);
          },
        )),
        const SizedBox(height: 20),
      ],
    );
  }
}

// =====================================================
// ORDERS PAGE
// =====================================================

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPaymentMethod = "Card";
  
  final List<Map<String, dynamic>> _currentOrders = [
    {
      "id": "ORD001",
      "name": "Tomato Plant Bundle",
      "quantity": 2,
      "price": 45.99,
      "status": "Processing",
      "image": "https://images.unsplash.com/photo-1592921870789-04563e271ab1?w=400",
      "date": "2026-03-15",
      "seller": "Green Garden Store",
      "weight": 5.0,
    },
    {
      "id": "ORD002",
      "name": "Mint Herb Pack",
      "quantity": 1,
      "price": 12.99,
      "status": "Shipped",
      "image": "https://images.unsplash.com/photo-1580809361436-42a7ec9b3dbb?w=400",
      "date": "2026-03-14",
      "seller": "Fresh Herbs Co",
      "weight": 0.5,
    },
  ];

  final List<Map<String, dynamic>> _pastOrders = [
    {
      "id": "ORD003",
      "name": "Rose Bush Set",
      "quantity": 1,
      "price": 59.99,
      "status": "Delivered",
      "image": "https://images.unsplash.com/photo-1563241527-3004b8f0a263?w=400",
      "date": "2026-03-01",
      "seller": "Flower Paradise",
      "weight": 3.0,
    },
    {
      "id": "ORD004",
      "name": "Succulent Collection",
      "quantity": 5,
      "price": 89.95,
      "status": "Delivered",
      "image": "https://images.unsplash.com/photo-1509207736528-cda5be79d074?w=400",
      "date": "2026-02-20",
      "seller": "Green Garden Store",
      "weight": 2.5,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  double _calculateTotalWeight(List<Map<String, dynamic>> orders) {
    return orders.fold(0, (sum, order) => sum + (order['weight'] ?? 0));
  }

  double _calculateShippingFee(double weight) {
    // Base fee + per kg fee
    double baseFee = 5.0;
    double perKgFee = 2.0;
    return baseFee + (weight * perKgFee);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text("My Orders", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF64DD17),
          tabs: const [
            Tab(text: "Active"),
            Tab(text: "Past"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrdersList(_currentOrders, isActive: true),
          _buildOrdersList(_pastOrders, isActive: false),
        ],
      ),
    );
  }

  Widget _buildOrdersList(List<Map<String, dynamic>> orders, {required bool isActive}) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            const Text("No orders yet", style: TextStyle(color: Colors.white70, fontSize: 16)),
          ],
        ),
      );
    }

    double totalWeight = _calculateTotalWeight(orders);
    double shippingFee = _calculateShippingFee(totalWeight);
    double totalPrice = orders.fold(0.0, (sum, order) => sum + (order['price'] ?? 0)) + shippingFee;

    return SingleChildScrollView(
      child: Column(
        children: [
          // Weight & Shipping Summary
          if (isActive)
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF64DD17).withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Total Weight", style: TextStyle(color: Colors.white70, fontSize: 12)),
                          Text("${totalWeight.toStringAsFixed(2)} kg", style: const TextStyle(color: Color(0xFF64DD17), fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("Shipping Fee", style: TextStyle(color: Colors.white70, fontSize: 12)),
                          Text("\$${shippingFee.toStringAsFixed(2)}", style: const TextStyle(color: Color(0xFF64DD17), fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Subtotal", style: TextStyle(color: Colors.white70)),
                        Text("\$${(totalPrice - shippingFee).toStringAsFixed(2)}", style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Total", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text("\$${totalPrice.toStringAsFixed(2)}", style: const TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Payment Method Selection
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFF64DD17).withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Payment Method", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _selectedPaymentMethod = "Card"),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: _selectedPaymentMethod == "Card" ? const Color(0xFF64DD17) : Colors.black.withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: _selectedPaymentMethod == "Card" ? const Color(0xFF64DD17) : Colors.grey.withValues(alpha: 0.2),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.credit_card, color: _selectedPaymentMethod == "Card" ? Colors.black : const Color(0xFF64DD17), size: 18),
                                      const SizedBox(width: 8),
                                      Text("Card", style: TextStyle(color: _selectedPaymentMethod == "Card" ? Colors.black : Colors.white, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => setState(() => _selectedPaymentMethod = "On Delivery"),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: _selectedPaymentMethod == "On Delivery" ? const Color(0xFF64DD17) : Colors.black.withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: _selectedPaymentMethod == "On Delivery" ? const Color(0xFF64DD17) : Colors.grey.withValues(alpha: 0.2),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.money, color: _selectedPaymentMethod == "On Delivery" ? Colors.black : const Color(0xFF64DD17), size: 18),
                                      const SizedBox(width: 8),
                                      Text("On Delivery", style: TextStyle(color: _selectedPaymentMethod == "On Delivery" ? Colors.black : Colors.white, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: const Color(0xFF1A1A1A),
                            title: const Text("Complete Payment", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Method: $_selectedPaymentMethod", style: const TextStyle(color: Colors.white)),
                                const SizedBox(height: 10),
                                Text("Total: \$${totalPrice.toStringAsFixed(2)}", style: const TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.bold, fontSize: 16)),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Payment completed via $_selectedPaymentMethod! ✓"),
                                      backgroundColor: const Color(0xFF64DD17),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF64DD17)),
                                child: const Text("Pay", style: TextStyle(color: Colors.black)),
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF64DD17),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text("Complete Payment", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),

          // Orders List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return _buildOrderCard(order, isActive);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, bool isActive) {
    Color statusColor = _getStatusColor(order["status"]);
    
    return GestureDetector(
      onTap: isActive ? () => _showOrderDetailsDialog(order) : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            // Order Header
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order #${order["id"]}",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        order["date"],
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: statusColor),
                    ),
                    child: Text(
                      order["status"],
                      style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            // Product & Weight Info
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
                  bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
                ),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      order["image"],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order["name"],
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Qty: ${order["quantity"]} × Weight: ${order['weight']} kg",
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        Text(
                          order["seller"],
                          style: const TextStyle(color: Color(0xFF64DD17), fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "\$${order["price"]}",
                        style: const TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      if (isActive)
                        const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDetails(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Text("Order #${order['id']}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(order['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text("Quantity: ${order['quantity']}", style: const TextStyle(color: Colors.white70)),
              Text("Weight: ${order['weight']} kg", style: const TextStyle(color: Colors.white70)),
              Text("Price: \$${order['price']}", style: const TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.bold)),
              Text("Date: ${order['date']}", style: const TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Status: ${order['status']}",
                  style: TextStyle(color: _getStatusColor(order['status']), fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close", style: TextStyle(color: Color(0xFF64DD17))),
          ),
        ],
      ),
    );
  }

  void _showOrderDetailsDialog(Map<String, dynamic> order) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF1A1A1A),
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.95,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order Details",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Product Image & Info
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(order["image"], width: double.infinity, height: 200, fit: BoxFit.cover),
                ),
                const SizedBox(height: 16),
                
                Text(
                  order["name"],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),

                _buildDetailRow("Quantity", "${order["quantity"]}"),
                _buildDetailRow("Unit Price", "\$${(order["price"] / order["quantity"]).toStringAsFixed(2)}"),
                _buildDetailRow("Total", "\$${order["price"].toStringAsFixed(2)}", isTotal: true),

                const SizedBox(height: 20),
                const Divider(color: Colors.grey),
                const SizedBox(height: 20),

                // Seller Info
                Text(
                  "Seller Information",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 12),
                _buildDetailRow("Seller", order["seller"]),

                const SizedBox(height: 20),
                const Divider(color: Colors.grey),
                const SizedBox(height: 20),

                // Shipping & Status
                Text(
                  "Order Status",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF64DD17).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF64DD17)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.local_shipping, color: Color(0xFF64DD17)),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order["status"],
                            style: const TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.bold),
                          ),
                          Text("Tracking: TRK-${order['id']}", style: const TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                _buildDetailRow("Order Date", order["date"]),
                _buildDetailRow("Shipping Address", "123 Garden Lane, Plant City, GD 12345"),

                const SizedBox(height: 20),
                const Divider(color: Colors.grey),
                const SizedBox(height: 20),

                // Action Buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF64DD17)),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Support ticket created")));
                      Navigator.pop(context);
                    },
                    child: const Text("Report Issue", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF64DD17)),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Return initiated")));
                      Navigator.pop(context);
                    },
                    child: const Text("Initiate Return", style: TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isTotal ? Color(0xFF64DD17) : Colors.white,
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Processing":
        return Colors.orange;
      case "Shipped":
        return Colors.blue;
      case "Delivered":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

// =====================================================
// SAVED PRODUCTS / WISHLIST PAGE
// =====================================================

class SavedProductsPage extends StatefulWidget {
  final Map<String, dynamic>? initialSavedProduct;

  const SavedProductsPage({super.key, this.initialSavedProduct});

  @override
  State<SavedProductsPage> createState() => _SavedProductsPageState();
}

class _SavedProductsPageState extends State<SavedProductsPage> {
  final List<Map<String, dynamic>> _allSavedProducts = [
    {
      "id": 1,
      "name": "Tomato Plant",
      "price": 15.99,
      "oldPrice": 22.99,
      "image": "https://images.unsplash.com/photo-1592921870789-04563e271ab1?w=400",
      "rating": 4.8,
      "category": "Vegetables",
      "seller": "Green Garden Store"
    },
    {
      "id": 2,
      "name": "Mint Herb",
      "price": 9.99,
      "oldPrice": 14.99,
      "image": "https://images.unsplash.com/photo-1580809361436-42a7ec9b3dbb?w=400",
      "rating": 4.9,
      "category": "Herbs",
      "seller": "Fresh Herbs Co"
    },
    {
      "id": 3,
      "name": "Rose Bush",
      "price": 24.99,
      "oldPrice": 34.99,
      "image": "https://images.unsplash.com/photo-1563241527-3004b8f0a263?w=400",
      "rating": 4.7,
      "category": "Flowers",
      "seller": "Flower Paradise"
    },
    {
      "id": 4,
      "name": "Succulent Pack",
      "price": 18.99,
      "oldPrice": 26.99,
      "image": "https://images.unsplash.com/photo-1509207736528-cda5be79d074?w=400",
      "rating": 4.6,
      "category": "Plants",
      "seller": "Green Garden Store"
    },
    {
      "id": 5,
      "name": "Lavender Plant",
      "price": 12.99,
      "oldPrice": 18.99,
      "image": "https://images.unsplash.com/photo-1490750967868-88aa4486c946?w=400",
      "rating": 4.5,
      "category": "Flowers",
      "seller": "Flower Paradise"
    },
    {
      "id": 6,
      "name": "Basil Leaf",
      "price": 8.99,
      "oldPrice": 12.99,
      "image": "https://images.unsplash.com/photo-1509222788887-1f89ae8b1589?w=400",
      "rating": 4.7,
      "category": "Herbs",
      "seller": "Fresh Herbs Co"
    },
  ];

  late TextEditingController _searchController;
  String _selectedCategory = "All";
  String _searchQuery = "";
  final List<int> _selectedProductIds = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    final injectedItem = widget.initialSavedProduct;
    if (injectedItem != null) {
      final exists = _allSavedProducts.any((p) => p['name'] == injectedItem['name']);
      if (!exists) {
        _allSavedProducts.insert(0, injectedItem);
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  get _filteredProducts {
    List<Map<String, dynamic>> filtered = _allSavedProducts;

    // Filter by category
    if (_selectedCategory != "All") {
      filtered = filtered.where((p) => p["category"] == _selectedCategory).toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((p) => 
        p["name"].toLowerCase().contains(_searchQuery.toLowerCase()) ||
        p["seller"].toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

    return filtered;
  }

  void _toggleProductSelection(int productId) {
    setState(() {
      if (_selectedProductIds.contains(productId)) {
        _selectedProductIds.remove(productId);
      } else {
        _selectedProductIds.add(productId);
      }
    });
  }

  void _addSelectedToOrders() {
    if (_selectedProductIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select products to add to orders")),
      );
      return;
    }

    List<Map<String, dynamic>> selectedProducts = _allSavedProducts
      .where((p) => _selectedProductIds.contains(p["id"]))
      .toList();

    _showBulkAddDialog(selectedProducts);
  }

  void _showBulkAddDialog(List<Map<String, dynamic>> products) {
    Map<int, int> quantities = {};
    for (var product in products) {
      quantities[product["id"]] = 1;
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: Color(0xFF1A1A1A),
          title: const Text("Add to Orders", style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: products.map((product) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        product["name"],
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (quantities[product["id"]]! > 1) {
                                  quantities[product["id"]] = quantities[product["id"]]! - 1;
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF64DD17)),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(Icons.remove, size: 16, color: Color(0xFF64DD17)),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${quantities[product["id"]]}x",
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantities[product["id"]] = quantities[product["id"]]! + 1;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF64DD17)),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(Icons.add, size: 16, color: Color(0xFF64DD17)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Color(0xFF64DD17))),
            ),
            TextButton(
              onPressed: () {
                setState(() => _selectedProductIds.clear());
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${products.length} product(s) added to orders! 🛒"),
                    backgroundColor: Color(0xFF64DD17),
                  ),
                );
              },
              child: const Text("Add", style: TextStyle(color: Colors.green)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFF1A1A1A),
        title: const Text("Saved Products", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (_selectedProductIds.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF64DD17),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GestureDetector(
                    onTap: _addSelectedToOrders,
                    child: Text(
                      "Add ${_selectedProductIds.length}",
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                  ),
                ),
              ),
            ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const Text("Remove All"),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Color(0xFF1A1A1A),
                      title: const Text("Remove All", style: TextStyle(color: Colors.white)),
                      content: const Text("Remove all saved products?", style: TextStyle(color: Colors.white70)),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel", style: TextStyle(color: Color(0xFF64DD17))),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() => _allSavedProducts.clear());
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("All products removed")),
                            );
                          },
                          child: const Text("Remove", style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
              ),
              PopupMenuItem(
                child: const Text("Share Wishlist"),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Wishlist link copied! 🔗")),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      body: _allSavedProducts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    "No Saved Products",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Save your favorite products to purchase them later",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF64DD17)),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Continue Shopping", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      setState(() => _searchQuery = value);
                    },
                    decoration: InputDecoration(
                      hintText: "Search products or sellers...",
                      hintStyle: const TextStyle(color: Colors.white54),
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF64DD17)),
                      suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close, color: Colors.white54),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = "");
                            },
                          )
                        : null,
                      filled: true,
                      fillColor: Color(0xFF1A1A1A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
                      ),
                    ),
                  ),
                ),

                // Category Filter
                SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    children: ["All", "Vegetables", "Herbs", "Flowers", "Plants"]
                        .map(
                          (category) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Text(category),
                              selected: _selectedCategory == category,
                              onSelected: (selected) {
                                setState(() => _selectedCategory = category);
                              },
                              backgroundColor: Color(0xFF1A1A1A),
                              selectedColor: Color(0xFF64DD17),
                              labelStyle: TextStyle(
                                color: _selectedCategory == category ? Colors.black : Colors.white70,
                              ),
                              side: BorderSide(
                                color: _selectedCategory == category ? Colors.transparent : Colors.grey.withValues(alpha: 0.2),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),

                // Search Results/Empty State
                if (_filteredProducts.isEmpty)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 64, color: Colors.grey),
                          const SizedBox(height: 16),
                          const Text(
                            "No products found",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Try adjusting your search or category filter",
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  // Products Grid
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        return _buildProductCard(product);
                      },
                    ),
                  ),
              ],
            ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    bool isSelected = _selectedProductIds.contains(product["id"]);
    
    return GestureDetector(
      onLongPress: () => _toggleProductSelection(product["id"]),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Color(0xFF64DD17) : Colors.grey.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      product["image"],
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Selection Checkbox
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => _toggleProductSelection(product["id"]),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? Color(0xFF64DD17) : Colors.black.withValues(alpha: 0.6),
                          border: Border.all(color: Color(0xFF64DD17)),
                        ),
                        child: isSelected
                          ? const Icon(Icons.check, color: Colors.black, size: 14)
                          : null,
                      ),
                    ),
                  ),
                  // Rating Badge
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Color(0xFF64DD17)),
                          const SizedBox(width: 4),
                          Text(
                            product["rating"].toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Remove Button
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _allSavedProducts.removeWhere((p) => p["id"] == product["id"]));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Removed from wishlist 💔")),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, color: Colors.white, size: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Info
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product["name"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "\$${product["price"].toStringAsFixed(2)}",
                        style: const TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "\$${product["oldPrice"].toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF64DD17)),
                            padding: const EdgeInsets.symmetric(vertical: 6),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${product["name"]} added to cart! 🛒")),
                            );
                          },
                          child: const Text("Cart", style: TextStyle(fontSize: 11, color: Color(0xFF64DD17))),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF64DD17),
                            padding: const EdgeInsets.symmetric(vertical: 6),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${product["name"]} ready to buy! ✨")),
                            );
                          },
                          child: const Text("Buy", style: TextStyle(fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final String currentLanguage;
  final Function(String) onLanguageChange;
  final Function(bool) onThemeChange;
  final bool isDarkMode;

  const ProfilePage({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChange,
    required this.onThemeChange,
    required this.isDarkMode,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _bioController;
  late TextEditingController _regionController;
  late TextEditingController _farmSizeController;
  late TextEditingController _cropsController;
  
  // Profile State Management
  final String _defaultProfileImage = 'https://via.placeholder.com/200/4CAF50/FFFFFF?text=Smart+Farmer';
  File? _profileImageFile;
  bool _isEditingProfile = false;
  bool _isEditingFarm = false;
  final String _userRole = 'Professional Farmer';
  final String _userBadge = 'Expert Farmer';
  int _profileCompletion = 85;
  String _selectedLanguage = 'en';
  String _selectedSoilType = 'Loamy Soil';
  final List<String> _selectedCrops = ['Wheat', 'Barley'];
  
  // Activity Data
  final int _diagnosesCount = 24;
  final int _marketplaceListings = 12;
  int _favoriteItems = 8;
  bool _storySeen = false;
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _profilePosts = [
    {
      'image': 'https://images.unsplash.com/photo-1464226184884-fa280b87c399?w=900&q=80',
      'caption': 'Irrigation setup update for spring crops 💧',
      'likes': 312,
      'comments': 46,
      'liked': false,
      'saved': false,
      'shares': 18,
      'commentList': <Map<String, String>>[
        {'user': 'Nabt Team', 'text': 'Great setup, very efficient!'},
      ],
    },
    {
      'image': 'https://images.unsplash.com/photo-1471193945509-9ad0617afabf?w=900&q=80',
      'caption': 'Healthy wheat field this season 🌾',
      'likes': 441,
      'comments': 63,
      'liked': false,
      'saved': false,
      'shares': 24,
      'commentList': <Map<String, String>>[
        {'user': 'Farmer Karim', 'text': 'Mashallah, very healthy crops.'},
      ],
    },
    {
      'image': 'https://images.unsplash.com/photo-1457530378978-8bac673b8062?w=900&q=80',
      'caption': 'Organic soil mix gives better roots ✅',
      'likes': 276,
      'comments': 35,
      'liked': false,
      'saved': false,
      'shares': 11,
      'commentList': <Map<String, String>>[],
    },
    {
      'image': 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=900&q=80',
      'caption': 'Farm daily check with smart notes 📒',
      'likes': 214,
      'comments': 28,
      'liked': false,
      'saved': false,
      'shares': 7,
      'commentList': <Map<String, String>>[],
    },
    {
      'image': 'https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?w=900&q=80',
      'caption': 'Plant care routine for this week 🌱',
      'likes': 389,
      'comments': 51,
      'liked': false,
      'saved': false,
      'shares': 15,
      'commentList': <Map<String, String>>[],
    },
    {
      'image': 'https://images.unsplash.com/photo-1444858291040-58f756a3bdd6?w=900&q=80',
      'caption': 'Preparing land for next harvest.',
      'likes': 175,
      'comments': 19,
      'liked': false,
      'saved': false,
      'shares': 5,
      'commentList': <Map<String, String>>[],
    },
  ];

  final List<Map<String, dynamic>> _profileProducts = [
    {
      'name': 'Olive Seedling Pack',
      'category': 'Plants',
      'image': 'https://images.unsplash.com/photo-1592419044706-39796d40f98c?w=1000&q=80',
      'price': '3200 DZD',
      'agroInfo': 'Watering: Moderate • Sunlight: Full Sun • Soil: Loamy',
    },
    {
      'name': 'Drip Irrigation Kit',
      'category': 'Irrigation',
      'image': 'https://images.unsplash.com/photo-1464226184884-fa280b87c399?w=1000&q=80',
      'price': '4800 DZD',
      'agroInfo': 'Watering: N/A • Sunlight: N/A • Soil: N/A',
    },
    {
      'name': 'Organic Compost Bag',
      'category': 'Fertilizers',
      'image': 'https://images.unsplash.com/photo-1457530378978-8bac673b8062?w=1000&q=80',
      'price': '1400 DZD',
      'agroInfo': 'Use: Every 2 weeks • Soil: All types',
    },
    {
      'name': 'Treatment Set',
      'category': 'Treatment',
      'image': 'https://images.unsplash.com/photo-1471193945509-9ad0617afabf?w=1000&q=80',
      'price': '2600 DZD',
      'agroInfo': 'Use after diagnosis • Follow label instructions',
    },
  ];
  
  // Form Validation States
  final Map<String, bool> _fieldErrors = {};
  final Map<String, String> _fieldErrorMessages = {};
  bool _isFormLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _profileImageFile = null;
    _nameController = TextEditingController(text: 'chemali rahma ');
    _emailController = TextEditingController(text: 'chemali.rahma@smartfarming.com');
    _phoneController = TextEditingController(text: '+213 (0) 555 123-456');
    _bioController = TextEditingController(text: 'Passionate about sustainable agriculture and organic farming practices');
    _regionController = TextEditingController(text: 'Bordj bou arreriedj Region, Algeria');
    _farmSizeController = TextEditingController(text: '25 hectares');
    _cropsController = TextEditingController(text: 'Wheat, Barley, Lentils');
    
    _selectedLanguage = widget.currentLanguage;
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    _regionController.dispose();
    _farmSizeController.dispose();
    _cropsController.dispose();
    super.dispose();
  }

  // Validation Methods
  bool _validateForm(bool isProfile) {
    _fieldErrors.clear();
    _fieldErrorMessages.clear();
    
    if (isProfile) {
      if (_nameController.text.isEmpty) {
        _fieldErrors['name'] = true;
        _fieldErrorMessages['name'] = 'Name is required';
      }
      if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
        _fieldErrors['email'] = true;
        _fieldErrorMessages['email'] = 'Valid email required';
      }
      if (_phoneController.text.isEmpty || _phoneController.text.length < 10) {
        _fieldErrors['phone'] = true;
        _fieldErrorMessages['phone'] = 'Valid phone required';
      }
    } else {
      if (_farmSizeController.text.isEmpty) {
        _fieldErrors['farmSize'] = true;
        _fieldErrorMessages['farmSize'] = 'Farm size is required';
      }
    }
    
    return _fieldErrors.isEmpty;
  }

  void _saveProfileInfo() async {
    if (!_validateForm(true)) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors'), backgroundColor: Colors.red),
      );
      return;
    }
    
    setState(() => _isFormLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      _isFormLoading = false;
      _isEditingProfile = false;
      _profileCompletion = 95;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated successfully!'), backgroundColor: Color(0xFF4CAF50)),
    );
  }

  void _saveFarmInfo() async {
    if (!_validateForm(false)) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fix the errors'), backgroundColor: Colors.red),
      );
      return;
    }
    
    setState(() => _isFormLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      _isFormLoading = false;
      _isEditingFarm = false;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Farm information updated!'), backgroundColor: Color(0xFF4CAF50)),
    );
  }

  void _changeProfilePicture() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text('Change Profile Picture', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF4CAF50)),
              title: const Text('Take a Photo', style: TextStyle(color: Colors.white)),
              onTap: () async {
                Navigator.pop(context);
                await _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image, color: Color(0xFF4CAF50)),
              title: const Text('Choose from Gallery', style: TextStyle(color: Colors.white)),
              onTap: () async {
                Navigator.pop(context);
                await _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        setState(() {
          _profileImageFile = File(pickedFile.path);
        });
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('✓ Profile picture updated successfully!'),
              backgroundColor: Color(0xFF4CAF50),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _toggleMainProfilePostLike(Map<String, dynamic> post) {
    setState(() {
      final liked = (post['liked'] as bool?) ?? false;
      post['liked'] = !liked;
      post['likes'] = ((post['likes'] as int?) ?? 0) + (liked ? -1 : 1);
    });
  }

  void _toggleMainProfilePostSaved(Map<String, dynamic> post) {
    setState(() {
      final saved = (post['saved'] as bool?) ?? false;
      post['saved'] = !saved;
      _favoriteItems += saved ? -1 : 1;
      if (_favoriteItems < 0) _favoriteItems = 0;
    });
  }

  void _shareMainProfilePost(Map<String, dynamic> post) {
    setState(() {
      post['shares'] = ((post['shares'] as int?) ?? 0) + 1;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post shared successfully'), backgroundColor: Color(0xFF31D6FF)),
    );
  }

  void _openMainProfileCommentSheet(Map<String, dynamic> post) {
    final TextEditingController commentController = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF151D23),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) {
          final comments = (post['commentList'] as List<dynamic>);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Comments', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: Colors.white54)),
                  ],
                ),
              ),
              Divider(color: Colors.white24, height: 1),
              Expanded(
                child: comments.isEmpty
                    ? const Center(child: Text('No comments yet', style: TextStyle(color: Colors.white54)))
                    : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.all(12),
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          final comment = Map<String, dynamic>.from(comments[index] as Map);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(radius: 14, backgroundColor: Color(0xFF31D6FF), child: Icon(Icons.person, size: 13, color: Colors.black)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(color: const Color(0xFF0F151A), borderRadius: BorderRadius.circular(10)),
                                    child: RichText(
                                      text: TextSpan(
                                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                                        children: [
                                          TextSpan(text: '${comment['user']}: ', style: const TextStyle(color: Color(0xFF2DE091), fontWeight: FontWeight.w600)),
                                          TextSpan(text: (comment['text'] ?? '').toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 12, right: 12, top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: commentController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Write a comment...',
                          hintStyle: const TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: const Color(0xFF0F151A),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: Colors.white24),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(color: Colors.white24),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        final text = commentController.text.trim();
                        if (text.isEmpty) return;
                        setState(() {
                          comments.insert(0, {'user': 'You', 'text': text});
                          post['comments'] = ((post['comments'] as int?) ?? 0) + 1;
                        });
                        commentController.clear();
                      },
                      icon: const Icon(Icons.send_rounded, color: Color(0xFF2DE091)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12181D),
        title: Text(
          _nameController.text.trim().toLowerCase().replaceAll(' ', '.'),
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined, color: Color(0xFF2DE091)),
            tooltip: 'Create post/product',
            onPressed: _showCreateContentSheet,
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            color: const Color(0xFF12181D),
            onSelected: (value) {
              if (value == 'farm') {
                _showFarmInfoModal();
              } else if (value == 'activity') {
                _showActivityReviewModal();
              } else if (value == 'settings') {
                _showSettingsModal();
              } else if (value == 'logout') {
                _showLogoutConfirmation();
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'farm',
                child: Row(
                  children: [
                    Icon(Icons.agriculture_rounded, color: Color(0xFF2DE091), size: 20),
                    SizedBox(width: 10),
                    Text('Farm Information', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'activity',
                child: Row(
                  children: [
                    Icon(Icons.insights_rounded, color: Color(0xFF31D6FF), size: 20),
                    SizedBox(width: 10),
                    Text('Activity Review', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings_rounded, color: Colors.white70, size: 20),
                    SizedBox(width: 10),
                    Text('Settings & Preferences', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout_rounded, color: Colors.redAccent, size: 20),
                    SizedBox(width: 10),
                    Text('Log Out', style: TextStyle(color: Colors.redAccent)),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _storySeen = !_storySeen),
                  child: Container(
                    width: 96,
                    height: 96,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: !_storySeen
                          ? const LinearGradient(
                              colors: [Color(0xFFE1306C), Color(0xFFF77737), Color(0xFFFCAF45)],
                            )
                          : null,
                      color: _storySeen ? Colors.white24 : null,
                    ),
                    child: GestureDetector(
                      onTap: _changeProfilePicture,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: [Color(0xFF2DE091), Color(0xFF31D6FF)]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: ClipOval(
                            child: _profileImageFile != null && _profileImageFile!.existsSync()
                                ? Image.file(_profileImageFile!, fit: BoxFit.cover)
                                : Image.network(_defaultProfileImage, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildInstaStatColumn(_diagnosesCount.toString(), 'Diagnoses'),
                      _buildInstaStatColumn(_marketplaceListings.toString(), 'Listings'),
                      _buildInstaStatColumn(_favoriteItems.toString(), 'Favorites'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(_nameController.text.trim(), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(_userBadge, style: const TextStyle(color: Color(0xFF2DE091), fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(_bioController.text, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 4),
            Row(
              children: const [
                Icon(Icons.verified, size: 14, color: Color(0xFF31D6FF)),
                SizedBox(width: 4),
                Text('Verified Farmer Account', style: TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color(0xFF151D23),
                border: Border.all(color: Colors.white24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📍 ${_regionController.text}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 3),
                  Text('📞 ${_phoneController.text}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 3),
                  Text('🌾 Farm: ${_farmSizeController.text}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showEditProfileModal,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2DE091),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                icon: const Icon(Icons.edit_outlined, size: 18),
                label: const Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF151D23),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _profileTabButton(
                      icon: Icons.grid_on,
                      label: 'Posts',
                      selected: _selectedTab == 0,
                      onTap: () => setState(() => _selectedTab = 0),
                    ),
                  ),
                  Expanded(
                    child: _profileTabButton(
                      icon: Icons.view_stream_outlined,
                      label: 'Feed',
                      selected: _selectedTab == 1,
                      onTap: () => setState(() => _selectedTab = 1),
                    ),
                  ),
                  Expanded(
                    child: _profileTabButton(
                      icon: Icons.sell_outlined,
                      label: 'Products',
                      selected: _selectedTab == 2,
                      onTap: () => setState(() => _selectedTab = 2),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (_selectedTab == 0)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _profilePosts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final post = _profilePosts[index];
                  return GestureDetector(
                    onTap: () => _toggleMainProfilePostLike(post),
                    onLongPress: () => _toggleMainProfilePostSaved(post),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _buildProfileImageFromSource(
                          (post['image'] as String),
                          fit: BoxFit.cover,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        Positioned(
                          left: 4,
                          right: 4,
                          bottom: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.45),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  (post['liked'] as bool?) == true ? Icons.favorite : Icons.favorite_border,
                                  size: 12,
                                  color: (post['liked'] as bool?) == true ? Colors.redAccent : Colors.white70,
                                ),
                                const SizedBox(width: 3),
                                Text('${post['likes']}', style: const TextStyle(color: Colors.white, fontSize: 10)),
                                const Spacer(),
                                Icon(
                                  (post['saved'] as bool?) == true ? Icons.bookmark : Icons.bookmark_border,
                                  size: 12,
                                  color: (post['saved'] as bool?) == true ? const Color(0xFF2DE091) : Colors.white70,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            else if (_selectedTab == 1)
              Column(
                children: List.generate(_profilePosts.length, (index) {
                  final post = _profilePosts[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF151D23),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                          child: _buildProfileImageFromSource(
                            (post['image'] as String),
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(post['caption'] as String, style: const TextStyle(color: Colors.white70)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () => _toggleMainProfilePostLike(post),
                                    child: Icon(
                                      (post['liked'] as bool?) == true ? Icons.favorite : Icons.favorite_border,
                                      color: (post['liked'] as bool?) == true ? Colors.redAccent : Colors.white70,
                                      size: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text('${post['likes']}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                  const SizedBox(width: 14),
                                  GestureDetector(
                                    onTap: () => _openMainProfileCommentSheet(post),
                                    child: const Icon(Icons.mode_comment_outlined, color: Colors.white70, size: 18),
                                  ),
                                  const SizedBox(width: 4),
                                  Text('${post['comments']}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                  const SizedBox(width: 14),
                                  GestureDetector(
                                    onTap: () => _toggleMainProfilePostSaved(post),
                                    child: Icon(
                                      (post['saved'] as bool?) == true ? Icons.bookmark : Icons.bookmark_border,
                                      color: (post['saved'] as bool?) == true ? const Color(0xFF2DE091) : Colors.white70,
                                      size: 18,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () => _shareMainProfilePost(post),
                                    child: const Icon(Icons.share_outlined, color: Colors.white70, size: 18),
                                  ),
                                  const SizedBox(width: 4),
                                  Text('${post['shares']}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _profileProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 208,
                ),
                itemBuilder: (context, index) {
                  final product = _profileProducts[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NabtProductDetailsPage(
                            product: {
                              'name': (product['name'] ?? 'Product').toString(),
                              'category': (product['category'] ?? 'Category').toString(),
                              'image': (product['image'] ?? '').toString(),
                              'price': (product['price'] ?? '').toString(),
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF151D23),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: _buildProfileImageFromSource(
                              (product['image'] ?? '').toString(),
                              height: 112,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 7, 8, 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 3),
                                Text((product['category'] ?? '').toString(), style: const TextStyle(color: Colors.white60, fontSize: 11)),
                                const SizedBox(height: 2),
                                Text((product['price'] ?? '').toString(), style: const TextStyle(color: Color(0xFF2DE091), fontSize: 11, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 3),
                                const Text('Tap to view', style: TextStyle(color: Color(0xFF2DE091), fontWeight: FontWeight.bold, fontSize: 11)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _profileTabButton({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selected ? const Color(0xFF2DE091).withValues(alpha: 0.2) : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: selected ? const Color(0xFF2DE091) : Colors.white54, size: 18),
            const SizedBox(height: 3),
            Text(label, style: TextStyle(color: selected ? const Color(0xFF2DE091) : Colors.white60, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Future<String?> _pickLocalImagePath() async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 90);
      return picked?.path;
    } catch (_) {
      return null;
    }
  }

  Widget _buildProfileImageFromSource(
    String source, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
  }) {
    final imageWidget = source.startsWith('http')
        ? Image.network(source, width: width, height: height, fit: fit)
        : Image.file(File(source), width: width, height: height, fit: fit);

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius, child: imageWidget);
    }
    return imageWidget;
  }

  void _showCreateContentSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF12181D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Create', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 14),
                _createChoiceTile(
                  icon: Icons.post_add_rounded,
                  title: 'New Feed Post',
                  subtitle: 'Photo + description (Instagram style)',
                  onTap: () {
                    Navigator.pop(context);
                    _showCreateFeedPostSheet();
                  },
                ),
                const SizedBox(height: 10),
                _createChoiceTile(
                  icon: Icons.sell_rounded,
                  title: 'New Product for Sell',
                  subtitle: 'Price + agro information + optional market share',
                  onTap: () {
                    Navigator.pop(context);
                    _showCreateProductSheet();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _createChoiceTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF151D23),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF2DE091).withValues(alpha: 0.2),
              child: Icon(icon, color: const Color(0xFF2DE091), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(color: Colors.white60, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white54, size: 16),
          ],
        ),
      ),
    );
  }

  void _showCreateFeedPostSheet() {
    final captionController = TextEditingController();
    String? selectedImagePath;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF12181D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('New Feed Post', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final path = await _pickLocalImagePath();
                          if (path != null) {
                            setModalState(() => selectedImagePath = path);
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF2DE091)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        icon: const Icon(Icons.photo_library_outlined, color: Color(0xFF2DE091)),
                        label: Text(
                          selectedImagePath == null ? 'Select image from library' : 'Image selected ✓',
                          style: const TextStyle(color: Color(0xFF2DE091)),
                        ),
                      ),
                    ),
                    if (selectedImagePath != null) ...[
                      const SizedBox(height: 10),
                      _buildProfileImageFromSource(
                        selectedImagePath!,
                        width: double.infinity,
                        height: 150,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ],
                    const SizedBox(height: 10),
                    TextField(
                      controller: captionController,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: const TextStyle(color: Colors.white70),
                        hintText: 'Write your post description...',
                        hintStyle: const TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: const Color(0xFF0F151A),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.white24),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final image = selectedImagePath ?? 'https://images.unsplash.com/photo-1464226184884-fa280b87c399?w=900&q=80';
                          final caption = captionController.text.trim().isEmpty
                              ? 'New post from my farm 🌱'
                              : captionController.text.trim();
                          setState(() {
                            _profilePosts.insert(0, {
                              'image': image,
                              'caption': caption,
                              'likes': 0,
                              'comments': 0,
                            });
                            _selectedTab = 1;
                          });
                          Navigator.pop(context);
                          ScaffoldMessenger.of(this.context).showSnackBar(
                            const SnackBar(content: Text('Feed post published successfully')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2DE091),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        icon: const Icon(Icons.publish_rounded),
                        label: const Text('Publish Post'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      captionController.dispose();
    });
  }

  void _showCreateProductSheet() {
    final nameController = TextEditingController();
    final categoryController = TextEditingController(text: 'Vegetables');
    final priceController = TextEditingController();
    final agroController = TextEditingController();
    bool shareToMarket = true;
    String? selectedImagePath;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF12181D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('New Product for Sell', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final path = await _pickLocalImagePath();
                          if (path != null) {
                            setModalState(() => selectedImagePath = path);
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF2DE091)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        icon: const Icon(Icons.photo_library_outlined, color: Color(0xFF2DE091)),
                        label: Text(
                          selectedImagePath == null ? 'Select product image from library' : 'Image selected ✓',
                          style: const TextStyle(color: Color(0xFF2DE091)),
                        ),
                      ),
                    ),
                    if (selectedImagePath != null) ...[
                      const SizedBox(height: 10),
                      _buildProfileImageFromSource(
                        selectedImagePath!,
                        width: double.infinity,
                        height: 150,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ],
                    const SizedBox(height: 10),
                    _buildCreateField(controller: nameController, label: 'Product Name', hint: 'e.g. Premium Tomato Seedling'),
                    const SizedBox(height: 10),
                    _buildCreateField(controller: categoryController, label: 'Category', hint: 'Vegetables / Fruits / Herbs / ...'),
                    const SizedBox(height: 10),
                    _buildCreateField(controller: priceController, label: 'Price (DZD)', hint: 'e.g. 2400'),
                    const SizedBox(height: 10),
                    _buildCreateField(
                      controller: agroController,
                      label: 'Agro Information',
                      hint: 'Watering, sunlight, soil...',
                      maxLines: 3,
                    ),
                    const SizedBox(height: 8),
                    SwitchListTile(
                      value: shareToMarket,
                      onChanged: (value) => setModalState(() => shareToMarket = value),
                      activeColor: const Color(0xFF2DE091),
                      title: const Text('Share also in Market page', style: TextStyle(color: Colors.white)),
                      subtitle: const Text('If enabled, it appears in Market category grid', style: TextStyle(color: Colors.white60, fontSize: 12)),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final name = nameController.text.trim();
                          if (name.isEmpty) {
                            ScaffoldMessenger.of(this.context).showSnackBar(
                              const SnackBar(content: Text('Product name is required')),
                            );
                            return;
                          }
                          final category = categoryController.text.trim().isEmpty ? 'Vegetables' : categoryController.text.trim();
                            final image = selectedImagePath ?? 'https://images.unsplash.com/photo-1464226184884-fa280b87c399?w=1000&q=80';
                          final rawPrice = priceController.text.trim().isEmpty ? '0' : priceController.text.trim();
                          final priceLabel = rawPrice.contains('DZD') ? rawPrice : '$rawPrice DZD';
                          final agroInfo = agroController.text.trim().isEmpty
                              ? 'Watering: Moderate • Sunlight: Full Sun • Soil: Loamy'
                              : agroController.text.trim();

                          final createdProduct = {
                            'name': name,
                            'category': category,
                            'image': image,
                            'price': priceLabel,
                            'agroInfo': agroInfo,
                          };

                          setState(() {
                            _profileProducts.insert(0, createdProduct);
                            _selectedTab = 2;
                          });

                          if (shareToMarket) {
                            NabtMarketStore.addSharedProduct(createdProduct);
                          }

                          Navigator.pop(context);
                          ScaffoldMessenger.of(this.context).showSnackBar(
                            SnackBar(
                              content: Text(
                                shareToMarket
                                    ? 'Product posted and shared to Market successfully'
                                    : 'Product posted successfully',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2DE091),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        icon: const Icon(Icons.publish_rounded),
                        label: const Text('Publish Product'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      nameController.dispose();
      categoryController.dispose();
      priceController.dispose();
      agroController.dispose();
    });
  }

  Widget _buildCreateField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: const Color(0xFF0F151A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white24),
        ),
      ),
    );
  }

  // New Methods
  void _showEditProfileModal() {
    setState(() { _isEditingProfile = true; });
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0A0A0A),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: _buildSectionHeader('Edit User Information', isEditing: true),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: _buildProfileEditForm(),
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(() {
      setState(() { _isEditingProfile = false; });
    });
  }

  void _showFarmInfoModal() {
    setState(() { _isEditingFarm = false; });
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0A0A0A),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
               mainAxisSize: MainAxisSize.min,
               children: [
                 Padding(
                   padding: const EdgeInsets.all(16),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       const Text('Farm Information', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                       IconButton(
                         icon: Icon(_isEditingFarm ? Icons.close : Icons.edit, color: const Color(0xFF4CAF50)),
                         onPressed: () {
                           setModalState(() { _isEditingFarm = !_isEditingFarm; });
                           setState(() { _isEditingFarm = _isEditingFarm; });
                         },
                       )
                     ]
                   )
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                   child: _isEditingFarm ? _buildFarmEditForm() : _buildFarmViewCard(),
                 ),
                 const SizedBox(height: 20),
               ]
            )
          )
        )
      )
    ).whenComplete(() {
      setState(() { _isEditingFarm = false; });
    });
  }

  void _showActivityReviewModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0A0A0A),
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Activity Review', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildActivityCard(
                      '🔍 Diagnoses',
                      _diagnosesCount.toString(),
                      const Color(0xFF2196F3),
                      () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActivityCard(
                      '🏪 Marketplace',
                      _marketplaceListings.toString(),
                      const Color(0xFFFF9800),
                      () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActivityCard(
                      '❤️ Favorites',
                      _favoriteItems.toString(),
                      const Color(0xFFE91E63),
                      () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _showSettingsModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0A0A0A),
      isScrollControlled: true,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Settings & Preferences', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _buildSettingsTile('🔔 Notifications', 'Manage alerts', () {}),
              _buildSettingsTile('🌍 Language', _getLanguageName(_selectedLanguage), () {
                Navigator.pop(context);
                _showLanguageSelector();
              }),
              _buildSettingsTile('🔒 Security', 'Password & 2FA', () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecuritySettingsPage()),
                );
              }),
              _buildSettingsTile('⚙️ Account Settings', 'Edit preferences', () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AccountSettingsPage()),
                );
              }),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstaStatColumn(String count, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(count, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 13)),
      ],
    );
  }

  // Build Methods
  Widget _buildSectionHeader(String title, {bool isEditing = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        if (!_isFormLoading)
          GestureDetector(
            onTap: () {
              setState(() {
                if (title.contains('User')) {
                  _isEditingProfile = !_isEditingProfile;
                } else if (title.contains('Farm')) {
                  _isEditingFarm = !_isEditingFarm;
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                isEditing ? Icons.close : Icons.edit,
                color: const Color(0xFF4CAF50),
                size: 18,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildProfileViewCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          _buildInfoRow(Icons.person, 'Full Name', _nameController.text),
          const Divider(color: Color(0xFF2A2A2A), height: 20),
          _buildInfoRow(Icons.email, 'Email', _emailController.text),
          const Divider(color: Color(0xFF2A2A2A), height: 20),
          _buildInfoRow(Icons.phone, 'Phone', _phoneController.text),
          const Divider(color: Color(0xFF2A2A2A), height: 20),
          _buildInfoRow(Icons.location_on, 'Location', _regionController.text),
          const Divider(color: Color(0xFF2A2A2A), height: 20),
          _buildInfoRow(Icons.description, 'Bio', _bioController.text),
        ],
      ),
    );
  }

  Widget _buildProfileEditForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          _buildEditableTextField(
            controller: _nameController,
            label: 'Full Name',
            icon: Icons.person,
            hasError: _fieldErrors['name'] ?? false,
            errorMessage: _fieldErrorMessages['name'],
          ),
          const SizedBox(height: 12),
          _buildEditableTextField(
            controller: _emailController,
            label: 'Email Address',
            icon: Icons.email,
            hasError: _fieldErrors['email'] ?? false,
            errorMessage: _fieldErrorMessages['email'],
          ),
          const SizedBox(height: 12),
          _buildEditableTextField(
            controller: _phoneController,
            label: 'Phone Number',
            icon: Icons.phone,
            hasError: _fieldErrors['phone'] ?? false,
            errorMessage: _fieldErrorMessages['phone'],
          ),
          const SizedBox(height: 12),
          _buildEditableTextField(
            controller: _regionController,
            label: 'Location',
            icon: Icons.location_on,
          ),
          const SizedBox(height: 12),
          _buildEditableTextField(
            controller: _bioController,
            label: 'Bio',
            icon: Icons.description,
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => setState(() => _isEditingProfile = false),
                child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(width: 12),
              if (_isFormLoading)
                const SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: null,
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color(0xFF4CAF50))),
                    child: SizedBox(
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                    ),
                  ),
                )
              else
                ElevatedButton(
                  onPressed: _saveProfileInfo,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)),
                  child: const Text('Save Changes', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFarmViewCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          _buildInfoRow(Icons.landscape, 'Farm Size', _farmSizeController.text),
          const Divider(color: Color(0xFF2A2A2A), height: 20),
          _buildInfoRow(Icons.grass, 'Soil Type', _selectedSoilType),
          const Divider(color: Color(0xFF2A2A2A), height: 20),
          _buildInfoRow(Icons.agriculture, 'Crops', _selectedCrops.join(', ')),
        ],
      ),
    );
  }

  Widget _buildFarmEditForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          _buildEditableTextField(
            controller: _farmSizeController,
            label: 'Farm Size (hectares)',
            icon: Icons.landscape,
            hasError: _fieldErrors['farmSize'] ?? false,
            errorMessage: _fieldErrorMessages['farmSize'],
          ),
          const SizedBox(height: 12),
          _buildDropdownField(
            label: 'Soil Type',
            icon: Icons.grass,
            value: _selectedSoilType,
            items: ['Loamy Soil', 'Sandy Soil', 'Clay Soil', 'Silty Soil', 'Peaty Soil'],
            onChanged: (value) => setState(() => _selectedSoilType = value ?? 'Loamy Soil'),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => setState(() => _isEditingFarm = false),
                child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
              ),
              const SizedBox(width: 12),
              if (_isFormLoading)
                const SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: null,
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color(0xFF4CAF50))),
                    child: SizedBox(
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                    ),
                  ),
                )
              else
                ElevatedButton(
                  onPressed: _saveFarmInfo,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)),
                  child: const Text('Save Farm Info', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditableTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool hasError = false,
    String? errorMessage,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: hasError ? Colors.red : const Color(0xFF4CAF50)),
            prefixIcon: Icon(icon, color: const Color(0xFF4CAF50)),
            filled: true,
            fillColor: const Color(0xFF2A2A2A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: hasError ? Colors.red : const Color(0xFF4CAF50).withValues(alpha: 0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: hasError ? Colors.red : const Color(0xFF4CAF50).withValues(alpha: 0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
            ),
            errorText: hasError ? errorMessage : null,
            errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
          ),
        ),
        if (hasError && errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 14),
                const SizedBox(width: 4),
                Text(errorMessage, style: const TextStyle(color: Colors.red, fontSize: 12)),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF4CAF50), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityCard(String label, String count, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Text(count, style: TextStyle(color: color, fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF4CAF50).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.4)),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF4CAF50),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsTile(String title, String subtitle, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 2),
                      Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Color(0xFF4CAF50), size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData icon,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.3)),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        dropdownColor: const Color(0xFF2A2A2A),
        underline: const SizedBox(),
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item, style: const TextStyle(color: Colors.white)))).toList(),
        onChanged: onChanged,
        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF4CAF50)),
      ),
    );
  }

  void _showLanguageSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('Select Language', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...[
            ('en', '🇬🇧 English'),
            ('ar', '🇸🇦 العربية'),
            ('fr', '🇫🇷 Français'),
          ].map((lang) {
            return ListTile(
              title: Text(lang.$2, style: const TextStyle(color: Colors.white)),
              trailing: _selectedLanguage == lang.$1 ? const Icon(Icons.check, color: Color(0xFF4CAF50)) : null,
              onTap: () {
                setState(() => _selectedLanguage = lang.$1);
                widget.onLanguageChange(lang.$1);
                Navigator.pop(context);
              },
            );
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text('Logout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text('Are you sure you want to logout from Smart Farming Assistant?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF4CAF50))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully!'), backgroundColor: Color(0xFF4CAF50)),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    bool obscureOld = true;
    bool obscureNew = true;
    bool obscureConfirm = true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          title: const Text('Change Password', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: oldPasswordController,
                  obscureText: obscureOld,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    labelStyle: const TextStyle(color: Color(0xFF4CAF50)),
                    filled: true,
                    fillColor: Colors.black.withValues(alpha: 0.5),
                    suffixIcon: IconButton(
                      icon: Icon(obscureOld ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => obscureOld = !obscureOld),
                      color: const Color(0xFF4CAF50),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: newPasswordController,
                  obscureText: obscureNew,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    labelStyle: const TextStyle(color: Color(0xFF4CAF50)),
                    filled: true,
                    fillColor: Colors.black.withValues(alpha: 0.5),
                    suffixIcon: IconButton(
                      icon: Icon(obscureNew ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => obscureNew = !obscureNew),
                      color: const Color(0xFF4CAF50),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: obscureConfirm,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    labelStyle: const TextStyle(color: Color(0xFF4CAF50)),
                    filled: true,
                    fillColor: Colors.black.withValues(alpha: 0.5),
                    suffixIcon: IconButton(
                      icon: Icon(obscureConfirm ? Icons.visibility : Icons.visibility_off),
                      onPressed: () => setState(() => obscureConfirm = !obscureConfirm),
                      color: const Color(0xFF4CAF50),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                // Validate that fields are not empty
                if (oldPasswordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter your current password'), backgroundColor: Colors.red),
                  );
                  return;
                }
                if (newPasswordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a new password'), backgroundColor: Colors.red),
                  );
                  return;
                }
                if (confirmPasswordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please confirm your new password'), backgroundColor: Colors.red),
                  );
                  return;
                }
                
                // Check if passwords match
                if (newPasswordController.text == confirmPasswordController.text) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password changed successfully!'), backgroundColor: Color(0xFF4CAF50)),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('New passwords do not match'), backgroundColor: Colors.red),
                  );
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)),
              child: const Text('Change Password', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'ar':
        return '🇸🇦 العربية';
      case 'fr':
        return '🇫🇷 Français';
      default:
        return '🇬🇧 English';
    }
  }
}

// ========================
// Security & Privacy Settings Page
// ========================
class SecuritySettingsPage extends StatefulWidget {
  const SecuritySettingsPage({super.key});

  @override
  State<SecuritySettingsPage> createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends State<SecuritySettingsPage> with SingleTickerProviderStateMixin {
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;
  late AnimationController _animationController;
  
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  bool _is2FAEnabled = false;
  bool _isBiometricEnabled = false;
  bool _isPasswordMode = false;
  bool _isLoading = false;
  
  String _passwordStrength = 'Weak';
  Color _strengthColor = Colors.red;
  double _strengthValue = 0.0;
  
  String _lastPasswordChangeDate = 'Last changed: 2 months ago';
  DateTime? _lastLoginTime;
  String _lastLoginLocation = 'Device Location, City';
  
  List<Map<String, String>> _trustedDevices = [
    {'name': 'iPhone 12 Pro', 'location': 'Algiers, Algeria', 'date': 'Today'},
    {'name': 'MacBook Pro', 'location': 'Algiers, Algeria', 'date': '3 days ago'},
  ];
  
  List<String> _backupCodes = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _lastLoginTime = DateTime.now().subtract(const Duration(hours: 2));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Password strength validation
  void _updatePasswordStrength(String password) {
    setState(() {
      int strength = 0;
      
      // Check length
      if (password.length >= 8) strength += 1;
      if (password.length >= 12) strength += 1;
      
      // Check for numbers
      if (password.contains(RegExp(r'[0-9]'))) strength += 1;
      
      // Check for symbols
      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength += 1;
      
      // Check for uppercase
      if (password.contains(RegExp(r'[A-Z]'))) strength += 1;
      
      if (strength <= 2) {
        _passwordStrength = 'Weak';
        _strengthColor = Colors.red;
        _strengthValue = 0.3;
      } else if (strength <= 3) {
        _passwordStrength = 'Medium';
        _strengthColor = Colors.orange;
        _strengthValue = 0.6;
      } else {
        _passwordStrength = 'Strong';
        _strengthColor = const Color(0xFF4CAF50);
        _strengthValue = 1.0;
      }
    });
  }

  bool _validatePasswordRequirements(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  void _generateBackupCodes() {
    setState(() {
      _backupCodes = List.generate(8, (index) {
        String code = '';
        for (int i = 0; i < 4; i++) {
          code += ('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.split('')..shuffle()).first;
        }
        return code;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4CAF50)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Security & Privacy',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Security Score Card
            FadeTransition(
              opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [const Color(0xFF4CAF50).withValues(alpha: 0.2), const Color(0xFF1A1A1A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Security Score', style: TextStyle(color: Colors.white70, fontSize: 14)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('Good', style: TextStyle(color: Color(0xFF4CAF50), fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text('70%', style: TextStyle(color: const Color(0xFF4CAF50), fontSize: 36, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LinearProgressIndicator(
                                value: 0.7,
                                minHeight: 8,
                                backgroundColor: const Color(0xFF2A2A2A),
                                valueColor: AlwaysStoppedAnimation(const Color(0xFF4CAF50).withValues(alpha: 0.7)),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Enable 2FA to improve security',
                                style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),

            // ========================
            // 1. PASSWORD & ACCESS SECTION
            // ========================
            _buildSectionHeader('🔐 Password & Access'),
            const SizedBox(height: 12),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_lastPasswordChangeDate, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
                  const SizedBox(height: 12),
                  if (_isPasswordMode) ...[
                    // Current Password
                    TextField(
                      controller: _currentPasswordController,
                      obscureText: _obscureCurrentPassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Current Password',
                        labelStyle: const TextStyle(color: Color(0xFF4CAF50)),
                        filled: true,
                        fillColor: Colors.black.withValues(alpha: 0.5),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureCurrentPassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _obscureCurrentPassword = !_obscureCurrentPassword),
                          color: const Color(0xFF4CAF50),
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // New Password
                    TextField(
                      controller: _newPasswordController,
                      obscureText: _obscureNewPassword,
                      onChanged: _updatePasswordStrength,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        labelStyle: const TextStyle(color: Color(0xFF4CAF50)),
                        filled: true,
                        fillColor: Colors.black.withValues(alpha: 0.5),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureNewPassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _obscureNewPassword = !_obscureNewPassword),
                          color: const Color(0xFF4CAF50),
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Password Strength Meter
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Password Strength', style: TextStyle(color: Colors.white70, fontSize: 12)),
                            Text(_passwordStrength, style: TextStyle(color: _strengthColor, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: _strengthValue,
                            minHeight: 6,
                            backgroundColor: const Color(0xFF2A2A2A),
                            valueColor: AlwaysStoppedAnimation(_strengthColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    // Requirements Checklist
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Requirements', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 8),
                        _buildRequirementCheck('At least 8 characters', _newPasswordController.text.length >= 8),
                        _buildRequirementCheck('Contains numbers', _newPasswordController.text.contains(RegExp(r'[0-9]'))),
                        _buildRequirementCheck('Contains symbols', _newPasswordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    
                    // Confirm Password
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Confirm New Password',
                        labelStyle: const TextStyle(color: Color(0xFF4CAF50)),
                        filled: true,
                        fillColor: Colors.black.withValues(alpha: 0.5),
                        suffixIcon: IconButton(
                          icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                          onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                          color: const Color(0xFF4CAF50),
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Action Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => setState(() => _isPasswordMode = false),
                          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: _isLoading ? null : () => _handlePasswordChange(),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)),
                          icon: _isLoading ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation(Colors.black))) : const Icon(Icons.check),
                          label: Text(_isLoading ? 'Updating...' : 'Save Changes', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ] else ...[
                    // Password Display
                    GestureDetector(
                      onTap: () => setState(() => _isPasswordMode = true),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Password', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                const SizedBox(height: 4),
                                const Text('••••••••', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text('Change', style: TextStyle(color: Color(0xFF4CAF50), fontWeight: FontWeight.bold, fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 28),

            // ========================
            // 2. TWO-FACTOR AUTHENTICATION
            // ========================
            _buildSectionHeader('🛡️ Two-Factor Authentication'),
            const SizedBox(height: 12),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('2-Factor Authentication', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 4),
                          Text(
                            _is2FAEnabled ? 'Enabled' : 'Disabled',
                            style: TextStyle(
                              color: _is2FAEnabled ? const Color(0xFF4CAF50) : Colors.white.withValues(alpha: 0.6),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: _is2FAEnabled,
                        onChanged: (value) => setState(() => _is2FAEnabled = value),
                        activeColor: const Color(0xFF4CAF50),
                        inactiveThumbColor: Colors.grey,
                      ),
                    ],
                  ),
                  if (!_is2FAEnabled) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.security, color: const Color(0xFF4CAF50).withValues(alpha: 0.7), size: 32),
                          const SizedBox(height: 12),
                          const Text(
                            'Protect your account with an extra layer of security',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white70, fontSize: 13),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () => setState(() => _is2FAEnabled = true),
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)),
                            child: const Text('Enable 2FA', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    const SizedBox(height: 16),
                    // 2FA Enabled - Show setup/status
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 24),
                              SizedBox(width: 12),
                              Text(
                                '2FA is Active',
                                style: TextStyle(
                                  color: Color(0xFF4CAF50),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildSecurityOption('Select Method', 'Authenticator App', Icons.phone_android),
                          const SizedBox(height: 12),
                          _buildSecurityOption('Recovery Codes', 'Generate & backup codes', Icons.file_download),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 28),

            // ========================
            // 3. BIOMETRIC AUTHENTICATION
            // ========================
            _buildSectionHeader('👆 Biometric Authentication'),
            const SizedBox(height: 12),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Face ID / Fingerprint', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 4),
                      Text(
                        _isBiometricEnabled ? 'Enabled' : 'Disabled',
                        style: TextStyle(
                          color: _isBiometricEnabled ? const Color(0xFF4CAF50) : Colors.white.withValues(alpha: 0.6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: _isBiometricEnabled,
                    onChanged: (value) => setState(() => _isBiometricEnabled = value),
                    activeColor: const Color(0xFF4CAF50),
                    inactiveThumbColor: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // ========================
            // 4. TRUSTED DEVICES
            // ========================
            _buildSectionHeader('📱 Trusted Devices'),
            const SizedBox(height: 12),
            
            ..._trustedDevices.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, String> device = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          device['name']!.contains('iPhone') ? Icons.phone_iphone : Icons.laptop,
                          color: const Color(0xFF4CAF50),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(device['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text(device['location']!, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
                            Text(device['date']!, style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 11)),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() => _trustedDevices.removeAt(index));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Device removed'), backgroundColor: Color(0xFF4CAF50)),
                          );
                        },
                        icon: const Icon(Icons.close, color: Colors.red, size: 20),
                      ),
                    ],
                  ),
                ),
              );
            }),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Log out from all other devices',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logged out from all devices'), backgroundColor: Colors.red),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Logout All', style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // ========================
            // 5. LOGIN ACTIVITY
            // ========================
            _buildSectionHeader('📋 Login Activity'),
            const SizedBox(height: 12),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.login, color: Color(0xFF4CAF50)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Last Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text(_lastLoginLocation, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
                            Text(
                              'Today at ${_lastLoginTime?.hour}:${_lastLoginTime?.minute.toString().padLeft(2, '0')}',
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Viewing all login activity...'), backgroundColor: Color(0xFF4CAF50)),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF4CAF50)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('View All Activity', style: TextStyle(color: Color(0xFF4CAF50))),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // ========================
            // 6. BACKUP CODES
            // ========================
            _buildSectionHeader('🔑 Backup Codes'),
            const SizedBox(height: 12),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Recovery codes are a safe way to recover your account', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 16),
                  if (_backupCodes.isEmpty)
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _generateBackupCodes,
                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Generate Codes', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                    )
                  else ...[
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.5),
                      itemCount: _backupCodes.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2A2A),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _backupCodes[index],
                                style: const TextStyle(color: Color(0xFF4CAF50), fontFamily: 'monospace', fontSize: 11, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Codes copied to clipboard'), backgroundColor: Color(0xFF4CAF50)),
                              );
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)),
                            icon: const Icon(Icons.copy, size: 16),
                            label: const Text('Copy', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Codes downloaded'), backgroundColor: Color(0xFF4CAF50)),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF4CAF50)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            icon: const Icon(Icons.download, size: 16, color: Color(0xFF4CAF50)),
                            label: const Text('Download', style: TextStyle(color: Color(0xFF4CAF50), fontWeight: FontWeight.bold, fontSize: 12)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 28),

            // ========================
            // 7. NOTIFICATION PREFERENCES
            // ========================
            _buildSectionHeader('🔔 Notifications'),
            const SizedBox(height: 12),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  _buildNotificationOption('New login alert', 'Get notified on new device login'),
                  const SizedBox(height: 12),
                  _buildNotificationOption('Password changes', 'Get notified when password is changed'),
                  const SizedBox(height: 12),
                  _buildNotificationOption('2FA changes', 'Get notified when 2FA is modified'),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Helper Widgets
  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        const Expanded(child: Divider(color: Color(0xFF2A2A2A), height: 1)),
      ],
    );
  }

  Widget _buildRequirementCheck(String requirement, bool isMet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check_circle : Icons.radio_button_unchecked,
            size: 18,
            color: isMet ? const Color(0xFF4CAF50) : Colors.white.withValues(alpha: 0.4),
          ),
          const SizedBox(width: 8),
          Text(
            requirement,
            style: TextStyle(
              color: isMet ? Colors.white : Colors.white.withValues(alpha: 0.5),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityOption(String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12)),
              const SizedBox(height: 2),
              Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 11)),
            ],
          ),
          Icon(icon, color: const Color(0xFF4CAF50), size: 20),
        ],
      ),
    );
  }

  Widget _buildNotificationOption(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13)),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 11)),
            ],
          ),
        ),
        Switch(
          value: false,
          onChanged: (value) => setState(() {}),
          activeColor: const Color(0xFF4CAF50),
          inactiveThumbColor: Colors.grey,
        ),
      ],
    );
  }

  Future<void> _handlePasswordChange() async {
    // Validation
    if (_currentPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your current password'), backgroundColor: Colors.red),
      );
      return;
    }
    
    if (!_validatePasswordRequirements(_newPasswordController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New password does not meet requirements'), backgroundColor: Colors.red),
      );
      return;
    }
    
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New passwords do not match'), backgroundColor: Colors.red),
      );
      return;
    }
    
    if (_newPasswordController.text == _currentPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New password must be different from current password'), backgroundColor: Colors.orange),
      );
      return;
    }
    
    // Simulate password change
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1500));
    
    setState(() {
      _isLoading = false;
      _isPasswordMode = false;
      _lastPasswordChangeDate = 'Last changed: Today';
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
      _passwordStrength = 'Weak';
      _strengthColor = Colors.red;
      _strengthValue = 0.0;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✓ Password changed successfully!'),
        backgroundColor: Color(0xFF4CAF50),
        duration: Duration(seconds: 3),
      ),
    );
  }
}

// ========================
// Account Settings Page
// ========================
class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String _selectedPaymentMethod = 'edahabia';
  bool _savePaymentDefault = false;
  
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'id': 'edahabia',
      'nameAr': 'الذهبية',
      'titleAr': 'الدفع ببطاقة بريد الجزائر',
      'nameEn': 'Edahabia',
      'titleEn': 'Algerian Post Debit Card',
      'colors': {'primary': Color(0xFFD4AF37), 'secondary': Color(0xFF4CAF50)},
      'icon': Icons.credit_card,
    },
    {
      'id': 'baridimob',
      'nameAr': 'بريد موب',
      'titleAr': 'تحويل من تطبيق بريد موب',
      'nameEn': 'BaridiMob',
      'titleEn': 'Mobile Money Transfer',
      'colors': {'primary': Color(0xFF1E88E5), 'secondary': Color(0xFFFDD835)},
      'icon': Icons.mobile_screen_share,
    },
    {
      'id': 'cod',
      'nameAr': 'دفع عند الاستلام',
      'titleAr': 'إدفع نقدًا للمندوب',
      'nameEn': 'Cash On Delivery',
      'titleEn': 'Pay the Courier in Cash',
      'colors': {'primary': Color(0xFFEF5350), 'secondary': Colors.white},
      'icon': Icons.local_shipping,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4CAF50)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Account Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Methods Section Header
            FadeTransition(
              opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Methods',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Select your preferred payment method',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Payment Method Cards  
            Column(
              children: [
                ..._paymentMethods.map((method) {
                  bool isSelected = _selectedPaymentMethod == method['id'];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedPaymentMethod = method['id']),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF4CAF50) : const Color(0xFF4CAF50).withValues(alpha: 0.2),
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: isSelected
                              ? [BoxShadow(color: const Color(0xFF4CAF50).withValues(alpha: 0.3), blurRadius: 12, spreadRadius: 2)]
                              : [],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? const Color(0xFF4CAF50) : Colors.white.withValues(alpha: 0.3),
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? Center(
                                      child: Container(
                                        width: 12,
                                        height: 12,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFF4CAF50),
                                        ),
                                      ),
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    (method['colors']['primary'] as Color).withValues(alpha: 0.2),
                                    (method['colors']['secondary'] as Color).withValues(alpha: 0.1),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: (method['colors']['primary'] as Color).withValues(alpha: 0.3),
                                ),
                              ),
                              child: Icon(method['icon'], color: method['colors']['primary'], size: 28),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(method['nameAr'], style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                      const SizedBox(width: 8),
                                      Text('${method['nameEn']}',
                                          style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12)),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(method['titleAr'], style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 11)),
                                  const SizedBox(height: 2),
                                  Text(method['titleEn'],
                                      style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 10)),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                color: isSelected ? const Color(0xFF4CAF50) : Colors.white.withValues(alpha: 0.3), size: 16),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),

            const SizedBox(height: 28),

            // Save as Default
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Save as Default Payment',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Use this method for future transactions',
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12),
                      ),
                    ],
                  ),
                  Switch(
                    value: _savePaymentDefault,
                    onChanged: (value) => setState(() => _savePaymentDefault = value),
                    activeColor: const Color(0xFF4CAF50),
                    inactiveThumbColor: Colors.grey,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Account Information Section
            Text(
              'Account Information',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Email
            _buildAccountInfoCard(
              label: 'Email Address',
              value: 'chemali.rahma@smartfarming.com',
              icon: Icons.email,
              onEdit: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Email update feature - Coming soon'),
                    backgroundColor: Color(0xFF4CAF50),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            // Phone
            _buildAccountInfoCard(
              label: 'Phone Number',
              value: '+213 (0) 555 123-456',
              icon: Icons.phone,
              onEdit: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Phone update feature - Coming soon'),
                    backgroundColor: Color(0xFF4CAF50),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            // Account Type
            _buildAccountInfoCard(
              label: 'Account Type',
              value: 'Premium Farmer',
              icon: Icons.verified_user,
              onEdit: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Account upgrade features available'),
                    backgroundColor: Color(0xFF4CAF50),
                  ),
                );
              },
            ),

            const SizedBox(height: 28),

            // Preferences Section
            Text(
              'Preferences',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Email Notifications
            _buildPreferenceToggle(
              title: 'Email Notifications',
              subtitle: 'Receive updates and offers via email',
              initialValue: true,
            ),
            const SizedBox(height: 12),

            // SMS Notifications
            _buildPreferenceToggle(
              title: 'SMS Notifications',
              subtitle: 'Important updates via text message',
              initialValue: false,
            ),
            const SizedBox(height: 12),

            // Marketing
            _buildPreferenceToggle(
              title: 'Marketing Communications',
              subtitle: 'Receive promotional offers and deals',
              initialValue: false,
            ),

            const SizedBox(height: 28),

            // Save Changes Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✓ Account settings saved successfully!'),
                      backgroundColor: Color(0xFF4CAF50),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountInfoCard({
    required String label,
    required String value,
    required IconData icon,
    required VoidCallback onEdit,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF4CAF50), size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14)),
              ],
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(Icons.edit, color: Color(0xFF4CAF50), size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferenceToggle({
    required String title,
    required String subtitle,
    required bool initialValue,
  }) {
    bool isEnabled = initialValue;
    return StatefulBuilder(
      builder: (context, setStateLocal) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),
                ],
              ),
            ),
            Switch(
              value: isEnabled,
              onChanged: (value) => setStateLocal(() => isEnabled = value),
              activeColor: const Color(0xFF4CAF50),
              inactiveThumbColor: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

class NabtAIDiagnosticPage extends StatefulWidget {
  final String? imagePath;

  const NabtAIDiagnosticPage({super.key, this.imagePath});

  @override
  State<NabtAIDiagnosticPage> createState() => _NabtAIDiagnosticPageState();
}

class _NabtAIDiagnosticPageState extends State<NabtAIDiagnosticPage> {
  bool _isScanning = false;
  bool _showResult = false;
  double _progress = 0;
  Timer? _timer;

  final Map<String, dynamic> _diagnosisResult = {
    'plant': 'Olive - زيتون',
    'disease': 'Leaf Spot Disease',
    'confidence': '97%',
    'reason': 'High humidity + overwatering + poor airflow around leaves caused fungal development.',
    'symptoms': 'Brown circular spots, yellow halo around lesions, and lower leaf drying.',
    'solutions': <String>[
      'Remove infected leaves immediately and isolate the plant for 5-7 days.',
      'Apply copper-based fungicide every 7 days for 3 applications.',
      'Water only at soil level and reduce watering frequency by 20%.',
      'Increase air circulation and keep leaves dry after watering.',
    ],
    'medical': {
      'id': 9901,
      'name': 'Copper Fungicide Spray',
      'price': 1450.0,
      'oldPrice': 1800.0,
      'image': 'https://picsum.photos/seed/leaf-spot-medicine/600/450',
      'rating': 4.8,
      'category': 'Treatment',
      'seller': 'Agri Med Store',
    }
  };

  @override
  void initState() {
    super.initState();
    if (widget.imagePath != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _startDiagnosis();
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startDiagnosis() {
    setState(() {
      _isScanning = true;
      _showResult = false;
      _progress = 0;
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 130), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() => _progress += 0.04);
      if (_progress >= 1) {
        timer.cancel();
        setState(() {
          _progress = 1;
          _isScanning = false;
          _showResult = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12181D),
        title: const Text('AI Diagnosis - تشخيص بالذكاء الاصطناعي'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F171C), Color(0xFF111A21)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: const Color(0xFF32E6B4).withValues(alpha: 0.55)),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: widget.imagePath == null
                          ? Opacity(
                              opacity: 0.25,
                              child: Image.network(
                                'https://images.unsplash.com/photo-1592419044706-39796d40f98c?w=1200&q=80',
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.file(File(widget.imagePath!), fit: BoxFit.cover),
                    ),
                  ),
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _HexGridPainter(),
                    ),
                  ),
                  if (_isScanning)
                    Align(
                      alignment: Alignment(0, (_progress * 2) - 1),
                      child: Container(
                        height: 3,
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF00D0FF), Color(0xFF3DFF8B)],
                          ),
                        ),
                      ),
                    ),
                  const Center(
                    child: Icon(Icons.health_and_safety_outlined, color: Colors.white38, size: 44),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isScanning ? null : _startDiagnosis,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF26D07C),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(_isScanning ? 'Scanning...' : 'Start Diagnosis - ابدأ التشخيص'),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF151D23),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('مسح الورقة جاري... (AI Scanning...)', style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      minHeight: 8,
                      value: _progress,
                      backgroundColor: const Color(0xFF24323D),
                      valueColor: const AlwaysStoppedAnimation(Color(0xFF32E6B4)),
                    ),
                  ),
                ],
              ),
            ),
            if (_showResult) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF151D23),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF26D07C).withValues(alpha: 0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Plant Species: ${_diagnosisResult['plant']}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Disease: ${_diagnosisResult['disease']} • ${_diagnosisResult['confidence']} Confidence', style: const TextStyle(color: Color(0xFFFFD275))),
                    const SizedBox(height: 8),
                    Text('Reason: ${_diagnosisResult['reason']}', style: const TextStyle(color: Colors.white70, height: 1.5)),
                    const SizedBox(height: 8),
                    Text('Symptoms: ${_diagnosisResult['symptoms']}', style: const TextStyle(color: Colors.white70, height: 1.5)),
                    const SizedBox(height: 10),
                    const Text('Solution Plan:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    ...(_diagnosisResult['solutions'] as List<String>).map(
                      (step) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text('• $step', style: const TextStyle(color: Colors.white70, height: 1.4)),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Repost shared to community feed')),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF31D6FF)),
                            foregroundColor: const Color(0xFF31D6FF),
                          ),
                          icon: const Icon(Icons.share_outlined),
                          label: const Text('Share / Repost'),
                        ),
                        OutlinedButton.icon(
                          onPressed: () {
                            final medical = Map<String, dynamic>.from(_diagnosisResult['medical'] as Map<String, dynamic>);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SavedProductsPage(initialSavedProduct: medical),
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Saved to favorites page')),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF2DE091)),
                            foregroundColor: const Color(0xFF2DE091),
                          ),
                          icon: const Icon(Icons.favorite_border),
                          label: const Text('Save to Favorites'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          final medical = _diagnosisResult['medical'] as Map<String, dynamic>;
                          NabtCartStore.addToCart({
                            'title': medical['name'],
                            'price': medical['price'],
                            'qty': 1,
                            'image': medical['image'],
                            'selected': true,
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MarketPage(
                                isDarkMode: Theme.of(context).brightness == Brightness.dark,
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${medical['name']} added. Opened market for treatment products.'),
                              backgroundColor: const Color(0xFF26D07C),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF26D07C),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                        child: const Text('Buy Disease Treatment from Market'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HexGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8
      ..color = const Color(0xFF31D6FF).withValues(alpha: 0.15);
    const gap = 28.0;
    for (double y = 0; y < size.height + gap; y += gap) {
      for (double x = 0; x < size.width + gap; x += gap) {
        canvas.drawCircle(Offset(x, y), 8, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class NabtAICameraScanResultPage extends StatefulWidget {
  final String scanType; // plant | toxicity
  final String imagePath;

  const NabtAICameraScanResultPage({
    super.key,
    required this.scanType,
    required this.imagePath,
  });

  @override
  State<NabtAICameraScanResultPage> createState() => _NabtAICameraScanResultPageState();
}

class _NabtAICameraScanResultPageState extends State<NabtAICameraScanResultPage> {
  bool _isScanning = true;
  double _progress = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 120), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() => _progress += 0.04);
      if (_progress >= 1) {
        timer.cancel();
        setState(() {
          _progress = 1;
          _isScanning = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isPlant = widget.scanType == 'plant';

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12181D),
        title: Text(isPlant ? 'Plant ID Result' : 'Toxicity ID Result'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.file(
                File(widget.imagePath),
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 14),
            if (_isScanning) ...[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF151D23),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isPlant ? 'Scanning plant identity...' : 'Scanning plant toxicity...',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        minHeight: 8,
                        value: _progress,
                        backgroundColor: const Color(0xFF24323D),
                        valueColor: const AlwaysStoppedAnimation(Color(0xFF2DE091)),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              if (isPlant) _buildPlantIdResult() else _buildToxicityResult(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPlantIdResult() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF151D23),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2DE091).withValues(alpha: 0.4)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Plant Type: Monstera Deliciosa', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text('Scientific Name: Monstera deliciosa', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 4),
          Text('Family: Araceae', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 10),
          Text('Care Information', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          SizedBox(height: 6),
          Text('• Watering: Every 5-7 days when top soil is dry', style: TextStyle(color: Colors.white70)),
          Text('• Sunlight: Bright indirect light', style: TextStyle(color: Colors.white70)),
          Text('• Soil: Well-draining organic potting mix', style: TextStyle(color: Colors.white70)),
          Text('• Temperature: 18°C - 30°C', style: TextStyle(color: Colors.white70)),
          Text('• Humidity: Medium to high humidity preferred', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 10),
          Text('Benefits & Notes', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
          SizedBox(height: 6),
          Text('Air-purifying indoor plant. Keep away from pets/children if ingested.', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildToxicityResult() {
    const toxicityPercent = 78;
    const isSafeToEat = false;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF151D23),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Toxicity Analysis', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isSafeToEat ? Colors.green.withValues(alpha: 0.2) : Colors.red.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: isSafeToEat ? Colors.green : Colors.redAccent),
            ),
            child: Text(
              isSafeToEat ? 'Safe to Eat: YES' : 'Safe to Eat: NO',
              style: TextStyle(
                color: isSafeToEat ? Colors.greenAccent : Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Estimated Toxicity Percentage', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: toxicityPercent / 100,
              backgroundColor: const Color(0xFF24323D),
              valueColor: const AlwaysStoppedAnimation(Colors.redAccent),
            ),
          ),
          const SizedBox(height: 8),
          const Text('Toxicity: 78%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text(
            'This plant has high calcium oxalate crystals and is not recommended for eating. Avoid oral contact and keep away from children and pets.',
            style: TextStyle(color: Colors.white70, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class NabtMarketStore {
  static final List<Map<String, dynamic>> sharedProducts = [];

  static void addSharedProduct(Map<String, dynamic> product) {
    sharedProducts.insert(0, Map<String, dynamic>.from(product));
  }
}

class NabtCartStore {
  static final List<Map<String, dynamic>> cartItems = [];
  static final List<Map<String, dynamic>> paidPurchases = [];

  static void addToCart(Map<String, dynamic> item) {
    item.putIfAbsent('selected', () => false);
    final index = cartItems.indexWhere((entry) => entry['title'] == item['title']);
    if (index >= 0) {
      cartItems[index]['qty'] = (cartItems[index]['qty'] as int) + (item['qty'] as int);
    } else {
      cartItems.add(Map<String, dynamic>.from(item));
    }
  }

  static void updateQuantity(int index, int quantity) {
    if (index < 0 || index >= cartItems.length) {
      return;
    }
    cartItems[index]['qty'] = quantity < 1 ? 1 : quantity;
  }

  static void removeAt(int index) {
    if (index < 0 || index >= cartItems.length) {
      return;
    }
    cartItems.removeAt(index);
  }

  static void payAll({
    required String paymentMethod,
    required String wilaya,
    required String region,
    required String street,
    required String fullAddress,
  }) {
    final now = DateTime.now();
    for (final item in cartItems) {
      paidPurchases.insert(0, {
        ...item,
        'paymentMethod': paymentMethod,
        'wilaya': wilaya,
        'region': region,
        'street': street,
        'fullAddress': fullAddress,
        'paidAt': '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}',
      });
    }
    cartItems.clear();
  }
}

class NabtProductDetailsPage extends StatefulWidget {
  final Map<String, String> product;
  final Map<String, dynamic>? sellerData;

  const NabtProductDetailsPage({
    super.key,
    required this.product,
    this.sellerData,
  });

  @override
  State<NabtProductDetailsPage> createState() => _NabtProductDetailsPageState();
}

class _NabtProductDetailsPageState extends State<NabtProductDetailsPage> {
  int _imageIndex = 0;
  final TextEditingController _commentController = TextEditingController();
  final List<Map<String, dynamic>> _farmerComments = [
    {
      'name': 'Nora from Blida',
      'comment': 'Top quality for olive fields.',
      'date': '5d ago',
      'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=300&q=80&crop=faces&fit=crop&facepad=2',
      'rating': 4,
      'location': 'Blida, Algeria',
      'farmSize': '8 hectares',
      'crops': 'Vegetables, Grapes',
      'followers': '1.8k',
      'farmName': 'Nora Gardens',
    },
    {
      'name': 'Hassan from Oran',
      'comment': 'Best quality seeds I\'ve bought. Excellent customer service.',
      'date': '1w ago',
      'image': 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=300&q=80&crop=faces&fit=crop&facepad=2',
      'rating': 5,
      'location': 'Oran, Algeria',
      'farmSize': '25 hectares',
      'crops': 'Cereals, Dates',
      'followers': '4.1k',
      'farmName': 'Hassan Fields',
    },
    {
      'name': 'Fatima from Tipaza',
      'comment': 'Great irrigation solution for my farm. Highly recommended!',
      'date': '10d ago',
      'image': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=300&q=80&crop=faces&fit=crop&facepad=2',
      'rating': 5,
      'location': 'Tipaza, Algeria',
      'farmSize': '12 hectares',
      'crops': 'Citrus, Strawberries',
      'followers': '3.2k',
      'farmName': 'Fatima Harvest',
    },
  ];
  final List<String> _gallery = [
    'https://images.unsplash.com/photo-1592419044706-39796d40f98c?w=1200&q=80',
    'https://images.unsplash.com/photo-1457530378978-8bac673b8062?w=1200&q=80',
    'https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?w=1200&q=80',
  ];

  double _estimatePrice(String name) {
    return (2400 + (name.length * 155)).toDouble();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _openAddCommentSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF12181D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Comment - أضف تعليق',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _commentController,
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Write your experience with this product...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF0F151A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    final text = _commentController.text.trim();
                    if (text.isEmpty) {
                      return;
                    }
                    setState(() {
                      _farmerComments.insert(0, {
                        'name': 'You',
                        'comment': text,
                        'date': 'Now',
                        'image': 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=300&q=80',
                      });
                    });
                    _commentController.clear();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text('Comment added successfully - تم إضافة التعليق'),
                        backgroundColor: Color(0xFF2DE091),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2DE091),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: const Icon(Icons.send_rounded),
                  label: const Text('Post Comment'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageFromSource(
    String source, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    if (source.startsWith('http')) {
      return Image.network(source, width: width, height: height, fit: fit);
    }
    return Image.file(File(source), width: width, height: height, fit: fit);
  }

  @override
  Widget build(BuildContext context) {
    final image = widget.product['image'] ?? _gallery.first;
    final name = widget.product['name'] ?? 'Premium Olive Seedling';
    final category = widget.product['category'] ?? 'Plants';
    final sellerName = (widget.sellerData?['farmName'] ?? widget.sellerData?['name'] ?? 'Green Garden Store').toString();
    final sellerLocation = (widget.sellerData?['location'] ?? 'Algeria').toString();
    final sellerImage = (widget.sellerData?['image'] ?? 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=500&q=80').toString();
    final price = _estimatePrice(name);
    final oldPrice = price + 1200;
    final title = '$name - $category';
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12181D),
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF2DE091)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NabtCartCheckoutPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 250,
              child: PageView(
                onPageChanged: (value) => setState(() => _imageIndex = value),
                children: [image, ..._gallery.skip(1)].map((url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _buildImageFromSource(url, fit: BoxFit.cover),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _imageIndex == index ? 18 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _imageIndex == index ? const Color(0xFF2DE091) : Colors.white24,
                    borderRadius: BorderRadius.circular(8),
                  ),
                );
              }),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF151D23), borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text('${price.toStringAsFixed(0)} DZD', style: const TextStyle(color: Color(0xFF2DE091), fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 12),
                      Text('${oldPrice.toStringAsFixed(0)} DZD', style: const TextStyle(color: Colors.white38, decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _infoCard(
              title: 'Agricultural Info - معلومات زراعية',
              children: const [
                _InfoLine(icon: Icons.water_drop, label: 'Watering: Low to Moderate'),
                _InfoLine(icon: Icons.wb_sunny, label: 'Sunlight: Full Sun'),
                _InfoLine(icon: Icons.grass, label: 'Soil: Loamy / Well-drained'),
              ],
            ),
            const SizedBox(height: 14),
            _infoCard(
              title: 'Seller - البائع',
              children: [
                GestureDetector(
                  onTap: () {
                    if (widget.sellerData != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FarmerProfilePage(farmerData: widget.sellerData!),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NabtSellerProfilePage()),
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F151A),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF31D6FF).withValues(alpha: 0.25)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(colors: [Color(0xFF2DE091), Color(0xFF31D6FF)]),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: ClipOval(
                              child: _buildImageFromSource(sellerImage, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(sellerName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 3),
                              Text(sellerLocation, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _infoCard(
              title: 'Community Reviews - مراجعات المزارعين',
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: _openAddCommentSheet,
                    icon: const Icon(Icons.add_comment_outlined, color: Color(0xFF2DE091), size: 18),
                    label: const Text('Add Comment', style: TextStyle(color: Color(0xFF2DE091))),
                  ),
                ),
                ..._farmerComments.map(
                  (comment) => _reviewTile(
                    farmerData: comment,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FarmerProfilePage(farmerData: comment),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFF12181D),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    NabtCartStore.addToCart({
                      'title': title,
                      'price': price,
                      'qty': 1,
                      'image': image,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Added to cart'),
                        backgroundColor: Color(0xFF2DE091),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF2DE091), width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  ),
                  icon: const Icon(Icons.add_shopping_cart, color: Color(0xFF2DE091), size: 18),
                  label: const Text('Cart', style: TextStyle(color: Color(0xFF2DE091), fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    NabtCartStore.addToCart({
                      'title': title,
                      'price': price,
                      'qty': 1,
                      'image': image,
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const NabtCartCheckoutPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2DE091),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  ),
                  icon: const Icon(Icons.flash_on, size: 18),
                  label: const Text('Buy Now', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF151D23), borderRadius: BorderRadius.circular(20)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...children,
      ]),
    );
  }

  Widget _reviewTile({required Map<String, dynamic> farmerData, required VoidCallback onTap}) {
    final name = farmerData['name'] ?? '';
    final review = farmerData['comment'] ?? '';
    final imageUrl = farmerData['image'] ?? '';
    final date = farmerData['date'] ?? '';
    final rating = farmerData['rating'] ?? 5;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF0F151A),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(children: [
          GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(imageUrl, width: 52, height: 52, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: onTap,
                      child: Text(name, style: const TextStyle(color: Color(0xFF2DE091), fontWeight: FontWeight.w600, fontSize: 13)),
                    ),
                  ),
                  if (date.isNotEmpty) Text(date, style: const TextStyle(color: Colors.white54, fontSize: 10)),
                ],
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 2,
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star_rounded : Icons.star_border_rounded,
                    color: index < rating ? const Color(0xFFFFD275) : Colors.white24,
                    size: 16,
                  );
                }),
              ),
              const SizedBox(height: 4),
              Text(review, style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4)),
            ]),
          )
        ]),
      ),
    );
  }
}

class NabtSellerProfilePage extends StatefulWidget {
  const NabtSellerProfilePage({super.key});

  @override
  State<NabtSellerProfilePage> createState() => _NabtSellerProfilePageState();
}

class _NabtSellerProfilePageState extends State<NabtSellerProfilePage> {
  bool _isFollowing = false;
  bool _storySeen = false;
  int _selectedTab = 0;
  final String _sellerProfileImage = 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=500&q=80';

  final List<Map<String, String>> _sellerStories = const [
    {'title': 'Green Garden Story', 'image': 'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=900&q=80'},
    {'title': 'Irrigation Setup', 'image': 'https://images.unsplash.com/photo-1464226184884-fa280b87c399?w=900&q=80'},
    {'title': 'Farm Update', 'image': 'https://images.unsplash.com/photo-1471193945509-9ad0617afabf?w=900&q=80'},
  ];

  final List<Map<String, dynamic>> _posts = [
    {
      'image': 'https://picsum.photos/seed/farmer-post-1/1200/900',
      'caption': 'Fresh olive seedlings available this week 🌱 #Olive #Nabt',
      'likes': 1200,
      'comments': 214,
      'liked': false,
      'commentList': <String>['Is this available in Setif?', 'Great quality 👏'],
    },
    {
      'image': 'https://picsum.photos/seed/farmer-post-2/1200/900',
      'caption': 'Smart irrigation setup for small farms 💧',
      'likes': 986,
      'comments': 133,
      'liked': false,
      'commentList': <String>['Need price for 2 hectares'],
    },
    {
      'image': 'https://picsum.photos/seed/farmer-post-3/1200/900',
      'caption': 'Disease prevention tips for spring crops 🍃',
      'likes': 1800,
      'comments': 302,
      'liked': false,
      'commentList': <String>['Very useful post ✅'],
    },
    {
      'image': 'https://picsum.photos/seed/farmer-post-4/1200/900',
      'caption': 'New shipment: organic fertilizers now in stock ✅',
      'likes': 743,
      'comments': 89,
      'liked': false,
      'commentList': <String>['Can you deliver to Oran?'],
    },
    {
      'image': 'https://picsum.photos/seed/farmer-post-5/1200/900',
      'caption': 'Before/after growth in 30 days 🌿',
      'likes': 2100,
      'comments': 411,
      'liked': false,
      'commentList': <String>['Amazing result!'],
    },
    {
      'image': 'https://picsum.photos/seed/farmer-post-6/1200/900',
      'caption': 'Harvest season checklist for Algerian farmers.',
      'likes': 531,
      'comments': 64,
      'liked': false,
      'commentList': <String>['Thanks for sharing 🌾'],
    },
  ];

  final List<Map<String, String>> _sellerProducts = const [
    {
      'name': 'Olive Seedlings Pack',
      'category': 'Plants',
      'image': 'https://picsum.photos/seed/farmer-product-1/1200/900',
    },
    {
      'name': 'Smart Drip Irrigation Kit',
      'category': 'Irrigation',
      'image': 'https://picsum.photos/seed/farmer-product-2/1200/900',
    },
    {
      'name': 'Organic Fertilizer 25kg',
      'category': 'Fertilizers',
      'image': 'https://picsum.photos/seed/farmer-product-3/1200/900',
    },
    {
      'name': 'Disease Treatment Set',
      'category': 'Treatment',
      'image': 'https://picsum.photos/seed/farmer-product-4/1200/900',
    },
  ];

  String _formatCount(int value) {
    if (value >= 1000) {
      final k = value / 1000;
      return k >= 10 ? '${k.toStringAsFixed(0)}k' : '${k.toStringAsFixed(1)}k';
    }
    return '$value';
  }

  bool get _hasActiveStory => _sellerStories.isNotEmpty;

  void _togglePostLike(int index) {
    setState(() {
      final post = _posts[index];
      final liked = post['liked'] as bool;
      post['liked'] = !liked;
      post['likes'] = (post['likes'] as int) + (liked ? -1 : 1);
    });
  }

  void _openCommentSheet(int index) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF12181D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, modalSetState) {
            final post = _posts[index];
            final comments = post['commentList'] as List<String>;
            return FractionallySizedBox(
              heightFactor: 0.82,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: 12 + MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Comments',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(
                            '${comments.length}',
                            style: const TextStyle(color: Colors.white60, fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: comments.isEmpty
                            ? const Center(
                                child: Text('No comments yet', style: TextStyle(color: Colors.white54)),
                              )
                            : ListView.separated(
                                itemCount: comments.length,
                                separatorBuilder: (_, __) => const Divider(color: Colors.white10, height: 14),
                                itemBuilder: (context, commentIndex) {
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 14,
                                        backgroundColor: const Color(0xFF2DE091).withValues(alpha: 0.2),
                                        child: const Icon(Icons.person, size: 14, color: Color(0xFF2DE091)),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF0F151A),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                commentIndex == 0 ? 'You' : 'Farmer ${commentIndex + 1}',
                                                style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(comments[commentIndex], style: const TextStyle(color: Colors.white, fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Write a comment...',
                                hintStyle: const TextStyle(color: Colors.white54),
                                filled: true,
                                fillColor: const Color(0xFF0F151A),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(color: Colors.white24),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(color: Colors.white24),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: const Color(0xFF2DE091),
                            child: IconButton(
                              onPressed: () {
                                final text = controller.text.trim();
                                if (text.isEmpty) {
                                  return;
                                }
                                setState(() {
                                  comments.insert(0, text);
                                  post['comments'] = (post['comments'] as int) + 1;
                                });
                                modalSetState(() {});
                                controller.clear();
                              },
                              icon: const Icon(Icons.send_rounded, color: Colors.black, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(controller.dispose);
  }

  void _sharePost() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Post shared successfully'),
        backgroundColor: Color(0xFF31D6FF),
      ),
    );
  }

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF12181D),
        title: const Text('Report Seller', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Why are you reporting this seller?', style: TextStyle(color: Colors.white70, fontSize: 14)),
            const SizedBox(height: 16),
            _reportReasonButton('Inappropriate content', Icons.warning_amber_rounded),
            _reportReasonButton('Scam or fraud', Icons.security),
            _reportReasonButton('Poor quality products', Icons.thumb_down_outlined),
            _reportReasonButton('Other reason', Icons.more_horiz),
          ],
        ),
      ),
    );
  }

  Widget _reportReasonButton(String text, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Report sent successfully'),
            backgroundColor: Colors.green,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF0F151A),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.red, size: 18),
            const SizedBox(width: 10),
            Text(text, style: const TextStyle(color: Colors.white, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  void _showBlockDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF12181D),
        title: const Text('Block Seller', style: TextStyle(color: Colors.white)),
        content: const Text(
          'You will not see posts or messages from this seller.',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Seller blocked'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            child: const Text('Block', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _copyProfileUrl() {
    final url = 'https://nabt.app/seller/greengarden.store';
    Clipboard.setData(ClipboardData(text: url));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile URL copied to clipboard'),
        backgroundColor: Color(0xFF2DE091),
      ),
    );
  }

  void _showQRCodeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF12181D),
        title: const Text('Profile QR Code', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.qr_code_2, size: 120, color: Color(0xFF2DE091)),
                    const SizedBox(height: 10),
                    Text(
                      'greengarden.store',
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Scan to visit profile', style: TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Color(0xFF2DE091))),
          ),
        ],
      ),
    );
  }

  Future<void> _openPostViewer(int initialIndex) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NabtSellerPostViewerPage(
          posts: _posts,
          initialIndex: initialIndex,
        ),
      ),
    );
    setState(() {});
  }

  Future<void> _openStoryViewer(List<Map<String, String>> stories, int initialIndex) async {
    final seenAll = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => NabtStoryViewerPage(stories: stories, initialIndex: initialIndex),
      ),
    );
    if (seenAll == true) {
      setState(() => _storySeen = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12181D),
        title: const Text('greengarden.store'),
        actions: [
          PopupMenuButton<String>(
            color: const Color(0xFF12181D),
            onSelected: (value) {
              if (value == 'report') {
                _showReportDialog();
              } else if (value == 'block') {
                _showBlockDialog();
              } else if (value == 'copy_url') {
                _copyProfileUrl();
              } else if (value == 'qr_code') {
                _showQRCodeDialog();
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'report',
                child: Row(
                  children: [
                    Icon(Icons.flag_outlined, color: Colors.red, size: 20),
                    SizedBox(width: 12),
                    Text('Report', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'block',
                child: Row(
                  children: [
                    Icon(Icons.block, color: Colors.orange, size: 20),
                    SizedBox(width: 12),
                    Text('Block', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'copy_url',
                child: Row(
                  children: [
                    Icon(Icons.link, color: Color(0xFF2DE091), size: 20),
                    SizedBox(width: 12),
                    Text('Copy Profile URL', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'qr_code',
                child: Row(
                  children: [
                    Icon(Icons.qr_code_2, color: Color(0xFF31D6FF), size: 20),
                    SizedBox(width: 12),
                    Text('QR Code', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(Icons.more_horiz, color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: _hasActiveStory ? () => _openStoryViewer(_sellerStories, 0) : null,
                  child: Container(
                    width: 96,
                    height: 96,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: (_hasActiveStory && !_storySeen)
                          ? const LinearGradient(
                              colors: [Color(0xFFE1306C), Color(0xFFF77737), Color(0xFFFCAF45)],
                            )
                          : null,
                      color: _hasActiveStory
                          ? (_storySeen ? Colors.white24 : null)
                          : const Color(0xFF2DE091),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [Color(0xFF2DE091), Color(0xFF31D6FF)]),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: ClipOval(
                          child: Image.network(_sellerProfileImage, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _countColumn('156', 'Posts'),
                      _countColumn('8.2k', 'Followers'),
                      _countColumn('642', 'Following'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text('Green Garden Store', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const Text('Premium agricultural products • Algeria', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 4),
            const Row(
              children: [
                Icon(Icons.verified, size: 14, color: Color(0xFF31D6FF)),
                SizedBox(width: 4),
                Text('Verified Seller • 4.9 (1234 reviews)', style: TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Organic seedlings, smart irrigation kits, and farm guidance for Algerian farmers. Delivery across all wilayas.',
              style: TextStyle(color: Colors.white70, height: 1.4),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color(0xFF151D23),
                border: Border.all(color: Colors.white24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📍 Oran, Algeria', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  SizedBox(height: 3),
                  Text('📞 +213 555 555 555', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  SizedBox(height: 3),
                  Text('⏱ Response time: ~2 minutes', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => _isFollowing = !_isFollowing),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFollowing ? Colors.white12 : const Color(0xFF2DE091),
                      foregroundColor: _isFollowing ? Colors.white : Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Icon(_isFollowing ? Icons.person : Icons.person_add_alt_1),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatPage())),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF31D6FF)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Icon(Icons.chat_bubble_outline, color: Color(0xFF31D6FF), size: 20),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CallPage()),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Icon(Icons.phone_outlined, color: Colors.white70, size: 20),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF151D23),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _tabButton(
                      icon: Icons.grid_on,
                      label: 'Posts',
                      selected: _selectedTab == 0,
                      onTap: () => setState(() => _selectedTab = 0),
                    ),
                  ),
                  Expanded(
                    child: _tabButton(
                      icon: Icons.view_stream_outlined,
                      label: 'Feed',
                      selected: _selectedTab == 1,
                      onTap: () => setState(() => _selectedTab = 1),
                    ),
                  ),
                  Expanded(
                    child: _tabButton(
                      icon: Icons.sell_outlined,
                      label: 'Products',
                      selected: _selectedTab == 2,
                      onTap: () => setState(() => _selectedTab = 2),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (_selectedTab == 0)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _posts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  return InkWell(
                    onTap: () => _openPostViewer(index),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(post['image'] as String, fit: BoxFit.cover),
                    ),
                  );
                },
              )
            else if (_selectedTab == 1)
              Column(
                children: List.generate(_posts.length, (index) {
                  final post = _posts[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF151D23),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => _openPostViewer(index),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                            child: Image.network(post['image'] as String, height: 180, width: double.infinity, fit: BoxFit.cover),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(post['caption'] as String, style: const TextStyle(color: Colors.white70)),
                              const SizedBox(height: 8),
                              _postActions(index),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _sellerProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, index) {
                  final product = _sellerProducts[index];
                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NabtProductDetailsPage(product: product),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF151D23),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Image.network(product['image']!, height: 120, width: double.infinity, fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product['name']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                                const SizedBox(height: 4),
                                Text(product['category']!, style: const TextStyle(color: Colors.white60, fontSize: 11)),
                                const SizedBox(height: 4),
                                const Text('Tap to view & buy', style: TextStyle(color: Color(0xFF2DE091), fontWeight: FontWeight.bold, fontSize: 11)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _countColumn(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)),
      ],
    );
  }

  Widget _postActions(int index) {
    final post = _posts[index];
    final liked = post['liked'] as bool;
    final likes = post['likes'] as int;
    final comments = post['comments'] as int;
    return Row(
      children: [
        InkWell(
          onTap: () => _togglePostLike(index),
          child: Row(
            children: [
              Icon(liked ? Icons.favorite : Icons.favorite_border, color: liked ? Colors.redAccent : Colors.white70, size: 19),
              const SizedBox(width: 4),
              Text(_formatCount(likes), style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(width: 14),
        InkWell(
          onTap: () => _openCommentSheet(index),
          child: Row(
            children: [
              const Icon(Icons.mode_comment_outlined, color: Colors.white70, size: 19),
              const SizedBox(width: 4),
              Text(_formatCount(comments), style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(width: 14),
        InkWell(
          onTap: _sharePost,
          child: const Row(
            children: [
              Icon(Icons.share_outlined, color: Colors.white70, size: 19),
              SizedBox(width: 4),
              Text('Share', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tabButton({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: selected ? const Color(0xFF2DE091).withValues(alpha: 0.2) : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: selected ? const Color(0xFF2DE091) : Colors.white54, size: 18),
            const SizedBox(height: 3),
            Text(label, style: TextStyle(color: selected ? const Color(0xFF2DE091) : Colors.white60, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class NabtStoryViewerPage extends StatefulWidget {
  final List<Map<String, String>> stories;
  final int initialIndex;
  const NabtStoryViewerPage({super.key, required this.stories, required this.initialIndex});

  @override
  State<NabtStoryViewerPage> createState() => _NabtStoryViewerPageState();
}

class _NabtStoryViewerPageState extends State<NabtStoryViewerPage> {
  late final PageController _controller;
  int _current = 0;
  late Set<int> _seenStoryIndexes;
  bool _likedStory = false;
  String _selectedReaction = '';
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
    _seenStoryIndexes = {widget.initialIndex};
  }

  @override
  void dispose() {
    _messageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _pickReaction() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF12181D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        const reactions = ['❤️', '😍', '🔥', '👏', '🌱'];
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 10,
              children: reactions.map((emoji) {
                return InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    setState(() => _selectedReaction = emoji);
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF151D23),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Text(emoji, style: const TextStyle(fontSize: 22)),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _sendStoryMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) {
      return;
    }
    _messageController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Message sent to seller'),
        backgroundColor: Color(0xFF31D6FF),
      ),
    );
  }

  bool get _allStoriesSeen => _seenStoryIndexes.length == widget.stories.length;

  Future<bool> _handleWillPop() async {
    Navigator.pop(context, _allStoriesSeen);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleWillPop,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, _allStoriesSeen),
          ),
          title: Text(widget.stories[_current]['title'] ?? 'Story'),
        ),
        body: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: widget.stories.length,
              onPageChanged: (value) {
                setState(() {
                  _current = value;
                  _seenStoryIndexes.add(value);
                });
              },
              itemBuilder: (context, index) {
                final story = widget.stories[index];
                return Image.network(story['image']!, fit: BoxFit.cover, width: double.infinity, height: double.infinity);
              },
            ),
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Row(
                children: List.generate(widget.stories.length, (index) {
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      height: 3,
                      decoration: BoxDecoration(
                        color: index == _current ? Colors.white : Colors.white30,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 18,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.42),
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: Colors.white24),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: _pickReaction,
                      icon: Text(_selectedReaction.isEmpty ? '😊' : _selectedReaction, style: const TextStyle(fontSize: 22)),
                    ),
                    IconButton(
                      onPressed: () => setState(() => _likedStory = !_likedStory),
                      icon: Icon(
                        _likedStory ? Icons.favorite : Icons.favorite_border,
                        color: _likedStory ? Colors.redAccent : Colors.white,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Send message...',
                          hintStyle: const TextStyle(color: Colors.white54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: const BorderSide(color: Colors.white24),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(22),
                            borderSide: const BorderSide(color: Colors.white24),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: _sendStoryMessage,
                      icon: const Icon(Icons.send_rounded, color: Color(0xFF2DE091)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NabtSellerPostViewerPage extends StatefulWidget {
  final List<Map<String, dynamic>> posts;
  final int initialIndex;
  const NabtSellerPostViewerPage({
    super.key,
    required this.posts,
    required this.initialIndex,
  });

  @override
  State<NabtSellerPostViewerPage> createState() => _NabtSellerPostViewerPageState();
}

class _NabtSellerPostViewerPageState extends State<NabtSellerPostViewerPage> {
  late final PageController _controller;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatCount(int value) {
    if (value >= 1000) {
      final k = value / 1000;
      return k >= 10 ? '${k.toStringAsFixed(0)}k' : '${k.toStringAsFixed(1)}k';
    }
    return '$value';
  }

  void _toggleLike(int index) {
    setState(() {
      final post = widget.posts[index];
      final liked = post['liked'] as bool;
      post['liked'] = !liked;
      post['likes'] = (post['likes'] as int) + (liked ? -1 : 1);
    });
  }

  void _openCommentSheet(int index) {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF12181D),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, modalSetState) {
            final post = widget.posts[index];
            final comments = post['commentList'] as List<String>;
            return FractionallySizedBox(
              heightFactor: 0.82,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: 12 + MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Comments',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text('${comments.length}', style: const TextStyle(color: Colors.white60, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: comments.isEmpty
                            ? const Center(
                                child: Text('No comments yet', style: TextStyle(color: Colors.white54)),
                              )
                            : ListView.separated(
                                itemCount: comments.length,
                                separatorBuilder: (_, __) => const Divider(color: Colors.white10, height: 14),
                                itemBuilder: (context, commentIndex) {
                                  return Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 14,
                                        backgroundColor: const Color(0xFF2DE091).withValues(alpha: 0.2),
                                        child: const Icon(Icons.person, size: 14, color: Color(0xFF2DE091)),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF0F151A),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                commentIndex == 0 ? 'You' : 'Farmer ${commentIndex + 1}',
                                                style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600),
                                              ),
                                              const SizedBox(height: 2),
                                              Text(comments[commentIndex], style: const TextStyle(color: Colors.white, fontSize: 12)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Write a comment...',
                                hintStyle: const TextStyle(color: Colors.white54),
                                filled: true,
                                fillColor: const Color(0xFF0F151A),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(color: Colors.white24),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: const BorderSide(color: Colors.white24),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: const Color(0xFF2DE091),
                            child: IconButton(
                              onPressed: () {
                                final text = controller.text.trim();
                                if (text.isEmpty) {
                                  return;
                                }
                                setState(() {
                                  comments.insert(0, text);
                                  post['comments'] = (post['comments'] as int) + 1;
                                });
                                modalSetState(() {});
                                controller.clear();
                              },
                              icon: const Icon(Icons.send_rounded, color: Colors.black, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(controller.dispose);
  }

  void _sharePost() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post shared'), backgroundColor: Color(0xFF31D6FF)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12181D),
        title: const Text('Seller Feed'),
      ),
      body: PageView.builder(
        controller: _controller,
        scrollDirection: Axis.vertical,
        itemCount: widget.posts.length,
        onPageChanged: (value) => setState(() => _current = value),
        itemBuilder: (context, index) {
          final post = widget.posts[index];
          final liked = post['liked'] as bool;
          final comments = post['commentList'] as List<String>;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF151D23),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(post['image'] as String, height: 320, width: double.infinity, fit: BoxFit.cover),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post['caption'] as String, style: const TextStyle(color: Colors.white70)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => _toggleLike(index),
                              icon: Icon(liked ? Icons.favorite : Icons.favorite_border, color: liked ? Colors.redAccent : Colors.white70),
                            ),
                            Text(_formatCount(post['likes'] as int), style: const TextStyle(color: Colors.white70)),
                            const SizedBox(width: 12),
                            IconButton(
                              onPressed: () => _openCommentSheet(index),
                              icon: const Icon(Icons.mode_comment_outlined, color: Colors.white70),
                            ),
                            Text(_formatCount(post['comments'] as int), style: const TextStyle(color: Colors.white70)),
                            const Spacer(),
                            IconButton(
                              onPressed: _sharePost,
                              icon: const Icon(Icons.share_outlined, color: Colors.white70),
                            ),
                          ],
                        ),
                        if (comments.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          const Text('Comments', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 6),
                          ...comments.take(3).map(
                            (text) => Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: Text('• $text', style: const TextStyle(color: Colors.white60, fontSize: 12)),
                            ),
                          ),
                        ],
                        const SizedBox(height: 4),
                        Text(
                          'Post ${_current + 1} of ${widget.posts.length} • Swipe up/down for more',
                          style: const TextStyle(color: Colors.white38, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoLine({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF31D6FF), size: 18),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

class NabtCartCheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> initialItems;
  const NabtCartCheckoutPage({super.key, this.initialItems = const []});

  @override
  State<NabtCartCheckoutPage> createState() => _NabtCartCheckoutPageState();
}

class _NabtCartCheckoutPageState extends State<NabtCartCheckoutPage> {
  late List<Map<String, dynamic>> _items;
  String _paymentMethod = 'baridimob';

  String? _selectedWilaya;
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  String _savedAddress = '';

  final List<String> _wilayas = const [
    'Adrar',
    'Chlef',
    'Laghouat',
    'Oum El Bouaghi',
    'Batna',
    'Béjaïa',
    'Biskra',
    'Béchar',
    'Blida',
    'Bouira',
    'Tamanrasset',
    'Tébessa',
    'Tlemcen',
    'Tiaret',
    'Tizi Ouzou',
    'Algiers',
    'Djelfa',
    'Jijel',
    'Sétif',
    'Saïda',
    'Skikda',
    'Sidi Bel Abbès',
    'Annaba',
    'Guelma',
    'Constantine',
    'Médéa',
    'Mostaganem',
    'M’Sila',
    'Mascara',
    'Ouargla',
    'Oran',
    'El Bayadh',
    'Illizi',
    'Bordj Bou Arreridj',
    'Boumerdès',
    'El Tarf',
    'Tindouf',
    'Tissemsilt',
    'El Oued',
    'Khenchela',
    'Souk Ahras',
    'Tipaza',
    'Mila',
    'Aïn Defla',
    'Naâma',
    'Aïn Témouchent',
    'Ghardaïa',
    'Relizane',
    'Timimoun',
    'Bordj Badji Mokhtar',
    'Ouled Djellal',
    'Béni Abbès',
    'In Salah',
    'In Guezzam',
    'Touggourt',
    'Djanet',
    'El M’Ghair',
    'El Menia',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialItems.isNotEmpty) {
      for (final item in widget.initialItems) {
        NabtCartStore.addToCart(Map<String, dynamic>.from(item));
      }
    }
    _items = List<Map<String, dynamic>>.from(NabtCartStore.cartItems);
    for (final item in _items) {
      item.putIfAbsent('selected', () => false);
    }
  }

  @override
  void dispose() {
    _regionController.dispose();
    _streetController.dispose();
    super.dispose();
  }

  void _syncCart() {
    NabtCartStore.cartItems
      ..clear()
      ..addAll(_items);
  }

    List<Map<String, dynamic>> get _selectedItems =>
      _items.where((item) => (item['selected'] as bool?) ?? false).toList();

    double get _subtotal =>
      _selectedItems.fold(0, (sum, e) => sum + (e['price'] as double) * (e['qty'] as int));
  double get _discount => _paymentMethod == 'baridimob' ? _subtotal * 0.1 : 0;
  double get _total => _subtotal - _discount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      appBar: AppBar(backgroundColor: const Color(0xFF12181D), title: const Text('Cart & Checkout - السلة والدفع')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ..._items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: const Color(0xFF151D23), borderRadius: BorderRadius.circular(18)),
              child: Row(children: [
                Checkbox(
                  value: (item['selected'] as bool?) ?? false,
                  activeColor: const Color(0xFF2DE091),
                  checkColor: Colors.black,
                  side: const BorderSide(color: Colors.white38),
                  onChanged: (value) {
                    setState(() {
                      _items[index]['selected'] = value ?? false;
                      _syncCart();
                    });
                  },
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(item['image'], width: 60, height: 60, fit: BoxFit.cover),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(item['title'], style: const TextStyle(color: Colors.white, fontSize: 13))),
                Row(children: [
                  IconButton(
                    onPressed: () => setState(() {
                      if (_items[index]['qty'] > 1) _items[index]['qty']--;
                      NabtCartStore.updateQuantity(index, _items[index]['qty'] as int);
                    }),
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.white70),
                  ),
                  Text('${item['qty']}', style: const TextStyle(color: Colors.white)),
                  IconButton(
                    onPressed: () => setState(() {
                      _items[index]['qty']++;
                      NabtCartStore.updateQuantity(index, _items[index]['qty'] as int);
                    }),
                    icon: const Icon(Icons.add_circle_outline, color: Color(0xFF2DE091)),
                  ),
                  IconButton(
                    onPressed: () => setState(() {
                      _items.removeAt(index);
                      NabtCartStore.removeAt(index);
                    }),
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                  ),
                ]),
              ]),
            );
          }),
          if (_items.isEmpty)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: const Color(0xFF151D23), borderRadius: BorderRadius.circular(18)),
              child: const Row(
                children: [
                  Icon(Icons.shopping_cart_outlined, color: Colors.white54),
                  SizedBox(width: 10),
                  Text('Cart is empty - السلة فارغة', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0x331A2530),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white24),
            ),
            child: Column(children: [
              _totalRow('Subtotal', '${_subtotal.toStringAsFixed(0)} DZD'),
              _totalRow('BaridiMob Discount', '- ${_discount.toStringAsFixed(0)} DZD', highlight: _discount > 0),
              const Divider(color: Colors.white24),
              _totalRow('Total', '${_total.toStringAsFixed(0)} DZD', bold: true),
            ]),
          ),
          const SizedBox(height: 14),
          const Text('اختيار طريقة الدفع (Choose Payment Method)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _paymentCard('edahabia', 'Edahabia - الذهبية', const Color(0xFFFFC857), Icons.credit_card),
          _paymentCard('baridimob', 'BaridiMob - بريد موب', const Color(0xFF31D6FF), Icons.phone_android),
          _paymentCard('cod', 'Cash on Delivery - دفع عند الاستلام', const Color(0xFFE95F5F), Icons.local_shipping),
          const SizedBox(height: 14),
          const Text('Delivery Address - عنوان التوصيل', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF151D23),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_savedAddress.isEmpty) ...[
                  const Text('Choose Wilaya - اختر الولاية', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedWilaya,
                    items: _wilayas
                        .map((wilaya) => DropdownMenuItem<String>(
                              value: wilaya,
                              child: Text(wilaya, style: const TextStyle(color: Colors.white)),
                            ))
                        .toList(),
                    dropdownColor: const Color(0xFF151D23),
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Select wilaya',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF0F151A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                    ),
                    onChanged: (value) => setState(() => _selectedWilaya = value),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _regionController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Region / Commune - المنطقة',
                      labelStyle: const TextStyle(color: Colors.white60),
                      filled: true,
                      fillColor: const Color(0xFF0F151A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _streetController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Street / Farm details - الشارع / تفاصيل المزرعة',
                      labelStyle: const TextStyle(color: Colors.white60),
                      filled: true,
                      fillColor: const Color(0xFF0F151A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        if (_selectedWilaya == null || _regionController.text.trim().isEmpty || _streetController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please complete wilaya, region and street'), backgroundColor: Colors.orange),
                          );
                          return;
                        }
                        setState(() {
                          _savedAddress = '${_selectedWilaya!}, ${_regionController.text.trim()}, ${_streetController.text.trim()}';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Address saved successfully - تم حفظ العنوان'), backgroundColor: Color(0xFF2DE091)),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF2DE091)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.save_alt, color: Color(0xFF2DE091)),
                      label: const Text('Save Full Address', style: TextStyle(color: Color(0xFF2DE091))),
                    ),
                  ),
                ] else ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F151A),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFF2DE091).withValues(alpha: 0.35)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.location_on_outlined, color: Color(0xFF2DE091), size: 18),
                            SizedBox(width: 6),
                            Text('Saved Delivery Address', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(_savedAddress, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: () {
                              setState(() {
                                _savedAddress = '';
                              });
                            },
                            icon: const Icon(Icons.edit_outlined, color: Color(0xFF31D6FF), size: 18),
                            label: const Text('Edit', style: TextStyle(color: Color(0xFF31D6FF))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _syncCart();
                if (_items.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please add products first - أضف منتجات أولاً'), backgroundColor: Colors.red),
                  );
                  return;
                }
                if (_selectedItems.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select products first - اختر المنتجات أولاً'), backgroundColor: Colors.orange),
                  );
                  return;
                }
                if (_savedAddress.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please save your address before paying'), backgroundColor: Colors.orange),
                  );
                  return;
                }
                NabtCartStore.cartItems
                  ..clear()
                  ..addAll(_selectedItems.map((item) => Map<String, dynamic>.from(item)));
                NabtCartStore.payAll(
                  paymentMethod: _paymentMethod,
                  wilaya: _selectedWilaya!,
                  region: _regionController.text.trim(),
                  street: _streetController.text.trim(),
                  fullAddress: _savedAddress,
                );
                _items.removeWhere((item) => (item['selected'] as bool?) ?? false);
                NabtCartStore.cartItems
                  ..clear()
                  ..addAll(_items.map((item) => Map<String, dynamic>.from(item)));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order confirmed - تم تأكيد الطلب'), backgroundColor: Color(0xFF2DE091)),
                );
                setState(() {
                  _items = List<Map<String, dynamic>>.from(NabtCartStore.cartItems);
                  _savedAddress = '';
                  _selectedWilaya = null;
                  _regionController.clear();
                  _streetController.clear();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2DE091),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text('Confirm & Pay - تأكيد والدفع'),
            ),
          ),
          const SizedBox(height: 16),
          if (NabtCartStore.paidPurchases.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF2DE091).withValues(alpha: 0.15),
                    const Color(0xFF31D6FF).withValues(alpha: 0.12),
                  ],
                ),
                border: Border.all(color: const Color(0xFF2DE091).withValues(alpha: 0.35)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.history_edu_rounded, color: Color(0xFF2DE091)),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Saved Purchases - المشتريات المحفوظة',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F151A),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Text(
                      '${NabtCartStore.paidPurchases.length}',
                      style: const TextStyle(color: Color(0xFF31D6FF), fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            ...NabtCartStore.paidPurchases.take(5).map((purchase) => _buildSavedPurchaseCard(purchase)),
          ]
        ]),
      ),
    );
  }

  Widget _buildSavedPurchaseCard(Map<String, dynamic> purchase) {
    final String title = (purchase['title'] ?? 'Purchase').toString();
    final String image = (purchase['image'] ?? '').toString();
    final String paymentMethod = (purchase['paymentMethod'] ?? '').toString();
    final String wilaya = (purchase['wilaya'] ?? '').toString();
    final String fullAddress = (purchase['fullAddress'] ?? '').toString();
    final String date = (purchase['paidAt'] ?? '').toString();
    final int qty = purchase['qty'] is int ? purchase['qty'] as int : 1;
    final double price = purchase['price'] is double ? purchase['price'] as double : 0;
    final double total = qty * price;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF151D23),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF2DE091).withValues(alpha: 0.28)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2DE091).withValues(alpha: 0.09),
            blurRadius: 12,
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: image.isNotEmpty
                    ? Image.network(image, width: 54, height: 54, fit: BoxFit.cover)
                    : Container(
                        width: 54,
                        height: 54,
                        color: const Color(0xFF0F151A),
                        child: const Icon(Icons.inventory_2_outlined, color: Colors.white54),
                      ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${total.toStringAsFixed(0)} DZD',
                      style: const TextStyle(color: Color(0xFF2DE091), fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF2DE091).withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('PAID', style: TextStyle(color: Color(0xFF2DE091), fontSize: 11, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _metaChip(Icons.payments_outlined, paymentMethod),
              _metaChip(Icons.location_city, wilaya),
              _metaChip(Icons.calendar_month_outlined, date),
              _metaChip(Icons.numbers, 'Qty $qty'),
            ],
          ),
          if (fullAddress.isNotEmpty) ...[
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(Icons.home_work_outlined, size: 14, color: Colors.white54),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    fullAddress,
                    style: const TextStyle(color: Colors.white60, fontSize: 11),
                  ),
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }

  Widget _metaChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF0F151A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFF31D6FF)),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _paymentCard(String id, String title, Color accent, IconData icon) {
    final active = _paymentMethod == id;
    return GestureDetector(
      onTap: () => setState(() => _paymentMethod = id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF151D23),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: active ? accent : Colors.white24, width: active ? 2 : 1),
        ),
        child: Row(children: [
          Icon(icon, color: accent),
          const SizedBox(width: 10),
          Expanded(child: Text(title, style: const TextStyle(color: Colors.white))),
          Icon(active ? Icons.radio_button_checked : Icons.radio_button_off, color: active ? accent : Colors.white38),
        ]),
      ),
    );
  }

  Widget _totalRow(String label, String value, {bool bold = false, bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white70, fontWeight: bold ? FontWeight.bold : FontWeight.w400)),
          Text(value, style: TextStyle(color: highlight ? const Color(0xFF31D6FF) : Colors.white, fontWeight: bold ? FontWeight.bold : FontWeight.w500)),
        ],
      ),
    );
  }
}

class NabtCommunityForumPage extends StatefulWidget {
  const NabtCommunityForumPage({super.key});

  @override
  State<NabtCommunityForumPage> createState() => _NabtCommunityForumPageState();
}

class _NabtCommunityForumPageState extends State<NabtCommunityForumPage> {
  final TextEditingController _askController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final ImagePicker _communityImagePicker = ImagePicker();
  final List<String> _topics = const ['All', 'Disease', 'Irrigation', 'Market', 'Soil'];
  String _selected = 'All';
  String _search = '';
  final List<String> _composerImages = [];

  final List<Map<String, dynamic>> _posts = [
    {
      'user': 'Ahmed from Mascara',
      'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500&q=80',
      'location': 'Mascara, Algeria',
      'topic': 'Disease',
      'question': 'Leaves are turning yellow with rusty dots. What should I apply?',
      'time': '12m',
      'likes': 18,
      'comments': [
        {'user': 'Nabt Support', 'text': 'Use copper fungicide once every 7 days and remove infected leaves.'},
      ],
      'liked': false,
      'saved': false,
      'images': [
        'https://images.unsplash.com/photo-1471193945509-9ad0617afabf?w=300&q=80',
        'https://images.unsplash.com/photo-1444858291040-58f756a3bdd6?w=300&q=80',
      ],
    },
    {
      'user': 'Fatima from Blida',
      'avatar': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500&q=80',
      'location': 'Blida, Algeria',
      'topic': 'Irrigation',
      'question': 'Best drip schedule for olive seedlings in spring?',
      'time': '1h',
      'likes': 26,
      'comments': [
        {'user': 'Farmer Karim', 'text': 'Start with short morning cycles and monitor soil moisture.'},
      ],
      'liked': false,
      'saved': true,
      'images': [
        'https://images.unsplash.com/photo-1464226184884-fa280b87c399?w=300&q=80',
      ],
    },
    {
      'user': 'Nora from Setif',
      'avatar': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=500&q=80',
      'location': 'Setif, Algeria',
      'topic': 'Market',
      'question': 'Where can I find reliable organic fertilizer suppliers this month?',
      'time': '3h',
      'likes': 11,
      'comments': [],
      'liked': false,
      'saved': false,
      'images': [
        'https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?w=300&q=80',
      ],
    },
  ];

  List<Map<String, dynamic>> get _visiblePosts {
    final byTopic = _selected == 'All' ? _posts : _posts.where((post) => post['topic'] == _selected).toList();
    if (_search.trim().isEmpty) return byTopic;
    final query = _search.toLowerCase();
    return byTopic.where((post) {
      final question = (post['question'] as String).toLowerCase();
      final user = (post['user'] as String).toLowerCase();
      final topic = (post['topic'] as String).toLowerCase();
      return question.contains(query) || user.contains(query) || topic.contains(query);
    }).toList();
  }

  void _toggleLike(Map<String, dynamic> post) {
    setState(() {
      final bool isLiked = (post['liked'] as bool?) ?? false;
      post['liked'] = !isLiked;
      post['likes'] = ((post['likes'] as int?) ?? 0) + (isLiked ? -1 : 1);
    });
  }

  void _toggleSave(Map<String, dynamic> post) {
    setState(() {
      post['saved'] = !((post['saved'] as bool?) ?? false);
    });
  }

  void _sharePost(Map<String, dynamic> post) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Shared: ${post['question']}')),
    );
  }

  void _openCommunityProfile(Map<String, dynamic> post) {
    final farmerData = {
      'name': post['user'] ?? 'Farmer',
      'farmName': post['topic'] != null ? '${post['topic']} Expert' : (post['user'] ?? 'Farm Profile'),
      'image': post['avatar'] ?? 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=500&q=80',
      'location': post['location'] ?? 'Algeria',
      'followers': ((post['likes'] as int?) ?? 0).toString(),
      'crops': post['question'] ?? 'Farming knowledge sharing',
      'farmSize': 'Community Member',
    };
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FarmerProfilePage(farmerData: farmerData)),
    );
  }

  void _openMyCommunityProfile() {
    final farmerData = {
      'name': 'rahma chemali',
      'farmName': 'rahma farm',
      'image': 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=500&q=80',
      'location': 'setif',
      'followers': '0',
      'crops': 'My community posts and updates',
      'farmSize': 'Community Member',
    };
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FarmerProfilePage(farmerData: farmerData)),
    );
  }

  Future<void> _pickComposerImage(ImageSource source) async {
    try {
      final image = await _communityImagePicker.pickImage(source: source, imageQuality: 85);
      if (image == null || !mounted) return;
      setState(() {
        _composerImages.add(image.path);
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to pick image right now')),
      );
    }
  }

  void _openComposerCameraSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF151D23),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined, color: Color(0xFF2DE091)),
                  title: const Text('Take Photo', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                    _pickComposerImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined, color: Color(0xFF31D6FF)),
                  title: const Text('Choose from Gallery', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                    _pickComposerImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openCommunityImagePreview(String path) {
    final bool isNetwork = path.startsWith('http://') || path.startsWith('https://');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Center(
            child: InteractiveViewer(
              minScale: 1,
              maxScale: 4,
              child: isNetwork
                  ? Image.network(path, fit: BoxFit.contain)
                  : Image.file(File(path), fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }

  Widget _communityImageThumb(String path, {double width = 90, double height = 90, VoidCallback? onTap}) {
    final bool isNetwork = path.startsWith('http://') || path.startsWith('https://');
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: isNetwork
            ? Image.network(path, width: width, height: height, fit: BoxFit.cover)
            : Image.file(File(path), width: width, height: height, fit: BoxFit.cover),
      ),
    );
  }

  void _openComments(Map<String, dynamic> post) {
    final commentController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF151D23),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, modalSetState) {
            final comments = (post['comments'] as List<dynamic>);
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.62,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(width: 46, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10))),
                    const SizedBox(height: 12),
                    const Text('Comments', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                    const SizedBox(height: 10),
                    Expanded(
                      child: comments.isEmpty
                          ? const Center(child: Text('No comments yet', style: TextStyle(color: Colors.white54)))
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                final comment = Map<String, dynamic>.from(comments[index] as Map);
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const CircleAvatar(radius: 14, backgroundColor: Color(0xFF31D6FF), child: Icon(Icons.person, size: 13, color: Colors.black)),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(color: const Color(0xFF0F151A), borderRadius: BorderRadius.circular(10)),
                                          child: RichText(
                                            text: TextSpan(
                                              style: const TextStyle(color: Colors.white70, fontSize: 12),
                                              children: [
                                                TextSpan(
                                                  text: '${comment['user']}: ',
                                                  style: const TextStyle(color: Color(0xFF2DE091), fontWeight: FontWeight.w600),
                                                ),
                                                TextSpan(text: (comment['text'] ?? '').toString()),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: commentController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Write a comment...',
                                hintStyle: const TextStyle(color: Colors.white54),
                                filled: true,
                                fillColor: const Color(0xFF0F151A),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(color: Colors.white24),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  borderSide: const BorderSide(color: Colors.white24),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              final text = commentController.text.trim();
                              if (text.isEmpty) return;
                              modalSetState(() {
                                comments.add({'user': 'You', 'text': text});
                              });
                              setState(() {});
                              commentController.clear();
                            },
                            icon: const Icon(Icons.send_rounded, color: Color(0xFF2DE091)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _createPost() {
    final questionController = TextEditingController();
    String selectedTopic = _topics[1];
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF151D23),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, modalSetState) {
            return Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Create Post', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: _topics.where((topic) => topic != 'All').map((topic) {
                      final active = selectedTopic == topic;
                      return ChoiceChip(
                        label: Text(topic),
                        selected: active,
                        onSelected: (_) => modalSetState(() => selectedTopic = topic),
                        selectedColor: const Color(0xFF2DE091),
                        backgroundColor: const Color(0xFF0F151A),
                        labelStyle: TextStyle(color: active ? Colors.black : Colors.white70),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: questionController,
                    maxLines: 4,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Write your question...',
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: const Color(0xFF0F151A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final question = questionController.text.trim();
                        if (question.isEmpty) return;
                        setState(() {
                          _posts.insert(0, {
                            'user': 'You',
                            'avatar': 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=500&q=80',
                            'location': 'Algeria',
                            'topic': selectedTopic,
                            'question': question,
                            'time': 'now',
                            'likes': 0,
                            'comments': <Map<String, String>>[],
                            'liked': false,
                            'saved': false,
                            'images': <String>[],
                          });
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2DE091),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Post Now'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _askController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12181D),
        title: const Text('Nabt Community', style: TextStyle(fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            onPressed: _createPost,
            icon: const Icon(Icons.add_circle_outline, color: Color(0xFF2DE091)),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: _openMyCommunityProfile,
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage('https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=500&q=80'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(color: const Color(0xFF151D23), borderRadius: BorderRadius.circular(16)),
                        child: TextField(
                          controller: _askController,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Ask the community... (tap send to post)',
                            hintStyle: TextStyle(color: Colors.white38, fontSize: 12),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        final text = _askController.text.trim();
                        if (text.isEmpty && _composerImages.isEmpty) return;
                        setState(() {
                          _posts.insert(0, {
                            'user': 'You',
                            'avatar': 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=500&q=80',
                            'location': 'Algeria',
                            'topic': _selected == 'All' ? 'Disease' : _selected,
                            'question': text.isEmpty ? 'Shared photos from my farm 🌿' : text,
                            'time': 'now',
                            'likes': 0,
                            'comments': <Map<String, String>>[],
                            'liked': false,
                            'saved': false,
                            'images': List<String>.from(_composerImages),
                          });
                          _composerImages.clear();
                        });
                        _askController.clear();
                      },
                      icon: const Icon(Icons.send_rounded, color: Color(0xFF2DE091)),
                    ),
                    IconButton(
                      onPressed: _openComposerCameraSheet,
                      icon: const Icon(Icons.camera_alt_rounded, color: Color(0xFF31D6FF)),
                    ),
                  ],
                ),
                if (_composerImages.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 58,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _composerImages.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final imagePath = _composerImages[index];
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            _communityImageThumb(imagePath, width: 58, height: 58),
                            Positioned(
                              right: -6,
                              top: -6,
                              child: GestureDetector(
                                onTap: () => setState(() => _composerImages.removeAt(index)),
                                child: Container(
                                  width: 18,
                                  height: 18,
                                  decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
                                  child: const Icon(Icons.close, size: 12, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(color: const Color(0xFF151D23), borderRadius: BorderRadius.circular(14)),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _search = value),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Search posts by user, topic, or question',
                      hintStyle: TextStyle(color: Colors.white54, fontSize: 12),
                      prefixIcon: Icon(Icons.search, color: Colors.white54),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 38,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final topic = _topics[index];
                final active = _selected == topic;
                return ChoiceChip(
                  label: Text(topic),
                  selected: active,
                  onSelected: (_) => setState(() => _selected = topic),
                  selectedColor: const Color(0xFF2DE091),
                  labelStyle: TextStyle(color: active ? Colors.black : Colors.white70),
                  backgroundColor: const Color(0xFF151D23),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemCount: _topics.length,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              itemCount: _visiblePosts.length,
              itemBuilder: (context, index) {
                final post = _visiblePosts[index];
                final images = (post['images'] as List<dynamic>).cast<String>();
                final comments = (post['comments'] as List<dynamic>);
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF151D23),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      GestureDetector(
                        onTap: () => _openCommunityProfile(post),
                        child: CircleAvatar(radius: 18, backgroundImage: NetworkImage(post['avatar'] as String)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _openCommunityProfile(post),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(post['user'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            Text('${post['location']} • ${post['time']}', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                          ]),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F151A),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Text(
                          post['topic'] as String,
                          style: const TextStyle(color: Color(0xFF31D6FF), fontSize: 10, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 10),
                    Text(post['question'], style: const TextStyle(color: Colors.white70)),
                    if (images.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: images.map((image) {
                          return _communityImageThumb(
                            image,
                            onTap: () => _openCommunityImagePreview(image),
                          );
                        }).toList(),
                      ),
                    ],
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _postAction(
                          icon: (post['liked'] as bool) ? Icons.favorite : Icons.favorite_border,
                          label: '${post['likes']}',
                          color: (post['liked'] as bool) ? Colors.redAccent : const Color(0xFF31D6FF),
                          onTap: () => _toggleLike(post),
                        ),
                        _postAction(
                          icon: Icons.chat_bubble_outline,
                          label: '${comments.length}',
                          onTap: () => _openComments(post),
                        ),
                        _postAction(
                          icon: (post['saved'] as bool) ? Icons.bookmark : Icons.bookmark_border,
                          label: 'Save',
                          onTap: () => _toggleSave(post),
                        ),
                        _postAction(
                          icon: Icons.share_outlined,
                          label: 'Share',
                          onTap: () => _sharePost(post),
                        ),
                      ],
                    )
                  ]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _postAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = const Color(0xFF31D6FF),
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF0F151A),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 5),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  final bool compact;

  const WeatherWidget({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = compact ? 10.0 : 12.0;
    final verticalPadding = compact ? 8.0 : 10.0;
    final weatherFont = compact ? 16.0 : 18.0;
    final maxWidth = compact ? 118.0 : 170.0;

    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Météo', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text('18°C', style: TextStyle(color: Colors.white, fontSize: weatherFont, fontWeight: FontWeight.bold)),
          const Text(
            'Algiers • Clear Sky',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class MeteoPage extends StatefulWidget {
  const MeteoPage({super.key});

  @override
  State<MeteoPage> createState() => _MeteoPageState();
}

class _MeteoPageState extends State<MeteoPage> {
  final List<String> _regions = const [
    'Algiers',
    'Oran',
    'Blida',
    'Constantine',
    'Setif',
    'Tlemcen',
    'Annaba',
  ];

  final List<Map<String, dynamic>> _weatherTypes = const [
    {'label': 'Sunny', 'icon': Icons.wb_sunny_rounded, 'color': Color(0xFFFFC857)},
    {'label': 'Cloudy', 'icon': Icons.cloud_rounded, 'color': Color(0xFF9BB0C8)},
    {'label': 'Rain', 'icon': Icons.grain_rounded, 'color': Color(0xFF5CA8FF)},
    {'label': 'Windy', 'icon': Icons.air_rounded, 'color': Color(0xFF7CD7D1)},
  ];

  String _selectedRegion = 'Algiers';

  int get _regionSeed => _regions.indexOf(_selectedRegion) + 1;

  List<Map<String, dynamic>> _buildWeeklyForecast() {
    final now = DateTime.now();
    return List.generate(7, (index) {
      final day = now.add(Duration(days: index));
      final int typeIndex = (_regionSeed + index) % _weatherTypes.length;
      final weather = _weatherTypes[typeIndex];
      final int maxTemp = 19 + ((_regionSeed * 2 + index * 3) % 16);
      final int minTemp = maxTemp - (4 + ((_regionSeed + index) % 4));
      final int humidity = 40 + ((_regionSeed * 11 + index * 9) % 45);

      return {
        'dayName': _weekdayName(day.weekday),
        'date': '${day.day}/${day.month}',
        'max': maxTemp,
        'min': minTemp,
        'humidity': humidity,
        'weather': weather,
      };
    });
  }

  String _weekdayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[(weekday - 1).clamp(0, 6)];
  }

  @override
  Widget build(BuildContext context) {
    final weekly = _buildWeeklyForecast();
    final today = weekly.first;
    final todayWeather = today['weather'] as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12181D),
        elevation: 0,
        title: const Text('Meteo Forecast', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF151D23),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white24),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                dropdownColor: const Color(0xFF151D23),
                value: _selectedRegion,
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white70),
                style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                items: _regions.map((region) {
                  return DropdownMenuItem<String>(
                    value: region,
                    child: Text(region),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() => _selectedRegion = value);
                },
              ),
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF2DE091).withValues(alpha: 0.28),
                  const Color(0xFF31D6FF).withValues(alpha: 0.24),
                  const Color(0xFF151D23),
                ],
              ),
              border: Border.all(color: Colors.white24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF31D6FF).withValues(alpha: 0.12),
                  blurRadius: 18,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_selectedRegion, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(
                        todayWeather['label'] as String,
                        style: const TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${today['max']}°',
                        style: const TextStyle(color: Colors.white, fontSize: 44, fontWeight: FontWeight.w700, height: 0.9),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Min ${today['min']}° • Humidity ${today['humidity']}%',
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 78,
                  height: 78,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    todayWeather['icon'] as IconData,
                    color: todayWeather['color'] as Color,
                    size: 42,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Weekly Forecast',
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          ...weekly.map((day) {
            final weather = day['weather'] as Map<String, dynamic>;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF151D23),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 74,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(day['dayName'] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        Text(day['date'] as String, style: const TextStyle(color: Colors.white54, fontSize: 11)),
                      ],
                    ),
                  ),
                  Icon(weather['icon'] as IconData, color: weather['color'] as Color, size: 24),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      weather['label'] as String,
                      style: const TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ),
                  Text(
                    '${day['max']}° / ${day['min']}°',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class ModernSavedItemsPage extends StatefulWidget {
  const ModernSavedItemsPage({super.key});

  @override
  State<ModernSavedItemsPage> createState() => _ModernSavedItemsPageState();
}

class _ModernSavedItemsPageState extends State<ModernSavedItemsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  String _search = '';

  final List<Map<String, dynamic>> _savedItems = [
    {
      'name': 'Organic Monstera Kit',
      'price': 4500.0,
      'category': 'Plants',
      'image': 'https://images.unsplash.com/photo-1614594975525-e45190c55d0b?w=900&q=80',
      'seller': 'Green Garden Store',
      'rating': 4.8,
    },
    {
      'name': 'Premium Potting Mix',
      'price': 1200.0,
      'category': 'Soil',
      'image': 'https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?w=900&q=80',
      'seller': 'Nabt Supplies',
      'rating': 4.6,
    },
    {
      'name': 'Smart Drip Kit',
      'price': 7600.0,
      'category': 'Irrigation',
      'image': 'https://images.unsplash.com/photo-1464226184884-fa280b87c399?w=900&q=80',
      'seller': 'Irrigate DZ',
      'rating': 4.7,
    },
    {
      'name': 'Tomato Seed Pack',
      'price': 900.0,
      'category': 'Seeds',
      'image': 'https://images.unsplash.com/photo-1592921570552-8ac1b3f63f11?w=900&q=80',
      'seller': 'Farmer Ahmed',
      'rating': 4.5,
    },
  ];

  List<String> get _categories {
    final set = {'All', ..._savedItems.map((item) => item['category'].toString())};
    return set.toList();
  }

  List<Map<String, dynamic>> get _filteredItems {
    var list = _savedItems;
    if (_selectedCategory != 'All') {
      list = list.where((item) => item['category'] == _selectedCategory).toList();
    }
    if (_search.trim().isNotEmpty) {
      final query = _search.toLowerCase();
      list = list.where((item) {
        final name = item['name'].toString().toLowerCase();
        final seller = item['seller'].toString().toLowerCase();
        return name.contains(query) || seller.contains(query);
      }).toList();
    }
    return list;
  }

  Widget _buildImage(String source) {
    if (source.startsWith('http://') || source.startsWith('https://')) {
      return Image.network(source, fit: BoxFit.cover);
    }
    return Image.file(File(source), fit: BoxFit.cover);
  }

  void _openItemDetails(Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NabtProductDetailsPage(
          product: {
            'name': item['name'].toString(),
            'image': item['image'].toString(),
            'category': item['category'].toString(),
          },
        ),
      ),
    );
  }

  void _addItemToCart(Map<String, dynamic> item) {
    NabtCartStore.addToCart({
      'title': item['name'].toString(),
      'image': item['image'].toString(),
      'price': (item['price'] as num).toDouble(),
      'qty': 1,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item['name']} added to cart')),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visible = _filteredItems;
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12181D),
        title: const Text('Saved Items', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF31D6FF).withValues(alpha: 0.22),
                        const Color(0xFF2DE091).withValues(alpha: 0.20),
                      ],
                    ),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFF12181D),
                        child: Icon(Icons.bookmark, color: Color(0xFF2DE091)),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Your Wishlist', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            Text('${_savedItems.length} saved products', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const NabtCartCheckoutPage())),
                        child: const Text('Open Cart', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(color: const Color(0xFF151D23), borderRadius: BorderRadius.circular(14)),
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => setState(() => _search = value),
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Search saved items',
                      hintStyle: TextStyle(color: Colors.white54),
                      prefixIcon: Icon(Icons.search, color: Colors.white54),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 38,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final active = category == _selectedCategory;
                return ChoiceChip(
                  label: Text(category),
                  selected: active,
                  onSelected: (_) => setState(() => _selectedCategory = category),
                  selectedColor: const Color(0xFF2DE091),
                  backgroundColor: const Color(0xFF151D23),
                  labelStyle: TextStyle(color: active ? Colors.black : Colors.white70),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemCount: _categories.length,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: visible.isEmpty
                ? const Center(
                    child: Text('No saved items found', style: TextStyle(color: Colors.white54)),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 2, 16, 18),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 285,
                    ),
                    itemCount: visible.length,
                    itemBuilder: (context, index) {
                      final item = visible[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF151D23),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => _openItemDetails(item),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                child: SizedBox(
                                  height: 130,
                                  width: double.infinity,
                                  child: _buildImage(item['image'].toString()),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'].toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item['seller'].toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.white60, fontSize: 11),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(Icons.star_rounded, color: Color(0xFF2DE091), size: 15),
                                      const SizedBox(width: 4),
                                      Text('${item['rating']}', style: const TextStyle(color: Colors.white70, fontSize: 11)),
                                      const Spacer(),
                                      Text(
                                        '${(item['price'] as num).toStringAsFixed(0)} DZD',
                                        style: const TextStyle(color: Color(0xFF2DE091), fontWeight: FontWeight.bold, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          height: 32,
                                          child: OutlinedButton(
                                            onPressed: () => setState(() => _savedItems.remove(item)),
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(color: Colors.white24),
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              padding: EdgeInsets.zero,
                                            ),
                                            child: const Icon(Icons.bookmark_remove_outlined, color: Colors.white70, size: 16),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        flex: 2,
                                        child: SizedBox(
                                          height: 32,
                                          child: ElevatedButton(
                                            onPressed: () => _addItemToCart(item),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(0xFF2DE091),
                                              foregroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                              padding: EdgeInsets.zero,
                                            ),
                                            child: const Text('Add', style: TextStyle(fontWeight: FontWeight.w700)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class HomeMessagesPage extends StatefulWidget {
  const HomeMessagesPage({super.key});

  @override
  State<HomeMessagesPage> createState() => _HomeMessagesPageState();
}

class _HomeMessagesPageState extends State<HomeMessagesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _conversations = [
    {
      'name': 'Green Garden Store',
      'avatar': 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=500&q=80',
      'message': 'Your Monstera order is ready for delivery.',
      'time': '2m',
      'isOnline': true,
      'unreadCount': 2,
      'role': 'Verified Seller',
      'location': 'Oran, Algeria',
      'bio': 'Premium agricultural products, indoor plants, and organic kits for all farmers.',
      'followers': '8.2k',
      'following': '642',
      'postsCount': '156',
      'rating': '4.9',
      'responseTime': '~2 minutes',
      'gallery': [
        'https://images.unsplash.com/photo-1463320726281-696a485928c7?w=900&q=80',
        'https://images.unsplash.com/photo-1492496913980-501348b61469?w=900&q=80',
        'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=900&q=80',
        'https://images.unsplash.com/photo-1614594975525-e45190c55d0b?w=900&q=80',
      ],
      'products': [
        {'name': 'Organic Monstera Kit', 'price': '4,500 DZD', 'image': 'https://images.unsplash.com/photo-1614594975525-e45190c55d0b?w=900&q=80'},
        {'name': 'Premium Potting Mix', 'price': '1,200 DZD', 'image': 'https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?w=900&q=80'},
      ],
      'messages': [
        {'text': 'Hello! Your order is packed and ready.', 'isMe': false},
        {'text': 'Great, thank you. When will it arrive?', 'isMe': true},
      ],
    },
    {
      'name': 'Nabt Support',
      'avatar': 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=500&q=80',
      'message': 'We found a new care guide for your plants 🌿',
      'time': '1h',
      'isOnline': true,
      'unreadCount': 0,
      'role': 'Nabt Team',
      'location': 'Algiers, Algeria',
      'bio': 'Official support for diagnosis, care guides, and smart farming assistance.',
      'followers': '5.4k',
      'following': '120',
      'postsCount': '78',
      'rating': '4.8',
      'responseTime': '~5 minutes',
      'gallery': [
        'https://images.unsplash.com/photo-1464226184884-fa280b87c399?w=900&q=80',
        'https://images.unsplash.com/photo-1471193945509-9ad0617afabf?w=900&q=80',
        'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=900&q=80',
        'https://images.unsplash.com/photo-1466692476868-aef1dfb1e735?w=900&q=80',
      ],
      'products': [
        {'name': 'Plant Care Ebook', 'price': '900 DZD', 'image': 'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?w=900&q=80'},
        {'name': 'Soil Nutrition Pack', 'price': '2,000 DZD', 'image': 'https://images.unsplash.com/photo-1463123081488-789f998ac9c4?w=900&q=80'},
      ],
      'messages': [
        {'text': 'Hi Rahma, want tips for healthier leaves?', 'isMe': false},
      ],
    },
    {
      'name': 'Farmer Ahmed',
      'avatar': 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=500&q=80',
      'message': 'Thanks for your comment on my tomato post.',
      'time': '3h',
      'isOnline': false,
      'unreadCount': 1,
      'role': 'Local Farmer',
      'location': 'Blida, Algeria',
      'bio': 'Tomato and herbs grower. Sharing practical farming methods and daily harvest updates.',
      'followers': '2.1k',
      'following': '310',
      'postsCount': '42',
      'rating': '4.7',
      'responseTime': '~15 minutes',
      'gallery': [
        'https://images.unsplash.com/photo-1523741543316-beb7fc7023d8?w=900&q=80',
        'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=900&q=80',
        'https://images.unsplash.com/photo-1470252649378-9c29740c9fa8?w=900&q=80',
        'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?w=900&q=80',
      ],
      'products': [
        {'name': 'Fresh Tomato Box', 'price': '1,800 DZD', 'image': 'https://images.unsplash.com/photo-1546470427-e5b8d7b6d2f0?w=900&q=80'},
        {'name': 'Mint Bundle', 'price': '400 DZD', 'image': 'https://images.unsplash.com/photo-1628557044797-f21a177c37ec?w=900&q=80'},
      ],
      'messages': [
        {'text': 'Thanks for your support 🙏', 'isMe': false},
      ],
    },
  ];

  List<Map<String, dynamic>> get _filteredConversations {
    if (_searchQuery.trim().isEmpty) return _conversations;
    return _conversations.where((chat) {
      final name = (chat['name'] as String).toLowerCase();
      final message = (chat['message'] as String).toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || message.contains(query);
    }).toList();
  }

  List<Map<String, dynamic>> get _onlinePeople => _conversations.where((chat) => chat['isOnline'] == true).toList();

  void _openProfile(Map<String, dynamic> chat) {
    final farmerData = {
      'name': chat['name'] ?? 'Farmer',
      'farmName': chat['role'] ?? chat['name'] ?? 'Farm Profile',
      'image': chat['avatar'] ?? '',
      'location': chat['location'] ?? 'Algeria',
      'followers': chat['followers'] ?? '0',
      'crops': chat['bio'] ?? 'Mixed Crops',
      'farmSize': chat['responseTime'] ?? '~10 minutes',
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FarmerProfilePage(farmerData: farmerData),
      ),
    );
  }

  void _openChat(Map<String, dynamic> chat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          participantName: chat['name'] as String,
          participantImageUrl: chat['avatar'] as String,
          participantIsOnline: chat['isOnline'] as bool,
          participantProfileData: Map<String, dynamic>.from(chat),
          initialMessages: (chat['messages'] as List<dynamic>)
              .map((message) => Map<String, dynamic>.from(message as Map))
              .toList(),
          onMessageSent: (text) {
            if (!mounted) return;
            setState(() {
              chat['message'] = text;
              chat['time'] = 'now';
              chat['unreadCount'] = 0;
              (chat['messages'] as List).add({'text': text, 'isMe': true});
            });
          },
        ),
      ),
    );

    setState(() {
      chat['unreadCount'] = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12181D),
        elevation: 0,
        title: const Text('Messages', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF151D23),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchQuery = value),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search messages',
                  hintStyle: TextStyle(color: Colors.white54),
                  prefixIcon: Icon(Icons.search, color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 92,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _onlinePeople.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final chat = _onlinePeople[index];
                return GestureDetector(
                  onTap: () => _openChat(chat),
                  child: SizedBox(
                    width: 68,
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 26,
                              backgroundImage: NetworkImage(chat['avatar'] as String),
                            ),
                            const Positioned(
                              right: 0,
                              bottom: 0,
                              child: CircleAvatar(radius: 6, backgroundColor: Color(0xFF4CAF50)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          chat['name'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: _filteredConversations.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final chat = _filteredConversations[index];
                final unread = chat['unreadCount'] as int;
                return GestureDetector(
                  onTap: () => _openChat(chat),
                  onLongPress: () => _openProfile(chat),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF151D23),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundImage: NetworkImage(chat['avatar'] as String),
                            ),
                            if (chat['isOnline'] == true)
                              const Positioned(
                                right: 0,
                                bottom: 0,
                                child: CircleAvatar(radius: 6, backgroundColor: Color(0xFF4CAF50)),
                              ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chat['name'] as String,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                chat['message'] as String,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white70, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              chat['time'] as String,
                              style: const TextStyle(color: Colors.white54, fontSize: 12),
                            ),
                            const SizedBox(height: 8),
                            if (unread > 0)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4CAF50),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  unread.toString(),
                                  style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MessengerProfilePage extends StatefulWidget {
  final Map<String, dynamic> profileData;

  const MessengerProfilePage({
    super.key,
    required this.profileData,
  });

  @override
  State<MessengerProfilePage> createState() => _MessengerProfilePageState();
}

class _MessengerProfilePageState extends State<MessengerProfilePage> {
  int _selectedTab = 0;
  bool _isFollowing = false;

  @override
  Widget build(BuildContext context) {
    final name = widget.profileData['name'] as String? ?? 'Unknown User';
    final avatar = widget.profileData['avatar'] as String? ?? 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=500&q=80';
    final isOnline = widget.profileData['isOnline'] as bool? ?? false;
    final role = widget.profileData['role'] as String? ?? 'Community Member';
    final location = widget.profileData['location'] as String? ?? 'Algeria';
    final bio = widget.profileData['bio'] as String? ?? 'Passionate about agriculture and sharing knowledge.';
    final followers = widget.profileData['followers'] as String? ?? '0';
    final following = widget.profileData['following'] as String? ?? '0';
    final postsCount = widget.profileData['postsCount'] as String? ?? '0';
    final rating = widget.profileData['rating'] as String? ?? '4.5';
    final responseTime = widget.profileData['responseTime'] as String? ?? '~10 minutes';
    final gallery = ((widget.profileData['gallery'] as List?) ?? const [])
        .map((item) => item.toString())
        .toList();
    final products = ((widget.profileData['products'] as List?) ?? const [])
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();
    final messages = ((widget.profileData['messages'] as List?) ?? const [])
        .map((item) => Map<String, dynamic>.from(item as Map))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12181D),
        title: Text(name, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 96,
                  height: 96,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: isOnline
                          ? [const Color(0xFFE1306C), const Color(0xFFF77737), const Color(0xFFFCAF45)]
                          : [Colors.white24, Colors.white12],
                    ),
                  ),
                  child: ClipOval(child: Image.network(avatar, fit: BoxFit.cover)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _profileCount(postsCount, 'Posts'),
                      _profileCount(followers, 'Followers'),
                      _profileCount(following, 'Following'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(name, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 3),
            Text(role, style: const TextStyle(color: Color(0xFF31D6FF), fontSize: 13, fontWeight: FontWeight.w600)),
            const SizedBox(height: 3),
            Text(
              isOnline ? 'Online now' : 'Offline',
              style: TextStyle(
                color: isOnline ? const Color(0xFF4CAF50) : Colors.white54,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(bio, style: const TextStyle(color: Colors.white70, height: 1.35)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF151D23),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('📍 $location', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 3),
                  Text('⭐ Rating: $rating / 5', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                  const SizedBox(height: 3),
                  Text('⏱ Response time: $responseTime', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => _isFollowing = !_isFollowing),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFollowing ? Colors.white12 : const Color(0xFF2DE091),
                      foregroundColor: _isFollowing ? Colors.white : Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(_isFollowing ? 'Following' : 'Follow'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            participantName: name,
                            participantImageUrl: avatar,
                            participantIsOnline: isOnline,
                            participantProfileData: widget.profileData,
                            initialMessages: messages,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.chat_bubble_outline, color: Color(0xFF31D6FF), size: 18),
                    label: const Text('Message', style: TextStyle(color: Color(0xFF31D6FF))),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF31D6FF)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF151D23),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(child: _profileTabButton(icon: Icons.grid_on, label: 'Posts', selected: _selectedTab == 0, onTap: () => setState(() => _selectedTab = 0))),
                  Expanded(child: _profileTabButton(icon: Icons.sell_outlined, label: 'Products', selected: _selectedTab == 1, onTap: () => setState(() => _selectedTab = 1))),
                  Expanded(child: _profileTabButton(icon: Icons.info_outline, label: 'About', selected: _selectedTab == 2, onTap: () => setState(() => _selectedTab = 2))),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (_selectedTab == 0)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: gallery.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(gallery[index], fit: BoxFit.cover),
                  );
                },
              )
            else if (_selectedTab == 1)
              Column(
                children: products.map((product) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF151D23),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            product['image'] as String? ?? '',
                            width: 66,
                            height: 66,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name'] as String? ?? 'Product',
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product['price'] as String? ?? '',
                                style: const TextStyle(color: Color(0xFF2DE091), fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.white54),
                      ],
                    ),
                  );
                }).toList(),
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF151D23),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white24),
                ),
                child: Text(
                  '$name shares updates, products, and farming knowledge with the Nabt community. Use Message to contact directly.',
                  style: const TextStyle(color: Colors.white70, height: 1.4),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _profileCount(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _profileTabButton({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF2DE091).withValues(alpha: 0.18) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: selected ? const Color(0xFF2DE091) : Colors.white54),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? const Color(0xFF2DE091) : Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final String participantName;
  final String participantImageUrl;
  final bool participantIsOnline;
  final Map<String, dynamic>? participantProfileData;
  final List<Map<String, dynamic>>? initialMessages;
  final ValueChanged<String>? onMessageSent;

  const ChatPage({
    super.key,
    this.participantName = 'Green Garden Store',
    this.participantImageUrl = 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=500&q=80',
    this.participantIsOnline = true,
    this.participantProfileData,
    this.initialMessages,
    this.onMessageSent,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  late List<Map<String, dynamic>> _messages;

  @override
  void initState() {
    super.initState();
    _messages = widget.initialMessages != null && widget.initialMessages!.isNotEmpty
        ? widget.initialMessages!
            .map((message) => Map<String, dynamic>.from(message))
            .toList()
        : [
            {"text": "Hello! How can I help you with your plants today?", "isMe": false},
            {"text": "I noticed some yellow spots on my Peace Lily.", "isMe": true},
            {"text": "That sounds like it could be overwatering. How often do you water it?", "isMe": false},
          ];
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add({
          "text": text,
          "isMe": true,
        });
        _messageController.clear();
      });
      widget.onMessageSent?.call(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12181D),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.forum_outlined, color: Color(0xFF31D6FF)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NabtCommunityForumPage()),
              );
            },
          ),
        ],
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                final profileData = widget.participantProfileData ??
                    {
                      'name': widget.participantName,
                      'avatar': widget.participantImageUrl,
                      'isOnline': widget.participantIsOnline,
                      'role': 'Community Member',
                      'location': 'Algeria',
                      'bio': 'Plant lover and active community member.',
                      'followers': '1.2k',
                      'following': '210',
                      'postsCount': '24',
                      'rating': '4.7',
                      'responseTime': '~10 minutes',
                      'gallery': <String>[],
                      'products': <Map<String, String>>[],
                      'messages': _messages,
                    };
                final farmerData = {
                  'name': profileData['name'] ?? widget.participantName,
                  'farmName': profileData['role'] ?? profileData['name'] ?? widget.participantName,
                  'image': profileData['avatar'] ?? widget.participantImageUrl,
                  'location': profileData['location'] ?? 'Algeria',
                  'followers': profileData['followers'] ?? '0',
                  'crops': profileData['bio'] ?? 'Mixed Crops',
                  'farmSize': profileData['responseTime'] ?? '~10 minutes',
                };
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FarmerProfilePage(farmerData: farmerData),
                  ),
                );
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [Color(0xFF2DE091), Color(0xFF31D6FF)]),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: ClipOval(
                    child: Image.network(widget.participantImageUrl, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.participantName, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                Text(
                  widget.participantIsOnline ? 'Online' : 'Offline',
                  style: TextStyle(
                    color: widget.participantIsOnline
                        ? const Color(0xFF2DE091).withValues(alpha: 0.9)
                        : Colors.white54,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF2DE091).withValues(alpha: 0.15),
                        const Color(0xFF31D6FF).withValues(alpha: 0.10),
                      ],
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: const Color(0xFF0B0F12).withValues(alpha: 0.3),
                    ),
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    return _buildMessageBubble(msg['text'], msg['isMe']);
                  },
                ),
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String text, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF2DE091) : const Color(0xFF151D23),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: Radius.circular(isMe ? 15 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 15),
          ),
          boxShadow: !isMe
              ? [
                  BoxShadow(
                    color: const Color(0xFF2DE091).withValues(alpha: 0.5),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isMe ? Colors.black : const Color(0xFF2DE091),
            fontSize: 15,
            fontWeight: !isMe ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Color(0xFF12181D),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border(
          top: BorderSide(color: Colors.white24),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline, color: Color(0xFF2DE091)),
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                controller: _messageController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Message ${widget.participantName}...",
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF0F151A),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _sendMessage,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color(0xFF2DE091),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF2DE091),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: const Icon(Icons.send, color: Colors.black, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final String initialTool;
  const CameraScreen({super.key, this.initialTool = "Plant ID"});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final PageController _toolController = PageController(viewportFraction: 0.5);
  final List<String> _tools = ["Plant ID", "Mushroom", "Disease ID", "Toxicity"];
  int _activeToolIndex = 0;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _activeToolIndex = _tools.indexOf(widget.initialTool);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _toolController.jumpToPage(_activeToolIndex);
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    
    if (image != null && mounted) {
      setState(() => _selectedImage = File(image.path));
      // Navigate to scanning screen
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScanningScreen(
              imagePath: image.path,
              toolType: _tools[_activeToolIndex],
            ),
          ),
        );
      }
    }
  }

  void _showCameraOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text("Capture ${_tools[_activeToolIndex]}", style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF64DD17).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF64DD17), width: 2),
                        ),
                        child: const Icon(Icons.camera_alt, color: Color(0xFF64DD17), size: 40),
                      ),
                      const SizedBox(height: 12),
                      const Text("Take Photo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.blue, width: 2),
                        ),
                        child: const Icon(Icons.photo_library, color: Colors.blue, size: 40),
                      ),
                      const SizedBox(height: 12),
                      const Text("Choose Gallery", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera/Preview Area
          Positioned.fill(
            child: Container(
              color: Colors.black,
              child: _selectedImage != null
                  ? Image.file(_selectedImage!, fit: BoxFit.cover)
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFF64DD17).withValues(alpha: 0.5), width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.camera_alt, color: Colors.grey, size: 80),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            "Ready to identify ${_tools[_activeToolIndex]}?",
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
            ),
          ),

          // Top Controls
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _tools[_activeToolIndex],
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline, color: Colors.white, size: 30),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Bottom Controls
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Tool Selector
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _tools.length,
                    itemBuilder: (context, index) {
                      bool isSelected = _activeToolIndex == index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _activeToolIndex = index);
                            _toolController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF64DD17) : Colors.black.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected ? const Color(0xFF64DD17) : Colors.grey.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              _tools[index],
                              style: TextStyle(
                                color: isSelected ? Colors.black : Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Main Action Button
                GestureDetector(
                  onTap: _showCameraOptions,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF64DD17), width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF64DD17).withValues(alpha: 0.5),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          color: Color(0xFF64DD17),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera, color: Colors.black, size: 30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _toolController.dispose();
    super.dispose();
  }
}

class ScanningScreen extends StatefulWidget {
  final String imagePath;
  final String toolType;
  const ScanningScreen({super.key, required this.imagePath, this.toolType = "Plant ID"});

  @override
  State<ScanningScreen> createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> with SingleTickerProviderStateMixin {
  late AnimationController _scanController;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    
    // Auto-navigate to result after 3 seconds of "scanning"
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IdentificationResultPage(toolType: widget.toolType)),
      );
      }
    });
  }

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Display Captured Image
          Positioned.fill(child: Image.file(File(widget.imagePath), fit: BoxFit.cover)),
          
          // Scanning Laser Animation
          AnimatedBuilder(
            animation: _scanController,
            builder: (context, child) {
              return Positioned(
                top: MediaQuery.of(context).size.height * 0.2 + (_scanController.value * 300),
                left: 50,
                right: 50,
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: const Color(0xFF64DD17),
                    boxShadow: [BoxShadow(color: const Color(0xFF64DD17).withValues(alpha: 0.8), blurRadius: 10, spreadRadius: 2)],
                  ),
                ),
              );
            },
          ),
          
          // Semi-transparent overlay
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.3),
            ),
          ),
          
          // Scanning status
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF64DD17)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Analyzing ${widget.toolType}...",
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Please wait while we process your image",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
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

class IdentificationResultPage extends StatelessWidget {
  final String toolType;
  const IdentificationResultPage({super.key, this.toolType = "Plant ID"});

  @override
  Widget build(BuildContext context) {
    // Different results based on tool type
    final Map<String, Map<String, dynamic>> resultData = {
      "Plant ID": {
        "title": "Tomato Plant",
        "confidence": "94%",
        "icon": "🍅",
        "description": "This appears to be a Solanum lycopersicum (Common Tomato) plant.",
        "details": [
          "Family: Solanaceae",
          "Growth Pattern: Determinate/Indeterminate",
          "Soil pH: 6.0-6.8",
          "Water Needs: Moderate to High",
        ],
      },
      "Disease ID": {
        "title": "Leaf Rust",
        "confidence": "87%",
        "icon": "🦠",
        "description": "Fungal disease causing orange/brown spots on leaves.",
        "details": [
          "Severity: Medium",
          "Cause: Fungal Spores",
          "Treatment: Apply fungicide every 7 days",
          "Prevention: Improve air circulation",
        ],
      },
      "Mushroom": {
        "title": "Champignon",
        "confidence": "91%",
        "icon": "🍄",
        "description": "Agaricus bisporus - Common edible mushroom.",
        "details": [
          "Edibility: Edible",
          "Habitat: Decomposing wood/compost",
          "Season: Year-round (cultivated)",
          "Nutritional Value: High in Vitamins B & D",
        ],
      },
      "Toxicity": {
        "title": "Non-Toxic Plant",
        "confidence": "96%",
        "icon": "✅",
        "description": "This plant is safe for humans and pets.",
        "details": [
          "Safe for: Humans", 
          "Safe for: Pets",
          "Safe for: Indoor use",
          "No known toxins detected",
        ],
      },
    };

    final result = resultData[toolType] ?? resultData["Plant ID"]!;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        title: Text("$toolType Result"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image
            Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1599653814854-0fc7614e8a2e?q=80&w=1000'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Confidence
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(result['icon'], style: const TextStyle(fontSize: 40)),
                          const SizedBox(height: 8),
                          Text(
                            result['title'],
                            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF64DD17).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF64DD17)),
                        ),
                        child: Text(
                          result['confidence'],
                          style: const TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  
                  // Description
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      result['description'],
                      style: const TextStyle(color: Colors.white70, height: 1.6, fontSize: 14),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Details
                  const Text("Details & Recommendations", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...List.generate(
                    (result['details'] as List).length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF64DD17),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              result['details'][index],
                              style: const TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.save_alt),
                          label: const Text("Save Result"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF64DD17),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.share),
                          label: const Text("Share"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.camera_alt),
                      label: const Text("Scan Again"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// ARTICLE DETAIL PAGE
// =====================================================

class ArticleDetailPage extends StatelessWidget {
  final Map<String, String> article;

  const ArticleDetailPage({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    article["image"]!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[800],
                        child: const Icon(Icons.image_not_supported, color: Colors.grey),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article["title"]!,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF64DD17),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.grey, size: 16),
                      const SizedBox(width: 8),
                      const Text("5 min read", style: TextStyle(color: Colors.grey)),
                      const SizedBox(width: 30),
                      const Icon(Icons.star, color: Color(0xFF64DD17), size: 16),
                      const SizedBox(width: 8),
                      const Text("Expert verified", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Introduction",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "This comprehensive guide provides detailed information about plant care, growth patterns, and best practices for optimal health. Learn the fundamentals and advanced techniques to nurture your plants.",
                    style: TextStyle(color: Colors.white70, height: 1.6, fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Key Points",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  _buildKeyPoint("Watering", "Water regularly but avoid overwatering. Check soil moisture before each watering."),
                  _buildKeyPoint("Sunlight", "Ensure 6-8 hours of indirect sunlight daily for optimal growth."),
                  _buildKeyPoint("Soil", "Use well-draining soil with proper nutrients and organic matter."),
                  _buildKeyPoint("Temperature", "Maintain temperature between 65-75°F for most plants."),
                  const SizedBox(height: 30),
                  const Text(
                    "Common Mistakes",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  _buildMistake("Over-fertilizing", "More fertilizer doesn't mean better growth. Follow recommended dosage."),
                  _buildMistake("Poor drainage", "Excess water causes root rot. Ensure proper drainage holes."),
                  _buildMistake("Ignoring pests", "Check regularly for pests and treat early."),
                  const SizedBox(height: 40),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF64DD17), Color(0xFF00E676)],
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Article saved to favorites!"),
                            backgroundColor: Color(0xFF64DD17),
                          ),
                        );
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.bookmark, color: Colors.black),
                          SizedBox(width: 10),
                          Text(
                            "Save Article",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyPoint(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 8, right: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF64DD17),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(color: Colors.white70, height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMistake(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.1),
          border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning_amber, color: Colors.red, size: 20),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(color: Colors.white70, height: 1.5)),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// QUIZ PAGE
// =====================================================

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int totalPoints = 0;
  bool answered = false;
  String? selectedAnswer;
  bool isAnswerCorrect = false;
  List<int> _randomizedIndices = [];

  final List<Map<String, dynamic>> allQuizzes = [
    {
      "question": "How often should you water most indoor plants?",
      "options": ["Daily", "2-3 times a week", "Once a week", "Every 2 weeks"],
      "correctIndex": 2,
      "explanation": "Most indoor plants prefer soil to dry slightly between waterings. Watering once a week is usually sufficient.",
      "points": 10,
    },
    {
      "question": "What is the ideal temperature for plant growth?",
      "options": ["45-55°F", "65-75°F", "85-95°F", "Below 32°F"],
      "correctIndex": 1,
      "explanation": "Most plants thrive in temperatures between 65-75°F (18-24°C).",
      "points": 10,
    },
    {
      "question": "What does NPK stand for in fertilizers?",
      "options": ["Nitrogen, Phosphorus, Potassium", "Nitrogen, Phosphorus, Magnesium", "Nickel, Phosphorus, Potassium", "Nitrogen, Phosphate, Potash"],
      "correctIndex": 0,
      "explanation": "NPK represents the three primary nutrients: Nitrogen (N), Phosphorus (P), and Potassium (K).",
      "points": 10,
    },
    {
      "question": "What is the main cause of root rot in plants?",
      "options": ["Lack of sunlight", "Overwatering", "Too much fertilizer", "Cold temperature"],
      "correctIndex": 1,
      "explanation": "Root rot is primarily caused by overwatering and poor drainage, which leads to fungal infections.",
      "points": 10,
    },
    {
      "question": "How many hours of sunlight do most plants need daily?",
      "options": ["2-3 hours", "4-5 hours", "6-8 hours", "12+ hours"],
      "correctIndex": 2,
      "explanation": "Most plants require 6-8 hours of indirect sunlight daily for optimal growth.",
      "points": 10,
    },
    {
      "question": "What is the best soil pH for most vegetables?",
      "options": ["4.0-5.0", "5.5-7.0", "7.5-8.5", "8.5-9.5"],
      "correctIndex": 1,
      "explanation": "Most vegetables prefer slightly acidic to neutral soil with pH between 5.5-7.0 for optimal nutrient uptake.",
      "points": 10,
    },
    {
      "question": "Which season is best for planting most crops?",
      "options": ["Winter", "Spring", "Summer", "Autumn"],
      "correctIndex": 1,
      "explanation": "Spring is ideal for planting because of moderate temperatures, increasing daylight, and soil warming.",
      "points": 10,
    },
    {
      "question": "What does crop rotation help prevent?",
      "options": ["Soil erosion", "Soil depletion and diseases", "Water pollution", "Air pollution"],
      "correctIndex": 1,
      "explanation": "Crop rotation prevents soil nutrient depletion and reduces pathogen buildup that affects specific crops.",
      "points": 10,
    },
    {
      "question": "Which nutrient is mainly responsible for leaf growth?",
      "options": ["Phosphorus", "Potassium", "Nitrogen", "Sulfur"],
      "correctIndex": 2,
      "explanation": "Nitrogen promotes leafy green growth and is essential for photosynthesis and protein formation.",
      "points": 10,
    },
    {
      "question": "What is the ideal moisture level for most soil?",
      "options": ["10-20%", "25-35%", "50-60%", "70-80%"],
      "correctIndex": 1,
      "explanation": "Soil moisture between 25-35% is optimal for most crops, ensuring water availability without waterlogging.",
      "points": 10,
    },
    {
      "question": "Which pest is most destructive to wheat crops?",
      "options": ["Locusts", "Weevils", "Both equally", "Neither"],
      "correctIndex": 2,
      "explanation": "Both locusts and weevils pose significant threats. Locusts cause swarms of damage while weevils destroy stored grain.",
      "points": 10,
    },
    {
      "question": "What is the average shelf life of seeds?",
      "options": ["1 year", "2-3 years", "5-10 years", "20+ years"],
      "correctIndex": 2,
      "explanation": "Most seeds retain viability for 5-10 years when stored in cool, dry conditions, though quality decreases over time.",
      "points": 10,
    },
    {
      "question": "Which farming practice improves soil structure most effectively?",
      "options": ["Monoculture", "Composting", "Heavy tilling", "Pesticide use"],
      "correctIndex": 1,
      "explanation": "Composting adds organic matter that improves soil structure, water retention, and microbial activity.",
      "points": 10,
    },
    {
      "question": "What is the primary cause of nitrogen deficiency in plants?",
      "options": ["Excess rain", "Poor drainage", "Soil microbial activity", "Lack of organic matter"],
      "correctIndex": 3,
      "explanation": "Soil lacking organic matter has reduced nitrogen because decomposing organic matter releases nitrogen into the soil.",
      "points": 10,
    },
    {
      "question": "How often should you apply fertilizer to growing crops?",
      "options": ["Every day", "Every 2-4 weeks", "Once per season", "Never"],
      "correctIndex": 1,
      "explanation": "Most crops benefit from fertilizer application every 2-4 weeks during the growing season for continuous nutrient supply.",
      "points": 10,
    },
    {
      "question": "What is the optimal harvest time for most leafy greens?",
      "options": ["Morning", "Midday", "Evening", "Anytime"],
      "correctIndex": 0,
      "explanation": "Early morning harvesting is best because plants are fully hydrated, ensuring crispness and nutrient content.",
      "points": 10,
    },
    {
      "question": "Which practice helps reduce water usage in farming?",
      "options": ["Flood irrigation", "Drip irrigation", "Overhead sprinkler", "Manual watering"],
      "correctIndex": 1,
      "explanation": "Drip irrigation delivers water directly to plant roots, reducing waste and using 30-50% less water than other methods.",
      "points": 10,
    },
    {
      "question": "What is the ideal spacing for most vegetable plants?",
      "options": ["1-2 inches", "6-12 inches", "18-24 inches", "Varies by plant species"],
      "correctIndex": 3,
      "explanation": "Spacing varies significantly by plant type. Lettuce needs 6-12 inches while tomatoes need 24-36 inches.",
      "points": 10,
    },
    {
      "question": "Which disease is caused by fungal spores and spreads in humid conditions?",
      "options": ["Bacterial leaf spot", "Powdery mildew", "Viral mosaic", "Blossom end rot"],
      "correctIndex": 1,
      "explanation": "Powdery mildew is a fungal disease that thrives in humid conditions and appears as white powder on leaves.",
      "points": 10,
    },
    {
      "question": "What is the benefit of mulching in agriculture?",
      "options": ["Increases pests", "Prevents water loss and suppresses weeds", "Reduces soil temperature", "Requires frequent removal"],
      "correctIndex": 1,
      "explanation": "Mulching conserves soil moisture, regulates temperature, suppresses weeds, and improves soil structure as it decomposes.",
      "points": 10,
    },
  ];

  late List<Map<String, dynamic>> quizzes;

  @override
  void initState() {
    super.initState();
    _randomizeQuestions();
  }

  void _randomizeQuestions() {
    _randomizedIndices = List<int>.generate(allQuizzes.length, (i) => i);
    _randomizedIndices.shuffle();
    quizzes = List<Map<String, dynamic>>.generate(
      20,
      (index) => allQuizzes[_randomizedIndices[index % allQuizzes.length]],
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuiz = quizzes[currentQuestionIndex];
    final isLastQuestion = currentQuestionIndex == quizzes.length - 1;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1536147116438-62679a5e01f2?q=80&w=1000&auto=format&fit=crop'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.46),
                    Colors.black.withValues(alpha: 0.86),
                    const Color(0xFF050806),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -62,
            right: -44,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF64DD17).withValues(alpha: 0.11),
              ),
            ),
          ),
          Positioned(
            bottom: -72,
            left: -50,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF00E676).withValues(alpha: 0.10),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withValues(alpha: 0.10),
                          side: BorderSide(color: Colors.white.withValues(alpha: 0.20)),
                        ),
                        icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Farming & Plant Care Quiz',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 17),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Question ${currentQuestionIndex + 1}/${quizzes.length}',
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.80), fontSize: 13),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF64DD17),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                'Points: $totalPoints',
                                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: (currentQuestionIndex + 1) / quizzes.length,
                            backgroundColor: Colors.white.withValues(alpha: 0.12),
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF64DD17)),
                            minHeight: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.20)),
                    ),
                    child: Text(
                      currentQuiz['question'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        height: 1.4,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...List.generate(
                    (currentQuiz['options'] as List).length,
                    (index) => _buildOptionButton(
                      option: currentQuiz['options'][index],
                      index: index,
                      isCorrect: index == currentQuiz['correctIndex'],
                      currentQuiz: currentQuiz,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (answered)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isAnswerCorrect
                            ? const Color(0xFF64DD17).withValues(alpha: 0.14)
                            : Colors.red.withValues(alpha: 0.13),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isAnswerCorrect ? const Color(0xFF64DD17) : Colors.redAccent,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isAnswerCorrect ? Icons.check_circle : Icons.cancel,
                                color: isAnswerCorrect ? const Color(0xFF64DD17) : Colors.redAccent,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isAnswerCorrect ? 'Correct! +10 Points' : 'Incorrect',
                                style: TextStyle(
                                  color: isAnswerCorrect ? const Color(0xFF64DD17) : Colors.redAccent,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            currentQuiz['explanation'],
                            style: TextStyle(color: Colors.white.withValues(alpha: 0.86), height: 1.45),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16),
                  if (answered)
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF64DD17), Color(0xFF00E676)],
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          onPressed: () {
                            if (isLastQuestion) {
                              _showResultsDialog();
                            } else {
                              setState(() {
                                currentQuestionIndex++;
                                answered = false;
                                selectedAnswer = null;
                              });
                            }
                          },
                          child: Text(
                            isLastQuestion ? 'See Results' : 'Next Question',
                            style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                        ),
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

  Widget _buildOptionButton({
    required String option,
    required int index,
    required bool isCorrect,
    required Map<String, dynamic> currentQuiz,
  }) {
    bool isSelected = selectedAnswer == option;
    bool showCorrect = answered && isCorrect;
    bool showIncorrect = answered && isSelected && !isCorrect;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: answered
            ? null
            : () {
                setState(() {
                  selectedAnswer = option;
                  answered = true;
                  isAnswerCorrect = isCorrect;
                  if (isCorrect) {
                    totalPoints += (currentQuiz["points"] as num).toInt();
                  }
                });
              },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: showCorrect
                ? const Color(0xFF64DD17).withValues(alpha: 0.16)
                : showIncorrect
                    ? Colors.red.withValues(alpha: 0.14)
                    : isSelected
                        ? const Color(0xFF64DD17).withValues(alpha: 0.13)
                        : Colors.white.withValues(alpha: 0.08),
            border: Border.all(
              color: showCorrect
                  ? const Color(0xFF64DD17)
                  : showIncorrect
                      ? Colors.redAccent
                      : isSelected
                          ? const Color(0xFF64DD17)
                          : Colors.white.withValues(alpha: 0.20),
              width: 1.6,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: showCorrect
                        ? const Color(0xFF64DD17)
                        : showIncorrect
                            ? Colors.redAccent
                            : isSelected
                                ? const Color(0xFF64DD17)
                                : Colors.white54,
                    width: 2,
                  ),
                ),
                child: showCorrect
                    ? const Icon(Icons.check, size: 15, color: Color(0xFF64DD17))
                    : showIncorrect
                        ? const Icon(Icons.close, size: 15, color: Colors.redAccent)
                        : Center(
                            child: Text(
                              String.fromCharCode(65 + index),
                              style: TextStyle(
                                color: isSelected ? const Color(0xFF64DD17) : Colors.white54,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  option,
                  style: TextStyle(
                    color: showCorrect
                        ? const Color(0xFF64DD17)
                        : showIncorrect
                            ? Colors.redAccent
                            : Colors.white,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResultsDialog() {
    int percentage = ((totalPoints / 200) * 100).toInt();
    String performance = "";
    String message = "";
    
    if (percentage >= 90) {
      performance = "Outstanding!";
      message = "You're a farming and plant care expert! Excellent knowledge!";
    } else if (percentage >= 80) {
      performance = "Excellent!";
      message = "Great performance! You have strong farming knowledge.";
    } else if (percentage >= 70) {
      performance = "Good!";
      message = "Good job! Keep learning to improve your farming skills.";
    } else if (percentage >= 60) {
      performance = "Fair";
      message = "You're on the right track. Study more farming techniques.";
    } else {
      performance = "Keep Learning";
      message = "Don't worry! Continue learning farming best practices.";
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
          decoration: BoxDecoration(
            color: const Color(0xFF141A1E),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF64DD17),
                ),
                child: Text(
                  '$percentage%',
                  style: const TextStyle(fontSize: 38, fontWeight: FontWeight.w800, color: Colors.black),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                performance,
                style: const TextStyle(color: Color(0xFF64DD17), fontSize: 22, fontWeight: FontWeight.w800),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.78), height: 1.5, fontSize: 13),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF64DD17).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF64DD17)),
                ),
                child: Column(
                  children: [
                    const Text('Quiz Results', style: TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Total Questions:', style: TextStyle(color: Colors.white70)),
                        Text('20', style: TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Your Points:', style: TextStyle(color: Colors.white70)),
                        Text('$totalPoints / 200', style: const TextStyle(color: Color(0xFF64DD17), fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(colors: [Color(0xFF64DD17), Color(0xFF00E676)]),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Back to Home',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// DISEASES PAGE
// =====================================================

class DiseasesPage extends StatefulWidget {
  const DiseasesPage({super.key});

  @override
  State<DiseasesPage> createState() => _DiseasesPageState();
}

class _DiseasesPageState extends State<DiseasesPage> {
  String searchQuery = "";

  final List<Map<String, String>> diseases = [
    {
      "name": "Leaf Rust",
      "type": "Fungi",
      "severity": "High",
      "image": "https://images.unsplash.com/photo-1599307767316-776533da941c?q=80&w=500",
      "description": "Orange, yellow, or brown spots on leaves causing plant weakening.",
      "treatment": "Remove infected leaves, avoid overhead watering, apply organic fungicide every 7 days.",
    },
    {
      "name": "Powdery Mildew",
      "type": "Fungi",
      "severity": "Medium",
      "image": "https://images.unsplash.com/photo-1599653814854-0fc7614e8a2e?q=80&w=500",
      "description": "White powder coating on leaves, stems, and flowers.",
      "treatment": "Improve air circulation, spray with sulfur-based fungicide, remove affected areas.",
    },
    {
      "name": "Root Rot",
      "type": "Fungi",
      "severity": "Critical",
      "image": "https://images.unsplash.com/photo-1599903437514-8d7bc471ac1e?q=80&w=500",
      "description": "Mushy roots and stem decay due to excessive moisture.",
      "treatment": "Repot with fresh soil, improve drainage, reduce watering frequency, apply fungicide.",
    },
    {
      "name": "Spider Mites",
      "type": "Pest",
      "severity": "Medium",
      "image": "https://images.unsplash.com/photo-1599599810966-9e82b685b0cd?q=80&w=500",
      "description": "Tiny insects creating fine webbing on leaves and stems.",
      "treatment": "Spray with neem oil, increase humidity, isolate plant, repeat weekly.",
    },
    {
      "name": "Blight",
      "type": "Fungi",
      "severity": "High",
      "image": "https://images.unsplash.com/photo-1600271886742-f049cd451bba?q=80&w=500",
      "description": "Rapid leaf discoloration and plant death.",
      "treatment": "Remove all affected parts, improve air circulation, apply copper fungicide.",
    },
    {
      "name": "Aphids",
      "type": "Pest",
      "severity": "Medium",
      "image": "https://images.unsplash.com/photo-1585518419759-66ed635b4545?q=80&w=500",
      "description": "Small insects that suck plant sap causing yellowing and stunted growth.",
      "treatment": "Spray with insecticidal soap, use neem oil, introduce ladybugs.",
    },
    {
      "name": "Leaf Spot",
      "type": "Fungi",
      "severity": "Low",
      "image": "https://images.unsplash.com/photo-1582847346884-35cbf49b8055?q=80&w=500",
      "description": "Brown or black spots on leaves with yellow halos.",
      "treatment": "Remove affected leaves, avoid wetting foliage, apply fungicide spray.",
    },
    {
      "name": "Mealybugs",
      "type": "Pest",
      "severity": "Medium",
      "image": "https://images.unsplash.com/photo-1587618556084-11a85d625b7f?q=80&w=500",
      "description": "White cottony insects on stems and leaves.",
      "treatment": "Wipe with alcohol solution, spray with insecticidal soap, quarantine plant.",
    },
  ];

  List<Map<String, String>> getFilteredDiseases() {
    if (searchQuery.isEmpty) {
      return diseases;
    }
    return diseases
        .where((disease) =>
            disease["name"]!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            disease["type"]!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredDiseases = getFilteredDiseases();

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text("Plant Diseases"),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFB2FF59), width: 1.5),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Search diseases...",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(Icons.search, color: Color(0xFFB2FF59)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
          // Results Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Showing ${filteredDiseases.length} disease${filteredDiseases.length != 1 ? 's' : ''}",
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          const SizedBox(height: 16),
          // Disease List
          Expanded(
            child: filteredDiseases.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off, size: 48, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          'No diseases found for "$searchQuery"',
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredDiseases.length,
                    itemBuilder: (context, index) {
                      return _buildDiseaseCard(filteredDiseases[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiseaseCard(Map<String, String> disease) {
    Color severityColor;
    switch (disease["severity"]) {
      case "Critical":
        severityColor = Colors.red;
        break;
      case "High":
        severityColor = Colors.orange;
        break;
      case "Medium":
        severityColor = Colors.yellow;
        break;
      default:
        severityColor = Colors.green;
    }

    return GestureDetector(
      onTap: () {
        _showDiseaseDetails(disease);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                disease["image"]!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    color: Colors.grey[800],
                    child: const Icon(Icons.image_not_supported, color: Colors.grey),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          disease["name"]!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF64DD17),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: severityColor.withValues(alpha: 0.2),
                          border: Border.all(color: severityColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          disease["severity"]!,
                          style: TextStyle(
                            color: severityColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    disease["type"]!,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    disease["description"]!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      Icon(Icons.info_outline, color: Color(0xFF64DD17), size: 16),
                      SizedBox(width: 8),
                      Text(
                        "Tap for treatment details",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDiseaseDetails(Map<String, String> disease) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      disease["name"]!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF64DD17),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                disease["type"]!,
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                disease["description"]!,
                style: const TextStyle(color: Colors.white70, height: 1.6),
              ),
              const SizedBox(height: 20),
              const Text(
                "Treatment Plan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                disease["treatment"]!,
                style: const TextStyle(color: Colors.white70, height: 1.6),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}



// =====================================================
// CATEGORY PRODUCTS PAGE
// =====================================================

class CategoryProductsPage extends StatelessWidget {
  final String categoryName;

  const CategoryProductsPage({
    super.key,
    required this.categoryName,
  });

  // Sample products by category
  Map<String, List<Map<String, String>>> getCategoryProducts() {
    return {
      "Vegetables": [
        {"name": "Tomato Plant", "price": "\$15.00", "image": "https://images.unsplash.com/photo-1592921870789-04563e271ab1?q=80&w=500", "rating": "4.8", "reviews": "234"},
        {"name": "Cucumber Vine", "price": "\$12.00", "image": "https://images.unsplash.com/photo-1557804506-669214670979?q=80&w=500", "rating": "4.6", "reviews": "187"},
        {"name": "Lettuce Bunch", "price": "\$8.00", "image": "https://images.unsplash.com/photo-1515182629504-e6e3dab74fbb?q=80&w=500", "rating": "4.7", "reviews": "125"},
        {"name": "Bell Pepper", "price": "\$14.00", "image": "https://images.unsplash.com/photo-1599599810694-b5ac4dd37e86?q=80&w=500", "rating": "4.9", "reviews": "298"},
        {"name": "Spinach Leaves", "price": "\$7.00", "image": "https://images.unsplash.com/photo-1511621776919-a63c4b66de13?q=80&w=500", "rating": "4.5", "reviews": "92"},
        {"name": "Broccoli Head", "price": "\$11.00", "image": "https://images.unsplash.com/photo-1588003233010-ac82f57f0cbb?q=80&w=500", "rating": "4.8", "reviews": "156"},
      ],
      "Fruits": [
        {"name": "Orange Tree", "price": "\$25.00", "image": "https://images.unsplash.com/photo-1523148e6408-d6179a101e4b?q=80&w=500", "rating": "4.9", "reviews": "312"},
        {"name": "Apple Sapling", "price": "\$28.00", "image": "https://images.unsplash.com/photo-1560806674-e65e5f48a88f?q=80&w=500", "rating": "4.8", "reviews": "267"},
        {"name": "Lemon Plant", "price": "\$22.00", "image": "https://images.unsplash.com/photo-1600271886742-f049cd451bba?q=80&w=500", "rating": "4.7", "reviews": "198"},
        {"name": "Mango Tree", "price": "\$32.00", "image": "https://images.unsplash.com/photo-1585518419759-66ed635b4545?q=80&w=500", "rating": "4.9", "reviews": "420"},
        {"name": "Banana Plant", "price": "\$18.00", "image": "https://images.unsplash.com/photo-1587618556084-11a85d625b7f?q=80&w=500", "rating": "4.6", "reviews": "134"},
        {"name": "Strawberry Bush", "price": "\$16.00", "image": "https://images.unsplash.com/photo-1582847346884-35cbf49b8055?q=80&w=500", "rating": "4.8", "reviews": "276"},
      ],
      "Flowers": [
        {"name": "Wheat Seeds", "price": "\$45.00", "image": "https://images.unsplash.com/photo-1574943320219-553eb213f72d?q=80&w=500", "rating": "4.7", "reviews": "189"},
        {"name": "Corn Seeds", "price": "\$52.00", "image": "https://images.unsplash.com/photo-1508924476507-2efd8b9d5134?q=80&w=500", "rating": "4.8", "reviews": "267"},
        {"name": "Rice Seeds", "price": "\$38.00", "image": "https://images.unsplash.com/photo-1586020906456-d7376cf80a30?q=80&w=500", "rating": "4.6", "reviews": "145"},
        {"name": "Soybean Plants", "price": "\$42.00", "image": "https://images.unsplash.com/photo-1599653814854-0fc7614e8a2e?q=80&w=500", "rating": "4.7", "reviews": "201"},
      ],
      "Herbs": [
        {"name": "Indoor Fern", "price": "\$20.00", "image": "https://images.unsplash.com/photo-1456265446384-7e8d12d8db4f?q=80&w=500", "rating": "4.8", "reviews": "234"},
        {"name": "Rose Bush", "price": "\$24.00", "image": "https://images.unsplash.com/photo-1563241527-3004b8f0a263?q=80&w=500", "rating": "4.9", "reviews": "356"},
        {"name": "Tulip Bulbs", "price": "\$12.00", "image": "https://images.unsplash.com/photo-1540763185298-1b434c919eba?q=80&w=500", "rating": "4.7", "reviews": "198"},
        {"name": "Lily Plant", "price": "\$19.00", "image": "https://images.unsplash.com/photo-1563389810256-cb4e7b90acdc?q=80&w=500", "rating": "4.8", "reviews": "267"},
        {"name": "Hydrangea Bush", "price": "\$26.00", "image": "https://images.unsplash.com/photo-1588282042777-a98ee0c05da1?q=80&w=500", "rating": "4.9", "reviews": "298"},
      ],
      "Medicinal": [
        {"name": "Mint Plant", "price": "\$9.00", "image": "https://images.unsplash.com/photo-1599653814854-0fc7614e8a2e?q=80&w=500", "rating": "4.8", "reviews": "312"},
        {"name": "Basil Herb", "price": "\$8.00", "image": "https://images.unsplash.com/photo-1580809361436-42a7ec9b3dbb?q=80&w=500", "rating": "4.7", "reviews": "256"},
        {"name": "Turmeric Plant", "price": "\$14.00", "image": "https://images.unsplash.com/photo-1599599810966-9e82b685b0cd?q=80&w=500", "rating": "4.9", "reviews": "423"},
        {"name": "Aloe Vera", "price": "\$11.00", "image": "https://images.unsplash.com/photo-1592921870789-04563e271ab1?q=80&w=500", "rating": "4.8", "reviews": "367"},
        {"name": "Ginger Root", "price": "\$13.00", "image": "https://images.unsplash.com/photo-1599903437514-8d7bc471ac1e?q=80&w=500", "rating": "4.7", "reviews": "189"},
        {"name": "Thyme Herb", "price": "\$7.50", "image": "https://images.unsplash.com/photo-1599654723374-82873e28f546?q=80&w=500", "rating": "4.8", "reviews": "145"},
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    final products = getCategoryProducts()[categoryName] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
      ),
      body: products.isEmpty
          ? Center(
              child: Text(
                'No products available for $categoryName',
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _buildProductCard(context, products[index]);
              },
            ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, String> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.3), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network(
                product["image"]!,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    color: Colors.grey[800],
                    child: const Icon(Icons.image_not_supported, color: Colors.grey),
                  );
                },
              ),
            ),
            // Product Details
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product["name"]!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Color(0xFF64DD17), size: 14),
                      const SizedBox(width: 4),
                      Text(
                        "${product["rating"]} (${product["reviews"]})",
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Price and Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product["price"]!,
                        style: const TextStyle(
                          color: Color(0xFF64DD17),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF64DD17),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add, color: Colors.black, size: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// FARMER PROFILE PAGE
// =====================================================

class FarmerProfilePage extends StatefulWidget {
  final Map<String, dynamic> farmerData;
  const FarmerProfilePage({super.key, required this.farmerData});

  @override
  State<FarmerProfilePage> createState() => _FarmerProfilePageState();
}

class _FarmerProfilePageState extends State<FarmerProfilePage> {
  late Map<String, dynamic> _posts;
  late Map<String, dynamic> _feedPosts;
  late List<Map<String, dynamic>> _products;
  bool _isFollowing = false;
  bool _storySeen = false;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _initializeFarmerData();
  }

  void _initializeFarmerData() {
    _posts = {
      'post1': {
        'image': 'https://images.unsplash.com/photo-1488459716781-6f3ee4f14b0f?w=500&h=500&fit=crop',
        'caption': 'Fresh harvest season! 🌾 Ready to share quality produce',
        'likes': 324,
        'liked': false,
        'saved': false,
        'shares': 12,
        'comments': 45,
        'commentList': [
          {'user': 'Ali Farmer', 'text': 'Amazing quality!', 'avatar': 'https://i.pravatar.cc/150?img=1'},
        ],
      },
      'post2': {
        'image': 'https://images.unsplash.com/photo-1574943320219-553eb213f72d?w=500&h=500&fit=crop',
        'caption': 'Organic farming at its finest. No chemicals, pure nature',
        'likes': 456,
        'liked': false,
        'saved': false,
        'shares': 18,
        'comments': 62,
        'commentList': [],
      },
      'post3': {
        'image': 'https://images.unsplash.com/photo-1625246333195-78d9c38ad576?w=500&h=500&fit=crop',
        'caption': 'Team work makes the dream work 👨‍🌾👩‍🌾',
        'likes': 234,
        'liked': false,
        'saved': false,
        'shares': 8,
        'comments': 28,
        'commentList': [],
      },
    };

    _feedPosts = {
      'feed1': {
        'image': 'https://images.unsplash.com/photo-1599599810694-fef1e45b0c92?w=600&fit=crop',
        'caption': 'Today\'s harvest: tomatoes, cucumbers, and fresh greens. Quality guaranteed!',
        'likes': 567,
        'liked': false,
        'saved': false,
        'shares': 21,
        'comments': 89,
        'commentList': [
          {'user': 'Hassan Farm', 'text': 'Great quality! When can I order?'},
          {'user': 'Nora Gardens', 'text': 'Beautiful produce! 🌱'},
        ],
      },
      'feed2': {
        'image': 'https://images.unsplash.com/photo-1574943320219-553eb213f72d?w=600&fit=crop',
        'caption': 'Farm update: Our new irrigation system is working perfectly',
        'likes': 892,
        'liked': false,
        'saved': false,
        'shares': 34,
        'comments': 123,
        'commentList': [],
      },
    };

    _products = [
      {
        'name': 'Organic Tomatoes',
        'image': 'https://images.unsplash.com/photo-1592921570552-8ac1b3f63f11?w=300&h=300&fit=crop',
        'price': '250 DA/kg',
      },
      {
        'name': 'Fresh Cucumbers',
        'image': 'https://images.unsplash.com/photo-1590080876-e8b0e4c91e23?w=300&h=300&fit=crop',
        'price': '180 DA/kg',
      },
      {
        'name': 'Green Peppers',
        'image': 'https://images.unsplash.com/photo-1584868547706-74d440642117?w=300&h=300&fit=crop',
        'price': '220 DA/kg',
      },
      {
        'name': 'Leafy Greens',
        'image': 'https://images.unsplash.com/photo-1599599810414-b4b7b7c632c9?w=300&h=300&fit=crop',
        'price': '150 DA/kg',
      },
    ];
  }

  bool get _hasActiveStory => true;

  void _togglePostLike(Map<String, dynamic> post) {
    setState(() {
      final liked = (post['liked'] as bool?) ?? false;
      post['liked'] = !liked;
      post['likes'] = ((post['likes'] as int?) ?? 0) + (liked ? -1 : 1);
    });
  }

  void _togglePostSaved(Map<String, dynamic> post) {
    setState(() {
      post['saved'] = !((post['saved'] as bool?) ?? false);
    });
  }

  void _sharePostDynamic(Map<String, dynamic> post) {
    setState(() {
      post['shares'] = ((post['shares'] as int?) ?? 0) + 1;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Post shared successfully'),
        backgroundColor: Color(0xFF31D6FF),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.farmerData['name'] ?? '';
    final farmName = widget.farmerData['farmName'] ?? '';
    final image = widget.farmerData['image'] ?? '';
    final location = widget.farmerData['location'] ?? '';
    final followers = widget.farmerData['followers'] ?? '0';
    final crops = widget.farmerData['crops'] ?? '';
    final farmSize = widget.farmerData['farmSize'] ?? '';

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF12181D),
        title: Text(farmName),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Row(
              children: [
                Container(
                  width: 96,
                  height: 96,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: (_hasActiveStory && !_storySeen)
                        ? const LinearGradient(
                            colors: [Color(0xFFE1306C), Color(0xFFF77737), Color(0xFFFCAF45)],
                          )
                        : (_storySeen
                            ? const LinearGradient(colors: [Colors.white24, Colors.white24])
                            : const LinearGradient(colors: [Color(0xFF2DE091), Color(0xFF31D6FF)])),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: Image.network(image, fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _countColumn(_posts.length.toString(), 'Posts'),
                      _countColumn(followers, 'Followers'),
                      _countColumn('642', 'Following'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(location, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 4),
            const Row(
              children: [
                Icon(Icons.verified, size: 14, color: Color(0xFF31D6FF)),
                SizedBox(width: 4),
                Text('Verified Farmer • 4.8 rating', style: TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Farm Size: $farmSize • Crops: $crops',
              style: const TextStyle(color: Colors.white70, height: 1.4),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => setState(() => _isFollowing = !_isFollowing),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFollowing ? Colors.white12 : const Color(0xFF2DE091),
                      foregroundColor: _isFollowing ? Colors.white : Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Icon(_isFollowing ? Icons.person : Icons.person_add_alt_1, size: 18),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            participantName: name,
                            participantImageUrl: image,
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF31D6FF)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Icon(Icons.chat_bubble_outline, color: Color(0xFF31D6FF), size: 18),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CallPage(
                            participantName: name,
                            participantImageUrl: image,
                          ),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white24),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Icon(Icons.phone_outlined, color: Colors.white70, size: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Tabs
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF151D23),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _tabButton(
                      icon: Icons.grid_on,
                      label: 'Posts',
                      selected: _selectedTab == 0,
                      onTap: () => setState(() => _selectedTab = 0),
                    ),
                  ),
                  Expanded(
                    child: _tabButton(
                      icon: Icons.view_stream_outlined,
                      label: 'Feed',
                      selected: _selectedTab == 1,
                      onTap: () => setState(() => _selectedTab = 1),
                    ),
                  ),
                  Expanded(
                    child: _tabButton(
                      icon: Icons.shopping_bag_outlined,
                      label: 'Products',
                      selected: _selectedTab == 2,
                      onTap: () => setState(() => _selectedTab = 2),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Tab Content
            if (_selectedTab == 0)
              _buildPostsGrid()
            else if (_selectedTab == 1)
              _buildFeedView()
            else
              _buildProductsGrid(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPostsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
      ),
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts.values.elementAt(index);
        return GestureDetector(
          onTap: () => _togglePostLike(post),
          onLongPress: () => _togglePostSaved(post),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(post['image'], fit: BoxFit.cover),
                Positioned(
                  left: 6,
                  right: 6,
                  bottom: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          (post['liked'] as bool) ? Icons.favorite : Icons.favorite_border,
                          size: 12,
                          color: (post['liked'] as bool) ? Colors.redAccent : Colors.white70,
                        ),
                        const SizedBox(width: 3),
                        Text('${post['likes']}', style: const TextStyle(color: Colors.white, fontSize: 10)),
                        const Spacer(),
                        Icon(
                          (post['saved'] as bool?) == true ? Icons.bookmark : Icons.bookmark_border,
                          size: 12,
                          color: (post['saved'] as bool?) == true ? const Color(0xFF2DE091) : Colors.white70,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeedView() {
    final posts = _feedPosts.values.toList();
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: posts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final post = posts[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF151D23),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(post['image'], width: double.infinity, height: 220, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post['caption'],
                      style: const TextStyle(color: Colors.white, fontSize: 13, height: 1.4),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => _togglePostLike(post),
                              child: Icon(
                                post['liked'] ? Icons.favorite : Icons.favorite_border,
                                color: post['liked'] ? Colors.red : Colors.white54,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text('${post['likes']}', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () => _showCommentSheet(context, post),
                              child: const Icon(Icons.chat_bubble_outline, color: Colors.white54, size: 18),
                            ),
                            const SizedBox(width: 4),
                            Text('${post['comments']}', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () => _togglePostSaved(post),
                              child: Icon(
                                (post['saved'] as bool?) == true ? Icons.bookmark : Icons.bookmark_border,
                                color: (post['saved'] as bool?) == true ? const Color(0xFF2DE091) : Colors.white54,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('${post['shares']}', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                            const SizedBox(width: 4),
                            GestureDetector(
                              onTap: () => _sharePostDynamic(post),
                              child: const Icon(Icons.share_outlined, color: Colors.white54, size: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        mainAxisExtent: 205,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NabtProductDetailsPage(
                  product: {
                    'name': product['name']?.toString() ?? 'Farmer Product',
                    'image': product['image']?.toString() ?? '',
                    'price': product['price']?.toString() ?? '',
                    'category': widget.farmerData['farmName']?.toString() ?? 'Farmer Product',
                  },
                  sellerData: widget.farmerData,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF151D23),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(product['image'], width: double.infinity, height: 120, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product['price'],
                        style: const TextStyle(
                          color: Color(0xFF2DE091),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _countColumn(String count, String label) {
    return Column(
      children: [
        Text(count, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _tabButton({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? const Color(0xFF2DE091) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: selected ? const Color(0xFF2DE091) : Colors.white54, size: 18),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: selected ? const Color(0xFF2DE091) : Colors.white54,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),

    );
  }

  void _showCommentSheet(BuildContext context, Map<String, dynamic> post) {
    final TextEditingController commentController = TextEditingController();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF151D23),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Comments', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: Colors.white54)),
                ],
              ),
            ),
            Divider(color: Colors.white24, height: 1),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(12),
                itemCount: (post['commentList'] as List).length,
                itemBuilder: (context, index) {
                  final comment = (post['commentList'] as List)[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(child: Image.network(comment['avatar'] ?? 'https://i.pravatar.cc/150?img=1', width: 36, height: 36, fit: BoxFit.cover)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(comment['user'], style: const TextStyle(color: Color(0xFF2DE091), fontSize: 12, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 3),
                              Text(comment['text'], style: const TextStyle(color: Colors.white70, fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 12, right: 12, top: 12),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.white24))),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: const Color(0xFF0B0F12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Color(0xFF2DE091), width: 1)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.white24, width: 0.5)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      if (commentController.text.isNotEmpty) {
                        setState(() {
                          (post['commentList'] as List).add({'user': 'You', 'text': commentController.text, 'avatar': 'https://i.pravatar.cc/150?img=5'});
                          post['comments']++;
                          commentController.clear();
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF2DE091)),
                      child: const Icon(Icons.send, color: Colors.black, size: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// CALL PAGE (WHATSAPP STYLE)
// =====================================================
class CallPage extends StatefulWidget {
  final String participantName;
  final String participantImageUrl;

  const CallPage({
    super.key,
    this.participantName = 'Green Garden Store',
    this.participantImageUrl = 'https://images.unsplash.com/photo-1544723795-3fb6469f5b39?w=500&q=80',
  });

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> with WidgetsBindingObserver {
  bool _isMuted = false;
  bool _isLoudSpeaker = false;
  bool _isVideoOn = false;
  int _callDuration = 0;
  late Timer _callTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startCallTimer();
  }

  void _startCallTimer() {
    _callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() => _callDuration++);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _callTimer.cancel();
    super.dispose();
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _endCall() {
    _callTimer.cancel();
    Navigator.pop(context);
  }

  void _toggleCamera() {
    setState(() => _isVideoOn = !_isVideoOn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      body: Column(
        children: [
          // Live Camera Feed Area
          Expanded(
            child: Stack(
              children: [
                if (_isVideoOn)
                  // Live camera area with animated background
                  Container(
                    color: Colors.black,
                    child: Stack(
                      children: [
                        // Animated camera effect
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF2DE091).withValues(alpha: 0.3),
                                const Color(0xFF31D6FF).withValues(alpha: 0.2),
                                Colors.black,
                              ],
                            ),
                          ),
                        ),
                        // Live camera feed placeholder (acts as camera view)
                        Center(
                          child: Text(
                            '📹 Live Camera Active',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  // Glass green background when camera is off
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF2DE091).withValues(alpha: 0.15),
                          const Color(0xFF31D6FF).withValues(alpha: 0.10),
                        ],
                      ),
                    ),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        color: const Color(0xFF0B0F12).withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                // Seller profile overlay - Center
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Seller Profile Picture with glow effect
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2DE091).withValues(alpha: 0.6),
                              blurRadius: 25,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF2DE091), Color(0xFF31D6FF)],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: ClipOval(
                              child: Image.network(
                                widget.participantImageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey,
                                    child: const Center(
                                      child: Icon(Icons.person, color: Colors.white, size: 80),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Seller Name
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFF2DE091).withValues(alpha: 0.5)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              widget.participantName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              _isVideoOn ? 'Video Call Active' : 'Calling...',
                              style: TextStyle(
                                color: _isVideoOn ? const Color(0xFF2DE091) : Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Call Duration
                      Text(
                        _formatDuration(_callDuration),
                        style: const TextStyle(
                          color: Color(0xFF2DE091),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Control buttons
          Container(
            color: const Color(0xFF12181D),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              children: [
                // Top controls row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Mute button
                    GestureDetector(
                      onTap: () => setState(() => _isMuted = !_isMuted),
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isMuted
                              ? const Color(0xFF2DE091).withValues(alpha: 0.2)
                              : Colors.white.withValues(alpha: 0.1),
                          border: Border.all(
                            color: _isMuted ? const Color(0xFF2DE091) : Colors.white24,
                          ),
                        ),
                        child: Icon(
                          _isMuted ? Icons.mic_off : Icons.mic,
                          color: _isMuted ? const Color(0xFF2DE091) : Colors.white70,
                          size: 24,
                        ),
                      ),
                    ),
                    // Speaker button
                    GestureDetector(
                      onTap: () => setState(() => _isLoudSpeaker = !_isLoudSpeaker),
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isLoudSpeaker
                              ? const Color(0xFF31D6FF).withValues(alpha: 0.2)
                              : Colors.white.withValues(alpha: 0.1),
                          border: Border.all(
                            color: _isLoudSpeaker ? const Color(0xFF31D6FF) : Colors.white24,
                          ),
                        ),
                        child: Icon(
                          _isLoudSpeaker ? Icons.volume_up : Icons.volume_down,
                          color: _isLoudSpeaker ? const Color(0xFF31D6FF) : Colors.white70,
                          size: 24,
                        ),
                      ),
                    ),
                    // Video/Camera button
                    GestureDetector(
                      onTap: _toggleCamera,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isVideoOn
                              ? const Color(0xFF2DE091).withValues(alpha: 0.2)
                              : Colors.white.withValues(alpha: 0.1),
                          border: Border.all(
                            color: _isVideoOn ? const Color(0xFF2DE091) : Colors.white24,
                          ),
                          boxShadow: _isVideoOn
                              ? [
                                  BoxShadow(
                                    color: const Color(0xFF2DE091).withValues(alpha: 0.5),
                                    blurRadius: 12,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : [],
                        ),
                        child: Icon(
                          _isVideoOn ? Icons.videocam : Icons.videocam_outlined,
                          color: _isVideoOn ? const Color(0xFF2DE091) : Colors.white70,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // End call button
                GestureDetector(
                  onTap: _endCall,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red,
                          blurRadius: 20,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.call_end,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

