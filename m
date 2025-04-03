Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E2EC3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 07:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qTmMiroN5WTlR4Qwf9hpok5tRac9OxYlNsOIMAJQz1U=; b=F/rgxqUTd6icaZ0pDQt9XA/JMt
	rAsdtSkXEScDL4n9xi9bP0pKVOJvH/IYKoD3giQ70HPCW6fUamgsxpEHNh+unrYdln20vnp0/1snQ
	OcKh+CxPb+XVfD973gTPX6uDy1PdKgjQdkyq67mLL8uibdgPLka/yl9L8MeuU8HrFFI6Qok+wAMFi
	FrdeL42V7xz+ZKGR9XLBFGdReBtd3i61zwNByT1H/LwEYZ88vD/knWeBRF2VOJPIzAZYdzR0Ei4Z3
	1L9mbxZPVK4kPMPcP8/sFXfcMj3RNpoydzy6StWinH80kZnNAVMSEiJXzdWF0lLSsN9gG3rzwpFSH
	2Dpmze0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0ErV-0000000850x-41Nf;
	Thu, 03 Apr 2025 07:19:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0ErT-000000084z5-1BDJ
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 07:19:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 78A8A44685;
	Thu,  3 Apr 2025 07:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E60DC4CEE8;
	Thu,  3 Apr 2025 07:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743664778;
	bh=jmF+MELNUIsTjYw+oIe6HAd+rN0Nz1RH28EAj/ZppYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HRZjDqRBLHwRnYyQ7LsqxblyVj9GLusvIgLz1J6KwcEH5MvS9Y2QyFXpSUPH3ADtP
	 f/plS+XBfi5DPYSDTuqhd4O9fpZyhm4KLP8QXnltd6N13TFTRIJExGxmtVZR6boYJo
	 UCGwDQt9rHrRfuJireyWaRVN/UasBAkpOgrH8MsKEOR/lhHMfC3UEawoHxBH5EYgM5
	 LoZV1U5ORpAlYUxvABodc4cCA7bN03HWSakMn9dHcLs5V5SqKauSRJdLNhSCdWQFDF
	 BnID5CRr4tZTi3mkflUO+3vs9GjuEtF+5JtCaggHdWK959AMK0+OtD757nYmjxv9tL
	 3B0gR/SbN6rLw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/2] nvme: requeue namespace scan on missed AENs
Date: Thu,  3 Apr 2025 09:19:29 +0200
Message-Id: <20250403071930.52154-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250403071930.52154-1-hare@kernel.org>
References: <20250403071930.52154-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_001939_342944_2B52BA22 
X-CRM114-Status: GOOD (  12.22  )
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

From: Hannes Reinecke <hare@kernel.org

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


