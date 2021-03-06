# My Elm examples

## Requirements

Elm 0.18

## Installation

1. `npm -g elm`
2. Checkout this repo and change to this directory
3. run `elm-reactor`
4. open `http://localhost:80000`

## Simple Examples

* [Counter.elm](Counter.elm). Counter example from the [Elm-Architecture guide](http://guide.elm-lang.org/architecture/user_input/buttons.html) with
reset button
* [SimpleList.elm](SimpleList.elm). A simple shopping list without interaction.
See [Gist](https://gist.github.com/HusseinMorsy/8c726fc58be40722a147488db9da33e3)
for step by step tutorial.
* [Grouped.elm](Grouped.elm). Shows how to group a List.
* [InterActiveList.elm](InterActiveList.elm). Extended version of SimpleList.elm,
where you can check items
* [MwstCalculator.elm](MwstCalculator.elm). Shows hows use input fields and how
to convert Strings to Float.
* [Currying.elm](Currying.elm). Shows how easy it is in ELm to use [currying](https://en.wikipedia.org/wiki/Currying)
* [Exercises](knowthen-elm-beginners) from the [Elm for beginners course from James Moore](http://courses.knowthen.com/courses/elm-for-beginners)


## Intermediate Examples

* [tests/Example.elm](tests/Example.elm). Shows how to write unit and fuzzy tests. See [elm-community/elm-test](http://package.elm-lang.org/packages/elm-community/elm-test/latest)
* [TimeoutForm.elm](TimeoutForm.elm). Shows usage of Subscriptions and Time.
* [Mult-todos](multi-todos). Shows how to handle multiple todos like [List of counters](http://guide.elm-lang.org/architecture/modularity/counter_list.html)
* [Homepage.elm](Homepage.elm). Simple SPA, that shows how to handle url navigation with [elm-lang/navigation](http://package.elm-lang.org/packages/elm-lang/navigation/latest)
* [RandomCoin.elm](RandomCoin.elm). Show how to generate random values. See also [Elm-Guide](https://guide.elm-lang.org/architecture/effects/random.html)
* [UuidGenerator.elm](UuidGenerator.elm). Generate UUID v.4. See[mgold/elm-random-pcg Package](http://package.elm-lang.org/packages/danyx23/elm-uuid/latest) [mgold/elm-random-pcg Package](http://package.elm-lang.org/packages/mgold/elm-random-pcg/latest/)

see also [Elm OpenWeatherMap example application](https://github.com/HusseinMorsy/elm-openweathermap-example)

## TODO


- [ ] [Building a Live-Validated Signup Form in Elm](http://tech.noredink.com/post/129641182738/building-a-live-validated-signup-form-in-elm)
- [ ] see webpack usage in [Sierpinski triangle in Elm](https://github.com/halfzebra/elm-sierpinski)
- [ ] JSON-API example
- [ ] Websocket example
- [x] Testing
- [ ] JavaScript interop
