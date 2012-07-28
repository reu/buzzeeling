class Module
  @include: (mixin) ->
    this.prototype[name] = method for name, method of mixin

window.Module = Module
