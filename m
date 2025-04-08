Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A45C3601E
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 02:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JMWU3zewgX2Te8mTFChuQb1MlCnbRz4KdE2wolSn9h8=; b=PAm1tWiGDlsDa5/SPJcvnnlKaw
	n7NUFLrQlnJ2rMweU3gPMy8XgrcKKEJGfPGpv8ypsKHW7rXEMomTUyOTCz56ddqEGC8Q/d5YsGeeM
	JfFHu2K6ehY/gHNecGGdG6+z3speROzTQ8Lx3+xWQacAfTvzSYuLxVe+ZJ/xlFW6g9pul/aeM6NV4
	o0OwqT8Csm3Kcr/nRwfEMlOil58Zi4YNUH8h9QwUfJO0c9JJobO8f2qAro6bf0tOHvGCgYFRDOJAX
	D+jk8fWjaDv+tqczDPGQ3R2FrAdbixrp2VpKawtilQQxxKoUSJU0Z0ggYuzSaaw4QOeQUuMaf668Z
	Ptolx5Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1z0h-00000002Xvb-2mIQ;
	Tue, 08 Apr 2025 02:48:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1z0e-00000002XuT-3YxQ
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 02:48:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 97B085C4393;
	Tue,  8 Apr 2025 02:46:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F8CC4CEE9;
	Tue,  8 Apr 2025 02:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744080499;
	bh=40F0MtjWEEov4jhoeW7oYC9CJp0vJU6q9GaDB43a7ig=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=EXIbnV77/CkxraIubTqUNmgS45tNww9X9I9w8J8KRxc6to5s6agGLWpcbs0ay5juf
	 sotl5udIUdRQxGt2bvDXK8qvorHxTdkH78Yae+q/Wk6MrE/1Q5GsYXQWFG9g85brK5
	 HcFUzpfx4vF9Ztwrg5MC8r3LoFX4foa1GRpT7bfXJvUzGys4zlbAcbHCnpTqp60dbO
	 qIyhc2LwPz2vpym7N3j2bzUOmEpag6UZq70EaSuuR+b0tqQfEvAr4P/iOZcBNwNnyk
	 SE8Nawy5LPqBsjSW3vAiIqkkgsKKgXZmJuRqVUBnKrIZo8ergCbIT3Zywd8YGUiFmA
	 uJkUhekB7/3Yg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 3/3] nvmet: pci-epf: Cleanup link state management
Date: Tue,  8 Apr 2025 11:47:33 +0900
Message-ID: <20250408024733.690966-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408024733.690966-1-dlemoal@kernel.org>
References: <20250408024733.690966-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_194821_236304_A94D5ED7 
X-CRM114-Status: GOOD (  11.84  )
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

Since the link_up boolean field of struct nvmet_pci_epf_ctrl is always
set to true when nvmet_pci_epf_start_ctrl() is called, assign true to
this field in nvmet_pci_epf_start_ctrl(). Conversely, since this field
is set to false when nvmet_pci_epf_stop_ctrl() is called, set this field
to false directly inside that function.

While at it, also add information messages to notify the user of the PCI
link state changes to help troubleshoot any link stability issues
without needing to enable debug messages.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index f18faf407eab..db2da0595423 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2086,11 +2086,18 @@ static int nvmet_pci_epf_create_ctrl(struct nvmet_pci_epf *nvme_epf,
 
 static void nvmet_pci_epf_start_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
 {
+
+	dev_info(ctrl->dev, "PCI link up\n");
+	ctrl->link_up = true;
+
 	schedule_delayed_work(&ctrl->poll_cc, NVMET_PCI_EPF_CC_POLL_INTERVAL);
 }
 
 static void nvmet_pci_epf_stop_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
 {
+	dev_info(ctrl->dev, "PCI link down\n");
+	ctrl->link_up = false;
+
 	cancel_delayed_work_sync(&ctrl->poll_cc);
 
 	nvmet_pci_epf_disable_ctrl(ctrl, false);
@@ -2317,10 +2324,8 @@ static int nvmet_pci_epf_epc_init(struct pci_epf *epf)
 	if (ret)
 		goto out_clear_bar;
 
-	if (!epc_features->linkup_notifier) {
-		ctrl->link_up = true;
+	if (!epc_features->linkup_notifier)
 		nvmet_pci_epf_start_ctrl(&nvme_epf->ctrl);
-	}
 
 	return 0;
 
@@ -2336,7 +2341,6 @@ static void nvmet_pci_epf_epc_deinit(struct pci_epf *epf)
 	struct nvmet_pci_epf *nvme_epf = epf_get_drvdata(epf);
 	struct nvmet_pci_epf_ctrl *ctrl = &nvme_epf->ctrl;
 
-	ctrl->link_up = false;
 	nvmet_pci_epf_destroy_ctrl(ctrl);
 
 	nvmet_pci_epf_deinit_dma(nvme_epf);
@@ -2348,7 +2352,6 @@ static int nvmet_pci_epf_link_up(struct pci_epf *epf)
 	struct nvmet_pci_epf *nvme_epf = epf_get_drvdata(epf);
 	struct nvmet_pci_epf_ctrl *ctrl = &nvme_epf->ctrl;
 
-	ctrl->link_up = true;
 	nvmet_pci_epf_start_ctrl(ctrl);
 
 	return 0;
@@ -2359,7 +2362,6 @@ static int nvmet_pci_epf_link_down(struct pci_epf *epf)
 	struct nvmet_pci_epf *nvme_epf = epf_get_drvdata(epf);
 	struct nvmet_pci_epf_ctrl *ctrl = &nvme_epf->ctrl;
 
-	ctrl->link_up = false;
 	nvmet_pci_epf_stop_ctrl(ctrl);
 
 	return 0;
-- 
2.49.0


