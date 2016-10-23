From: james.smart@broadcom.com (James Smart)
Date: Sun, 23 Oct 2016 12:31:05 -0700
Subject: [PATCH v3 1/7] Add type 0x28 NVME type code to scsi fc headers
Message-ID: <580d0ff9.QtHqSSVtyyUePum+%james.smart@broadcom.com>


Add type 0x28 NVME type code to scsi fc headers

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 include/uapi/scsi/fc/fc_fs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/scsi/fc/fc_fs.h b/include/uapi/scsi/fc/fc_fs.h
index 50f28b1..dcf314d 100644
--- a/include/uapi/scsi/fc/fc_fs.h
+++ b/include/uapi/scsi/fc/fc_fs.h
@@ -190,6 +190,7 @@ enum fc_fh_type {
 	FC_TYPE_FCP =	0x08,	/* SCSI FCP */
 	FC_TYPE_CT =	0x20,	/* Fibre Channel Services (FC-CT) */
 	FC_TYPE_ILS =	0x22,	/* internal link service */
+	FC_TYPE_NVME =	0x28,	/* FC-NVME */
 };
 
 /*
@@ -203,6 +204,7 @@ enum fc_fh_type {
 	[FC_TYPE_FCP] =		"FCP",			\
 	[FC_TYPE_CT] =		"CT",			\
 	[FC_TYPE_ILS] =		"ILS",			\
+	[FC_TYPE_NVME] =	"NVME",			\
 }
 
 /*
-- 
2.5.0
