From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 13 Jul 2016 13:03:20 +0300
Subject: [patch] nvme-rdma: fix an error code
Message-ID: <20160713100320.GC29468@mwanda>

We accidentally return success when an error code was intended.

Fixes: 711023071960 ('nvme-rdma: add a NVMe over Fabrics RDMA host driver')
Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 278551b..5208f16 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -299,8 +299,8 @@ static int nvme_rdma_reinit_request(void *data, struct request *rq)
 	req->mr = ib_alloc_mr(dev->pd, IB_MR_TYPE_MEM_REG,
 			ctrl->max_fr_pages);
 	if (IS_ERR(req->mr)) {
-		req->mr = NULL;
 		ret = PTR_ERR(req->mr);
+		req->mr = NULL;
 	}
 
 	req->need_inval = false;
