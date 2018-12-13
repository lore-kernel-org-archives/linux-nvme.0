From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Dec 2018 09:31:57 +0100
Subject: [PATCH v2 6/6] nvme-multipath: disable polling for underlying
 namespace request queue
In-Reply-To: <20181213063819.13614-7-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-7-sagi@grimberg.me>
Message-ID: <20181213083157.GD869@lst.de>

On Wed, Dec 12, 2018@10:38:18PM -0800, Sagi Grimberg wrote:
> Since the multipath device does not support polling (yet) we cannot
> pass requests to the polling queue map as those will not generate
> interrupt so we cannot reap the completion.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

As said before I don't think this is the right place.  We need
to handle the stacking case in the block layer.  Something like this
untested patch below should do the trick:

--
>From b810e53e8a9ec6f62202c2ad65e6e56277bcace7 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Thu, 13 Dec 2018 09:30:13 +0100
Subject: block: clear REQ_HIPRI if polling is not supported

This prevents a HIPRI bio from being submitted through a stacking
driver that does not support polling and thus won't poll for I/O
completion.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 268d2b8e9843..efa10789ddc0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -921,6 +921,9 @@ generic_make_request_checks(struct bio *bio)
 		}
 	}
 
+	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+		bio->bi_opf &= ~REQ_HIPRI;
+
 	switch (bio_op(bio)) {
 	case REQ_OP_DISCARD:
 		if (!blk_queue_discard(q))
-- 
2.19.2
