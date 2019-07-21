From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Mon, 22 Jul 2019 00:32:19 +0900
Subject: [PATCH 4/4] lnvm: sync-up uapi lightnvm.h header from kernel
In-Reply-To: <20190721153219.5730-1-minwoo.im.dev@gmail.com>
References: <20190721153219.5730-1-minwoo.im.dev@gmail.com>
Message-ID: <20190721153219.5730-5-minwoo.im.dev@gmail.com>

This patch just syncs-up UAPI header from the kernel.  No functional
changes included.

Cc: Keith Busch <kbusch at kernel.org>
Cc: Matias Bjorling <mb at lightnvm.io>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 linux/lightnvm.h | 52 +++++++++++++++++++++++++++++++++++++++++++++++-
 nvme-lightnvm.c  |  2 +-
 2 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/linux/lightnvm.h b/linux/lightnvm.h
index f678ffb..c937160 100644
--- a/linux/lightnvm.h
+++ b/linux/lightnvm.h
@@ -77,7 +77,7 @@ struct nvm_ioctl_create_simple {
 struct nvm_ioctl_create_extended {
 	__u16 lun_begin;
 	__u16 lun_end;
-	__u16 over_prov;
+	__u16 op;
 	__u16 rsv;
 };
 
@@ -135,6 +135,44 @@ struct nvm_ioctl_dev_factory {
 	__u32 flags;
 };
 
+struct nvm_user_vio {
+	__u8 opcode;
+	__u8 flags;
+	__u16 control;
+	__u16 nppas;
+	__u16 rsvd;
+	__u64 metadata;
+	__u64 addr;
+	__u64 ppa_list;
+	__u32 metadata_len;
+	__u32 data_len;
+	__u64 status;
+	__u32 result;
+	__u32 rsvd3[3];
+};
+
+struct nvm_passthru_vio {
+	__u8 opcode;
+	__u8 flags;
+	__u8 rsvd[2];
+	__u32 nsid;
+	__u32 cdw2;
+	__u32 cdw3;
+	__u64 metadata;
+	__u64 addr;
+	__u32 metadata_len;
+	__u32 data_len;
+	__u64 ppa_list;
+	__u16 nppas;
+	__u16 control;
+	__u32 cdw13;
+	__u32 cdw14;
+	__u32 cdw15;
+	__u64 status;
+	__u32 result;
+	__u32 timeout_ms;
+};
+
 /* The ioctl type, 'L', 0x20 - 0x2F documented in ioctl-number.txt */
 enum {
 	/* top level cmds */
@@ -150,6 +188,11 @@ enum {
 
 	/* Factory reset device */
 	NVM_DEV_FACTORY_CMD,
+
+	/* Vector user I/O */
+	NVM_DEV_VIO_ADMIN_CMD = 0x41,
+	NVM_DEV_VIO_CMD = 0x42,
+	NVM_DEV_VIO_USER_CMD = 0x43,
 };
 
 #define NVM_IOCTL 'L' /* 0x4c */
@@ -167,6 +210,13 @@ enum {
 #define NVM_DEV_FACTORY		_IOW(NVM_IOCTL, NVM_DEV_FACTORY_CMD, \
 						struct nvm_ioctl_dev_factory)
 
+#define NVME_NVM_IOCTL_IO_VIO		_IOWR(NVM_IOCTL, NVM_DEV_VIO_USER_CMD, \
+						struct nvm_passthru_vio)
+#define NVME_NVM_IOCTL_ADMIN_VIO	_IOWR(NVM_IOCTL, NVM_DEV_VIO_ADMIN_CMD,\
+						struct nvm_passthru_vio)
+#define NVME_NVM_IOCTL_SUBMIT_VIO	_IOWR(NVM_IOCTL, NVM_DEV_VIO_CMD,\
+						struct nvm_user_vio)
+
 #define NVM_VERSION_MAJOR	1
 #define NVM_VERSION_MINOR	0
 #define NVM_VERSION_PATCHLEVEL	0
diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
index 62bdc40..b4b20ec 100644
--- a/nvme-lightnvm.c
+++ b/nvme-lightnvm.c
@@ -167,7 +167,7 @@ int lnvm_do_create_tgt(char *devname, char *tgtname, char *tgttype,
 		c.conf.type = NVM_CONFIG_TYPE_EXTENDED;
 		c.conf.e.lun_begin = lun_begin;
 		c.conf.e.lun_end = lun_end;
-		c.conf.e.over_prov = over_prov;
+		c.conf.e.op = over_prov;
 	} else {
 		c.conf.type = NVM_CONFIG_TYPE_SIMPLE;
 		c.conf.s.lun_begin = lun_begin;
-- 
2.17.1
