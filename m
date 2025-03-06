Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5615C19F32
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 02:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wXGUQHDt3V1j5vgXYNhevlvl/FzXxzbHTjUJ8Xww2io=; b=FTHan+lPkmjzVPWGXEJwg/b/Qd
	GWIvtHFCvcUiFr9XgnWWFTLyDKYkfRHdP61cC5iTkwQMWL2QHL2U8ihK32gUAk/Fz9FMkOvMIHZz3
	2jtg0RZUBB9ahzbPbdH72zd+ik05zHZFEMWPmczfP0SBJ0pnC+3PaCPJFaMXLShnWsPipHbaBgYv5
	7SHqfzsDOJlI6bMVG/JsQTypaKYkzizADAsw3H83q7KM2on+aQCwaWbPyeBYkRgeYmzgtYFDFFu/l
	lD52Ns8WzN1ec+xsUAquT5XkJCfKhROGp+Lg+RW0vKbTa1XYcqAJzStrY5Tay53/TJ2XX/vMw3/Ft
	ksxqQCcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tq1K3-00000009sr4-42wm;
	Thu, 06 Mar 2025 02:50:55 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tq1Hv-00000009scZ-2iDk
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 02:48:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7F0C1A46613;
	Thu,  6 Mar 2025 02:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF65C4CEE7;
	Thu,  6 Mar 2025 02:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741229321;
	bh=gh+5Lo0bba1Yf9fkC90816oxGrujL43HMhi0a1rbF3c=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fnRLJetk5Ia5UWwKd9H23WI3sPvG6DTVAxKI67vjPbir8v1bsuQEXyAsVYjlAfSkH
	 0frU92X9IThOmgJBHndyon3nsv2sFoA9XKcpijoh94p2AUTJ4P6u0+4yemMOUBSkeb
	 5EZS6H22OpouYTBcAaPJ9QViH+85ku+0G4/+d1WTPSWs4e5YoPoKxLvFC6Zlbv2awl
	 QZo3UvYxmB3smnhU+RnpR2PN2iPaZPhZHhZk6dOd9clin/yFRI95xbcGi/kv9GcMe5
	 kk17rTNXZLY/h5OaGuWzunkNhBzzpTxU2qVvtRjwy6fkrxT3807wZ0H5okVksUmk09
	 mtSzN9wQebxNg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 1/2] nvmet: pci-epf: Set NVMET_PCI_EPF_Q_LIVE when a queue is fully created
Date: Thu,  6 Mar 2025 11:48:26 +0900
Message-ID: <20250306024827.591924-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306024827.591924-1-dlemoal@kernel.org>
References: <20250306024827.591924-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_184844_158903_951FD56F 
X-CRM114-Status: GOOD (  14.94  )
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


