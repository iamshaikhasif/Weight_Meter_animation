import 'package:flutter/material.dart';
import 'package:weight_meter_animation/circleController.dart';
import 'package:weight_meter_animation/circularWheel.dart';
import 'package:get/get.dart';
import 'package:weight_meter_animation/commonMethod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
GlobalKey<CircularWheelState> _keyWeight = GlobalKey<CircularWheelState>();
  
   var controller = Get.put(CircleController());
  
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: CircularWheel(
              key: _keyWeight,
              initVal: controller.weightHq.value,
              type: "${controller.weightUnit.value.toLowerCase()}",
              onChanged: (val) {
                
              },
            ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  weightQuestion() {
    return Column(
      children: [
        GridView.builder(
          itemCount: controller.weightOptions.length,
          itemBuilder: (context, index) {
            return Obx(
              () => OptionButton(
                onTap: () {
                  if (controller.weightUnit.value.toLowerCase() !=
                      controller.weightOptions[index].toLowerCase()) {
                    controller.weightUnit.value =
                        controller.weightOptions[index];
                    int v;
                    if (controller.weightUnit.value.toLowerCase() == "kg") {
                      v = (controller.weightHq.value * 0.45359237).round();
                      _keyWeight.currentState?.setKGData(
                          v, controller.weightUnit.value.toLowerCase());
                      controller.setWeight(v);
                    } else {
                      v = (controller.weightHq.value / 0.45359237).round();
                      _keyWeight.currentState?.setLBData(
                          v, controller.weightUnit.value.toLowerCase());
                      controller.setWeight(v);
                    }
                  }
                },
                title: controller.weightOptions[index],
                isActive: (controller.weightOptions[index] ==
                    controller.weightUnit.value.toUpperCase()),
              ),
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.8,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0),
          shrinkWrap: true,
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => CircularWheel(
            key: _keyWeight,
            initVal: controller.weightHq.value,
            type: "${controller.weightUnit.value.toLowerCase()}",
            onChanged: (val) {
              print(val);
              controller.setWeight(val);
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Obx(
          () => Text.rich(
            TextSpan(children: [
              TextSpan(
                text: "${controller.weightHq.value}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
              TextSpan(
                  text: " ${controller.weightUnit.value.toLowerCase()}",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ]),
          ),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
