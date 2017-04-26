---
title: "自定义View"
date: 2017-04-23 15:21
---
View的坐标系是相对于父控件而言的，``getLeft/getTop/getRight/getBottom``均是获取相对于父控件的距离。

``MotionEvent``中``getX/getY``是触摸点相对于其所在组件坐标系的坐标，``getRawX/getRawY``是触摸点相对于屏幕默认坐标系的坐标。

两条射线从圆心向圆周射出，形成一个夹角和夹角正对的一段弧。当这段弧长正好等于圆周长的360分之一时，两条射线的夹角的大小为1度.角度是60进制。角度是angle，the degrees of angle。

两条射线从圆心向圆周射出，形成一个夹角和夹角正对的一段弧。当这段弧长正好等于圆的半径时，两条射线的夹角大小为1弧度.弧度是10进制。弧度是radian。

``360角度 = 2π弧度 ==> 180角度 = π弧度``

在常见的数学坐标系中角度增大方向为逆时针，在默认的屏幕坐标系中角度增大方向为顺时针。

安卓支持的颜色模式：ARGB8888四通道高精度(32位)，ARGB4444四通道低精度(16位)，RGB565屏幕默认模式(16位)，Alpha8仅有透明通道(8位)。

Alpha透明度,0x00透明，0xff不透明。Red 0x00无色，0xff红色。Green 0x00无色，0xff绿色。Blue 0x00无色，0xff蓝色。当RGB全取最小值(0或0x000000)时颜色为黑色，全取最大值(255或0xffffff)时颜色为白色

``int color = getResources().getColor(R.color.mycolor);``

如果对View的宽高进行修改了，不要调用``super.onMeasure(widthMeasureSpec,heightMeasureSpec);``要调用``setMeasuredDimension(widthsize,heightsize);`` 这个函数。

``onSizeChanged``在视图大小发生改变时调用，可用来确定View大小。

Q: 在测量完View并使用setMeasuredDimension函数之后View的大小基本上已经确定了，那么为什么还要再次确定View的大小呢？

A: 这是因为View的大小不仅由View本身控制，而且受父控件的影响，所以我们在确定View大小的时候最好使用系统提供的onSizeChanged回调函数。

``onSizeChanged(int w, int h, int oldw, int oldh)``有四个参数，分别为 宽度，高度，上一次宽度，上一次高度。只需关注 宽度(w), 高度(h) 即可，这两个参数就是View最终的大小。

确定布局的函数是``onLayout``，它用于确定子View的位置，在自定义ViewGroup中会用到，他调用的是子View的``layout``函数。

``child.layout(l, t, r, b);``,``l``指View左侧距父View左侧的距离，对应函数``getLeft``,``t``指View顶部距父View顶部的距离，对应函数``getTop``,``r``指View右侧距父View左侧的距离，对应函数``getRight``,``b``指View底部距父View顶部的距离，对应函数``getBottom``。

所有的画布操作都只影响后续的绘制，对之前已经绘制过的内容没有影响。

translate是坐标系的移动，可以为图形绘制选择一个合适的坐标系。 请注意，位移是基于当前位置移动，而不是每次基于屏幕左上角的(0,0)点移动.

``Canvas.scale (float sx, float sy, float px, float py)``,缩放比例(sx,sy)取值范围详解,``[-∞, -1)``先根据缩放中心放大n倍，再根据中心轴进行翻转,``-1``根据缩放中心轴进行翻转,``(-1, 0)``先根据缩放中心缩小到n，再根据中心轴进行翻转,``0``不会显示，若sx为0，则宽度为0，不会显示，sy同理,``(0, 1)``根据缩放中心缩小到n,``1``没有变化,``(1, +∞)	``根据缩放中心放大n倍.

``Canvas.rotate (float degrees, float px, float py)``

``Canvas.skew (float sx, float sy)``错切是特殊类型的线性变换,float sx:将画布在x方向上倾斜相应的角度，sx倾斜角度的tan值，float sy:将画布在y轴方向上倾斜相应的角度，sy为倾斜角度的tan值.变换后:``X = x + sx * y``,``Y = sy * x + y``.

画布的操作是不可逆的，所以存在快照与回滚。

绘制图片有两种方法，drawPicture(矢量图) 和 drawBitmap(位图).可以把Picture看作是一个录制Canvas操作的录像机。

想要将Picture中的内容显示出来就需要手动调用播放(绘制)，将Picture中的内容绘制出来可以有以下几种方法：使用Picture提供的draw方法绘制,使用Canvas提供的drawPicture方法绘制。,将Picture包装成为PictureDrawable，使用PictureDrawable的draw方法绘制。

获取一个Bitmap:通过Bitmap创建,复制一个已有的Bitmap(新Bitmap状态和原有的一致) 或者 创建一个空白的Bitmap(内容可改变);通过BitmapDrawable获取,从资源文件 内存卡 网络等地方获取一张图片并转换为内容不可变的Bitmap;通过BitmapFactory获取,从资源文件 内存卡 网络等地方获取一张图片并转换为内容不可变的Bitmap.

``Bitmap bitmap = BitmapFactory.decodeResource(mContext.getResources(),R.raw.bitmap);``

``
Bitmap bitmap=null;
try {
    InputStream is = mContext.getAssets().open("bitmap.png");
    bitmap = BitmapFactory.decodeStream(is);
    is.close();
} catch (IOException e) {
    e.printStackTrace();
}
``

``Bitmap bitmap = BitmapFactory.decodeFile("/sdcard/bitmap.png");``

``
// 此处省略了获取网络输入流的代码
Bitmap bitmap = BitmapFactory.decodeStream(is);
is.close();
``

``Path.Direction``,``CW	clockwise	顺时针``,``CCW	counter-clockwise	逆时针``

``ACTION_CANCEL``的触发条件是事件被上层拦截,当事件被上层 View 拦截的时候，ChildView 是收不到任何事件的，ChildView 收不到任何事件，自然也不会收到 ``ACTION_CANCEL``了，所以说这个 ``ACTION_CANCEL`` 的正确触发条件并不是这样,事实上，只有上层 View 回收事件处理权的时候，ChildView 才会收到一个 ``ACTION_CANCEL`` 事件。例如：上层 View 是一个 RecyclerView，它收到了一个 ``ACTION_DOWN`` 事件，由于这个可能是点击事件，所以它先传递给对应 ItemView，询问 ItemView 是否需要这个事件，然而接下来又传递过来了一个 ``ACTION_MOVE`` 事件，且移动的方向和 RecyclerView 的可滑动方向一致，所以 RecyclerView 判断这个事件是滚动事件，于是要收回事件处理权，这时候对应的 ItemView 会收到一个 ``ACTION_CANCEL`` ，并且不会再收到后续事件。

正常情况下，如果初始点击位置在该视图区域之外，该视图根本不可能会收到事件，然而，万事万物都不是绝对的，肯定还有一些特殊情况，你可曾还记得点击 Dialog 区域外关闭吗？Dialog 就是一个特殊的视图(没有占满屏幕大小的窗口)，能够接收到视图区域外的事件(虽然在通常情况下你根本用不到这个事件)，除了 Dialog 之外，你最可能看到这个事件的场景是悬浮窗，当然啦，想要接收到视图之外的事件需要一些特殊的设置。设置视图的 WindowManager 布局参数的 flags为``FLAG_WATCH_OUTSIDE_TOUCH``，这样点击事件发生在这个视图之外时，该视图就可以接收到一个 ``ACTION_OUTSIDE ``事件。

多个手指同时按在屏幕上，会产生很多的事件，为了区分这些事件，工程师们用了一个很简单的办法－－编号，当手指第一次按下时产生一个唯一的号码，手指抬起或者事件被拦截就回收编号，就这么简单。第一次按下的手指特殊处理作为主指针，之后按下的手指作为辅助指针

``ACTION_DOWN``	第一个 手指 初次接触到屏幕 时触发。
``ACTION_MOVE``	手指 在屏幕上滑动 时触发，会多次触发。
``ACTION_UP``	最后一个 手指 离开屏幕 时触发。
``ACTION_POINTER_DOWN``	有非主要的手指按下(即按下之前已经有手指在屏幕上)。
``ACTION_POINTER_UP``	有非主要的手指抬起(即抬起之后仍然有手指在屏幕上)。

``getActionMasked()``	与 ``getAction()`` 类似，多点触控必须使用这个方法获取事件类型。``getActionIndex()``	获取该事件是哪个指针(手指)产生的。

``getPointerCount()``	获取在屏幕上手指的个数。
``getPointerId(int pointerIndex)``	获取一个指针(手指)的唯一标识符ID，在手指按下和抬起之间ID始终不变。
``findPointerIndex(int pointerId)``	通过PointerId获取到当前状态下PointIndex，之后通过PointIndex获取其他内容。
``getX(int pointerIndex)``	获取某一个指针(手指)的X坐标
``getY(int pointerIndex)``	获取某一个指针(手指)的Y坐标

int类型共32位(0x00000000)，他们用最低8位(0x000000ff)表示事件类型，再往前的8位(0x0000ff00)表示事件编号，以手指按下为例讲解数值是如何合成的:

ACTION_DOWN 的默认数值为 (0x00000000)
ACTION_POINTER_DOWN 的默认数值为 (0x00000005)

手指按下	触发事件(数值)
第1个手指按下	ACTION_DOWN (0x00000000)
第2个手指按下	ACTION_POINTER_DOWN (0x00000105)
第3个手指按下	ACTION_POINTER_DOWN (0x00000205)
第4个手指按下	ACTION_POINTER_DOWN (0x00000305)

多点触控时必须使用 getActionMasked() 来获取事件类型。单点触控时由于事件数值不变，使用 getAction() 和 getActionMasked() 两个方法都可以。使用 ``getActionIndex()`` 可以获取到这个index数值。不过请注意，``getActionIndex()`` 只在 down 和 up 时有效，move 时是无效的。

actionIndex，可以使用 getActionIndex() 获得，但通过 actionIndex 字面意思知道，这个只表示事件的序号，而且根据其说明文档解释，这个 ActionIndex 只有在手指按下(down)和抬起(up)时是有用的，在移动(move)时是没有用的，事件追踪非常重要的一环就是移动(move)，然而它却没卵用，这也太不实在了.PointId 在手指按下时产生，手指抬起或者事件被取消后消失，是一个事件流程中唯一不变的标识，可以在手指按下时 通过 getPointerId(int pointerIndex) 获得。 (参数中的 pointerIndex 就是 actionIndex).

由于我们的设备非常灵敏，手指稍微移动一下就会产生一个移动事件，所以移动事件会产生的特别频繁，为了提高效率，系统会将近期的多个移动事件(move)按照事件发生的顺序进行排序打包放在同一个 MotionEvent 中，与之对应的产生了以下方法：

getHistorySize()	获取历史事件集合大小
getHistoricalX(int pos)	获取第pos个历史事件x坐标(pos < getHistorySize())
getHistoricalY(int pos)	获取第pos个历史事件y坐标(pos < getHistorySize())
getHistoricalX (int pin, int pos)	获取第pin个手指的第pos个历史事件x坐标(pin < getPointerCount(), pos < getHistorySize() )
getHistoricalY (int pin, int pos)	获取第pin个手指的第pos个历史事件y坐标(pin < getPointerCount(), pos < getHistorySize() )

历史数据只有 ACTION_MOVE 事件。
历史数据单点触控和多点触控均可以用。

getDownTime()	获取手指按下时的时间。
getEventTime()	获取当前事件发生的时间。
getHistoricalEventTime(int pos)	获取历史事件发生的时间。
pos 表示历史数据中的第几个数据。( pos < getHistorySize() )
返回值类型为 long，单位是毫秒。

MotionEvent支持获取某些输入设备(手指或触控笔)的与屏幕的接触面积和压力大小，主要有以下方法：

getSize ()	获取第1个手指与屏幕接触面积的大小
getSize (int pin)	获取第pin个手指与屏幕接触面积的大小
getHistoricalSize (int pos)	获取历史数据中第1个手指在第pos次事件中的接触面积
getHistoricalSize (int pin, int pos)	获取历史数据中第pin个手指在第pos次事件中的接触面积
getPressure ()	获取第一个手指的压力大小
getPressure (int pin)	获取第pin个手指的压力大小
getHistoricalPressure (int pos)	获取历史数据中第1个手指在第pos次事件中的压力大小
getHistoricalPressure (int pin, int pos)	获取历史数据中第pin个手指在第pos次事件中的压力大小

pin 全称是 pointerIndex，表示第几个手指。(pin < getPointerCount() )
pos 表示历史数据中的第几个数据。( pos < getHistorySize() )

获取接触面积大小和获取压力大小是需要硬件支持的。非常不幸的是大部分设备所使用的电容屏不支持压力检测，但能够大致检测出接触面积。大部分设备的 ``getPressure()`` 是使用接触面积来模拟的。由于获取接触面积和获取压力大小受系统和硬件影响，使用的时候一定要进行数据检测，以防因为设备问题而导致程序出错。

使用 getToolType(int pointerIndex) 来获取对应的输入设备类型，pointIndex可以为0，但必须小于 getPointerCount()。
TOOL_TYPE_ERASER	橡皮擦
TOOL_TYPE_FINGER	手指
TOOL_TYPE_MOUSE	鼠标
TOOL_TYPE_STYLUS	手写笔
TOOL_TYPE_UNKNOWN	未知类型

我们在画布上正常的绘制，需要将画布坐标系转换为全局坐标系后才能真正的绘制内容。所以我们反着来，将获得到的全局坐标系坐标使用当前画布的逆矩阵转化一下，就转化为当前画布的坐标系坐标了.

```
// ▼ 注意此处使用 getRawX，而不是 getX
down_x = event.getRawX();
down_y = event.getRawY();

// ▼ 获得当前矩阵的逆矩阵
Matrix invertMatrix = new Matrix();
canvas.getMatrix().invert(invertMatrix);

// ▼ 使用 mapPoints 将触摸位置转换为画布坐标
invertMatrix.mapPoints(pts);
```

pointId 和 index 最大的区别就是 pointId 是不变的，始终为第一次落下时生成的数值，不会受到其他手指抬起和落下的影响。



