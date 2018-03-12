From: himanshu.madhani@cavium.com (Himanshu Madhani)
Date: Mon, 12 Mar 2018 11:16:50 -0700
Subject: [PATCH 13/13] qla2xxx: Update driver version to 10.00.00.06-k
In-Reply-To: <20180312181650.20704-1-himanshu.madhani@cavium.com>
References: <20180312181650.20704-1-himanshu.madhani@cavium.com>
Message-ID: <20180312181650.20704-14-himanshu.madhani@cavium.com>

Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
---
 drivers/scsi/qla2xxx/qla_version.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_version.h b/drivers/scsi/qla2xxx/qla_version.h
index 549bef9afddd..0c55d7057280 100644
--- a/drivers/scsi/qla2xxx/qla_version.h
+++ b/drivers/scsi/qla2xxx/qla_version.h
@@ -7,7 +7,7 @@
 /*
  * Driver version
  */
-#define QLA2XXX_VERSION      "10.00.00.05-k"
+#define QLA2XXX_VERSION      "10.00.00.06-k"
 
 #define QLA_DRIVER_MAJOR_VER	10
 #define QLA_DRIVER_MINOR_VER	0
-- 
2.12.0
