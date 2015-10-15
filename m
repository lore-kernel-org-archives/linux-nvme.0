From: hch@lst.de (Christoph Hellwig)
Date: Thu, 15 Oct 2015 07:27:32 +0200
Subject: [PATCH 2/8] nvme: use the block layer for userspace
 passthrough metadata
In-Reply-To: <alpine.LNX.2.00.1510142038370.27742@localhost.lm.intel.com>
References: <1444633811-28319-1-git-send-email-hch@lst.de>
 <1444633811-28319-3-git-send-email-hch@lst.de>
 <alpine.LNX.2.00.1510142038370.27742@localhost.lm.intel.com>
Message-ID: <20151015052732.GA21725@lst.de>

On Wed, Oct 14, 2015@09:19:23PM +0000, Keith Busch wrote:
> We need to set REQ_INTEGRITY in req->cmd_flags here since requests
> submitted through blk_execute_rq don't copy the bio flags.
>
>> 	}
>>
>> 	blk_execute_rq(req->q, NULL, req, 0);
>
> And need to provide the gendisk instead of NULL so the nvme_map_data()
> -> nvme_dif_remap() doesn't dereference NULL to get the namespace's PI
> type; there are other ways to get to this, but setting the disk here
> looks the simplist from: ((struct nvme_ns *)q->queuedata)->disk;
>
> Similarly, we need to set bio->bi_bdev to 'bdev_get(ns->disk, 0)' to
> fix a NULL pointer in bio_integrity_advance in the completion path.

Do you have a patch that implements all your suggestions?  I probably could
recreated it, but folding in a tested patch is way easier.
