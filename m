Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F15C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 12:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UL6Ei4t6tWWphjSCj9oLLbjHVJIO6YMp4d75MhGCgZc=; b=LxDeRTA8EuaFppLfZhJBHWjUA9
	rwvbYSG8o4wfMQN/03j4dXd1KiFcwxyaZOa8OT4OuF6HAVdCD3LDev/K72TZGE9lWLJ2GH5FFhO+R
	QZCR+YQWOIaoKT2zN02NrdlcQWuTXKNfISW64vdvDzS3lm9oiPOEDD7EoATggLu0Dv06pWzW08xjv
	i7/F1jL5EDjrSJsB+1MkMytqU/9xQgYqLzkJF97A5xFw7FmvVTKtFgqSk3NUOXzRJioadlRVKG8v6
	ZeuqErrWeQ+B1ZcAo5t1Q/KOxEUwgjtNPL40euNGImoknIIsgiu+gNRTf/JTGJIevioK4dI96RAZx
	a6c9UVCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5X8-00000004NVl-364I;
	Tue, 26 Mar 2024 12:04:02 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp5X3-00000004NTU-3XWr
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 12:03:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 2D5D8CE20B4;
	Tue, 26 Mar 2024 12:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E123C433C7;
	Tue, 26 Mar 2024 12:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711454635;
	bh=rsq+FuvPRM5OSOFdUGAPIGVork/ZdhfoluV5ftgb4Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kxIkt1W7hJ2wIIessQhZSEy3h/WQadMNpt75k7/rJRa8ln2tAiZGXurMkbsH9I2Xr
	 AreMxkEXgD5Wvg4+df0dF7GaJihMNjVAPsq0O0g7awcb+PnLipIkcxgM2qVvGjzmEC
	 zHp6DSp9d/Ivqx4+7Df43MVGsGD+7MSVBkTwx/TJGr6m1kDx877aTYqGjzMiKDY8Z0
	 GJ0HytKgP4Sbu89JJK5VeyQx+k6nRrisVWhh6u5Jy2vnxMBdsqMf40eP9oghNf3L3c
	 ZDmbirKkFs0+8YSR7AWp7H9JGPQarkOiQPMRlBa0M6DoJ+mw2qVzx/vB4ZABlkBP5g
	 egL7aiAfa0bIw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/7] nvmet: add 'host_traddr' callback for debugfs
Date: Tue, 26 Mar 2024 13:03:37 +0100
Message-Id: <20240326120342.105740-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240326120342.105740-1-hare@kernel.org>
References: <20240326120342.105740-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_050358_306592_DE73A1EC 
X-CRM114-Status: GOOD (  13.54  )
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

We want to display the transport address of the connected host
in debugfs, but this is a property of the transport.
So add a callback 'host_traddr' to allow the transport drivers
to fill in the data.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
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
index 45c0483c54fc..60cfb1ab266e 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -115,6 +115,23 @@ static ssize_t nvmet_ctrl_state_write(struct file *file, const char __user *buf,
 }
 NVMET_DEBUGFS_RW_ATTR(nvmet_ctrl_state);
 
+static int nvmet_ctrl_host_traddr_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = (struct nvmet_ctrl *)m->private;
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
index 4f5b0a2f36b9..257cace53924 100644
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
2.35.3


