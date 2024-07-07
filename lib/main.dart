import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const FormularioApp());
}

class FormularioApp extends StatelessWidget {
  const FormularioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Formulario Ander Endara",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCliController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _ubicacionController = TextEditingController();
  final _direccionController = TextEditingController();
  final _tecnicoController = TextEditingController();

  final TextEditingController _fechaInicioController = TextEditingController();
  final TextEditingController _fechaFinController = TextEditingController();
  DateTime? _fechaInicio;
  DateTime? _fechaFin;

  String? _visita;
  String? _estado;
  bool _isSubmitted = false;

  String? _validateDropdown(String? value) {
    if (value == null || value.isEmpty) {
      return "Seleccione una opción";
    }
    return null;
  }

  Future<void> _selectFechaInicio(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaInicio ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _fechaInicio) {
      setState(() {
        _fechaInicio = picked;
        _fechaInicioController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectFechaFin(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaFin ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _fechaFin) {
      setState(() {
        _fechaFin = picked;
        _fechaFinController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 134, 241),
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.search, color: Colors.black)),
          IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.more_vert, color: Colors.black)),
        ],
        title: Text(
          'Orden de trabajo'.toUpperCase(),
          style: GoogleFonts.dmSerifDisplay(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // LOGO
              Center(
                child: Image.network(
                  'https://www.shutterstock.com/shutterstock/photos/2255221165/display_1500/stock-vector-gear-and-wrench-mechanic-logo-design-vector-illustration-gear-and-wrench-mechanic-modern-logo-2255221165.jpg', // Asegúrate de tener el logo en esta ruta
                  height: 250,
                  width: 250,
                ),
              ),
              const SizedBox(height: 20),
              // ESTADO
              DropdownButtonFormField<String>(
                value: _estado,
                onChanged: (String? newValue) {
                  setState(() {
                    _estado = newValue;
                  });
                },
                items: <String>["En Curso", "Finalizado"]
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(242, 34, 34, 34)),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "Estado".toUpperCase(),
                  prefixIcon: const Icon(Icons.people),
                  prefixIconColor: const Color.fromARGB(242, 34, 34, 34),
                ),
                validator: _validateDropdown,
              ),
              const SizedBox(height: 20),
              // CLIENTE
              TextFormField(
                controller: _nombreCliController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(242, 34, 34, 34)),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "Nombre Cliente".toUpperCase(),
                  prefixIcon: const Icon(Icons.person),
                  prefixIconColor: const Color.fromARGB(242, 34, 34, 34),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese un nombre Válido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // TELÉFONO
              TextFormField(
                controller: _telefonoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(242, 34, 34, 34)),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "Teléfono".toUpperCase(),
                  prefixIcon: const Icon(Icons.phone),
                  prefixIconColor: const Color.fromARGB(242, 34, 34, 34),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese un teléfono Válido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // VISITA MOTIVO
              InputDecorator(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(242, 34, 34, 34)),
                      borderRadius: BorderRadius.circular(20)),
                  labelText: "Motivo de la Visita".toUpperCase(),
                  errorText: _isSubmitted && _visita == null
                      ? "Seleccione una opción"
                      : null,
                ),
                child: Column(
                  children: [
                    RadioListTile<String>(
                      title: const Text("Reparacion"),
                      value: "Reparacion",
                      groupValue: _visita,
                      onChanged: (String? value) {
                        setState(() {
                          _visita = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text("Mantenimiento Preventivo"),
                      value: "Preventivo",
                      groupValue: _visita,
                      onChanged: (String? value) {
                        setState(() {
                          _visita = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text("Mantenimiento Correctivo"),
                      value: "Correctivo",
                      groupValue: _visita,
                      onChanged: (String? value) {
                        setState(() {
                          _visita = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // DIRECCION
              TextFormField(
                controller: _direccionController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(242, 34, 34, 34)),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "Direccion".toUpperCase(),
                  prefixIcon: const Icon(Icons.phone),
                  prefixIconColor: const Color.fromARGB(242, 34, 34, 34),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese una direccion válida";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // UBICACION
              TextFormField(
                controller: _ubicacionController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(242, 34, 34, 34)),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "Ubicación".toUpperCase(),
                  prefixIcon: const Icon(Icons.phone),
                  prefixIconColor: const Color.fromARGB(242, 34, 34, 34),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese una ubicación válida";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
            // FECHA INICIO
              TextFormField(
                controller: _fechaInicioController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(242, 34, 34, 34)),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "Fecha Inicio".toUpperCase(),
                  prefixIcon: const Icon(Icons.calendar_today),
                  prefixIconColor: const Color.fromARGB(242, 34, 34, 34),
                ),
                readOnly: true,
                onTap: () => _selectFechaInicio(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Seleccione una fecha de inicio";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
            // FECHA FIN
              TextFormField(
                controller: _fechaFinController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(242, 34, 34, 34)),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "Fecha Fin".toUpperCase(),
                  prefixIcon: const Icon(Icons.calendar_today),
                  prefixIconColor: const Color.fromARGB(242, 34, 34, 34),
                ),
                readOnly: true,
                onTap: () => _selectFechaFin(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Seleccione una fecha de fin";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // TECNICO
              TextFormField(
                controller: _tecnicoController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(242, 34, 34, 34)),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "Tecnico Asignado".toUpperCase(),
                  prefixIcon: const Icon(Icons.person),
                  prefixIconColor: const Color.fromARGB(242, 34, 34, 34),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Ingrese un tecnico Válido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // BOTÓN ENVIAR
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isSubmitted = true;
                  });
                  if (_formKey.currentState!.validate() && _visita != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Cliente registrado exitosamente!!!")),
                    );
                  }
                },
                child: const Text("ENVIAR"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
