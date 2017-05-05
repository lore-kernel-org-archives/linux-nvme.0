From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Fri,  5 May 2017 16:13:02 -0700
Subject: [PATCH] nvme_fc: correct port role bits
Message-ID: <20170505231302.31578-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

FC Port roles is a bit mask, not individual values.
Correct nvme definitions to unique bits.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 include/linux/nvme-fc-driver.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index abcefb708008..00b164288e80 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -27,8 +27,8 @@
 
 /* FC Port role bitmask - can merge with FC Port Roles in fc transport */
 #define FC_PORT_ROLE_NVME_INITIATOR	0x10
-#define FC_PORT_ROLE_NVME_TARGET	0x11
-#define FC_PORT_ROLE_NVME_DISCOVERY	0x12
+#define FC_PORT_ROLE_NVME_TARGET	0x20
+#define FC_PORT_ROLE_NVME_DISCOVERY	0x40
 
 
 /**
-- 
2.11.0
