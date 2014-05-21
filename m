From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 21 May 2014 19:17:06 -0400
Subject: [PATCH] NVMe: Remove superfluous cqe_seen
In-Reply-To: <537CED01.6040106@micron.com>
References: <537CED01.6040106@micron.com>
Message-ID: <20140521231706.GP6121@linux.intel.com>

On Wed, May 21, 2014@11:14:25AM -0700, Sam Bradshaw wrote:
> cqe_seen is redundant with the return value from nvme_process_cq().
> Remove it.

Ah, but it isn't.  Look at commit e9539f47525.  The purpose of cqe_seen
is to be 'sticky', that we *have* indeed processed something on this CQ
since the last interrupt, and so if we get an interrupt, the device may
have legitimately interrupted us.

A more interesting patch might be to implement some kind of autotuning of
the interrupt coalescing -- if we're seeing too many times tha the queue
has no work on it, then we should increase the time or queue depth used.
I'm not sure what event would cause us to *reduce* the time or queue
depth, so I fear we'd end up set to a suboptimal value over time.

You could argue that the return value from nvme_process_cq() is now
never used, and that would be correct, but I have a patch in the works
that will use it again, so I don't think it's worth taking out.

Was there a performance problem that this solves, or did you just notice
it, and send a cleanup?
