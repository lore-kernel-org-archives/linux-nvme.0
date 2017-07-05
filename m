From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Jul 2017 00:56:32 +0200
Subject: [PATCH 8/8] xen-blockfront: quiesce IO before device removal
In-Reply-To: <77cea68f-7915-2bbf-0861-05d1ca389e6c@grimberg.me>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
 <1499154912-10420-9-git-send-email-sagi@grimberg.me>
 <20170704221908.GA3732@ming.t460p>
 <77cea68f-7915-2bbf-0861-05d1ca389e6c@grimberg.me>
Message-ID: <20170705225632.GB11849@lst.de>

On Wed, Jul 05, 2017@09:29:26AM +0300, Sagi Grimberg wrote:
>
>
>> Looks the above change isn't needed since this blk_mq_start_stopped_hw_queues()
>> should have been the counterpart of blk_mq_stop_hw_queue() in
>> blkif_queue_rq().
>
> Removed the patch altogether in v2 as I'm not convinced it is needed.

I've only started reading the series, but to me it seems like the
two places where xen-blkfront currently calls blk_mq_stop_hw_queues
should probably converted, as they are the same category as the other
calls converted in your series.
