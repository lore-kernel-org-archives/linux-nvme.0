From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 19 Jun 2019 10:37:00 -0700
Subject: [PATCH nvme-cli 12/13] Introduce NVMe 1.4 Identify Namespace fields
 in struct nvme_id_ns
In-Reply-To: <20190619173701.8263-1-bvanassche@acm.org>
References: <20190619173701.8263-1-bvanassche@acm.org>
Message-ID: <20190619173701.8263-13-bvanassche@acm.org>

Several new fields have been introduced in version 1.4 of the NVMe spec
at offsets that were defined as reserved in version 1.3d of the NVMe
spec. Update the definition of the nvme_id_ns data structure such that
it is in sync with version 1.4 of the NVMe spec. This change preserves
backwards compatibility.

Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 linux/nvme.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index 69f287e682f2..af14339bdca6 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -332,7 +332,12 @@ struct nvme_id_ns {
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
-- 
2.22.0.rc3
