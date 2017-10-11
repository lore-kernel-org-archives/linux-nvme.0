From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 15:29:09 +0300
Subject: [PATCH 4/7] nvme-rdma: Check that reinit_request got a proper mr
In-Reply-To: <1507724952-13917-1-git-send-email-sagi@grimberg.me>
References: <1507724952-13917-1-git-send-email-sagi@grimberg.me>
Message-ID: <1507724952-13917-5-git-send-email-sagi@grimberg.me>

Warn if req->mr is NULL as it should never happen.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6e62657662fd..93f4dd0b6f26 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -274,6 +274,9 @@ static int nvme_rdma_reinit_request(void *data, struct request *rq)
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	int ret = 0;
 
+	if (WARN_ON_ONCE(!req->mr))
+		return 0;
+
 	ib_dereg_mr(req->mr);
 
 	req->mr = ib_alloc_mr(dev->pd, IB_MR_TYPE_MEM_REG,
-- 
2.7.4
