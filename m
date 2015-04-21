From: kwan.huen@samsung.com (kwan.huen)
Date: Mon, 20 Apr 2015 18:47:42 -0700
Subject: [PATCH 1/2] added stream id write support
In-Reply-To: <1429580863-3451-1-git-send-email-kwan.huen@samsung.com>
References: <1429580863-3451-1-git-send-email-kwan.huen@samsung.com>
Message-ID: <1429580863-3451-2-git-send-email-kwan.huen@samsung.com>

---
 drivers/block/nvme-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 85b8036..332341a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -769,6 +769,9 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 	if (req->cmd_flags & REQ_RAHEAD)
 		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
 
+	if (rq_data_dir(req))
+		dsmgmt |= bio_get_streamid(req->bio) << 8;
+
 	cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
 	memset(cmnd, 0, sizeof(*cmnd));
 
-- 
1.9.1
