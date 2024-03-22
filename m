Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD43BCD11BF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 07:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YxsKI+ZaHHtgsjsATeShOprbLjOforkqCd1sOqP0BYc=; b=pQ1iikWtg1I4Y6a2T9uLw5//Ig
	hQmj5U6626BB3JOOUaaVKH2Vx5hijRz7vHNxLONXz3iOZSFh2xlW+ZPnmEnpqXLle+S0Agz/jJHv5
	I98IzET8cQANsqT65CSlByDVUvHQgmo9yss75yK+yyAf9BT2c85+FpbMWFYzDULZsykoGJd9bvod3
	L4otKO3Dxc0Kryr1R4VerLa8piK4nOG6ShxOLPMYExZc91acIuthlsZXvBaH/OniwCawxIbllGcmc
	l3Ihov7AGS4Guyon2KJ3zdtgyJWO+Fx3U1Kr1Vuo18i1sEifxSY5HLLbwVW9vMa/zZ98TqpWp1xwq
	ejumMl4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnYwM-000000067OA-3lx0;
	Fri, 22 Mar 2024 07:03:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnYwI-000000067Lz-30Sa
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 07:03:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3BCB26137B;
	Fri, 22 Mar 2024 07:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0296C43390;
	Fri, 22 Mar 2024 07:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711091022;
	bh=AgtBv75UYnrvg0rG7tnF/VKUQr3sZMDRfbazmjBt24U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cwc6FqPRZrj0D4IwMtLqVrF9Wyo5Yrl7P1n9oVMT8wc1JOertdOHfq4D3Wd4qO0a/
	 oAbmOA3KIcykD/wniIVzUzoG7GniH4Vj1qhwnANeg2Ku/gmVPB6A6xbF7SaNBY/6nR
	 FilGkGhEiqtKeJMIXDg0xV0LZH65CbALJq/IWqWjn4CthE2jqFM81OVFQwq/wbvQnH
	 kfJE32Giq+ymS9gywysoAhVirxZGX8goojMyUI1PNttC+GU6FyGiRVSWCwrnD4GPIk
	 hgqvemsyiwizk808f0bGx9uAXO9Y6GBYKPQ09osiO0VKH9UwNMzsg9cbVLl0k5QWVH
	 A70ljpPTPCT6Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/8] nvmet: add 'host_traddr' callback for debugfs
Date: Fri, 22 Mar 2024 08:03:27 +0100
Message-Id: <20240322070333.3820-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240322070333.3820-1-hare@kernel.org>
References: <20240322070333.3820-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_000342_865143_D9F9383A 
X-CRM114-Status: GOOD (  14.33  )
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
---
 drivers/nvme/target/core.c    |  8 ++++++++
 drivers/nvme/target/debugfs.c | 19 +++++++++++++++++++
 drivers/nvme/target/nvmet.h   |  4 ++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6cd1b92fc500..4955819e4f5f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1527,6 +1527,14 @@ void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl)
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
index 4b9451ad0db9..40eeac97157a 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -114,6 +114,23 @@ static ssize_t nvmet_ctrl_state_write(struct file *file, const char __user *buf,
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
@@ -137,6 +154,8 @@ int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 			    &nvmet_ctrl_kato_fops);
 	debugfs_create_file("state", S_IRUSR | S_IWUSR, ctrl->debugfs_dir, ctrl,
 			    &nvmet_ctrl_state_fops);
+	debugfs_create_file("host_traddr", S_IRUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_host_traddr_fops);
 	return 0;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f0371163cb26..3b7ba6d656cf 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -361,6 +361,8 @@ struct nvmet_fabrics_ops {
 	void (*delete_ctrl)(struct nvmet_ctrl *ctrl);
 	void (*disc_traddr)(struct nvmet_req *req,
 			struct nvmet_port *port, char *traddr);
+	ssize_t (*host_traddr)(struct nvmet_ctrl *ctrl,
+			char *traddr, size_t traddr_len);
 	u16 (*install_queue)(struct nvmet_sq *nvme_sq);
 	void (*discovery_chg)(struct nvmet_port *port);
 	u8 (*get_mdts)(const struct nvmet_ctrl *ctrl);
@@ -509,6 +511,8 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
 				       struct nvmet_req *req);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
 u16 nvmet_check_ctrl_status(struct nvmet_req *req);
+ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *ctrl,
+		char *traddr, size_t traddr_len);
 
 struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		enum nvme_subsys_type type);
-- 
2.35.3


