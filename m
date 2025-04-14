Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B391C369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F/4c5n/hcL52xPn2a2lFM76E9NFkOziJaQ3DiShk5z8=; b=q0s0pOMU9ywY0+m2uiIjWOICtB
	KusGIQXvDg5l7n5jutP3PgXYcP/iMNWe2QQVO9d1NE3jJOcA+F5Ywml5m506jXo/lzJXbBRLJ5kWT
	ABJ+ZuLau6llwZRlOa2HyxkOS0oj+VNv7KS7fvtgUcDkKQIY3+xDJDBZvNfXECGcUzg65fdXrZ4G4
	/e6n3CFI1sDuS+ERR4Ij0EztN/WR9cb5DOCGw6YobYbxhS1J1bAF3GDiDjCHarM+JXM3qbo4D+LOL
	5QBUX2Pxq8Js0f2odWeaQnus1bQHo1AxX3rzGHMWmcr1Ji3z5WeMX6RbCK803COCSIiCWpA3rEXxs
	lCgv1RQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Ju0-000000029Wu-0bnE;
	Mon, 14 Apr 2025 13:31:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Jty-000000029UB-0kaI
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:31:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 01FDF614BD;
	Mon, 14 Apr 2025 13:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E82C4CEEB;
	Mon, 14 Apr 2025 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637465;
	bh=WLPqhcICB4GH5EgHVdkmVjqhnt+TGeP0aV62tORQN7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JxcKn5XWUeipY+Zis3KdKq7ltrKJoPPM5lbzwRBzHPOc3JkP8liWNDUS2NNg0rDUE
	 D44rLuPt2mLQXkzu6wIURB1GK7Rt+FmZytJ8+Zh/usm2fDXtmOZxEO8ZkXKthrMiIA
	 HAHivKC2w9SX7iVnA6ShXVsfBun7W/aFq1Dlmuj2XNM/69FvO5ygvvzXIQkyI9aNXA
	 BIMbbzgw5yAMV9d/qhL1ifJLC6FtjMzJVPcTeqUyPyH/iKuflYUki7lvgC7jVTSCqO
	 3y+BO+6R3ZjEkfh2yeedxGLowTh+bkTtrWl8ke0VMX43s/EBCVtC92vBeYxgd3FVqy
	 y/sSvG+uL5exg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 08/17] nvme: re-read ANA log page after ns scan completes
Date: Mon, 14 Apr 2025 09:30:39 -0400
Message-Id: <20250414133048.680608-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133048.680608-1-sashal@kernel.org>
References: <20250414133048.680608-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
Content-Transfer-Encoding: 8bit
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

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit 62baf70c327444338c34703c71aa8cc8e4189bd6 ]

When scanning for new namespaces we might have missed an ANA AEN.

The NVMe base spec (NVMe Base Specification v2.1, Figure 151 'Asynchonous
Event Information - Notice': Asymmetric Namespace Access Change) states:

  A controller shall not send this even if an Attached Namespace
  Attribute Changed asynchronous event [...] is sent for the same event.

so we need to re-read the ANA log page after we rescanned the namespace
list to update the ANA states of the new namespaces.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ec73ec1cf0ff5..e199321086f28 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4708,6 +4708,11 @@ static void nvme_scan_work(struct work_struct *work)
 	/* Requeue if we have missed AENs */
 	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
 		nvme_queue_scan(ctrl);
+#ifdef CONFIG_NVME_MULTIPATH
+	else
+		/* Re-read the ANA log page to not miss updates */
+		queue_work(nvme_wq, &ctrl->ana_work);
+#endif
 }
 
 /*
-- 
2.39.5


