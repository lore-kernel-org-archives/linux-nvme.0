Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21423C021A7
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 06:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eRLpdexH/2++JUw+IWHOVifbRRqviBqbK0pGV0nez48=; b=bir8KjzXNd1q+RUOuouLLfmXdt
	aRjASER6Z+RZveRAx+bjacxFZGiwHxKVACzmtc8/GaWGASy46zIXgr1kGV7+ltLrLgsCxg1Z6AEJU
	ht3amtuICzIEI1vzmKS0fCpsaRDNTAxWRNXiiL+wUa8n2QIBcFVT4axs+bIa+TB2Tk0E5Mp/01+FT
	klpFXZ6wkCeYXshbTtMiTT/kj29OIHCoCHS1cMln0pzX9DfFFn0uvEomTtrYocOvJrJIkgeqG3ubX
	9zQiPUlwn5CZ5CXGcsg/R3bgV+5H4OLZGPp0yffE13OKhzCOoEdE1A65mM+dvu+Ti7iSVQZHRXqdU
	PynKsMKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT5S-0000000A0Hg-1xpi;
	Thu, 13 Feb 2025 06:52:38 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT5O-0000000A0Eq-2dgB
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 06:52:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 74556A41E6E;
	Thu, 13 Feb 2025 06:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05735C4CEE7;
	Thu, 13 Feb 2025 06:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739429553;
	bh=0LwTTBcAQJpoadqwsYRYWY1xLCiZ1h49Vgh9hohjbKg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Mq9UVACxhC5EkvvZwZHkbb7zLsyIohbS8NDkcPw6ToSVa3AuMw7aFWDYaCJEkr+QQ
	 f2/3xf80IAdE+H7VXI/3deWsREfIsYfvlR7XY+FnetF5/0OkVVAFYXJKfXB7phcb5R
	 ykt5EY0OFHgfd/uqjUFk4BeZ16QEULkqNvGMQr6KCT44Os13LQz0/enxmZipKqEUZx
	 x4bmR6JsAM3XaAfn9ATUM976k5S25mBMBeBozDv4ZVmyQeMmmvNMZNAMGQJjEdUJAl
	 LiI6H1VyneGs26UIUd0eh/gjwjYDJ+4kS8VfBBJpSd+eOaXI18+G51ZNcdaBvPYA7h
	 tthTQIRoiXnXA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v3 1/4] nvmet: pci-epf: Correctly initialize CSTS when enabling the controller
Date: Thu, 13 Feb 2025 15:52:28 +0900
Message-ID: <20250213065231.598527-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213065231.598527-1-dlemoal@kernel.org>
References: <20250213065231.598527-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_225234_798145_A62D4D17 
X-CRM114-Status: GOOD (  14.85  )
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

The function nvmet_pci_epf_poll_cc_work() sets the NVME_CSTS_RDY bit of
the controller status register (CSTS) when nvmet_pci_epf_enable_ctrl()
returns success. However, since this function can be called several
times (e.g. if the host reboots), instead of setting the bit in
ctrl->csts, initialize this field to only have NVME_CSTS_RDY set.
Conversely, if nvmet_pci_epf_enable_ctrl() fails, make sure to clear all
bits from ctrl->csts.

To simplify nvmet_pci_epf_poll_cc_work(), initialize ctrl->csts to
NVME_CSTS_RDY directly inside nvmet_pci_epf_enable_ctrl() and clear this
field in that function as well in case of a failure. To be consistent,
move clearing the NVME_CSTS_RDY bit from ctrl->csts when the controller
is being disabled from nvmet_pci_epf_poll_cc_work() into
nvmet_pci_epf_disable_ctrl().

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/pci-epf.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index ac30b42cc622..efd4623fb002 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1822,14 +1822,14 @@ static int nvmet_pci_epf_enable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
 	if (ctrl->io_sqes < sizeof(struct nvme_command)) {
 		dev_err(ctrl->dev, "Unsupported I/O SQES %zu (need %zu)\n",
 			ctrl->io_sqes, sizeof(struct nvme_command));
-		return -EINVAL;
+		goto err;
 	}
 
 	ctrl->io_cqes = 1UL << nvmet_cc_iocqes(ctrl->cc);
 	if (ctrl->io_cqes < sizeof(struct nvme_completion)) {
 		dev_err(ctrl->dev, "Unsupported I/O CQES %zu (need %zu)\n",
 			ctrl->io_sqes, sizeof(struct nvme_completion));
-		return -EINVAL;
+		goto err;
 	}
 
 	/* Create the admin queue. */
@@ -1844,7 +1844,7 @@ static int nvmet_pci_epf_enable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
 				qsize, pci_addr, 0);
 	if (status != NVME_SC_SUCCESS) {
 		dev_err(ctrl->dev, "Failed to create admin completion queue\n");
-		return -EINVAL;
+		goto err;
 	}
 
 	qsize = aqa & 0x00000fff;
@@ -1854,17 +1854,22 @@ static int nvmet_pci_epf_enable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
 	if (status != NVME_SC_SUCCESS) {
 		dev_err(ctrl->dev, "Failed to create admin submission queue\n");
 		nvmet_pci_epf_delete_cq(ctrl->tctrl, 0);
-		return -EINVAL;
+		goto err;
 	}
 
 	ctrl->sq_ab = NVMET_PCI_EPF_SQ_AB;
 	ctrl->irq_vector_threshold = NVMET_PCI_EPF_IV_THRESHOLD;
 	ctrl->enabled = true;
+	ctrl->csts = NVME_CSTS_RDY;
 
 	/* Start polling the controller SQs. */
 	schedule_delayed_work(&ctrl->poll_sqs, 0);
 
 	return 0;
+
+err:
+	ctrl->csts = 0;
+	return -EINVAL;
 }
 
 static void nvmet_pci_epf_disable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
@@ -1889,6 +1894,8 @@ static void nvmet_pci_epf_disable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
 	/* Delete the admin queue last. */
 	nvmet_pci_epf_delete_sq(ctrl->tctrl, 0);
 	nvmet_pci_epf_delete_cq(ctrl->tctrl, 0);
+
+	ctrl->csts &= ~NVME_CSTS_RDY;
 }
 
 static void nvmet_pci_epf_poll_cc_work(struct work_struct *work)
@@ -1909,13 +1916,10 @@ static void nvmet_pci_epf_poll_cc_work(struct work_struct *work)
 		ret = nvmet_pci_epf_enable_ctrl(ctrl);
 		if (ret)
 			return;
-		ctrl->csts |= NVME_CSTS_RDY;
 	}
 
-	if (!nvmet_cc_en(new_cc) && nvmet_cc_en(old_cc)) {
+	if (!nvmet_cc_en(new_cc) && nvmet_cc_en(old_cc))
 		nvmet_pci_epf_disable_ctrl(ctrl);
-		ctrl->csts &= ~NVME_CSTS_RDY;
-	}
 
 	if (nvmet_cc_shn(new_cc) && !nvmet_cc_shn(old_cc)) {
 		nvmet_pci_epf_disable_ctrl(ctrl);
-- 
2.48.1


