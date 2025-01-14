import 'package:cheq_gallery_app/app/app.dart';
import 'package:cheq_gallery_app/permission/permission.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders storage permission checking page', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(StoragePermissionCheckingPage), findsOneWidget);
    });
  });
}
