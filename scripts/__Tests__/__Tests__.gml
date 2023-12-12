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

show_debug_message("\nTest 1");
event.invoke();

show_debug_message("\nTest 2");
event.disconnect(func2);
event.disconnect(func3);
event.invoke();

show_debug_message("\nTest 3");
event.disconnect_all();
event.invoke();

show_debug_message("\nTest 4");
event.connect(function(a, b) {
	show_debug_message($"{a} + {b} = {a + b}");
});

event.connect(function(a, b) {
	show_debug_message($"{a} - {b} = {a - b}");
});

event.invoke(10, 20);
event.invoke(-23, 1);
event.invoke_for_array([1, 7]);

show_debug_message("\nTest 5");
var foo = function() {};
function bar() {};

event.connect(foo);
event.connect(bar);

var i = 0;
repeat (array_length(event.listeners)) {
	show_debug_message(event.listeners[i]);
	i++;
}

event.disconnect_all();
