import 'package:flutter/material.dart';
import 'kalkulator.dart';
import 'package:getwidget/getwidget.dart';

void main() => runApp(MyApp());

final ButtonStyle buttonPrimary = ElevatedButton.styleFrom(
  minimumSize: const Size(25, 50),
  backgroundColor: Colors.teal.shade900,
  elevation: 0,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(50),
    ),
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/counter': (context) => CounterPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class MyCheckboxListTile extends StatelessWidget {
  final Dept dept;
  final Function onRemove;
  final Function(bool?) onChanged;

  MyCheckboxListTile({
    required this.dept,
    required this.onChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.blue.withOpacity(0.5),
      title: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white54),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            ColoredGFCheckbox(
              value: dept.isDone,
              onChanged: onChanged,
              activeColor: Colors.blue,
              inactiveColor: Colors.blueAccent,
            ),
            SizedBox(width: 25.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    dept.name,
                    textAlign: TextAlign.justify,
                    style: dept.isDone
                        ? TextStyle(decoration: TextDecoration.lineThrough)
                        : TextStyle(color: Colors.brown[500]),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "Rp.${dept.jumlah}",
                    textAlign: TextAlign.right,
                    style: dept.isDone
                        ? TextStyle(decoration: TextDecoration.lineThrough)
                        : TextStyle(color: Colors.brown[500]),
                  ),
                  SizedBox(
                    height: 10.0,
                  )
                ],
              ),
            ),
            IconButton(
              icon:
                  Icon(Icons.remove_circle, color: Colors.brown[500], size: 45),
              onPressed: () {
                onRemove();
              },
            ),
          ],
        ),
      ),
      onTap: () {
        onChanged(!dept.isDone);
      },
    );
  }
}

class _HomePageState extends State<HomePage> {
  List<Dept> dept = [];

  void removeDept(int index) {
    setState(() {
      dept.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        title: Text(
          'Aplikasi Pencatat Hutang',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: dept.length,
              itemBuilder: (context, index) {
                return MyCheckboxListTile(
                  dept: dept[index],
                  onChanged: (bool? value) {
                    setState(() {
                      dept[index].isDone = value ?? false;
                    });
                  },
                  onRemove: () => removeDept(index),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.amberAccent,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(children: [
              const SizedBox(
                width: 50,
              ),
              ElevatedButton(
                style: buttonPrimary,
                onPressed: () {
                  _showAddDeptDialog(context);
                },
                child: const Text('Tambah Hutang'),
              ),
              const SizedBox(
                width: 35.0,
              ),
              ElevatedButton(
                style: buttonPrimary,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CalculatorPage()),
                  );
                },
                child: const Text('Buka Kalkulator'),
              ),
              const SizedBox(
                height: 120.0,
              ),
            ]),
          )
        ],
      ),
    );
  }

  Future<void> _showAddDeptDialog(BuildContext context) async {
    TextEditingController deptController = TextEditingController();
    TextEditingController jumlahController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Catat Hutang Baru'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: deptController,
                decoration: const InputDecoration(
                    hintText: 'Masukkan keterangan Hutang'),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: jumlahController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(hintText: 'Masukkan jumlah Hutang'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Tambah'),
              onPressed: () {
                setState(() {
                  dept.add(
                    Dept(
                      name: deptController.text,
                      jumlah: jumlahController.text,
                      isDone: false,
                    ),
                  );
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Dept {
  String name;
  String? jumlah;
  bool isDone;

  Dept({required this.name, this.jumlah, required this.isDone});
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Kalkulator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Ini adalah halaman kalkulator.'),
          ],
        ),
      ),
    );
  }
}

class ColoredGFCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;
  final Color activeColor;
  final Color inactiveColor;

  ColoredGFCheckbox({
    required this.value,
    required this.onChanged,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return GFCheckbox(
      type: GFCheckboxType.circle,
      activeBgColor: activeColor, // Warna latar belakang kotak kecil
      onChanged: onChanged,
      value: value,
      inactiveBorderColor: inactiveColor
          .withGreen(600), // Warna border kotak kecil saat tidak aktif
    );
  }
}
