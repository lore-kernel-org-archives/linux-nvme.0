Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6BAC369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 02:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BzCY/WYc8ZGvA7JEnuLqHm79ZJW1u1eZwNXBNZpYhx8=; b=xetABIWiaCd6bQtWvpyUZiM0aB
	HX85xVxp6zDdldNwdOPI48uLUh2ueQMHh47pA4Hd6vEi84+Lb6kb7T2aU4cf9LXm+sq9KulXE9JPd
	bzQ97MSrG/IabOkLkeR/F4Wt7G3MvjwQRdK0ldf35X8AD+RuuRAa3Ie8uoQvSFt2QD1EZMox+NueU
	f3i41aB1+Bldgz89GfBUS4NE11YZsnz4y541qfY/gwiEMWQSTMJMXgZ3u0gd92B19cp2WYVj4vPlW
	SjxXs8x5jOkgMj3AwGpfyq0WrtLbhiw5yxe1Wo8RvNkxy5u2QOHMGejbyy9B+I80dUbnreeQGfG+5
	xVHGtvMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u73JA-00000005b7j-1gVe;
	Tue, 22 Apr 2025 02:24:24 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u73BU-00000005Z7m-45GV
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 02:16:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2268B44DE3;
	Tue, 22 Apr 2025 02:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5775AC4CEEC;
	Tue, 22 Apr 2025 02:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288188;
	bh=QrzVhPOEckdeVgfj7BTtvLJJYq7mpUIxJUdJU3sToRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Je8tMoBIRld8+lQq3a0fPculqIjuVEAi4l0l0OSaDEcxAWA7oLvQk76RDoO475SGW
	 h9GorU6lbiTeH32lULxhnLr88x4YwCbuQLtrWFIjbqMh5rCkDvA5nYPb5QQasCZI68
	 zWawcqfVcBC5axU0OfWOh+0ZQQJRyhlfUsQNyhrUXyd9/iPWglbg67fgpvHxDmyz/y
	 TYKscvfl+bQYyaPt7pCDpRde46IGlcyzEmPvTWKqqV5M5SU6mgqbi10E4sz2nk6eZD
	 zrM87+gyHHxJMgFoL+TgBgyiCMZJsfeo5upVKIb6wJmk+NO0QSoyTlO57CkRh9CApk
	 44e5xWjKBtBQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 21/30] nvmet: pci-epf: cleanup link state management
Date: Mon, 21 Apr 2025 22:15:41 -0400
Message-Id: <20250422021550.1940809-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021550.1940809-1-sashal@kernel.org>
References: <20250422021550.1940809-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.3
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_191629_052618_F7442702 
X-CRM114-Status: GOOD (  12.73  )
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

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit ad91308d3bdeb9d90ef4a400f379ce461f0fb6a7 ]

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
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/pci-epf.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 99563648c318f..094826f81b283 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2084,11 +2084,18 @@ static int nvmet_pci_epf_create_ctrl(struct nvmet_pci_epf *nvme_epf,
 
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
 
 	nvmet_pci_epf_disable_ctrl(ctrl);
@@ -2314,10 +2321,8 @@ static int nvmet_pci_epf_epc_init(struct pci_epf *epf)
 	if (ret)
 		goto out_clear_bar;
 
-	if (!epc_features->linkup_notifier) {
-		ctrl->link_up = true;
+	if (!epc_features->linkup_notifier)
 		nvmet_pci_epf_start_ctrl(&nvme_epf->ctrl);
-	}
 
 	return 0;
 
@@ -2333,7 +2338,6 @@ static void nvmet_pci_epf_epc_deinit(struct pci_epf *epf)
 	struct nvmet_pci_epf *nvme_epf = epf_get_drvdata(epf);
 	struct nvmet_pci_epf_ctrl *ctrl = &nvme_epf->ctrl;
 
-	ctrl->link_up = false;
 	nvmet_pci_epf_destroy_ctrl(ctrl);
 
 	nvmet_pci_epf_deinit_dma(nvme_epf);
@@ -2345,7 +2349,6 @@ static int nvmet_pci_epf_link_up(struct pci_epf *epf)
 	struct nvmet_pci_epf *nvme_epf = epf_get_drvdata(epf);
 	struct nvmet_pci_epf_ctrl *ctrl = &nvme_epf->ctrl;
 
-	ctrl->link_up = true;
 	nvmet_pci_epf_start_ctrl(ctrl);
 
 	return 0;
@@ -2356,7 +2359,6 @@ static int nvmet_pci_epf_link_down(struct pci_epf *epf)
 	struct nvmet_pci_epf *nvme_epf = epf_get_drvdata(epf);
 	struct nvmet_pci_epf_ctrl *ctrl = &nvme_epf->ctrl;
 
-	ctrl->link_up = false;
 	nvmet_pci_epf_stop_ctrl(ctrl);
 
 	return 0;
-- 
2.39.5


