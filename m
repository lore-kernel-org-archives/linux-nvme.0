From: weiyj_lk@163.com (weiyj_lk@163.com)
Date: Tue, 12 Jul 2016 11:06:17 +0000
Subject: [PATCH -next] nvme-rdma: fix the return value of
 nvme_rdma_reinit_request()
Message-ID: <1468321577-16278-1-git-send-email-weiyj_lk@163.com>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

PTR_ERR should be applied before its argument is reassigned, otherwise the
return value will be set to 0, not error code.

Signed-off-by: Wei Yongjun <yongjun_wei at trendmicro.com.cn>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
