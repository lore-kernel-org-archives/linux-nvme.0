Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D66C369B9
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=goaEgVYAmt4aow4PEsXESAdV3yf6rtorepplz98trVY=; b=2fc1zaS/1yP3iwXRQW+c+PZG8m
	UNPiZq1qYMaEDSLyk4yPRVfSimwt7Gvm6VY7LCgNl+jZlFGcJmuCMMWyBOANVhvEd63j5IEHs+FyY
	mPvwh+SuUkN0hB80kkYo/VY0kdDkHZbQtiqj9V503k2AyA2mjVN3Q61iQI6swp6z0sLBZ6zwODTZN
	kgvKKx/QJzLVPXQAqVRdnX98vjpdUXA4QtSdnv2UNTB23z362mKkGB9n5oqAuK8vOcKS/TjbR3WoI
	JVuqreOKYLee4sh/xpIkfnGPKXZ8ou05rhC00Z7WK4MVa+1l4W/oFzG9yJSjfjeiOvjRmFk04EABY
	rpANDKUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JtF-000000028kk-0MQR;
	Mon, 14 Apr 2025 13:30:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JsI-000000028TP-17VD
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:29:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 05C1149F50;
	Mon, 14 Apr 2025 13:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAAABC4CEE9;
	Mon, 14 Apr 2025 13:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637361;
	bh=Pg6gCQBdEpkh4I0IgeWbw45o0IqIzFFpIq3s+sJzhjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RElN7r77S5yWeybi5dbMERozugb2jENe79wBMaCC3loszV37oarvgwkVsOdoXqPA5
	 COO5OspkEOrfxzrcHwwUeLsDykD3SL4jyMiNU4/6c9DeUMz3FrcsSAzH6IZK2MGRlb
	 EvqChYeqEVDJ5XywFxalxUfnM9ZJSizf4rOUKnmXTg78AzYlau4e9Dm018IgSx6DD0
	 LYFFCT0SV6giEj22vUXGuB/7I+M+Qx4vZbyYBnC4Xm4qRJhHvfAYbZNPUFyag3WvMH
	 RZhiCs8iad8FYcn8Aei4jGQwRfRNrLM4gekxVoO7kyLO40S47WGgUXxm0oQPfV74KG
	 2Yy2iQGk4kWFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 13/30] nvme: re-read ANA log page after ns scan completes
Date: Mon, 14 Apr 2025 09:28:30 -0400
Message-Id: <20250414132848.679855-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132848.679855-1-sashal@kernel.org>
References: <20250414132848.679855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.23
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_062922_326516_C5A5DA1D 
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
index 587385b59b865..f7519c07ed3c4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4277,6 +4277,11 @@ static void nvme_scan_work(struct work_struct *work)
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


