# `rubygems-deep_fetch`

Adds a `deep_fetch` command to rubygems, fetches a gem and its dependencies.

The `deep_fetch` command will not fetch the gems already installed.

This tiny gem command makes it easy to review the gem you are about to install __and its dependencies you miss locally__.

## Installation

Install using rubygems:

    $ gem install rubygems-deep_fetch

It requires Rubygems 2.0.0 or later becauses it is based on `Gem::DependencyResolver`.

## Usage

This is just like `gem fetch`:

```
$ gem deep_fetch GEMNAME [GEMNAME ...] [options]
```

See `gem help deep_fetch`.

## Example

Let's suppose I plan to install a fresh version of `sinatra`. This gem has 3 dependencies:

```
$ gem dependency sinatra --version 1.4.3 --remote
Gem sinatra-1.4.3
  rack (~> 1.4)
  rack-protection (~> 1.4)
  tilt (>= 1.3.4, ~> 1.3)
```

`tilt` is already installed on my machine, so I don't care about that one.

```
$ gem list tilt --local | grep tilt
tilt (1.4.1)
```

Now, I want to fetch `sinatra` and all the gems I miss locally.

```
$ gem deep_fetch sinatra --version 1.4.3
Downloaded sinatra-1.4.3
Downloaded rack-1.5.2
Downloaded rack-protection-1.5.0

$ ls *gem -1
rack-1.5.2.gem
rack-protection-1.5.0.gem
sinatra-1.4.3.gem
```

That's it. I can now unpack the gems using `gem unpack` and review them before safely running `gem install`.

## Bugs

When used with Rubygems 2.0.0, it will create empty directories like `cache` or `doc`. This bugs comes from Rubygems itself and it has been fixed in 2.1.0. See rubygems/rubygems#482

## Disclaimer

No test so far.

No "platform" option so far.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
