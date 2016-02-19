# Podspec

Effortlessly create a [CocoaPods Podspec](https://guides.cocoapods.org/making/specs-and-specs-repo.html).

![](http://i.giphy.com/rsQu1BC0BF8wo.gif)

## Installation

```shell
$ git clone https://github.com/dkhamsing/podspec.git
$ cd podspec/
$ rake install
```

This project requires GitHub credentials in [.netrc](https://github.com/octokit/octokit.rb#using-a-netrc-file).

## Usage

```shell
$ podspec postmates/PMJSON
podspec 0.1.0
Generating Podspec for postmates/PMJSON...
Wrote PMJSON.podspec in 3s ✨
```

### Sample Output

`PMJSON.podspec`

```ruby
Pod::Spec.new do |s|
  s.name         = "PMJSON"
  s.version      = "0.9"
  s.summary      = "Pure Swift JSON encoding/decoding library"
  s.description  = "PMJSON provides a pure-Swift strongly-typed JSON encoder/decoder as well as a set of convenience methods for converting to/from Foundation objects and for decoding JSON structures."

  s.homepage     = "https://github.com/postmates/PMJSON"

  s.license      = "Apache License 2.0"

  s.author       = "Postmates Inc."

  s.source       = { :git => "https://github.com/postmates/PMJSON.git", :tag => "v0.9" }

  s.source_files = "Sources/*.{h,m,swift}"

  s.ios.deployment_target = "8.0"
  # s.osx.deployment_target = "10.9"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"
end
```

The Podspec created should get you started, make sure to consult the [Podspec syntax reference](https://guides.cocoapods.org/syntax/podspec.html).

### Validate the Podspec

```
$ pod spec lint PMJSON.podspec

-> PMJSON (0.9)

Analyzed 1 podspec.

PMJSON.podspec passed validation.
```

😎

## Contact

- [github.com/dkhamsing](https://github.com/dkhamsing)
- [twitter.com/dkhamsing](https://twitter.com/dkhamsing)

## License

This project is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
