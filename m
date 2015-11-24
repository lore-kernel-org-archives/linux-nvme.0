From: hch@lst.de (Christoph Hellwig)
Date: Tue, 24 Nov 2015 23:22:26 +0100
Subject: [PATCH 06/47] blk-mq: add a flags parameter to
 blk_mq_alloc_request
In-Reply-To: <5654D4C6.7010601@fb.com>
References: <1448037342-18384-1-git-send-email-hch@lst.de>
 <1448037342-18384-7-git-send-email-hch@lst.de> <5654D4C6.7010601@fb.com>
Message-ID: <20151124222226.GA18552@lst.de>

On Tue, Nov 24, 2015@02:21:10PM -0700, Jens Axboe wrote:
> On 11/20/2015 09:35 AM, Christoph Hellwig wrote:
>> We already have the reserved flag, and a nowait flag awkwardly encoded as
>> a gfp_t.  Add a real flags argument to make the scheme more extensible and
>> allow for a nicer calling convention.
>
> I've been reviewing these in the nvme-req.9 branch, I'll pick them out when 
> for-4.5/xx is forked off. That should happen when Linus pulls the recent 
> for-linus pull request.

Ok.  It would be good to only fork off after the NVMe page size fix,
as that is bound to create merge conflicts otherwise.

While you're at it can you send "nvme: add missing unmaps in nvme_queue_rq"
and "block: fix blk_abort_request for blk-mq drivers" from this series to
Linus for 4.4-rc as well?

>>   create mode 100644 drivers/nvme/host/core.c
>
> that should obviously not be there.

Yeah, Jeff already pointed that out.  I'll fix it for the next resend.
