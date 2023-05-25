Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875BCC77B7E
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ItTSXHgEggm5+/j4eDI9mL6YglFd4wAwIrJ5wJGC3Vo=; b=JCpEhc7vmv1TbSQn8zQ0Ool4Wc
	4iv5mWsjZNa8s0uM7BRVS5ye16+s4d34QRXY5lOG0MsZj5cDvXlTCKlZlc8c+5ZWnoxjvP5IG1soz
	tpdF0AF6n5qVu1bYrkw0PagbDfqVy4RKN1hO3EVLm/5yGqT67BPOaj4Rh3/2ApRzTzlW0NMFqUnve
	zIf/bAZSNwr01b3MkJaTeXYe0iomJ4ZO/DAQNsHhDRzixZ14ErmcwSAqAmIp7W0ZEs0I+UJlM3wPM
	mGMm8SLrfBu86Z3F/DaafQIyuWVBaGpyZCXE/oCMjHgLERX2NEFfH4HYMh4VxWRRb4e8k6dH+FTSQ
	VNgn7JnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Fr8-00HRNs-16;
	Thu, 25 May 2023 18:38:34 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Fr6-00HRMh-0R
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:38:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A55E560C03;
	Thu, 25 May 2023 18:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CD7C433A4;
	Thu, 25 May 2023 18:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685039911;
	bh=lbFJs7EsMCgMNxM7oZIy+eZ6GTedCsCMm64MSxVff7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7CKNgzOpFgSFAJVobltJDoO6EMgKMowsRcoTUPmrZOw/PowawV8s1ZmttabX6+G8
	 JlsPs8f/58zcE1BHIThB+Zph/kGB2xiGSuojdwKGHbSEUMaeGTiPAqDUHDPtwLRSbb
	 LI47BzRxBNh8Q4jNj2PSWDyhM50AUd6USWZ3fstYUBR9TSverJCgNp055jgSJ2dhUE
	 +/c/bWnCtSVjime449pTuoAOhdI/r+RIZAGaPAAb0dhP8GXV7/yc9ZVETaC3vIwMZy
	 fMgGMzDOzUBh+bHEcjnRYKLDQQWbF/NMsPE+Q/UPxPWRGWmCjeLqaaJnjuw/ixiorv
	 qI4uyecuCPVjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 47/57] nvme-multipath: don't call blk_mark_disk_dead in nvme_mpath_remove_disk
Date: Thu, 25 May 2023 14:35:57 -0400
Message-Id: <20230525183607.1793983-47-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_113832_213747_CC796F76 
X-CRM114-Status: GOOD (  12.15  )
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 1743e5f6000901a11f4e1cd741bfa9136f3ec9b1 ]

nvme_mpath_remove_disk is called after del_gendisk, at which point a
blk_mark_disk_dead call doesn't make any sense.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d09ed00701743..f96d330d39641 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -858,7 +858,6 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
-	blk_mark_disk_dead(head->disk);
 	/* make sure all pending bios are cleaned up */
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
-- 
2.39.2


