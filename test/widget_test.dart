import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:granthu_project/app/app.dart';
import 'package:granthu_project/data/repositories/settings_repository.dart';
import 'package:granthu_project/services/persistence/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Crop Doctor AI App smoke test and launches dashboard', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final storage = await LocalStorageService.init();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          localStorageServiceProvider.overrideWithValue(storage),
        ],
        child: const CropDoctorApp(),
      ),
    );

    await tester.pumpAndSettle();

    // Verify header elements
    expect(find.text('Good morning, Farmer'), findsOneWidget);
    expect(find.text("Let's keep your crops healthy today."), findsOneWidget);
    expect(find.text('Scan a Leaf'), findsOneWidget);
    expect(find.text('Supported Crops'), findsOneWidget);
    expect(find.text('Quick Actions'), findsOneWidget);

    // Verify bottom navigation destinations exist
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Diagnose'), findsWidgets); // quick action + bottom nav
    expect(find.text('History'), findsOneWidget);
    expect(find.text('Learn'), findsOneWidget);

    // Tap on Learn tab
    await tester.tap(find.text('Learn'));
    await tester.pumpAndSettle();

    expect(find.text('Farmer Learning Hub'), findsOneWidget);
    expect(find.text('How Crop Doctor AI Works'), findsOneWidget);
  });
}
