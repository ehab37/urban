import 'package:flutter/material.dart';
import 'package:urban/constants/cart.dart';
import 'package:urban/constants/product.dart';
import 'package:urban/screens/sign/forgetPassword/enter_email.dart';
import 'package:urban/screens/user/User_profile.dart';
import 'package:urban/screens/admin/admin_Orders_screen.dart';
import 'package:urban/screens/equipments_screens/equipments_companies.dart';
import 'package:urban/screens/home_screen.dart';
import 'package:urban/screens/order_details_screen.dart';
import 'package:urban/screens/user/edit_Photo.dart';
import 'package:urban/screens/user/payment_screen.dart';
import 'package:urban/screens/user/settings_screen.dart';

import 'constants/MyUser.dart';
import 'constants/request_worker.dart';
import 'screens/admin/select_worker.dart';
import 'screens/user/User_Orders_screen.dart';
import 'screens/user/add_requestWorker.dart';
import 'screens/admin/add_worker.dart';
import 'screens/admin/admin_chat.dart';
import 'screens/admin/admin_messages-list.dart';
import 'screens/admin/admin_requests.dart';
import 'screens/admin/admin_workers.dart';
import 'screens/call_Center/carts.dart';
import 'screens/user/cart_Details.dart';
import 'screens/user/carts_screen.dart';

import 'screens/equipments_screens/add_equipment.dart';
import 'screens/equipments_screens/equipments_view.dart';
import 'screens/equipments_screens/kinds_screen.dart';
import 'screens/image_view_screen.dart';
import 'screens/material_screens/Company_Details_Screen.dart';
import 'screens/material_screens/add_product.dart';
import 'screens/material_screens/companies_screen.dart';
import 'screens/material_screens/kinds_screen.dart';
import 'screens/material_screens/product_details.dart';
import 'screens/material_screens/products_screen.dart';
import 'screens/material_screens/section_screen.dart';
import 'screens/sign/signing_screen.dart';
import 'screens/user/user_experts.dart';
import 'screens/user/user_workers.dart';

Map<String, WidgetBuilder> routes = {
  Home.route: (context) => const Home(),
  SigningScreen.route: (context) => const SigningScreen(),
  MaterialSectionsScreen.route: (context) =>
      const MaterialSectionsScreen(category: ''),
  MaterialCompaniesScreen.route: (context) =>
      const MaterialCompaniesScreen(category: '', section: '', kind: ''),
  MaterialKindsScreen.route: (context) =>
      const MaterialKindsScreen(category: '', section: ''),
  ProductsScreen.route: (context) =>
      const ProductsScreen(company: '', kind: '', section: '', category: ''),
  AddProductScreen.route: (context) =>
      const AddProductScreen(company: '', kind: '', section: '', category: ''),
  ProductDetails.route: (context) => ProductDetails(product: Product()),
  CartsScreen.route: (context) => const CartsScreen(),
  CallCenterCarts.route: (context) => const CallCenterCarts(),
  EquipmentsKindScreen.route: (context) => const EquipmentsKindScreen(),
  EquipmentsViewScreen.route: (context) =>
      const EquipmentsViewScreen(kind: '', company: ''),
  AddEquipmentScreen.route: (context) =>
      const AddEquipmentScreen(kind: '', company: ''),
  EquipmentsCompaniesScreen.route: (context) =>
      const EquipmentsCompaniesScreen(kind: ''),
  CartDetailsScreen.route: (context) => CartDetailsScreen(cart: Cart()),
  ShowPhoto.route: (context) => const ShowPhoto(url: ''),
  PaymentScreen.route: (context) => PaymentScreen(payment: '', cart: Cart()),
  UserOrdersScreen.route: (context) => const UserOrdersScreen(),
  AdminOrdersScreen.route: (context) => const AdminOrdersScreen(),
  OrderDetailsScreen.route: (context) => OrderDetailsScreen(cart: Cart()),
  CompanyDetailsScreen.route: (context) =>
      const CompanyDetailsScreen(company: ''),
  AdminWorkersScreen.route: (context) => const AdminWorkersScreen(),
  AddWorkerScreen.route: (context) => const AddWorkerScreen(),
  UserWorkersScreen.route: (context) => const UserWorkersScreen(),
  AddRequestWorker.route: (context) => const AddRequestWorker(),
  AdminRequestsScreen.route: (context) => const AdminRequestsScreen(),
  SelectWorkerScreen.route: (context) =>
      SelectWorkerScreen(requestWorker: RequestWorker()),
  UserExpertsScreen.route: (context) => const UserExpertsScreen(),
  AdminMessagesList.route: (context) => const AdminMessagesList(),
  UserProfileScreen.route: (context) => const UserProfileScreen(),
  SettingScreen.route: (context) => const SettingScreen(),
  EditUserPhoto.route: (context) => const EditUserPhoto(),
  EnterEmailScreen.route: (context) => const EnterEmailScreen(),
  AdminChatScreen.route: (context) => AdminChatScreen(
        myUser: MyUser(),
      ),
};
