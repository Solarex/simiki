---
title: "50 Android Hacks"
date: 2016-06-17 10:46
---
##Working your way around layouts
###Centering views using weights

+ ``LinearLayout``,``layout_weight``,``weightSum``

###Using lazy loading and avoiding replication

+ use ``<include />`` tag to add another layout from another XML file

+ If you’ve ever found yourself making a view invisible and then making it visible afterward,you’ll want to use the ``ViewStub`` class.A ``ViewStub`` is an invisible, zero-sized ``View`` that can be used to lazily inflate layout resources at runtime. When a ``ViewStub`` is made visible, or when ``inflate()`` is invoked, the layout resource is inflated. The ``ViewStub`` then replaces itself in its parent with the inflated ``View`` or ``Views``.

```xml
<ViewStub
    android:id="@+id/map_stub"
    android:layout_width="fill_parent"
    android:layout_height="fill_parent"
    android:layout="@layout/map"
    android:inflatedId="@+id/map_view"/>
```

The ``inflatedId`` is the ID that the inflated view will have after we call ``inflate()`` or ``setVisibility()`` in the ``ViewStub`` class.If we want to get a reference to the view inflated, the ``inflate()`` method returns the view to avoid a second call to ``findViewById()``.

###Creating a custom ViewGroup

+ Drawing the layout is a two-pass process: a ``measure`` pass and a ``layout`` pass. The measuring pass is implemented in ``measure(int, int)`` and is a top-down traversal of the ``View`` tree. Each View pushes dimension specifications down the tree during the recursion. At the end of the measure pass, every ``View`` has stored its measurements. The second pass happens in ``layout(int, int, int, int)`` and is also top-down. During this pass each parent is responsible for positioning all of its children using the sizes computed in the measure pass.

+ To use our new ``CascadeLayout.LayoutParams`` class, we’ll need to override some additional methods in the CascadeLayout class. These are ``checkLayoutParams()``, ``generateDefaultLayoutParams()``, ``generateLayoutParams(AttributeSet attrs)``, and ``generateLayoutParams(ViewGroup.LayoutParams p)``. The code for these methods is almost always the same between ViewGroups.

###Preferences hacks

##Creating cool animations

###Snappy transitions with TextSwitcher and ImageSwitcher

+ Changing the contents of a view is a basic function of most applications, but it doesn’t have to be boring. If we use the default ``TextView``, you’ll notice there’s no eye candy when we swap its content. It’d be nice to have a way to apply different animations to content being swapped. So to make our transitions more visually appealing, Android provides two classes called ``TextSwitcher`` and ``ImageSwitcher``.

###Adding eye candy to your ViewGroup’s children

+ Android provides a class called LayoutAnimationController. This class is useful to animate a layout’s or a ViewGroup’s children. It’s important to mention that you won’t be able to provide different animations for each child, but the ``LayoutAnimationController`` can help you decide when the animation should apply to each child.

###Doing animations over the Canvas

###Slideshow using the Ken Burns effect

##View tips and tricks

###Avoiding date validations with an EditText for dates

###Formatting a TextView’s text

+ ``SpannableString``,``Html.fromHtml()``

###Adding text glowing effects

+ ``public void setShadowLayer (float radius, float dx, float dy, int color)``

###Rounded borders for backgrounds

+ A ``ShapeDrawable`` is a drawable object that creates primitive shapes such as rectangles.

```xml
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="rectangle">
	<solid android:color="#AAAAAA"/>
	<corners android:radius="15dp"/>
</shape>
```

###Getting the view’s width and height in the onCreate() method

+ Let’s first see why we get a 0 when we ask for the view’s sizes inside the Activity’s ``onCreate()`` method. When the ``onCreate()`` method is called, the content view is set inflating the layout XML with a ``LayoutInflater``. The process of inflation involves creating the views but not setting their sizes.The conclusion is the following: Views get their height and width when the layout happens. Layout happens after the ``onCreate()`` method is called, so we get a 0 when we call ``getHeight()`` or ``getWidth()`` from it.

+ To solve this issue, we can use the View’s ``post()`` method. This method receives a ``Runnable`` and adds it to the message queue. An interesting thing is that the ``Runnable`` will be executed on the user interface thread.

+ Activity/View#onWindowFocusChanged,这个函数的含义是：view已经初始化完毕了，宽/高已经准备好了，这个时候去获取宽高是可以成功获取的。但是需要注意的是onWindowFocusChanged函数会被调用多次，当Activity的窗口得到焦点和失去焦点时均会被调用一次，如果频繁地进行onResume和onPause，那么onWindowFocusChanged也会被频繁地调用。

+ view.post(runnable),通过post可以将一个runnable投递到消息队列的尾部，然后等待UI线程Looper调用此runnable的时候，view也已经初始化好了。

+ ViewTreeObserver,使用ViewTreeObserver的众多回调可以完成这个功能，比如使用OnGlobalLayoutListener这个接口，当view树的状态发生改变或者view树内部的view的可见性发生改变时，onGlobalLayout方法将被回调，因此这是获取view的宽高一个很好的时机。需要注意的是，伴随着view树的状态改变等，onGlobalLayout会被调用多次

详细介绍一下``ViewTreeObserver``这个类，这个类是用来注册当view tree全局状态改变时的回调监听器，这些全局事件包括很多，比如整个view tree视图的布局，视图绘制的开始，点击事件的改变等等。还有千万不要在应用程序中实例化``ViewTreeObserver``对象，因为该对象仅是由视图提供的。 

``ViewTreeObserver``类提供了几个相关函数用来添加view tree的相关监听器：

``public void addOnDrawListener (ViewTreeObserver.OnDrawListener listener)``,该函数为api 16版本中添加，作用是注册在该view tree将要绘制时候的回调监听器，注意该函数和相关的remove函数不能在监听器回调的onDraw()中调用。

``public void addOnGlobalFocusChangeListener (ViewTreeObserver.OnGlobalFocusChangeListener listener)``,该函数用来注册在view tree焦点改变时候的回调监听器。

``public void addOnGlobalLayoutListener (ViewTreeObserver.OnGlobalLayoutListener listener)``该函数用来注册在该view tree中view的全局布局属性改变或者可见性改变时候的回调监听器。

``public void addOnPreDrawListener (ViewTreeObserver.OnPreDrawListener listener)``该函数用来注册当view tree将要被绘制时候(view 的 onDraw 函数之前)的回调监听器。

``public void addOnScrollChangedListener (ViewTreeObserver.OnScrollChangedListener listener)``该函数用来注册当view tree滑动时候的回调监听器，比如用来监听ScrollView的滑动状态。

``public void addOnTouchModeChangeListener (ViewTreeObserver.OnTouchModeChangeListener listener)``该函数用来注册当view tree的touch mode改变时的回调监听器，回调函数``onTouchModeChanged (boolean isInTouchMode)``中的isInTouchMode为该view tree的touch mode状态。

``public void addOnWindowAttachListener (ViewTreeObserver.OnWindowAttachListener listener)``api 18添加，该函数用来注册当view tree被附加到一个window上时的回调监听器。

``public void addOnWindowFocusChangeListener (ViewTreeObserver.OnWindowFocusChangeListener listener)``api 18添加，该函数用来注册当window中该view tree焦点改变时候的回调监听器。

而且对应每一个add方法都会有一个remove方法用来删除相应监听器。

+ view.measure(int widthMeasureSpec, int heightMeasureSpec),通过手动对view进行measure来得到view的宽/高，这种情况比较复杂，这里要分情况处理，根据view的layoutparams来分：

match_parent: 直接放弃，无法measure出具体的宽/高。原因很简单，根据view的measure过程，构造此种MeasureSpec需要知道parentSize，即父容器的剩余空间，而这个时候我们无法知道parentSize的大小，所以理论上不可能测量处view的大小。

wrap_content: 

```java
int widthMeasureSpec = View.MeasureSpec.makeMeasureSpec((1<<30)-1, View.MeasureSpec.AT_MOST);
int heightMeasureSpec = View.MeasureSpec.makeMeasureSpec((1<<30)-1, View.MeasureSpec.AT_MOST);
v_view1.measure(widthMeasureSpec, heightMeasureSpec);
```

注意到(1<<30)-1，我们知道MeasureSpec的前2位为mode，后面30位为size，所以说我们使用最大size值去匹配该最大化模式，让view自己去计算需要的大小。

具体的数值(dp/px),这种模式下，只需要使用具体数值去measure即可，比如宽/高都是100px：

```java
int widthMeasureSpec = View.MeasureSpec.makeMeasureSpec(100, View.MeasureSpec.EXACTLY);
int heightMeasureSpec = View.MeasureSpec.makeMeasureSpec(100, View.MeasureSpec.EXACTLY);
v_view1.measure(widthMeasureSpec, heightMeasureSpec);
```

###VideoViews and orientation changes

###Removing the background to improve your Activity startup time

+ ``FrameLayout`` is created when we execute the ``setContentView()`` method, and the ``DecorView`` is the root of the tree. By default, the framework fills our window with a default background color and the ``DecorView`` is the view that holds the window’s background drawable. So if we have an opaque UI or a custom background, our device is wasting time drawing the default background color.If we’re sure that we’ll use opaque user interfaces in our activity, we can remove the default background to boost our startup time. To do this, we need to add a line to the theme mentioned previously, as shown next:

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
<style name="Theme.NoBackground" parent="android:Theme"> 
	<item name="android:windowNoTitle">true</item> 
	<item name="android:windowBackground">@null</item>
</style>
</resources>
```

Removing the window background is a simple trick to gain some speed. The rule is simple: if the UI of your application is drawing 100% of the window contents, you should always set ``windowBackground`` to ``null``. Remember that the theme can be set in an ``<application>`` or an ``<activity>`` tag.

###Toast’s position hack

+ ``Toast``,``public void setGravity(int gravity, int xOffset, int yOffset);``

###Creating a wizard form using a Gallery

##Tools

###Removing log statements before releasing

+ use ``Timber``

###Using the Hierarchy Viewer tool to remove unnecessary views

##Patterns

###The Model-View-Presenter pattern

+ The basic difference between MVP and MVC is that in MVP, the presenter contains the UI business logic for the view and communicates with it through an interface.

###BroadcastReceiver following Activity’s lifecycle

###Architecture pattern using Android libraries

+ Before Android library projects were released, sharing code between Android projects was hard or even impossible. You could use a JAR to share Java code, but you couldn’t share code that needed resources. Sharing an Activity or a custom view was impossi- ble because you can’t add resources to JARs and use them later in an Android applica- tion. Android library projects were created as a way to share Android code.

###The SyncAdapter pattern

+ https://www.youtube.com/watch?v=xHXn3Kg2IQE

##Working with lists and adapters

###Handling empty lists

+ ``ListView`` and other classes that extend ``AdapterView`` easily handle emptiness through a method called ``setEmptyView(View)``. When the ``AdapterView`` needs to draw, it’ll draw the empty view if its ``Adapter`` is ``null``, or the adapter’s ``isEmpty()`` method returns true.

+ You can also try using a ``ViewStub`` as an empty view. Using a ``ViewStub`` as an empty view will guarantee that the empty view isn’t inflated when it’s not needed.

###Creating fast adapters with a ViewHolder

+ The ``AdapterView`` is the abstract class for views that use an ``Adapter`` to fill themselves. A common subclass is the ``ListView``. Both classes work together in a simple way. When the ``AdapterView`` is shown, it calls the ``Adapter``’s ``getView()`` method to create and add the views as children. The ``Adapter`` will take care of creating the views in its ``getView()`` method. As you can imagine, instead of returning new views per row, Android offers a way to recycle them. Let’s first look at how this works and then how to take advantage of the recycling.

###Adding section headers to a ListView

###Communicating with an Adapter using an Activity and a delegate

###Taking advantage of ListView’s header

###Handling orientation changes inside a ViewPager

### ListView’s choiceMode

+   Apart from show- ing items in a scrollable list, it can also be used to pick stuff from that list.
+   Defines the choice behavior for the view. By default, lists do not have any choice behavior. By setting the ``choiceMode`` to ``singleChoice``, the list allows up to one item to be in a chosen state. By setting the ``choiceMode`` to ``multipleChoice``, the list allows any number of items to be chosen.
+   The issue is that we’re adding a focusable widget, the ``CheckBox``. The best way to solve this is to disallow the ``CheckBox`` to gain focus. And, because the ``ListView`` is the one that decides what should and shouldn’t be checked, we’ll also remove the ``CheckBox`` possi- bility of getting clicks. We do this by adding the following attributes to the XML:

```xml
android:clickable="false"
android:focusable="false"
android:focusableInTouchMode="false"
```



## Useful libraries

### Aspect-oriented programming in Android

+   Aspect-oriented programming is a programming paradigm that aims to increase modularity by allowing the separation of cross-cutting concerns. Here’s a basic idea of how all of this works: we specify our cross-cutting concerns in a separated module (aspect), and we place the code that we want to be executed (either before or after our cross-cutting concern) in the separate module or modules.
+   Inside Android, AOP can be implemented using a library called AspectJ. Since Android doesn’t support bytecode generation, we can’t use all the AspectJ features. One AspectJ feature that works in Android is called compile-time weaving. To under- stand how this works, you first need to understand when it happens. AspectJ will modify our code after it’s compiled to bytecode and before it’s converted to dex. There it’ll take care of adding the additional code to our cross-cutting concerns.To make AOP work, we’ll need to modify the build procedure.
+   Because we want to clean our Activity from logs, we’ll now create a log aspect. We have two possibili- ties for creating an aspect: the AspectJ language syntax and the @AspectJ annotation style. The big difference is that the language syntax should be easier to write aspects in, since it was purposefully designed for that, whereas the annotation style follows regular Java compilation. 
+   If you haven’t used AspectJ, here’s a small reference for understanding the code: A join point is a well-defined point in the program flow. A pointcut picks out certain join points and values at those points. A piece of advice is code that’s executed when a join point is reached.

### Empowering your application using Cocos2d-x

+   The surface is Z ordered so that it is behind the window holding its SurfaceView; the SurfaceView punches a hole in its window to allow its surface to be displayed. The view hierarchy will take care of correctly compositing with the Surface any siblings of the SurfaceView that would normally appear on top of it. This can be used to place overlays such as buttons on top of the Surface, though note however that it can have an impact on performance since a full alpha-blended composite will be performed each time the Surface changes.



## Interacting with other languages

### Running Objective-C in Android

### Using Scala inside Android

## Ready-to-use snippets

### Firing up multiple intents

+   Mixing intents

```java
Intent pickIntent = new Intent(Intent.ACTION_GET_CONTENT);
pickIntent.setType("image/*");

Intent takePhotoIntent;
takePhotoIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);

Intent chooserIntent = Intent.createChooser(pickIntent,getString(R.string.activity_main_pick_both));
chooserIntent.putExtra(Intent.EXTRA_INITIAL_INTENTS,new Intent[]{takePhotoIntent});

startActivityForResult(chooserIntent, PICK_OR_TAKE_PICTURE);
```

### Getting user information when receiving feedback

### Adding an MP3 to the media ContentProvider

+   Adding the MP3 using content values

```java
MediaUtils.saveRaw(this, R.raw.loop1, LOOP1_PATH);

ContentValues values = new ContentValues(5);
values.put(Media.ARTIST, "Android");
values.put(Media.ALBUM, "50AH");
values.put(Media.TITLE, "hack037");
values.put(Media.MIME_TYPE, "audio/mp3");
values.put(Media.DATA, LOOP1_PATH);

getContentResolver().insert(Media.EXTERNAL_CONTENT_URI, values);
```

+   Adding the MP3 using the media scanner

```java
MediaUtils.saveRaw(this, R.raw.loop2, LOOP2_PATH);

Uri uri = Uri.parse("file://" + LOOP2_PATH);
Intent i = new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE, uri);
sendBroadcast(i);
```

### Adding a refresh action to the action bar

### Getting dependencies from the market

### Last-in-first-out image loading

+   LIFOTask,We extend ``FutureTask``, a class accepted by the executor classes because it exposes a ``cancel`` method, much like the old implementation using ``AsyncTask``.

```java
public class LIFOTask extends FutureTask<Object>
  implements Comparable<LIFOTask> {
  private static long counter = 0;
  private final long priority;
  public LIFOTask(Runnable runnable) {
    super(runnable, new Object());
    priority = counter++;
}
  public long getPriority() {
    return priority;
}
  @Override
  public int compareTo(LIFOTask other) {
      return priority > other.getPriority() ? -1 : 1;
  }
}
```

+   LIFOThreadPoolProcessor

```java
public class LIFOThreadPoolProcessor {
  private BlockingQueue<Runnable> opsToRun =
  new PriorityBlockingQueue<Runnable>(64, new Comparator<Runnable>() {
    @Override
    public int compare(Runnable r0, Runnable r1) {
       if (r0 instanceof LIFOTask && r1 instanceof LIFOTask) {
          LIFOTask l0 = (LIFOTask)r0;
          LIFOTask l1 = (LIFOTask)r1;
          return l0.compareTo(l1);
		}
	return 0; 
    }
  });
  private ThreadPoolExecutor executor;
  public LIFOThreadPoolProcessor(int threadCount) {
    executor = new ThreadPoolExecutor(threadCount, threadCount, 0,
      TimeUnit.SECONDS, opsToRun);
  }
  public Future<?> submitTask(LIFOTask task) {
    return executor.submit(task);
  }
  public void clear() {
    executor.purge();
  } 
}
```



## Beyond database basics

### Building databases with ORMLite

+   Object-Relational Mapping
+   ER diagram:entity-relationship diagram
+   The two most common annotations we’ll use with ORMLite are ``DatabaseTable`` and ``DatabaseField``. These annotations will target classes and member variables respec- tively and will allow us to craft our resulting database tables.

### Creating custom functions in SQLite

+   android-database-sqlcipher

### Batching database operations

+   using batch operations

```java
public ContentProviderResult[] applyBatch(
            ArrayList<ContentProviderOperation> operations);
```

+   Applying batch using ``com.android.providers .calendar.SQLiteContentProvider``

## Avoiding fragmentation

### Handling lights-out mode

### Using new APIs in older devices

### Using new APIs in older devices

+   Using ``apply()`` instead of ``commit()``,Since Android version 9, the ``SharedPreferences.Editor`` has an ``apply()`` method to be used instead of ``commit()``.Unlike ``commit()``, which writes its preferences out to persistent storage synchronously, ``apply()`` commits its changes to the in-memory SharedPreferences immediately but starts an asynchronous commit to disk and you won’t be notified of any failures.

### Backward-compatible notifications

### Creating tabs with fragments

## Building tools

### Handling dependencies with Apache Maven

### Installing dependencies in a rooted device

### Using Jenkins to deal with device diversity



## references to read

+ http://android-developers.blogspot.com.ar/2009/03/android-layout-tricks-3-optimize-with.html
+ https://developer.android.com/guide/topics/resources/drawable-resource.html#Shape
+ Separation_of_Concerns Delegation_pattern
+ http://eclipse.org/aspectj/doc/released/faq.php
+ http://williamd1618.blogspot.com/2011/04/android-and-aspect-oriented-programming.html
+ http://www.eclipse.org/aspectj/doc/next/progguide/starting-aspectj.html
