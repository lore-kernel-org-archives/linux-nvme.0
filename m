From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Sep 2016 20:23:04 -0700
Subject: [PATCH 13/18] add missing endianess conversions in json_nvme_id_ns
In-Reply-To: <1474600989-16657-1-git-send-email-hch@lst.de>
References: <1474600989-16657-1-git-send-email-hch@lst.de>
Message-ID: <1474600989-16657-14-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 nvme-print.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 95afdf9..5320951 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1131,9 +1131,9 @@ void json_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 
 	root = json_create_object();
 
-	json_object_add_value_int(root, "nsze", ns->nsze);
-	json_object_add_value_int(root, "ncap", ns->ncap);
-	json_object_add_value_int(root, "nuse", ns->nuse);
+	json_object_add_value_int(root, "nsze", le64_to_cpu(ns->nsze));
+	json_object_add_value_int(root, "ncap", le64_to_cpu(ns->ncap));
+	json_object_add_value_int(root, "nuse", le64_to_cpu(ns->nuse));
 	json_object_add_value_int(root, "nsfeat", ns->nsfeat);
 	json_object_add_value_int(root, "nlbaf", ns->nlbaf);
 	json_object_add_value_int(root, "flbas", ns->flbas);
@@ -1143,12 +1143,12 @@ void json_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 	json_object_add_value_int(root, "nmic", ns->nmic);
 	json_object_add_value_int(root, "rescap", ns->rescap);
 	json_object_add_value_int(root, "fpi", ns->fpi);
-	json_object_add_value_int(root, "nawun", ns->nawun);
-	json_object_add_value_int(root, "nawupf", ns->nawupf);
-	json_object_add_value_int(root, "nacwu", ns->nacwu);
-	json_object_add_value_int(root, "nabsn", ns->nabsn);
-	json_object_add_value_int(root, "nabo", ns->nabo);
-	json_object_add_value_int(root, "nabspf", ns->nabspf);
+	json_object_add_value_int(root, "nawun", le16_to_cpu(ns->nawun));
+	json_object_add_value_int(root, "nawupf", le16_to_cpu(ns->nawupf));
+	json_object_add_value_int(root, "nacwu", le16_to_cpu(ns->nacwu));
+	json_object_add_value_int(root, "nabsn", le16_to_cpu(ns->nabsn));
+	json_object_add_value_int(root, "nabo", le16_to_cpu(ns->nabo));
+	json_object_add_value_int(root, "nabspf", le16_to_cpu(ns->nabspf));
 	json_object_add_value_float(root, "nvmcap", nvmcap);
 
 	memset(eui64, 0, sizeof(eui64_buf));
@@ -1168,9 +1168,9 @@ void json_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 	for (i = 0; i <= ns->nlbaf; i++) {
 		struct json_object *lbaf = json_create_object();
 
-		json_object_add_value_int(lbaf, "ms", ns->lbaf[i].ms);
-		json_object_add_value_int(lbaf, "ds", ns->lbaf[i].ds);
-		json_object_add_value_int(lbaf, "rp", ns->lbaf[i].rp);
+		json_object_add_value_int(lbaf, "ms", le16_to_cpu(ns->lbaf[i].ms));
+		json_object_add_value_int(lbaf, "ds", le16_to_cpu(ns->lbaf[i].ds));
+		json_object_add_value_int(lbaf, "rp", le16_to_cpu(ns->lbaf[i].rp));
 
 		json_array_add_value_object(lbafs, lbaf);
 	}
-- 
2.1.4
