From: jikos@kernel.org (Jiri Kosina)
Date: Wed, 29 May 2019 11:20:40 +0200 (CEST)
Subject: "nosmt" breaks resuming from hibernation (was Re: [5.2-rc1
 regression]: nvme vs. hibernation)
In-Reply-To: <20190529085618.GH2623@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.1905241706280.1962@cbobk.fhfr.pm>
 <20190524154429.GE15192@localhost.localdomain>
 <nycvar.YFH.7.76.1905250023380.1962@cbobk.fhfr.pm>
 <92a15981-dfdc-0ac9-72ee-920555a3c1a4@oracle.com>
 <nycvar.YFH.7.76.1905271126480.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905281709130.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905282118070.1962@cbobk.fhfr.pm>
 <20190529085618.GH2623@hirez.programming.kicks-ass.net>
Message-ID: <nycvar.YFH.7.76.1905291118100.1962@cbobk.fhfr.pm>

On Wed, 29 May 2019, Peter Zijlstra wrote:

> > > I verified that it succesfully makes it to the point where restore_image()
> > > is called from swsusp_arch_resume() (and verified that only BSP is alive
> > > at that time), but the old kernel never comes back and triplefault-like
> > > reboot happens.
> 
> which means that even without nosmt all 'other' CPUs are offline. And
> when I look at resume_target_kernel() I see it call
> hibernate_resume_nonboot_cpu_disable().
> 
> So how is the SMT offline different from that offline? afaict they all 
> get into play_dead()->native_play_dead()->mwait_play_dead().

There is no way those other CPUs have been offlined before to the 
native_play_dead() state, as this is way before any userspace was alive to 
initiate any kind of hotplug.

So they are guaranteed to have been all online, and then offlined properly 
to resume_play_dead(). 'nosmt' is the only exception there, as it's the 
only kind of offlining that has already happened at this point.

Let's continue in the other thread.

Thanks,

-- 
Jiri Kosina
SUSE Labs
