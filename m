Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E21AC3ABCD
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 23:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dheRTuf6LdiQpT4PGGfVtaTK5VCNYpu1pJcyROlrfzI=; b=DkkKFx/uDikUQUwQMPF9ZZCzs8
	HaYs7T5n3w4wkHEEdZpyIAGXaMyNqtKfNO+u4n3yISCyeKSWWyxh1ibD83lQbovclSn5HQWtd0Fgl
	Ywiiu5BQ09FSQZSjOZzstymocL0iv8HK9P8B2T1tu4gKU4K+Q6/BSgOZbEt7ow5wQ+udFN0rnTh0P
	AfsuByB4blqGyygKCzewYrEDqqG/we2t7FqnR6r1O96dEQE7nytCHtCNzweJ3jjhBnaPm6MtFVSqh
	7Uzrk8Cizg7p76PGjZOL31pfyAxIboDG5G3LPWuLFsX/fO3V+cYYMioJIMCXsI6nJSrTlEvXaRS0Q
	ucITK+QA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAdD-00000001yr0-3E87;
	Thu, 08 May 2025 23:26:23 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAdB-00000001yo7-1L7t
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 23:26:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9FAC743983;
	Thu,  8 May 2025 23:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE31FC4CEED;
	Thu,  8 May 2025 23:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746746780;
	bh=HzK03H1vckUh7OjzdeU0axHJalPO2JStVVUuKg6KaYA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rETaKZ5ccuGrnNGXQrZhdRq+JHBDSR1Baz7sk/4eHlYdlHiIL1A+z38ko/k7ZOuL/
	 c4W0Jc6hX9aBtoq/RgAajD+e6muAgAMkWSgxXcJKO/7rEKdRn1xzEKJOvwetdzuYeZ
	 011sg7n8qwkG3J1P1TXJ5x6HvgHIX17oQE8O54MtWseZfB10iIXuvhEKag9HQABSdj
	 LkWTFRRjbrtkQEssjWc0/EoxRYFLPn0mEcG6G6FJTl2/ceKlFBrZbrT9U4Z06Su0yJ
	 yADW4s0YcH/0TM2A7lZXc2AE1OOazbRp6Df2oK3FOZcIMyRloX4qAd8g13r7//f9qd
	 F2NMvgz2wAUAg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 5/5] nvmet: pci-epf: Remove NVMET_PCI_EPF_Q_IS_SQ
Date: Fri,  9 May 2025 08:25:04 +0900
Message-ID: <20250508232504.437470-6-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508232504.437470-1-dlemoal@kernel.org>
References: <20250508232504.437470-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_162621_373236_41A5A103 
X-CRM114-Status: GOOD (  10.95  )
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

The flag NVMET_PCI_EPF_Q_IS_SQ is set but never used. Remove it.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 94a908b2340e..7123c855b5a6 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -62,8 +62,7 @@ static DEFINE_MUTEX(nvmet_pci_epf_ports_mutex);
 #define NVMET_PCI_EPF_CQ_RETRY_INTERVAL	msecs_to_jiffies(1)
 
 enum nvmet_pci_epf_queue_flags {
-	NVMET_PCI_EPF_Q_IS_SQ = 0,	/* The queue is a submission queue */
-	NVMET_PCI_EPF_Q_LIVE,		/* The queue is live */
+	NVMET_PCI_EPF_Q_LIVE = 0,	/* The queue is live */
 	NVMET_PCI_EPF_Q_IRQ_ENABLED,	/* IRQ is enabled for this queue */
 };
 
@@ -1542,7 +1541,6 @@ static void nvmet_pci_epf_init_queue(struct nvmet_pci_epf_ctrl *ctrl,
 
 	if (sq) {
 		queue = &ctrl->sq[qid];
-		set_bit(NVMET_PCI_EPF_Q_IS_SQ, &queue->flags);
 	} else {
 		queue = &ctrl->cq[qid];
 		INIT_DELAYED_WORK(&queue->work, nvmet_pci_epf_cq_work);
-- 
2.49.0


