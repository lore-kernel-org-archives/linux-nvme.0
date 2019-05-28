From: jikos@kernel.org (Jiri Kosina)
Date: Tue, 28 May 2019 17:21:56 +0200 (CEST)
Subject: "nosmt" breaks resuming from hibernation (was Re: [5.2-rc1
 regression]: nvme vs. hibernation)
In-Reply-To: <nycvar.YFH.7.76.1905271126480.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905241706280.1962@cbobk.fhfr.pm>
 <20190524154429.GE15192@localhost.localdomain>
 <nycvar.YFH.7.76.1905250023380.1962@cbobk.fhfr.pm>
 <92a15981-dfdc-0ac9-72ee-920555a3c1a4@oracle.com>
 <nycvar.YFH.7.76.1905271126480.1962@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1905281709130.1962@cbobk.fhfr.pm>

On Mon, 27 May 2019, Jiri Kosina wrote:

> > Looks this has been discussed in the past.
> > 
> > http://lists.infradead.org/pipermail/linux-nvme/2019-April/023234.html
> > 
> > I created a fix for a case but not good enough.
> > 
> > http://lists.infradead.org/pipermail/linux-nvme/2019-April/023277.html
> 
> That removes the warning, but I still seem to have ~1:1 chance of reboot 
> (triple fault?) immediately after hibernation image is read from disk. 

[ some x86/PM folks added ]

I isolated this to 'nosmt' being present in the "outer" (resuming) kernel, 
and am still not sure whether this is x86 issue or nvme/PCI/blk-mq issue.

For the newcomers to this thread: on my thinkpad x270, 'nosmt' reliably 
breaks resume from hibernation; after the image is read out from disk and 
attempt is made to jump to the old kernel, machine reboots.

I verified that it succesfully makes it to the point where restore_image() 
is called from swsusp_arch_resume() (and verified that only BSP is alive 
at that time), but the old kernel never comes back and triplefault-like 
reboot happens.

It's sufficient to remove "nosmt" from the *resuming* kernel, and that 
makes the issue go away (and we resume to the old kernel that has SMT 
correctly disabled). So it has something to do with enabling & disabling 
the siblings before we do the CR3 dance and jump to the old kernel.

I haven't yet been able to isolate this to being (or not being) relevant 
to the pending nvme CQS warning above.

Any ideas how to debug this welcome. I haven't been able to reproduce it 
in a VM, so it's either something specific to that machine in general, or 
to nvme specifically.

Dongli Zhang, could you please try hibernation with "nosmt" on the system 
where you originally saw the initial pending CQS warning? Are you by any 
chance seeing the issue as well?

Thanks,

-- 
Jiri Kosina
SUSE Labs
