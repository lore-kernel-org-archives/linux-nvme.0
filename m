From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 10 Feb 2016 10:46:41 -0800
Subject: [PATCH for-4.5 06/13] NVMe: Remove WQ_MEM_RECLAIM from nvme work
 queue
In-Reply-To: <1455128250-5984-7-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-7-git-send-email-keith.busch@intel.com>
Message-ID: <20160210184641.GA26933@infradead.org>

On Wed, Feb 10, 2016@11:17:23AM -0700, Keith Busch wrote:
> This isn't used for work in the memory reclaim path, and we may need
> to sync with work queues that also are not flagged memory relaim. This
> fixes a kernel warning if we ever do sync with such a work queue.

We do need it during memory reclaim: memory reclaim in general
does I/O, which can be on NVMe.  We then need the workqueue to
abort a command or reset an overloaded controller to make progress.
Not having WQ_MEM_RECLAIM risks deadlocks in heavily loaded systems.
