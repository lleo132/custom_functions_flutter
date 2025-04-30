final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {

  //CONFIG OFF FLUTTERFLOW NOT COPY!!
  //WidgetsFlutterBinding.ensureInitialized();
  //GoRouter.optionURLReflectsImperativeAPIs = true;
  //usePathUrlStrategy();
  //final environmentValues = FFDevEnvironmentValues();
  ////await environmentValues.initialize();
  //await initFirebase();
  //await FFLocalizations.initialize();
  //final appState = FFAppState();
  //await appState.initializePersistedState();
  //await initializeFirebaseRemoteConfig();

  //ADD FOR CUSTOM ERROR IN RELEASE
  FlutterError.onError = (FlutterErrorDetails details) {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => ErrorPageWidget(details: details.toString()),
      ),
    );
  };

  //ADD CUSTOM ERROR IN DEBUG MODE
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return ErrorPageWidget(details: details.toString());
  };
//CAPTURE ERROR
  runZonedGuarded(() {
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => appState),
        ],
        child: MyApp(),
      ),
    );
  }, (error, stackTrace) {
    debugPrint('Caught error in runZonedGuarded: $error');
  });
}