import 'package:flutter/material.dart';

class InternoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: Stack(
          children: [_BackgroundImage(), _nombre()],
        ),
      ),
    );
  }
}

class _nombre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 20,
      color: Colors.red,
    );
  }
}

class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: _boxDecoration(),
      child: const FadeInImage(
          image: AssetImage('assets/internos_images'),
          placeholder: AssetImage('assets/jar-loading.gif'),
          fit: BoxFit.cover),
    );
  }

  BoxDecoration _boxDecoration() => const BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Colors.black45, offset: Offset(0, 6), blurRadius: 10)
      ],
      borderRadius: BorderRadiusDirectional.all(Radius.circular(10)));
}
