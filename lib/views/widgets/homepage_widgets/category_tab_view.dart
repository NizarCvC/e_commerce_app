import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/view_models/category_cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTabView extends StatelessWidget {
  const CategoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cubit = BlocProvider.of<CategoriesCubit>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        bloc: cubit,
        buildWhen: (previous, current) =>
            current is CategoriesLoading ||
            current is CategoriesLoaded ||
            current is CategoriesError,
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is CategoriesLoaded) {
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  height: size.height * 0.18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        state.categories[index].imageUrl,
                      ),
                      fit: .cover,
                    ),
                  ),
                ),
              ),
            );
          } else if (state is CategoriesError) {
            return Center(
              child: Text(
                state.message,
                style: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(color: Colors.red),
              ),
            );
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
