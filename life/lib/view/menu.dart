import 'package:flutter/material.dart';
import 'package:life/view/configuracion.dart';
import 'package:life/view/formulario_cita.dart';
import 'package:life/view/formulario_medicamento.dart';
import 'package:life/view/formulario_tratamiento.dart';
import 'package:life/view/lista_citas_screen.dart';
import 'package:life/view/lista_medicamentos_screen.dart';
import 'package:life/view/lista_tratamientos_screen.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  void navegar(BuildContext context, Widget destino) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destino),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Life Reminder 🩵'),
        backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categorías',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  categoriaTile(
                    context,
                    titulo: 'Tratamientos',
                    icono: Icons.healing,
                    color: Colors.lightBlue,
                    onTap: () {
                      mostrarOpciones(
                        context,
                        const FormularioTratamiento(),
                        const ListaTratamientosScreen(),
                      );
                    },
                  ),
                  categoriaTile(
                    context,
                    titulo: 'Citas',
                    icono: Icons.calendar_month,
                    color: Colors.indigo,
                    onTap: () {
                      mostrarOpciones(
                        context,
                        const FormularioCita(),
                        const ListaCitasScreen(),
                      );
                    },
                  ),
                  categoriaTile(
                    context,
                    titulo: 'Medicamentos',
                    icono: Icons.medication,
                    color: Colors.blueGrey,
                    onTap: () {
                      mostrarOpciones(
                        context,
                        const FormularioMedicamento(),
                        const ListaMedicamentosScreen(),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 10,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ConfiguracionScreen()),
              );
              break;
            case 1:
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/perfil');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget categoriaTile(
    BuildContext context, {
    required String titulo,
    required IconData icono,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icono, size: 40, color: color),
            const SizedBox(height: 10),
            Text(
              titulo,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            )
          ],
        ),
      ),
    );
  }

  void mostrarOpciones(BuildContext context, Widget formulario, Widget lista) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              children: [
                Expanded(child: lista),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => navegar(context, formulario),
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar nuevo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
