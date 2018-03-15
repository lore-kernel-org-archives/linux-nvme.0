From: himanshu.madhani@cavium.com (Himanshu Madhani)
Date: Wed, 14 Mar 2018 20:35:04 -0700
Subject: [PATCH v2 13/13] qla2xxx: Update driver version to 10.00.00.06-k
In-Reply-To: <20180315033504.12628-1-himanshu.madhani@cavium.com>
References: <20180315033504.12628-1-himanshu.madhani@cavium.com>
Message-ID: <20180315033504.12628-14-himanshu.madhani@cavium.com>

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
