---
title: "Android Tv开发"
date: 2015-11-26 10:39
---

+ declare manifest

```xml
<uses-feature android:name="android.software.leanback"
        android:required="false" />
<uses-feature android:name="android.hardware.touchscreen"
              android:required="false" />
<application
  android:banner="@drawable/banner" >
  ...
  <activity
    android:name="com.example.android.MainActivity"
    android:label="@string/app_name" >

    <intent-filter>
      <action android:name="android.intent.action.MAIN" />
      <category android:name="android.intent.category.LAUNCHER" />
    </intent-filter>
  </activity>

  <activity
    android:name="com.example.android.TvActivity"
    android:label="@string/app_name"
    android:theme="@style/Theme.Leanback">

    <intent-filter>
      <action android:name="android.intent.action.MAIN" />
      <category android:name="android.intent.category.LEANBACK_LAUNCHER" />
    </intent-filter>

  </activity>
</application>
```

+ change launcher color

When a TV app launches, the system displays an animation that resembles an expanding, filled circle. 
To customize the color of this animation, set the ``android:colorPrimary`` attribute of your TV app or activity to a specific color. 
You should also set two additional ``transition overlap`` attributes to ``true``.

```xml
<resources>
    <style ... >
      <item name="android:colorPrimary">@color/primary</item>
      <item name="android:windowAllowReturnTransitionOverlap">true</item>
      <item name="android:windowAllowEnterTransitionOverlap">true</item>
    </style>
</resources>
```

+ check for a tv device

```java
public static final String TAG = "DeviceTypeRuntimeCheck";
 
UiModeManager uiModeManager = (UiModeManager) getSystemService(UI_MODE_SERVICE);
if (uiModeManager.getCurrentModeType() == Configuration.UI_MODE_TYPE_TELEVISION) { 
    Log.d(TAG, "Running on a TV Device")
} else { 
    Log.d(TAG, "Running on a non-TV Device")
} 
```

+ unsupported tv hardware features

Android system does not support the following features for a TV device: ``android.hardware.touchscreen``,``android.hardware.faketouch`` for touchscreen emulator,``android.hardware.telephony``,``android.hardware.camera``,``android.hardware.bluetooth``,``android.hardware.nfc``,``android.hardware.location.gps``,``android.hardware.microphone``,``android.hardware.sensor``.

checking for hardware features

```java
// Check if the telephony hardware feature is available. 
if (getPackageManager().hasSystemFeature("android.hardware.telephony")) { 
    Log.d("HardwareFeatureTest", "Device can make phone calls");
} 
 
// Check if android.hardware.touchscreen feature is available. 
if (getPackageManager().hasSystemFeature("android.hardware.touchscreen")) {
    Log.d("HardwareFeatureTest", "Device has a touch screen.");
} 
```

+ GPS

TVs are stationary, indoor devices, and do not have built-in global positioning system (GPS) receivers. If your app uses location information, you can still allow users to search for a location, or use a static location provider such as a zip code configured during the TV device setup.

```java
// Request a static location from the location manager 
LocationManager locationManager = (LocationManager) this.getSystemService(
        Context.LOCATION_SERVICE);
Location location = locationManager.getLastKnownLocation("static");
 
// Attempt to get postal or zip code from the static location object 
Geocoder geocoder = new Geocoder(this);
Address address = null;
try { 
  address = geocoder.getFromLocation(location.getLatitude(),
          location.getLongitude(), 1).get(0); 
  Log.d("Zip code", address.getPostalCode());
 
} catch (IOException e) {
  Log.e(TAG, "Geocoder error", e);
}
```

+ Any TV app activity that is subject to disconnect and reconnect events must be configured to handle reconnection events in the app manifest. The following code sample demonstrates how to enable an activity to handle configuration changes, including a keyboard or navigation device connecting, disconnecting, or reconnecting:

```xml
<activity
  android:name="com.example.android.TvActivity"
  android:label="@string/app_name"
  android:configChanges="keyboard|keyboardHidden|navigation"
  android:theme="@style/Theme.Leanback">

  <intent-filter>
    <action android:name="android.intent.action.MAIN" />
    <category android:name="android.intent.category.LEANBACK_LAUNCHER" />
  </intent-filter>
  ...
</activity>
```

This configuration change allows the app to continue running through a reconnection event, rather than being restarted by the Android framework, which is not a good user experience.

+ Leanback Theme

```xml
<activity
  android:name="com.example.android.TvActivity"
  android:label="@string/app_name"
  android:theme="@style/Theme.Leanback">
```

+ Overscan

Layouts for TV have some unique requirements due to the evolution of TV standards and the desire to always present a full screen picture to viewers. For this reason, TV devices may clip the outside edge of an app layout in order to ensure that the entire display is filled. This behavior is generally referred to as overscan.

Screen elements that must be visible to the user at all times should be positioned within the overscan safe area. Adding a 5% margin of 48dp on the left and right edges and 27dp on the top and bottom edges to a layout ensures that screen elements in that layout will be within the overscan safe area.

Background screen elements that the user doesn't directly interact with should not be adjusted or clipped to the overscan safe area. This approach ensures that background screen elements look correct on all screens.

The following example shows a root layout that can contain background elements, and a nested child layout that has a 5% margin and can contain elements within the overscan safe area:

TV边界应该留些边距。

```xml
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
   android:layout_width="match_parent"
   android:layout_height="match_parent"
   >

   <!-- Screen elements that can render outside the overscan safe area go here -->

   <!-- Nested RelativeLayout with overscan-safe margin -->
   <RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
       android:layout_width="match_parent"
       android:layout_height="match_parent"
       android:layout_marginTop="27dp"
       android:layout_marginBottom="27dp"
       android:layout_marginLeft="48dp"
       android:layout_marginRight="48dp">

      <!-- Screen elements that need to be within the overscan safe area go here -->

   </RelativeLayout>
</RelativeLayout>
```

Do not apply overscan margins to your layout if you are using the v17 leanback classes, such as ``BrowseFragment`` or related widgets, as those layouts already incorporate overscan-safe margins.

+ modifying directional navigation

The Android framework automatically applies a directional navigation scheme based on the relative position of focusable elements in your layouts. You should test the generated navigation scheme in your app using a D-pad controller. After testing, if you decide you want users to move through your layouts in a specific way, you can set up explicit directional navigation for your controls.

```xml
<TextView android:id="@+id/Category1"
        android:nextFocusDown="@+id/Category2"\>
```

``nextFocusDown``,``nextFocusLeft``,``nextFocusRight``,``nextFocusUp``

You should set up the navigation order as a loop, so that the last control directs focus back to the first one.

+ provide clear focus and selection

It is important to always have an item in focus that a user can take action on immediately after your app starts, or any time it is idle.

Your app layout and implementation should use color, size, animation, or a combination of these attributes to help users easily determine what actions they can take next. Use a uniform scheme for indicating focus across your application.

Use ``selector`` to implement highlights for focused and selected controls.

+ ``ImageCardView``,To receive focus from the D-pad controller by calling ``setFocusable(true)`` and ``setFocusableInTouchMode(true)``.