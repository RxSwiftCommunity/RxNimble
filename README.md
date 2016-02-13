[![Build Status](https://travis-ci.org/RxSwiftCommunity/RxNimble.svg?branch=master)](https://travis-ci.org/RxSwiftCommunity/RxNimble)

# RxNimble

Nimble extensions that making unit testing with RxSwift easier :tada:

## Why

RxSwift includes a really nifty little library called [RxBlocking](http://cocoapods.org/pods/RxBlocking) which provides convenience functions for peeking in on `Observable` instances. Check is a *blocking call*, hence the name. 

But writing code to check an `Observable`'s value is sooooo tedious:

```swift
let result = try! observabe.toBlocking().first()
expect(result) == 42
```

With `RxNimble`, we've added [Nimble](https://github.com/Quick/Nimble) matchers for `Observable`s, so the code above can be rewritten as:

```swift
expect(observable) == 42
```

Nice.

## Installation

Add to your podfile:

```rb
pod 'RxNimble'
```

And `pod install` and that's it!

## Known Issues

Very very _very_ rarely the Swift compiler gets confused about the different types and you need to use the original `RxBlocking` code.

## License

MIT ofc.

![Give yourself a high five](https://media.giphy.com/media/dRkMyTvCuAdY4/giphy.gif)
