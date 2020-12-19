import 'package:flutter/material.dart';
import 'package:hellothere/models/cooltile_class.dart';

class CooltilesList extends ChangeNotifier {
  String _string;

  set string(val) {
    _string = val;
    notifyListeners(); //все Consumers с string будут перерисованы
  }

  String get string => _string;

  void toggleString() {
    var string2 = _string == null
        ? "HelloWorld"
        : _string == "HelloWorld"
            ? "fuk u"
            : 'HelloWorld';
    string = string2;
  }

  int _counter = 0;

  List<Cooltile> _primary;
  List<Cooltile> get primary => _primary;

  set primary(val) {
    _primary = val;
    notifyListeners(); //все Consumers с примари будут перерисованы
    print('primary setter toggled ');
  }

  void generateTiles() {
    List<Cooltile> nums5 = _primary ?? [];
    while (nums5.length < 40) {
      _counter++;
      nums5.add(
          Cooltile(title: randomString(5), subtitle: randNumb(), id: _counter));
    }

    primary = nums5;
  }

  void addTiles(GlobalKey<AnimatedListState> listKey) {
    List<Cooltile> nums5 = _primary ?? [];
    _counter++;
    var e =
        Cooltile(title: randomString(5), subtitle: randNumb(), id: _counter);
    nums5.insert(0, e);
    print("${_primary.length}");
    primary = nums5;
    listKey.currentState
        .insertItem(0, duration: const Duration(milliseconds: 500));
    // transformScale,transform.
  }

  void removeTile({@required Cooltile e}) {
    print('removeTile toggled');
    List<Cooltile> newPrimList =
        List<Cooltile>.from(_primary); // совершенно независимый объект
    List<Cooltile> newSecondList = List<Cooltile>.from(_secondary);
    newSecondList.add(e);
    newPrimList.remove(e);
    primary = newPrimList;
    secondary = newSecondList;
    //Singleton?
    print('removeTile executed');
  }

  bool sorta = true;
  void sortEmUp() {
    List<Cooltile> newPrimList = List<Cooltile>.from(_primary);
    sorta
        ? newPrimList.sort((Cooltile a, Cooltile b) =>
            a.title.toLowerCase().compareTo(b.title.toLowerCase()))
        : newPrimList.sort((Cooltile a, Cooltile b) => a.id.compareTo(b.id));
    sorta = !sorta;
    primary = newPrimList;
  }

  List<Cooltile> _secondary =
      []; // fab сортирует тайтлы по алфавиту, второе нажатие по айди.
  List<Cooltile> get secondary => _secondary;

  set secondary(val) {
    _secondary = val;
    notifyListeners();
  }

  void removeitBack({@required Cooltile ct}) {
    List<Cooltile> newSecondList = List<Cooltile>.from(_secondary);
    List<Cooltile> newPrimList = List<Cooltile>.from(_primary);
    newPrimList.add(ct);
    newSecondList.remove(ct);
    newPrimList.sort((Cooltile a, Cooltile b) => a.id.compareTo(b.id));
    primary = newPrimList;
    secondary = newSecondList;
  }

  void purge() {
    List<Cooltile> onDelete = List<Cooltile>.from(_secondary);
    onDelete.clear();
    secondary = onDelete;
  }

  bool grid = true;
  bool get atgrid => grid;
  set atgrid(val) {
    grid = val;
    notifyListeners();
  }

  void gridSwap() {
    atgrid = !atgrid;
    grid = atgrid;
  }

  bool encrease = false;
  bool get atencrease => encrease;
  set atencrease(val) {
    encrease = val;
    notifyListeners();
  }

  void enreaseSwap() {
    atencrease = !atencrease;
    encrease = atencrease;
  }
}
