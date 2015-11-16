From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Mon, 16 Nov 2015 15:34:45 +0100
Subject: [PATCH 11/13] nvme: missing ppaf copy
In-Reply-To: <1447684487-25539-1-git-send-email-m@bjorling.me>
References: <1447684487-25539-1-git-send-email-m@bjorling.me>
Message-ID: <1447684487-25539-12-git-send-email-m@bjorling.me>

The ppa format was not copied from the NVMe specific ppa format to the
lightnvm specific ppa format. This led to the ppa format not being
communicated to the layers above.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/nvme/host/lightnvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 9069be8..fd37123 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -300,6 +300,8 @@ static int nvme_nvm_identity(struct request_queue *q, struct nvm_id *nvm_id)
 	nvm_id->cgrps = nvme_nvm_id->cgrps;
 	nvm_id->cap = le32_to_cpu(nvme_nvm_id->cap);
 	nvm_id->dom = le32_to_cpu(nvme_nvm_id->dom);
+	memcpy(&nvm_id->ppaf, &nvme_nvm_id->ppaf,
+					sizeof(struct nvme_nvm_addr_format));
 
 	ret = init_grps(nvm_id, nvme_nvm_id);
 out:
-- 
2.1.4
