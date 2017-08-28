From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 28 Aug 2017 10:40:23 +0300
Subject: blk_mq_reinit_tagset during NVMEoF port toggling
In-Reply-To: <85228a2d-053f-cf79-292e-725aad6ee5fa@mellanox.com>
References: <85228a2d-053f-cf79-292e-725aad6ee5fa@mellanox.com>
Message-ID: <e47ee442-0361-eb7c-6da3-e3b9f61015d5@grimberg.me>

> Hi guys,

Hi Max, CCing linux-nvme.

> we have encountered a bug during our port toggling test with MP using 
> NVMEoF over RDMA (1 IO queue repro it quickly).
> We have been receiving local protection errors dumps after failing back 
> to the port that became active again (it's not the retransmission issue 
> we fixed in the past). After debugging it we saw that the requests have 
> been doing a reinit process (dereg_mr/alloc_mr).
> But somehow the req->mr->need_inval is still true in the beginning of 
> nvme_rdma_queue_rq function. This shouldn't happen since we should have 
> perform the dereg_mr/alloc_mr in the reinit func and set it to false.
> We don't see this issue in kernel older than 4.11 so before bisecting:

Which code base is this max?

is commit 842594c8775b585c58459e044708c0335b6aa6b7 applied?

if so, maybe it is possible that not all requests are being reinitialized.
Can you reproduce with the following applied:
--
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index d0be72ccb091..420ef106057e 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -302,8 +302,10 @@ int blk_mq_reinit_tagset(struct blk_mq_tag_set *set)
                         continue;

                 for (j = 0; j < tags->nr_tags; j++) {
-                       if (!tags->static_rqs[j])
+                       if (!tags->static_rqs[j]) {
+                               pr_info("passing rq %d\n", j);
                                 continue;
+                       }

                         ret = set->ops->reinit_request(set->driver_data,
                                                 tags->static_rqs[j]);
--
