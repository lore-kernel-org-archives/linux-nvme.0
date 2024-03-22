Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8F3C54E71
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 07:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UTqHesu8a6tsRDyxjozmhUCh+yGxZhKTfR8M4PnDDxc=; b=Az45xENHbmwBXCzp/8g9uVMACX
	RlolYvnYCLCGiGY3Dfn3J/7rSi7THoWfx1hc1KDZTE8LiwoSbITbKwSS5d8cBUhcYqT7npwr1cKOr
	F8WXZHU/Stnx9Dr9MUzY1ZZ2TRtu1BdY6TBISAyMYZHooxLtHU4Mthdbff34bwS125NmFxKuVuBGt
	JjnM6Yh4WKsnEVvQVuAEkiHSZkS6HhCvt37K3xp59kZlc6Y0BEQgENWG7T0uytlHXAmQZFtjqs5TD
	thcPRzNpQjOmX2cpBp5lciKcyDCchDy9GAadldE69IrSM4Vm8Z86OxNpURBY6uAuBRaJm3SODYmIg
	Xvya1Odg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnYwP-000000067Qh-2shM;
	Fri, 22 Mar 2024 07:03:49 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnYwM-000000067NK-0N55
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 07:03:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7DD3FCE16FE;
	Fri, 22 Mar 2024 07:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BA6C433C7;
	Fri, 22 Mar 2024 07:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711091023;
	bh=PZpKkPcUORgncStjfVl948zMcCtQdxSHUtknKYSLb98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PF3rQ4Y0E8BBrDAjGSaGbFJwq/HWQz6qZ+csf6VSwjWx65frRARJSVNOlYCm8taOd
	 OX01Y1UBc5E/yZ0wxHyEXUEvInEldX9M6KpmaurdNLqf3+yLvX2G8S77E2y+Tya9CD
	 oOsaEh29jEK55xzIBW3kltd6YpWwH46KZw1NhCCCJPkdytVkMshnYo8+ui1JYKZgBX
	 EjSFNKB2k/tFLZWw6ZeROgkWLLtRaV7kF0z/SfVzua56kgsk6F83euF2f0034jE4kk
	 EwK8OyKx3rrHR8l4xXw0phBlqwrRvF38+bqyHfT7+SBfPrWGaCaTd/IgdAbs82R995
	 yIg2xFCbDXpIA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/8] nvmet-tcp: implement host_traddr()
Date: Fri, 22 Mar 2024 08:03:28 +0100
Message-Id: <20240322070333.3820-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240322070333.3820-1-hare@kernel.org>
References: <20240322070333.3820-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_000346_729953_D5183FFC 
X-CRM114-Status: GOOD (  11.03  )
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

Implement callback to display the host transport address.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/tcp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4718d4d87a85..d890c1a393d8 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2201,6 +2201,19 @@ static void nvmet_tcp_disc_port_addr(struct nvmet_req *req,
 	}
 }
 
+static ssize_t nvmet_tcp_host_port_addr(struct nvmet_ctrl *ctrl,
+			char *traddr, size_t traddr_len)
+{
+	struct nvmet_sq *sq = ctrl->sqs[0];
+	struct nvmet_tcp_queue *queue =
+		container_of(sq, struct nvmet_tcp_queue, nvme_sq);
+
+	if (queue->sockaddr_peer.ss_family == AF_UNSPEC)
+		return -EINVAL;
+	return snprintf(traddr, traddr_len, "%pISc",
+			(struct sockaddr *)&queue->sockaddr_peer);
+}
+
 static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_TCP,
@@ -2211,6 +2224,7 @@ static const struct nvmet_fabrics_ops nvmet_tcp_ops = {
 	.delete_ctrl		= nvmet_tcp_delete_ctrl,
 	.install_queue		= nvmet_tcp_install_queue,
 	.disc_traddr		= nvmet_tcp_disc_port_addr,
+	.host_traddr		= nvmet_tcp_host_port_addr,
 };
 
 static int __init nvmet_tcp_init(void)
-- 
2.35.3


