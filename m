Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAA6C28B22
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 10:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wXGUQHDt3V1j5vgXYNhevlvl/FzXxzbHTjUJ8Xww2io=; b=mOjhbTOuBNwkJzB3yEFwopnPkQ
	KAiDTEPFj9UCyEhvZG61/xrNb18Geh2uW5bcqJ9baEjJkYskjZfwQcqR9WlwFlYUBENxtP0xYcIzm
	hsuGGI3XOey0J/Fdg/2OHnNHhvEtXphiCn73A+v+ldHDfiv16mceyPz8GbjyAzRliFGP5Kl+efnej
	h6Wgytgs8Kq8K4nEmN1ZTw8x+EWAeeWkpiURqoFXv6W/0gEbYFdP+lOFPvRx4Y5Zqn75UIEWFhA/b
	OZccDGeRvUxdVhkgbYY9BBYdZQnNlkSf8sHiMFG8tz2FM5WUbLRlvb9fj9UA2PuXHg3BhfldsPucL
	EQ4CuDRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tq8CN-0000000AaeN-2rcr;
	Thu, 06 Mar 2025 10:11:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tq71R-0000000API4-1YzV
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 08:56:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C3C045C544A;
	Thu,  6 Mar 2025 08:53:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3041C4CEE8;
	Thu,  6 Mar 2025 08:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741251364;
	bh=gh+5Lo0bba1Yf9fkC90816oxGrujL43HMhi0a1rbF3c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k/Cy7Qoo+Md5tzfnDCdLnJtxKiOrYeQYo0NRzUuttL3VEB602Fq2PoFwt6WtsuQIB
	 vuJ5sTdHUh4Cd8Bj8R8W51Ala2SkcZQ0i3q6AFmBR1bAlDXkHl3eQ5lGZNLxE1hPmk
	 SEoMTOMQOqYHXhYjHsiRbkOLxvW/3qT3GMpe9VmEyhOtiI8p3bHIQed9Q893usUBGK
	 jwVKyudThPFnbzWcAqVrNnfbSrCk8XTZSlgoX/nS8IAr9mYjgLHgykwV4/9RpJCWVw
	 p2y6x6zrc9z3Ps65Ai2PUF5RB75vd+j5BG+XnEwoUyN6CUILMR1O7r3oVttYVIZf47
	 NpAjPsy+HVmDg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 1/2] nvmet: pci-epf: Set NVMET_PCI_EPF_Q_LIVE when a queue is fully created
Date: Thu,  6 Mar 2025 17:55:48 +0900
Message-ID: <20250306085549.834943-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306085549.834943-1-dlemoal@kernel.org>
References: <20250306085549.834943-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_005605_487968_07D7963C 
X-CRM114-Status: GOOD (  15.05  )
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

The function nvmet_pci_epf_create_sq() use test_and_set_bit() to check
that a submission queue is not already live and if not, set the
NVMET_PCI_EPF_Q_LIVE queue flag to declare the sq live (ready to use).
However, this is done on entry to the function, before the submission
queue is actually fully initialized and ready to use. This creates a
race situation with the function nvmet_pci_epf_poll_sqs_work() which
looks at the NVMET_PCI_EPF_Q_LIVE queue flag to poll the submission
queue when it is live. This race can lead to invalid DMA transfers if
nvmet_pci_epf_poll_sqs_work() runs after the NVMET_PCI_EPF_Q_LIVE flag
is set but before setting the sq pci address and doorbell ofset.

Avoid this race by only testing the NVMET_PCI_EPF_Q_LIVE flag on entry
to nvmet_pci_epf_create_sq() and setting it after the submission queue
is fully setup before nvmet_pci_epf_create_sq() returns success.
Since the function nvmet_pci_epf_create_cq() also has the same racy flag
setting pattern, also make a similar change in that function.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 565d2bd36dcd..d55ad334670c 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1265,7 +1265,7 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 	struct nvmet_pci_epf_queue *cq = &ctrl->cq[cqid];
 	u16 status;
 
-	if (test_and_set_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags))
+	if (test_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags))
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
 
 	if (!(flags & NVME_QUEUE_PHYS_CONTIG))
@@ -1300,6 +1300,8 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 	if (status != NVME_SC_SUCCESS)
 		goto err;
 
+	set_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags);
+
 	dev_dbg(ctrl->dev, "CQ[%u]: %u entries of %zu B, IRQ vector %u\n",
 		cqid, qsize, cq->qes, cq->vector);
 
@@ -1307,7 +1309,6 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 
 err:
 	clear_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags);
-	clear_bit(NVMET_PCI_EPF_Q_LIVE, &cq->flags);
 	return status;
 }
 
@@ -1333,7 +1334,7 @@ static u16 nvmet_pci_epf_create_sq(struct nvmet_ctrl *tctrl,
 	struct nvmet_pci_epf_queue *sq = &ctrl->sq[sqid];
 	u16 status;
 
-	if (test_and_set_bit(NVMET_PCI_EPF_Q_LIVE, &sq->flags))
+	if (test_bit(NVMET_PCI_EPF_Q_LIVE, &sq->flags))
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
 
 	if (!(flags & NVME_QUEUE_PHYS_CONTIG))
@@ -1355,7 +1356,7 @@ static u16 nvmet_pci_epf_create_sq(struct nvmet_ctrl *tctrl,
 
 	status = nvmet_sq_create(tctrl, &sq->nvme_sq, sqid, sq->depth);
 	if (status != NVME_SC_SUCCESS)
-		goto out_clear_bit;
+		return status;
 
 	sq->iod_wq = alloc_workqueue("sq%d_wq", WQ_UNBOUND,
 				min_t(int, sq->depth, WQ_MAX_ACTIVE), sqid);
@@ -1365,6 +1366,8 @@ static u16 nvmet_pci_epf_create_sq(struct nvmet_ctrl *tctrl,
 		goto out_destroy_sq;
 	}
 
+	set_bit(NVMET_PCI_EPF_Q_LIVE, &sq->flags);
+
 	dev_dbg(ctrl->dev, "SQ[%u]: %u entries of %zu B\n",
 		sqid, qsize, sq->qes);
 
@@ -1372,8 +1375,6 @@ static u16 nvmet_pci_epf_create_sq(struct nvmet_ctrl *tctrl,
 
 out_destroy_sq:
 	nvmet_sq_destroy(&sq->nvme_sq);
-out_clear_bit:
-	clear_bit(NVMET_PCI_EPF_Q_LIVE, &sq->flags);
 	return status;
 }
 
-- 
2.48.1


