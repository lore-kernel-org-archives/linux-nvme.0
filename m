From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Oct 2016 15:30:50 +0200
Subject: [PATCH v3 07/11] dm: Fix a race condition related to stopping
 and starting queues
In-Reply-To: <1e89a7d7-5cae-40b1-ce31-09d630e6f33d@sandisk.com>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
 <1e89a7d7-5cae-40b1-ce31-09d630e6f33d@sandisk.com>
Message-ID: <20161019133050.GG6323@lst.de>

Looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>

FYI, I wonder how many of the blk_mq_stop_hw_queues do not need
the quiesce call.  In the long run it might be better to have
blk_mq_stop_hw_queues to stop an quiesce, and have a
__blk_mq_stop_hw_queues variant to just stop.
