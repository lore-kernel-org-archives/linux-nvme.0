From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Mon, 26 Feb 2018 14:17:15 +0100
Subject: [PATCH 16/19] lightnvm: define chunk states
In-Reply-To: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
Message-ID: <1519651038-16845-17-git-send-email-javier@cnexlabs.com>

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
index 776ffdc2e137..74830d5dbd6e 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -232,6 +232,20 @@ struct nvm_addr_format {
 	u64	rsv_mask[2];
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
