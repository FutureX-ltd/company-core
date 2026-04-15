# company_core

`company_core` is the shared Flutter package for company-wide reusable UI and foundational building blocks across multiple apps. It centralizes common branding, layouts, and future shared primitives so product teams can ship consistently without duplicating code.

## Overview

This package currently provides:

- Shared branding configuration
- Reusable powered-by footer components
- A company app shell that pins branding at the bottom of screens
- A scalable package structure for future widgets, themes, dialogs, loaders, and utilities

---

## Developer Guide

This section is for internal developers who maintain and release the package.

### Package architecture

The package follows a modular internal structure so features can grow without turning the package into a flat collection of unrelated files.

```text
lib/
  company_core.dart
  src/
    branding/
    config/
    layout/
    widgets/
    theme/
    utils/
assets/
  logos/
```

#### Folder responsibilities

- `lib/company_core.dart`
  Public package entrypoint. Export only stable APIs that consumer apps should import.

- `lib/src/`
  Internal implementation area for package features. Files here are organized by responsibility and should stay modular.

- `lib/src/branding/`
  Branding-specific reusable widgets such as `BrandingFooter` and `PoweredByLogo`.

- `lib/src/config/`
  Shared configuration models and defaults used by the package, such as `BrandingConfig`.

- `lib/src/layout/`
  Reusable company-wide layout wrappers such as `CompanyAppShell`. Future shared screen shells should live here.

- `lib/src/widgets/`
  Shared general-purpose UI components that are not branding-specific, such as buttons, loaders, and dialogs.

- `lib/src/theme/`
  Shared theme primitives such as colors, typography, spacing, shapes, and future design tokens.

- `lib/src/utils/`
  Internal helpers, extensions, constants, formatters, and other cross-cutting utilities.

- `assets/`
  Package-owned assets bundled for consumer apps.

- `assets/logos/`
  Branding SVG assets, including theme-aware logo variants.

#### Architecture guidelines

- Keep public APIs minimal and export them only from `lib/company_core.dart`.
- Add new features inside the most relevant domain folder instead of expanding unrelated files.
- Prefer small focused widgets and configuration objects over monolithic classes.
- Preserve backward compatibility whenever possible because multiple apps may depend on this package at the same time.

### Development workflow

When updating the package, follow the same release process every time so consuming apps can reliably upgrade to a known version.

#### Standard workflow

1. Update the package source code.
2. Run formatting, analysis, and tests.
3. Update the version in `pubspec.yaml`.
4. Commit the changes.
5. Create a git tag for the release version.
6. Push `main`.
7. Push the tag.

#### Recommended local verification

```bash
dart format lib test
flutter analyze
flutter test
```

#### Release workflow commands

Replace the version and message as needed for the actual release:

```bash
git add .
git commit -m "improve ui"
git tag v0.0.34
git push origin main
git push origin v0.0.34
```

#### Release process details

- Update package code
  Implement the required changes in `lib/`, assets, and tests.

- Update version inside `pubspec.yaml`
  Bump the package version before tagging the release.

- Create commit
  Commit the complete release-ready state after tests pass.

- Create git tag
  Use a version tag that matches `pubspec.yaml`, for example `v0.0.34`.

- Push main
  Push the latest source code to the main branch.

- Push tag
  Push the release tag so consumer apps can depend on a stable immutable reference.

### Versioning rules

Use semantic versioning to keep package upgrades predictable across apps.

#### Patch version

Use patch releases for backward-compatible fixes and small refinements.

Example:

```text
0.0.34 -> bug fixes
```

Typical cases:

- UI alignment fixes
- internal cleanup
- safer defaults
- documentation corrections
- non-breaking asset or behavior fixes

#### Minor version

Use minor releases for backward-compatible new features.

Example:

```text
0.1.0 -> new features
```

Typical cases:

- adding a new reusable widget
- introducing a new layout wrapper
- exposing a new optional configuration model
- adding new public exports without breaking existing usage

#### Major version

Use major releases for breaking changes or major contract changes.

Example:

```text
1.0.0 -> stable production release
```

Typical cases:

- removing public APIs
- changing constructor requirements in a breaking way
- renaming exported classes
- changing default behavior in a way that can break existing apps

#### Semantic versioning summary

- Patch: safe fixes, no breaking changes
- Minor: new capabilities, backward compatible
- Major: breaking change or official stable milestone

### Release checklist

Before publishing a new version, confirm all of the following:

- [ ] Code reviewed
- [ ] Tested
- [ ] Version updated in `pubspec.yaml`
- [ ] Git tag created
- [ ] Pushed to GitHub

---

## Usage Guide

This section is for Flutter developers consuming the package inside apps.

### Installation

Add the package to your app `pubspec.yaml`.

#### Install from git branch

```yaml
dependencies:
  company_core:
    git:
      url: git@github.com:FutureX-ltd/company-core.git
      ref: main
```

Use `ref: main` during active development when you want the latest branch state.

#### Install from stable tag

```yaml
dependencies:
  company_core:
    git:
      url: git@github.com:FutureX-ltd/company-core.git
      ref: v0.0.34
```

Use a version tag in production apps when you need stable and repeatable builds.

After updating `pubspec.yaml`, run:

```bash
flutter pub get
```

### Usage examples

Import the package:

```dart
import 'package:company_core/company_core.dart';
```

#### Example 1: Branding footer

Use the default footer directly with zero configuration:

```dart
const BrandingFooter()
```

#### Example 2: Add to profile screen

Pin the shared footer at the bottom of a page layout:

```dart
Column(
  children: [
    Expanded(child: ProfileContent()),
    const BrandingFooter(),
  ],
)
```

#### Example 3: CompanyAppShell usage

Use the shared screen shell to avoid repeating layout code across screens:

```dart
CompanyAppShell(
  child: HomeView(),
  config: const BrandingConfig(),
)
```

Note: `CompanyAppShell` currently requires a `BrandingConfig` parameter. If the shell API is later aligned with package defaults, consumers can adopt the simpler constructor without changing screen structure.

### Best practices

- Use the footer in profile screens where company branding should be consistently visible.
- Use the footer in settings screens to keep common informational pages aligned across apps.
- Use the footer in login and onboarding flows when brand attribution is required.
- Use `CompanyAppShell` in common layouts to avoid repeating `Scaffold`, `SafeArea`, and footer composition logic.
- Prefer stable tagged versions in production apps instead of tracking `main`.
- Keep app-specific business logic outside this package; `company_core` should stay generic and reusable.

### Troubleshooting

#### Package not updating

If the app still uses old package code after a change:

- confirm the latest commit was pushed
- confirm the app points to the expected `ref`
- run `flutter pub get`

#### Need `flutter pub upgrade`

If the dependency is resolved but the app still does not pull the latest compatible state, run:

```bash
flutter pub upgrade
```

#### Git ref issue

If the app depends on a tag or commit that does not include your changes:

- update `ref` in the consumer app
- run `flutter pub get` again

Example:

```yaml
ref: v0.0.34
```

#### Cache issue

If Flutter keeps resolving a stale cached git dependency, clear and refresh the cache:

```bash
flutter pub cache clean
flutter pub get
```

If needed during local package development, switch the consumer app temporarily to a local `path:` dependency until the release tag is ready.

---

## Maintainer Notes

- Keep README examples aligned with the actual public API.
- When adding new exports, update both the Developer Guide and Usage Guide.
- Prefer documenting stable usage patterns over temporary experimental APIs.
