Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC8CC25B74
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 05:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lrb22Re5XT5FsU/Fw8DlvbBxzcvLfSKzIXdum5w4Npk=; b=UDUtp71p6dV5nrRSE74Zyk3T2F
	tGM5kV1tWeTeHLdnE5nq9K//KD+McAyGXZKGx/jy1TTk8HtSDVYao9UP9h9vp6BdqC4UeHE0rLYaV
	mjxF7YTt4futA0xLTbshxuEVdnrJ+XO92S4gg/31TTtJlqcY3U0JzODRZZb16R0gSGuV33YifwaH5
	8QhVTH8AN/TKCVpOM4Wq2uZXOVRwsXf4Dyk7MUiKD/fwlvjf+qbG/lun8J4YfqRngsX+/6mpasYm/
	/HF/nHYejgxxUTyBZkuv+7TXl4OJSwH9zQfXIyQepg/Q+9V9FCGke4dGhHYeWipVCESpUxa0fBWrR
	L6r5JeRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSiA-0000000DoXL-3B6R;
	Mon, 27 May 2024 05:15:54 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSi7-0000000DoUs-1dLJ
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 05:15:52 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8348C1F8D6;
	Mon, 27 May 2024 05:15:42 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7011D13A6B;
	Mon, 27 May 2024 05:15:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Nf+sGf4WVGa4YQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 May 2024 05:15:42 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 2/7] nvmet: add 'host_traddr' callback for debugfs
Date: Mon, 27 May 2024 07:15:20 +0200
Message-ID: <20240527051525.762-3-dwagner@suse.de>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527051525.762-1-dwagner@suse.de>
References: <20240527051525.762-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 8348C1F8D6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240526_221551_611601_A8418812 
X-CRM114-Status: GOOD (  14.80  )
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

We want to display the transport address of the connected host
in debugfs, but this is a property of the transport.
So add a callback 'host_traddr' to allow the transport drivers
to fill in the data.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/core.c    |  8 ++++++++
 drivers/nvme/target/debugfs.c | 19 +++++++++++++++++++
 drivers/nvme/target/nvmet.h   |  4 ++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7c82e33d9347..20b138ed571f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1530,6 +1530,14 @@ void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvmet_ctrl_fatal_error);
 
+ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *ctrl,
+		char *traddr, size_t traddr_len)
+{
+	if (!ctrl->ops->host_traddr)
+		return -EOPNOTSUPP;
+	return ctrl->ops->host_traddr(ctrl, traddr, traddr_len);
+}
+
 static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 		const char *subsysnqn)
 {
diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index d60778b0a4b0..cb2befc8619e 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -115,6 +115,23 @@ static ssize_t nvmet_ctrl_state_write(struct file *file, const char __user *buf,
 }
 NVMET_DEBUGFS_RW_ATTR(nvmet_ctrl_state);
 
+static int nvmet_ctrl_host_traddr_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+	ssize_t size;
+	char buf[NVMF_TRADDR_SIZE + 1];
+
+	size = nvmet_ctrl_host_traddr(ctrl, buf, NVMF_TRADDR_SIZE);
+	if (size < 0) {
+		buf[0] = '\0';
+		size = 0;
+	}
+	buf[size] = '\0';
+	seq_printf(m, "%s\n", buf);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_ctrl_host_traddr);
+
 int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 {
 	char name[32];
@@ -138,6 +155,8 @@ int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 			    &nvmet_ctrl_kato_fops);
 	debugfs_create_file("state", S_IRUSR | S_IWUSR, ctrl->debugfs_dir, ctrl,
 			    &nvmet_ctrl_state_fops);
+	debugfs_create_file("host_traddr", S_IRUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_host_traddr_fops);
 	return 0;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index df73a08a657e..5d6adb5c2fc0 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -354,6 +354,8 @@ struct nvmet_fabrics_ops {
 	void (*delete_ctrl)(struct nvmet_ctrl *ctrl);
 	void (*disc_traddr)(struct nvmet_req *req,
 			struct nvmet_port *port, char *traddr);
+	ssize_t (*host_traddr)(struct nvmet_ctrl *ctrl,
+			char *traddr, size_t traddr_len);
 	u16 (*install_queue)(struct nvmet_sq *nvme_sq);
 	void (*discovery_chg)(struct nvmet_port *port);
 	u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
@@ -502,6 +504,8 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
 				       struct nvmet_req *req);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
 u16 nvmet_check_ctrl_status(struct nvmet_req *req);
+ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *ctrl,
+		char *traddr, size_t traddr_len);
 
 struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		enum nvme_subsys_type type);
-- 
2.45.1


