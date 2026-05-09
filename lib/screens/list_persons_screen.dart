import 'package:flutter/material.dart';
import '../models/person.dart';

class ListPersonsScreen extends StatefulWidget {
  const ListPersonsScreen({super.key});

  @override
  State<ListPersonsScreen> createState() => _ListPersonsScreenState();
}

class _ListPersonsScreenState extends State<ListPersonsScreen> {
  String _search = '';

  List<Person> get _filtered => AppData.personas
      .where((p) =>
          p.nombre.toLowerCase().contains(_search.toLowerCase()) ||
          p.apellido.toLowerCase().contains(_search.toLowerCase()) ||
          p.dni.contains(_search))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F0C29), Color(0xFF302B63), Color(0xFF24243E)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 16),
              _buildCounter(),
              const SizedBox(height: 8),
              Expanded(child: _buildList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white, size: 20),
            style: IconButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lista de Personas',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                'Personas registradas en el sistema',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
        onChanged: (v) => setState(() => _search = v),
        style: const TextStyle(color: Colors.white, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Buscar por nombre, apellido o DNI...',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.35), fontSize: 13),
          prefixIcon: const Icon(Icons.search_rounded,
              color: Color(0xFF6C63FF), size: 20),
          filled: true,
          fillColor: Colors.white.withOpacity(0.06),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide:
                  const BorderSide(color: Color(0xFF6C63FF), width: 1.5)),
        ),
      ),
    );
  }

  Widget _buildCounter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF6C63FF).withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF6C63FF).withOpacity(0.3)),
            ),
            child: Text(
              '${_filtered.length} persona${_filtered.length != 1 ? 's' : ''}',
              style: const TextStyle(
                color: Color(0xFF9C84FF),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    if (_filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline_rounded,
                size: 64, color: Colors.white.withOpacity(0.2)),
            const SizedBox(height: 16),
            Text(
              _search.isEmpty
                  ? 'No hay personas registradas'
                  : 'Sin resultados para "$_search"',
              style: TextStyle(
                  color: Colors.white.withOpacity(0.4), fontSize: 15),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _filtered.length,
      itemBuilder: (context, index) {
        final p = _filtered[index];
        return _PersonCard(person: p, index: index);
      },
    );
  }
}

class _PersonCard extends StatelessWidget {
  final Person person;
  final int index;

  const _PersonCard({required this.person, required this.index});

  static const _avatarColors = [
    [Color(0xFF6C63FF), Color(0xFF9C84FF)],
    [Color(0xFF11998E), Color(0xFF38EF7D)],
    [Color(0xFFE040FB), Color(0xFFFF6E7F)],
    [Color(0xFFFF416C), Color(0xFFFF4B2B)],
  ];

  @override
  Widget build(BuildContext context) {
    final colors = _avatarColors[index % _avatarColors.length];
    final initials =
        '${person.nombre[0]}${person.apellido[0]}'.toUpperCase();

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: colors),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                initials,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${person.nombre} ${person.apellido}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 15),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.badge_outlined,
                        size: 13, color: Colors.white38),
                    const SizedBox(width: 4),
                    Text(
                      'DNI: ${person.dni}',
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.phone_outlined,
                        size: 13, color: Colors.white38),
                    const SizedBox(width: 4),
                    Text(
                      person.telefono,
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.chevron_right_rounded,
                color: Colors.white38, size: 20),
          ),
        ],
      ),
    );
  }
}
