Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EEFC3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 23:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SzRSdo6P5s5h8WQdsAIi2ufXKCY4P7VmxdBlIA/9U/I=; b=0590+XXq6rHzqnXfr7wdgAZ9M8
	WtvygNBqZva3k2/M5Cfn64vHnKf3ql+OJOojWiDUhvHNWpo6m+d2gOrWGvqg/HJtxjVENbglF1KSM
	FE5sDQdWWF/+kri2+sa1Yc4gNZtNvcxF2K3pWdovyrxCRikOnMPnYsKfy+c6CXnPf3VnZ6XkS2tZ7
	5HtKrP83Er8oOijJs20hd3hsrjbuOBgwo4D4FC6NSUnT0XqdqoqFaF0UWBWvoW8UztyuaJknhDCNS
	hAalXai3F1enWRKbCj6bF4rKldK08S3eRLbQNeCUofPXpV6UMmOU+4p96/cw9lEUo7hp+b/d2pX33
	DjGm9e/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAdB-00000001yoN-0vXu;
	Thu, 08 May 2025 23:26:21 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDAd7-00000001ymw-3mEz
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 23:26:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E04B35C63DA;
	Thu,  8 May 2025 23:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB12C4CEED;
	Thu,  8 May 2025 23:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746746776;
	bh=PtLXluZk1mcb+xNIv4n9wwlZeEC2Ig431LGTiHzJOqg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=RFp4PHH93zSPkLqN3g0DhPb6ttl6wcgPVUdgtDO2hj7D81gE8/WBzFd+P2J4ilBWS
	 8YvskMC99uvWIDb3X/vW8Z+xL6A/lfymDQYt+pP3YMNBlZq0CrN48xdAvCRuRxNlXT
	 fyyaYB4dZo2hUsfnHxSUR0V3MGgxqhoTSeczwQ5JA1QlnfjDQgLWGxW07YBaEEiFtA
	 ZhkybOe/m/KMIYF1M0NfxyYuRKnkgj8qxmoqPSmhXat5PfLTc3s/fQFWAHxkwK1FoK
	 Cxym8ef6Q7OBwYmLToK5IaLUoy7yNnMOPbX4KEiNoT9sP6brTMPEr+BVdcQ44+feEn
	 D1gozNkIWCmDw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 1/5] nvmet: pci-epf: Clear completion queue IRQ flag on delete
Date: Fri,  9 May 2025 08:25:00 +0900
Message-ID: <20250508232504.437470-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508232504.437470-1-dlemoal@kernel.org>
References: <20250508232504.437470-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_162617_994525_7F4E3093 
X-CRM114-Status: GOOD (  10.99  )
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

The function nvmet_pci_epf_delete_cq() unconditionally calls
nvmet_pci_epf_remove_irq_vector() even for completion queues that do not
have interrupts enabled. Furthermore, for completion queues that do
have IRQ enabled, deleting and re-creating the completion queue leaves
the flag NVMET_PCI_EPF_Q_IRQ_ENABLED set, even if the completion queue
is being re-created with IRQ disabled.

Fix these issues by calling nvmet_pci_epf_remove_irq_vector() only if
NVMET_PCI_EPF_Q_IRQ_ENABLED is set and make sure to always clear that
flag.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 7fab7f3d79b7..d5442991f2fb 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1344,7 +1344,8 @@ static u16 nvmet_pci_epf_delete_cq(struct nvmet_ctrl *tctrl, u16 cqid)
 
 	cancel_delayed_work_sync(&cq->work);
 	nvmet_pci_epf_drain_queue(cq);
-	nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
+	if (test_and_clear_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
+		nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
 	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &cq->pci_map);
 
 	return NVME_SC_SUCCESS;
-- 
2.49.0


