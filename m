Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C60C36013
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Mar 2025 15:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LYkdRquGzyP4MyaagVRPPsClfvAQADk6NNhNGqHQp48=; b=aSYLHut9SSyMvrIjKFamrMixyB
	soQSNFO58/1xwMh+KJ11Q/ZjVnzT+kp7+liuDurEJ76Xa3qqGBY6z0idR19R1Di7fK+J7ygAn55Q2
	YjTp0ZZTRkMrTOky9WioU95oeU5DNAspFs9sxW1LNj9F7s34VH+4142VHSQlJrAcn2sYPmvuV6kt/
	+yejthffVVDuKmiJgaVy44D+Bt8z5YUaYqqb49/fU62TTP1dkFO5WGZtSSMeVS7oZE+17IePpjX4s
	+TsaFavwlEDsIsVEFUWxXKBQvww6HXbfurbVV+l76BSEfwll+Yp0dB94MIqzrmK9wh5wB666DE4/x
	6AR6C1SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txpTt-0000000BPOj-2BFq;
	Thu, 27 Mar 2025 15:49:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txpTr-0000000BPMl-2JJs
	for linux-nvme@lists.infradead.org;
	Thu, 27 Mar 2025 15:49:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id DB731614B1;
	Thu, 27 Mar 2025 15:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494D2C4CEE5;
	Thu, 27 Mar 2025 15:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743090558;
	bh=9OK112xI42JX1TK6elCwHBwRgKILNDdWUEuYtQQjcVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ed/b8q2DFjLQegeNLXHY0CyIBxXcdxQ1R7ArtWxIvBaLG3hX88o3tOPMg9EVgSDNd
	 03WbUzNoDfn54/SEOyQOreGYQPN3uemdK+lGduqJKrvQARSkYLfuWaKDEljuejKcOU
	 CIDmk9XK2LtjKw54aRX3ERC6/WGEQAZSv7jNJSis/6d+LSqhc66uoXdyUp0fJIlfsO
	 WfO7eYv6jLL9bPgx/6qbmC0HYyJEpdNNCZf6743F/btco6c5riK4NzzBssmNCmNnsh
	 T/sNprVaw3Ngl11civaOi1khFOdbEpHCrkdIU2BILETbkhmk2Prk4egatnfVJt1U5N
	 rGTzxKLul3viw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/5] nvme: requeue namespace scan on missed AENs
Date: Thu, 27 Mar 2025 16:48:53 +0100
Message-Id: <20250327154854.85521-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250327154854.85521-1-hare@kernel.org>
References: <20250327154854.85521-1-hare@kernel.org>
MIME-Version: 1.0
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

From: Hannes Reinecke <hare@suse.de>

Scanning for namespaces can take some time, so if the target is
reconfigured while the scan is running we will miss the AEN.
So check if the NVME_AER_NOTICE_NS_CHANGED bit is set once the scan is
finished, and requeue scanning to pick up any missed changes.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8359d0aa0e44..70f9c2d2b113 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4292,6 +4292,10 @@ static void nvme_scan_work(struct work_struct *work)
 			nvme_scan_ns_sequential(ctrl);
 	}
 	mutex_unlock(&ctrl->scan_lock);
+
+	/* Requeue if we have missed AENs */
+	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
+		nvme_queue_scan(ctrl);
 }
 
 /*
-- 
2.35.3


