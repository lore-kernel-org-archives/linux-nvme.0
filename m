From: axboe@fb.com (Jens Axboe)
Date: Wed, 2 Mar 2016 15:16:18 -0700
Subject: [PATCH 4/5] block: fix blk_rq_get_max_sectors for driver private
 requests
In-Reply-To: <20160302211857.GB3803@lst.de>
References: <1456938434-20387-1-git-send-email-hch@lst.de>
 <1456938434-20387-5-git-send-email-hch@lst.de>
 <20160302191705.GD27636@localhost.localdomain> <20160302211857.GB3803@lst.de>
Message-ID: <56D76632.2010301@fb.com>

On 03/02/2016 02:18 PM, Christoph Hellwig wrote:
> On Wed, Mar 02, 2016@07:17:05PM +0000, Keith Busch wrote:
>> check for the one type that does support checking chunk sectors instead:
>>
>> 	if (unlikely(rq->cmd_type != REQ_TYPE_FS))
>>
>> But it looks fine as-is, too.
>
> Yes, that's probably better in the long run.  Jens, can you fold the
> suggestion from Keith into the patch?

Too late to fold, but I fixed it separately.

-- 
Jens Axboe
