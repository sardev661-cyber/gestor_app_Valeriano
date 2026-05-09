import 'package:flutter/material.dart';
import '../models/person.dart';

class RegisterPersonScreen extends StatefulWidget {
  const RegisterPersonScreen({super.key});

  @override
  State<RegisterPersonScreen> createState() => _RegisterPersonScreenState();
}

class _RegisterPersonScreenState extends State<RegisterPersonScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _apellidoCtrl = TextEditingController();
  final _dniCtrl = TextEditingController();
  final _telefonoCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _direccionCtrl = TextEditingController();
  final _fechaNacCtrl = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _apellidoCtrl.dispose();
    _dniCtrl.dispose();
    _telefonoCtrl.dispose();
    _emailCtrl.dispose();
    _direccionCtrl.dispose();
    _fechaNacCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 600));

    AppData.addPersona(Person(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nombre: _nombreCtrl.text.trim(),
      apellido: _apellidoCtrl.text.trim(),
      dni: _dniCtrl.text.trim(),
      telefono: _telefonoCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      direccion: _direccionCtrl.text.trim(),
      fechaNacimiento: _fechaNacCtrl.text.trim(),
    ));

    if (mounted) {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Colors.white),
              SizedBox(width: 12),
              Text('Persona registrada exitosamente'),
            ],
          ),
          backgroundColor: const Color(0xFF11998E),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
        ),
      );
      _clearForm();
    }
  }

  void _clearForm() {
    _nombreCtrl.clear();
    _apellidoCtrl.clear();
    _dniCtrl.clear();
    _telefonoCtrl.clear();
    _emailCtrl.clear();
    _direccionCtrl.clear();
    _fechaNacCtrl.clear();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6C63FF),
              onPrimary: Colors.white,
              surface: Color(0xFF1E1B3A),
            ),
          ),
          child: child!,
        );
      },
    );
    if (date != null) {
      _fechaNacCtrl.text =
          '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    }
  }

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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _sectionTitle('Información Personal'),
                        const SizedBox(height: 16),
                        _buildFormCard([
                          _buildField(
                            controller: _nombreCtrl,
                            label: 'Nombre',
                            icon: Icons.person_outline_rounded,
                            validator: (v) =>
                                v!.isEmpty ? 'Campo requerido' : null,
                          ),
                          _buildField(
                            controller: _apellidoCtrl,
                            label: 'Apellido',
                            icon: Icons.person_outline_rounded,
                            validator: (v) =>
                                v!.isEmpty ? 'Campo requerido' : null,
                          ),
                          _buildField(
                            controller: _dniCtrl,
                            label: 'DNI',
                            icon: Icons.badge_outlined,
                            keyboardType: TextInputType.number,
                            validator: (v) {
                              if (v!.isEmpty) return 'Campo requerido';
                              if (v.length < 7) return 'DNI inválido';
                              return null;
                            },
                          ),
                          _buildDateField(),
                        ]),
                        const SizedBox(height: 20),
                        _sectionTitle('Información de Contacto'),
                        const SizedBox(height: 16),
                        _buildFormCard([
                          _buildField(
                            controller: _telefonoCtrl,
                            label: 'Teléfono',
                            icon: Icons.phone_outlined,
                            keyboardType: TextInputType.phone,
                            validator: (v) =>
                                v!.isEmpty ? 'Campo requerido' : null,
                          ),
                          _buildField(
                            controller: _emailCtrl,
                            label: 'Correo Electrónico',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) {
                              if (v!.isEmpty) return 'Campo requerido';
                              if (!v.contains('@')) return 'Email inválido';
                              return null;
                            },
                          ),
                          _buildField(
                            controller: _direccionCtrl,
                            label: 'Dirección',
                            icon: Icons.location_on_outlined,
                            validator: (v) =>
                                v!.isEmpty ? 'Campo requerido' : null,
                          ),
                        ]),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: _isSaving ? null : _save,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6C63FF),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              elevation: 0,
                            ),
                            child: _isSaving
                                ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 2.5),
                                  )
                                : const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.save_rounded, size: 20),
                                      SizedBox(width: 10),
                                      Text(
                                        'GUARDAR PERSONA',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1.2,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
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
                'Registrar Persona',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                'Completa todos los campos',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF9C84FF),
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildFormCard(List<Widget> fields) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        children: fields
            .expand((f) => [f, const SizedBox(height: 14)])
            .toList()
          ..removeLast(),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: _inputDeco(label, icon),
    );
  }

  Widget _buildDateField() {
    return TextFormField(
      controller: _fechaNacCtrl,
      readOnly: true,
      onTap: _pickDate,
      validator: (v) => v!.isEmpty ? 'Campo requerido' : null,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: _inputDeco('Fecha de Nacimiento', Icons.calendar_today_outlined),
    );
  }

  InputDecoration _inputDeco(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle:
          TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 13),
      prefixIcon: Icon(icon, color: const Color(0xFF6C63FF), size: 18),
      filled: true,
      fillColor: Colors.white.withOpacity(0.04),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Color(0xFF6C63FF), width: 1.5)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFF416C))),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFFF416C))),
      errorStyle: const TextStyle(color: Color(0xFFFF6E7F)),
    );
  }
}
