import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends GetxService {
  bool isAdmin = false;
  bool isChofer = false;
  final supabase = Supabase.instance.client;
  // ignore: avoid_init_to_null
  late Session? session = null;
  late String? email;
  late List<Map<String, dynamic>>? userTable;
  late List<Map<String, dynamic>>? userAdminTable;
  late List<Map<String, dynamic>>? choferTable;

  late bool isStart = false;

  bool isSession() {
    session = supabase.auth.currentSession;
    email = (session!=null) ? session!.user.email : null;
    print("session recuperada");
    return session != null;
  }

  Future<void> getTable() async {
    if (email != null) {
      // usuario normal
      final res = await supabase.from("users").select("*").eq("email", email!);
      if (res.isNotEmpty) {
        userTable = res;
        print("es usuario");
      }

      // usuario admin
      final resAdmin =
          await supabase.from("user_admin").select("*").eq("email", email!);
      if (resAdmin.isNotEmpty) {
        isAdmin = true;
        userAdminTable = resAdmin;
        print("es admin");
      } else {
        isAdmin = false;
      }

      // usuario chofer
      final resChofer =
          await supabase.from("chofers").select("*").eq("email", email!);
      if (resChofer.isNotEmpty) {
        isChofer = true;
        choferTable = resChofer;
        print("es chofer");
      } else {
        isChofer = false;
      }
    }
  }

  Future<void> start() async {
    print("Start");
    print(isStart);
    if (isStart && session != null) return;

    isSession();
    await getTable();
    isStart = true;
    print("iniciado por primera vez");
  }

  void setterInit() {
    print("setterInit");
    isAdmin = false;
    isChofer = false;
    session = null;
    email = null;
    userTable = null;
    userAdminTable = null;
    choferTable = null;
    isStart = false;

    print("Start");
    print(isStart);
  }

  Future<void> signout() async {
    setterInit();

    await supabase.auth.signOut();
  }
}
