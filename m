From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Thu, 11 Feb 2016 12:36:29 +0100
Subject: [PATCH] nvme: lightnvm: return ppa completion status
In-Reply-To: <1455190589-20016-1-git-send-email-m@bjorling.me>
References: <1455190589-20016-1-git-send-email-m@bjorling.me>
Message-ID: <1455190589-20016-2-git-send-email-m@bjorling.me>

PPAs sent to device is separately acknowledge in a 64bit status
variable. The status is stored in DW0 and DW1 of the completion queue
entry. Store this status inside the nvm_rq for further processing.

This can later be used to implement retry techniques for failed writes
and reads.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/nvme/host/lightnvm.c | 17 +++++++++++++++--
 include/linux/lightnvm.h     |  1 +
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 55dab93..bbb1dbf 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -146,6 +146,14 @@ struct nvme_nvm_command {
 	};
 };
 
+struct nvme_nvm_completion {
+	__le64	result;		/* Used by LightNVM to return ppa completions */
+	__le16	sq_head;	/* how much of this queue may be reclaimed */
+	__le16	sq_id;		/* submission queue that generated this entry */
+	__u16	command_id;	/* of the command which completed */
+	__le16	status;		/* did the command fail, and if so, why? */
+};
+
 #define NVME_NVM_LP_MLC_PAIRS 886
 struct nvme_nvm_lp_mlc {
 	__u16			num_pairs;
@@ -471,6 +479,10 @@ static inline void nvme_nvm_rqtocmd(struct request *rq, struct nvm_rq *rqd,
 static void nvme_nvm_end_io(struct request *rq, int error)
 {
 	struct nvm_rq *rqd = rq->end_io_data;
+	struct nvme_nvm_completion *cqe = rq->special;
+
+	if (cqe)
+		rqd->ppa_status = le64_to_cpu(cqe->result);
 
 	nvm_end_io(rqd, error);
 
@@ -490,7 +502,8 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 	if (IS_ERR(rq))
 		return -ENOMEM;
 
-	cmd = kzalloc(sizeof(struct nvme_nvm_command), GFP_KERNEL);
+	cmd = kzalloc(sizeof(struct nvme_nvm_command) +
+				sizeof(struct nvme_nvm_completion), GFP_KERNEL);
 	if (!cmd) {
 		blk_mq_free_request(rq);
 		return -ENOMEM;
@@ -509,7 +522,7 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 
 	rq->cmd = (unsigned char *)cmd;
 	rq->cmd_len = sizeof(struct nvme_nvm_command);
-	rq->special = (void *)0;
+	rq->special = cmd + 1;
 
 	rq->end_io_data = rqd;
 
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 0fb3745..201b2a3 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -242,6 +242,7 @@ struct nvm_rq {
 	uint16_t nr_pages;
 	uint16_t flags;
 
+	u64 ppa_status; /* ppa media status */
 	int error;
 };
 
-- 
2.1.4
