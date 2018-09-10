From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 10 Sep 2018 13:00:40 -0600
Subject: CPU frequency variations
In-Reply-To: <CA+1E3rLFED9UqDM2GmFMfr935KwjgpLvNauwpnHLz0nwnVrkTw@mail.gmail.com>
References: <CA+1E3rLFED9UqDM2GmFMfr935KwjgpLvNauwpnHLz0nwnVrkTw@mail.gmail.com>
Message-ID: <20180910190040.GA7867@localhost.localdomain>

On Tue, Sep 11, 2018@12:02:25AM +0530, Joshi wrote:
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
> Such as on this-  Intel Xeon E5-2690 v3 @2.6 GHz, 2 NUMA nodes, 24 cpus each.
> 
> Often storage-benchmark seem to suffer because there are more number
> of CPUs available; Binding it to single/few CPUs help in seeing better
> numbers.
> 
> May I know how you deal with CPU frequency variations during benchmarks.

Just to get all the CPU's to use the highest performing scaling
governor:

  echo performance | tee /sys/devices/system/cpu/cpufreq/policy*/scaling_governor

But it sounds like you've alraedy done that.
