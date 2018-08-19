From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 19 Aug 2018 13:06:57 -0400
Subject: [PATCH] nvme-cli: wdc-plugin mark array static declaration
Message-ID: <20180819170657.30036-1-chaitanya.kulkarni@wdc.com>

The array deFeatureIdList is only used in wdc-nvme.c,
use static declaration.
---
 wdc-nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wdc-nvme.c b/wdc-nvme.c
index 1545172..4e691e7 100644
--- a/wdc-nvme.c
+++ b/wdc-nvme.c
@@ -238,7 +238,7 @@ typedef struct _WDC_DE_CSA_FEATURE_ID_LIST
     __u8 featureName[WDC_DE_GENERIC_BUFFER_SIZE];
 } WDC_DE_CSA_FEATURE_ID_LIST;
 
-WDC_DE_CSA_FEATURE_ID_LIST deFeatureIdList[] =
+static WDC_DE_CSA_FEATURE_ID_LIST deFeatureIdList[] =
 {
 	{0x00                                   , "Dummy Placeholder"},
 	{FID_ARBITRATION                        , "Arbitration"},
-- 
2.14.1
