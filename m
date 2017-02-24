From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 23 Feb 2017 18:48:47 -0700
Subject: [PATCH] nvme/lightnvm: Prevent small buffer overflow in
 nvme_nvm_identify
Message-ID: <1487900927-29348-1-git-send-email-scott.bauer@intel.com>

There are two closely named structs in lightnvm:
struct nvme_nvm_addr_format and
struct nvme_addr_format.

The first struct has 4 reserved bytes at the end, the second does not.
(gdb) p sizeof(struct nvme_nvm_addr_format)
$1 = 16
(gdb) p sizeof(struct nvm_addr_format)
$2 = 12

In the nvme_nvm_identify function we memcpy from the larger struct to the
smaller struct. We incorrectly pass the length of the larger struct
and overflow by 4 bytes, lets not do that.

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
---
 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 21cac85..fd98954 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -324,7 +324,7 @@ static int nvme_nvm_identity(struct nvm_dev *nvmdev, struct nvm_id *nvm_id)
 	nvm_id->cap = le32_to_cpu(nvme_nvm_id->cap);
 	nvm_id->dom = le32_to_cpu(nvme_nvm_id->dom);
 	memcpy(&nvm_id->ppaf, &nvme_nvm_id->ppaf,
-					sizeof(struct nvme_nvm_addr_format));
+					sizeof(struct nvm_addr_format));
 
 	ret = init_grps(nvm_id, nvme_nvm_id);
 out:
-- 
2.7.4
