From: ramirose@gmail.com (Rami Rosen)
Date: Fri,  5 Oct 2018 19:57:54 +0300
Subject: [PATCH] nvme-cli: fix a typo
Message-ID: <20181005165754.4131-1-ramirose@gmail.com>

This patch fixes a typo in nvme-cli usage text.

Signed-off-by: Rami Rosen <ramirose at gmail.com>
---
 nvme-builtin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-builtin.h b/nvme-builtin.h
index afd12b0..7cf10ef 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -13,7 +13,7 @@ COMMAND_LIST(
 	ENTRY("id-ns", "Send NVMe Identify Namespace, display structure", id_ns)
 	ENTRY("list-ns", "Send NVMe Identify List, display structure", list_ns)
 	ENTRY("ns-descs", "Send NVMe Namespace Descriptor List, display structure", ns_descs)
-	ENTRY("id-nvmset", "Sned NVMe Identify NVM Set List, display structure", id_nvmset)
+	ENTRY("id-nvmset", "Send NVMe Identify NVM Set List, display structure", id_nvmset)
 	ENTRY("create-ns", "Creates a namespace with the provided parameters", create_ns)
 	ENTRY("delete-ns", "Deletes a namespace from the controller", delete_ns)
 	ENTRY("attach-ns", "Attaches a namespace to requested controller(s)", attach_ns)
-- 
2.17.1
