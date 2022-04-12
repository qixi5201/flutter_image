import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '瀏覽影像',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 建立 AppBar
    final appBar = AppBar(
      title: Text('瀏覽影像'),
    );
    const images = <String>[
      'assets/img1.jpg',
      'assets/img2.jpg',
      'assets/img3.jpg'];
    final gallery = _PhotoViewGalleryWrapper(
      GlobalKey<_PhotoViewGalleryWrapperState>(),
      images, BoxDecoration(color: Colors.white,),
      0, 0.6, 1.2, Axis.horizontal,
    );

    // 結合 AppBar 和 App 操作畫面
    final appHomePage = Scaffold(
      appBar: appBar,
      body: gallery,
    );
    return appHomePage;
  }
}
class _PhotoViewGalleryWrapper extends StatefulWidget {
  final GlobalKey<_PhotoViewGalleryWrapperState> _key;
  List<String> _images;
  Decoration _backgroundDecoration;
  int _initialIndex;
  double _minScale, _maxScale;
  Axis _scrollDirection;
  int _imageIndex;
  _PhotoViewGalleryWrapper(this._key, this._images, this._backgroundDecoration,
      this._initialIndex, this._minScale, this._maxScale,
      this._scrollDirection): super (key: _key) {
    _imageIndex = _initialIndex;
  }
  @override

  State<StatefulWidget> createState() => _PhotoViewGalleryWrapperState();
}

class _PhotoViewGalleryWrapperState extends State<_PhotoViewGalleryWrapper> {

  @override

  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        PhotoViewGallery.builder(
          scrollPhysics: BouncingScrollPhysics(),
          builder: _buildItem,
          itemCount: widget._images.length,
          enableRotation: true,
          backgroundDecoration: widget._backgroundDecoration,
          pageController: PageController(initialPage: widget._initialIndex),
          onPageChanged: _onPageChanged,
          scrollDirection: widget._scrollDirection,
        ),
      ],
    );
  }
  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    return PhotoViewGalleryPageOptions(
      imageProvider: AssetImage(widget._images[index]),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * 0.6,
      maxScale: PhotoViewComputedScale.covered,
    );
  }
  void _onPageChanged(int index) {
    setState(() {
      widget._imageIndex = index;
    });
  }
}