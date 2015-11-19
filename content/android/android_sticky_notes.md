---
title: "Sticky Notes"
date: 2014-11-03 10:16
---
+ Activity ``getIntent()`` Return the intent that started this activity.
+ PackageManager ``queryIntentActivities(Intent intent, int flags)`` Retrieve all activities that can be performed for the given intent. 取得所有可以对给定intent响应的activity。
+ ResolveInfo ``loadLabel(PackageManager pm)`` Retrieve the current textual label associated with this resolution.
+ ``ApplicationInfo`` Information you can retrieve about a particular application. This corresponds to information collected from the ``AndroidManifest.xml's <application>`` tag.``ApplicationInfo`` 所有可以从特定应用中取得的信息，和从``AndroidManifest.xml``文件``<application>``节点中搜集来的信息一一对应。
+ ``PackageInfo`` Overall information about the contents of a package. This corresponds to all of the information collected from ``AndroidManifest.xml``.关于package的所有信息，和在``AndroidManifest.xml``中搜集来的信息对应。
+ ``android:sharedUserLabel`` A user-readable label for the shared user ID. The label must be set as a reference to a string resource; it cannot be a raw string.This attribute was introduced in API Level 3. It is meaningful only if the sharedUserId attribute is also set. ``AndroidManifest.xml``中``<manifest>`` tag中的``android:sharedUserLabel``是一个对用户可读的表示``sharedUserId``的字符串，必须设置为一个string资源的引用，不能是raw string。只有在``android:sharedUserId``也被设置的时候才有意义。
+ Prior to Android 2.0, devices have seen a lot of services hanging around and claiming resources even though there was no work to be done, meaning Android brought the services back into memory even though there were no messages in the queue. This would have happened when ``stopService`` was not invoked either because of an exception or because the process was taken out between ``onStartCommandand`` and ``stopService``. Android2.0之前，即使没有工作要做，系统也会在内存中挂起许多服务占用资源，这会在``stopService``由于异常或者进程在``onStartCommand``和``stopService``之间被清除而未被调用时发生。Android 2.0 introduced a solution so that we can indicate to the system, if there are no pending intents, that it shouldn’t bother restarting the service. This is OK because whoever started the service to do the work will call it again, such as the alarm manager.This is done by returning the nonsticky flag (``Service.START_NOT_STICKY``) from
``onStartCommand``.Android 2.0引入了一种新机制，可以通知系统如果没有 pending intents，service不用被重新启动。在``onStartCommand``方法中返回``Service.START_NOT_STICKY``可以达到此目的。However, nonsticky is not really that nonsticky. Remember, even if we mark the service as nonsticky, if there are pending intents, Android will bring the service back to life. This setting applies only when there are no pending intents.
+ The sticky flag (``Service.START_STICKY``) means that Android should restart the service even if there are no pending intents. When the service is restarted, call ``onCreate`` and ``onStartCommand`` with a null intent. This will give the service an opportunity, if need be, to call ``stopSelf`` if that is appropriate. The implication is that a service that is sticky needs to deal with null intents on restarts.``Service.STAT_STICKY``标志指示系统即使在没有pending intents时也应该重启service，service重启时，传递null intent以调用``onCreate``和``onStartCommand``。
+ ``SparseArrays`` map integers to Objects.  Unlike a normal array of Objects,there can be gaps in the indices.  It is intended to be more **memory efficient than** using a ``HashMap`` to map Integers to Objects,both because it avoids auto-boxing keys and its data structure doesn't rely on an extra entry object for each mapping.
+ ``Parcel`` Container for a message (data and object references) that can be sent through an ``IBinder``. A Parcel can contain both flattened data that will be unflattened on the other side of the IPC (using the various methods here for writing specific types, or the general Parcelable interface), and references to live IBinder objects that will result in the other side receiving a proxy IBinder connected with the original IBinder in the Parcel.Parcel is not a general-purpose serialization mechanism. This class (and the corresponding Parcelable API for placing arbitrary objects into a Parcel) is designed as a high-performance IPC transport. As such, it is not appropriate to place any Parcel data in to persistent storage: changes in the underlying implementation of any of the data in the Parcel can render older data unreadable.Parcel被设计用来做高性能IPC，不适合做序列化。
+ ``ConnectivityManager`` Class that answers queries about the state of network connectivity.查询网络连接状态 It also notifies applications when network connectivity changes. Get an instance of this class by calling ``Context.getSystemService(Context.CONNECTIVITY_SERVICE)``.The primary responsibilities of this class are to:
	+ Monitor network connections (Wi-Fi, GPRS, UMTS, etc.)
	+ Send broadcast intents when network connectivity changes
	+ Attempt to "fail over" to another network when connectivity to a network is lost
	+ Provide an API that allows applications to query the coarse-grained or fine-grained state of the available networks
+ ``NetworkPolicyManager`` Manager for creating and modifying network policy rules.
+ ``NetworkStatsService`` Collect and persist detailed network statistics, and provide this data to other system services. ``NetworkStatsSettings``Settings that can be changed externally.
+ ``HandlerThread`` Handy class for starting a new thread that has a looper. The looper can then be used to create handler classes. Note that ``start()`` must still be called.
+ ``RemoteCallbackList`` Takes care of the grunt work of maintaining a list of remote interfaces, typically for the use of performing callbacks from a Service to its clients. ``RemoteCallbackList``主要用来处理service对client的回调处理。In particular, this:
	+ Keeps track of a set of registered ``IInterface`` callbacks, taking care to identify them through their underlying unique ``IBinder`` (by calling ``IInterface.asBinder()``.
	+ Attaches a ``IBinder.DeathRecipient`` to each registered interface, so that it can be cleaned out of the list if its process goes away.
	+ Performs locking of the underlying list of interfaces to deal with multithreaded incoming calls, and a thread-safe way to iterate over a snapshot of the list without holding its lock.
To use this class, simply create a single instance along with your service, and call its ``register(E)`` and ``unregister(E)`` methods as client register and unregister with your service. To call back on to the registered clients, use ``beginBroadcast()``, ``getBroadcastItem(int)``, and ``finishBroadcast()``.If a registered callback's process goes away, this class will take care of automatically removing it from the list. If you want to do additional work in this situation, you can create a subclass that implements the ``onCallbackDied(E)`` method.要使用这个类，创建一个和你的服务相连的实例，client调用``register(E)``和``unregister(E)``来register和unregister service。
+ ``NetworkStats`` Creates ``NetworkStats`` instances by parsing various ``/proc/`` files as needed. Collection of active network statistics. Can contain summary details across all interfaces, or details with per-UID granularity. Internally stores data as a large table, closely matching ``/proc/`` data format. This structure optimizes for rapid in-memory comparison, but consider using ``NetworkStatsHistory`` when persisting.``NetworkStats``是活动网络数据收集的集合，包含所有活跃的网络接口的统计信息，或者每个UID的细节。在内存中使用一个很大的表作为存储，格式和``/proc``中数据存储格式很相似。``NetworkStats``存储结构为内存内的比较进行了优化，如果需要持久化的话，考虑使用``NetworkStatsHistory``吧。
+ ``Context.enforceCallingOrSelfPermission(String permission, String message)`` If neither you nor the calling process of an IPC you are handling has been granted a particular permission, throw a ``SecurityException``.被授予特殊权限的时候抛出``SecurityException``异常。
+ ``NativeDaemonConnector`` Generic connector class for interfacing with a native daemon which uses the ``libsysutils`` FrameworkListener protocol.通用的用来和使用了``libsysutils`` FrameworkListener协议的本地守护进程进行交互的connector class。
+ ``PendingIntent`` A description of an ``Intent`` and target action to perform with it. Instances of this class are created with ``getActivity(Context, int, Intent, int)``, ``getActivities(Context, int, Intent[], int)``, ``getBroadcast(Context, int, Intent, int)``, and ``getService(Context, int, Intent, int)``; the returned object can be handed to other applications so that they can perform the action you described on your behalf at a later time.返回的对象可以交给其他应用程序，这样其他应用程序可以以你的身份之后执行在``PendingIntent``中描述的操作。By giving a ``PendingIntent`` to another application, you are granting it the right to perform the operation you have specified as if the other application was yourself (with the same permissions and identity). As such, you should be careful about how you build the ``PendingIntent``: almost always, for example, the base Intent you supply should have the component name explicitly set to one of your own components, to ensure it is ultimately sent there and nowhere else.将``PendingIntent``传递给其他对象意味着给其他应用程序授权，因此应该在构建``PendingIntent``时加倍小心，应该显示设置要传递的component name。A ``PendingIntent`` itself is simply a reference to a token maintained by the system describing the original data used to retrieve it. This means that, even if its owning application's process is killed, the ``PendingIntent`` itself will remain usable from other processes that have been given it. If the creating application later re-retrieves the same kind of ``PendingIntent`` (same operation, same Intent action, data, categories, and components, and same flags), it will receive a ``PendingIntent`` representing the same token if that is still valid, and can thus call cancel() to remove it.``PendingIntent``是一个引用。Because of this behavior, it is important to know when two Intents are considered to be the same for purposes of retrieving a PendingIntent. A common mistake people make is to create multiple PendingIntent objects with Intents that only vary in their "extra" contents, expecting to get a different PendingIntent each time. This does not happen. The parts of the Intent that are used for matching are the same ones defined by Intent.filterEquals. If you use two Intent objects that are equivalent as per Intent.filterEquals, then you will get the same PendingIntent for both of them.
+ ``IntentFilter`` Structured description of ``Intent`` values to be matched. An ``IntentFilter`` can match against **actions**, **categories**, and **data (either via its type, scheme, and/or path)** in an Intent. It also includes a "priority" value which is used to order multiple matching filters.``IntentFilter`` objects are often created in XML as part of a package's ``AndroidManifest.xml`` file, using ``intent-filter`` tags.There are three ``Intent`` characteristics you can filter on: the action, data, and categories. For each of these characteristics you can provide multiple possible matching values (via ``addAction(String)``, ``addDataType(String)``, ``addDataScheme(String)``, ``addDataSchemeSpecificPart(String, int)``, ``addDataAuthority(String, String)``, ``addDataPath(String, int)``, and ``addCategory(String)``, respectively). For actions, the field will not be tested if no values have been given (treating it as a wildcard); if no data characteristics are specified, however, then the filter will only match intents that contain no data.
+ ``DropBoxManager`` Enqueues chunks of data (from various sources -- application crashes, kernel log records, etc.). The queue is size bounded and will drop old data if the enqueued data exceeds the maximum size. You can think of this as a persistent, system-wide, blob-oriented "logcat".You can obtain an instance of this class by calling ``getSystemService(String)`` with ``DROPBOX_SERVICE``.``DropBoxManager`` entries are not sent anywhere directly, but other system services and debugging tools may scan and upload entries for processing.``DropBoxManager``将不同来源的数据入列。队列有大小，超出队列大小时，将会把旧数据丢弃，可以把``DropBoxManager``当做一个持久化的，系统范围的，二进制的``logcat``。可以从服务中得到它。
+ ``NetworkStatsRecorder`` Logic to record deltas between periodic ``NetworkStats`` snapshots into ``NetworkStatsHistory`` that belong to ``networkStatsCollection``.Keeps pending changes in memory until they pass a specific threshold, in  bytes. Uses ``FileRotator`` for persistence logic.Not inherently thread safe.
+ ``NetworkStatsCollection`` Collection of ``NetworkStatsHistory``, stored based on combined key of ``NetworkIdentitySet``, UID, set, and tag. Knows how to persist itself.
+ ``AtomicFile`` Helper class for performing atomic operations on a file by creating a backup file until a write has successfully completed. If you need this on older versions of the platform you can use ``AtomicFile`` in the v4 support library.Atomic file guarantees file integrity by ensuring that a file has been completely written and sync'd to disk before removing its backup. As long as the backup file exists, the original file is considered to be invalid (left over from a previous attempt to write the file).通过创建一个文件的备份来保证在文件上的操作是原子性的，保证文件被写入并同步到了磁盘，这些操作没有完成不会删除备份文件，如果备份文件存在，原来的文件就是不合法的，因为也许上一次尝试写入文件没有完成就离开了。Atomic file does not confer any file locking semantics. Do not use this class when the file may be accessed or modified concurrently by multiple threads or processes. The caller is responsible for ensuring appropriate mutual exclusion invariants whenever it accesses the file.``AtomicFile``不提供锁机制，当这个文件可能被并发访问或修改时不要使用``AtomicFile``。
+ Android系统原生自带的``style.xml``在目录``framework/base/core/res/res/values/styles.xml``
+ ``NetworkTemplate`` Template definition used to generically match ``NetworkIdentity``,usually when collecting statistics.``NetworkTemplate``主要用来收集统计信息。
+ ``Loader`` An abstract class that performs asynchronous loading of data. While Loaders are active they should monitor the source of their data and deliver new results when the contents change.
+ ``ContentResolver`` ``public final void registerContentObserver (Uri uri, boolean notifyForDescendents, ContentObserver observer)`` Register an observer class that gets callbacks when data identified by a given content URI changes.注册一个observer类，当给定的URI所指向的内容发生变化时，用来回调。
+ ``UEventObserver``,UEventObserver is an abstract class that receives UEvent's from the kernel.Subclass UEventObserver, implementing ``onUEvent(UEvent event)``, then call ``startObserving()`` with a match string. The UEvent thread will then call your ``onUEvent()`` method when a UEvent occurs that contains your match string.Call ``stopObserving()`` to stop receiving UEvent's.
+ ``PreferenceFragment``,Shows a hierarchy of Preference objects as lists. These preferences will automatically save to ``SharedPreferences`` as the user interacts with them. To retrieve an instance of ``SharedPreferences`` that the preference hierarchy in this fragment will use, call ``getDefaultSharedPreferences(android.content.Context)`` with a context in the same package as this fragment.Furthermore, the preferences shown will follow the visual style of system preferences. It is easy to create a hierarchy of preferences (that can be shown on multiple screens) via XML. For these reasons, it is recommended to use this fragment (as a superclass) to deal with preferences in applications.
+ ``FragmentManager.BackStackEntry``,Representation of an entry on the fragment back stack, as created with ``FragmentTransaction.addToBackStack()``. Entries can later be retrieved with ``FragmentManager.getBackStackEntry()``.
+ The best way to add a share action item to an ``ActionBar`` is to use ``ShareActionProvider``, which became available in API level 14.
+ ``per-URI permissions``:when starting an activity or returning a result to an activity, the caller can set ``Intent.FLAG_GRANT_READ_URI_PERMISSION`` and/or ``Intent.FLAG_GRANT_WRITE_URI_PERMISSION``. This grants the receiving activity permission access the specific data URI in the Intent, regardless of whether it has any permission to access data in the content provider corresponding to the Intent.
+ handles receiving a single image of any type,or multiple images of any type

```xml
<intent-filter>
    <action android:name="android.intent.action.SEND" />
    <category android:name="android.intent.category.DEFAULT" />
    <data android:mimeType="image/*" />
</intent-filter>
<intent-filter>
    <action android:name="android.intent.action.SEND_MULTIPLE" />
    <category android:name="android.intent.category.DEFAULT" />
    <data android:mimeType="image/*" />
</intent-filter>
```

+ An ``ActionProvider``, once attached to a menu item in the action bar, handles both the appearance and behavior of that item. In the case of ``ShareActionProvider``, you provide a share intent and it does the rest.
+ ``ShareActionProvider``

```xml
<menu xmlns:android="http://schemas.android.com/apk/res/android">
    <item
            android:id="@+id/menu_item_share"
            android:showAsAction="ifRoom"
            android:title="Share"
            android:actionProviderClass=
                "android.widget.ShareActionProvider" />
    ...
</menu>
```

```java
private ShareActionProvider mShareActionProvider;
...

@Override
public boolean onCreateOptionsMenu(Menu menu) {
    // Inflate menu resource file.
    getMenuInflater().inflate(R.menu.share_menu, menu);

    // Locate MenuItem with ShareActionProvider
    MenuItem item = menu.findItem(R.id.menu_item_share);

    // Fetch and store ShareActionProvider
    mShareActionProvider = (ShareActionProvider) item.getActionProvider();

    // Return true to display menu
    return true;
}

// Call to update the share intent
private void setShareIntent(Intent shareIntent) {
    if (mShareActionProvider != null) {
        mShareActionProvider.setShareIntent(shareIntent);
    }
}
```

+ Sharing Files:In all cases, the only secure way to offer a file from your app to another app is to send the receiving app the file's content URI and grant temporary access permissions to that URI. Content URIs with temporary URI access permissions are secure because they apply only to the app that receives the URI, and they expire automatically. The Android ``FileProvider`` component provides the method ``getUriForFile()`` for generating a file's content URI.

+ Defining a ``FileProvider`` for your app requires an entry in your manifest. This entry specifies the authority to use in generating content URIs, as well as the name of an XML file that specifies the directories your app can share.

```
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.myapp">
    <application
        ...>
        <provider
            android:name="android.support.v4.content.FileProvider"
            android:authorities="com.example.myapp.fileprovider"
            android:grantUriPermissions="true"
            android:exported="false">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/filepaths" />
        </provider>
        ...
    </application>
</manifest>
```

Once you have added the ``FileProvider`` to your app manifest, you need to specify the directories that contain the files you want to share. To specify the directories, start by creating the file ``filepaths.xml`` in the ``res/xml/`` subdirectory of your project. In this file, specify the directories by adding an XML element for each directory.

The snippet also demonstrates how to share a subdirectory of the files/ directory in your internal storage area:

```
<paths>
    <files-path path="images/" name="myimages" />
</paths>
```

In this example, the ``<files-path>`` tag shares directories within the ``files/`` directory of your app's internal storage. The path attribute shares the ``images/`` subdirectory of ``files/``. The name attribute tells the ``FileProvider`` to add the path segment ``myimages`` to content URIs for files in the ``files/images/`` subdirectory.The ``<paths>`` element can have multiple children, each specifying a different directory to share. In addition to the ``<files-path>`` element, you can use the ``<external-path>`` element to share directories in external storage, and the ``<cache-path>`` element to share directories in your internal cache directory.

You now have a complete specification of a ``FileProvider`` that generates content URIs for files in the ``files/`` directory of your app's internal storage or for files in subdirectories of ``files/``. When your app generates a content URI for a file, it contains the authority specified in the ``<provider>`` element (``com.example.myapp.fileprovider``), the path ``myimages/``, and the name of the file. ``content://com.example.myapp.fileprovider/myimages/default_image.jpg``

To receive requests for files from client apps and respond with a content URI, your app should provide a file selection Activity. Client apps start this Activity by calling ``startActivityForResult()`` with an Intent containing the action ``ACTION_PICK``. When the client app calls ``startActivityForResult()``, your app can return a result to the client app, in the form of a content URI for the file the user selected.

To set up the file selection Activity, start by specifying the Activity in your manifest, along with an intent filter that matches the action ``ACTION_PICK`` and the categories ``CATEGORY_DEFAULT`` and ``CATEGORY_OPENABLE``. Also add MIME type filters for the files your app serves to other apps.

```
<activity
    android:name=".FileSelectActivity"
    android:label="@"File Selector" >
    <intent-filter>
        <action
            android:name="android.intent.action.PICK"/>
        <category
            android:name="android.intent.category.DEFAULT"/>
        <category
            android:name="android.intent.category.OPENABLE"/>
        <data android:mimeType="text/plain"/>
        <data android:mimeType="image/*"/>
    </intent-filter>
</activity>
```

```
public class MainActivity extends Activity {
    // The path to the root of this app's internal storage
    private File mPrivateRootDir;
    // The path to the "images" subdirectory
    private File mImagesDir;
    // Array of files in the images subdirectory
    File[] mImageFiles;
    // Array of filenames corresponding to mImageFiles
    String[] mImageFilenames;
    // Initialize the Activity
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        ...
        // Set up an Intent to send back to apps that request a file
        mResultIntent =
                new Intent("com.example.myapp.ACTION_RETURN_FILE");
        // Get the files/ subdirectory of internal storage
        mPrivateRootDir = getFilesDir();
        // Get the files/images subdirectory;
        mImagesDir = new File(mPrivateRootDir, "images");
        // Get the files in the images subdirectory
        mImageFiles = mImagesDir.listFiles();
        // Set the Activity's result to null to begin with
        setResult(Activity.RESULT_CANCELED, null);
        /*
         * Display the file names in the ListView mFileListView.
         * Back the ListView with the array mImageFilenames, which
         * you can create by iterating through mImageFiles and
         * calling File.getAbsolutePath() for each File
         */
         ...

        // Define a listener that responds to clicks on a file in the ListView
        mFileListView.setOnItemClickListener(
                new AdapterView.OnItemClickListener() {
            @Override
            /*
             * When a filename in the ListView is clicked, get its
             * content URI and send it to the requesting app
             */
            public void onItemClick(AdapterView<?> adapterView,
                    View view,
                    int position,
                    long rowId) {
                /*
                 * Get a File for the selected file name.
                 * Assume that the file names are in the
                 * mImageFilename array.
                 */
                File requestFile = new File(mImageFilename[position]);
                /*
                 * Most file-related method calls need to be in
                 * try-catch blocks.
                 */
                // Use the FileProvider to get a content URI
                try {
                    fileUri = FileProvider.getUriForFile(
                            MainActivity.this,
                            "com.example.myapp.fileprovider",
                            requestFile);
                } catch (IllegalArgumentException e) {
                    Log.e("File Selector",
                          "The selected file can't be shared: " +
                          clickedFilename);
                }
                

                if (fileUri != null) {
                    // Grant temporary read permission to the content URI
                    mResultIntent.addFlags(
                        Intent.FLAG_GRANT_READ_URI_PERMISSION);
                    // Put the Uri and MIME type in the result Intent
                    mResultIntent.setDataAndType(
                            fileUri,
                            getContentResolver().getType(fileUri));
                    // Set the result
                    MainActivity.this.setResult(Activity.RESULT_OK,
                            mResultIntent);
                    } else {
                        mResultIntent.setDataAndType(null, "");
                        MainActivity.this.setResult(RESULT_CANCELED,
                                mResultIntent);
                    }
                }
            }
        });
    }
    ...
}
```

```
    /*
     * When the Activity of the app that hosts files sets a result and calls
     * finish(), this method is invoked. The returned Intent contains the
     * content URI of a selected file. The result code indicates if the
     * selection worked or not.
     */
    @Override
    public void onActivityResult(int requestCode, int resultCode,
            Intent returnIntent) {
        // If the selection didn't work
        if (resultCode != RESULT_OK) {
            // Exit without doing anything else
            return;
        } else {
            // Get the file's content URI from the incoming Intent
            Uri returnUri = returnIntent.getData();
            /*
             * Try to open the file for "read" access using the
             * returned URI. If the file isn't found, write to the
             * error log and return.
             */
            try {
                /*
                 * Get the content resolver instance for this context, and use it
                 * to get a ParcelFileDescriptor for the file.
                 */
                mInputPFD = getContentResolver().openFileDescriptor(returnUri, "r");
            } catch (FileNotFoundException e) {
                e.printStackTrace();
                Log.e("MainActivity", "File not found.");
                return;
            }
            // Get a regular file descriptor for the file
            FileDescriptor fd = mInputPFD.getFileDescriptor();
            ...
        }
    }
```

The method ``openFileDescriptor()`` returns a ``ParcelFileDescriptor`` forthe file. From this object, the client app gets a ``FileDescriptor`` object, which it can then use to read the file.

```
    ...
    /*
     * Get the file's content URI from the incoming Intent, then
     * get the file's MIME type
     */
    Uri returnUri = returnIntent.getData();
    String mimeType = getContentResolver().getType(returnUri);
    ...
    /*
     * Get the file's content URI from the incoming Intent,
     * then query the server app to get the file's display name
     * and size.
     */
    Uri returnUri = returnIntent.getData();
    Cursor returnCursor =
            getContentResolver().query(returnUri, null, null, null, null);
    /*
     * Get the column indexes of the data in the Cursor,
     * move to the first row in the Cursor, get the data,
     * and display it.
     */
    int nameIndex = returnCursor.getColumnIndex(OpenableColumns.DISPLAY_NAME);
    int sizeIndex = returnCursor.getColumnIndex(OpenableColumns.SIZE);
    returnCursor.moveToFirst();
    TextView nameView = (TextView) findViewById(R.id.filename_text);
    TextView sizeView = (TextView) findViewById(R.id.filesize_text);
    nameView.setText(returnCursor.getString(nameIndex));
    sizeView.setText(Long.toString(returnCursor.getLong(sizeIndex)));
    ...
```

+ Sharing with NFC

```
<uses-permission android:name="android.permission.NFC" />
<uses-permission
            android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-feature
    android:name="android.hardware.nfc"
    android:required="true" />

        // NFC isn't available on the device
        if (!PackageManager.hasSystemFeature(PackageManager.FEATURE_NFC)) {
            /*
             * Disable NFC features here.
             * For example, disable menu items or buttons that activate
             * NFC-related features
             */
            ...
        // Android Beam file transfer isn't supported
        } else if (Build.VERSION.SDK_INT <
                Build.VERSION_CODES.JELLY_BEAN_MR1) {
            // If Android Beam isn't available, don't continue.
            mAndroidBeamAvailable = false;
            /*
             * Disable Android Beam file transfer features here.
             */
            ...
        // Android Beam file transfer is available, continue
        } else {
        mNfcAdapter = NfcAdapter.getDefaultAdapter(this);
        ...
        }
```

Once you've verified that the device supports Android Beam file transfer, add a callback method that the system invokes when Android Beam file transfer detects that the user wants to send files to another NFC-enabled device. In this callback method, return an array of ``Uri`` objects. Android Beam file transfer copies the files represented by these URIs to the receiving device.To add the callback method, implement the ``NfcAdapter.CreateBeamUrisCallback`` interface and its method ``createBeamUris()``.

```
public class MainActivity extends Activity {
    ...
    // List of URIs to provide to Android Beam
    private Uri[] mFileUris = new Uri[10];
    ...
    /**
     * Callback that Android Beam file transfer calls to get
     * files to share
     */
    private class FileUriCallback implements
            NfcAdapter.CreateBeamUrisCallback {
        public FileUriCallback() {
        }
        /**
         * Create content URIs as needed to share with another device
         */
        @Override
        public Uri[] createBeamUris(NfcEvent event) {
            return mFileUris;
        }
    }
    ...
    // Instance that returns available files from this app
    private FileUriCallback mFileUriCallback;
    ...
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        ...
        // Android Beam file transfer is available, continue
        ...
        mNfcAdapter = NfcAdapter.getDefaultAdapter(this);
        /*
         * Instantiate a new FileUriCallback to handle requests for
         * URIs
         */
        mFileUriCallback = new FileUriCallback();
        // Set the dynamic callback for URI requests.
        mNfcAdapter.setBeamPushUrisCallback(mFileUriCallback,this);
        ...
    }
    ...
}
```

You can also provide the array of Uri objects directly to the NFC framework through your app's NfcAdapter instance. Choose this approach if you can define the URIs to transfer before the NFC touch event occurs. ``NfcAdapter.setBeamPushUris()``

To transfer one or more files to another NFC-enabled device, get a file URI (a URI with a file scheme) for each file and then add the URI to an array of Uri objects. To transfer a file, you must also have permanent read access for the file.

```
        /*
         * Create a list of URIs, get a File,
         * and set its permissions
         */
        private Uri[] mFileUris = new Uri[10];
        String transferFile = "transferimage.jpg";
        File extDir = getExternalFilesDir(null);
        File requestFile = new File(extDir, transferFile);
        requestFile.setReadable(true, false);
        // Get a URI for the File and add it to the list of URIs
        fileUri = Uri.fromFile(requestFile);
        if (fileUri != null) {
            mFileUris[0] = fileUri;
        } else {
            Log.e("My Activity", "No File URI available for file.");
        }
```

+ Managing Audio Playback

You may be tempted to try and listen for volume key presses and modify the volume of your audio stream that way. Resist the urge. Android provides the handy ``setVolumeControlStream()`` method to direct volume key presses to the audio stream you specify.Having identified the audio stream your application will be using, you should set it as the volume stream target. You should make this call early in your app’s lifecycle—because you only need to call it once during the activity lifecycle, you should typically call it within the ``onCreate()`` method (of the ``Activity`` or ``Fragment`` that controls your media). This ensures that whenever your app is visible, the volume controls function as the user expects.

Media playback buttons such as play, pause, stop, skip, and previous are available on some handsets and many connected or wireless headsets. Whenever a user presses one of these hardware keys, the system broadcasts an intent with the ``ACTION_MEDIA_BUTTON`` action.

```
public class RemoteControlReceiver extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        if (Intent.ACTION_MEDIA_BUTTON.equals(intent.getAction())) {
            KeyEvent event = (KeyEvent)intent.getParcelableExtra(Intent.EXTRA_KEY_EVENT);
            if (KeyEvent.KEYCODE_MEDIA_PLAY == event.getKeyCode()) {
                // Handle key press.
            }
        }
    }
}

AudioManager am = mContext.getSystemService(Context.AUDIO_SERVICE);
...

// Start listening for button presses
am.registerMediaButtonEventReceiver(RemoteControlReceiver);
...

// Stop listening for button presses
am.unregisterMediaButtonEventReceiver(RemoteControlReceiver);
```

+ With multiple apps potentially playing audio it's important to think about how they should interact. To avoid every music app playing at the same time, Android uses audio focus to moderate audio playback—only apps that hold the audio focus should play audio.Before your app starts playing any audio, it should hold the audio focus for the stream it will be using. This is done with a call to ``requestAudioFocus()`` which returns ``AUDIOFOCUS_REQUEST_GRANTED`` if your request is successful.

```
AudioManager am = mContext.getSystemService(Context.AUDIO_SERVICE);
...

// Request audio focus for playback
int result = am.requestAudioFocus(afChangeListener,
                                 // Use the music stream.
                                 AudioManager.STREAM_MUSIC,
                                 // Request permanent focus.
                                 AudioManager.AUDIOFOCUS_GAIN);
   
if (result == AudioManager.AUDIOFOCUS_REQUEST_GRANTED) {
    am.registerMediaButtonEventReceiver(RemoteControlReceiver);
    // Start playback.
}
```

Once you've finished playback be sure to call ``abandonAudioFocus()``. This notifies the system that you no longer require focus and unregisters the associated ``AudioManager.OnAudioFocusChangeListener``.

```
// Abandon audio focus when playback complete    
am.abandonAudioFocus(afChangeListener);
``` 

```
OnAudioFocusChangeListener afChangeListener = new OnAudioFocusChangeListener() {
    public void onAudioFocusChange(int focusChange) {
        if (focusChange == AUDIOFOCUS_LOSS_TRANSIENT
            // Pause playback
        } else if (focusChange == AudioManager.AUDIOFOCUS_GAIN) {
            // Resume playback 
        } else if (focusChange == AudioManager.AUDIOFOCUS_LOSS) {
            am.unregisterMediaButtonEventReceiver(RemoteControlReceiver);
            am.abandonAudioFocus(afChangeListener);
            // Stop playback
        }
    }
};
```

Ducking is the process of lowering your audio stream output volume to make transient audio from another app easier to hear without totally disrupting the audio from your own application.

```
OnAudioFocusChangeListener afChangeListener = new OnAudioFocusChangeListener() {
    public void onAudioFocusChange(int focusChange) {
        if (focusChange == AUDIOFOCUS_LOSS_TRANSIENT_CAN_DUCK) {
            // Lower the volume
        } else if (focusChange == AudioManager.AUDIOFOCUS_GAIN) {
            // Raise it back to normal
        }
    }
};
```

+ Save the Full-size Photo

```
String mCurrentPhotoPath;

private File createImageFile() throws IOException {
    // Create an image file name
    String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date());
    String imageFileName = "JPEG_" + timeStamp + "_";
    File storageDir = Environment.getExternalStoragePublicDirectory(
            Environment.DIRECTORY_PICTURES);
    File image = File.createTempFile(
        imageFileName,  /* prefix */
        ".jpg",         /* suffix */
        storageDir      /* directory */
    );

    // Save a file: path for use with ACTION_VIEW intents
    mCurrentPhotoPath = "file:" + image.getAbsolutePath();
    return image;
}

static final int REQUEST_TAKE_PHOTO = 1;

private void dispatchTakePictureIntent() {
    Intent takePictureIntent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
    // Ensure that there's a camera activity to handle the intent
    if (takePictureIntent.resolveActivity(getPackageManager()) != null) {
        // Create the File where the photo should go
        File photoFile = null;
        try {
            photoFile = createImageFile();
        } catch (IOException ex) {
            // Error occurred while creating the File
            ...
        }
        // Continue only if the File was successfully created
        if (photoFile != null) {
            takePictureIntent.putExtra(MediaStore.EXTRA_OUTPUT,
                    Uri.fromFile(photoFile));
            startActivityForResult(takePictureIntent, REQUEST_TAKE_PHOTO);
        }
    }
}

private void galleryAddPic() {
    Intent mediaScanIntent = new Intent(Intent.ACTION_MEDIA_SCANNER_SCAN_FILE);
    File f = new File(mCurrentPhotoPath);
    Uri contentUri = Uri.fromFile(f);
    mediaScanIntent.setData(contentUri);
    this.sendBroadcast(mediaScanIntent);
}

private void setPic() {
    // Get the dimensions of the View
    int targetW = mImageView.getWidth();
    int targetH = mImageView.getHeight();

    // Get the dimensions of the bitmap
    BitmapFactory.Options bmOptions = new BitmapFactory.Options();
    bmOptions.inJustDecodeBounds = true;
    BitmapFactory.decodeFile(mCurrentPhotoPath, bmOptions);
    int photoW = bmOptions.outWidth;
    int photoH = bmOptions.outHeight;

    // Determine how much to scale down the image
    int scaleFactor = Math.min(photoW/targetW, photoH/targetH);

    // Decode the image file into a Bitmap sized to fill the View
    bmOptions.inJustDecodeBounds = false;
    bmOptions.inSampleSize = scaleFactor;
    bmOptions.inPurgeable = true;

    Bitmap bitmap = BitmapFactory.decodeFile(mCurrentPhotoPath, bmOptions);
    mImageView.setImageBitmap(bitmap);
}
```

+ Controlling the Camera:Getting an instance of the ``Camera`` object is the first step in the process of directly controlling the camera. As Android's own ``Camera`` application does, the recommended way to access the camera is to open ``Camera`` on a separate thread that's launched from ``onCreate()``. This approach is a good idea since it can take a while and might bog down the UI thread. In a more basic implementation, opening the camera can be deferred to the ``onResume()`` method to facilitate code reuse and keep the flow of control simple.在``onCreate``或者``onResume``中起一个线程``Camera.open()``

```
private boolean safeCameraOpen(int id) {
    boolean qOpened = false;
  
    try {
        releaseCameraAndPreview();
        mCamera = Camera.open(id);
        qOpened = (mCamera != null);
    } catch (Exception e) {
        Log.e(getString(R.string.app_name), "failed to open Camera");
        e.printStackTrace();
    }

    return qOpened;    
}

private void releaseCameraAndPreview() {
    mPreview.setCamera(null);
    if (mCamera != null) {
        mCamera.release();
        mCamera = null;
    }
}
```

+ To get started with displaying a preview, you need preview class. The preview requires an implementation of the ``android.view.SurfaceHolder.Callback`` interface, which is used to pass image data from the camera hardware to the application.

```
class Preview extends ViewGroup implements SurfaceHolder.Callback {

    SurfaceView mSurfaceView;
    SurfaceHolder mHolder;

    Preview(Context context) {
        super(context);

        mSurfaceView = new SurfaceView(context);
        addView(mSurfaceView);

        // Install a SurfaceHolder.Callback so we get notified when the
        // underlying surface is created and destroyed.
        mHolder = mSurfaceView.getHolder();
        mHolder.addCallback(this);
        mHolder.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS);
    }
...
}
```

A camera instance and its related preview must be created in a specific order, with the camera object being first. In the snippet below, the process of initializing the camera is encapsulated so that ``Camera.startPreview()`` is called by the ``setCamera()`` method, whenever the user does something to change the camera. The preview must also be restarted in the preview class ``surfaceChanged()`` callback method.

```
public void setCamera(Camera camera) {
    if (mCamera == camera) { return; }
    
    stopPreviewAndFreeCamera();
    
    mCamera = camera;
    
    if (mCamera != null) {
        List<Size> localSizes = mCamera.getParameters().getSupportedPreviewSizes();
        mSupportedPreviewSizes = localSizes;
        requestLayout();
      
        try {
            mCamera.setPreviewDisplay(mHolder);
        } catch (IOException e) {
            e.printStackTrace();
        }
      
        // Important: Call startPreview() to start updating the preview
        // surface. Preview must be started before you can take a picture.
        mCamera.startPreview();
    }
}
```

+ Modify Camera Settings

```
public void surfaceChanged(SurfaceHolder holder, int format, int w, int h) {
    // Now that the size is known, set up the camera parameters and begin
    // the preview.
    Camera.Parameters parameters = mCamera.getParameters();
    parameters.setPreviewSize(mPreviewSize.width, mPreviewSize.height);
    requestLayout();
    mCamera.setParameters(parameters);

    // Important: Call startPreview() to start updating the preview surface.
    // Preview must be started before you can take a picture.
    mCamera.startPreview();
}
```

+ The ``setCameraDisplayOrientation()`` method lets you change how the preview is displayed without affecting how the image is recorded. 

+ Take Picture:Use the ``Camera.takePicture()`` method to take a picture once the preview is started. You can create ``Camera.PictureCallback`` and ``Camera.ShutterCallback`` objects and pass them into ``Camera.takePicture()``.If you want to grab images continously, you can create a ``Camera.PreviewCallback`` that implements ``onPreviewFrame()``. For something in between, you can capture only selected preview frames, or set up a delayed action to call ``takePicture()``.

+ Restart the Preview:After a picture is taken, you must restart the preview before the user can take another picture. In this example, the restart is done by overloading the shutter button.

```
@Override
public void onClick(View v) {
    switch(mPreviewState) {
    case K_STATE_FROZEN:
        mCamera.startPreview();
        mPreviewState = K_STATE_PREVIEW;
        break;

    default:
        mCamera.takePicture( null, rawCallback, null);
        mPreviewState = K_STATE_BUSY;
    } // switch
    shutterBtnConfig();
}
```

+ Stop the Preview and Release the Camera

```
public void surfaceDestroyed(SurfaceHolder holder) {
    // Surface will be destroyed when we return, so stop the preview.
    if (mCamera != null) {
        // Call stopPreview() to stop updating the preview surface.
        mCamera.stopPreview();
    }
}

/**
 * When this function returns, mCamera will be null.
 */
private void stopPreviewAndFreeCamera() {

    if (mCamera != null) {
        // Call stopPreview() to stop updating the preview surface.
        mCamera.stopPreview();
    
        // Important: Call release() to release the camera for use by other
        // applications. Applications should release the camera immediately
        // during onPause() and re-open() it during onResume()).
        mCamera.release();
    
        mCamera = null;
    }
}
```

+ Display Bitmap

```
BitmapFactory.Options options = new BitmapFactory.Options();
options.inJustDecodeBounds = true;
BitmapFactory.decodeResource(getResources(), R.id.myimage, options);
int imageHeight = options.outHeight;
int imageWidth = options.outWidth;
String imageType = options.outMimeType;
```

```
public static int calculateInSampleSize(
            BitmapFactory.Options options, int reqWidth, int reqHeight) {
    // Raw height and width of image
    final int height = options.outHeight;
    final int width = options.outWidth;
    int inSampleSize = 1;

    if (height > reqHeight || width > reqWidth) {

        final int halfHeight = height / 2;
        final int halfWidth = width / 2;

        // Calculate the largest inSampleSize value that is a power of 2 and keeps both
        // height and width larger than the requested height and width.
        while ((halfHeight / inSampleSize) >= reqHeight
                && (halfWidth / inSampleSize) >= reqWidth) {
            inSampleSize *= 2;
        }
    }

    return inSampleSize;
}
```

```
public static Bitmap decodeSampledBitmapFromResource(Resources res, int resId,
        int reqWidth, int reqHeight) {

    // First decode with inJustDecodeBounds=true to check dimensions
    final BitmapFactory.Options options = new BitmapFactory.Options();
    options.inJustDecodeBounds = true;
    BitmapFactory.decodeResource(res, resId, options);

    // Calculate inSampleSize
    options.inSampleSize = calculateInSampleSize(options, reqWidth, reqHeight);

    // Decode bitmap with inSampleSize set
    options.inJustDecodeBounds = false;
    return BitmapFactory.decodeResource(res, resId, options);
}
```

+ On Android Android 2.2 (API level 8) and lower, when garbage collection occurs, your app's threads get stopped. This causes a lag that can degrade performance. Android 2.3 adds concurrent garbage collection, which means that the memory is reclaimed soon after a bitmap is no longer referenced.On Android 2.3.3 (API level 10) and lower, the backing pixel data for a bitmap is stored in native memory. It is separate from the bitmap itself, which is stored in the Dalvik heap. The pixel data in native memory is not released in a predictable manner, potentially causing an application to briefly exceed its memory limits and crash. As of Android 3.0 (API level 11), the pixel data is stored on the Dalvik heap along with the associated bitmap.在API level 8之前，gc会导致应用的UI thread暂停卡顿。Android 2.3开始加入了并行的gc。在API level 10之前，bitmap的pixel data存储在native memory，和存储在dalvik heap中的bitmap是分离的。native memory中的bitmap pixel data释放规律不可预测，会潜在导致应用oom crash。从API level 11开始，bitmap pixel data和bitmap本身一样存储在了dalvik heap中。

+ On Android 2.3.3 (API level 10) and lower, using ``recycle()`` is recommended. If you're displaying large amounts of bitmap data in your app, you're likely to run into ``OutOfMemoryError`` errors. The ``recycle()`` method allows an app to reclaim memory as soon as possible.Android 3.0 (API level 11) introduces the ``BitmapFactory.Options.inBitmap`` field. If this option is set, decode methods that take the Options object will attempt to reuse an existing bitmap when loading content. This means that the bitmap's memory is reused, resulting in improved performance, and removing both memory allocation and de-allocation. However, there are certain restrictions with how ``inBitmap`` can be used. In particular, before Android 4.4 (API level 19), only equal sized bitmaps are supported. API level 10之前推荐使用``recycle``来进行bitmap内存的释放。从API level 11开始，引入了``BitmapFactory.Options.inBitmap``选项，可以复用bitmap。

```
Set<SoftReference<Bitmap>> mReusableBitmaps;
private LruCache<String, BitmapDrawable> mMemoryCache;

// If you're running on Honeycomb or newer, create a
// synchronized HashSet of references to reusable bitmaps.
if (Utils.hasHoneycomb()) {
    mReusableBitmaps =
            Collections.synchronizedSet(new HashSet<SoftReference<Bitmap>>());
}

mMemoryCache = new LruCache<String, BitmapDrawable>(mCacheParams.memCacheSize) {

    // Notify the removed entry that is no longer being cached.
    @Override
    protected void entryRemoved(boolean evicted, String key,
            BitmapDrawable oldValue, BitmapDrawable newValue) {
        if (RecyclingBitmapDrawable.class.isInstance(oldValue)) {
            // The removed entry is a recycling drawable, so notify it
            // that it has been removed from the memory cache.
            ((RecyclingBitmapDrawable) oldValue).setIsCached(false);
        } else {
            // The removed entry is a standard BitmapDrawable.
            if (Utils.hasHoneycomb()) {
                // We're running on Honeycomb or later, so add the bitmap
                // to a SoftReference set for possible use with inBitmap later.
                mReusableBitmaps.add
                        (new SoftReference<Bitmap>(oldValue.getBitmap()));
            }
        }
    }
....
}

public static Bitmap decodeSampledBitmapFromFile(String filename,
        int reqWidth, int reqHeight, ImageCache cache) {

    final BitmapFactory.Options options = new BitmapFactory.Options();
    ...
    BitmapFactory.decodeFile(filename, options);
    ...

    // If we're running on Honeycomb or newer, try to use inBitmap.
    if (Utils.hasHoneycomb()) {
        addInBitmapOptions(options, cache);
    }
    ...
    return BitmapFactory.decodeFile(filename, options);
}

private static void addInBitmapOptions(BitmapFactory.Options options,
        ImageCache cache) {
    // inBitmap only works with mutable bitmaps, so force the decoder to
    // return mutable bitmaps.
    options.inMutable = true;

    if (cache != null) {
        // Try to find a bitmap to use for inBitmap.
        Bitmap inBitmap = cache.getBitmapFromReusableSet(options);

        if (inBitmap != null) {
            // If a suitable bitmap has been found, set it as the value of
            // inBitmap.
            options.inBitmap = inBitmap;
        }
    }
}

// This method iterates through the reusable bitmaps, looking for one 
// to use for inBitmap:
protected Bitmap getBitmapFromReusableSet(BitmapFactory.Options options) {
        Bitmap bitmap = null;

    if (mReusableBitmaps != null && !mReusableBitmaps.isEmpty()) {
        synchronized (mReusableBitmaps) {
            final Iterator<SoftReference<Bitmap>> iterator
                    = mReusableBitmaps.iterator();
            Bitmap item;

            while (iterator.hasNext()) {
                item = iterator.next().get();

                if (null != item && item.isMutable()) {
                    // Check to see it the item can be used for inBitmap.
                    if (canUseForInBitmap(item, options)) {
                        bitmap = item;

                        // Remove from reusable set so it can't be used again.
                        iterator.remove();
                        break;
                    }
                } else {
                    // Remove from the set if the reference has been cleared.
                    iterator.remove();
                }
            }
        }
    }
    return bitmap;
}

static boolean canUseForInBitmap(
        Bitmap candidate, BitmapFactory.Options targetOptions) {

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
        // From Android 4.4 (KitKat) onward we can re-use if the byte size of
        // the new bitmap is smaller than the reusable bitmap candidate
        // allocation byte count.
        int width = targetOptions.outWidth / targetOptions.inSampleSize;
        int height = targetOptions.outHeight / targetOptions.inSampleSize;
        int byteCount = width * height * getBytesPerPixel(candidate.getConfig());
        return byteCount <= candidate.getAllocationByteCount();
    }

    // On earlier versions, the dimensions must match exactly and the inSampleSize must be 1
    return candidate.getWidth() == targetOptions.outWidth
            && candidate.getHeight() == targetOptions.outHeight
            && targetOptions.inSampleSize == 1;
}

/**
 * A helper function to return the byte usage per pixel of a bitmap based on its configuration.
 */
static int getBytesPerPixel(Config config) {
    if (config == Config.ARGB_8888) {
        return 4;
    } else if (config == Config.RGB_565) {
        return 2;
    } else if (config == Config.ARGB_4444) {
        return 2;
    } else if (config == Config.ALPHA_8) {
        return 1;
    }
    return 1;
}
```

