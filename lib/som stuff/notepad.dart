abstract class Animal {
  String kindofAnimal;
  int age;
  String name;

  String showData() =>
      "Animal`s name is: $name, it is a $kindofAnimal and it is $age years old. It is as old as $tohumanAge human years";
  double get tohumanAge => age * 6.5;
  set updatedAge(int val) => age = val;

//default constr
  Animal(this.kindofAnimal, this.age, this.name);
// named constr
  Animal.fromMap(Map<String, String> mymap) {
    this.kindofAnimal = mymap["kind of Animal"];
    this.name = mymap['name'];
    this.age = int.parse(mymap['age']);
  }

  // factory Animal.build(bool havePaws) {
  //   return havePaws
  //       ? Animal("horse", 7, "Sweety")
  //       : Animal("Goldfish", 1, "blub");
  // }

  void feed();
}

//inheritance
class Reptile extends Animal {
  int _length;

  Reptile(this._length, Map<String, String> mymap) : super.fromMap(mymap);

  @override
  void feed() {
    print('I fed with mice');
  }
}

class Unicorn with Hellhound implements Animal {
  String kindofAnimal;
  int age;
  String name;

  double get tohumanAge => age * 3.2;
  set updatedAge(int val) => age = val;

  Unicorn(this.kindofAnimal, this.age, this.name);

  String showData() =>
      'this is fucking $kindofAnimal, its $age years old (this is equal to $tohumanAge human years) and its name is: $name';

  void feed() {
    print('Im unicron');
  }
}

mixin Hellhound {
  bool isfromHell;
  void haunt() {
    print('haha gotcha');
  }
}

void main() {
  // var cat = Animal("cat", 3, "Snowflake");
  // var dog =
  //     Animal.fromMap({'kind of Animal': 'dog', 'name': "Good Boy", "age": "4"});
  // var animal = Animal.build(false);
  // cat.updatedAge = 5;
  // dog.updatedAge = 3;
  var unicorn = Unicorn("Unicorn", 178, 'Mudoc');
  print(unicorn.showData());
  unicorn.haunt();
}
