---
title: "android_training"
date: 2015-08-26 22:44
---
#Android Training(Getting Started)
##Build Your First App
###Starting Another Activity

```java
<activity
    android:name="com.mycompany.myfirstapp.DisplayMessageActivity"
    android:label="@string/title_activity_display_message"
    android:parentActivityName="com.mycompany.myfirstapp.MyActivity" >
    <meta-data
        android:name="android.support.PARENT_ACTIVITY"
        android:value="com.mycompany.myfirstapp.MyActivity" />
</activity>
```

The ``android:parentActivityName`` attribute declares the name of this activity's parent activity within the app's logical hierarchy. The system uses this value to implement default navigation behaviors, such as Up navigation on Android 4.1 (API level 16) and higher. You can provide the same navigation behaviors for older versions of Android by using the Support Library and adding the ``<meta-data>`` element as shown here.

##Adding the Action Bar
###Adding Action Buttons

```xml
<menu xmlns:android="http://schemas.android.com/apk/res/android"
      xmlns:yourapp="http://schemas.android.com/apk/res-auto" >
    <!-- Search, should appear as action button -->
    <item android:id="@+id/action_search"
          android:icon="@drawable/ic_action_search"
          android:title="@string/action_search"
          yourapp:showAsAction="ifRoom"  />
    ...
</menu>
```
