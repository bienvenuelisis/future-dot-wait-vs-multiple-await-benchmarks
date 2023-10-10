import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:http/http.dart' as http;

class MultipleAwaitBenchmark extends AsyncBenchmarkBase {
  const MultipleAwaitBenchmark() : super('MultipleAwait');

  static void main() {
    const MultipleAwaitBenchmark().report();
  }

  // The benchmark code.
  @override
  Future<void> run() async {
    await http.get(Uri.https("bard.google.com"));
    await http.get(Uri.https("chat.openai.com"));
    await http.get(Uri.https("claude.ai"));
  }
  // The benchmark code.
  /* @override
  Future<void> run() async {
    http.Response google = await http.get(Uri.https("bard.google.com"));
    http.Response openai = await http.get(Uri.https("chat.openai.com"));
    http.Response claude = await http.get(Uri.https("claude.ai"));

    print(google.statusCode);
    print(openai.statusCode);
    print(claude.statusCode);
  } */

  // Not measured setup code executed prior to the benchmark runs.
  @override
  Future<void> setup() async {}

  // Not measured teardown code executed after the benchmark runs.
  @override
  Future<void> teardown() async {}

  // To opt into the reporting the time per run() instead of per 10 run() calls.
  //@override
  //void exercise() => run();
}

class FutureDotAwaitBenchmark extends AsyncBenchmarkBase {
  const FutureDotAwaitBenchmark() : super('FutureDotAwait');

  static void main() {
    const FutureDotAwaitBenchmark().report();
  }

  /* // The benchmark code.
  @override
  Future<void> run() async {
    List<http.Response> responses = await Future.wait([
      http.get(Uri.https("bard.google.com")),
      http.get(Uri.https("chat.openai.com")),
      http.get(Uri.https("claude.ai")),
    ]);

    ({
      http.Response google,
      http.Response openai,
      http.Response claude
    }) namedResponses = (
      google: responses[0],
      openai: responses[1],
      claude: responses[2],
    );

    print(namedResponses.google.statusCode);
    print(namedResponses.openai.statusCode);
    print(namedResponses.claude.statusCode);
  } */

  // The benchmark code.
  @override
  Future<void> run() async {
    await Future.wait([
      http.get(Uri.https("bard.google.com")),
      http.get(Uri.https("chat.openai.com")),
      http.get(Uri.https("claude.ai")),
    ]);
  }

  // Not measured setup code executed prior to the benchmark runs.
  @override
  Future<void> setup() async {}

  // Not measured teardown code executed after the benchmark runs.
  @override
  Future<void> teardown() async {}

  // To opt into the reporting the time per run() instead of per 10 run() calls.
  //@override
  //void exercise() => run();
}

void main(List<String> arguments) async {
  // Run the benchmarks for 10 runs, with multiple await and report the results.
  MultipleAwaitBenchmark.main();

  // Run the benchmarks for 10 runs, with Future.wait and report the results.
  FutureDotAwaitBenchmark.main();
}
