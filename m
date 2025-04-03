Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344E1C3601E
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 07:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0g0FtzvSM0q8F6AFdB9/MJaK9GcfiaZxZ4HOL2GRy4M=; b=aYZ8WTCrPnUDoVKZ/qazsShtP2
	Ecc7kp3/cjvN3b4RuBREsVQ2CkhiGLsuglwYl218yQq9IqBPJnLHcHHnMSDrAZovyb1D1MOJxn3iO
	haLZvk+012XVK3GPbWdTFMkgoeR2ACqI7zzQW1yu96RAuPWcwv1damgMK2ZEvysxRyOrSb7kGGSqj
	wn/ocH1Hm8BTfOkPR+LYEXc9YWomvSi2tbLlLzksm1PEwWnjOyXsEobmb7sxBcYS6MiXlL42CdXB+
	SWTf6Y42N5ykHoT6d0AhkYxH6kKmoT0ulBeSW1r03xdOv4DWHb4yisstS87EgFWjAq55KDGqCSy5E
	d+g90ZpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0ErX-0000000852G-36la;
	Thu, 03 Apr 2025 07:19:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0ErV-0000000850K-1sfP
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 07:19:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D4F825C58CA;
	Thu,  3 Apr 2025 07:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A6BC4CEE8;
	Thu,  3 Apr 2025 07:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743664780;
	bh=QQQFVQbz5RDfa2M0T88TBpoqL81Vc26ApU3M/LaQ8nM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BRYdWNsI7/IyTBWF3H1BW9L4E5vst7inStW9rQQ4rMXE29G4OzpkX8L2wy6TGtRxR
	 xZee7BRsVW4/OWFuqNmNEd98okFoAl9SLudNo0HCmj0DpFKMhzFfjIchmiwFgSpZ3s
	 qt3v3wI84pj8YJ0UJVUcn8/MBuL96K1u0R05E4+qlwBq6aUgOn5J+Rf405zITYTf/f
	 FFOveR+keXM89pRZ6KyXl2ivvcTEi9X8XJ/qaJLSe3gxOoQveMzw4H3NO1csVIQcVG
	 v7UJasRTdK/O4oO32yUY6V2w2uKqBac9CknmHFe1EiujOIry76dIaEFI6sl6/Td3qd
	 ju9u/PpXX+F5A==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/2] nvme: re-read ANA log page after ns scan completes
Date: Thu,  3 Apr 2025 09:19:30 +0200
Message-Id: <20250403071930.52154-3-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250403071930.52154-1-hare@kernel.org>
References: <20250403071930.52154-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_001941_573555_F371AB71 
X-CRM114-Status: GOOD (  11.53  )
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

When scanning for new namespaces we might have missed an ANA AEN,
so we should always re-read the ANA log page after scanning to ensure
we don't miss updates there.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 70f9c2d2b113..6197de34c3c8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4296,6 +4296,11 @@ static void nvme_scan_work(struct work_struct *work)
 	/* Requeue if we have missed AENs */
 	if (test_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events))
 		nvme_queue_scan(ctrl);
+#if CONFIG_NVME_MULTIPATH
+	else
+		/* Re-read the ANA log page to not miss updates */
+		queue_work(nvme_wq, &ctrl->ana_work);
+#endif
 }
 
 /*
-- 
2.35.3


