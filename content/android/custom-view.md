---
title: "自定义view"
date: 2017-03-06 16:22
---
+ ``View.onMeasure``,``widthMeasureSpec``和``heightMeasureSpec``，效率的原因以整数形式传入。在他们使用之前，首先要做的是使用``MeasureSpec.getMode``和``MeasureSpec.getSize``
+ ``specMode``有三种
  + ``MeasureSpec.EXACTLY``,边界已经确定，match_parent, fill_parent, 20dp
  + ``MeasureSpec.AT_MOST``,父控件能给的最大尺寸，这样子view会根据这个上限来设置自己的大小，wrap_content
  + ``MeasureSpec.UNSPECIFIED``,未指定大小，可以是任意大小，这种情况不多，一般都是父控件是AdapterView，通过measure方法传入的模式
+ ``setMeasuredDimension``这个方法必须由``onMeasure(int, int)``来调用，来存储测量的宽高值，如果有子view还要调用measureChildren
+ 自定义属性：
  + ``attrs.xml``

```
<declare-styleable name="CustomView">
  <attr name="textColor" format="color"/>
  <attr name="textSize" format="dimension"/>
</declare-styleable>
```

  + 获取对应的值

```
TypedArray array = context.obtainStyledAttributes(attrs,R.styleable.CustomView, defStyle, 0);
mStrokeWidth = array.getDimensionPixelSize(R.styleable.CustomViews_stroke_width, DEFAULT_STROKE_WIDTH);
```

