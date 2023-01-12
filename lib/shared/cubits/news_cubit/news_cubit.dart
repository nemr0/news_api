import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news_api/shared/network/dio_helper.dart';

import '../../news_enum.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());
  static NewsCubit get(BuildContext context) =>
      BlocProvider.of<NewsCubit>(context);
  bool initiate(News news) {
    List? saved;
    switch (news) {
      case News.business:
        saved = GetStorage().read(News.business.name);
        if (saved == null) {
          return false;
        } else {
          _businessData = saved;
          emit(BusinessGetSuccessState(_businessData));
          return true;
        }
      case News.sports:
        saved = GetStorage().read(News.sports.name);
        if (saved == null) {
          return false;
        } else {
          _sportsData = saved;
          emit(BusinessGetSuccessState(_businessData));
          return true;
        }
      case News.science:
        saved = GetStorage().read(News.science.name);
        if (saved == null) {
          return false;
        } else {
          _scienceData = saved;
          emit(BusinessGetSuccessState(_businessData));
          return true;
        }
    }
  }

  List? _businessData = [];

  List? _sportsData = [];

  List? _scienceData = [];

  Future<void> getData(
      {bool isRefresh = false, News news = News.business}) async {
    if (isRefresh == false) {
      bool saveLoaded = initiate(news);
      if (saveLoaded) {
        await getData(isRefresh: true, news: news);
        return;
      }
      switch (news) {
        case News.business:
          if (_businessData!.isNotEmpty) {
            emit(BusinessGetSuccessState(_businessData));
            return;
          }
          emit(BusinessGetLoadingState());
          break;

        case News.sports:
          if (_sportsData!.isNotEmpty) {
            emit(SportsGetSuccessState(_sportsData));

            return;
          }
          emit(SportsGetLoadingState());
          break;

        case News.science:
          if (_scienceData!.isNotEmpty) {
            emit(ScienceGetSuccessState(_scienceData));

            return;
          }
          emit(ScienceGetLoadingState());

          break;
      }
    }
    await DioHelper()
        .getDataForCategory(category: news.name)
        .then((Response<Map> value) {
      List? articles = value.data!['articles'];
      switch (news) {
        case News.business:
          _businessData = articles;
          GetStorage().write(News.business.name, articles);
          emit(BusinessGetSuccessState(articles));
          break;

        case News.sports:
          _sportsData = articles;
          GetStorage().write(News.sports.name, articles);
          emit(SportsGetSuccessState(articles));
          break;

        case News.science:
          _scienceData = articles;
          GetStorage().write(News.science.name, articles);
          emit(ScienceGetSuccessState(articles));

          break;
      }
    }).onError((error, stackTrace) {
      switch (news) {
        case News.business:
          emit(BusinessGetFailedState(error.toString()));
          break;

        case News.sports:
          emit(SportsGetFailedState(error.toString()));
          break;

        case News.science:
          emit(ScienceGetFailedState(error.toString()));

          break;
      }
    });
  }
}
