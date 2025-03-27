Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F433C3600B
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Mar 2025 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ukZjeb5yzorUeIY0iKDOJcrrYXakDXJW5IykuOp7xro=; b=Qv93q1GVUBR8Pq2yAparjUJo5s
	J/+4kmjuZcGNnBGrt0JHru1tXBiEp6WfKE5hizQ5DUafLFZU48ac6AuRafelW6oX2o8skWN2XUlXI
	ixavgunKRzsKR8PX3BdXPdBsGHrPFXPVc8lchmFatuoAkZkUGaowDBvE2yxkMXKL+uljlX39AKkhS
	+aj3RFvhVyu7Hzy+2wfmxHcGY3nL1STvkW/r5SnN3Bnm5vD/V1bodJeApw61d9ZafeWHayVA367tv
	dxPTiY29gKJj4gTOPwn5Fwcc4RlBXHEZ6rTlVREHoj5OhxFIydWQ0qHZFlGceqCyZyHiJeK6iGrOz
	X1Op3uKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txpTw-0000000BPR0-0ccB;
	Thu, 27 Mar 2025 15:49:24 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txpTt-0000000BPON-2z95
	for linux-nvme@lists.infradead.org;
	Thu, 27 Mar 2025 15:49:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id F3E47A42BAA;
	Thu, 27 Mar 2025 15:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272ACC4CEE5;
	Thu, 27 Mar 2025 15:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743090560;
	bh=Gnnb05QMdOXdB6cAZBedrEKzWpdfC5X+kFtoKECvP7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=StGg1XbTw7MMznekYXKOSEUdhzwShgQH9HUW2mEczLgNowUlhHDVrjVO/spO8goHF
	 xLnd1hHrdqGoB1FLCMWSTm2sivx7ljsMX5WiuxcGcZovhFW7KLF/qs7pjmrDxcZJcx
	 XBqlvJJkz1XqROxPM0dBDEgqvrCmfVyiBdBQRLDnYrftg8Y8JapjYUb4kPj1sXt2zI
	 Ve7Qz1YUlbu5IV3Qs4JXAkfQAnoSfQoZS9N5I929CivJxwgmfKK4XhY/zTDUMw+PjC
	 +Sw5IL7l4P8QSQ9JjW5Ti3gum0rDDXRj9p1RnugEgLLLEMvSiRjycR8yYdeBlGzWMu
	 xmLCLgumvLumg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/5] nvme: re-read ANA log page after ns scan completes
Date: Thu, 27 Mar 2025 16:48:54 +0100
Message-Id: <20250327154854.85521-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250327154854.85521-1-hare@kernel.org>
References: <20250327154854.85521-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250327_084921_820930_CE566529 
X-CRM114-Status: GOOD (  11.83  )
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

When scanning for new namespaces we might have missed an ANA AEN,
so we should always re-read the ANA log page after scanning to ensure
we don't miss updates there.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 70f9c2d2b113..161dd2b49865 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4296,6 +4296,9 @@ static void nvme_scan_work(struct work_struct *work)
 	/* Requeue if we have missed AENs */
 	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
 		nvme_queue_scan(ctrl);
+	else
+		/* Re-read the ANA log page to not miss updates */
+		queue_work(nvme_wq, &ctrl->ana_work);
 }
 
 /*
-- 
2.35.3


