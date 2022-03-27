import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CarouselSlider extends StatefulWidget {
  final List<String> images;
  const CarouselSlider({Key? key, required this.images}) : super(key: key);

  @override
  State<CarouselSlider> createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.images.length,
        pageSnapping: true,
        controller: _pageController,
        allowImplicitScrolling: true,
        itemBuilder: (context, pagePosition) {
          return Container(
              margin: const EdgeInsets.all(10),
              child: InkWell(
                onTap: () => showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (context) => Dialog(
                    backgroundColor: Colors.transparent,
                    child: ExtendedImage.network(
                      widget.images[pagePosition],
                      cache: true,
                      fit: BoxFit.contain,
                      mode: ExtendedImageMode.gesture,
                      initGestureConfigHandler: (state) {
                        return GestureConfig(
                          minScale: 0.9,
                          animationMinScale: 0.7,
                          maxScale: 3.0,
                          animationMaxScale: 3.5,
                          speed: 1.0,
                          inertialSpeed: 100.0,
                          initialScale: 1.0,
                          inPageView: false,
                          initialAlignment: InitialAlignment.center,
                        );
                      },
                    ),
                  ),
                ),
                child: ExtendedImage.network(
                  widget.images[pagePosition],
                  cache: true,
                  fit: BoxFit.cover,
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
              ));
        });
  }
}
