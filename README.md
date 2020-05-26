[![Build Status](https://travis-ci.org/RxSwiftCommunity/RxNimble.svg?branch=master)](https://travis-ci.org/RxSwiftCommunity/RxNimble)

# RxNimble

Nimble extensions that make unit testing with RxSwift easier :tada:

If you came here because you want to help out, please check out the [contribution guide](CONTRIBUTING.md)

## Why

RxSwift includes a really nifty little library called [RxBlocking](http://cocoapods.org/pods/RxBlocking) which provides convenience functions for peeking in on `Observable` instances. Check is a *blocking call*, hence the name. 

But writing code to check an `Observable`'s value is sooooo tedious:

```swift
let result = try! observable.toBlocking().first()
expect(result) == 42
```

With `RxNimble`, we've added [Nimble](https://github.com/Quick/Nimble) extension for `Observable`s, so the code above can be rewritten as:

```swift
expect(observable).first == 42
```

Nice.

It's also possible to pass a timeout to the blocking operators:

```swift
expect(observable).first(timeout: 3) == 42
```

This extension is also available for all Traits (e.g. `Single`, `Maybe`) and other types conforming to `ObservableConvertibleType`.

---

If on the other hand you'd rather use [RxTest](http://cocoapods.org/pods/RxTest) instead of `RxBlocking`, you can do it by specifying RxNimble's `RxTest` subspec. With _RxTest_ you can have more powerful tests, checking a stream as a whole instead of being limited to `first`, `last` and `array` (while the last 2 implicitly require the stream to have completed).

That means _RxTest_ allows you to verify the occurrence of multiple `next`, `error` and `completed` events at specific virtual times:

```swift
expect(subject).events(scheduler: scheduler, disposeBag: disposeBag)
    .to(equal([
        Recorded.next(5, "Hello"),
        Recorded.next(10, "World"),
        Recorded.completed(100)
       ]))
```

You may also verify specific error types:

```swift
expect(imageSubject).events(scheduler: scheduler, disposeBag: disposeBag)
    .to(equal([
        Recorded.error(5, ImageError.invalidImage)
       ]))
```

## Installation

### CocoaPods

Add to the tests target in your Podfile:

```rb
pod 'RxNimble' # same as RxNimble/RxBlocking
```

or

```rb
pod 'RxNimble/RxTest' # installs RxTest instead of RxBlocking
```

or even

```rb
pod 'RxNimble', subspecs: ['RxBlocking', 'RxTest'] # installs both dependencies
```

And `pod install` and that's it!

### Carthage

Add to your Cartfile.private:

```rb
github 'RxSwiftCommunity/RxNimble'
```

Run `carthage update --cache-builds` then drag & drop from the Carthage/Builds folder into your project either or both of:

- `RxNimbleRxBlocking.framework` and `RxBlocking.framework`
- `RxNimbleRxTest.framework` and `RxTest.framework`

## Migration 4.5.0 -> 5.0.0

Deprecated function `equalFirst` was removed in favor of a more natural Nimble matcher API style.

### RxNimble 4.5.0:
```swift
expect(o).to(equalFirst(...))
```
### RxNimble 5.0.0:
```swift
expect(o).first.to(equal(...))
```

## Known Issues

Very very _very_ rarely the Swift compiler gets confused about the different types and you need to use the original `RxBlocking` code.

## License

MIT ofc.

![Give yourself a high five](https://media.giphy.com/media/dRkMyTvCuAdY4/giphy.gif)
