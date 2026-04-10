# Changelog

All notable changes to this project are documented in this file.

The format loosely follows Keep a Changelog and is based on the Git commit history.

## [0.1.16] - 2026-04-10

### Changed
- Routine maintenance and stability updates.

## [0.1.15] - 2026-03-27

### Fixed
- Fixed renewal subscription query callback timing so the result block is invoked after the full transaction list has been processed.
- Cleaned up the renewal query implementation to avoid redundant initialization and improve callback consistency.

### Changed
- Updated release notes and podspec metadata for the 0.1.15 publish.

## [0.1.12] - 2026-03-27

### Added
- Added Flare subscription renewal info query support via public renewal APIs.
- Added public extension entry points for querying renewal status from transaction lists.

### Changed
- Updated release documentation to highlight renewal query capability as the primary update of this version.

## [0.1.11] - 2026-03-04

### Fixed
- Fixed transaction price and currency retrieval to align with StoreKit 2 runtime values.

### Added
- Added ownership type support in transaction metadata.
- Added signed date support in transaction metadata.
- Exposed `originalPurchaseDate` publicly in `StoreTransaction`.

### Changed
- Minor source cleanup and formatting updates.

## [0.1.10] - 2026-03-04

### Changed
- Bumped package version to 0.1.10.
- Updated project acknowledgment and attribution for Flare framework.
- Improved public documentation.

## [0.1.9] - 2026-03-04

### Added
- Added transaction environment string query support.

### Changed
- Updated documentation for environment-related APIs.
- Bumped podspec version to 0.1.9.

## [0.1.8] - 2026-02-28

### Added
- Added `appAccountToken` support in transaction data.

### Fixed
- Fixed pod validation warnings.

## [0.1.7] - 2026-02-28

### Added
- Added product type retrieval support.

## [0.1.6] - 2026-02-28

### Added
- Added subscription expiration query support.

## [0.1.5] - 2026-02-28

### Added
- Added comprehensive logging system.

### Changed
- Synced codebase with Flare 3.3.0.

## [0.1.4] - 2026-02-28

### Added
- Enhanced public API accessibility.

## [0.1.3] - 2026-02-28

### Added
- Added subscription ticket expiration time query support.

## [0.1.2] - 2026-02-28

### Changed
- Version bump and stabilization updates.

## [0.1.1] - 2026-02-28

### Changed
- Initial stable release updates.

## [0.1.0] - 2025-09-09

### Added
- Initial project scaffolding and first publish.

---

## Notes
- This changelog is generated from existing commit messages and release commits in the repository.
- For future releases, prefer Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`) to keep release notes clearer.
