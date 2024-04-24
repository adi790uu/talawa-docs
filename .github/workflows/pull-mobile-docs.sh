#!/bin/bash

git clone --depth=1 --branch develop https://github.com/adi790uu/talawa.git

mkdir -p docs/talawa-mobile-docs

cd talawa

cd talawa_lint && flutter pub get && cd ..
flutter pub get
flutter analyze
dart analyze
flutter pub global activate dartdoc
flutter pub global run dartdoc . --output talawa-mobile-docs --format md --exclude=test/widget_tests/widgets/pinned_carousel_widget_test.dart, lib/widgets/pinned_carousel_widget.dart, lib/widgets/post_widget.dart, test/widget_tests/widgets/post_widget_test.dart
rm -rf talawa-mobile-docs/widgets_pinned_carousel_widget/CustomCarouselScrollerState/build.md
rm -rf talawa-mobile-docs/widgets_post_widget/PostContainerState/build.md

cd ..

cp -r talawa/talawa-mobile-docs/* docs/talawa-mobile-docs/

rm -rf talawa

git add .

git commit -m "Updated talawa mobile docs"

git pull --rebase origin develop
git push -u origin develop