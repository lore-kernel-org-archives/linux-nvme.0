From: paul.grabinar@ranbarg.com (Paul Grabinar)
Date: Mon, 20 Jul 2015 20:09:25 +0100
Subject: Discard operation with protection type 0
Message-ID: <55AD4765.1090802@ranbarg.com>

Hi,
Sorry to bother everyone again with another issue to do with end-to-end
protection. I know we all love them.
I think this one is minor.

The configuration concerns a device with 512 byte (though I think 4k
would be the same) sectors, 8 bytes of meta-data in a seperate buffer
and a protection type of zero.

Discard (TRIM) operations on such a configuration can fail.

The driver needs to ensure that a buffer with the meta-data is provided,
as it is not possible to use the PRACT bit. However, for discard
operation, I don't think we care, as the discard command does not need
meta-data.

The following patch is not necessarily the right fix, but shows what I
think the issue is.

Thanks.

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7920c27..8beb86f 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -863,6 +863,7 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
      */
     if (ns && ns->ms && !blk_integrity_rq(req)) {
         if (!(ns->pi_type && ns->ms == 8) &&
+                    !(req->cmd_flags & REQ_DISCARD) &&
                     req->cmd_type != REQ_TYPE_DRV_PRIV) {
             req->errors = -EFAULT;
             blk_mq_complete_request(req);
