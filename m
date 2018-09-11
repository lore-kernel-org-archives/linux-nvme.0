From: mwilck@suse.com (Martin Wilck)
Date: Tue, 11 Sep 2018 08:55:27 +0200
Subject: CPU frequency variations
In-Reply-To: <CA+1E3rLFED9UqDM2GmFMfr935KwjgpLvNauwpnHLz0nwnVrkTw@mail.gmail.com>
References: <CA+1E3rLFED9UqDM2GmFMfr935KwjgpLvNauwpnHLz0nwnVrkTw@mail.gmail.com>
Message-ID: <830fa5e6db6e7ba24a81eea4a18be8a1379b7be6.camel@suse.com>

On Tue, 2018-09-11@00:02 +0530, Joshi wrote:
> While doing some I/O polling related experiments/optimization, I felt
> the need to eliminate fluctuations (in I/O performance) caused by CPU
> frequency variations.
> 
> During benchmarks (and I mean storage ones), in order to keep running
> CPU at nearly constant high frequency, I tried
> things such as - performance governor, bios-based performance
> settings, explicit setting of sysfs cpu scaling max counters, kernel
> parameters to disable cpufreq etc.
> Some of above helped; On machines with less number of CPUs. While
> nothing seems to help on relatively heavyweight machines.
> Such as on this-  Intel Xeon E5-2690 v3 @2.6 GHz, 2 NUMA nodes, 24
> cpus each.
> 
> Often storage-benchmark seem to suffer because there are more number
> of CPUs available; Binding it to single/few CPUs help in seeing
> better
> numbers.
> 
> May I know how you deal with CPU frequency variations during
> benchmarks.

Are you certain that it's frequency variations that hurt you? Maybe
your CPUs go to deep sleep states? Have you tried e.g.
"intel_idle.max_cstate=0"?

Martin

-- 
Dr. Martin Wilck <mwilck at suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
