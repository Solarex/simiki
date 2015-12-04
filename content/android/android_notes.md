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
  + ``PorterDuffXfermode(PorterDuff.Mode mode)``，
