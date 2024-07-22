Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4B2C3DA5D
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 14:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EFF7UL3b12VIPshcqp6HtRhk7crt6qirNr+8ahL0ceU=; b=lkMYqxnqjnmoBFFJ+oHeZQHjOJ
	37yM388cRH+G70SHpnpZEgrtXMhye4yh5r9l+pKbLuAX4NLPu39ljzbqeyQh5w1GeAE3MCUe67oMj
	KdJ44aw3NSBbf3G+wCAnlz4/GiUUSIaQXBsXGwdDLB5iNJRJAf9YkpJ8oWyug+9ftqUhvaP5E4qjy
	ZxaDlmJ1GzMfzVbFAKcPDjOXI9kdHbyxN4KlCQ1ICx7bIMlkh+smi+CNF0ARe5cyJSrDam+R6dUw+
	I4yNEkCkhXFHh6OFJ8t9qwREKb7rWY+z9v/Gj9LOA8+XPQafU1gwwDD3yIvwaCaWbz2W1aUNWZlAF
	obVzDdKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVtvm-00000009lS9-2kE5;
	Mon, 22 Jul 2024 14:22:26 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVtvi-00000009lNF-1ASf
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 14:22:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 64560CE0B64;
	Mon, 22 Jul 2024 14:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27370C4AF12;
	Mon, 22 Jul 2024 14:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721658139;
	bh=rvxSwaBo/MU49AuTWmCU/bAdU6ldYXcaCYome3zR76g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iC3aEaRKSspVcNhQL6TDXqdnJ6CliDUv2B4uRVv5cAwKCWOCurduQs+Oib4Oo8sEr
	 kTsb94ebTzM4SrcShPE2ubbqztIz8m+nmbncJHqYw8U7h/5n+wAErgiT3cVNXlDYfC
	 n9RS6iDAXbycHom4MlTt8PxuQTdbi2T12gHGclMdT90l1Fo2Myex/J+F7TSfHoN2St
	 mzGkKvIZ70QH2SaAWxGnDNh4jTXulHIchByxcUmQKpzY7mu4Z0/GkkAoHOWIHOLytw
	 ChLVHjjh3SzOUCtH42YK8EAnqwErOPmcunClfYtjae7D+FHAAzp1Q3QSpY8GxUVxdi
	 fpmVDjbR96wvw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 9/9] nvmet: add tls_concat and tls_key debugfs entries
Date: Mon, 22 Jul 2024 16:21:22 +0200
Message-Id: <20240722142122.128258-10-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722142122.128258-1-hare@kernel.org>
References: <20240722142122.128258-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_072222_698425_CFD1128F 
X-CRM114-Status: GOOD (  10.53  )
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
index cb2befc8619e..40e7b834a5eb 100644
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


