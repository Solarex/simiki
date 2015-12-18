---
title: "android_notes"
date: 2015-12-05 00:27
---
+ CustomView,valid format values for declare-styleable/attr tags,<http://code.google.com/p/idea-android/source/browse/trunk/src/org/jetbrains/android/dom/attrs/AttributeFormat.java?r=96>,``reference``,``string``,``color``,``dimension``,``boolean``,``integer``,``float``,``fraction``,``enum``,``flag``
+ ``Paint.setColorFilter(ColorFilter)``
  + ``ColorMatrixFilter(ColorMatrix)``，颜色值过滤，ColorMatrix是一个4*5的矩阵，每一行第5行表示偏移值。矩阵不同位置表示RGBA值，范围在0.0f~2.0f之间，1.0f为保持原图的RGB值。
  + ``LightColorFilter(int mul, int add)``，mul=colorMultiply意为色彩倍增，add=colorAdd意为色彩添加，colorMultiply执行&运算，colorAdd执行加法运算
  + ``PorterDuffColorFilter(int color, PorterDuff.Mode mode)``，根据颜色值和混合模式进行混合
+ ``Paint.setXfermode(Xfermode xfermode)``过渡模式
  + ``AvoidXfermode(int opColor, int tolerance, AvoidXfermode.Mode mode)``，第一个``opColor``表示一个16进制的可以带透明通道的颜色值例如0x12345678，第二个参数``tolerance``表示容差值，那么什么是容差呢？你可以理解为一个可以标识“精确”或“模糊”的东西，待会我们细讲，最后一个参数表示AvoidXfermode的具体模式，其可选值只有两个：``AvoidXfermode.Mode.AVOID``或者``AvoidXfermode.Mode.TARGET``
    + ``AvoidXfermode.Mode.TARGET``，在该模式下Android会判断画布上的颜色是否会有跟opColor不一样的颜色，比如我opColor是红色，那么在TARGET模式下就会去判断我们的画布上是否有存在红色的地方，如果有，则把该区域“染”上一层我们画笔定义的颜色，否则不“染”色，而tolerance容差值则表示画布上的像素和我们定义的红色之间的差别该是多少的时候才去“染”的，比如当前画布有一个像素的色值是(200, 20, 13)，而我们的红色值为(255, 0, 0)，当tolerance容差值为255时，即便(200, 20, 13)并不等于红色值也会被“染”色，容差值越大“染”色范围越广反之则反
    + ``AvoidXfermode.Mode.AVOID``，与TARGET恰恰相反，TARGET是我们指定的颜色是否与画布的颜色一样，而AVOID是我们指定的颜色是否与画布不一样，其他的都与TARGET类似。``AvoidXfermode(0XFFFFFFFF, 0, AvoidXfermode.Mode.AVOID)``当模式为AVOID容差值为0时，只有当图片中像素颜色值与0XFFFFFFFF完全不一样的地方才会被染色。``AvoidXfermode(0XFFFFFFFF, 255, AvoidXfermode.Mode.AVOID)``当容差值为255时，只要与0XFFFFFFFF稍微有点不一样的地方就会被染色
  + ``PixelXorXfermode(int opColor)``，``op ^ src ^ dst``像素色值的按位异或运算
  + ``PorterDuffXfermode(PorterDuff.Mode mode)``，图形混合模式
    + ``PorterDuff.Mode.ADD``饱和相加
    + ``PorterDuff.Mode.CLEAR``清除
    + ``PorterDuff.Mode.DARKEN``变暗
    + ``PorterDuff.Mode.DST``只绘制目标图像
    + ``PorterDuff.Mode.DST_ATOP``在源图像和目标图像相交的地方绘制目标图像而在不相交的地方绘制源图像
    + ``PorterDuff.Mode.DST_IN``只在源图像和目标图像相交的地方绘制目标图像
    + ``PorterDuff.Mode.DST_OUT``只在源图像和目标图像不相交的地方绘制目标图像
    + ``PorterDuff.Mode.DST_OVER``在源图像的上方绘制目标图像
    + ``PorterDuff.Mode.LIGHTEN``变亮
    + ``PorterDuff.Mode.MULTIPLY``正片叠加
    + ``PorterDuff.Mode.OVERLAY``叠加
    + ``PorterDuff.Mode.SCREEN``滤色
    + ``PorterDuff.Mode.SRC``显示原图
    + ``PorterDuff.Mode.SRC_ATOP``在源图像和目标图像相交的地方绘制源图像，在不相交的地方绘制目标图像
    + ``PorterDuff.Mode.SRC_IN``只在源图像和目标图像相交的地方绘制源图像
    + ``PorterDuff.Mode.SRC_OUT``只在源图像和目标图像不相交的地方绘制源图像
    + ``PorterDuff.Mode.SRC_OVER``在目标图像的顶部绘制源图像
    + ``PorterDuff.Mode.XOR``在源图像和目标图像重叠之外的任何地方绘制他们，而在不重叠的地方不绘制任何内容
+ ``Paint.FontMetrics``,top,ascent,descent,bottom,leading
+ ``StaticLayout``是``android.text.Layout``的一个子类，很明显它也是为文本处理量身定做的，其内部实现了文本绘制换行的处理。
+ ``Paint.ascent()``,``Paint.descent()``,``Paint.breakText (CharSequence text, int start, int end, boolean measureForwards, float maxWidth, float[] measuredWidth)``,``Paint.getFontMetrics (Paint.FontMetrics metrics)``,``Paint.getFontMetricsInt()``,``Paint.getFontMetricsInt(Paint.FontMetricsInt fmi)``,``Paint.getFontSpacing()``,``setUnderlineText(boolean underlineText)``,``Paint.setTypeface(Typeface typeface)``,``Paint.defaultFromStyle(int style)``,``Paint.create(String familyName, int style)和create(Typeface family, int style)``,``Paint.createFromAsset(AssetManager mgr, String path)、createFromFile(String path)和createFromFile(File path)``,``Paint.setTextSkewX(float skewX)``设置文本在水平方向上的倾斜,这个倾斜值没有具体的范围，但是官方推崇的值为-0.25可以得到比较好的倾斜文本效果，值为负右倾值为正左倾，默认值为0。``setTextSize (float textSize)``,``setTextScaleX (float scaleX)``，``setTextLocale (Locale locale)``，``setTextAlign (Paint.Align align)``，``setSubpixelText (boolean subpixelText)``,``setStrikeThruText (boolean strikeThruText)``,``setLinearText (boolean linearText)``,``setFakeBoldText (boolean fakeBoldText)``,``measureText (String text),measureText (CharSequence text, int start, int end),measureText (String text, int start, int end),measureText (char[] text, int index, int count)``,``setDither(boolean dither)``
+ ``Paint.setStrokeCap(Paint.Cap cap)``,``Paint.setStrokeJoin(Paint.Join join)``,``Paint.setShadowLayer(float radius, float dx, float dy, int shadowColor)``
+ ``Paint.setMaskFilter(MaskFilter maskfilter)``
  + ``BlurMaskFilter``模糊遮罩滤镜
  + ``EmbossMaskFilter``浮雕遮罩滤镜
+ ``Paint.setRasterizer (Rasterizer rasterizer)``设置光栅，``Paint.setPathEffect(PathEffect effect)``,``ComposePathEffect``,``CornerPathEffect``,``DashPathEffect``,``DiscretePathEffect``,``PathDashPathEffect``,``SumPathEffect``.
+ ``Paint.setShader(Shader shader)``着色器
  + ``Shader.TileMode``有三种模式``CLAMP``边缘拉伸，``MIRROR``镜像，``REPEAT``重复
  + ``BitmapShader(Bitmap bitmap, Shader.TileMode tileX, Shader.TileMode tileY)``,``tileX``和``tileY``分部表示x轴和y轴上的TileMode
  + ``LinearGradient``线性渐变``LinearGradient(float x0, float y0, float x1, float y1, int color0, int color1, Shader.TileMode tile)``，``LinearGradient(float x0, float y0, float x1, float y1, int[] colors, float[] positions, Shader.TileMode tile)``
  + ``SweepGradient``梯度渐变，扫描式渐变，类似雷达``SweepGradient(float cx, float cy, int color0, int color1)``，``SweepGradient(float cx, float cy, int[] colors, float[] positions)``
  + ``RadialGradient``径向渐变，圆形中心向四周渐变的效果
  + ``ComposeShader``组合Shader的意思，顾名思义就是两个Shader组合在一起作为一个新Shader，``ComposeShader (Shader shaderA, Shader shaderB, Xfermode mode)``，``ComposeShader (Shader shaderA, Shader shaderB, PorterDuff.Mode mode)``，一个指定了只能用PorterDuff的混合模式而另一个只要是Xfermode下的混合模式都没问题
  