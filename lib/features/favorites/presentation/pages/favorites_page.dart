import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hotel_booking/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:hotel_booking/features/hotels/presentation/widgets/hotel_card.dart';
import 'package:hotel_booking/i18n/strings.g.dart';

@RoutePage()
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.favorites.title),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
              child: Icon(
                Icons.favorite_outline,
                size: 150,
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
            );
          }
          return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final hotel = state.items[index];
              return HotelCard(
                key: ObjectKey(hotel),
                hotel: hotel,
                isFavorite: true,
                onFavoriteChanged: (selected) {
                  final favoritesBloc = context.read<FavoritesBloc>();
                  if (selected) {
                    favoritesBloc.add(AddFavoriteEvent(hotel: hotel));
                  } else {
                    favoritesBloc.add(RemoveFavoriteEvent(hotel: hotel));
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
