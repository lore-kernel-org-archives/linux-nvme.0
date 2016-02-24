From: keith.busch@intel.com (Keith Busch)
Date: Wed, 24 Feb 2016 09:15:58 -0700
Subject: [PATCHv4-4.5 7/7] NVMe: Fix 0-length integrity payload
In-Reply-To: <1456330558-819-1-git-send-email-keith.busch@intel.com>
References: <1456330558-819-1-git-send-email-keith.busch@intel.com>
Message-ID: <1456330558-819-8-git-send-email-keith.busch@intel.com>

A user could send a passthrough IO command with a metadata pointer to a
namespace without metadata. With metadata length of 0, kmalloc returns
ZERO_SIZE_PTR. Since that is not NULL, the driver would have set this as
the bio's integrity payload, which causes an access fault on completion.

This patch ignores the users metadata buffer if the namespace format
does not support separate metadata.

Reported-by: Stephen Bates <stephen.bates at microsemi.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9011685..5455ca0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -184,7 +184,7 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 			goto out_unmap;
 		}
 
-		if (meta_buffer) {
+		if (meta_buffer && meta_len) {
 			struct bio_integrity_payload *bip;
 
 			meta = kmalloc(meta_len, GFP_KERNEL);
-- 
2.6.2.307.g37023ba
