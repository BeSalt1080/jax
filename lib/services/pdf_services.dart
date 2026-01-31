import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:jax/services/file_services.dart';

Future<List<String>?> mergeProcess() async {
	final files = await getMultipleFiles();
	if (files == null || files.isEmpty) return null;

	final tempDir = await getTemporaryDirectory();
	final destDir = Directory(
			'${tempDir.path}${Platform.pathSeparator}jax_merge_${DateTime.now().millisecondsSinceEpoch}');
	await destDir.create(recursive: true);

	final List<String> savedPaths = [];
	for (final f in files) {
		final filename = f.path.split(Platform.pathSeparator).last;
		final destPath = '${destDir.path}${Platform.pathSeparator}$filename';
		final copied = await f.copy(destPath);
		savedPaths.add(copied.path);
	}

	return savedPaths;
}