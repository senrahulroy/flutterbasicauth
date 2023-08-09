import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:uiwithcomponent/clonewithriverpod/stream_provider.dart';

class CloneMainScreen extends ConsumerStatefulWidget {
  const CloneMainScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CloneMainScreenState();
}

class _CloneMainScreenState extends ConsumerState<CloneMainScreen> {
  @override
  Widget build(BuildContext context) {
    final dateWatch = ref.watch(dateProvider);
    final counterWatch = ref.watch(counterProvider);
    final currentWeatherWatch = ref.watch(
      weartherProvider,
    );

    final getText =
        counterWatch == null ? 'start increment' : counterWatch.toString();
    return Scaffold(
        appBar: AppBar(title: const Text("Clone App")),
        body: Center(
          child: Column(
            children: [
              Text(
                dateWatch.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Gap(12.h),
              Text(getText),
              Gap(12.h),
              ElevatedButton(
                  onPressed: () {
                    ref.read(counterProvider.notifier).increment();
                  },
                  child: const Text("Increment")),
              const Divider(thickness: 5, color: Colors.red),
              Gap(12.h),
              Text(
                "Start Next",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: 250.h,
                child: Column(
                  children: [
                    currentWeatherWatch.when(
                        data: (data) => Text(
                              data.toLowerCase(),
                              style: const TextStyle(fontSize: 40),
                            ),
                        error: (error, stackTrace) => const Text('😒'),
                        loading: () => const CircularProgressIndicator()),
                    Expanded(
                        child: ListView.builder(
                      itemCount: City.values.length,
                      itemBuilder: (context, index) {
                        final city = City.values[index];
                        final isSelected =
                            city == ref.watch(currentCityProvider);
                        return ListTile(
                          title: Text(
                            city.toString(),
                          ),
                          trailing: isSelected ? const Icon(Icons.check) : null,
                          onTap: () {
                            ref.read(currentCityProvider.notifier).state = city;
                          },
                        );
                      },
                    )),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SteamExample(),
                        ));
                  },
                  child: const Text("Steam Provider")),
            ],
          ),
        ));
  }
}

/// start city enum
enum City { ahmedabad, surat, rajkot, jamnagar, gandhinagar, kalol, palanpur }

///
typedef WeatherEmoji = String;

///
Future<String> getWeather(City city) {
  return Future.delayed(
      const Duration(seconds: 1),
      () =>
          {
            City.ahmedabad: '🌦️',
            City.surat: '🌫️',
            City.jamnagar: '❄️',
            City.rajkot: '🌤️',
            City.gandhinagar: '⛈️',
            City.kalol: '❄️',
            City.palanpur: '🌫️',
          }[city] ??
          'No Wearther');
}

/// UI writes to this
final currentCityProvider = StateProvider<City?>(
  (ref) => null,
);

/// Ui Reads this and reads form this
const unknownWeatherEmoji = '🤷‍♂️';
final weartherProvider = FutureProvider<WeatherEmoji>(
  (ref) {
    final city = ref.watch(currentCityProvider);
    if (city != null) {
      return getWeather(city);
    } else {
      return unknownWeatherEmoji;
    }
  },
);

/// this is a basice example of provider state and stateNotifier
final dateProvider = Provider<DateTime>((ref) {
  return DateTime.now();
});
final counterProvider = StateNotifierProvider<Counter, int?>((ref) {
  return Counter();
});

class Counter extends StateNotifier<int?> {
  Counter() : super(null);

  void increment() => state = state == null ? 1 : state! + 1;
}

/// this is for check null operator
// extension OptionalInfixaddtion<T extends num> on T? {
//   T? operator +(T? other) {
//     final shadow = this;
//     if (shadow != null) {
//       return shadow + (other ?? 0) as T;
//     } else {
//       return null;
//     }
//   }
// }

// void testIt() {
//   final int? int1 = 1;
//   final int? int2 = 1;

//   final result = int1 + int2;

// }
