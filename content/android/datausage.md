---
title: "DataUsage"
date: 2014-11-03 10:01
---
Android流量监控模块学习
====================
[REF](http://source.android.com/devices/tech/datausage/index.html)

Android 4.0 (Ice Cream Sandwich) introduces new features that help users understand and control how their device uses network data.  It monitors overall data usage, and supports warning or limit thresholds which will trigger notifications or disable mobile data when usage exceeds a specific quota.Android 4.0开始引入流量监控的特性。他可以监控所有的数据流量，支持警告和限制流量使用。当超过特定quota值时，会触发notification或者禁止移动网络。Data usage is also tracked on a per-application basis, enabling users to visually explore historical usage in the Settings app. Users can also restrict how specific applications are allowed to use data when running in the background.流量监控可以追追踪每个应用的历史数据。用户可以限制特定的应用在后台运行时是否可以联网。


Mobile operators typically measure data usage at the Internet layer (IP). To match this approach in Android 4.0, we rely on the fact that for the kernel devices we care about the ``rx_bytes`` and ``tx_bytes`` values returned by ``dev_get_stats()`` return exactly the Internet layer (IP) bytes transferred.  But we understand that for other devices it might not be the case. For now, the feature relies on this peculiarity. New drivers should have that property also, and the ``dev_get_stats()`` values must not include any encapsulation overhead of lower network layers (such as Ethernet headers), and should preferably not include other traffic (such as ARP) unless it is negligible.通过设备``dev_get_stats()``返回的``rx_bytes``和``tx_bytes``来统计数据流量。新加入的device应该有这样的特性，在``dev_get_stats()``中返回值不应包括底层的数据。


The Android framework only collects statistics from network interfaces associated with a ``NetworkStateTracker`` in ``ConnectivityService``. This enables the framework to concretely identify each network interface, including its type (such as ``TYPE_MOBILE`` or ``TYPE_WIFI``) and subscriber identity (such as IMSI).  All network interfaces used to route data should be represented by a ``NetworkStateTracker`` so that statistics can be accounted correctly.Android Framework从``ConnectivityService``中的``NetworkStateTracker``来为每个network interface统计数据。这样就保证了framework可以具体的分辨每个network interface，包括type和sim卡身份证等。


Tethering involves forwarding of traffic from one network interface to another using ``iptables`` forwarding rules.  The framework periodically records tethering statistics between any interface pairs returned by ``ConnectivityService.getTetheredIfacePairs()``.共享网络


Users can specify a day of month upon which their data usage resets. Internally, cycle boundaries are defined to end at midnight (00:00) UTC on the requested day. When a month is shorter than the requested day, the cycle resets on the first day of the subsequent month. For example, a cycle reset day of the 30th would cause a reset on January 30 at 00:00 UTC and March 1 at 00:00 UTC.流量重置的日期设置，一般是在设定日期的end at midnight UTC。当一个月日期不到设定日期时，从下个月1日开始重置，比如2月份没有30日，则从3月1日重新算流量。


Tags represent one of the metrics the data usage counters will be tracked against. By default, and implicitly, a tag is just based on the UID. The UID is used as the base for policing, and cannot be ignored. So a tag will always at least represent a UID (uid_tag). A tag can be explicitly augmented with an "accounting tag" which is associated with a UID. User space can use ``TrafficStats.setThreadStatsTag()`` to set the acct_tag portion of the tag which is then used  with sockets: all data belonging to that socket will be counted against the tag. The policing is then based on the tag's ``uid_tag`` portion, and stats are collected for the ``acct_tag`` portion separately.DataUsage Tag 是流量监控的一个维度，默认based on the UID。


# 流量监控主要用到的类

+ ``INetworkStatsSession``:Return network layer usage summary(historical network layer stats) for traffic that matches template.Return network layer usage summary per UID for traffic that matches template.Return historical network layer stats for specific UID traffic that matches template.

+ ``NetworkTemplate``:Template definition used to generically match ``NetworkIdentity``,usually when collecting statistics.

+ ``NetworkStatsHistory``:Collection of historical network statistics, recorded into equally-sized "buckets" in time. Internally it stores data in ``long`` series for more efficient persistence.Each bucket is defined by a ``bucketStart`` timestamp, and lasts for ``bucketDuration``. Internally assumes that ``bucketStart`` is sorted at all times.

+ ``NetworkPolicyEditor``:Utility class to modify list of ``NetworkPolicy``. Specifically knows about which policies can coexist. This editor offers thread safety when talking with ``NetworkPolicyManager``.

+ ``NetworkPolicy``:Policy for networks matching a ``NetworkTemplate``, including usage cycle and limits to be enforced.

+ ``NetworkStatsService``:Collect and persist detailed network statistics, and provide this data to other system services.

+ ``android.net.TrafficStats.UID_REMOVED``,``android.net.TrafficStats.UID_TETHERING``.

+ ``NetworkStats``:Collection of active network statistics. Can contain summary details across all interfaces, or details with per-UID granularity. Internally stores data as a large table, closely matching ``/proc/`` data format. This structure optimizes for rapid in-memory comparison, but consider using ``NetworkStatsHistory`` when persisting.所有活动网络分析的收集，包括了所有网络接口的总结细节，也可以从单个UID的粒度上来分析。在内部将这些分析数据作为一个大表存储，格式和``/proc``中的数据格式很接近，这种格式特地为内存内的比较进行了优化，持久化存储的时候可以考虑使用``NetworkStatsHistory``。前台数据，后台数据


+ [NetworkStats](https://github.com/android/platform_frameworks_base/blob/master/core/java/android/net/NetworkStats.java)

+ [NetworkStatsCollection](https://github.com/android/platform_frameworks_base/blob/master/services/java/com/android/server/net/NetworkStatsCollection.java)

+ [NetworkTemplate](https://android.googlesource.com/platform/frameworks/base.git/+/android-4.3_r3/core/java/android/net/NetworkTemplate.java)

+ NetworkStatsFactory:Creates ``NetworkStats`` instances by parsing various ``/proc/`` files as needed.


