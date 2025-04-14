Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86404C369B9
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 14:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pqg3WOO8vWBL3bwhjNd4U6pyLagpci22rNJUPqCPFG4=; b=K9dD+DTPKj2iUvSEfHRF4bCXDC
	HPYXUctAjRp8Py5/0foj7flqWsiI/huUWfDsG6cZAL9gGtHOt5uSZa59+/a9FNXpKl8DJtG7SjPLi
	zr+r8HAhCzkmxPZGbwhbN+w6Mpeo9aVlu/kC5HL2FGZ7zS9BcjuUu8thDrZiUqVenyBuKMsleVvlS
	X+W19wahG6pz2zwTAWnLVEEMwC92bupbouloPCJvHIe8L0fRK0oFusRnKCR8N8iaSArHMdwwvi6kZ
	j+6GVFs23AqgdIJIjmzEtMFa+7gATWouCV+fcwTvjEuXIfyp0oemCj/40qqXhi+vT3dvVR8zPDmFr
	dx2kosug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4L1m-00000002RYH-3l1N;
	Mon, 14 Apr 2025 14:43:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Jv2-00000002Ad9-3OzX
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:32:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7D626614BD;
	Mon, 14 Apr 2025 13:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48C8C4CEE9;
	Mon, 14 Apr 2025 13:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637531;
	bh=kyogF4eFc8Y+rCLo2T580oxtNnBC/Fq0z7Wi3o7A7jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pIgwFhBE+W5Y1yJRhyMd6lF9WoOu662La/49NwJOdX0FFEkEje8O/NkYJovk/ki+8
	 febZVMwSlIVd0LnYXC/lfzJ6544JnY1agGRCwWXKZSNus2S6ofcIQ9MNGEEcptv++K
	 R7irYS592hQ3aP2FMmpye2xm6lwzteH5W+TX60Mf9EaM8RcvPebLKQgu8viT9WQpR2
	 1McV4PIIivF5MAdgCnn1zbas8jL3cqCCtH3iz1uYAasWkE7ey8a+J4qP6sa33ci0PA
	 pJF2/3cusE9UufLv047XUXnG5LP0wkVmoUaA2iXkJ2FQuXU060weSOebmkekbKB1ya
	 IVYGTlmJp9saQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 06/11] nvme: re-read ANA log page after ns scan completes
Date: Mon, 14 Apr 2025 09:31:53 -0400
Message-Id: <20250414133158.681045-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133158.681045-1-sashal@kernel.org>
References: <20250414133158.681045-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.236
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
index b3ca27b78f030..ada9ec02e9b53 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4269,6 +4269,11 @@ static void nvme_scan_work(struct work_struct *work)
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


