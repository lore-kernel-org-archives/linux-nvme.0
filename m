Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77544D3C552
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 06:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WCfgG4Q/hqNjaGCID0hHBAcADiZXY55VrrEOgqWyHy4=; b=qP8OZV3wyN5DO3R3V3x8DFHALU
	qUv2MX6NoQIxT0JDtHOE+r7Us8cIWVBogeIHbMag0AuEKaisMQzgajTqXcPm+xpQ0ZAjQgas73YO6
	ErEFPa7rfshC5Lu6cJPACESrYLXeQOWz2XADzxyUj42GqY5S0Vq8Rc0FGNW0QBLhdEiepW/Mg3jUU
	6AjH1dlYVEauFTc1tSk7JzBiDS0cAYY279s0sw36Y6qmAo51F15P5akJRrGtinqK1emWBr3e8y+dZ
	Dgnml1U3fUBhk4HmKp+qpoCtirPYK/K2zspmcf70+MvEh0QMjAR64Fkrd/mHaSMDPW3DgzFEmrUGs
	ULyfNAoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1gZO-0000000H98q-377B;
	Fri, 18 Oct 2024 06:34:42 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1gYy-0000000H931-0x8w
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 06:34:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 457F85C5D16;
	Fri, 18 Oct 2024 06:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10B6C4CEC3;
	Fri, 18 Oct 2024 06:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729233255;
	bh=Ni4SmrOi1UnoeqmiY/o74ZRh5zVQ9/nk219LQVTeAPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+Mmwg3fgmpGVjdbNsOMPdgD4gDj+KwLSsxTyURKKsR9yoJgqVn/ObTUaIs6AN6Zh
	 v0Q4HJBitGYi1/wfhGYbrtUZ4YOxuP9QMRRJGEboL30kdZ1W7cKA9p4Hi60JxGJebl
	 UWpHQs9hYkv+EWyDZYGeWABgnMnderB9MrIqEUFwiezD6CgNEYFeUY+08v3gDYWWxz
	 pCB8FcyzIVnTZzOBy2sxG7g+DNwgmk2JVKvW0IbDmxIH+5Bux6J7senpzBBH3YjrdI
	 JKCa0iAdhv59WzK0eaYE8d2CJz7V+aKxY9y8koARkbHS5hc5hnnAd7vRc0nAjCnLZ/
	 y/eYxtj+AwU2g==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 9/9] nvmet: add tls_concat and tls_key debugfs entries
Date: Fri, 18 Oct 2024 08:33:43 +0200
Message-Id: <20241018063343.39798-10-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241018063343.39798-1-hare@kernel.org>
References: <20241018063343.39798-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_233416_338544_FEE4C9A8 
X-CRM114-Status: GOOD (  10.01  )
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

Add debugfs entries to display the 'concat' and 'tls_key' controller
attributes.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/debugfs.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index 220c7391fc19..e4300eb95101 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -132,6 +132,27 @@ static int nvmet_ctrl_host_traddr_show(struct seq_file *m, void *p)
 }
 NVMET_DEBUGFS_ATTR(nvmet_ctrl_host_traddr);
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static int nvmet_ctrl_tls_key_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+	key_serial_t keyid = nvmet_queue_tls_keyid(ctrl->sqs[0]);
+
+	seq_printf(m, "%08x\n", keyid);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_ctrl_tls_key);
+
+static int nvmet_ctrl_tls_concat_show(struct seq_file *m, void *p)
+{
+	struct nvmet_ctrl *ctrl = m->private;
+
+	seq_printf(m, "%d\n", ctrl->concat);
+	return 0;
+}
+NVMET_DEBUGFS_ATTR(nvmet_ctrl_tls_concat);
+#endif
+
 int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 {
 	char name[32];
@@ -157,6 +178,12 @@ int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 			    &nvmet_ctrl_state_fops);
 	debugfs_create_file("host_traddr", S_IRUSR, ctrl->debugfs_dir, ctrl,
 			    &nvmet_ctrl_host_traddr_fops);
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	debugfs_create_file("tls_concat", S_IRUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_tls_concat_fops);
+	debugfs_create_file("tls_key", S_IRUSR, ctrl->debugfs_dir, ctrl,
+			    &nvmet_ctrl_tls_key_fops);
+#endif
 	return 0;
 }
 
-- 
2.35.3


