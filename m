From: joshiiitr@gmail.com (Joshi)
Date: Tue, 11 Sep 2018 00:02:25 +0530
Subject: CPU frequency variations
Message-ID: <CA+1E3rLFED9UqDM2GmFMfr935KwjgpLvNauwpnHLz0nwnVrkTw@mail.gmail.com>

While doing some I/O polling related experiments/optimization, I felt
the need to eliminate fluctuations (in I/O performance) caused by CPU
frequency variations.

During benchmarks (and I mean storage ones), in order to keep running
CPU at nearly constant high frequency, I tried
things such as - performance governor, bios-based performance
settings, explicit setting of sysfs cpu scaling max counters, kernel
parameters to disable cpufreq etc.
Some of above helped; On machines with less number of CPUs. While
nothing seems to help on relatively heavyweight machines.
Such as on this-  Intel Xeon E5-2690 v3 @2.6 GHz, 2 NUMA nodes, 24 cpus each.

Often storage-benchmark seem to suffer because there are more number
of CPUs available; Binding it to single/few CPUs help in seeing better
numbers.

May I know how you deal with CPU frequency variations during benchmarks.

Thanks,
-- 
Joshi
