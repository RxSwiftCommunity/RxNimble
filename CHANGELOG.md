# Changelog

## Current Master

- Rename `Predicate` to `Matcher` to support Xcode 15.

## 6.3.0

- Updates to Nimble 13. See [#69](https://github.com/RxSwiftCommunity/RxNimble/issues/69).

## 6.2.0

- Support for new Nimble 12 dependency. See [#68](https://github.com/RxSwiftCommunity/RxNimble/pull/68).
- Remove Carthage dependency and build steps.
- Move to Swift Package Manager instead of xcodeproj.
- Reorganized file structure to SPM standard.

## 6.1.0

- Support for new Nimble 11 dependency. See [#67](https://github.com/RxSwiftCommunity/RxNimble/pull/67).

## 6.0.0

- Support for new Nimble 10 dependency. See [#66](https://github.com/RxSwiftCommunity/RxNimble/pull/66).

## 5.1.2

- Updates Nimble version (see [#65](https://github.com/RxSwiftCommunity/RxNimble/pull/65)).

## 5.1.1

- Updates minimum deployment targets to iOS 9 and macOS 10.12.

## 5.1.0

- Support [RxSwift 6](https://dev.to/freak4pc/what-s-new-in-rxswift-6-2nog)
- Adds a [carthage.sh](https://github.com/Carthage/Carthage/issues/3019#issuecomment-665136323) script to workaround a Carthage issue

## 5.0.0

- Support for new Nimble 9 dependency. See [#59](https://github.com/RxSwiftCommunity/RxNimble/pull/59).
- Increased minimum iOS deployment target to 9.0.

## 4.7.2

- More weak linking fixus. A Carthage/SPM-only release. 

## 4.7.1

- Weak links with XCTest.

## 4.7.0

- Support for Swift Package Manager
- Expectation+Blocking.swift imports `Foundation` to fix a compilation issue with SPM

## 4.6.0

- Support for RxSwift traits
- Adds support for passing a timeout to RxBlockings' operators

## 4.5.0

- Carthage support
- Support for Xcode 10.2, RxSwift 5.0 & Swift 5

## 4.4.1

- Adds support for Carthage (4.4.1 does not exist on CocoaPods).

## 4.4.0

- Added support to RxTest. Users may now choose between `RxTest` and `RxBlocking` (or both)

## 4.3.0

- Swift 4.2 support
- Xcode 10 support
- Update Demo supporting Xcode 10 with Swift 4.2

## 4.2.0

- Updated RxSwift requirement.
- Swift 4.1 support again. See [#30](https://github.com/RxSwiftCommunity/RxNimble/pull/31).

## 4.1.1

- Swift 4.1 support. See [#30](https://github.com/RxSwiftCommunity/RxNimble/issues/30).

## 4.1.0

- Deprecate old matcher functions
- Introduce following properties for `expect(observable)` to match `RxBlocking` operator
  - `first`
  - `last`
  - `array`

## 4.0.0

- Support for Swift 4.0, RxSwift 4.0 and RxBlocking 4.0. See [#27](https://github.com/RxSwiftCommunity/RxNimble/pull/27).

## 3.0.0

- Support for new Nimble 7 api. See [#21](https://github.com/RxSwiftCommunity/RxNimble/pull/21).

## 1.0.0

- Swift 3 support.

## 0.2.0

- Fixes build issues. See [#8](https://github.com/RxSwiftCommunity/RxNimble/pull/8).

## 0.1.0

- Initial release.
