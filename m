From: himanshu.madhani@cavium.com (Himanshu Madhani)
Date: Wed, 31 Oct 2018 09:40:59 -0700
Subject: [PATCH v4 5/5] qla2xxx: Update driver version to 11.00.00.00-k
In-Reply-To: <20181031164059.6286-1-himanshu.madhani@cavium.com>
References: <20181031164059.6286-1-himanshu.madhani@cavium.com>
Message-ID: <20181031164059.6286-6-himanshu.madhani@cavium.com>

Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
---
 drivers/scsi/qla2xxx/qla_version.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_version.h b/drivers/scsi/qla2xxx/qla_version.h
index 12bafff71a1a..0d58aa629c08 100644
--- a/drivers/scsi/qla2xxx/qla_version.h
+++ b/drivers/scsi/qla2xxx/qla_version.h
@@ -7,9 +7,9 @@
 /*
  * Driver version
  */
-#define QLA2XXX_VERSION      "10.00.00.11-k"
+#define QLA2XXX_VERSION      "11.00.00.00-k"
 
-#define QLA_DRIVER_MAJOR_VER	10
+#define QLA_DRIVER_MAJOR_VER	11
 #define QLA_DRIVER_MINOR_VER	0
 #define QLA_DRIVER_PATCH_VER	0
 #define QLA_DRIVER_BETA_VER	0
-- 
2.12.0
