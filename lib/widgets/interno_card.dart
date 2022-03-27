import 'package:flutter/material.dart';
import 'package:penitenciario/models/interno.dart';

class InternoCard extends StatelessWidget {
  final Interno interno;
  const InternoCard({Key? key, required this.interno}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? nameandsurname = interno.name! + " " + interno.surname!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _BackgroundImage(interno.picture),
            _Datos(
              niss: interno.niss!,
              nameSurname: nameandsurname,
            ),
          ],
        ),
      ),
    );
  }
}

class _Datos extends StatelessWidget {
  final String niss;
  final String nameSurname;

  const _Datos({required this.niss, required this.nameSurname});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 0.5,
        horizontal: 5,
      ),
      width: double.infinity,
      decoration: _builBoxDecoration(),
      height: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            niss,
            style: const TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            nameSurname,
            style: const TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  BoxDecoration _builBoxDecoration() => BoxDecoration(
      color: Colors.green[300],
      borderRadius: const BorderRadius.all(Radius.circular(5)));
}

class _BackgroundImage extends StatelessWidget {
  final String? url;

  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        decoration: _boxDecoration(),
        child: url == null
            ? const Image(
                image: AssetImage('assets/internos_images/no-image.png'),
                fit: BoxFit.cover,
              )
            : FadeInImage(
                image: NetworkImage(url!),
                placeholder:
                    const AssetImage('assets/internos_images/jar-loading.gif'),
                fit: BoxFit.cover),
      ),
    );
  }

  BoxDecoration _boxDecoration() => const BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(color: Colors.black45, offset: Offset(0, 6), blurRadius: 10)
      ],
      borderRadius: BorderRadiusDirectional.all(Radius.circular(10)));
}
