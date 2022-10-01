abstract class NewsStates
{}
class NewsInitialsState extends NewsStates{}
class NewsTolBarSate extends NewsStates{}
class NewsGetBusinessState extends NewsStates{}
class NewsLoadingBusinessState extends NewsStates{}
class NewsErrorBusinessState extends NewsStates{
  late final String error;
  NewsErrorBusinessState( this.error);
}
class NewsGetSportsState extends NewsStates{
  List<dynamic> sports;

  NewsGetSportsState(this.sports);
}
class NewsLoadingSportsState extends NewsStates{}
class NewsErrorSportsState extends NewsStates{
  late final String error;
  NewsErrorSportsState( this.error);
}
class NewsGetScienceState extends NewsStates{}
class NewsLoadingScienceState extends NewsStates{}
class NewsErrorScienceState extends NewsStates{
  late final String error;
  NewsErrorScienceState( this.error);
}
class NewsGetEnterState extends NewsStates{}
class NewsLoadingEnterState extends NewsStates{}
class NewsErrorEnterState extends NewsStates{
  late final String error;
  NewsErrorEnterState( this.error);
}
class NewsGetGeneralState extends NewsStates{}
class NewsLoadingGeneralState extends NewsStates{}
class NewsErrorGeneralState extends NewsStates{
  late final String error;
  NewsErrorGeneralState( this.error);
}
class NewsGetSearchSuccessState extends NewsStates {}

class NewsGetSearchLoadingState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates
{
  final String error;
  NewsGetSearchErrorState(this.error);

}

class NewsGetHeadlinesState extends NewsStates{}
class NewsLoadingHeadlinesState extends NewsStates{}
class NewsErrorHeadlinesState extends NewsStates{
  late final String error;
  NewsErrorHeadlinesState( this.error);
}
class GetFlagState extends NewsStates{}