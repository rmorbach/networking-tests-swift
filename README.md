# networking-tests-swift
Sample application on how to test networking in Swift.

Examples are provided in [`NetworkTestingTests`](NetworkTestingTests/) target.

## Using shared URLSession

Just register your custom `URLProtocol` subclass on application startup: 

```swift
URLProtocol.registerClass(URLProtocolMock.self)
```

## Using custom URLSession

Add your custom `URLProtocol` subclass to `protocolClasses` property of `URLSessionConfiguration`:

```swift
let configuration = URLSessionConfiguration.default
configuration.protocolClasses = [URLProtocolMock.self]

let session = URLSession(configuration: configuration)
```
