import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:tuple/tuple.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import '../universal_ui/universal_ui.dart';
import '../widgets/demo_scaffold.dart';

class ReadOnlyPage extends StatefulWidget {
  const ReadOnlyPage({Key? key, this.jsonData}) : super(key: key);

  final String? jsonData;
  @override
  _ReadOnlyPageState createState() => _ReadOnlyPageState();
}

class _ReadOnlyPageState extends State<ReadOnlyPage> {
  final FocusNode _focusNode = FocusNode();

  bool _edit = false;

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      // documentFilename: 'sample_data.json',
      documentFilename: widget.jsonData!,
      builder: _buildContent,
      showToolbar: _edit == true,
      // floatingActionButton: FloatingActionButton.extended(
      //     label: Text(_edit == true ? 'Done' : 'Edit'),
      //     onPressed: _toggleEdit,
      //     icon: Icon(_edit == true ? Icons.check : Icons.edit)),
    );
  }

  Widget _buildContent(BuildContext context, QuillController? controller) {
    var quillEditor = QuillEditor(
      controller: controller!,
      scrollController: ScrollController(),
      scrollable: true,
      focusNode: _focusNode,
      autoFocus: true,
      readOnly: true,
      expands: false,
      showCursor: false,
      padding: EdgeInsets.zero,
        customStyles: DefaultStyles(
            link: TextStyle().copyWith(color: Colors.blue),
            paragraph: DefaultTextBlockStyle(
                const TextStyle().copyWith(
                  fontSize: 17,
                  color: Color(0xFF292929),
                  height: 1.3
                ),
                const Tuple2(0, 0),
                const Tuple2(0, 0),
                null)
        ),
      onLaunchUrl: (String? value) {
        try {
          _onTapHashTagOrAtMention(jsonDecode(value!)['title'], context,
              link: jsonDecode(value)['link']);
        } catch (e) {
          print('Exception on tap hash tag or atmention : $e');
        }
      },
    );
    if (kIsWeb) {
      quillEditor = QuillEditor(
          controller: controller,
          scrollController: ScrollController(),
          scrollable: true,
          focusNode: _focusNode,
          autoFocus: true,
          readOnly: !_edit,
          expands: false,
          padding: EdgeInsets.zero,
          embedBuilder: defaultEmbedBuilderWeb,
        onLaunchUrl: (String? value) {
          try {
            _onTapHashTagOrAtMention(jsonDecode(value!)['title'], context,
                link: jsonDecode(value)['link']);
          } catch (e) {
            print('Exception on tap hash tag or atmention : $e');
          }
        },);
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: quillEditor,
          ),
        ],
      ),
    );
  }

  void _onTapHashTagOrAtMention(String? value, BuildContext context,
      {String? link}) {
    if (value != null && value.isNotEmpty) {
      var isHashTag = value.startsWith('#');
      var isAtMention = value.startsWith('@');
      var word =
      value.replaceAll('#', '').replaceAll('@', '').replaceAll(' ', '_');
      if (isHashTag) {
        /// you can redirect to your screen here
      } else if(isAtMention){
        /// you can redirect to your screen here
      }

      if (link != null && link.isNotEmpty) {
        final urlRegExp =
        RegExp(r'(https?:\/\/|www\.)[\w-\.]+\.[\w-\.]+(\/([\S]+)?)?');
        var isUrl = urlRegExp.hasMatch(link);
        if (isUrl) {
          try {
            if (link.startsWith('http')) {
              _launchURL(link);
            } else {
              _launchURL('https://$link');
            }
          } catch (e) {
            print('Could not launch url : $e');
          }
        }
      }
    }
  }

  void _launchURL(String url) async {
    if (await urlLauncher.canLaunch(url)) {
      await urlLauncher.launch(
        url,
        universalLinksOnly: true,
      );
    } else {
      throw 'Can not launch';
    }
  }

  void _toggleEdit() {
    setState(() {
      _edit = !_edit;
    });
  }
}
