Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F0BD0EE19
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 16:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WCfgG4Q/hqNjaGCID0hHBAcADiZXY55VrrEOgqWyHy4=; b=fxba0fOegyCBxnrOhkCg08A6Dt
	E5oMGt7YbD3oGgBwwuSe/8W0JW4v75Q+EJ4z29SVzbEwqSbDsOP4XUTeD3bwZOKJHO80AAW2Waqsd
	lRsnB2+/Pd5bcrRWMM7LrtLAKdyGVPDIpzsivyHXMT0SVWfWs4riba/RmwqdLVTiS3ktFIw3KTrBG
	q1P11MpUS4osj3SvM+JLRQm84jtqXRk2qXi2WaNmYOGbdTuNmMTqVwXlXrXypZq09QZI2OmovLEZW
	pFCOS/U59U75U+LlOEYksETpPezX9fAA0bJ4EpQzT1P8CAAmBuyk9mG1UbIsurDdpZEF81Bne0GGV
	MX0ypJlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szI5A-0000000GtwH-1REo;
	Fri, 11 Oct 2024 16:01:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szHz1-0000000Gt2j-1Kfi
	for linux-nvme@bombadil.infradead.org;
	Fri, 11 Oct 2024 15:55:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=WCfgG4Q/hqNjaGCID0hHBAcADiZXY55VrrEOgqWyHy4=; b=X9QFQEk3yW2vEebuIJV1/iofci
	xQyIHnO5rP6KCw+jY9bhdAcdyosATmlh1o5s1beLBPGwbQtCmIlDsjuNyp9Tbf4xUXuQE/jKVW8Du
	QVukffCmoO6RUf7WLUQmp78y7Yjldd6IBxEzesN92/ieXVWK9iO+6JIuuZb5rAFBrkbbXBBc+CjzA
	LoioKZicpRyHHtbh099LGygtByMr96TmFzXFU9ULr6fJWVRPQg+GFcfD/ZYo2WXL4K/f7+c4rDDd+
	Xe952VtYXEWEIY0LNR3CNrKQ+1YyMzuZQ3ixvN2BqgTmib2L+HPIEH2L6BsWFsNo2h72ig2HYGM2D
	KOtiXUsw==;
Received: from nyc.source.kernel.org ([147.75.193.91])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szHyy-00000005vGX-11Ix
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 15:55:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 53B89A44B48;
	Fri, 11 Oct 2024 15:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C7DC4CEC7;
	Fri, 11 Oct 2024 15:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728662107;
	bh=Ni4SmrOi1UnoeqmiY/o74ZRh5zVQ9/nk219LQVTeAPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H7JKUkxabHxsa0aWycUFlpvfxP4Sd4tTQSM5nDZpoPokr/xEVFc+hCmlGtyn/QLdP
	 8udTDcdT9A/wQxSY2MFniIaX3SBHKCNkirAlKN3xteLXGkS5B2wekL1zjU/dZzJ0Sg
	 OD5lTJIknFj5/pjEQdGw1ZRUJLcOrUTXF3JavhXndt6yH3jW+XmJ8tv/jdHQ64r06v
	 A9akUfCGrMJ5yO2Vpg8Xn3DCzTYPQ9mbP42Ejjcfyqsgdsr6ts4Oe2tMTetShWw1zy
	 ZBhxqOt2u2jNC7imGuuAR8fNzmsDMU8eVlJfufcGqt75h0aml8epuqcUa+pkRPiRZY
	 Qumk4zlDgzPYA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 9/9] nvmet: add tls_concat and tls_key debugfs entries
Date: Fri, 11 Oct 2024 17:54:30 +0200
Message-Id: <20241011155430.43450-10-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241011155430.43450-1-hare@kernel.org>
References: <20241011155430.43450-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_165512_454218_72D9DD45 
X-CRM114-Status: UNSURE (   9.57  )
X-CRM114-Notice: Please train this message.
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


