From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Feb 2016 14:52:14 +0000
Subject: [PATCH for-4.5 06/13] NVMe: Remove WQ_MEM_RECLAIM from nvme
 work queue
In-Reply-To: <20160210184641.GA26933@infradead.org>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-7-git-send-email-keith.busch@intel.com>
 <20160210184641.GA26933@infradead.org>
Message-ID: <20160211145214.GA11908@localhost.localdomain>

On Wed, Feb 10, 2016@10:46:41AM -0800, Christoph Hellwig wrote:
> On Wed, Feb 10, 2016@11:17:23AM -0700, Keith Busch wrote:
> > This isn't used for work in the memory reclaim path, and we may need
> > to sync with work queues that also are not flagged memory relaim. This
> > fixes a kernel warning if we ever do sync with such a work queue.
> 
> We do need it during memory reclaim: memory reclaim in general
> does I/O, which can be on NVMe.  We then need the workqueue to
> abort a command or reset an overloaded controller to make progress.
> Not having WQ_MEM_RECLAIM risks deadlocks in heavily loaded systems.

There was a more obvious way to do this that took me another day to
see. We schedule remove_work on the system work queue, and all this
cleanup can happen there instead of in the reset_work on the nvme
work queue.

I will drop the unneeded patches from this series, and resubmit the rest
with the reviews, fixes, and recommended code changes and documentation.
