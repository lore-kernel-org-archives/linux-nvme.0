From: wisha.wa@yandex.com (Wisha Wa)
Date: Sat, 09 Feb 2019 23:28:50 +0700
Subject: APST problem on WDC WDS256G1X0C-00ENX0
Message-ID: <3494641549729730@myt5-9da6df248f4a.qloud-c.yandex.net>

Hi all

I use WDC WDS256G1X0C-00ENX0 NVMe SSD and noticed that it has problems.
With APST enabled, the device can run very hot to the point of automatic shutdown.

I tried changing nvme_core.default_ps_max_latency_us to determine the problematic state

ps ? ?0 : mp:8.25W operational enlat:0 exlat:0 rrt:0 rrl:0
? ? ? ? ?rwt:0 rwl:0 idle_power:0.02W active_power:5.02W
ps ? ?1 : mp:8.25W operational enlat:0 exlat:0 rrt:1 rrl:1
? ? ? ? ?rwt:1 rwl:1 idle_power:0.02W active_power:3.02W
ps ? ?2 : mp:8.25W operational enlat:0 exlat:0 rrt:2 rrl:2
? ? ? ? ?rwt:2 rwl:2 idle_power:0.02W active_power:3.02W
ps ? ?3 : mp:0.0500W non-operational enlat:51000 exlat:10000 rrt:0 rrl:0
? ? ? ? ?rwt:0 rwl:0 idle_power:- active_power:-
ps ? ?4 : mp:0.0055W non-operational enlat:1000000 exlat:100000 rrt:0 rrl:0
? ? ? ? ?rwt:0 rwl:0 idle_power:- active_power:-

default_ps_max_latency_us=0       :APST off: device works fine
default_ps_max_latency_us=9000    (<ps3 exlat): ps3 and ps4 disabled: device runs very hot.
default_ps_max_latency_us=90000   (<ps4 exlat): ps4 disabled: device runs very hot at boot, but cools down when idle.
default_ps_max_latency_us=200000  (>ps4 exlat): all states enabled: device runs very hot at boot, but cools down when idle.

Is there a way to specifically disable ps1 or ps2?
If not, should a patch be submitted to add this device to the quirk list?

device information:
vid       : 0x15b7
ssvid     : 0x1b4b
mn        : WDC WDS256G1X0C-00ENX0                  
fr        : B35500WD

I am new to this, if this is the wrong place to ask, please point me to the right one.
