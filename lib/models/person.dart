class Person {
  final String id;
  final String nombre;
  final String apellido;
  final String dni;
  final String telefono;
  final String email;
  final String direccion;
  final String fechaNacimiento;

  Person({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.dni,
    required this.telefono,
    required this.email,
    required this.direccion,
    required this.fechaNacimiento,
  });
}

// Global state (simple in-memory storage)
class AppData {
  static final List<Person> personas = [];

  static void addPersona(Person p) => personas.add(p);
}
