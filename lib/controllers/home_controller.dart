import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook_challenge/extensions/validator_extension.dart';
import 'package:widgetbook_challenge/providers/app_provider.dart';
import 'package:widgetbook_challenge/views/home_page.dart';
import 'package:widgetbook_challenge/views/home_view.dart';

///
class HomeController extends State<HomeView> {
  ///
  late AppProvider appProvider;

  ///[TextEditingController] for the textfield input
  late final TextEditingController nameController =
      TextEditingController(text: '');

  ///Form key for checking the form validation
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    ///Disposing the [TextEditingController]
    nameController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appProvider = Provider.of<AppProvider>(context);
  }

  @override
  Widget build(BuildContext context) => HomePage(this);

  ///
  void handleFormSubmit() {
    if (formKey.currentState!.validate()) {
      appProvider.submitForm(nameController.text.trim());
    }
  }

  ///
  String? nameValidator(String? value) {
    if (value.isValidName) {
      return null;
    }
    return 'Please enter valid name';
  }
}
