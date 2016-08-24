From: luto@kernel.org (Andy Lutomirski)
Date: Wed, 24 Aug 2016 03:52:12 -0700
Subject: [PATCH] nvme: Fix nvme_get/set_features() with a NULL result pointer
Message-ID: <f0eca21161c9ec5f81e9591741463ec3883cb931.1472035881.git.luto@kernel.org>

nvme_set_features() callers seem to expect that passing NULL as the
result pointer is acceptable.  Teach nvme_set_features() not to try to
write to the NULL address.

For symmetry, make the same change to nvme_get_features(), despite the
fact that all current callers pass a valid result pointer.

I assume that this bug hasn't been reported in practice because
the callers that pass NULL are all in the SCSI translation layer
and no one uses the relevant operations.

Cc: stable at vger.kernel.org
Signed-off-by: Andy Lutomirski <luto at kernel.org>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7ff2e820bbf4..ebae74f6da9c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -608,7 +608,7 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned nsid,
 
 	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &cqe, NULL, 0, 0,
 			NVME_QID_ANY, 0, 0);
-	if (ret >= 0)
+	if (ret >= 0 && result)
 		*result = le32_to_cpu(cqe.result);
 	return ret;
 }
@@ -628,7 +628,7 @@ int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 
 	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &cqe, NULL, 0, 0,
 			NVME_QID_ANY, 0, 0);
-	if (ret >= 0)
+	if (ret >= 0 && result)
 		*result = le32_to_cpu(cqe.result);
 	return ret;
 }
-- 
2.7.4
