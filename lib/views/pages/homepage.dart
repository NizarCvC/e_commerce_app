import 'package:e_commerce_app/utils/app_color.dart';
import 'package:e_commerce_app/view_models/home_cubit/home_cubit.dart';
import 'package:e_commerce_app/views/widgets/homepage_widgets/category_tab_view.dart';
import 'package:e_commerce_app/views/widgets/homepage_widgets/home_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'Category'),
            ],
            unselectedLabelColor: AppColors.grey,
          ),
          SizedBox(height: size.height * 0.02),
          Expanded(
            child: BlocProvider(
              create: (context) {
                final cubit = HomeCubit();
                cubit.getHomeData();
                return cubit;
              },
              child: TabBarView(
                controller: _tabController,
                children: [HomeTabView(), CategoryTabView()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
