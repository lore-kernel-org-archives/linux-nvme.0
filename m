Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADBAC369A2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 14:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OliiNUB8DiMuhEZ1Uxms/nd0yyiAsC2OC+g8efIpz4s=; b=vjjHta4mUhKRwko1CBQ7rmUf5M
	Qv4PMnbbZDN7FUi+OOuJVfPfIPxZ/QECxJ+WP2vFbV+hXRbHFtXVQlgJU+RdQE43AP+m0/4q5sc1z
	m4h/wfc7m28Avnh2a6n4ReL468S8CkWui4ejKZFxDMFZ54XUFJH9bcyRH0To/4gGznJT2nILM7DKR
	x7W7hThfrdMdM9A4cv3JFrzdmHtgd5CD5h0z/VExLKBBFyhPZeDd+By0aNrQsvYxEM6gZ1X8uMSLO
	k5nv5ghh+dHPKdlqFAYIUa+nPDwi0HrlBF3+szzNktgi9bTv0GEI7YS0jdT2ygKo3xbloRqEk8zG1
	IwvzYUfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4KnB-00000002NS8-2m7R;
	Mon, 14 Apr 2025 14:28:09 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Jpu-000000027YD-04SN
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:26:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7B38243D97;
	Mon, 14 Apr 2025 13:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BE8C4CEE9;
	Mon, 14 Apr 2025 13:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637213;
	bh=Dk7DGQ+Ldoaia2BqL7ftzKH5lZunYpvEa29t/X7CyhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wp6M8RL+N4r8W++cz/SajOHog4LVXZvMLwAacla/oRsx0rvOy87pKolyky/P2g3sL
	 DC5+mcgdx5Ne6qUU+9iTKYeA0++iKkqEepsOT7DrkUfN+WnkIDAUHpU7Te5oIVF6QY
	 3HuXfEO+Rupunho0FgwUsq24s2w0hIHdWQby8zku0DnpzkcxSebDdBNlBtAlcoOMTV
	 WyKN/wsgLXHuBhXg4x3ljl/sPWiPlJRzTwPdXzFT+8oYEh2AnweLAjuty+Y/Hausmv
	 n3hjhcrptxDHZdmmJcSImOxJwOMe//5jsyhBPhq4d9gd9nDy8CqQ/Z9U+iOPB2Nnfu
	 5pIoss8sTcT+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 17/34] nvme: re-read ANA log page after ns scan completes
Date: Mon, 14 Apr 2025 09:25:53 -0400
Message-Id: <20250414132610.677644-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132610.677644-1-sashal@kernel.org>
References: <20250414132610.677644-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.2
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_062654_084401_8333F8D7 
X-CRM114-Status: GOOD (  12.14  )
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
index 70f9c2d2b1130..edee1ec3d4780 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4296,6 +4296,11 @@ static void nvme_scan_work(struct work_struct *work)
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


