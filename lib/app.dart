import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook_challenge/extensions/validator_extension.dart';
import 'package:widgetbook_challenge/providers/app_provider.dart';

/// The app.
class App extends StatelessWidget {
  /// Creates a new instance of [App].
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light(),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(),
      ),
    );
  }
}

/// [HomePage] widget
class HomePage extends StatefulWidget {
  ///  Creates a new instance of [HomePage].
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///[TextEditingController] for the name textfield
  late final TextEditingController _nameController;

  ///Formkey for checking validation
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    ///initializing the [TextEditingController]
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    ///Disposing the [TextEditingController]
    _nameController.dispose();
  }

  Future<void> submitForm(AppProvider appProvider) async {
    if (_formKey.currentState!.validate()) {
      final result =
          await appProvider.submitForm(_nameController.text.trim(), context);

      /// do anything you want with the result
      /// whether is successful or results in an error
      /// everything is handled in the app provider class
    }
  }

  @override
  Widget build(BuildContext context) => Consumer<AppProvider>(
        builder: (context, appProvider, _) => Scaffold(
          appBar: AppBar(
            title: const Text('Interview Challenge'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _nameController,
                    validator: (value) {
                      if (value.isValidName) {
                        return null;
                      }
                      return 'Please enter valid name';
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      contentPadding: const EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    ),
                    onPressed: () async {
                      await submitForm(appProvider);
                    },
                    child: appProvider.appStatus == AppStatus.processing
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : const Text('Submit'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    appProvider.apiResponse,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
