# FastNoiseLite-D
Some messy static D bindings for [FastNoiseLite](https://github.com/Auburn/FastNoiseLite)'s C implementation.

Requires `gcc` to build the C file automatically, but you could use any compiler you like with some [small modifications](https://github.com/ichordev/FastNoiseLite-D/blob/main/dub.json#L14).

Use config `double` for doubles, config `float` for floats.

Feel free to submit a pull request if you feel like making any improvements, but currently these bindings are good enough for my own use. Please do not change the public API's symbols unless they are changed in new versions of FastNoiseLite.
