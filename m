From: suganath-prabu.subramani@broadcom.com (Suganath Prabu S)
Date: Fri, 14 Jul 2017 18:52:40 +0530
Subject: [PATCH v2 13/13] mpt3sas: Update mpt3sas driver version.
In-Reply-To: <1500038560-11231-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1500038560-11231-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <1500038560-11231-14-git-send-email-suganath-prabu.subramani@broadcom.com>

Updated mpt3sas driver version to 15.101.00.00

Signed-off-by: Chaitra P B <chaitra.basappa at broadcom.com>
Signed-off-by: Suganath Prabu S <suganath-prabu.subramani at broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index b7855c8..b705199 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -74,9 +74,9 @@
 #define MPT3SAS_DRIVER_NAME		"mpt3sas"
 #define MPT3SAS_AUTHOR "Avago Technologies <MPT-FusionLinux.pdl at avagotech.com>"
 #define MPT3SAS_DESCRIPTION	"LSI MPT Fusion SAS 3.0 Device Driver"
-#define MPT3SAS_DRIVER_VERSION		"15.100.00.00"
+#define MPT3SAS_DRIVER_VERSION		"15.101.00.00"
 #define MPT3SAS_MAJOR_VERSION		15
-#define MPT3SAS_MINOR_VERSION		100
+#define MPT3SAS_MINOR_VERSION		101
 #define MPT3SAS_BUILD_VERSION		0
 #define MPT3SAS_RELEASE_VERSION	00
 
-- 
1.7.1
