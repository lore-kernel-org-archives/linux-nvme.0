From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 19 May 2015 00:46:45 -0700
Subject: [PATCH 2/4] NVMe: Decouple nvmeq hctx from ns request queue
In-Reply-To: <1431977423-31587-3-git-send-email-keith.busch@intel.com>
References: <1431977423-31587-1-git-send-email-keith.busch@intel.com>
 <1431977423-31587-3-git-send-email-keith.busch@intel.com>
Message-ID: <20150519074645.GA21597@infradead.org>

On Mon, May 18, 2015@01:30:21PM -0600, Keith Busch wrote:
> Preparing for namespaces to dynamically attach/detach, we can't tie
> the nvmeq's hctx to a namespace request queue: they may be removed at
> any time. This patch has the driver create an io request queue that
> unaffiliated to any namespace so we always have a valid hctx for the
> io queues.

I don't think this is correct.  The better fix is to stop storing
the (or rather a hctx) in the nvmeq.  The current code only works by
chance as is just deferenences the tags pointer in the hctx.  So
just add a helper to find the right struct blk_mq_tags for a queue index
and change the driver to use that.
