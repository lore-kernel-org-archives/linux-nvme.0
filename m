From: axboe@fb.com (Jens Axboe)
Date: Tue, 15 Mar 2016 15:13:26 -0700
Subject: blk-mq merge flags
In-Reply-To: <20160315160833.GA21474@infradead.org>
References: <1456938434-20387-1-git-send-email-hch@lst.de>
 <1456938434-20387-2-git-send-email-hch@lst.de>
 <56D7247C.4000208@dev.mellanox.co.il> <20160302211729.GA3803@lst.de>
 <CACVXFVM=-BSTGbrO1MqciCs4zPAt1Lfk1=9DZr+NNur-R96j_g@mail.gmail.com>
 <20160303084609.GA14051@lst.de> <20160315160833.GA21474@infradead.org>
Message-ID: <56E88906.2060205@fb.com>

On 03/15/2016 09:08 AM, Christoph Hellwig wrote:
> Jens, Keith -
>
> any comments?  I think the lack of BLK_MQ_F_SG_MERGE for nvme
> is rather harmful at the moment, as I get much better request
> packing with it.  I'd rather fix this in the block layer, but
> if that's not ok I can also send a pure NVMe patch.

We can default to merging, and have drivers opt out, if they need to. 
NVMe is probably the only one that doesn't set the flag currently, so 
the net effect of the two different approaches would be the same. We'll 
have a slightly higher CPU overhead without a perf win for workloads 
that don't get merging, but overall it's always a win if we can merge 
commands. So a better default, I think, even for nvme.

-- 
Jens Axboe
