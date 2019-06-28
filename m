From: bvanassche@acm.org (Bart Van Assche)
Date: Fri, 28 Jun 2019 09:53:29 -0700
Subject: [PATCH v5 1/3] nvme: Introduce NVMe 1.4 Identify Namespace fields in
 struct nvme_id_ns
In-Reply-To: <20190628165331.163919-1-bvanassche@acm.org>
References: <20190628165331.163919-1-bvanassche@acm.org>
Message-ID: <20190628165331.163919-2-bvanassche@acm.org>

Several new fields have been introduced in version 1.4 of the NVMe spec
at offsets that were defined as reserved in version 1.3d of the NVMe
spec. Update the definition of the nvme_id_ns data structure such that
it is in sync with version 1.4 of the NVMe spec. This change preserves
backwards compatibility.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>
Reviewed-by: Keith Busch <kbusch at kernel.org>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Hannes Reinecke <hare at suse.com>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 include/linux/nvme.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d98b2d8baf4e..01aa6a6c241d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -315,7 +315,7 @@ struct nvme_id_ns {
 	__u8			nmic;
 	__u8			rescap;
 	__u8			fpi;
-	__u8			rsvd33;
+	__u8			dlfeat;
 	__le16			nawun;
 	__le16			nawupf;
 	__le16			nacwu;
@@ -324,11 +324,17 @@ struct nvme_id_ns {
 	__le16			nabspf;
 	__le16			noiob;
 	__u8			nvmcap[16];
-	__u8			rsvd64[28];
+	__le16			npwg;
+	__le16			npwa;
+	__le16			npdg;
+	__le16			npda;
+	__le16			nows;
+	__u8			rsvd74[18];
 	__le32			anagrpid;
 	__u8			rsvd96[3];
 	__u8			nsattr;
-	__u8			rsvd100[4];
+	__le16			nvmsetid;
+	__le16			endgid;
 	__u8			nguid[16];
 	__u8			eui64[8];
 	struct nvme_lbaf	lbaf[16];
-- 
2.22.0.410.gd8fdbe21b5-goog
