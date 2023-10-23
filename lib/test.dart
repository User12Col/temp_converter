import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class MyApp extends StatefulWidget {
  final CameraDescription camera;

  MyApp(this.camera);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.high);
    _initializeCamera();
  }

  void _initializeCamera() async {
    await _requestCameraPermission();
    await _controller.initialize();
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isGranted) {
      // Quyền đã được cấp, có thể sử dụng Camera.
      return;
    } else {
      final result = await Permission.camera.request();
      if (result.isGranted) {
        // Quyền đã được cấp, có thể sử dụng Camera.
        return;
      } else {
        // Quyền bị từ chối, hiển thị thông báo cho người dùng.
        openAppSettings(); // Mở cài đặt ứng dụng để người dùng cấp quyền.
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Code Demo'),
        ),
        body: Center(
          child: _controller.value.isInitialized
              ? CameraPreview(_controller)
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}

