import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lockre/screens/send/amount_to_send.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart'; // Commented out
import 'package:permission_handler/permission_handler.dart';
// import 'package:contacts_service/contacts_service.dart' as contacts_service; // Commented out
// import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart' as native_picker; // Commented out
import 'package:lockre/constants/colors.dart';
import 'package:lockre/routes/route.dart'; // Import the MyRoutes class

class SenderNumberScreen extends StatefulWidget {
  @override
  _SenderNumberScreenState createState() => _SenderNumberScreenState();
}

class _SenderNumberScreenState extends State<SenderNumberScreen> {
  // List<contacts_service.Contact> _contacts = []; // Commented out
  // List<contacts_service.Contact> _filteredContacts = []; // Commented out
  bool _isLoading = true;
  final TextEditingController _controller = TextEditingController();
  String _selectedCountryCode = 'BF';
  // final native_picker.FlutterContactPicker _contactPicker = native_picker.FlutterContactPicker(); // Commented out
  bool _isButtonPressed = false;

  @override
  void initState() {
    super.initState();
    _askPermissions();
    _controller.addListener(_filterContacts);
    // _getContacts(); // Commented out the call to _getContacts
  }

  @override
  void dispose() {
    _controller.removeListener(_filterContacts);
    _controller.dispose();
    super.dispose();
  }

  Future<void> _askPermissions() async {
    var status = await Permission.contacts.request();
    if (!status.isGranted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Future<void> _getContacts() async { // Commented out
  //   try {
  //     var contacts = await contacts_service.ContactsService.getContacts(); // Commented out
  //     setState(() {
  //       _contacts = contacts.toList(); // Commented out
  //       _filteredContacts = _contacts; // Commented out
  //       _isLoading = false;
  //     });
  //   } catch (e) {
  //     print('Error fetching contacts: $e');
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  void _filterContacts() {
    String query = _controller.text.toLowerCase();
    setState(() {
      // _filteredContacts = _contacts.where((contact) { // Commented out
      //   String contactName = contact.displayName?.toLowerCase() ?? ''; // Commented out
      //   var phoneNumbers = contact.phones?.map((e) => e.value ?? '').toList() ?? []; // Commented out
      //   return phoneNumbers.any((phoneNumber) => phoneNumber.contains(query)) || contactName.contains(query); // Commented out
      // }).toList(); // Commented out
    });
  }

  String _normalizePhoneNumber(String phoneNumber) {
    return phoneNumber.replaceAll(RegExp(r'\D'), '');
  }

  Widget _animatedButton({
    required VoidCallback onPressed,
    required String label,
    required bool isPressed,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      decoration: BoxDecoration(
        color: isPressed ? Colors.white : AppColors.primaryColor,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColors.primaryColor),
      ),
      child: InkWell(
        onTap: onPressed,
        onHighlightChanged: (value) {
          setState(() {
            _isButtonPressed = value;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: isPressed ? AppColors.primaryColor : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Numéro du récepteur', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // _buildPhoneNumberInput(), // Commented out
            const SizedBox(height: 20),
            const Text('Choisir dans la liste de mes contacts ', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildContactList(),
            const Spacer(),
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  // Widget _buildPhoneNumberInput() { // Commented out
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: InternationalPhoneNumberInput( // Commented out
  //           onInputChanged: (PhoneNumber number) { // Commented out
  //             setState(() { // Commented out
  //               _selectedCountryCode = number.isoCode ?? 'BF'; // Commented out
  //               _filterContacts(); // Commented out
  //             }); // Commented out
  //           }, // Commented out
  //           inputDecoration: const InputDecoration( // Commented out
  //             labelText: 'Entrez le numéro du récepteur', // Commented out
  //           ), // Commented out
  //           initialValue: PhoneNumber(isoCode: _selectedCountryCode), // Commented out
  //           selectorConfig: const SelectorConfig( // Commented out
  //             selectorType: PhoneInputSelectorType.DIALOG, // Commented out
  //           ), // Commented out
  //           autoValidateMode: AutovalidateMode.onUserInteraction, // Commented out
  //           ignoreBlank: false, // Commented out
  //           selectorTextStyle: const TextStyle(color: Colors.black), // Commented out
  //         ), // Commented out
  //       ),
  //     ],
  //   );
  // }

  Widget _buildContactList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    // if (_filteredContacts.isEmpty) { // Commented out
    //   return const Center(child: Text('Aucun contact trouvé')); // Commented out
    // }
    // return Expanded(
    //   child: ListView.builder(
    //     itemCount: _filteredContacts.length, // Commented out
    //     itemBuilder: (context, index) { // Commented out
    //       var contact = _filteredContacts[index]; // Commented out
    //       var phoneNumbers = contact.phones?.map((e) => _normalizePhoneNumber(e.value ?? '')).toList() ?? []; // Commented out
    //       return Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: phoneNumbers.map((phone) => ContactItem( // Commented out
    //           name: contact.displayName ?? '', // Commented out
    //           phone: phone, // Commented out
    //           onContactSelected: (selectedPhone) { // Commented out
    //             setState(() { // Commented out
    //               _controller.text = selectedPhone ?? ''; // Commented out
    //             }); // Commented out
    //           }, // Commented out
    //         )).toList(), // Commented out
    //       ); // Commented out
    //     }, // Commented out
    //   ); // Commented out
    // }
    return const Center(child: Text('Contact list not available')); // Placeholder text
  }

  Widget _buildContinueButton() {
    return Center(
      child: _animatedButton(
        onPressed: () {
          if (_controller.text.isNotEmpty) {
            Get.to(() => AmountToSendScreen(selectedNumber: _controller.text));
          }
        },
        label: 'Continuer',
        isPressed: _isButtonPressed,
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final String name;
  final String phone;
  final Function(String?) onContactSelected;

  ContactItem({required this.name, required this.phone, required this.onContactSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onContactSelected(phone),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.account_circle, size: 50),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(phone, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
