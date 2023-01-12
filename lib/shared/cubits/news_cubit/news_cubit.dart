import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_api/shared/network/dio_helper.dart';

import '../../news_enum.dart';

part 'news_state.dart';

/// Cubit that handles all news pages states [BusinessScreen],[SportsScreen] and
/// [ScienceScreen]
class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());

  /// Get Instance of this cubit using context
  static NewsCubit get(BuildContext context) =>
      BlocProvider.of<NewsCubit>(context);

  /// allow showing saved data if exists
  bool isSaved(NewsType news) {
    /// instance of saved data
    List? saved;
    saved = GetStorage().read(news.name);
    if (saved == null) {
      return false;
    } else {
      switch (news) {
        case NewsType.business:
          _businessData = saved;
          emit(BusinessGetSuccessState(_businessData));
          break;
        case NewsType.sports:
          _sportsData = saved;
          emit(SportsGetSuccessState(_sportsData));
          break;
        case NewsType.science:
          _scienceData = saved;
          emit(ScienceGetSuccessState(_scienceData));
          break;
      }

      /// gets data in background
      getData(isRefresh: true, news: news);
      return true;
    }
  }

  /// The List which holds [BusinessScreen] data
  List? _businessData = [];

  /// The List which holds [SportsScreen] data
  List? _sportsData = [];

  /// The List which holds [ScienceScreen] data
  List? _scienceData = [];

  /// Gets data for any screen
  Future<void> getData(
      {

      ///checking if onRefresh event
      bool isRefresh = false,
      NewsType news = NewsType.business}) async {
    /// load saved in memory or in get_storage if it is not an onRefresh event
    if (isRefresh == false) {
      switch (news) {
        case NewsType.business:
          if (_businessData!.isNotEmpty) {
            emit(BusinessGetSuccessState(_businessData));
            return;
          }
          if (isSaved(news)) return;
          emit(BusinessGetLoadingState());
          break;

        case NewsType.sports:
          if (_sportsData!.isNotEmpty) {
            emit(SportsGetSuccessState(_sportsData));

            return;
          }
          if (isSaved(news)) return;

          emit(SportsGetLoadingState());
          break;

        case NewsType.science:
          if (_scienceData!.isNotEmpty) {
            emit(ScienceGetSuccessState(_scienceData));

            return;
          }
          if (isSaved(news)) return;

          emit(ScienceGetLoadingState());

          break;
      }
    }
    await DioHelper()
        .getDataForCategory(category: news.name)
        .then((Response<Map> value) {
      List? articles = value.data!['articles'];
      switch (news) {
        case NewsType.business:
          _businessData = articles;
          emit(BusinessGetSuccessState(articles));
          GetStorage().write(NewsType.business.name, articles);

          break;

        case NewsType.sports:
          _sportsData = articles;
          emit(SportsGetSuccessState(articles));
          GetStorage().write(NewsType.sports.name, articles);

          break;

        case NewsType.science:
          _scienceData = articles;
          emit(ScienceGetSuccessState(articles));
          GetStorage().write(NewsType.science.name, articles);

          break;
      }
    }).onError((error, stackTrace) {
      switch (news) {
        case NewsType.business:
          emit(BusinessGetFailedState(error.toString()));
          break;

        case NewsType.sports:
          emit(SportsGetFailedState(error.toString()));
          break;

        case NewsType.science:
          emit(ScienceGetFailedState(error.toString()));

          break;
      }
    });
  }
}
