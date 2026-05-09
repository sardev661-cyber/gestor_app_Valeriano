import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 24),
                _buildAvatar(),
                const SizedBox(height: 20),
                const Text(
                  'Admin Usuario',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Administrador del Sistema',
                  style: TextStyle(
                    color: const Color(0xFF9C84FF).withOpacity(0.8),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF11998E).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color(0xFF11998E).withOpacity(0.3)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified_rounded,
                          size: 14, color: Color(0xFF38EF7D)),
                      SizedBox(width: 6),
                      Text(
                        'Cuenta Verificada',
                        style: TextStyle(
                            color: Color(0xFF38EF7D),
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionLabel('INFORMACIÓN PERSONAL'),
                      const SizedBox(height: 12),
                      _buildInfoCard([
                        _InfoRow(
                          icon: Icons.person_rounded,
                          label: 'Nombre',
                          value: 'Admin',
                          color: const Color(0xFF6C63FF),
                        ),
                        _InfoRow(
                          icon: Icons.person_outline_rounded,
                          label: 'Apellido',
                          value: 'Usuario',
                          color: const Color(0xFF6C63FF),
                        ),
                        _InfoRow(
                          icon: Icons.cake_rounded,
                          label: 'Fecha de Nacimiento',
                          value: '01/01/1990',
                          color: const Color(0xFFE040FB),
                        ),
                        _InfoRow(
                          icon: Icons.wc_rounded,
                          label: 'Género',
                          value: 'Masculino',
                          color: const Color(0xFF6C63FF),
                        ),
                      ]),
                      const SizedBox(height: 20),
                      _sectionLabel('INFORMACIÓN DE CONTACTO'),
                      const SizedBox(height: 12),
                      _buildInfoCard([
                        _InfoRow(
                          icon: Icons.email_rounded,
                          label: 'Correo',
                          value: 'admin@gestorapp.com',
                          color: const Color(0xFF11998E),
                        ),
                        _InfoRow(
                          icon: Icons.phone_rounded,
                          label: 'Teléfono',
                          value: '+51 999 888 777',
                          color: const Color(0xFF11998E),
                        ),
                        _InfoRow(
                          icon: Icons.location_on_rounded,
                          label: 'Ciudad',
                          value: 'Lima, Perú',
                          color: const Color(0xFF11998E),
                        ),
                      ]),
                      const SizedBox(height: 20),
                      _sectionLabel('CUENTA'),
                      const SizedBox(height: 12),
                      _buildInfoCard([
                        _InfoRow(
                          icon: Icons.badge_rounded,
                          label: 'ID de Usuario',
                          value: '#USR-00001',
                          color: const Color(0xFFFF416C),
                        ),
                        _InfoRow(
                          icon: Icons.calendar_month_rounded,
                          label: 'Miembro desde',
                          value: 'Enero 2024',
                          color: const Color(0xFFFF416C),
                        ),
                        _InfoRow(
                          icon: Icons.security_rounded,
                          label: 'Rol',
                          value: 'Administrador',
                          color: const Color(0xFFFF416C),
                        ),
                      ]),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.edit_rounded, size: 18),
                          label: const Text(
                            'Editar Perfil',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF9C84FF),
                            side: const BorderSide(
                                color: Color(0xFF6C63FF), width: 1.5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
          const Text(
            'Mi Perfil',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF6C63FF), Color(0xFFE040FB)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C63FF).withOpacity(0.5),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const Icon(Icons.person_rounded,
              size: 56, color: Colors.white),
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF11998E),
            ),
            child: const Icon(Icons.check_rounded,
                color: Colors.white, size: 16),
          ),
        ),
      ],
    );
  }

  Widget _sectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFF9C84FF),
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildInfoCard(List<_InfoRow> rows) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        children: rows.asMap().entries.map((entry) {
          final i = entry.key;
          final row = entry.value;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 14),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: row.color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(row.icon, color: row.color, size: 18),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          row.label,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 11),
                        ),
                        Text(
                          row.value,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (i < rows.length - 1)
                Divider(
                    height: 1,
                    color: Colors.white.withOpacity(0.06),
                    indent: 18,
                    endIndent: 18),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _InfoRow {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });
}
