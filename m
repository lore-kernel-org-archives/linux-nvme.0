Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFC5C54E58
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Mar 2024 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j8qS6j5uGJa41ygAn4T0PXn60uHEf5MUJMRnPU+9Pa8=; b=px1ReRHX1RqNEYnjPscL/lRMC3
	ojVUgzLmOb5+uHcuT5IOZSjgct9CYwZ1NnQhwsFgbxvpgLG2PKlvISnLeaExZ3je/yzz3NYEMzf6J
	JjI5VYWyVDt9p6JlDa/5voFCglKmYSxK/XwdVqp6lsAsDzvZaksFtx03sjhv3fvZLg/jIRrEcqdvM
	1+xKzZLDWn1UPDc+LUyhk4rZS5fttxVlM7k39OsGMPMhKzGgIzb3s9wHTzPQ18ZWrXgqErMYwx9SF
	fMmmXS8mA+N96RlDVp9+G72GRCsawUwLOGwESNPcrB9XonYb+5d2khKjYFAPdKOx+RgLUkUf8fRm9
	75Q0crDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmx7M-0000000HTpQ-03M6;
	Wed, 20 Mar 2024 14:40:36 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmx7H-0000000HTm9-26r5
	for linux-nvme@lists.infradead.org;
	Wed, 20 Mar 2024 14:40:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id DCDB2CE114E;
	Wed, 20 Mar 2024 14:40:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C161C43390;
	Wed, 20 Mar 2024 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710945629;
	bh=2/ugjOhPU3pL+XPJHtxNIBd7386fF/JI+aMtkI7ZF0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hBOtNThRsQ5337irG1S5UH8bNPJnmFI4LITzNw/Fps9J9xnL1qBP25hlOcZPbw0MR
	 mK8YPvpSu5wrG2ASxtVkzHT7vBnh80RcMVoz3wv1FufDSHfuSSfTFp6mETzw0yWoHh
	 9hEf9XRSs43c2B2J+lvXXghjqLRUYjpkSY94ldJ3v27yTzQcP8FxYaTMD4rsiJJrC/
	 0GWr6+NMP6fxTOGDRyrxLZ51IT5aIhGRkeWM1cvupd0BDGoe5dhl0b1LpFePWpHJyw
	 5ugDPknrek2/9/cc/eWepSUGNxBhIcEMVlbEMLbNz+obBh74BIpCtTsi6hsFz+df1b
	 iQqaZ1DoNcFEg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/7] nvmet: add debugfs support for queues
Date: Wed, 20 Mar 2024 15:40:12 +0100
Message-Id: <20240320144017.106283-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240320144017.106283-1-hare@kernel.org>
References: <20240320144017.106283-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_074031_957709_BB473F50 
X-CRM114-Status: GOOD (  15.46  )
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
 drivers/nvme/target/core.c    | 10 ++++++
 drivers/nvme/target/debugfs.c | 68 +++++++++++++++++++++++++++++++++++
 drivers/nvme/target/debugfs.h |  2 ++
 drivers/nvme/target/nvmet.h   |  7 ++++
 4 files changed, 87 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6cd1b92fc500..66c31ff04ce5 100644
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
@@ -855,6 +857,14 @@ int nvmet_sq_init(struct nvmet_sq *sq)
 }
 EXPORT_SYMBOL_GPL(nvmet_sq_init);
 
+ssize_t nvmet_sq_peeraddr(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
+		char *traddr, size_t traddr_len)
+{
+	if (!ctrl->ops->queue_peertraddr)
+		return -EOPNOTSUPP;
+	return ctrl->ops->queue_peertraddr(ctrl, sq, traddr, traddr_len);
+}
+
 static inline u16 nvmet_check_ana_state(struct nvmet_port *port,
 		struct nvmet_ns *ns)
 {
diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index 4b9451ad0db9..0c72dc631cd9 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -35,6 +35,74 @@ struct dentry *nvmet_debugfs;
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
+static int nvmet_queue_peer_traddr_show(struct seq_file *m, void *p)
+{
+	struct nvmet_sq *sq = (struct nvmet_sq *)m->private;
+	ssize_t size;
+	char buf[NVMF_TRADDR_SIZE + 1];
+
+	size = nvmet_sq_peeraddr(sq->ctrl, sq, buf, NVMF_TRADDR_SIZE);
+	if (size < 0) {
+		buf[0] = '\0';
+		size = 0;
+	}
+	buf[size] = '\0';
+	seq_printf(m, "%s\n", buf);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_queue_peer_traddr);
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
+	debugfs_create_file("host_traddr", S_IRUSR, queue_dir,
+			    sq, &nvmet_queue_peer_traddr_fops);
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
index a2c6a949ff0f..5192f8012b79 100644
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
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f0371163cb26..fae6493fd87a 100644
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
@@ -365,6 +368,8 @@ struct nvmet_fabrics_ops {
 	void (*discovery_chg)(struct nvmet_port *port);
 	u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
 	u16 (*get_max_queue_size)(const struct nvmet_ctrl *ctrl);
+	ssize_t (*queue_peertraddr)(struct nvmet_ctrl *ctrl,
+			struct nvmet_sq *sq, char *traddr, size_t traddr_len);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
@@ -498,6 +503,8 @@ void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, u16 qid,
 		u16 size);
 void nvmet_sq_destroy(struct nvmet_sq *sq);
 int nvmet_sq_init(struct nvmet_sq *sq);
+ssize_t nvmet_sq_peeraddr(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
+		char *traddr, size_t traddr_len);
 
 void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl);
 
-- 
2.35.3


