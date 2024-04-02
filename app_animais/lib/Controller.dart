import 'package:app_animais/Model.dart';

class AnimalController {
//atributo
  List<Animal> _listAnimal = [];

  //get
  List<Animal> get listarAnimais => _listAnimal;

//adicionar Animal
  void adicionarAnimal(String especie, String urlFoto, String urlAudio) {
    Animal novoAnimal = Animal(especie, urlAudio, urlFoto);
    _listAnimal.add(novoAnimal);
  }
}
