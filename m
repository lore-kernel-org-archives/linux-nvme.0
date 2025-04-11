Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFFDC369A6
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Apr 2025 01:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WinVfguzPRsu74qaPj7A25N2H5lsh3NkL8nHh8uqUyQ=; b=kFSbM1cc89R7OSI+51BfZtz4YM
	yCNckdAwcj4tu3qcJFBj12LGFXNlxvcnZZOWyn7j359kCSCy5NX4b6wI0Duph3K9S3wYImY4oO3VK
	okdocU3BBcGwKfSV0pJQGaERov7Vqhyy/YNnUYm4jLdyTWN5gqmPG+fFDdQGNoDp6fm4liBL9JLFU
	Rp+MV2HNYUWEoEFOmCZ0Q9XdNVAqnbVBAsPBgpU4AaNkfkGNv9N7VgjpX9S4aQ9y/msYvkTJwzTb3
	i+ylOs5w0vCkrQEsAzwxC4AfuccKdA9YSpYSxzDiPmltlNqpcnZVjzcHvKhv9JN2Jd5fC8TiVMhJr
	L7rlGUZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u33Q3-0000000CGIb-2XNy;
	Fri, 11 Apr 2025 01:42:59 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u33Q0-0000000CGGf-38XG
	for linux-nvme@lists.infradead.org;
	Fri, 11 Apr 2025 01:42:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2B0844A362;
	Fri, 11 Apr 2025 01:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5230DC4CEEA;
	Fri, 11 Apr 2025 01:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744335775;
	bh=KaIk92D4PjbqgRMo/n12W7T656O85u8xJ6lHvkNINKA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bBSl/r3MKcisGffuMpfq7PesdyOnG2XP0PFR6WMBLscNrKqbIYx/cgs87Fv7EKrJ1
	 dbL/bD/N6SoGd5d9XbWhcNuPWe90uDUshWL/EEb1pFmsHN5HnDrq6XOTcw5rFvXkmk
	 WUw8D2x0sUYW0WYNYscqkzJGBhYx9mw169EZbzP38xH8dZfJvEMBvjWPuM5Ef15d7Y
	 ckaj18yGHvk6HL1LsYJsYv02WX5fFPvC9oMFmJzA1ieQ+1qN0HfYg2CdZJsp3kAQPQ
	 D3BZgL+3iD4rqYJ0aAzWPd3zNEehNVyJuTbthc2/wMEAPdk6Lz0df5ky74021Wk7Fp
	 j1xgdIxxlwj1w==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 3/3] nvmet: pci-epf: Cleanup link state management
Date: Fri, 11 Apr 2025 10:42:11 +0900
Message-ID: <20250411014211.1070887-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411014211.1070887-1-dlemoal@kernel.org>
References: <20250411014211.1070887-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_184256_831835_AFEECADF 
X-CRM114-Status: GOOD (  11.93  )
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
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index c3d30d34f8ce..7fab7f3d79b7 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2095,11 +2095,18 @@ static int nvmet_pci_epf_create_ctrl(struct nvmet_pci_epf *nvme_epf,
 
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
@@ -2326,10 +2333,8 @@ static int nvmet_pci_epf_epc_init(struct pci_epf *epf)
 	if (ret)
 		goto out_clear_bar;
 
-	if (!epc_features->linkup_notifier) {
-		ctrl->link_up = true;
+	if (!epc_features->linkup_notifier)
 		nvmet_pci_epf_start_ctrl(&nvme_epf->ctrl);
-	}
 
 	return 0;
 
@@ -2345,7 +2350,6 @@ static void nvmet_pci_epf_epc_deinit(struct pci_epf *epf)
 	struct nvmet_pci_epf *nvme_epf = epf_get_drvdata(epf);
 	struct nvmet_pci_epf_ctrl *ctrl = &nvme_epf->ctrl;
 
-	ctrl->link_up = false;
 	nvmet_pci_epf_destroy_ctrl(ctrl);
 
 	nvmet_pci_epf_deinit_dma(nvme_epf);
@@ -2357,7 +2361,6 @@ static int nvmet_pci_epf_link_up(struct pci_epf *epf)
 	struct nvmet_pci_epf *nvme_epf = epf_get_drvdata(epf);
 	struct nvmet_pci_epf_ctrl *ctrl = &nvme_epf->ctrl;
 
-	ctrl->link_up = true;
 	nvmet_pci_epf_start_ctrl(ctrl);
 
 	return 0;
@@ -2368,7 +2371,6 @@ static int nvmet_pci_epf_link_down(struct pci_epf *epf)
 	struct nvmet_pci_epf *nvme_epf = epf_get_drvdata(epf);
 	struct nvmet_pci_epf_ctrl *ctrl = &nvme_epf->ctrl;
 
-	ctrl->link_up = false;
 	nvmet_pci_epf_stop_ctrl(ctrl);
 
 	return 0;
-- 
2.49.0


