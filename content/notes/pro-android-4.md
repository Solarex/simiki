---
title: "pro-android-4"
date: 2016-06-21 16:01
---

# Ch.27 Touch Screens

## Understanding MotionEvents

### The MotionEvent Object

**Receiving MotionEvent Objects**

+   When we want touch events to do something new with a particular View object, we can extend the class, override the ``onTouchEvent()`` method, and put our logic there. We can also implement the ``View.OnTouchListener`` interface and set up a callback handler on the ``View`` object. By setting up a callback handler with ``onTouch()``, ``MotionEvents`` will be delivered there first before they go to the View’s ``onTouchEvent()`` method. Only if the ``onTouch()`` method returned false would our View’s ``onTouchEvent()`` method get called.
+   772

