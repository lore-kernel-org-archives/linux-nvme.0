From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 30 Nov 2017 23:20:01 +0900
Subject: [PATCH] nvme-cli: add prints for new HMB identify fields of TP 4002
Message-ID: <1512051601-14003-1-git-send-email-minwoo.im.dev@gmail.com>

Add prints to __show_nvme_id_ctrl() for fields which were
added in TP 4002 which is "HMB Enhancements".

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-print.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/nvme-print.c b/nvme-print.c
index db11dd7..1808405 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -860,6 +860,8 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*ve
 	printf("sanicap : %#x\n", le32_to_cpu(ctrl->sanicap));
 	if (human)
 		show_nvme_id_ctrl_sanicap(ctrl->sanicap);
+	printf("hmminds : %d\n", le32_to_cpu(ctrl->hmminds));
+	printf("hmmaxd  : %d\n", le16_to_cpu(ctrl->hmmaxd));
 	printf("sqes    : %#x\n", ctrl->sqes);
 	if (human)
 		show_nvme_id_ctrl_sqes(ctrl->sqes);
-- 
2.7.4
