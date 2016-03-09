---
title: "Notes on ListView"
date: 2016-03-09 11:25
---
+ ``index`` child views,``position`` data in adapter,``id`` unique identifier for data
+ ``hasStableIds`` Stable IDs allow the ``ListView`` to optimize for the case when items remain the same between ``notifyDataSetChanged`` calls. The IDs it refers to are the ones returned from ``getItemId``.数据源发生变化``notifyDataSetChanged``之后，只有``getItemId``返回值发生变化的item会被重新创建。Without it, the ListView has to recreate all Views since it can't know if the item IDs are the same between data changes (e.g. if the ID is just the index in the data, it has to recreate everything). With it, it can refrain from recreating Views that kept their item IDs.
+ ``convertView`` supplied by ``ListView``,matches item types,can be reused.``ArrayList<View>[] mScrapViews``
+ ``notifyDataSetChanged`` new or update data,``notifyDataSetInvalidated`` no more data available,there is no more data in ``ListView``,it's all gone.
+ ``getItemViewType`` type of view for a given position,used to provide the right convertView,``getViewTypeCount`` how many types to expect.
+ commit data changes to the adapter and call ``notifyDataSetChanged`` on the UI thread.
+ having an enabled item lets you selected with the drawables,it also lets you click the item.disabling the items is not necessarily to show the user that this item is not available for instance,can be use to apply different apperance.disable一个item项来提供不一样apperance的item view type来避免点击。
+ ``setItemsCanFocus`` to tell ListView you dont want to select the entire rows,but to select stuff inside the rows
+ ``ListView.addHeaderView``,``ListView.addFooterView`` must be called before ``setAdapter``.``addHeaderView(View v, Object data, boolean isSelectable)``,``addFooterView(View v, Object data, boolean isSelectable)``
+ ``setAdapter``传入进去的adapter由于有headerview和footerview的存在，headerview和footerview的数据类型和item不同，adapter被包装成了``HeaderViewListAdapter``,``getAdapter``获取的adapter和之前传入进去的adapter是不同的。
+ ``ListView selectors``,set ``android:drawSelectorOnTop`` to be true,shown behind the list items
+ ``convertView.setBackground(R.drawable.selector)``
+ ``android:transcriptMode`` behavior of the list when the content changes,``disabled`` doesn't scroll,``normal`` scrolls to the bottom if last item is visible,``alwaysScroll``,always scroll to the bottom
+ ``android:stackFromBottom`` stack items in reverse order, starts with the last item from the adapter, useful for chats,messaging, talk, IRC,etc
+ ``android:textFilterEnabled=true``,Adapter must implement Filterable,eg. ``CursorAdapter``,``ArrayAdapter`` etc,implement ``getFilter``
+ ``Filter``,``protected FilterResults performFiltering(CharSequence prefix)``在background thread被调用,``protected void pushlishResults(CharSequence constraint, FilterResults results)``在UI线程被调用
+ ListView自身的优化，when scrolling views are cached in bitmaps,opaque bitmap to avoid blending，快速滑动时会出现黑色条目，``android:cacheColorHint="@color/bg_color"``
+ scroll bar根据列表项动态调整大小，snake effect，when views have very different heights,smooth scroollbar need each item's height(to expensive),``android:smoothScrollbar="false"``
+ set ``ListView`` height to ``wrap_content``,will measure three items in the list.布局过程中，会计算前三项item来计算布局高度并把前三项item放入回收器中，然后开始真正的填充数据过程。
+ access view directly,``getFirstVisiblePosition``第一个可见的item position,``getChildCount``有多少view显示在屏幕上，``getChildAt``
