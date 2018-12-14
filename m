From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 14 Dec 2018 11:06:05 -0800
Subject: [PATCH v4 1/6] block: clear REQ_HIPRI if polling is not supported
In-Reply-To: <20181214190610.20086-1-sagi@grimberg.me>
References: <20181214190610.20086-1-sagi@grimberg.me>
Message-ID: <20181214190610.20086-2-sagi@grimberg.me>

From: Christoph Hellwig <hch@lst.de>

This prevents a HIPRI bio from being submitted through a stacking
driver that does not support polling and thus won't poll for I/O
completion.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
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
2.17.1
