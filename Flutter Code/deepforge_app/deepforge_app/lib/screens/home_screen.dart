import 'package:deepforge_app/Providers/deep_provider.dart';
import 'package:deepforge_app/components/Buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('LOADEDDDDDD');
    final provider = Provider.of<DeepProvider>(context, listen: false);
    provider.loadYoloModel().then((value) {
      setState(() {
        Provider.of<DeepProvider>(context, listen: false).isModelLoaded = true;
      });
    }).catchError((onError) {
      print('Error loading model $onError');
    });
  }

  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            'DeepForge',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
     
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Container(
                height: 280,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(79, 163, 157, 157),
                ),
                child: Center(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Consumer<DeepProvider>(
                        builder: (context, provider, child) {
                          if (!provider.isModelLoaded) {
                            return const Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                    strokeWidth: 4, color: Colors.blue),
                                SizedBox(height: 20),
                                Text(
                                    'Model not loaded please waiting for it...')
                              ],
                            ));
                          } else {
                            return provider.imageFile != null
                                ? Image.file(
                                    provider.imageFile!,
                                    height:
                                        240, // Fixed height of the image container
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                  )
                                :  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const  Icon(Icons.image, size: 50),
                                        SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                                  const    Text('Upload image for detection')
                                  ],
                                );
                          }
                        },
                      ),
                      Consumer<DeepProvider>(
                        builder: (context, provider, _) {
                          // Adjust the container size to exclude padding
                          Size containerSize = Size(
                            MediaQuery.of(context).size.width -
                                0, // Adjusted width
                            280, // Fixed height of the container
                          );
                          return Stack(
                              children: provider
                                  .displayBoxesAroundRecognizedObjects(
                                      containerSize));
                        },
                      )
                    ],
                  ),
                )),
          ),
          Consumer<DeepProvider>(builder: (context, provider, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      provider.removeImage();
                    },
                    child: const Text(
                      'Clear',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    )),
              ],
            );
          }),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
          Consumer<DeepProvider>(builder: (context, provider, _) {
            return RoundButton(
                color: Colors.blue,
                title: 'Upload image',
                onTap: () {
                  provider.pickImage();
                  provider.yoloResults.clear();
                  provider.clearErrorMessage();
                });
          }),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
          Consumer<DeepProvider>(builder: (context, provider, _) {
            return MoreButton(
                title: 'Detect',
                onTap: () {
                  if (provider.imageFile == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text('Please upload an image before detecting.'),
                      duration: Duration(seconds: 2),
                    ));
                  } else {
                    provider.detectObjects();
                    provider.clearErrorMessage();
                  }
                },
                color: const Color.fromARGB(255, 54, 206, 59));
          }),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          Consumer<DeepProvider>(builder: (context, provider, _) {
            return Text(provider.errorMessage,
                style: TextStyle(
                    fontSize: 20,
                    color: provider.yoloResults.isNotEmpty
                        ? Color.fromARGB(255, 54, 206, 59)
                        : Colors.red));
          })
        ],
      ),
    );
  }
}
