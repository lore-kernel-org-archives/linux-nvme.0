Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D108C25B7C
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 05:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sGxPH0pTuU9FgrDHNWmRsGiegMKaNzFnZaxfMwg73j4=; b=T9sQBvH0kAxHHR5NNj70py2OvH
	x7DDl8jdItQCP3z6qRDXs41bkZhMpyhWlOcggta+EGBU7stdB978VYT84wi2PjiDF3IhJAl37MxrJ
	OvIA++ec0ItqFJdolP3miKgFhIc+Yz2Lx6jas+fE9UmsoWDcFalIfAV7WzZsorJIGuar+JzQTXEBQ
	Trnvi/bxeSptC+FWOWubn8ggNfsfIYBOCCSRGAFCkhx88IAuMX+SnaUHn91IaK24+ItxYTVkB7njF
	LBy/hPycl5cUBFV0pNsorJbjtd+p3rY0oemnSC4g8DLfNqdfdciTSje7SaDFtNnf/oZIK+KDgojAG
	bgMKIwyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSiJ-0000000Doa9-0BCg;
	Mon, 27 May 2024 05:16:03 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSi7-0000000DoUo-1f7O
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 05:16:00 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D61641F8D5;
	Mon, 27 May 2024 05:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716786942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sGxPH0pTuU9FgrDHNWmRsGiegMKaNzFnZaxfMwg73j4=;
	b=ZanRCip3hRI1fEOXOtEl6BTJpPkQXj5jqGRwMVvR1eZv5MitVuCWRpXZW0ut2uDJpY3rx5
	r7jE/JbwcPWAtrZjX0SYudXGZDLsbJzNwwolwP33G9tKh+i7INyS1tvTAQUhYZo+jjDpEA
	OCas/tkYK60za+bfjTuaWhofnwUXrt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716786942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sGxPH0pTuU9FgrDHNWmRsGiegMKaNzFnZaxfMwg73j4=;
	b=rOdtLz/fCc1M3TI8BmXJzEG07sA5x8fyytVEXcwZcPsYWz0e8Ll2+jB/kB7ZkvLYP1jT5K
	G1E2DdcbOsb7pqCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716786941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sGxPH0pTuU9FgrDHNWmRsGiegMKaNzFnZaxfMwg73j4=;
	b=Y66rZ1MUF/CrGwJgBgzzgoMdQPS0ErtaR+Mr9S3Lw7xeH9Sd6fVYPuJ6p9cw7VHmFfRRud
	R+8pWOzIlV07BBNiGPOnore+bLvE7rQKprhwHuXWw/4qv43rtyFk9TfjN1cDEKVE5KrNk5
	rUTZ1Q5oZbLkRnJZaNbM6QvGFwfcu4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716786941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sGxPH0pTuU9FgrDHNWmRsGiegMKaNzFnZaxfMwg73j4=;
	b=9L9paHAmKXkY8Z9oZfBFVtqB+Q96D9AzAKn+uJELlO0yecoU+Yy98YwIWESV9af3EqoQBo
	ebtbsU0LRxqkxJBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C11BF13A6B;
	Mon, 27 May 2024 05:15:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ND14Lf0WVGawYQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 May 2024 05:15:41 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 1/7] nvmet: add debugfs support
Date: Mon, 27 May 2024 07:15:19 +0200
Message-ID: <20240527051525.762-2-dwagner@suse.de>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527051525.762-1-dwagner@suse.de>
References: <20240527051525.762-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240526_221551_946286_1B7B3E25 
X-CRM114-Status: GOOD (  28.24  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Hannes Reinecke <hare@kernel.org>

Add a debugfs hierarchy to display the configured subsystems
and the controllers attached to the subsystems.

Suggested-by: Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/Kconfig   |   9 ++
 drivers/nvme/target/Makefile  |   1 +
 drivers/nvme/target/core.c    |  22 +++-
 drivers/nvme/target/debugfs.c | 183 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/debugfs.h |  42 ++++++++
 drivers/nvme/target/nvmet.h   |   8 +-
 6 files changed, 262 insertions(+), 3 deletions(-)
 create mode 100644 drivers/nvme/target/debugfs.c
 create mode 100644 drivers/nvme/target/debugfs.h

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 872dd1a0acd8..5740893ace6d 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -18,6 +18,15 @@ config NVME_TARGET
 	  To configure the NVMe target you probably want to use the nvmetcli
 	  tool from http://git.infradead.org/users/hch/nvmetcli.git.
 
+config NVME_TARGET_DEBUGFS
+        bool "NVMe Target debugfs support"
+	depends on NVME_TARGET
+	help
+	  This enables debugfs support to display the connected controllers
+	  to each subsystem
+
+	  If unsure, say N.
+
 config NVME_TARGET_PASSTHRU
 	bool "NVMe Target Passthrough support"
 	depends on NVME_TARGET
diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index c66820102493..c402c44350b2 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
 
 nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
 			discovery.o io-cmd-file.o io-cmd-bdev.o
+nvmet-$(CONFIG_NVME_TARGET_DEBUGFS)	+= debugfs.o
 nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
 nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
 nvmet-$(CONFIG_NVME_TARGET_AUTH)	+= fabrics-cmd-auth.o auth.o
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6bbe4df0166c..7c82e33d9347 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -16,6 +16,7 @@
 #include "trace.h"
 
 #include "nvmet.h"
+#include "debugfs.h"
 
 struct kmem_cache *nvmet_bvec_cache;
 struct workqueue_struct *buffered_io_wq;
@@ -1466,6 +1467,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	mutex_lock(&subsys->lock);
 	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
 	nvmet_setup_p2p_ns_map(ctrl, req);
+	nvmet_debugfs_ctrl_setup(ctrl);
 	mutex_unlock(&subsys->lock);
 
 	*ctrlp = ctrl;
@@ -1500,6 +1502,8 @@ static void nvmet_ctrl_free(struct kref *ref)
 
 	nvmet_destroy_auth(ctrl);
 
+	nvmet_debugfs_ctrl_free(ctrl);
+
 	ida_free(&cntlid_ida, ctrl->cntlid);
 
 	nvmet_async_events_free(ctrl);
@@ -1613,8 +1617,14 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->hosts);
 
+	ret = nvmet_debugfs_subsys_setup(subsys);
+	if (ret)
+		goto free_subsysnqn;
+
 	return subsys;
 
+free_subsysnqn:
+	kfree(subsys->subsysnqn);
 free_fr:
 	kfree(subsys->firmware_rev);
 free_mn:
@@ -1631,6 +1641,8 @@ static void nvmet_subsys_free(struct kref *ref)
 
 	WARN_ON_ONCE(!xa_empty(&subsys->namespaces));
 
+	nvmet_debugfs_subsys_free(subsys);
+
 	xa_destroy(&subsys->namespaces);
 	nvmet_passthru_subsys_free(subsys);
 
@@ -1684,11 +1696,18 @@ static int __init nvmet_init(void)
 	if (error)
 		goto out_free_nvmet_work_queue;
 
-	error = nvmet_init_configfs();
+	error = nvmet_init_debugfs();
 	if (error)
 		goto out_exit_discovery;
+
+	error = nvmet_init_configfs();
+	if (error)
+		goto out_exit_debugfs;
+
 	return 0;
 
+out_exit_debugfs:
+	nvmet_exit_debugfs();
 out_exit_discovery:
 	nvmet_exit_discovery();
 out_free_nvmet_work_queue:
@@ -1705,6 +1724,7 @@ static int __init nvmet_init(void)
 static void __exit nvmet_exit(void)
 {
 	nvmet_exit_configfs();
+	nvmet_exit_debugfs();
 	nvmet_exit_discovery();
 	ida_destroy(&cntlid_ida);
 	destroy_workqueue(nvmet_wq);
diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
new file mode 100644
index 000000000000..d60778b0a4b0
--- /dev/null
+++ b/drivers/nvme/target/debugfs.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DebugFS interface for the NVMe target.
+ * Copyright (c) 2022-2024 Shadow
+ * Copyright (c) 2024 SUSE LLC
+ */
+
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+
+#include "nvmet.h"
+#include "debugfs.h"
+
+struct dentry *nvmet_debugfs;
+
+#define NVMET_DEBUGFS_ATTR(field) \
+	static int field##_open(struct inode *inode, struct file *file) \
+	{ return single_open(file, field##_show, inode->i_private); } \
+	\
+	static const struct file_operations field##_fops = { \
+		.open = field##_open, \
+		.read = seq_read, \
+		.release = single_release, \
+	}
+
+#define NVMET_DEBUGFS_RW_ATTR(field) \
+	static int field##_open(struct inode *inode, struct file *file) \
+	{ return single_open(file, field##_show, inode->i_private); } \
+	\
+	static const struct file_operations field##_fops = { \
+		.open = field##_open, \
+		.read = seq_read, \
+		.write = field##_write, \
+		.release = single_release, \
+	}
+
+static int nvmet_ctrl_hostnqn_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+
+	seq_puts(m, ctrl->hostnqn);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_ctrl_hostnqn);
+
+static int nvmet_ctrl_kato_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+
+	seq_printf(m, "%d\n", ctrl->kato);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_ctrl_kato);
+
+static int nvmet_ctrl_port_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+
+	seq_printf(m, "%d\n", le16_to_cpu(ctrl->port->disc_addr.portid));
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_ctrl_port);
+
+static const char *const csts_state_names[] = {
+	[NVME_CSTS_RDY]		= "ready",
+	[NVME_CSTS_CFS]		= "fatal",
+	[NVME_CSTS_NSSRO]	= "reset",
+	[NVME_CSTS_SHST_OCCUR]	= "shutdown",
+	[NVME_CSTS_SHST_CMPLT]	= "completed",
+	[NVME_CSTS_PP]		= "paused",
+};
+
+static int nvmet_ctrl_state_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+	bool sep = false;
+	int i;
+
+	for (i = 0; i < 7; i++) {
+		int state = BIT(i);
+
+		if (!(ctrl->csts & state))
+			continue;
+		if (sep)
+			seq_puts(m, "|");
+		sep = true;
+		if (csts_state_names[state])
+			seq_puts(m, csts_state_names[state]);
+		else
+			seq_printf(m, "%d", state);
+	}
+	if (sep)
+		seq_printf(m, "\n");
+	return 0;
+}
+
+static ssize_t nvmet_ctrl_state_write(struct file *file, const char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct nvmet_ctrl *ctrl = m->private;
+	char reset[16];
+
+	if (count >= sizeof(reset))
+		return -EINVAL;
+	if (copy_from_user(reset, buf, count))
+		return -EFAULT;
+	if (!memcmp(reset, "fatal", 5))
+		nvmet_ctrl_fatal_error(ctrl);
+	else
+		return -EINVAL;
+	return count;
+}
+NVMET_DEBUGFS_RW_ATTR(nvmet_ctrl_state);
+
+int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
+{
+	char name[32];
+	struct dentry *parent = ctrl->subsys->debugfs_dir;
+	int ret;
+
+	if (!parent)
+		return -ENODEV;
+	snprintf(name, sizeof(name), "ctrl%d", ctrl->cntlid);
+	ctrl->debugfs_dir = debugfs_create_dir(name, parent);
+	if (IS_ERR(ctrl->debugfs_dir)) {
+		ret = PTR_ERR(ctrl->debugfs_dir);
+		ctrl->debugfs_dir = NULL;
+		return ret;
+	}
+	debugfs_create_file("port", S_IRUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_port_fops);
+	debugfs_create_file("hostnqn", S_IRUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_hostnqn_fops);
+	debugfs_create_file("kato", S_IRUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_kato_fops);
+	debugfs_create_file("state", S_IRUSR | S_IWUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_state_fops);
+	return 0;
+}
+
+void nvmet_debugfs_ctrl_free(struct nvmet_ctrl *ctrl)
+{
+	debugfs_remove_recursive(ctrl->debugfs_dir);
+}
+
+int nvmet_debugfs_subsys_setup(struct nvmet_subsys *subsys)
+{
+	int ret = 0;
+
+	subsys->debugfs_dir = debugfs_create_dir(subsys->subsysnqn,
+						 nvmet_debugfs);
+	if (IS_ERR(subsys->debugfs_dir)) {
+		ret = PTR_ERR(subsys->debugfs_dir);
+		subsys->debugfs_dir = NULL;
+	}
+	return ret;
+}
+
+void nvmet_debugfs_subsys_free(struct nvmet_subsys *subsys)
+{
+	debugfs_remove_recursive(subsys->debugfs_dir);
+}
+
+int __init nvmet_init_debugfs(void)
+{
+	struct dentry *parent;
+
+	parent = debugfs_create_dir("nvmet", NULL);
+	if (IS_ERR(parent)) {
+		pr_warn("%s: failed to create debugfs directory\n", "nvmet");
+		return PTR_ERR(parent);
+	}
+	nvmet_debugfs = parent;
+	return 0;
+}
+
+void nvmet_exit_debugfs(void)
+{
+	debugfs_remove_recursive(nvmet_debugfs);
+}
diff --git a/drivers/nvme/target/debugfs.h b/drivers/nvme/target/debugfs.h
new file mode 100644
index 000000000000..cfb8bbf6a297
--- /dev/null
+++ b/drivers/nvme/target/debugfs.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DebugFS interface for the NVMe target.
+ * Copyright (c) 2022-2024 Shadow
+ * Copyright (c) 2024 SUSE LLC
+ */
+#ifndef NVMET_DEBUGFS_H
+#define NVMET_DEBUGFS_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_NVME_TARGET_DEBUGFS
+int nvmet_debugfs_subsys_setup(struct nvmet_subsys *subsys);
+void nvmet_debugfs_subsys_free(struct nvmet_subsys *subsys);
+int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl);
+void nvmet_debugfs_ctrl_free(struct nvmet_ctrl *ctrl);
+
+int __init nvmet_init_debugfs(void);
+void nvmet_exit_debugfs(void);
+#else
+static inline int nvmet_debugfs_subsys_setup(struct nvmet_subsys *subsys)
+{
+	return 0;
+}
+static inline void nvmet_debugfs_subsys_free(struct nvmet_subsys *subsys){}
+
+static inline int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
+{
+	return 0;
+}
+static inline void nvmet_debugfs_ctrl_free(struct nvmet_ctrl *ctrl) {}
+
+static inline int __init nvmet_init_debugfs(void)
+{
+    return 0;
+}
+
+static inline void nvmet_exit_debugfs(void) {}
+
+#endif
+
+#endif /* NVMET_DEBUGFS_H */
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e4ba54b85511..df73a08a657e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -230,7 +230,9 @@ struct nvmet_ctrl {
 
 	struct device		*p2p_client;
 	struct radix_tree_root	p2p_ns_map;
-
+#ifdef CONFIG_NVME_TARGET_DEBUGFS
+	struct dentry		*debugfs_dir;
+#endif
 	spinlock_t		error_lock;
 	u64			err_counter;
 	struct nvme_error_slot	slots[NVMET_ERROR_LOG_SLOTS];
@@ -262,7 +264,9 @@ struct nvmet_subsys {
 
 	struct list_head	hosts;
 	bool			allow_any_host;
-
+#ifdef CONFIG_NVME_TARGET_DEBUGFS
+	struct dentry		*debugfs_dir;
+#endif
 	u16			max_qid;
 
 	u64			ver;
-- 
2.45.1


