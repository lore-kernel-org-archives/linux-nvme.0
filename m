Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D107FC35FFA
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Mar 2025 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P2BB8+66Rs7hS7926cSLCluQKqdYcWqwNgeyx9CqAYI=; b=PsJCxJuZLpax8erO/2O8pGsvk+
	aorrLTtOC1dXAUw84YCyogXa/+Wk2HRzRUXkY9sGJ7BSCJCz2wnU3WwJ4Bz92xX0TX/mL7MNGAgmb
	hr6KGyDKh8JC5GjLGPreWPm1ZgXtjwl92JMOancj497tmYwxYNSPP1G5kksDZQXUgtXx+4qZNLfLz
	47k9DduSM0gs8Z1Sm0Rrm2NJKLkhfXP22yVJ56I/pVb+F5z4jIT+PyRHm8wGoAaACtzFDZKGA1Kn5
	2Bgp4cpvEu1ZBdaY3ueuW2P8J0ZHJLIOdBfaZLHk2m4l/WV+G4J45agi2ki/HE4X134/DSohQs3/3
	JCU+uexw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuDVl-00000003MUz-2g0F;
	Mon, 17 Mar 2025 16:40:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuDTM-00000003Lsx-0wkT
	for linux-nvme@lists.infradead.org;
	Mon, 17 Mar 2025 16:37:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B2E615C4CED;
	Mon, 17 Mar 2025 16:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A0DC4CEE3;
	Mon, 17 Mar 2025 16:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742229471;
	bh=BkW0SLrAWLKbSYBIq6N8mJlIN9WKXlbffIL1rr/w8Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQMADMIRKDRnGL8q96SqVf+4eaUqlZa2z8KPfOebvgLWFlvzKuRE6L5EuCDixiIZb
	 EbAAheTF8eFUShv720RVCdQ3GdhMuJehEHeOLd5Y3ojD0saaWT9MCipyye/I3K2QO8
	 tVCK0wPoHtudYCKKXiHo12wq2lKPIuihOOqjnQeNmJDV0UGPTExhnUsXSieTP/EAZc
	 p6K+TiSBzA2wMD/M07QBDhWSPapD5E/TwBkSlYBaaSNDBakQJ1IQlodM4o4fSjNHMJ
	 q3q0sRxiH4Mh3qAQ5mAzGuHRu9VtFHg5YiIp9clWTpfL9KEmdltpC4CfGJEb2uI6pa
	 5HDTXi7hpGLOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 11/16] nvme-pci: fix stuck reset on concurrent DPC and HP
Date: Mon, 17 Mar 2025 12:37:20 -0400
Message-Id: <20250317163725.1892824-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250317163725.1892824-1-sashal@kernel.org>
References: <20250317163725.1892824-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.7
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250317_093752_353279_2E3B9668 
X-CRM114-Status: GOOD (  19.57  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 3f674e7b670b7b7d9261935820e4eba3c059f835 ]

The PCIe error handling has the nvme driver quiesce the device, attempt
to restart it, then wait for that restart to complete.

A PCIe DPC event also toggles the PCIe link. If the slot doesn't have
out-of-band presence detection, this will trigger a pciehp
re-enumeration.

The error handling that calls nvme_error_resume is holding the device
lock while this happens. This lock blocks pciehp's request to disconnect
the driver from proceeding.

Meanwhile the nvme's reset can't make forward progress because its
device isn't there anymore with outstanding IO, and the timeout handler
won't do anything to fix it because the device is undergoing error
handling.

End result: deadlocked.

Fix this by having the timeout handler short cut the disabling for a
disconnected PCIe device. The downside is that we're relying on an IO
timeout to clean up this mess, which could be a minute by default.

Tested-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 99c2983dbe6c8..ed62932be633f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1412,9 +1412,20 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	struct nvme_dev *dev = nvmeq->dev;
 	struct request *abort_req;
 	struct nvme_command cmd = { };
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 	u8 opcode;
 
+	/*
+	 * Shutdown the device immediately if we see it is disconnected. This
+	 * unblocks PCIe error handling if the nvme driver is waiting in
+	 * error_resume for a device that has been removed. We can't unbind the
+	 * driver while the driver's error callback is waiting to complete, so
+	 * we're relying on a timeout to break that deadlock if a removal
+	 * occurs while reset work is running.
+	 */
+	if (pci_dev_is_disconnected(pdev))
+		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	if (nvme_state_terminal(&dev->ctrl))
 		goto disable;
 
@@ -1422,7 +1433,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	 * the recovery mechanism will surely fail.
 	 */
 	mb();
-	if (pci_channel_offline(to_pci_dev(dev->dev)))
+	if (pci_channel_offline(pdev))
 		return BLK_EH_RESET_TIMER;
 
 	/*
-- 
2.39.5


