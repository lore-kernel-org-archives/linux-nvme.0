Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F72C021B5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 13:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BBfanoehjIOl/xRuIKTYlbH4l3dHlYZOArudczInEPE=; b=mXkY0df3n/tSWhnfPEt0cA0mR5
	DmJU6PjaZXqBdhurBTm2FZvFgxruIAqT18avA4CaXzJ/bxoCb3j2ytKgBIeuFE9WBqDo6HLZ97Kak
	KfgKU4rut3Ba6WhVVI4ZxHomeEdydVDguI03qfTBsIlvMkY0WAajqNiI8hLvJptPx+ru2sz4Ip4y3
	P/fhH6NYB49I2658B5Q4KakLoX7BB20IhuWr+IEEecjip//G5yvN9XSbZCS21PiRN12Q+nWOhrDsS
	jNKdvsRhtd6R3aNKjS8Stw5w48ILrjFXZlVycdoajnk+Me+eBi0qoBQDUrK3FVrsOO3n/UcVTe5+f
	I87hnEHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmYI5-0000000DoR5-1hrG;
	Mon, 24 Feb 2025 13:14:33 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXjY-0000000DibP-2MXe
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 12:38:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E64B75C1D21;
	Mon, 24 Feb 2025 12:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567C0C4CEE8;
	Mon, 24 Feb 2025 12:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740400731;
	bh=Svjuo5V8Wl0PrlCCeCE0EAGZyFEy5Fqm+ODQK619Izs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FdtKOtKyjOmtFbxoqT9lVwj7jbgfnv91yzlzk0A0qZqGmRk3HpFx4u09Eo2TSZ2zs
	 BbpEQYDHoLKZiiDLgnz8lrYWPx9TH9Yw3DEd4GcIs3GhwX+COMuUTuosYP+jNkZO9B
	 DSPNTRnf1XHfsstHFa9m8UlNBycU5LTPBbZDQ3lYCg1AZ+olccDjSz1sXzo1xke6Eh
	 qf+CqWWy3ct2254xkg0vgjafhlBN22HjxmyaM7wWenI9+u/c/cW4xJFmsi+I4Rq38R
	 egbb/CLOPQJTxk4Jl3w9Db/7KOwF+lKssFc1gJkxOVnFg4x57HWsqB1vpgbaDYfN9/
	 BIsOOSrbVbSMA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 10/10] nvmet: add tls_concat and tls_key debugfs entries
Date: Mon, 24 Feb 2025 13:38:18 +0100
Message-Id: <20250224123818.42218-11-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250224123818.42218-1-hare@kernel.org>
References: <20250224123818.42218-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_043852_652362_9743C4C2 
X-CRM114-Status: UNSURE (   9.85  )
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


