From: keith.busch@intel.com (Keith Busch)
Date: Tue, 19 May 2015 15:51:32 +0000 (UTC)
Subject: [PATCH 2/4] NVMe: Decouple nvmeq hctx from ns request queue
In-Reply-To: <alpine.LNX.2.00.1505191519450.15930@localhost.lm.intel.com>
References: <1431977423-31587-1-git-send-email-keith.busch@intel.com>
 <1431977423-31587-3-git-send-email-keith.busch@intel.com>
 <20150519074645.GA21597@infradead.org>
 <alpine.LNX.2.00.1505191519450.15930@localhost.lm.intel.com>
Message-ID: <alpine.LNX.2.00.1505191544580.15930@localhost.lm.intel.com>

On Tue, 19 May 2015, Keith Busch wrote:
> <snip> and the blk-mq layer takes an hctx to iterate through busy tags

> I'm actually not sure why every request queue has their own hardware
> context. Shouldn't it be an artifact of the tagset rather than the
> request queue? I thought I might have a chance of intercepting a late
> 4.1 rc if I didn't mess with the block layer, though.

Oh no!, the blk_mq_tag_busy_iter usage is broken in the nvme driver for
anything with more than one namespace, and broken with the implementation
I suggested. It only invokes the callback if the hctx is assocaited with
the same request queue. Must fix, maybe add a blk-mq api to iterate the
tagset rather than hctx.
