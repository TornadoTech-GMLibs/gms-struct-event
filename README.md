Event is a package for your project, with a handy implementation of trees for GameMaker Studio 2 using constructors.
The package was originally written for the personal work of TornadoTech projects, but was uploaded to GitHub for the convenience of all developers.

To create an event, you must create a new instance of the ``Event`` constructor,
which will allow us to carry out further manipulations.
You can also create global events in global variables, which can be very useful.
```js
var event = new Event();
global.event = new Event();
```

To subscribe to an event, the ``connect`` method is used; it also returns the function being subscribed.
This allows you to not separate methods for subscription into separate variables,
but to declare and sign them in one place.

And to trigger an event, just call the ``invoke`` method. (We'll talk about his arguments later)
```js
var event = new Event();

var func1 = event.connect(function() {
	show_debug_message("Called func 1!");
});

var func2 = event.connect(function() {
	show_debug_message("Called func 2!");
});

var func3 = event.connect(function() {
	show_debug_message("Called func 3!");
});

event.connect(function() {
	show_debug_message("Anonymous function");
});

event.invoke();
// Result:
// Called func 1!
// Called func 2!
// Called func 3!
// Anonymous function
```

If we need to unsubscribe an event, we can use ``disconnect``, but for this we must save a reference to the method.
This means that it will not be possible to unsubscribe from specific anonymous methods,
which is why they are anonymous.
Also, ``disconnect`` returns the result of whether it was possible to unsubscribe from the event or not.

**It is also IMPORTANT for you to remember that if you signed a listener,
then you need to delete it so that memory leaks do not occur.
For example: if you subscribe to the global translation update event in an object,
then you need to unsubscribe in the object’s delete method.**
```js
var event = new Event();

var func1 = event.connect(function() {
	show_debug_message("Called func 1!");
});

var func2 = event.connect(function() {
	show_debug_message("Called func 2!");
});

var func3 = event.connect(function() {
	show_debug_message("Called func 3!");
});

event.connect(function() {
	show_debug_message("Anonymous function");
});

event.disconnect(func2);
event.disconnect(func3);
event.invoke();
// Result:
// Called func 1!
// Anonymous function
```

The ``disconnect_all`` method will allow you to unsubscribe from all listeners,
including anonymous listeners.
This functionality is very specific and sometimes I can't find a use for it myself,
but it can be extremely useful in specific situations.
```js
var event = new Event();

var func1 = event.connect(function() {
	show_debug_message("Called func 1!");
});

var func2 = event.connect(function() {
	show_debug_message("Called func 2!");
});

var func3 = event.connect(function() {
	show_debug_message("Called func 3!");
});

event.connect(function() {
	show_debug_message("Anonymous function");
});

event.disconnect_all();
event.invoke();
// Result:
```

As stated before, the ``invoke`` method accepts an unbounded number of arguments to be sent as listener arguments.
**It is IMPORTANT** to remember that the method signature must be the same as what you pass to ``invoke``,
otherwise you will get an error or your code will not work correctly. 

``invoke_for_array`` works identically to ``invoke``, but instead of a set of arguments,
it accepts 1 array, which will be expanded and substituted into the listener's arguments. 
```js
var event = new Event();

event.connect(function(a, b) {
	show_debug_message($"{a} + {b} = {a + b}");
});

event.connect(function(a, b) {
	show_debug_message($"{a} - {b} = {a - b}");
});

event.invoke(10, 20);
event.invoke(-23, 1);
event.invoke_for_array([1, 7]);

// Result:
// 10 + 20 = 30
// 10 - 20 = -10
// -23 + 1 = -22
// -23 - 1 = -24
// 1 + 7 = 8
// 1 - 7 = -6
```
