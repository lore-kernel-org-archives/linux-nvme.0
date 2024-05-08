Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26869C04FFE
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 10:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J/dgTdF/kE2JqqjxY76af7T8cq+EYKXZVCgGNi269WQ=; b=I7tGnR+ReAaVwuG2U0L2kqP+If
	6dqKBt2l9T6pNS5zMbwTC1VO5+EKwKUe/nTJmDJ5G9hvkV5r5kiU+OSaskq/D4N60pHV4pnJEmC/i
	ZNiw02JQ4quf/bleYBRbg7KW18fh95aeFArMtQ46f/4OUDgc1IJJGCCWZBDqlsVdnePSgAKHdMKnT
	1k+KGH0oFkB1gsl/cZNBmYTfuWtqsRInR8/21Zbi+0plczZ5pPlPD0FvvfcSIHyhMfDLx7hlYpjgo
	Sdif++No2y3mKjixTzHH2dqOfF0XE/neoeavklq5M+q3pOnx+RcRDVF1Nxd63BQV72NSYFiDhK2EJ
	95SCtyvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eTE-0000000EyYl-3pHE;
	Wed, 08 May 2024 10:24:21 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eSj-0000000EyC2-2bdA
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 10:23:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id CF7ACCE1812;
	Wed,  8 May 2024 10:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7496C4AF17;
	Wed,  8 May 2024 10:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715163827;
	bh=mUtIhMjGS50QOgYfOAhkEKxZdu370ZZlFznEsoMouw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DSMZYgWfnbwUetEqs1XniwCkXILHFITzDX0LexF88Vf0jVbruzbLbfFirka2QfsRr
	 2lVLdMDrxs1GO/zT67pucdAXBxgqfN6jI5S+KfHwVfYSgaFmu0Pbe/UV5tBwATY3lJ
	 baQ/90fIxswo6e52xPR30qc76sAnpa2RD3vqV+IiUImeEEATj6Xq9i7sZstGwXUn5Z
	 tIajBlsrgSXiW33iBS5YuAhFK3I9ax0gymHIv44Ldy6/pVcpJCOlhpg0IJhdI2gUs/
	 QpbPbwPU+KDW6eJ0/wQdh/FVUFNP6W1fYH79J3x2rTRKqEDVHTk0cv8x+1YG7655pn
	 ug1DFsMKRa6lQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 14/19] nvme-tcp: reset after recovery for secure concatenation
Date: Wed,  8 May 2024 12:23:00 +0200
Message-Id: <20240508102305.108949-15-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240508102305.108949-1-hare@kernel.org>
References: <20240508102305.108949-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_032350_336470_CC9CEBD5 
X-CRM114-Status: GOOD (  12.93  )
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

With TP8018 a new key will be generated from the DH-HMAC-CHAP
protocol after reset or recovery, but we need to start over
to establish a new TLS connection with the new keys.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/tcp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 42d11c783244..a9fd3169ae45 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2222,6 +2222,22 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl,
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
+	if (ctrl->opts->tls_key && !ctrl->tls_pskid) {
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
@@ -2327,6 +2343,9 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	if (ret)
 		goto requeue;
 
+	if (nvme_tcp_reset_for_secure_concat(ctrl))
+		return;
+
 	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
 			ctrl->nr_reconnects);
 
@@ -2404,6 +2423,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 	if (ret)
 		goto out_fail;
 
+	nvme_tcp_reset_for_secure_concat(ctrl);
 	return;
 
 out_fail:
-- 
2.35.3


