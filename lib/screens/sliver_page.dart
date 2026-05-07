import 'package:flutter/material.dart';

class SliverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Kita gunakan LayoutBuilder untuk mendapatkan tinggi total layar
    return Scaffold(
      backgroundColor: const Color(0xFF0061A8),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double screenHeight = constraints.maxHeight;
          final double statusBarHeight = MediaQuery.of(context).padding.top;

          // Estimasi tinggi area judul (SafeArea + Padding + Text Height)
          // Misal kita sisakan 80 pixel dari atas agar teks "Riwayat Kehadiran" tetap terlihat
          final double reservedTopSpace = statusBarHeight + 60;

          // Menghitung rasio maxChildSize agar berhenti tepat di bawah judul
          final double maxScrollSize = (screenHeight - reservedTopSpace) / screenHeight;

          return Stack(
            children: [
              // 1. Section Header (Tetap terlihat di belakang)
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Riwayat Kehadiran",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Grid statistik diletakkan di sini
                      _buildGridStatistik(),
                    ],
                  ),
                ),
              ),

              // 2. Draggable Sheet
              DraggableScrollableSheet(
                initialChildSize: 0.65,
                minChildSize: 0.65,
                maxChildSize: maxScrollSize, // Berhenti di bawah teks
                snap: true, // Opsional: agar sheet "menempel" ke posisi max/min
                builder: (context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                    child: CustomScrollView(
                      controller: scrollController, // WAJIB: Hubungkan controller di sini
                      slivers: [
                        // 1. Bagian Handle Bar (Bisa di-scroll hilang)
                        SliverToBoxAdapter(
                          child: _buildHandleBar(context),
                        ),

                        // 2. Header "Daftar Kehadiran" yang STICKY
                        SliverPersistentHeader(
                          pinned: true, // Membuatnya menempel di atas
                          delegate: _StickyHeaderDelegate(
                            child: Container(
                              // color: Colors.white, // Harus ada warna agar tidak transparan saat menumpuk
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: _buildSheetHeader(), // Isi Row (Text + Icon)
                            ),
                          ),
                        ),

                        // 3. Daftar Isi (Riwayat)
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) => _buildListItem(),
                            childCount: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  // --- WIDGET HELPER ---

  Widget _buildHandleBar(context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: MediaQuery.of(context).size.width * 0.4),
      height: 5,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildSheetHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Daftar Kehadiran",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Row(
            children: [
              _buildIconButton(Icons.filter_list),
              const SizedBox(width: 8),
              _buildIconButton(Icons.file_download_outlined),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 20, color: Colors.grey[600]),
    );
  }

  Widget _buildListItem() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
      ),
      child: const Text("Selasa, 3 Februari 2026"), // Mockup data
    );
  }

  Widget _buildGridStatistik() {
    // Implementasi GridView seperti sebelumnya
    return Container();
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _StickyHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 60.0; // Tinggi maksimal header Anda
  @override
  double get minExtent => 60.0; // Tinggi minimal saat menempel

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

class CustomBounceButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final TextStyle? textStyle;
  final EdgeInsets padding;

  const CustomBounceButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color = Colors.blue,
    this.textStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  }) : super(key: key);

  @override
  _CustomBounceButtonState createState() => _CustomBounceButtonState();
}

class _CustomBounceButtonState extends State<CustomBounceButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late double _scale;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1, // Intensitas bounce (0.1 = mengecil 10%)
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap(); // Menjalankan fungsi yang dipassing
      },
      onTapCancel: () => _controller.reverse(),
      child: Transform.scale(
        scale: _scale,
        child: Container(
          padding: widget.padding,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            widget.text,
            style: widget.textStyle ??
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}