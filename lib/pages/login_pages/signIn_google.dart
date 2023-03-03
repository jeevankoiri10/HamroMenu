import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';
import 'dart:convert' show json;

import 'package:http/http.dart' as http;

final GoogleSignIn _googleSignIn = GoogleSignIn();
String userName = '';
String profilePicture = '';
String clientID = '';
GoogleSignInAccount? _currentUser;
String _contactText = '';
bool isLoggedIn = false;

class SignInWithGoogle extends StatefulWidget {
  const SignInWithGoogle({super.key});

  @override
  State<SignInWithGoogle> createState() => _SignInWithGoogleState();
}

class _SignInWithGoogleState extends State<SignInWithGoogle> {
  @override
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
        (dynamic name) =>
            (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (isLoggedIn == true && user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          Text(_contactText),
          ElevatedButton(
            onPressed: () => _googleSignIn.signOut(),
            child: const Text('SIGN OUT'),
          ),
          ElevatedButton(
              child: const Text('REFRESH'),
              onPressed: () async {
                final http.Response response = await http.get(
                  Uri.parse(
                      'https://people.googleapis.com/v1/people/me/connections'
                      '?requestMask.includeField=person.names'),
                  headers: await user.authHeaders,
                );
              }),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            onPressed: () {
              _googleSignIn.signIn().then((value) {
                userName = value!.displayName!;
                profilePicture = value!.photoUrl!;
              });
              // if signed in go to the homeScreen
              // _googleSignIn
              //     .isSignedIn()
              //     .then(((value) => Navigator.pushNamed(context, '/')));

              clientID = _googleSignIn.clientId.toString();
              isLoggedIn = true;
              setState(() {});
            },
            child: const Text('SIGN IN'),
          ),
        ],
      );
    }
  }

  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          _buildBody(),
          // Image.network('https://www.flaticon.com/free-icon/search_281764'),
          //Text('Sign In with Google'),
        ],
      ),
    );
  }
}
