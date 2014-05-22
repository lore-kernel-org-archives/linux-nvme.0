From: sbradshaw@micron.com (Sam Bradshaw (sbradshaw))
Date: Thu, 22 May 2014 00:10:19 +0000
Subject: [PATCH] NVMe: Remove superfluous cqe_seen
In-Reply-To: <20140521231706.GP6121@linux.intel.com>
References: <537CED01.6040106@micron.com>
 <20140521231706.GP6121@linux.intel.com>
Message-ID: <80B89753B40C5141A3E2D53FE7A2A8A9943A7ADC@NTXBOIMBX02.micron.com>



> -----Original Message-----
> From: Matthew Wilcox [mailto:willy at linux.intel.com]
> Sent: Wednesday, May 21, 2014 4:17 PM
> To: Sam Bradshaw (sbradshaw)
> Cc: linux-nvme at lists.infradead.org
> Subject: Re: [PATCH] NVMe: Remove superfluous cqe_seen
> 
> On Wed, May 21, 2014@11:14:25AM -0700, Sam Bradshaw wrote:
> > cqe_seen is redundant with the return value from nvme_process_cq().
> > Remove it.
> 
> Ah, but it isn't.  Look at commit e9539f47525.  The purpose of cqe_seen
> is to be 'sticky', that we *have* indeed processed something on this CQ
> since the last interrupt, and so if we get an interrupt, the device may
> have legitimately interrupted us.
> 
> A more interesting patch might be to implement some kind of autotuning
> of
> the interrupt coalescing -- if we're seeing too many times tha the
> queue
> has no work on it, then we should increase the time or queue depth
> used.
> I'm not sure what event would cause us to *reduce* the time or queue
> depth, so I fear we'd end up set to a suboptimal value over time.
> 
> You could argue that the return value from nvme_process_cq() is now
> never used, and that would be correct, but I have a patch in the works
> that will use it again, so I don't think it's worth taking out.
> 
> Was there a performance problem that this solves, or did you just
> notice
> it, and send a cleanup?

Performance problem, though not very easily measured.  At very high iops
rates, most if not all cqe's are processed via nvme_process_cq() in 
make_request(), leaving nvme_irq() with no work to do.  Nevertheless, it
always writes cqe_seen, which invalidates a very hot cacheline.  This
is somewhat exacerbated when IO submissions originate on a remote node
relative to the cpu handling the irq.

Perhaps a simpler patch where cqe_seen is only written if set? 

-Sam
