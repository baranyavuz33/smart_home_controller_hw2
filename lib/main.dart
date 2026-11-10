import 'package:flutter/material.dart';
import 'models/smart_device.dart';
import 'models/smart_light.dart';
import 'models/thermostat.dart';
import 'models/smart_speaker.dart';

void main() {
  runApp(const SmartHomeApp());
}

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Controller',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Creating objects with default constructors
  late final SmartLight smartLight;
  late final Thermostat thermostat;
  late final SmartSpeaker smartSpeaker;

  // Creating objects with named constructors
  late final SmartLight bedroomLight;

  @override
  void initState() {
    super.initState();
    // Reset device count to avoid duplication on hot reload
    SmartDevice.deviceCount = 0;

    // Using default constructor
    smartLight = SmartLight('Living Room Light', 'Living Room',
        isOn: true, brightness: 75);
    smartLight.connect();

    // Using named constructor
    bedroomLight = SmartLight.withDefaults(name: 'Bedroom Light');
    bedroomLight.connect();

    // Using default constructor
    thermostat = Thermostat('Main Thermostat', 'Hallway',
        temperature: 22.5, isHeating: true);
    thermostat.connect();
    thermostat.schedule('08:00 AM'); // Demonstrating mixin

    // Using named constructor
    smartSpeaker =
        SmartSpeaker.withDefaults(name: 'Kitchen Speaker', volume: 40);
    smartSpeaker.connect();
    smartSpeaker.currentTrack = 'Chill Vibes Playlist';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Home Controller'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: const Icon(Icons.home),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSmartLightCard(smartLight),
                const SizedBox(height: 12),
                _buildThermostatCard(thermostat),
                const SizedBox(height: 12),
                _buildSmartSpeakerCard(smartSpeaker),
                const SizedBox(height: 12),
                _buildSmartLightCard(bedroomLight),
              ],
            ),
          ),
          // Bottom bar showing total device count using static variable
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Text(
              'Total Devices: ${SmartDevice.getTotalDevices()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Smart Light Card ───────────────────────────────────────────
  Widget _buildSmartLightCard(SmartLight light) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Icon(Icons.lightbulb,
                    color: light.isOn ? Colors.amber : Colors.grey, size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(light.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Location: ${light.location}',
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
                // Connection indicator
                Icon(
                  light.isConnected ? Icons.wifi : Icons.wifi_off,
                  color: light.isConnected ? Colors.green : Colors.red,
                  size: 20,
                ),
              ],
            ),
            const Divider(),
            // Status
            Text('Status: ${light.getStatus()}',
                style: const TextStyle(fontSize: 14)),
            if (light.isScheduled)
              Text('Scheduled: ${light.scheduledTime}',
                  style: TextStyle(fontSize: 13, color: Colors.blue[700])),
            const SizedBox(height: 8),
            // Controls
            Row(
              children: [
                const Text('Power: '),
                Switch(
                  value: light.isOn,
                  onChanged: (value) {
                    setState(() {
                      light.performAction();
                    });
                  },
                ),
              ],
            ),
            // Brightness slider (only visible when light is on)
            if (light.isOn)
              Row(
                children: [
                  const Icon(Icons.brightness_low, size: 18),
                  Expanded(
                    child: Slider(
                      value: light.brightness.toDouble(),
                      min: 0,
                      max: 100,
                      divisions: 20,
                      label: '${light.brightness}%',
                      onChanged: (value) {
                        setState(() {
                          light.setBrightness(value.toInt());
                        });
                      },
                    ),
                  ),
                  const Icon(Icons.brightness_high, size: 18),
                  const SizedBox(width: 4),
                  Text('${light.brightness}%'),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // ─── Thermostat Card ────────────────────────────────────────────
  Widget _buildThermostatCard(Thermostat thermo) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Icon(Icons.thermostat,
                    color: thermo.isHeating ? Colors.deepOrange : Colors.blueGrey,
                    size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(thermo.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Location: ${thermo.location}',
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
                Icon(
                  thermo.isConnected ? Icons.wifi : Icons.wifi_off,
                  color: thermo.isConnected ? Colors.green : Colors.red,
                  size: 20,
                ),
              ],
            ),
            const Divider(),
            // Status
            Text('Status: ${thermo.getStatus()}',
                style: const TextStyle(fontSize: 14)),
            if (thermo.isScheduled)
              Text('Scheduled: ${thermo.scheduledTime}',
                  style: TextStyle(fontSize: 13, color: Colors.blue[700])),
            const SizedBox(height: 8),
            // Heating toggle
            Row(
              children: [
                const Text('Heating: '),
                Switch(
                  value: thermo.isHeating,
                  activeColor: Colors.deepOrange,
                  onChanged: (value) {
                    setState(() {
                      thermo.performAction();
                    });
                  },
                ),
              ],
            ),
            // Temperature controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      thermo.decreaseTemperature();
                    });
                  },
                  icon: const Icon(Icons.remove_circle_outline),
                  iconSize: 36,
                  color: Colors.blue,
                ),
                const SizedBox(width: 8),
                Text(
                  '${thermo.temperature.toStringAsFixed(1)}°C',
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    setState(() {
                      thermo.increaseTemperature();
                    });
                  },
                  icon: const Icon(Icons.add_circle_outline),
                  iconSize: 36,
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ─── Smart Speaker Card ─────────────────────────────────────────
  Widget _buildSmartSpeakerCard(SmartSpeaker speaker) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              children: [
                Icon(Icons.speaker,
                    color: speaker.isPlaying ? Colors.purple : Colors.grey,
                    size: 32),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(speaker.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('Location: ${speaker.location}',
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
                Icon(
                  speaker.isConnected ? Icons.wifi : Icons.wifi_off,
                  color: speaker.isConnected ? Colors.green : Colors.red,
                  size: 20,
                ),
              ],
            ),
            const Divider(),
            // Status
            Text('Status: ${speaker.getStatus()}',
                style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            // Play/Pause button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      speaker.performAction();
                    });
                  },
                  icon: Icon(
                    speaker.isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                    size: 48,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
            // Volume slider
            Row(
              children: [
                const Icon(Icons.volume_down, size: 18),
                Expanded(
                  child: Slider(
                    value: speaker.volume.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 20,
                    label: '${speaker.volume}%',
                    activeColor: Colors.purple,
                    onChanged: (value) {
                      setState(() {
                        speaker.setVolume(value.toInt());
                      });
                    },
                  ),
                ),
                const Icon(Icons.volume_up, size: 18),
                const SizedBox(width: 4),
                Text('${speaker.volume}%'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
