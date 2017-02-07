From: scott.bauer@intel.com (Scott Bauer)
Date: Mon,  6 Feb 2017 17:22:49 -0700
Subject: [PATCH] Fix SED-OPAL UAPI structs to prevent 32/64 bit size
 differences.
In-Reply-To: <1486426969-27549-1-git-send-email-scott.bauer@intel.com>
References: <1486426969-27549-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1486426969-27549-2-git-send-email-scott.bauer@intel.com>

This patch is a quick fixup of the user structures that will prevent
the structures from being different sizes on 32 and 64 bit archs.
Taking this fix will allow us to *NOT* have to do compat ioctls for
the sed code.

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
---
 include/uapi/linux/sed-opal.h | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
index 3179952..fc06e3a 100644
--- a/include/uapi/linux/sed-opal.h
+++ b/include/uapi/linux/sed-opal.h
@@ -48,37 +48,38 @@ enum opal_lock_state {
 };
 
 struct opal_key {
-	uint8_t	lr;
-	uint8_t	key_len;
-	char 	key[OPAL_KEY_MAX];
+	__u8 lr;
+	__u8 key_len;
+	__u8 __align[6];
+	__u8 key[OPAL_KEY_MAX];
 };
 
 struct opal_lr_act {
-	int sum;
-	uint8_t num_lrs;
-	uint8_t lr[OPAL_MAX_LRS];
 	struct opal_key key;
+	__u32 sum;
+	__u8    num_lrs;
+	__u8 lr[OPAL_MAX_LRS];
+	__u8 align[2]; /* Align to 8 byte boundary */
 };
 
 struct opal_session_info {
-	int sum;
-	enum opal_user who;
+	__u32 sum;
+	__u32 who;
 	struct opal_key opal_key;
-	uint8_t __align[2];
 };
 
 struct opal_user_lr_setup {
-	size_t range_start;
-	size_t range_length;
-	int    RLE; /* Read Lock enabled */
-	int    WLE; /* Write Lock Enabled */
+	__u64 range_start;
+	__u64 range_length;
+	__u32 RLE; /* Read Lock enabled */
+	__u32 WLE; /* Write Lock Enabled */
 	struct opal_session_info session;
-	uint8_t __align[4];
 };
 
 struct opal_lock_unlock {
-	enum opal_lock_state l_state;
 	struct opal_session_info session;
+	__u32 l_state;
+	__u8 __align[4];
 };
 
 struct opal_new_pw {
@@ -97,9 +98,9 @@ struct opal_new_pw {
 };
 
 struct opal_mbr_data {
-	u8 enable_disable;
 	struct opal_key key;
-	uint8_t __align[5];
+	__u8 enable_disable;
+	__u8 __align[7];
 };
 
 #define IOC_OPAL_SAVE		    _IOW('p', 220, struct opal_lock_unlock)
-- 
2.7.4
