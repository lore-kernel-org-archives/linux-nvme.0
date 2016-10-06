From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Oct 2016 11:34:49 +0200
Subject: [PATCH 1/2] nvme: don't schedule multiple resets
In-Reply-To: <1475699566-5284-1-git-send-email-keith.busch@intel.com>
References: <1475699566-5284-1-git-send-email-keith.busch@intel.com>
Message-ID: <20161006093449.GB4999@lst.de>

On Wed, Oct 05, 2016@04:32:45PM -0400, Keith Busch wrote:
> The queue_work only fails if the work is pending, but not yet running. If
> the work is running, the work item would get requeued, triggering a
> double reset. If the first reset fails for any reason, the second
> reset triggers:
> 
> 	WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING)
> 
> Hitting that schedules controller deletion for a second time, which
> potentially takes a reference on the device that is being deleted.
> If the reset occurs at the same time as a hot removal event, this causes
> a double-free.
> 
> This patch has the reset helper function check if the work is busy
> prior to queueing, and changes all places that schedule resets to use
> this function. Since most users don't want to sync with that work, the
> "flush_work" is moved to the only caller that wants to sync.

Looks fine.  I actually have something very similar in an old
branch, except that I also moved nvme_reset to common code
and made the fabrics drivers use it.  I'll really need to get
back to that stuff..

Reviewed-by: Christoph Hellwig <hch at lst.de>
