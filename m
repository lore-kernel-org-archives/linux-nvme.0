Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D26C54E71
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 07:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XgP2polYI1GkRHQ8Jn/nlXFEG5M22bvxOWxNk5sESoc=; b=Coxo7fXYIBzbITOyxztlq68r5i
	GmRk3A1W6P7j/1sIeodES4hKaYpVcZnkq9H/vJvNKpUFSk5CRbZD8w74p2tjcCKNGbX+hKY4gDZM4
	EWgWkw0+AtJxBKbtbBP5WRzUhxxqURKrd+qOI8AEEc5HKsemfrymSUk5jingUjujCtvy44nKyFipC
	WOYBCzniAAonxe2hqcorO3VErkzTHdm+MgfNI6qtFAFlWMifnOWSWwuZHVRVMWjQ2MaRw0UNlSLko
	5RMlAYZhGSAicH7dLwdxPF8X8RbdqqmqGoE4DqnfVDCC51B5aTmsVgtEGtUPSCfKNJAoTSG4Wlnvl
	YMbFCcYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnYwk-000000067h5-1ChH;
	Fri, 22 Mar 2024 07:04:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnYwT-000000067Tp-1CEK
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 07:03:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 87F966121D;
	Fri, 22 Mar 2024 07:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED707C43399;
	Fri, 22 Mar 2024 07:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711091032;
	bh=J5BWKs+wiFlFbndeElhEnt5hWylERK3+n4JOqicM5lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I4q916aOZhATxWYY70Vx8z4HpHjnXGZY2MeHchPKFGGq8Nlzc66T+nM8AN7Eo69ad
	 OyAuES5knuRuUZHs/rwVL38V2oeW6pZWpT/eNPwp/mel2X/bpH/BWd6CkhTXbw1jBz
	 lVj3uvjj9m/qzrWb/h96bu37ECZGe+OIE2/iu8g/VuR7doekBcQvTQcIGdECKYaPg4
	 KDvdrZPAMz1dTNvQCJ/cC4R+9XPXWY47T7/K/bp11z0HJXbVfcxgLYl/G/8o1/ldNp
	 HyEOsIlCbk521JHYkZgyyu+jiBlIEC1U2b6hlarBW+z30gpL08J2JbkPCmM7E3nw6T
	 OF+QUpuTszahQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 8/8] nvmet: add debugfs support for queues
Date: Fri, 22 Mar 2024 08:03:33 +0100
Message-Id: <20240322070333.3820-9-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240322070333.3820-1-hare@kernel.org>
References: <20240322070333.3820-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_000353_538893_B5DB9FF0 
X-CRM114-Status: GOOD (  14.88  )
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

Add debugfs entries to display the status of the controller
queues.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/core.c    |  2 ++
 drivers/nvme/target/debugfs.c | 49 +++++++++++++++++++++++++++++++++++
 drivers/nvme/target/debugfs.h |  8 ++++++
 drivers/nvme/target/nvmet.h   |  3 +++
 4 files changed, 62 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4955819e4f5f..694e91cdfc8d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -791,6 +791,7 @@ void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
 	sq->size = size;
 
 	ctrl->sqs[qid] = sq;
+	nvmet_debugfs_queue_setup(ctrl, sq);
 }
 
 static void nvmet_confirm_sq(struct percpu_ref *ref)
@@ -815,6 +816,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	wait_for_completion(&sq->free_done);
 	percpu_ref_exit(&sq->ref);
 	nvmet_auth_sq_free(sq);
+	nvmet_debugfs_queue_free(sq);
 
 	if (ctrl) {
 		/*
diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index 40eeac97157a..a8fec34f36d4 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -35,6 +35,55 @@ struct dentry *nvmet_debugfs;
 		.release = single_release, \
 	}
 
+static int nvmet_queue_sqsize_show(struct seq_file *m, void *p)
+{
+	struct nvmet_sq *sq = (struct nvmet_sq *)m->private;
+
+	seq_printf(m, "%d\n", sq->size);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_queue_sqsize);
+
+static int nvmet_queue_sqhead_show(struct seq_file *m, void *p)
+{
+	struct nvmet_sq *sq = (struct nvmet_sq *)m->private;
+	u32 sqhd = READ_ONCE(sq->sqhd);
+
+	if (sq->sqhd_disabled)
+		seq_puts(m, "disabled\n");
+	else
+		seq_printf(m, "%u\n", sqhd & 0x0000FFFF);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_queue_sqhead);
+
+int nvmet_debugfs_queue_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
+{
+	char name[32];
+	struct dentry *parent = ctrl->debugfs_dir, *queue_dir;
+
+	if (!parent)
+		return -ENODEV;
+	if (!sq)
+		return -EINVAL;
+	snprintf(name, sizeof(name), "queue%d", sq->qid);
+	queue_dir = debugfs_create_dir(name, parent);
+	if (IS_ERR(queue_dir))
+		return PTR_ERR(queue_dir);
+	sq->debugfs_dir = queue_dir;
+	debugfs_create_file("sqsize", S_IRUSR, queue_dir,
+			    sq, &nvmet_queue_sqsize_fops);
+	debugfs_create_file("sqhead", S_IRUSR, queue_dir,
+			    sq, &nvmet_queue_sqhead_fops);
+	return 0;
+}
+
+void nvmet_debugfs_queue_free(struct nvmet_sq *sq)
+{
+	debugfs_remove_recursive(sq->debugfs_dir);
+	sq->debugfs_dir = NULL;
+}
+
 static int nvmet_ctrl_hostnqn_show(struct seq_file *m, void *p)
 {
 	struct nvmet_ctrl *ctrl = (struct nvmet_ctrl *)m->private;
diff --git a/drivers/nvme/target/debugfs.h b/drivers/nvme/target/debugfs.h
index ff09e5597614..5192f8012b79 100644
--- a/drivers/nvme/target/debugfs.h
+++ b/drivers/nvme/target/debugfs.h
@@ -14,6 +14,8 @@ int nvmet_debugfs_subsys_setup(struct nvmet_subsys *subsys);
 void nvmet_debugfs_subsys_free(struct nvmet_subsys *subsys);
 int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl);
 void nvmet_debugfs_ctrl_free(struct nvmet_ctrl *ctrl);
+int nvmet_debugfs_queue_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq);
+void nvmet_debugfs_queue_free(struct nvmet_sq *sq);
 
 int __init nvmet_init_debugfs(void);
 void nvmet_exit_debugfs(void);
@@ -30,6 +32,12 @@ static inline int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 }
 static inline void nvmet_debugfs_ctrl_free(struct nvmet_ctrl *ctrl) {}
 
+static inline int nvmet_debugfs_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
+{
+	return 0;
+}
+static inline void nvmet_debugfs_sq_free(struct nvmet_sq *sq) {}
+
 static inline int __init nvmet_init_debugfs(void)
 {
     return 0;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 3b7ba6d656cf..a6c2b106ba1c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -109,6 +109,9 @@ struct nvmet_sq {
 	u16			size;
 	u32			sqhd;
 	bool			sqhd_disabled;
+#ifdef CONFIG_NVME_TARGET_DEBUGFS
+	struct dentry		*debugfs_dir;
+#endif
 #ifdef CONFIG_NVME_TARGET_AUTH
 	bool			authenticated;
 	struct delayed_work	auth_expired_work;
-- 
2.35.3


