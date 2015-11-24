From: axboe@fb.com (Jens Axboe)
Date: Tue, 24 Nov 2015 15:25:28 -0700
Subject: [PATCH 06/47] blk-mq: add a flags parameter to
 blk_mq_alloc_request
In-Reply-To: <20151124222226.GA18552@lst.de>
References: <1448037342-18384-1-git-send-email-hch@lst.de>
 <1448037342-18384-7-git-send-email-hch@lst.de> <5654D4C6.7010601@fb.com>
 <20151124222226.GA18552@lst.de>
Message-ID: <5654E3D8.3010003@fb.com>

On 11/24/2015 03:22 PM, Christoph Hellwig wrote:
> On Tue, Nov 24, 2015@02:21:10PM -0700, Jens Axboe wrote:
>> On 11/20/2015 09:35 AM, Christoph Hellwig wrote:
>>> We already have the reserved flag, and a nowait flag awkwardly encoded as
>>> a gfp_t.  Add a real flags argument to make the scheme more extensible and
>>> allow for a nicer calling convention.
>>
>> I've been reviewing these in the nvme-req.9 branch, I'll pick them out when
>> for-4.5/xx is forked off. That should happen when Linus pulls the recent
>> for-linus pull request.
>
> Ok.  It would be good to only fork off after the NVMe page size fix,
> as that is bound to create merge conflicts otherwise.
>
> While you're at it can you send "nvme: add missing unmaps in nvme_queue_rq"
> and "block: fix blk_abort_request for blk-mq drivers" from this series to
> Linus for 4.4-rc as well?

Look fine for this series. Added and for-4.5/core kicked off.

-- 
Jens Axboe
