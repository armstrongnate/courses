Courses
======

Courses is a simple app that displays a list of courses using the [Canvas API](https://api.instructure.com).

It uses [Moya](https://github.com/Moya/Moya) for modeling the endpoint(s), [Argo](https://github.com/thoughtbot/Argo)
for converting JSON to model objects, and [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa).

To use, set your access token at the top of `CanvasAPI.swift`.

```swift
let AccessToken = "<ACCESS_TOKEN_HERE>"
```
