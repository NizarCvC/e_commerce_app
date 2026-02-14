import 'package:e_commerce_app/models/product_item_model.dart';
import 'package:e_commerce_app/utils/app_routes.dart';
import 'package:e_commerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:e_commerce_app/view_models/choose_location_cubit/choose_location_cubit.dart';
import 'package:e_commerce_app/view_models/payment_method_cubit/payment_method_cubit.dart';
import 'package:e_commerce_app/view_models/checkout_cubit/checkout_cubit.dart';
import 'package:e_commerce_app/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:e_commerce_app/views/pages/add_new_card_page.dart';
import 'package:e_commerce_app/views/pages/checkout_page.dart';
import 'package:e_commerce_app/views/pages/choose_location_page.dart';
import 'package:e_commerce_app/views/pages/create_account_page.dart';
import 'package:e_commerce_app/views/pages/custom_bottom_nav_bar.dart';
import 'package:e_commerce_app/views/pages/login_page.dart';
import 'package:e_commerce_app/views/pages/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CustomBottomNavBar(),
        );
      case AppRoutes.loginPageRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const LoginPage(),
          ),
        );
      case AppRoutes.createAccountPageRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const CreateAccountPage(),
          ),
        );
      case AppRoutes.productDetailsRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            final ProductItemModel productItem =
                settings.arguments as ProductItemModel;
            return BlocProvider(
              create: (context) {
                final cubit = ProductDetailsCubit();
                cubit.getProductDetails(productItem);
                return cubit;
              },
              child: ProductDetailsPage(),
            );
          },
        );
      case AppRoutes.checkoutPageRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = CheckoutCubit();
              cubit.getCartItems();
              return cubit;
            },
            child: CheckoutPage(),
          ),
        );
      case AppRoutes.addNewCardPageRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) => PaymentMethodCubit(),
            child: AddNewCardPage(),
          ),
        );
      case AppRoutes.chooseLocationPageRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = ChooseLocationCubit();
              cubit.fetchLocations();
              return cubit;
            },
            child: ChooseLocationPage(),
          ),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No route defined'))),
        );
    }
  }
}
