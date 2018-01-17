From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 17 Jan 2018 19:06:23 +0200
Subject: [PATCH 1/1] nvmet: fix PSDT field check in command format
Message-ID: <1516208783-4629-1-git-send-email-maxg@mellanox.com>

PSDT field section according to NVM_Express-1.3:
"This field specifies whether PRPs or SGLs are used for any data
transfer associated with the command. PRPs shall be used for all
Admin commands for NVMe over PCIe. SGLs shall be used for all Admin
and I/O commands for NVMe over Fabrics. This field shall be set to
01b for NVMe over Fabrics 1.0 implementations.

Suggested-by: Idan Burstein <idanb at mellanox.com>
Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ab3a247..438e0ba 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -523,9 +523,12 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 		goto fail;
 	}
 
-	/* either variant of SGLs is fine, as we don't support metadata */
-	if (unlikely((flags & NVME_CMD_SGL_ALL) != NVME_CMD_SGL_METABUF &&
-		     (flags & NVME_CMD_SGL_ALL) != NVME_CMD_SGL_METASEG)) {
+	/*
+         * For fabrics, PSDT field shall describe metadata pointer (MPTR) that
+         * contains an address of a single contiguous physical buffer that is
+         * byte aligned.
+         */
+	if (unlikely((flags & NVME_CMD_SGL_ALL) != NVME_CMD_SGL_METABUF)) {
 		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 		goto fail;
 	}
-- 
1.8.3.1
