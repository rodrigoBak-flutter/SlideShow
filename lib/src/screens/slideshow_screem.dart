import 'package:app_slideshow_bakapp/src/models/slider_model.dart';
import 'package:app_slideshow_bakapp/src/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SlideShowScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SliderModel(),
      child: Scaffold(
        body: Center(
            child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Expanded(
              child: _Slides(),
            ),
            const _Dots(),
          ],
        )),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.1,
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const _Dot(
            index: 0,
          ),
          const _Dot(
            index: 1,
          ),
          const _Dot(
            index: 2,
          ),
          const _Dot(
            index: 3,
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  const _Dot({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final pageViewIndex = Provider.of<SliderModel>(context).currentPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: size.width * 0.05,
      height: size.height * 0.02,
      decoration: BoxDecoration(
        color: (pageViewIndex >= index - 0.5 && pageViewIndex < index + 0.5)
            ? Colors.pink
            : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides({super.key});

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    pageViewController.addListener(() {
      // print('Pagina Actual: ${pageViewController.page}');

      //Actualizar la instancia de mi Provider
      Provider.of<SliderModel>(context, listen: false).currentPage =
          pageViewController.page!;
      //Condicion para poder saltar de pagina
      if (pageViewController.page! > 2) {
        print('Salto de pagina');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageViewController,
        physics: const BouncingScrollPhysics(),
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const _Slide(svg: 'assets/slide-1.svg'),
          const _Slide(svg: 'assets/slide-2.svg'),
          const _Slide(svg: 'assets/slide-3.svg'),
          Container(),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String svg;

  const _Slide({super.key, required this.svg});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30),
      child: SvgPicture.asset(svg),
    );
  }
}
