import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SocialPage extends StatefulWidget {
  const SocialPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SocialPageState createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    final querySnapshot = await _firestore.collection('posts').get();
    setState(() {
      posts = querySnapshot.docs
          // ignore: unnecessary_cast
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> _addNewPost(Map<String, dynamic> newPost) async {
    await _firestore.collection('posts').add(newPost);
    _fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      appBar: AppBar(
        title: const Text('Sosyal Akış'),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 254, 165, 110),
      ),
      body: posts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Dostunu paylaş sen de sosyalleş!',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CreatePostPage(onPostCreated: _addNewPost),
                        ),
                      );
                    },
                    // ignore: sort_child_properties_last
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_photo_alternate),
                        SizedBox(width: 8),
                        Text('Yeni Gönderi Oluştur'),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 254, 165, 110),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CreatePostPage(onPostCreated: _addNewPost),
                        ),
                      );
                    },
                    // ignore: sort_child_properties_last
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_photo_alternate),
                        SizedBox(width: 8),
                        Text('Yeni Gönderi Oluştur'),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 254, 165, 110),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 8),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return PostCard(
                        post: posts[index],
                        isEven: index % 2 == 0,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class CreatePostPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onPostCreated;

  const CreatePostPage({Key? key, required this.onPostCreated})
      : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  File? _image;
  final TextEditingController _captionController = TextEditingController();
  late String _userName;

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userName =
            user.displayName ?? 'Kullanıcı'; // Kullanıcının displayName'ini al
      });
    }
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _createPost() {
    if (_image != null && _captionController.text.isNotEmpty) {
      final newPost = {
        'userName': _userName, // Dinamik kullanıcı adı
        'userImage': 'assets/icons/profile.png',
        'postImage': _image!
            .path, // Bu path yerel dosyalar için; üretimde Firebase Storage kullanmayı düşünün
        'caption': _captionController.text,
        'likes': 0,
        'comments': [],
        'timestamp': DateTime.now().toString(),
      };
      widget.onPostCreated(newPost);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Gönderi'),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 254, 165, 110),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _createPost,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SafeArea(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.photo_library),
                            title: const Text('Galeriden Seç'),
                            onTap: () {
                              Navigator.pop(context);
                              _getImage(ImageSource.gallery);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo_camera),
                            title: const Text('Fotoğraf Çek'),
                            onTap: () {
                              Navigator.pop(context);
                              _getImage(ImageSource.camera);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _image == null
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                          SizedBox(height: 8),
                          Text('Fotoğraf Ekle',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(_image!, fit: BoxFit.cover),
                      ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _captionController,
              decoration: InputDecoration(
                hintText: 'Açıklama ekle...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 254, 165, 110), width: 2),
                ),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final Map<String, dynamic> post;
  final bool isEven;

  const PostCard({super.key, required this.post, required this.isEven});

  @override
  // ignore: library_private_types_in_public_api
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var orangeColor = const Color.fromARGB(255, 254, 165, 110);
    var cardColor = widget.isEven ? Colors.white : Color(0xFFFFDAB9);

    return Card(
      margin: const EdgeInsets.all(8),
      color: cardColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(widget.post['userImage']),
            ),
            title: Text(
              widget.post['userName'],
              style: TextStyle(fontWeight: FontWeight.bold, color: orangeColor),
            ),
          ),
          widget.post['postImage'].startsWith('/data/')
              ? Image.file(
                  File(widget.post['postImage']),
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  widget.post['postImage'],
                  fit: BoxFit.cover,
                ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.chat_bubble_outline),
                    const SizedBox(width: 8),
                    Text('${widget.post['likes']} beğeni'),
                  ],
                ),
                Text(
                  widget.post['caption'],
                  style: const TextStyle(color: Colors.black87),
                ),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.post['comments']
                      .map<Widget>(
                        (comment) => Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            '${comment['user']}: ${comment['comment']}',
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
