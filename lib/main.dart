
import 'package:flutter/material.dart';

void main() {
  runApp(const JarvisApp());
}

class JarvisApp extends StatelessWidget {
  const JarvisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF02070D),
      ),
      home: const JarvisHome(),
    );
  }
}

class JarvisHome extends StatefulWidget {
  const JarvisHome({super.key});

  @override
  State<JarvisHome> createState() => _JarvisHomeState();
}

class _JarvisHomeState extends State<JarvisHome>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  final TextEditingController input = TextEditingController();
  final List<String> messages = [];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    input.dispose();
    super.dispose();
  }

  void sendMessage() {
    final text = input.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add("YOU: $text");
      messages.add("JARVIS: AI connection will be activated next.");
      input.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 22),
            const Text(
              "J.A.R.V.I.S",
              style: TextStyle(
                color: Color(0xFF00D9FF),
                fontSize: 27,
                letterSpacing: 8,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "PERSONAL AI SYSTEM",
              style: TextStyle(
                color: Colors.white54,
                letterSpacing: 4,
                fontSize: 10,
              ),
            ),
            Expanded(
              flex: 5,
              child: Center(
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: controller.value * 6.283,
                      child: Container(
                        width: 230,
                        height: 230,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            colors: [
                              Color(0xFF063E60),
                              Color(0xFF00BFFF),
                              Color(0xFF031522),
                              Colors.transparent,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00CFFF)
                                  .withValues(alpha: 0.5),
                              blurRadius: 45,
                              spreadRadius: 12,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.hub,
                            size: 85,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Text(
              "SYSTEM ONLINE",
              style: TextStyle(
                color: Color(0xFF00E5FF),
                letterSpacing: 4,
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView(
                padding: const EdgeInsets.all(18),
                children: messages
                    .map(
                      (message) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          message,
                          style: const TextStyle(
                            color: Color(0xFF00D9FF),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: input,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Ask JARVIS...",
                        hintStyle: const TextStyle(color: Colors.white38),
                        filled: true,
                        fillColor: const Color(0xFF10202C),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onSubmitted: (_) => sendMessage(),
                    ),
                  ),
                  IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(
                      Icons.send,
                      color: Color(0xFF00D9FF),
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
