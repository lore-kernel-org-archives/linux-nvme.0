Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF43C369A2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 14:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8u/cY9xpQ0WxfFh4jf3Xrtk6a28xE+XXOAXCLJJ5q8Q=; b=V+t0xZYaa8kBFC25lYhGtADSS9
	280LkHDDXGmy92DWhGPg+qGvDS/rt8fF52LWGRZiklRz+hlT06ZhjjE+ZpAxfpgQRMxRti+lzkpaK
	w8LBVz+rMNSpsyxQsO6c0sVq2e8v5Vb6gQ0CFrs+3n3Tgvg8CcxBUbXNmc2lUZtmvef65AwV8/JKK
	4sZ1MfSUiRY+1ywG0Np+DZ8bA51q2iHea7MgMUILir6pjjLU3ZTNrdntPCCmhZ/xjNBuPT+t0QUHP
	6sdn+U91o3n9L0Ow1nSKrhIeSOh3NQpczR9Wx0p3vXiiXVw+gvz9ulMNFoWgi/W+PGxSBdRDB87LR
	WM9tA2sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4L1h-00000002RSI-1mOG;
	Mon, 14 Apr 2025 14:43:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JrD-0000000287u-3xez
	for linux-nvme@bombadil.infradead.org;
	Mon, 14 Apr 2025 13:28:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=8u/cY9xpQ0WxfFh4jf3Xrtk6a28xE+XXOAXCLJJ5q8Q=; b=U0kElfh/PmzpqfiAqD70YGENJv
	0llcvkctZt1oXKKk2jC4v0y2zZ+mD5U3d/Bkz0wxxz0OUibf+qRjQ/3dM6t9LwNdUExKaIaEOi/y8
	NHqPSGoeBRGujC1v3RWQ9XXPmQN1SXdRFKM2JMfrDASsFecB2+Gm+famfm/hEcs2Ktohvl8gyXYxq
	yD07QAO/jIRh263ZVsuZ4S8pPl2009DnbKvNULA/DRcTcrsuZT+OXBQiCP2HQ7aOJ20xZEiXUXwyQ
	1/gNVYU65/LKpIbS8lTRZ+RB0eEKbcMgYzDf4p7kJl5Ly/C1hN+ztSvyuOSaQOXIoq+A8Sf6rfEPf
	8D5SO0Qg==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4JrA-00000009goC-3Ql0
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:28:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8F0364A540;
	Mon, 14 Apr 2025 13:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38004C4CEEB;
	Mon, 14 Apr 2025 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637291;
	bh=aAp+d0HOva9zbinlXjn0QPDZc+oNfOzsnaiqbkQEMKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvS7/WldujpeTgXTpusVUxWGQKG+dONn0SIjRaU4/TnV/Tia5cj+MwPorbbG+pTrD
	 5X7o6082pBVOraL7m1xsg1VxRBWEyPotaG+9HK4/1R2V0EH5ZoHMgnireAlD7aMxct
	 f+CpcC70tcfDAaTNwmE7WTQ+zGDYzlTYaVL3MJTmZSGwm+0SxlwYLxq9qdIWlzaZ6p
	 DpGl9aac0LkrrUCd6zE9VhT0AvVFTtOqLtL5sWYBVkpHOnPVHldmgnI+PkRmDcT+da
	 pX3yr3+H/cZcV7M6Iem+LX1LwrLgZqNU4ySY20ngeyj2wFnQPWsTib4wtHedR5A721
	 mfbC9IliIGdlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 17/34] nvme: re-read ANA log page after ns scan completes
Date: Mon, 14 Apr 2025 09:27:11 -0400
Message-Id: <20250414132729.679254-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_142813_302593_CA50CAD2 
X-CRM114-Status: GOOD (  12.09  )
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
index 1b386889242c3..33184d36310d4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4286,6 +4286,11 @@ static void nvme_scan_work(struct work_struct *work)
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


