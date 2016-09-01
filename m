From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 1 Sep 2016 06:44:52 -0700
Subject: [PATCH v5 2/6] iw_cxgb4: block module unload until all ep resources
 are released
In-Reply-To: <cover.1472833420.git.swise@opengridcomputing.com>
References: <cover.1472833420.git.swise@opengridcomputing.com>
Message-ID: <f9be4774ee55355ed2fe3cf09fb6674a65f36042.1472833420.git.swise@opengridcomputing.com>

Otherwise an endpoint can be still closing down causing a touch
after free crash.  Also WARN_ON if ulps have failed to destroy
various resources during device removal.

Fixes: ad61a4c7a9b7 ("iw_cxgb4: don't block in destroy_qp awaiting the last deref")
Reviewed-by: Sagi Grimberg <sagi at grimbrg.me>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/infiniband/hw/cxgb4/cm.c       | 2 ++
 drivers/infiniband/hw/cxgb4/device.c   | 5 +++++
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index 434a7fb..80f9889 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -333,6 +333,8 @@ static void remove_ep_tid(struct c4iw_ep *ep)
 
 	spin_lock_irqsave(&ep->com.dev->lock, flags);
 	_remove_handle(ep->com.dev, &ep->com.dev->hwtid_idr, ep->hwtid, 0);
+	if (idr_is_empty(&ep->com.dev->hwtid_idr))
+		wake_up(&ep->com.dev->wait);
 	spin_unlock_irqrestore(&ep->com.dev->lock, flags);
 }
 
diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index 071d733..3c4b212 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -872,9 +872,13 @@ static void c4iw_rdev_close(struct c4iw_rdev *rdev)
 static void c4iw_dealloc(struct uld_ctx *ctx)
 {
 	c4iw_rdev_close(&ctx->dev->rdev);
+	WARN_ON_ONCE(!idr_is_empty(&ctx->dev->cqidr));
 	idr_destroy(&ctx->dev->cqidr);
+	WARN_ON_ONCE(!idr_is_empty(&ctx->dev->qpidr));
 	idr_destroy(&ctx->dev->qpidr);
+	WARN_ON_ONCE(!idr_is_empty(&ctx->dev->mmidr));
 	idr_destroy(&ctx->dev->mmidr);
+	wait_event(ctx->dev->wait, idr_is_empty(&ctx->dev->hwtid_idr));
 	idr_destroy(&ctx->dev->hwtid_idr);
 	idr_destroy(&ctx->dev->stid_idr);
 	idr_destroy(&ctx->dev->atid_idr);
@@ -992,6 +996,7 @@ static struct c4iw_dev *c4iw_alloc(const struct cxgb4_lld_info *infop)
 	mutex_init(&devp->rdev.stats.lock);
 	mutex_init(&devp->db_mutex);
 	INIT_LIST_HEAD(&devp->db_fc_list);
+	init_waitqueue_head(&devp->wait);
 	devp->avail_ird = devp->rdev.lldi.max_ird_adapter;
 
 	if (c4iw_debugfs_root) {
diff --git a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
index aa47e0a..4b83b84 100644
--- a/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
+++ b/drivers/infiniband/hw/cxgb4/iw_cxgb4.h
@@ -263,6 +263,7 @@ struct c4iw_dev {
 	struct idr stid_idr;
 	struct list_head db_fc_list;
 	u32 avail_ird;
+	wait_queue_head_t wait;
 };
 
 static inline struct c4iw_dev *to_c4iw_dev(struct ib_device *ibdev)
-- 
2.7.0
