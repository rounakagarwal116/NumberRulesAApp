import 'package:flutter/material.dart';

class GridScreen extends StatefulWidget {
  @override
  _GridScreenState createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  List<int> numbers = List.generate(100, (index) => index + 1);
  String selectedRule = 'Select Rule';
  Set<int> highlightedNumbers = {};

  @override
  void initState() {
    super.initState();
    updateHighlightedNumbers();
  }

  void updateHighlightedNumbers() {
    setState(() {
      highlightedNumbers = applyRule(selectedRule);
    });
  }

  Set<int> applyRule(String rule) {
    switch (rule) {
      case 'Odd':
        return numbers.where((n) => n % 2 != 0).toSet();
      case 'Even':
        return numbers.where((n) => n % 2 == 0).toSet();
      case 'Prime':
        return getPrimes(numbers.last);
      case 'Fibonacci':
        return getFibonacci(numbers.last);
      default:
        return {};
    }
  }

  Set<int> getPrimes(int n) {
    List<bool> isPrime = List<bool>.filled(n + 1, true);
    isPrime[0] = isPrime[1] = false;

    for (int i = 2; i * i <= n; i++) {
      if (isPrime[i]) {
        for (int j = i * i; j <= n; j += i) {
          isPrime[j] = false;
        }
      }
    }

    Set<int> primes = {};
    for (int i = 2; i <= n; i++) {
      if (isPrime[i]) {
        primes.add(i);
      }
    }

    return primes;
  }

  Set<int> getFibonacci(int n) {
    Set<int> fibonacci = {};
    int a = 0, b = 1;

    while (a <= n) {
      fibonacci.add(a);
      int temp = a;
      a = b;
      b = temp + b;
    }

    return fibonacci;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            value: selectedRule,
            onChanged: (String? newValue) {
              setState(() {
                selectedRule = newValue!;
                updateHighlightedNumbers();
              });
            },
            items: <String>['Select Rule', 'Odd', 'Even', 'Prime', 'Fibonacci']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(fontSize: 20)),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 10,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 20.0,
              ),
              itemCount: numbers.length,
              itemBuilder: (context, index) {
                int number = numbers[index];
                bool isHighlighted = highlightedNumbers.contains(number);

                return Container(
                  decoration: BoxDecoration(
                    color: isHighlighted ? Colors.blue : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      number.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isHighlighted ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
