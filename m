Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551CAC02181
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jan 2025 16:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BBfanoehjIOl/xRuIKTYlbH4l3dHlYZOArudczInEPE=; b=AjTIY1p91mtNbum6qWkEK76s/n
	eK+8cDo2j2voBczyZ5LEhtGSpFnr74k08qB09zRwvOCo7gLmPTKr/KlKPcf8vdqELsugvivtOrxsw
	so9Y0i058AeG3KqlA6ES3hAakspKMC8GEmBcHTVyYQK8FbsF2XpBhkOVQRBO+h4pVMa4LKsuqsk14
	GyYNr9/L1X1P/S0ifqkGr0AzS8nO6RiuPyq7UTDTKvi965mPUPQVgYLkKSJ1RXZN2WOFuTKYAIKK3
	EBDJyd4XFR0+75DnqbkaGvanZ9MG7i8jWFWxt3q0QtVr6vjGhUXyEb1j78aR9IqeMM+vpdLX57TrT
	VKT1m8fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tae4U-0000000AnFJ-3bcb;
	Wed, 22 Jan 2025 16:59:19 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tae4R-0000000An9U-3FOw
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jan 2025 16:59:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C8E695C60CD;
	Wed, 22 Jan 2025 16:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972A0C4CED6;
	Wed, 22 Jan 2025 16:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737565154;
	bh=Svjuo5V8Wl0PrlCCeCE0EAGZyFEy5Fqm+ODQK619Izs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iSxdFoZZ8GuRj2RjlszJbP81E6uemZAub32FTS0W6gthHVDZPoTG/Ijx7mAwHqdE3
	 f1DD7/g6WgKaHY8POsVzqHna1u4pECg4+Wksb7thE5xgL8k8iQXAd+Xg9Wa+mmtP5R
	 VUSnOwMotzCZbrVFlytmYUmhSdAPO0ssq1mny21//+FE8rBO7ohPze+UlPGjbUXe1w
	 c6ke2i2CWHDna5c5T1LGw4j5/8/AN+rpANwnqxjPTt7+fvOEa1B6LuZJVLbVWrk9oa
	 i8jinL3XqurO8uMoafq/SfF82S67OIOWVtBVJR/EuiMGUiMRVdpTJSEv6frAreXSi8
	 qmdZPPl7YfEYg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 10/10] nvmet: add tls_concat and tls_key debugfs entries
Date: Wed, 22 Jan 2025 17:58:29 +0100
Message-Id: <20250122165829.11603-11-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250122165829.11603-1-hare@kernel.org>
References: <20250122165829.11603-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250122_085915_860879_944532C5 
X-CRM114-Status: GOOD (  10.38  )
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
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


