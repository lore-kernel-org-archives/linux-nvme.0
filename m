From: scott.bauer@intel.com (Scott Bauer)
Date: Tue, 14 Feb 2017 17:29:35 -0700
Subject: [PATCH V6 1/3] uapi: sed-opal fix IOW for activate lsp to use correct
 struct
Message-ID: <1487118577-1719-1-git-send-email-scott.bauer@intel.com>

The IOC_OPAL_ACTIVATE_LSP took the wrong strcure which would
give us the wrong size when using _IOC_SIZE, switch it to the
right structure.

Fixes: 058f8a2 ("Include: Uapi: Add user ABI for Sed/Opal")

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
---
 include/uapi/linux/sed-opal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index fc06e3a..c72e073 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -106,7 +106,7 @@ struct opal_mbr_data {
 #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
 #define IOC_OPAL_LOCK_UNLOCK	    _IOW('p', 221, struct opal_lock_unlock)
 #define IOC_OPAL_TAKE_OWNERSHIP	    _IOW('p', 222, struct opal_key)
-#define IOC_OPAL_ACTIVATE_LSP       _IOW('p', 223, struct opal_key)
+#define IOC_OPAL_ACTIVATE_LSP       _IOW('p', 223, struct opal_lr_act)
 #define IOC_OPAL_SET_PW             _IOW('p', 224, struct opal_new_pw)
 #define IOC_OPAL_ACTIVATE_USR       _IOW('p', 225, struct opal_session_info)
 #define IOC_OPAL_REVERT_TPR         _IOW('p', 226, struct opal_key)
-- 
2.7.4
