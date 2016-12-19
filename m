From: scott.bauer@intel.com (Scott Bauer)
Date: Mon, 19 Dec 2016 12:35:45 -0700
Subject: [PATCH v3 1/5] include: Add definitions for sed
In-Reply-To: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1482176149-2257-2-git-send-email-scott.bauer@intel.com>

This patch adds the definitions and structures for the SED
Opal code.

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli at intel.com>
---
 include/linux/sed-opal.h      | 38 +++++++++++++++++
 include/linux/sed.h           | 76 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/sed-opal.h | 94 +++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/sed.h      | 64 +++++++++++++++++++++++++++++
 4 files changed, 272 insertions(+)
 create mode 100644 include/linux/sed-opal.h
 create mode 100644 include/linux/sed.h
 create mode 100644 include/uapi/linux/sed-opal.h
 create mode 100644 include/uapi/linux/sed.h

diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
new file mode 100644
index 0000000..668401c
--- /dev/null
+++ b/include/linux/sed-opal.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright ? 2016 Intel Corporation
+ *
+ * Authors:
+ *    Rafael Antognolli <rafael.antognolli at intel.com>
+ *    Scott  Bauer      <scott.bauer at intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef LINUX_OPAL_H
+#define LINUX_OPAL_H
+
+#include <linux/sed.h>
+#include <linux/kernel.h>
+
+int opal_save(struct sed_context *sedc, struct sed_key *key);
+int opal_lock_unlock(struct sed_context *sedc, struct sed_key *key);
+int opal_take_ownership(struct sed_context *sedc, struct sed_key *key);
+int opal_activate_lsp(struct sed_context *sedc, struct sed_key *key);
+int opal_set_new_pw(struct sed_context *sedc, struct sed_key *key);
+int opal_activate_user(struct sed_context *sedc, struct sed_key *key);
+int opal_reverttper(struct sed_context *sedc, struct sed_key *key);
+int opal_setup_locking_range(struct sed_context *sedc, struct sed_key *key);
+int opal_add_user_to_lr(struct sed_context *sedc, struct sed_key *key);
+int opal_enable_disable_shadow_mbr(struct sed_context *sedc, struct sed_key *key);
+int opal_erase_locking_range(struct sed_context *sedc, struct sed_key *key);
+int opal_secure_erase_locking_range(struct sed_context *sedc, struct sed_key *key);
+int opal_unlock_from_suspend(struct sed_context *sedc);
+struct opal_dev *alloc_opal_dev(struct request_queue *q);
+#endif /* LINUX_OPAL_H */
diff --git a/include/linux/sed.h b/include/linux/sed.h
new file mode 100644
index 0000000..bc848b2
--- /dev/null
+++ b/include/linux/sed.h
@@ -0,0 +1,76 @@
+/*
+ * Self-Encrypting Drive interface - sed.h
+ *
+ * Copyright ? 2016 Intel Corporation
+ *
+ * Authors:
+ *    Rafael Antognolli <rafael.antognolli at intel.com>
+ *    Scott  Bauer      <scott.bauer at intel.com>
+ *
+ * This code is the generic layer to interface with self-encrypting
+ * drives. Specific command sets should advertise support to sed uapi
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#ifndef LINUX_SED_H
+#define LINUX_SED_H
+
+#include <linux/blkdev.h>
+#include <uapi/linux/sed.h>
+
+/*
+ * These constant values come from:
+ * TCG Storage Architecture Core Spec v2.01 r1
+ * Section: 3.3 Interface Communications
+ */
+enum {
+	TCG_SECP_00 = 0,
+	TCG_SECP_01,
+};
+
+/**
+ * struct sed_context - SED Security context for a device
+ * @ops:The Trusted Send/Recv functions.
+ * @sec_data:Opaque pointer that will be passed to the send/recv fn.
+ *Drivers can use this to pass necessary data required for
+ *Their implementation of send/recv.
+ * @dev:Currently an Opal Dev structure. In the future can be other types
+ *Of security structures.
+ */
+struct sed_context {
+	const struct sec_ops *ops;
+	void *sec_data;
+	void *dev;
+};
+
+/*
+ * sec_ops - transport specific Trusted Send/Receive functions
+* See SPC-4 for specific definitions
+ *
+ * @sec_send: sends the payload to the trusted peripheral
+ *     spsp: Security Protocol Specific
+ *     secp: Security Protocol
+ *     buf: Payload
+ *     len: Payload length
+ * @recv: Receives a payload from the trusted peripheral
+ *     spsp: Security Protocol Specific
+ *     secp: Security Protocol
+ *     buf: Payload
+ *     len: Payload length
+ */
+struct sec_ops {
+	int (*sec_send)(void *ctrl_data, u16 spsp, u8 secp, void *buf, size_t len);
+	int (*sec_recv)(void *ctrl_data, u16 spsp, u8 secp, void *buf, size_t len);
+};
+int fdev_sed_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
+
+#endif /* LINUX_SED_H */
diff --git a/include/uapi/linux/sed-opal.h b/include/uapi/linux/sed-opal.h
new file mode 100644
index 0000000..f168dac
--- /dev/null
+++ b/include/uapi/linux/sed-opal.h
@@ -0,0 +1,94 @@
+/*
+ * Copyright ? 2016 Intel Corporation
+ *
+ * Authors:
+ *    Rafael Antognolli <rafael.antognolli at intel.com>
+ *    Scott  Bauer      <scott.bauer at intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef _UAPI_OPAL_H
+#define _UAPI_OPAL_H
+
+#include <linux/types.h>
+
+#define OPAL_KEY_MAX 256
+
+enum opal_mbr {
+	OPAL_MBR_ENABLE,
+	OPAL_MBR_DISABLE,
+};
+
+enum opal_user {
+	OPAL_ADMIN1,
+	OPAL_USER1,
+	OPAL_USER2,
+	OPAL_USER3,
+	OPAL_USER4,
+	OPAL_USER5,
+	OPAL_USER6,
+	OPAL_USER7,
+	OPAL_USER8,
+	OPAL_USER9,
+};
+
+enum opal_lock_state {
+	OPAL_RO = 0x01, /* 0001 */
+	OPAL_RW = 0x02, /* 0010 */
+	OPAL_LK = 0x04, /* 0100 */
+};
+
+struct opal_key {
+	__u8	lr;
+	__u8	key_len;
+	__u8	key[OPAL_KEY_MAX];
+};
+
+struct opal_session_info {
+	bool SUM;
+	struct opal_key opal_key;
+	enum opal_user who;
+};
+
+struct opal_user_lr_setup {
+	struct opal_session_info session;
+	size_t range_start;
+	size_t range_length;
+	int    RLE; /* Read Lock enabled */
+	int    WLE; /* Write Lock Enabled */
+};
+
+struct opal_lock_unlock {
+	struct opal_session_info session;
+	enum opal_lock_state l_state;
+};
+
+struct opal_new_pw {
+	struct opal_session_info session;
+
+	/* When we're not operating in SUM, and we first set
+	 * passwords we need to set them via ADMIN authority.
+	 * After passwords are changed, we can set them via,
+	 * User authorities.
+	 * Because of this restriction we need to know about
+	 * Two different users. One in 'who' which we will use
+	 * to start the session and user_for_pw as the user we're
+	 * chaning the pw for.
+	 */
+	struct opal_session_info new_user_pw;
+};
+
+struct opal_mbr_data {
+	u8 enable_disable;
+	struct opal_key key;
+};
+
+#endif /* _UAPI_SED_H */
diff --git a/include/uapi/linux/sed.h b/include/uapi/linux/sed.h
new file mode 100644
index 0000000..1d2b45c
--- /dev/null
+++ b/include/uapi/linux/sed.h
@@ -0,0 +1,64 @@
+/*
+ * Definitions for the self-encrypting drive interface
+ * Copyright ? 2016 Intel Corporation
+ *
+ * Authors:
+ *    Rafael Antognolli <rafael.antognolli at intel.com>
+ *    Scott  Bauer      <scott.bauer at intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef _UAPI_SED_H
+#define _UAPI_SED_H
+
+#include <linux/types.h>
+#include "sed-opal.h"
+
+enum sed_key_type {
+	OPAL,
+	OPAL_PW,
+	OPAL_ACT_USR,
+	OPAL_LR_SETUP,
+	OPAL_LOCK_UNLOCK,
+	OPAL_MBR_DATA,
+};
+
+struct sed_key {
+	__u32 sed_type;
+	union {
+		struct opal_key            opal;
+		struct opal_new_pw         opal_pw;
+		struct opal_session_info   opal_session;
+		struct opal_user_lr_setup  opal_lrs;
+		struct opal_lock_unlock    opal_lk_unlk;
+		struct opal_mbr_data       opal_mbr;
+		/* additional command set key types */
+	};
+};
+
+#define IOC_SED_SAVE		   _IOW('p', 220, struct sed_key)
+#define IOC_SED_LOCK_UNLOCK	   _IOW('p', 221, struct sed_key)
+#define IOC_SED_TAKE_OWNERSHIP	   _IOW('p', 222, struct sed_key)
+#define IOC_SED_ACTIVATE_LSP       _IOW('p', 223, struct sed_key)
+#define IOC_SED_SET_PW             _IOW('p', 224, struct sed_key)
+#define IOC_SED_ACTIVATE_USR       _IOW('p', 225, struct sed_key)
+#define IOC_SED_REVERT_TPR         _IOW('p', 226, struct sed_key)
+#define IOC_SED_LR_SETUP           _IOW('p', 227, struct sed_key)
+#define IOC_SED_ADD_USR_TO_LR      _IOW('p', 228, struct sed_key)
+#define IOC_SED_ENABLE_DISABLE_MBR _IOW('p', 229, struct sed_key)
+#define IOC_SED_ERASE_LR           _IOW('p', 230, struct sed_key)
+#define IOC_SED_SECURE_ERASE_LR    _IOW('p', 231, struct sed_key)
+
+static inline int is_sed_ioctl(unsigned int cmd)
+{
+	return (cmd >= IOC_SED_SAVE && cmd <= IOC_SED_SECURE_ERASE_LR);
+}
+#endif /* _UAPI_SED_H */
-- 
2.7.4
