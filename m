Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FBAD78321
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 14:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BBfanoehjIOl/xRuIKTYlbH4l3dHlYZOArudczInEPE=; b=OFXEt5cgn8uVweV67F7HrUcBIZ
	oTfx0N3G+TkU+dAgrZ5YJzYBP1MQyA5hM/NfXdHfdx6Ys25VaxsT4Zldoxd0Bzm4VvO7G9VnHB0XX
	7PYZKWuSIdRKB2SsVs4jQuQotAoN76TWoVb0vByRhJ82NulrHE5n0uYucq8ND2sXUYbf4uHHgtbsX
	cAMXD7b4zlgHi4LpwxpGisW4jJTKOhsXMs4cibcgquZ8hxc0kqh/4/xsB88y9Q1S2fEekI8/6y7lb
	D1H/BfyFmn8ug+Emkrg+2QArP5tizXpzQ5SAAOAYa681zJjbaEqHVFQdBpmgOnK3AIY+73Ghf3+/F
	z3Pf1yVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI7Sp-00000006RDR-1OhN;
	Mon, 02 Dec 2024 14:31:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI7RY-00000006Qkq-0xw5
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 14:30:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BEEE95C5FFE;
	Mon,  2 Dec 2024 14:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85D0C4CEE0;
	Mon,  2 Dec 2024 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149831;
	bh=Svjuo5V8Wl0PrlCCeCE0EAGZyFEy5Fqm+ODQK619Izs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ts5SCsA8hHVvGW0b1j8JtWJeQprvER+MmBD6Jgk68/j4LH4Hvo4ytmmoBmCov3f2G
	 mPx5uSVqmJaSpOvd2sQJAsR5wasxi8KwZE3/9jAEf01dtKqZElcOqCvlrN9/IsCKoJ
	 birBdQh4QiIq/9oqAFSugvZDLTFJ83pwrewDyazoUu5lB/vG/YkwxVUejNja97gG4i
	 jBPGimXHqxiHHo+s0ojH8gucZbEhhpxNGtvDQOfnNF2/3zugvaFhIY/ct7TaZ+DheY
	 udUCmTZQxGCIWNgttg6GTq26wuCH3hbiuXC4p4nyMgk4yJgjsEP3dDEtsRmN4d2lMB
	 qXi/kwFHJPrUg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 10/10] nvmet: add tls_concat and tls_key debugfs entries
Date: Mon,  2 Dec 2024 15:29:59 +0100
Message-Id: <20241202142959.81321-11-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241202142959.81321-1-hare@kernel.org>
References: <20241202142959.81321-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_063032_306751_3D89C296 
X-CRM114-Status: GOOD (  10.13  )
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


