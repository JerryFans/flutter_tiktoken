## flutter_tiktoken

flutter_tiktoken is a flutter offline package for a fast BPE tokeniser for OpenAI models.

flutter_tiktoken is a copy package in [https://github.com/mvitlov/tiktoken](https://github.com/mvitlov/tiktoken) and fixed the [issue](https://github.com/mvitlov/tiktoken/issues/5) build spent many time (more than one hour) when build in release mode.

Open Ai Official Calcuate           |  flutter_tiktoken
:-------------------------:|:-------------------------:
![Snip20230621_3](https://github.com/JerryFans/flutter_tiktoken/assets/14149080/96a7153e-dfd5-40ee-a1cc-c9efc205a844) | ![Simulator Screenshot - iPhone 14 - 2023-06-21 at 18 43 10](https://github.com/JerryFans/flutter_tiktoken/assets/14149080/dcd5162f-92bf-49ab-b9e8-5364c3c5c7df)

## Usage

init flutter_tiktoken
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TiktokenDataProcessCenter().initata();
  runApp(const MyApp());
}
```

calcuateTokens
```dart
static int _calcuateTokens(
      {required String text, String modelName = 'gpt-4'}) {
    final encoding = encodingForModel(modelName);
    final numTokens = encoding.encode(text).length;
    return numTokens;
  }
```
