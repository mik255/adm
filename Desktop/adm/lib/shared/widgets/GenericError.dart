import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GenericError extends StatelessWidget {
  final String title;
  final String subtitle;
  final String errorCode;

  const GenericError({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.errorCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.error,size: 80,color: Colors.amber,),
                  const SizedBox(height: 16,),
                   Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 21),
                  ),
                  const SizedBox(height: 12),
                   Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                   Text(
                    "error code : $errorCode",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(height: 16,),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('voltar'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
