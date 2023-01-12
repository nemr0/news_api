import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api/shared/cubits/news_cubit/news_cubit.dart';
import 'package:news_api/shared/widgets/error_display.dart';

import '../../shared/widgets/news_body.dart';

///Business Screen
class BusinessScreen extends StatelessWidget {
  const BusinessScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Building upon NewsCubit changes
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        /// if data is available
        if (state is BusinessGetSuccessState) {
          final List? data = state.data;
          return NewsBody(data);
        }

        /// if getting data failed
        else if (state is BusinessGetFailedState) {
          return ErrorDisplay(error: state.error);
        }

        /// if data is loading
        else {
          return const CupertinoActivityIndicator();
        }
      },
    );
  }
}
