Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF56C369A8
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Apr 2025 01:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IJK7Th2wic3SVRdwrwg859ulgKuN6hDf9xc3oPhkopo=; b=imUo864+nBscd/80qGcbofJWQw
	Rr1zQZPSy5k4WYYJAoMnJWp1D7yDFi2kEGaez5HJwE5pAk+bHTrM6IZxbwhB2DI9Qf5yoEv3WS8UQ
	UfhwXqX9TaBIjBO5ZGrUCdbOx4PlaS151KBJw/j7YuclPydtsWma2O0T8m8o1j6snG/EOxuTU6Xag
	2SfpSYgS3hyw8pVQB44Avmy9FMzAVaW6o4FalIFVQeyzwIqTtjwVhKJmIwS29Er56VYZKH3Q3Lg/T
	xGnVIfALo0MwK64AtnDxKFFfPUTPEWAGIunt2MBdwtmbBD49BVLzFoq3kbdwjIcDmT+a1pCkn61LQ
	CHwqvieQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u33Q2-0000000CGI6-4Bk4;
	Fri, 11 Apr 2025 01:42:59 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u33Pz-0000000CGGN-41ck
	for linux-nvme@lists.infradead.org;
	Fri, 11 Apr 2025 01:42:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4DC985C6367;
	Fri, 11 Apr 2025 01:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4FDC4CEE9;
	Fri, 11 Apr 2025 01:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744335775;
	bh=HKvixGZMPdfu8hxVnNeafqo2EP//k5r9OdEXnTrhYow=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f0fJM7MBsnMydaOzE8EAnmi3vvysyhVdgEg00FIGF8/9EH9LSLB+sAX+bGZ0mdklw
	 rImLAxilOmpPj4OIzbWoIWZ01M7B887gXhzsfv2Ai/H0p31wcHajtbbPRDeYcSqvli
	 hPQS1qjL07Loz4taNqmsUUHhlocAwbHlC9UeeX40OArotqonEX3RISBw5lsxLCh8/j
	 iC5kCcS/HNuRTQBIkfmrYnuVSvh3/Brd+OuUG+8OON19Hb2LBhphwsdSrXRx4C/gW3
	 mWnDPgQwu0jOtmyAncKb9amwHBn4Q15BbOdmzfdz4Bqcp/MSDNgWV1uFMxGKZ9EgwN
	 UZCZqO93Yl+Mw==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 2/3] nvmet: pci-epf: Clear CC and CSTS when disabling the controller
Date: Fri, 11 Apr 2025 10:42:10 +0900
Message-ID: <20250411014211.1070887-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411014211.1070887-1-dlemoal@kernel.org>
References: <20250411014211.1070887-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_184256_082827_5EDA90BF 
X-CRM114-Status: GOOD (  17.47  )
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

When a host shuts down the controller when shutting down but does so
without first disabling the controller, the enable bit remains set in
the controller configuration register. When the host restarts and
attempts to enable the controller again, the
nvmet_pci_epf_poll_cc_work() function is unable to detect the change
from 0 to 1 of the enable bit, and thus the controller is not enabled
again, which result in a device scan timeout on the host. This problem
also occurs if the host shuts down uncleanly or if the PCIe link goes
down: as the CC.EN value is not reset, the controller is not enabled
again when the host restarts.

Fix this by introducing the function nvmet_pci_epf_clear_ctrl_config()
to clear the CC and CSTS registers of the controller when the PCIe link
is lost (nvmet_pci_epf_stop_ctrl() function), or when starting the
controller fails (nvmet_pci_epf_enable_ctrl() fails). Also use this
function in nvmet_pci_epf_init_bar() to simplify the initialization of
the CC and CSTS registers.

Furthermore, modify the function nvmet_pci_epf_disable_ctrl() to clear
the CC.EN bit and write this updated value to the BAR register when the
controller is shutdown by the host, to ensure that upon restart, we can
detect the host setting CC.EN.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 49 +++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 43296c05319c..c3d30d34f8ce 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1811,6 +1811,21 @@ static void nvmet_pci_epf_cq_work(struct work_struct *work)
 				   NVMET_PCI_EPF_CQ_RETRY_INTERVAL);
 }
 
+static void nvmet_pci_epf_clear_ctrl_config(struct nvmet_pci_epf_ctrl *ctrl)
+{
+	struct nvmet_ctrl *tctrl = ctrl->tctrl;
+
+	/* Initialize controller status. */
+	tctrl->csts = 0;
+	ctrl->csts = 0;
+	nvmet_pci_epf_bar_write32(ctrl, NVME_REG_CSTS, ctrl->csts);
+
+	/* Initialize controller configuration and start polling. */
+	tctrl->cc = 0;
+	ctrl->cc = 0;
+	nvmet_pci_epf_bar_write32(ctrl, NVME_REG_CC, ctrl->cc);
+}
+
 static int nvmet_pci_epf_enable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
 {
 	u64 pci_addr, asq, acq;
@@ -1876,18 +1891,20 @@ static int nvmet_pci_epf_enable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
 	return 0;
 
 err:
-	ctrl->csts = 0;
+	nvmet_pci_epf_clear_ctrl_config(ctrl);
 	return -EINVAL;
 }
 
-static void nvmet_pci_epf_disable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
+static void nvmet_pci_epf_disable_ctrl(struct nvmet_pci_epf_ctrl *ctrl,
+				       bool shutdown)
 {
 	int qid;
 
 	if (!ctrl->enabled)
 		return;
 
-	dev_info(ctrl->dev, "Disabling controller\n");
+	dev_info(ctrl->dev, "%s controller\n",
+		 shutdown ? "Shutting down" : "Disabling");
 
 	ctrl->enabled = false;
 	cancel_delayed_work_sync(&ctrl->poll_sqs);
@@ -1904,6 +1921,11 @@ static void nvmet_pci_epf_disable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
 	nvmet_pci_epf_delete_cq(ctrl->tctrl, 0);
 
 	ctrl->csts &= ~NVME_CSTS_RDY;
+	if (shutdown) {
+		ctrl->csts |= NVME_CSTS_SHST_CMPLT;
+		ctrl->cc &= ~NVME_CC_ENABLE;
+		nvmet_pci_epf_bar_write32(ctrl, NVME_REG_CC, ctrl->cc);
+	}
 }
 
 static void nvmet_pci_epf_poll_cc_work(struct work_struct *work)
@@ -1930,12 +1952,10 @@ static void nvmet_pci_epf_poll_cc_work(struct work_struct *work)
 	}
 
 	if (!nvmet_cc_en(new_cc) && nvmet_cc_en(old_cc))
-		nvmet_pci_epf_disable_ctrl(ctrl);
+		nvmet_pci_epf_disable_ctrl(ctrl, false);
 
-	if (nvmet_cc_shn(new_cc) && !nvmet_cc_shn(old_cc)) {
-		nvmet_pci_epf_disable_ctrl(ctrl);
-		ctrl->csts |= NVME_CSTS_SHST_CMPLT;
-	}
+	if (nvmet_cc_shn(new_cc) && !nvmet_cc_shn(old_cc))
+		nvmet_pci_epf_disable_ctrl(ctrl, true);
 
 	if (!nvmet_cc_shn(new_cc) && nvmet_cc_shn(old_cc))
 		ctrl->csts &= ~NVME_CSTS_SHST_CMPLT;
@@ -1974,16 +1994,10 @@ static void nvmet_pci_epf_init_bar(struct nvmet_pci_epf_ctrl *ctrl)
 	/* Clear Controller Memory Buffer Supported (CMBS). */
 	ctrl->cap &= ~(0x1ULL << 57);
 
-	/* Controller configuration. */
-	ctrl->cc = tctrl->cc & (~NVME_CC_ENABLE);
-
-	/* Controller status. */
-	ctrl->csts = ctrl->tctrl->csts;
-
 	nvmet_pci_epf_bar_write64(ctrl, NVME_REG_CAP, ctrl->cap);
 	nvmet_pci_epf_bar_write32(ctrl, NVME_REG_VS, tctrl->subsys->ver);
-	nvmet_pci_epf_bar_write32(ctrl, NVME_REG_CSTS, ctrl->csts);
-	nvmet_pci_epf_bar_write32(ctrl, NVME_REG_CC, ctrl->cc);
+
+	nvmet_pci_epf_clear_ctrl_config(ctrl);
 }
 
 static int nvmet_pci_epf_create_ctrl(struct nvmet_pci_epf *nvme_epf,
@@ -2088,7 +2102,8 @@ static void nvmet_pci_epf_stop_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
 {
 	cancel_delayed_work_sync(&ctrl->poll_cc);
 
-	nvmet_pci_epf_disable_ctrl(ctrl);
+	nvmet_pci_epf_disable_ctrl(ctrl, false);
+	nvmet_pci_epf_clear_ctrl_config(ctrl);
 }
 
 static void nvmet_pci_epf_destroy_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
-- 
2.49.0


