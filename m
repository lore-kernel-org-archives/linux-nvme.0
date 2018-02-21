From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Wed, 21 Feb 2018 10:26:55 +0100
Subject: [PATCH 17/20] lightnvm: define chunk states
In-Reply-To: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
Message-ID: <1519205218-26994-18-git-send-email-javier@cnexlabs.com>

Define chunk states as given in the 2.0 spec. Also, add an extra chunk
state that signals that the chunk is in use by the host. This allows for
the chunk metadata to be "owned" by a target when active, thus
completing the chunk state machine from the host perspective and
facilitating sanity checks. This state is transparent for the device.

Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
---
 include/linux/lightnvm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index bc43700c37ec..4dfb85d08ab5 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -297,6 +297,20 @@ struct nvm_dev_geo {
 	struct nvm_common_geo c;
 };
 
+enum {
+	/* Chunk states */
+	NVM_CHK_ST_FREE =	1 << 0,
+	NVM_CHK_ST_CLOSED =	1 << 1,
+	NVM_CHK_ST_OPEN =	1 << 2,
+	NVM_CHK_ST_OFFLINE =	1 << 3,
+	NVM_CHK_ST_HOST_USE =	1 << 7,
+
+	/* Chunk types */
+	NVM_CHK_TP_W_SEQ =	1 << 0,
+	NVM_CHK_TP_W_RAN =	1 << 1,
+	NVM_CHK_TP_SZ_SPEC =	1 << 4,
+};
+
 /*
  * Note: The structure size is linked to nvme_nvm_chk_meta such that the same
  * buffer can be used when converting from little endian to cpu addressing.
-- 
2.7.4
