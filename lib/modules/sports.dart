import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shared/componants/componants.dart';

import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class Sports extends StatelessWidget {
  const Sports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, NewsStates state) {
        var list=NewsCubit.get(context).sports;
        return conditionBuilder(list); },

    );
  }
}
