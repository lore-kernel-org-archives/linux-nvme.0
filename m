From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 Jan 2019 10:21:58 -0700
Subject: 2016 Changes to nvme.h
In-Reply-To: <e20019ce-6f8d-1c1c-a93c-aba61ce5cf3c@panasas.com>
References: <e20019ce-6f8d-1c1c-a93c-aba61ce5cf3c@panasas.com>
Message-ID: <20190124172158.GA9600@localhost.localdomain>

On Thu, Jan 24, 2019@04:59:58PM +0000, Wilson, Ellis wrote:
> Hi all,
> 
> I am looking for further insight into the change, which just caused some 
> issues with code I'm working with when we moved to a new kernel.  It is 
> identified on this page:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9d99a8dda154f38307d43d9c9aa504bd3703d596
> 
> In essence this pulls 90+% of the structs/enums/etc into the kernel 
> sources, and leaves only the most basic interface in nvme_uapi.h.  This 
> forces one to privately re-implement the structs/enums/etc that 
> previously existed in nvme.h, which previously was available in the 
> normal include path.  Fortunately all such data structures are described 
> clearly in the NVMe specs, but it still feels like work without much 
> reason.  This is especially the case since the author calls out that the 
> only public user of the old header file (nvme cli) already had a copy of 
> it in their sources locally, so it wouldn't break them.  This points out 
> the reliance/expectation of external users on the structs expected to be 
> passed through the uapi.
> 
> Is there rationale behind this that's not obvious to me?  Any insight is 
> appreciated.  I admit I don't live in kernel code on a daily basis so 
> it's possible I'm being naive about something -- apologies in advance if 
> that's the case.

As the spec defines new fields and user tooling wants to user them,
it is just not a good idea to rely on the kernel to own updating the
structures when the kernel has no internal need for it. It's better
for user space to control its own needs independent from the kernel's.

This could really be a user space library. I had a request to separate
nvme-cli parts into a library that included the spec structures, but I
admit I dropped the ball on that...
