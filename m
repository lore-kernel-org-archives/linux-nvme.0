From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 1 May 2016 11:08:30 -0700
Subject: [PATCH] NVMe: Fix check_flush_dependency warning
In-Reply-To: <1461793878-14732-1-git-send-email-keith.busch@intel.com>
References: <1461793878-14732-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160501180830.GB8879@infradead.org>

On Wed, Apr 27, 2016@03:51:18PM -0600, Keith Busch wrote:
> If the controller fails and is degraded after a reset, we need to kill
> off all requests queues before removing the inaccessble namespaces. This
> will prevent del_gendisk from syncing dirty data, which we can't due
> from a WQ_MEM_RECLAIM work queue.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>

Jens, any chance to get this and my state machine series in ASAP?

I have another one depending on the state machine series which will
need some changes due to this one, and having both of them in
a tree somewhere would help greatly with getting it out before the
end of the 4.7 merge window.
