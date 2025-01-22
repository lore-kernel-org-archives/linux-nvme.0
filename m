Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F285AC0218C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jan 2025 16:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=//TuOGHcrxqgRMUW/2ETf+So2GL36YIwAx6N8FGD+N0=; b=2gjLHmZBMsrd5hBlkVcxqpSObp
	PoKh6SyMbZscKp7+Iz044qJiYBMFPxP6J1QicliVs8u0ANo2QqTolLsH9BohDZ3IUvwQN/IWTVNku
	KXDJw2Cs6yp2fU6TiURsRuTdyIledsDHOTfnInvT5ZO4xjSuItyv+nZO2sKepzipljH8+jMK+ORkA
	7OlQDEC8An4zHiSdmbau2gZmX/eZZ01RVQvTo+Hvu+pR9NAo3FL4oUnFfM0KfzEthJA5CRG9IQLs9
	Npaw+xJJCgvP0tcTP2/7dBo8BEPcOsjoKYkb/XF9yfa6VHiPVt08ncrfuGeYSp4uuvmxzms/VvyOz
	d69ziC1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tae4R-0000000An9K-1TEh;
	Wed, 22 Jan 2025 16:59:15 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tae4O-0000000An4c-0uQK
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jan 2025 16:59:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 53ADF5C608E;
	Wed, 22 Jan 2025 16:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FB1C4CED6;
	Wed, 22 Jan 2025 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737565151;
	bh=NtUlYjdnaYlQXf8s2Lx5MIDIZROeNFKJdmjS1oh5bXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bA8R4NjyjVDhRfgL3x4C6PHPFF3jGaaxG1HutnL4t5CQVgHImRthQ3AvwyWU4UpcX
	 ogow//M6Cyv5w7UB0lAuhMiYCLZa7XVF0g+p42BDjB3vwewXE/Ae9gRPo/kxNnvnA8
	 4n4H+agACYfgK56uYns+a7MKKFIllQ6GsmMjg8UIdm1STmlKYumO4WOaUnB2ODjamm
	 pZfMKA9ZPUo6204XW2iqU0ycvtb1XfuYoSzKQ2PXHzma85SvQFLe63qkex5SbVYVsu
	 zd0NUY4TmLTjElrFJlzGZSkJCf0AePzq+zAIMgwd9HRohdmF0Djm3bajDAo++vKmR8
	 c2V/iMyX240sw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 08/10] nvme-fabrics: reset admin connection for secure concatenation
Date: Wed, 22 Jan 2025 17:58:27 +0100
Message-Id: <20250122165829.11603-9-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250122165829.11603-1-hare@kernel.org>
References: <20250122165829.11603-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250122_085912_347983_53EE3E96 
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

When secure concatenation is requested the connection needs to be
reset to enable TLS encryption on the new cnnection.
That implies that the original connection used for the DH-CHAP
negotiation really shouldn't be used, and we should reset as soon
as the DH-CHAP negotiation has succeeded on the admin queue.

Based on an idea from Sagi.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 66899774805e..e9ff6babc540 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2293,6 +2293,16 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	if (ret)
 		return ret;
 
+	if (ctrl->opts && ctrl->opts->concat && !ctrl->tls_pskid) {
+		/* See comments for nvme_tcp_key_revoke_needed() */
+		dev_dbg(ctrl->device, "restart admin queue for secure concatenation\n");
+		nvme_stop_keep_alive(ctrl);
+		nvme_tcp_teardown_admin_queue(ctrl, false);
+		ret = nvme_tcp_configure_admin_queue(ctrl, false);
+		if (ret)
+			return ret;
+	}
+
 	if (ctrl->icdoff) {
 		ret = -EOPNOTSUPP;
 		dev_err(ctrl->device, "icdoff is not supported!\n");
-- 
2.35.3


