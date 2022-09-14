import 'package:flutter/material.dart';
import 'package:widgetbook_challenge/controllers/home_controller.dart';
import 'package:widgetbook_challenge/infrastructure/widget_view.dart';
import 'package:widgetbook_challenge/providers/app_provider.dart';
import 'package:widgetbook_challenge/views/home_view.dart';

/// [HomePage] widget
/// this holds the main ui
///
class HomePage extends WidgetView<HomeView, HomeController> {
  ///  Creates a new instance of [HomePage].
  const HomePage(HomeController state, {Key? key}) : super(state, key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: const Text('Interview Challenge'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: state.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: state.nameController,
                      validator: state.nameValidator,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter your name',
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(MediaQuery.of(context).size.width, 45),
                      ),
                      onPressed: () async {
                        state.handleFormSubmit();
                      },
                      child: state.appProvider.appStatus == AppStatus.processing
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : const Text('Submit'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      state.appProvider.apiResponse,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (state.appProvider.appStatus == AppStatus.processing)
            const ModalBarrier(
              color: Colors.black38,
              dismissible: false,
            )
        ],
      );
}
