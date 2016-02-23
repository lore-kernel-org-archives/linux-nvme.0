From: keith.busch@intel.com (Keith Busch)
Date: Tue, 23 Feb 2016 09:36:13 -0700
Subject: [PATCH] NVMe: Fix 0-length integrity payload
Message-ID: <1456245373-17398-1-git-send-email-keith.busch@intel.com>

A cheeky user could send a passthrough IO command with a metadata pointer,
but on a namespace without metadata. With metadata length of 0, kmalloc
returns ZERO_SIZE_PTR. Since that is not NULL, the driver would have
set this as the bio's integrity payload, which causes an access fault
on completion.

This patch ignores the users metadata buffer if the namespace format
does not support separate metadata. This is preferred over returning an
invalid error to work with existing user space applications.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reported-by: Stephen Bates <stephen.bates at microsemi.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d8c3a55..5340352 100644
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
