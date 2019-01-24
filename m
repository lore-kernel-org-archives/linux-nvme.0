From: ellisw@panasas.com (Wilson, Ellis)
Date: Thu, 24 Jan 2019 16:59:58 +0000
Subject: 2016 Changes to nvme.h
Message-ID: <e20019ce-6f8d-1c1c-a93c-aba61ce5cf3c@panasas.com>

Hi all,

I am looking for further insight into the change, which just caused some 
issues with code I'm working with when we moved to a new kernel.  It is 
identified on this page:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9d99a8dda154f38307d43d9c9aa504bd3703d596

In essence this pulls 90+% of the structs/enums/etc into the kernel 
sources, and leaves only the most basic interface in nvme_uapi.h.  This 
forces one to privately re-implement the structs/enums/etc that 
previously existed in nvme.h, which previously was available in the 
normal include path.  Fortunately all such data structures are described 
clearly in the NVMe specs, but it still feels like work without much 
reason.  This is especially the case since the author calls out that the 
only public user of the old header file (nvme cli) already had a copy of 
it in their sources locally, so it wouldn't break them.  This points out 
the reliance/expectation of external users on the structs expected to be 
passed through the uapi.

Is there rationale behind this that's not obvious to me?  Any insight is 
appreciated.  I admit I don't live in kernel code on a daily basis so 
it's possible I'm being naive about something -- apologies in advance if 
that's the case.

Thanks!

ellis
