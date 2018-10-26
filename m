From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 26 Oct 2018 10:08:32 -0700
Subject: [PATCH 1/3] nvme-cli: fix array len to hold string of size 4
Message-ID: <20181026170834.23457-1-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 plugins/wdc/wdc-nvme.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
index 9531e36..604a8a9 100644
--- a/plugins/wdc/wdc-nvme.c
+++ b/plugins/wdc/wdc-nvme.c
@@ -286,10 +286,10 @@ typedef enum _NVME_VU_DE_LOGPAGE_NAMES
 } NVME_VU_DE_LOGPAGE_NAMES;
 typedef struct _NVME_VU_DE_LOGPAGE_LIST
 {
-    NVME_VU_DE_LOGPAGE_NAMES logPageName;
-    __u32 logPageId;
-    __u32 logPageLen;
-    char  logPageIdStr[4];
+	NVME_VU_DE_LOGPAGE_NAMES logPageName;
+	__u32	logPageId;
+	__u32	logPageLen;
+	char	logPageIdStr[5];
 } NVME_VU_DE_LOGPAGE_LIST, *PNVME_VU_DE_LOGPAGE_LIST;
 
 typedef struct _WDC_NVME_DE_VU_LOGPAGES
-- 
2.17.0
