From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 12 Dec 2018 15:11:38 -0800
Subject: [PATCH V2 02/12] nvme: add error log page slot definition
In-Reply-To: <20181212231148.4107-1-chaitanya.kulkarni@wdc.com>
References: <20181212231148.4107-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181212231148.4107-3-chaitanya.kulkarni@wdc.com>

This patch adds the NVMe error slot definition from the spec.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 include/linux/nvme.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b94fe8fadc4f..bbcc83886899 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1168,6 +1168,20 @@ struct nvme_command {
 	};
 };
 
+struct nvme_error_slot {
+	__le64		error_count;
+	__le16		sqid;
+	__le16		cmdid;
+	__le16		status_field;
+	__le16		param_error_location;
+	__le64		lba;
+	__le32		nsid;
+	__u8		vs;
+	__u8		resv[3];
+	__le64		cs;
+	__u8		resv2[24];
+};
+
 static inline bool nvme_is_write(struct nvme_command *cmd)
 {
 	/*
-- 
2.17.0
