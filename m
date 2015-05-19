From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 19 May 2015 09:15:45 -0700
Subject: [PATCH 2/4] NVMe: Decouple nvmeq hctx from ns request queue
In-Reply-To: <alpine.LNX.2.00.1505191544580.15930@localhost.lm.intel.com>
References: <1431977423-31587-1-git-send-email-keith.busch@intel.com>
 <1431977423-31587-3-git-send-email-keith.busch@intel.com>
 <20150519074645.GA21597@infradead.org>
 <alpine.LNX.2.00.1505191519450.15930@localhost.lm.intel.com>
 <alpine.LNX.2.00.1505191544580.15930@localhost.lm.intel.com>
Message-ID: <20150519161545.GB26772@infradead.org>

On Tue, May 19, 2015@03:51:32PM +0000, Keith Busch wrote:
> Oh no!, the blk_mq_tag_busy_iter usage is broken in the nvme driver for
> anything with more than one namespace, and broken with the implementation
> I suggested. It only invokes the callback if the hctx is assocaited with
> the same request queue. Must fix, maybe add a blk-mq api to iterate the
> tagset rather than hctx.

Yes, similar to how we pass a tag_set to blk_mq_tag_to_rq.
