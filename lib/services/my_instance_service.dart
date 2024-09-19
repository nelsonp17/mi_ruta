import 'package:get/get.dart';

class MyInstanceService extends GetxService {
  final _clientID = ''.obs;
  set clientID(String id) => _clientID.value = id;

  final _choferID = ''.obs;
  set choferID(String id) => _choferID.value = id;

  // Genera un UUID versión 4 (aleatorio)
  /**String generateRandomUuid() {
    const uuid = Uuid();
    return uuid.v4();
  }

  void setServiceID({String? id}) {
    if (id != null) {
      serviceID.value = generateRandomUuid();
    } else {
      serviceID.value = id!;
    }
  }

  void start() {
    if (serviceID.value == '') {
      setServiceID();
    }
  }**/
}
