From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 21 Dec 2016 01:01:28 -0800
Subject: [PATCH v3 4/5] nvme: Implement resume_from_suspend and SED
 Allocation code.
In-Reply-To: <aa3b337c-deeb-057d-1054-1443a43dbae4@eng.utah.edu>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
 <20161219215954.GB10634@localhost.localdomain>
 <20161219222311.GA2056@sbauer-Z170X-UD5>
 <20161220061744.GB4765@infradead.org>
 <20161220154916.GC10634@localhost.localdomain>
 <20161220154639.GA16393@infradead.org>
 <aa3b337c-deeb-057d-1054-1443a43dbae4@eng.utah.edu>
Message-ID: <20161221090128.GA7048@infradead.org>

On Tue, Dec 20, 2016@09:05:32AM -0700, Scott Bauer wrote:
> Thanks Keith. Although TCG Spec currently ignores it in the future it may not.
> In that case we should probably attempt to future proof it a bit. Since the
> namespace ID is accessible via the block device structure I'll find a way to
> include that in some opaque pointer that we can deliver through the core into
> NVMe.

Honestly I think this nsid issue is a major, major mess.  Without a nsid
only the global range makes sense, and in that case it does not make
sense to set a nsid (so it should be 0xFFFFFFFF).  This one more of the
major major issues because the NVMe group decided to not care about
security and outsourced it to that giant heap of crap called TCG.

I think we'll need to start a little conversation on the nvme list on
how to handle this, including potential errata.

> But this also brings up another question (and part of the reason I moved from
> the block ioctl to fs ioctl): For drives with multiple namsepaces is it 
> acceptable to allow a namespace, who has a segregated chunk of space, the ability
> to perform actions outside of its range? Since the multiple namespaces portion
> of the spec says there will be one Global LR a namespace that doesn't encompass
> the entire LBA range can end up locking other LBAs via locking the global.
> 
> That's why I wanted to go to char dev because it seemed like a better fit for 
> this scenario. Any thoughts on the above?

In SCSI we allow all kinds of ioctls affecting target-wide behavior on
the device nodes.  These needs to be protected using CAP_SYS_ADMIN,
otherwise we're going to get security issues, though (and in SCSI land
we had such issues before).
