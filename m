From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 29 May 2019 10:56:18 +0200
Subject: "nosmt" breaks resuming from hibernation (was Re: [5.2-rc1
 regression]: nvme vs. hibernation)
In-Reply-To: <nycvar.YFH.7.76.1905282118070.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905241706280.1962@cbobk.fhfr.pm>
 <20190524154429.GE15192@localhost.localdomain>
 <nycvar.YFH.7.76.1905250023380.1962@cbobk.fhfr.pm>
 <92a15981-dfdc-0ac9-72ee-920555a3c1a4@oracle.com>
 <nycvar.YFH.7.76.1905271126480.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905281709130.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905282118070.1962@cbobk.fhfr.pm>
Message-ID: <20190529085618.GH2623@hirez.programming.kicks-ass.net>

On Tue, May 28, 2019@09:22:14PM +0200, Jiri Kosina wrote:
> On Tue, 28 May 2019, Jiri Kosina wrote:
> 
> > [ some x86/PM folks added ]
> > 
> > I isolated this to 'nosmt' being present in the "outer" (resuming) kernel, 
> > and am still not sure whether this is x86 issue or nvme/PCI/blk-mq issue.
> > 
> > For the newcomers to this thread: on my thinkpad x270, 'nosmt' reliably 
> > breaks resume from hibernation; after the image is read out from disk and 
> > attempt is made to jump to the old kernel, machine reboots.

> 
> Thomas figured it out (and this should be really more widespread than just 
> my machine :) ).
> 
> nosmt forces HT siblings to mwait, but that explodes after %cr3 change 
> during resume, as the mwait target address is all of a sudden not valid 
> anymore for neither of the hyperthreads.

ARGH!!! But also, you wrote:

> > I verified that it succesfully makes it to the point where restore_image()
> > is called from swsusp_arch_resume() (and verified that only BSP is alive
> > at that time), but the old kernel never comes back and triplefault-like
> > reboot happens.

which means that even without nosmt all 'other' CPUs are offline. And
when I look at resume_target_kernel() I see it call
hibernate_resume_nonboot_cpu_disable().

So how is the SMT offline different from that offline? afaict they all
get into play_dead()->native_play_dead()->mwait_play_dead().
