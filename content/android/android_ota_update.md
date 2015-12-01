---
title: "Android OTA Update"
date: 2015-11-30 09:50
---
###Android OTA Update###

+ [ref](https://source.android.com/devices/tech/ota/index.html)

+ Devices have a special recovery partition with the software needed to unpack a downloaded update package and apply it to the rest of the system.
+ OTA updates are designed to upgrade the underlying operating system and the read-only apps installed on the system partition; these updates do not affect applications installed by the user from Google Play.
+ The flash space on an Android device typically contains the following partitions.
  + ``boot``,Contains the Linux kernel and a minimal root filesystem (loaded into a RAM disk). It mounts system and other partitions and starts the runtime located on the system partition.
  + ``system``,Contains system applications and libraries that have source code available on Android Open Source Project (AOSP). During normal operation, this partition is mounted read-only; its contents change only during an OTA update.
  + ``vendor``,Contains system applications and libraries that do not have source code available on Android Open Source Project (AOSP). During normal operation, this partition is mounted read-only; its contents change only during an OTA update.
  + ``userdata``,Stores the data saved by applications installed by the user, etc. This partition is not normally touched by the OTA update process.
  + ``cache``,Temporary holding area used by a few applications (accessing this partition requires special app permissions) and for storage of downloaded OTA update packages. Other programs use this space with the expectation that files can disappear at any time. Some OTA package installations may result in this partition being wiped completely.
  + ``recovery``,Contains a second complete Linux system, including a kernel and the special recovery binary that reads a package and uses its contents to update the other partitions.
  + ``misc``,Tiny partition used by recovery to stash some information away about what it's doing in case the device is restarted while the OTA package is being applied.

+ Life of an OTA update
  + Device performs regular check in with OTA servers and is notified of the availability of an update, including the URL of the update package and a description string to show the user.
  + Update downloads to a cache or data partition, and its cryptographic signature is verified against the certificates in ``/system/etc/security/otacerts.zip``. User is prompted to install the update.
  + Device reboots into **recovery mode**, in which the kernel and system in the recovery partition are booted instead of the kernel in the boot partition.
  + Recovery binary is started by ``init``. It finds command-line arguments in ``/cache/recovery/command`` that point it to the downloaded package.
  + Recovery verifies the cryptographic signature of the package against the public keys in ``/res/keys`` (part of the RAM disk contained in the recovery partition).
  + Data is pulled from the package and used to update the ``boot``, ``system``, and/or ``vendor`` partitions as necessary. One of the new files left on the ``system`` partition contains the contents of the new recovery partition.
  + Device reboots normally.(a)The newly updated boot partition is loaded, and it mounts and starts executing binaries in the newly updated system partition.(b)As part of normal startup, the system checks the contents of the recovery partition against the desired contents (which were previously stored as a file in /system). They are different, so the recovery partition is reflashed with the desired contents. (On subsequent boots, the recovery partition already contains the new contents, so no reflash is necessary.)

+ The ``ota_from_target_files`` tool provided in ``build/tools/releasetools`` can build two types of package: ``full`` and ``incremental``. The tool takes the ``target-files`` ``.zip`` file produced by the Android build system as input.
+ A full update is one where the entire final state of the device (system, boot, and recovery partitions) is contained in the package. As long as the device is capable of receiving the package and booting the recovery system, the package can install the desired build regardless of the current state of the device.

```bash
# first, build the target-files .zip
% . build/envsetup.sh && lunch tardis-eng
% mkdir dist_output
% make dist DIST_DIR=dist_output
  [...]
% ls -l dist_output/*target_files*
-rw-r----- 1 user eng  69965275 Sep 29 15:51 tardis-target_files.zip
# The target-files .zip contains everything needed to construct OTA packages.
% ./build/tools/releasetools/ota_from_target_files \
    dist_output/tardis-target_files.zip ota_update.zip
unzipping target target-files...
done.
% ls -l ota_update.zip
-rw-r----- 1 user eng 62236561 Sep 29 15:58 ota_update.zip
```

+ An incremental update contains a set of binary patches to be applied to the data already on the device. This can result in considerably smaller update packages:(a)Files that have not changed don't need to be included.(b)Files that have changed are often very similar to their previous versions, so the package need only contain an encoding of the differences between the two files.You can install the incremental update package only on a device that has the old or source build used when constructing the package. To build an incremental update, you need the target_files .zip from the previous build (the one you want to update from) as well as the target_files .zip from the new build.

```bash
% ./build/tools/releasetools/ota_from_target_files \
    -i PREVIOUS-tardis-target_files.zip \  # make incremental from this older version
    dist_output/tardis-target_files.zip incremental_ota_update.zip
unzipping target target-files...
unzipping source target-files...
   [...]
done.
% ls -l incremental_ota_update.zip
-rw-r----- 1 user eng 1175314 Sep 29 16:10 incremental_ota_update.zip
#To generate a block-based OTA for subsequent updates, pass the --block option to ota_from_target_files.
```

+ An update package (``ota_update.zip``, ``incremental_ota_update.zip``) is a ``.zip`` file that contains the executable binary ``META-INF/com/google/android/update-binary``. After verifying the signature on the package, recovery extracts this binary to ``/tmp`` and runs it, passing the following arguments:
  + Update binary API version number. If the arguments passed to the update binary change, this number is incremented.
  + File descriptor of the command pipe. The update program can use this pipe to send commands back to the recovery binary (mostly for UI changes such as indicating progress to the user).
  + Filename of the update package .zip file.
A recovery package can use any statically-linked binary as the update binary. The OTA package construction tools use the updater program (source in bootable/recovery/updater), which provides a simple scripting language that can do many installation tasks. You can substitute any other binary running on the device.

+ Android 5.0 and later versions use ``block OTA`` updates to ensure that each device uses the exact same partition. Instead of comparing individual files and computing binary patches, ``block OTA`` handles the entire partition as one file and computes a single binary patch, ensuring the resultant partition contains exactly the intended bits. This allows the device system image to achieve the same state via ``fastboot`` or OTA.Android 4.4 and earlier versions used ``file OTA`` updates, which ensured devices contained similar ``file contents, permissions, and modes``, but allowed metadata such as timestamps and the layout of the underlying storage to vary between devices based on the update method.
+ Because ``block OTA`` ensures that each device uses the same partition, it enables the use of ``dm-verity`` to cryptographically sign the system partition.

+ During a file-based OTA, Android attempts to change the contents of the system partition at the filesystem layer (on a file-by-file basis). The update is not guaranteed to write files in a consistent order, have a consistent last modified time or superblock, or even place the blocks in the same location on the block device. For this reason, file-based OTAs fail on a dm-verity-enabled device; after the OTA attempt, the device does not boot.During a block-based OTA, Android serves the device the difference between the two block images (rather than two sets of files). The update checks a device build against the corresponding build server at the block level (below the filesystem) using one of the following methods:
  + ``Full update``. Copying the full system image is simple and makes patch generation easy but also generates large images that can make applying patches expensive.
  + ``Incremental update``. Using a binary differ tool generates smaller images and makes patch application easy, but is memory-intensive when generating the patch itself.

``adb fastboot`` places the exact same bits on the device as a ``full OTA``, so flashing is compatible with ``block OTA``.

+ In general, ``incremental block OTA`` updates are larger than ``incremental file OTA`` updates due to:
  + Data preservation. Block-based OTAs preserve more data (``file metadata``, ``dm-verity data``, ``ext4 layout``, etc.) than file-based OTA.
  + Computation algorithm differences. In a ``file OTA update``, if a file path is identical in both builds, the OTA package contains no data for that file. In a ``block OTA update``, determining little or no change in a file depends on the quality of the patch computation algorithm and layout of file data in both source and target system.

If a file is corrupted, a file OTA succeeds as long as it doesn't touch the corrupted file, but a block OTA fails if it detects any corruption on the system partition.

The system builds the **updater binary** from ``bootable/recovery/updater`` and uses it in an OTA package.The package itself is a ``.zip`` file (``ota_update.zip``, ``incremental_ota_update.zip``) that contains the executable binary ``META-INF/com/google/android/update-binary``.Updater contains several builtin functions and an interpreter for an extensible scripting language (edify) that supports commands for typical update-related tasks. Updater looks in the package .zip file for a script in the file ``META-INF/com/google/android/updater-script``.Using the edify script and/or builtin functions is not a common activity, but can be helpful if you need to debug the update file.

An edify script is a single expression in which all values are strings. Empty strings are **false** in a Boolean context and all other strings are **true**. Edify supports the following operators (with the usual meanings):

```bash
(expr )
 expr + expr  # string concatenation, not integer addition
 expr == expr
 expr != expr
 expr && expr
 expr || expr
 ! expr
 if expr then expr endif
 if expr then expr else expr endif
 function_name(expr, expr,...)
 expr; expr
```

+ The recovery system includes several hooks for inserting device-specific code so that OTA updates can also update parts of the device other than the Android system (e.g., the baseband or radio processor).The partition map file is specified by ``TARGET_RECOVERY_FSTAB``; this file is used by both the recovery binary and the package-building tools. You can specify the name of the map file in ``TARGET_RECOVERY_FSTAB`` in ``BoardConfig.mk``.

A sample partition map file might look like this:

```bash
device/yoyodyne/tardis/recovery.fstab
# mount point       fstype  device       [device2]        [options (3.0+ only)]

/sdcard     vfat    /dev/block/mmcblk0p1 /dev/block/mmcblk0
/cache      yaffs2  cache
/misc       mtd misc
/boot       mtd boot
/recovery   emmc    /dev/block/platform/s3c-sdhci.0/by-name/recovery
/system     ext4    /dev/block/platform/s3c-sdhci.0/by-name/system length=-4096
/data       ext4    /dev/block/platform/s3c-sdhci.0/by-name/userdata
```

There are five supported filesystem types:``yaffs2``,``mtd``,``ext4``,``emmc``,``vfat``.

Starting in Android 3.0, the ``recovery.fstab`` file gains an additional optional field, options. Currently the only defined option is length , which lets you explicitly specify the length of the partition. This length is used when reformatting the partition (e.g., for the userdata partition during a data wipe/factory reset operation, or for the system partition during installation of a full OTA package). If the length value is negative, then the size to format is taken by adding the length value to the true partition size. For instance, setting "length=-16384" means the last 16k of that partition will not be overwritten when that partition is reformatted. This supports features such as encryption of the userdata partition (where encryption metadata is stored at the end of the partition that should not be overwritten).

+ Android OS images use cryptographic signatures in two places:

  + Each ``.apk`` file inside the image must be signed. Android's Package Manager uses an ``.apk`` signature in two ways:
    + When an application is replaced, it must be signed by the same key as the old application in order to get access to the old application's data. This holds true both for updating user apps by overwriting the ``.apk``, and for overriding a system app with a newer version installed under ``/data``.
    + If two or more applications want to share a user ID (so they can share data, etc.), they must be signed with the same key.
  + OTA update packages must be signed with one of the keys expected by the system or the installation process will reject them.

+ To generate your own unique set of release-keys, run these commands from the root of your Android tree:

```bash
#$subject should be changed to reflect your organization's information.
subject='/C=US/ST=California/L=Mountain View/O=Android/OU=Android/CN=Android/emailAddress=android@android.com'
mkdir ~/.android-certs
for x in releasekey platform shared media; do \
    ./development/tools/make_key ~/.android-certs/$x "$subject"; \
done
```

+ To generate a release image, use:

```bash
make dist
./build/tools/releasetools/sign_target_files_apks \
    -o \    # explained in the next section
    -d ~/.android-certs out/dist/*-target_files-*.zip \
    signed-target_files.zip
```

The ``sign_target_files_apks`` script takes a ``target-files .zip`` as input and produces a new ``target-files .zip`` in which all the .apks have been signed with new keys. The newly signed images can be found under ``IMAGES/`` in ``signed-target_files.zip``.

+ A signed target-files zip can be converted into a signed OTA update zip using the following procedure:

```bash
./build/tools/releasetools/ota_from_target_files \
    -k ~/.android-certs/releasekey \
    signed-target_files.zip \
    signed-ota_update.zip
```

+ Update packages received from the main system are typically verified twice: once by the main system, using the ``RecoverySystem.verifyPackage()`` method in the android API, and then again by recovery. The RecoverySystem API checks the signature against public keys stored in the main system, in the file ``/system/etc/security/otacerts.zip`` (by default). Recovery checks the signature against public keys stored in the recovery partition RAM disk, in the file ``/res/keys``.

+ Each key comes in two files: the **certificate**, which has the extension **.x509.pem**, and the **private key**, which has the extension **.pk8**. The private key should be kept secret and is needed to sign a package. The key may itself be protected by a password. The certificate, in contrast, contains only the public half of the key, so it can be distributed widely. It is used to verify a package has been signed by the corresponding private key.
The standard Android build uses four keys, all of which reside in build/target/product/security:
  + ``testkey``:Generic default key for packages that do not otherwise specify a key.
  + ``platform``:Test key for packages that are part of the core platform.
  + ``shared``:Test key for things that are shared in the home/contacts process.
  + ``media``:Test key for packages that are part of the media/download system.
Individual packages specify one of these keys by setting ``LOCAL_CERTIFICATE`` in their ``Android.mk`` file. (testkey is used if this variable is not set.) You can also specify an entirely different key by pathname, e.g.:

```bash
#device/yoyodyne/apps/SpecialApp/Android.mk
 [...]

LOCAL_CERTIFICATE := device/yoyodyne/security/special
#Now the build uses the device/yoyodyne/security/special.{x509.pem,pk8} key to sign SpecialApp.apk. The build can use only private keys that are not password protected.
```

+ Android uses 2048-bit RSA keys with public exponent 3. You can generate certificate/private key pairs using the openssl tool from openssl.org:

```bash
# generate RSA key
% openssl genrsa -3 -out temp.pem 2048
Generating RSA private key, 2048 bit long modulus
....+++
.....................+++
e is 3 (0x3)

# create a certificate with the public part of the key
% openssl req -new -x509 -key temp.pem -out releasekey.x509.pem \
  -days 10000 \
  -subj '/C=US/ST=California/L=San Narciso/O=Yoyodyne, Inc./OU=Yoyodyne Mobility/CN=Yoyodyne/emailAddress=yoyodyne@example.com'

# create a PKCS#8-formatted version of the private key
% openssl pkcs8 -in temp.pem -topk8 -outform DER -out releasekey.pk8 -nocrypt

# securely delete the temp.pem file
% shred --remove temp.pem
```

The openssl pkcs8 command given above creates a ``.pk8`` file with no password, suitable for use with the build system. To create a ``.pk8`` secured with a password (which you should do for all actual release keys), replace the ``-nocrypt`` argument with ``-passout stdin``; then openssl will encrypt the private key with a password read from standard input.

+ Once you have signed-target-files.zip, you need to create the image so you can put it onto a device. To create the signed image from the target files, run the following command from the root of the Android tree:

```bash
./build/tools/releasetools/img_from_target_files signed-target-files.zip signed-img.zip
```

The resulting file, ``signed-img.zip``, contains all the ``.img`` files. To load an image onto a device, use fastboot as follows:``fastboot update signed-img.zip``.
