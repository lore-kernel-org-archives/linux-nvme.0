From: keith.busch@intel.com (Keith Busch)
Date: Tue, 19 May 2015 15:35:19 +0000 (UTC)
Subject: [PATCH 2/4] NVMe: Decouple nvmeq hctx from ns request queue
In-Reply-To: <20150519074645.GA21597@infradead.org>
References: <1431977423-31587-1-git-send-email-keith.busch@intel.com>
 <1431977423-31587-3-git-send-email-keith.busch@intel.com>
 <20150519074645.GA21597@infradead.org>
Message-ID: <alpine.LNX.2.00.1505191519450.15930@localhost.lm.intel.com>

On Tue, 19 May 2015, Christoph Hellwig wrote:
> On Mon, May 18, 2015@01:30:21PM -0600, Keith Busch wrote:
>> Preparing for namespaces to dynamically attach/detach, we can't tie
>> the nvmeq's hctx to a namespace request queue: they may be removed at
>> any time. This patch has the driver create an io request queue that
>> unaffiliated to any namespace so we always have a valid hctx for the
>> io queues.
>
> I don't think this is correct.  The better fix is to stop storing
> the (or rather a hctx) in the nvmeq.  The current code only works by
> chance as is just deferenences the tags pointer in the hctx.  So
> just add a helper to find the right struct blk_mq_tags for a queue index
> and change the driver to use that.

Agreed this isn't the ideal fix. I'm just trying to get this working
in the short term and the hctx is the most convienient thing to use
for couple reasons: it has the cpumask required for the irq affinity
hints, and the blk-mq layer takes an hctx to iterate through busy tags,
and I clearly don't want h/w IO queue tied to a dynamic namespace's
request_queue's hctx.

I'm actually not sure why every request queue has their own hardware
context. Shouldn't it be an artifact of the tagset rather than the
request queue? I thought I might have a chance of intercepting a late
4.1 rc if I didn't mess with the block layer, though.
