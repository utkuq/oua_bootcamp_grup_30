import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<NotificationCardData> _notifications = [
    NotificationCardData(
      title: 'PETPET',
      message: 'Dikkat!',
      details: 'Boncuk için kuduz aşısı tarihi: 01.01.2024',
      isEven: true, // Tek sıra
      initiallyExpanded: true, // İlk kart açık
    ),
    NotificationCardData(
      title: 'Evcil Hayvan Sağlığı',
      message: 'Yeni!',
      details: 'Kedinizin diş sağlığı kontrolü gerekli.',
      isEven: false, // Çift sıra
      initiallyExpanded: false,
    ),
    NotificationCardData(
      title: 'Randevu Hatırlatması',
      message: 'Önemli!',
      details: 'Köpeğinizin aşı zamanı: 15.01.2024',
      isEven: true, // Tek sıra
      initiallyExpanded: false,
    ),
    NotificationCardData(
      title: 'Acil Durum',
      message: 'Dikkat!',
      details: 'Kaplumbağanızın kış bakımı hakkında bilgi.',
      isEven: false, // Çift sıra
      initiallyExpanded: false,
    ),
    NotificationCardData(
      title: 'Yeni Ürün',
      message: 'Duyuru!',
      details: 'Kedi tüy temizleme fırçası satışta.',
      isEven: true, // Tek sıra
      initiallyExpanded: false,
    ),
    NotificationCardData(
      title: 'Kampanya',
      message: 'Fırsat!',
      details: 'Tüm köpek mamalarında %20 indirim.',
      isEven: false, // Çift sıra
      initiallyExpanded: false,
    ),
    NotificationCardData(
      title: 'Oyun Etkinliği',
      message: 'Yarışma!',
      details: 'Bu hafta sonu büyük köpek yarışı düzenleniyor.',
      isEven: true, // Tek sıra
      initiallyExpanded: false,
    ),
    NotificationCardData(
      title: 'Yaz Kampanyası',
      message: 'İndirim!',
      details: 'Yaz sezonuna özel tüm ürünlerde %15 indirim.',
      isEven: false, // Çift sıra
      initiallyExpanded: false,
    ),
    NotificationCardData(
      title: 'Yeni Makale',
      message: 'Bilgi!',
      details: 'Evcil hayvan sağlığı üzerine yeni bir makale yayınlandı.',
      isEven: true, // Tek sıra
      initiallyExpanded: false,
    ),
    NotificationCardData(
      title: 'Acil Yardım',
      message: 'Uyarı!',
      details: 'Evcil hayvanınızın acil durum numaraları güncellenmiştir.',
      isEven: false, // Çift sıra
      initiallyExpanded: false,
    ),
  ];

  void _clearAll() {
    setState(() {
      _notifications.clear();
    });
  }

  void _removeNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            ..._notifications.asMap().entries.map((entry) {
              int index = entry.key;
              NotificationCardData notification = entry.value;
              return Dismissible(
                key: Key(notification.title),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  _removeNotification(index);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${notification.title} silindi')),
                  );
                },
                child: NotificationCard(
                  title: notification.title,
                  message: notification.message,
                  details: notification.details,
                  isEven: notification.isEven,
                  initiallyExpanded: notification.initiallyExpanded,
                ),
              );
            }),
            if (_notifications.isNotEmpty) ...[
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _clearAll,
                  icon: const Icon(Icons.delete, color: Colors.white),
                  label: const Text('Tümünü Temizle'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        const Color.fromARGB(255, 254, 165, 110), // Yazı rengi
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Şimdilik bu kadar',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatefulWidget {
  final String title;
  final String message;
  final String details;
  final bool isEven;
  final bool initiallyExpanded;

  const NotificationCard({
    super.key,
    required this.title,
    required this.message,
    required this.details,
    required this.isEven,
    required this.initiallyExpanded,
  });

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    var orangeColor = const Color.fromARGB(255, 254, 165, 110);
    var cardColor = widget.isEven
        ? Colors.white
        : const Color(
            0xFFFFDAB9); // Çift sıralı bildirimler için daha açık turuncu renk

    return Card(
      elevation: 0,
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Yazı hizalamasını sola hizala
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.pets, color: orangeColor),
            ),
            title: Text(
              widget.title,
              style: TextStyle(
                color: orangeColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                _isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: Colors.grey,
              ),
              onPressed: _toggleExpanded,
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // İçerik hizalamasını sola hizala
                children: [
                  Text(
                    widget.message,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(widget.details),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class NotificationCardData {
  final String title;
  final String message;
  final String details;
  final bool isEven;
  final bool initiallyExpanded;

  NotificationCardData({
    required this.title,
    required this.message,
    required this.details,
    required this.isEven,
    required this.initiallyExpanded,
  });
}
