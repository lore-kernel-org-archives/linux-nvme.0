From: jikos@kernel.org (Jiri Kosina)
Date: Tue, 28 May 2019 21:22:14 +0200 (CEST)
Subject: "nosmt" breaks resuming from hibernation (was Re: [5.2-rc1
 regression]: nvme vs. hibernation)
In-Reply-To: <nycvar.YFH.7.76.1905281709130.1962@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1905241706280.1962@cbobk.fhfr.pm>
 <20190524154429.GE15192@localhost.localdomain>
 <nycvar.YFH.7.76.1905250023380.1962@cbobk.fhfr.pm>
 <92a15981-dfdc-0ac9-72ee-920555a3c1a4@oracle.com>
 <nycvar.YFH.7.76.1905271126480.1962@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1905281709130.1962@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.1905282118070.1962@cbobk.fhfr.pm>

On Tue, 28 May 2019, Jiri Kosina wrote:

> [ some x86/PM folks added ]
> 
> I isolated this to 'nosmt' being present in the "outer" (resuming) kernel, 
> and am still not sure whether this is x86 issue or nvme/PCI/blk-mq issue.
> 
> For the newcomers to this thread: on my thinkpad x270, 'nosmt' reliably 
> breaks resume from hibernation; after the image is read out from disk and 
> attempt is made to jump to the old kernel, machine reboots.

Thomas figured it out (and this should be really more widespread than just 
my machine :) ).

nosmt forces HT siblings to mwait, but that explodes after %cr3 change 
during resume, as the mwait target address is all of a sudden not valid 
anymore for neither of the hyperthreads.

That also explains why I apparently didn't see it that regularly with 
kaslr disabled.

Nothing to do with nvme, so let's not continue coming up with proper fix 
in this thread.

Thanks,

-- 
Jiri Kosina
SUSE Labs
