From: suganath-prabu.subramani@broadcom.com (Suganath Prabu S)
Date: Tue, 31 Oct 2017 18:02:39 +0530
Subject: [PATCH 13/13] mpt3sas: Update mpt3sas driver version.
In-Reply-To: <1509453159-7028-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1509453159-7028-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <1509453159-7028-14-git-send-email-suganath-prabu.subramani@broadcom.com>

Updated mpt3sas driver version to 17.100.00.00

Signed-off-by: Chaitra P B <chaitra.basappa at broadcom.com>
Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 2d005af..ef7d001 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -74,8 +74,8 @@
 #define MPT3SAS_DRIVER_NAME		"mpt3sas"
 #define MPT3SAS_AUTHOR "Avago Technologies <MPT-FusionLinux.pdl at avagotech.com>"
 #define MPT3SAS_DESCRIPTION	"LSI MPT Fusion SAS 3.0 Device Driver"
-#define MPT3SAS_DRIVER_VERSION		"16.100.00.00"
-#define MPT3SAS_MAJOR_VERSION		16
+#define MPT3SAS_DRIVER_VERSION		"17.100.00.00"
+#define MPT3SAS_MAJOR_VERSION		17
 #define MPT3SAS_MINOR_VERSION		100
 #define MPT3SAS_BUILD_VERSION		0
 #define MPT3SAS_RELEASE_VERSION	00
-- 
2.5.5
