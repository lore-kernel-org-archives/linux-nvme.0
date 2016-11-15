From: axboe@fb.com (Jens Axboe)
Date: Mon, 14 Nov 2016 20:54:56 -0700
Subject: [PATCH] blk-mq drivers: untangle 0 and BLK_MQ_RQ_QUEUE_OK
In-Reply-To: <6ac81fdd561e008fec1f31e9a4530358737389a6.1479167141.git.osandov@fb.com>
References: <6ac81fdd561e008fec1f31e9a4530358737389a6.1479167141.git.osandov@fb.com>
Message-ID: <f9b19a2b-6424-d8c7-d243-113af2b5fde5@fb.com>

On 11/14/2016 04:49 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov at fb.com>
>
> Let's not depend on any of the BLK_MQ_RQ_QUEUE_* constants having
> specific values. No functional change.
>
> Signed-off-by: Omar Sandoval <osandov at fb.com>
> ---
> Hi, Jens,
>
> Some more trivial cleanup, feel free to apply or not if it's too intrusive.

I think we should clean it up. But you should split this patch in two -
one for NVMe, and one for SCSI.

And it should be against for-4.10/block, the nvme parts don't apply
without fuzz.

-- 
Jens Axboe
