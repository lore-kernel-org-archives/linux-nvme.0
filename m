Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401A6C54E5D
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XGeaTYwGURPsRa3Wqtd1iU4zGxhbfhPc+yJTc0epHs0=; b=1eBK0bniBFaHiPqHc6JHUb8ldk
	Yt00GgPyGLXaMH5AvgOdqqPPxOwgLOMThTiiABka8W2T09xYRnO/6zqli1qZhqQri2ALdUKVH0vK8
	PVvR+58LuBfDMQSUZYRke99+z+/xeOTiAAAW18lLFrHnmLiFjS4upRgyWgDBvXcDcvBs+7eLjpvCu
	4E3ULpdGdy4vPkLKq/mQMo7BNxbH2DbIB4NN+Kb8krZBrDiOdXIv5K0xameePt953IuB5lCLlmXph
	rwGMExsh+GvwAKfrzdfAR6LyI13+tUwjGtVtCel98wzsx2BvxMMf1c0t1N1GdUnHgLTHlFo4Uy5X+
	94w5D72g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEXY-00000008uyy-0sGR;
	Mon, 18 Mar 2024 15:04:40 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWp-00000008uSJ-38v3
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 15:03:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 08FDECE0AB2;
	Mon, 18 Mar 2024 15:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047B7C43399;
	Mon, 18 Mar 2024 15:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774233;
	bh=hNLdYA3M74MtLYj/W9Lccl8zipyN5IG7h/oyzP2MXPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7guB/nK5C6rCdsgbEvWQuMqL5w5Cd6qmCnzP+h5cFfMeD1nibyqN54sS0hlD0ZhY
	 0XpGkQZbZSng4EFTNVlS6p6f2DjVVo1sZUGExVdnncFieL8kSX/XqJMeNdOzNrmKkl
	 GwMClegqO3SZYyMdZpj/EbymZ+O6i0/c/gkjqCN4rfuFvBRnTlLjpvhnluJ1aKd2Zq
	 PwzFOQ9aYL8v/f0wwd8OoS6SmrxHorIzCM7iPo6wbtbaF0r/fbb7YPHD11ITWnjwkS
	 JZFnkdVBe5lTI5CmSgXDXOx8fgFf/f4zuV0I5CdGLE1zUznW0R/dYL+kjQn+NLUonu
	 ijcD+WQ0IEvrw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 13/17] nvme-tcp: reset after recovery for secure concatenation
Date: Mon, 18 Mar 2024 16:03:12 +0100
Message-Id: <20240318150316.138501-14-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240318150316.138501-1-hare@kernel.org>
References: <20240318150316.138501-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_080356_248081_4CAC4CA9 
X-CRM114-Status: GOOD (  12.72  )
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

From: Hannes Reinecke <hare@suse.de>

With TP8018 a new key will be generated from the DH-HMAC-CHAP
protocol after reset or recovery, but we need to start over
to establish a new TLS connection with the new keys.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 94152ded123a..3811ee9cd040 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2219,6 +2219,22 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 	}
 }
 
+static bool nvme_tcp_reset_for_secure_concat(struct nvme_ctrl *ctrl)
+{
+	if (!ctrl->opts->concat)
+		return false;
+	/*
+	 * If a key has been generated and TLS has not been enabled
+	 * reset the queue to start TLS handshake.
+	 */
+	if (ctrl->opts->tls_key && !ctrl->tls_key) {
+		dev_info(ctrl->device, "Reset to enable TLS with generated PSK\n");
+		nvme_reset_ctrl(ctrl);
+		return true;
+	}
+	return false;
+}
+
 static void nvme_tcp_revoke_generated_tls_key(struct nvme_ctrl *ctrl)
 {
 	if (!ctrl->opts->concat)
@@ -2321,6 +2337,9 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	if (nvme_tcp_setup_ctrl(ctrl, false))
 		goto requeue;
 
+	if (nvme_tcp_reset_for_secure_concat(ctrl))
+		return;
+
 	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
 			ctrl->nr_reconnects);
 
@@ -2396,6 +2415,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 	if (nvme_tcp_setup_ctrl(ctrl, false))
 		goto out_fail;
 
+	nvme_tcp_reset_for_secure_concat(ctrl);
 	return;
 
 out_fail:
-- 
2.35.3


