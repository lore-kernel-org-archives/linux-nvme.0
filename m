From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 30 Dec 2015 10:18:04 -0800
Subject: [PATCH 2/5] NVMe: Use a retryable error code on reset
In-Reply-To: <20151230180908.GB12454@localhost.localdomain>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-3-git-send-email-keith.busch@intel.com>
 <20151230175232.GC21400@infradead.org>
 <20151230180908.GB12454@localhost.localdomain>
Message-ID: <20151230181804.GA6359@infradead.org>

On Wed, Dec 30, 2015@06:09:08PM +0000, Keith Busch wrote:
> > I thought I only added this to make you happy, so I'm fine with
> > changing it.
> > 
> > But I don't understand why NVME_SC_CANCELLED isn't retryable,
> > nvme_req_needs_retry doesn't treat negative error codes special.
> > If it did we'd need to fix it as we want to be able to rety
> > the other cases where it is returned as well.
> 
> nvme_req_needs_retry checks NVME status bit "DNR", which happens to be
> set with a negative return code.

Uh-oh.  I had specificly written a little test case to check if
DNR works with a signed value, and it did.  But I forgot to do the
negative check.

This means I need to revisit this scheme entirely as NVME_SC_CANCELLED
should not imply a DNR in general.

> Yeah, a timed out command isn't retryable here. The check is to allow
> requeuing when a controller reset occured for reasons other than
> a timeout.

Generally we want to be able to retry after a timeout, so both
this and the above issue need to be fixed.

> A long time ago, we had total command lifetime timeout value just to
> allow timed out commands to requeue after a reset, but that was removed
> with the blk-mq conversion. I didn't think it was a big deal, though. The
> amount of time it takes to trigger a reset is 60 seconds by default, so
> that's a heck of a long time to wait just to requeue the IO. Some users
> I spoke with prefered to just fail the command sooner, so I didn't make
> any attempt to change this behavior.

For SCSI we have a separate error handlind deadline fo that. 
