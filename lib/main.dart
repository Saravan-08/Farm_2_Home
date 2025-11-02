void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // DEBUG: Check which Firebase project we're connected to
  print('🔥 Connected to Firebase project: ${DefaultFirebaseOptions.currentPlatform.projectId}');
  
  runApp(
    const ProviderScope(
      child: Farm2HomeApp(),
    ),
  );
}