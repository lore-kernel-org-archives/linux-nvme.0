Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C91C3ABC0
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 07:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=seCrdQeW6HaIstfpOPTwIMDgdKQu8hDxODJLLriSgCk=; b=0R7YCoS/T6IrzLeQCZLlPGxCas
	+8JHqeO9/yaxDLlSttiyLEdeuw2Jbf2OiKd+gaHTGUfiyjjxP69uYhiCPQL77YjncxZsYNmkZbzLo
	KXizU7l4beOY39JNFHJZJky1QET5vNLxEDmCzhwKKXGa3TSZFKN8spIFdHb8gx7k9WX7k4R5IA7l5
	RD+b0rPRVSyc1oHptbU3P3RWslLwTcEGa8A9X3T2uuQ9NKlfm2vzNJD3dwktAKvCeyyCCTQd1B8zN
	m22KCR2VZo0WhCZWBuahS7SLaXltNKJmz/L61ViVZoW8Ol4z04Syqpn5GDr4DqFpezbeiNYR/AdqS
	ZYQRhh5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCvHA-0000000HX4s-18t4;
	Thu, 08 May 2025 07:02:36 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCvDe-0000000HWo8-2n55
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 06:58:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0088AA4D9F8;
	Thu,  8 May 2025 06:58:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F51C4CEED;
	Thu,  8 May 2025 06:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746687537;
	bh=m8NzpbAZxINxHHYTCjqszbPSRyL5iuXgOwP6tl5INqM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=L71xfiYRPWxWvR7N39BuJWvmHE5ItVE+fK1XhqgoAlAlrsojDRxBztSEP6S+pUQuE
	 UrLjXFXKHnV+0nPp4R5m7lX0T4jXpSwsMu3p42FZA1bpDZaY+GS1p7Bty6KON7XvBF
	 a596ulRcVsuUD1pjynCf/Kyz/11tlt7v9iBvy/FdPQQhv1JFHv3fV8TpN9AQtICn2h
	 Yev4/a34euJkB1t3GZgWim9u/sl+vs6fWujtqCLZsht7WX2fByzJM9r4OtLcKM2UPj
	 r6ORq47Ga6I1eUv7aHxfNAtnjOqUEB5Sg+sXQj7ewNrc5icIc3pUwXrE1ERxFL21mW
	 LQVLJxVd8Xjig==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/4] nvmet: pci-epf: Clear completion queue IRQ flag on delete
Date: Thu,  8 May 2025 15:57:42 +0900
Message-ID: <20250508065745.389199-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508065745.389199-1-dlemoal@kernel.org>
References: <20250508065745.389199-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_235858_769590_48066CEC 
X-CRM114-Status: GOOD (  10.71  )
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

The function nvmet_pci_epf_delete_cq() unconditionnally calls
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


