Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13DAC021A4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 06:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0o2nF9ryiz3fHW2ZTBVFetwAD03gPJmXbGfbOk9p06Y=; b=BnSfy5VjVMSae0SFJQJv5JGhug
	U4sGb90m+XiG/Qi0xjkFAlhgmWquMW1t0nA0WvlmSWUvForEXH0w/vYuywml8X8kqty5DJefkS1/X
	WIz+XJ4nd51vNOupt8R1hhpH91sgU9hhe1xq+up94l4Mj7f/im+RlMECkLwH6Ef13F1+1VJXXu0wt
	2GAlnZGfLkVBzCHh3RMYnwzFsImkexkk22uiHvQKQ5m3L7yjFxY0RxMC50nlJeWpoIzLnelZ9+9uo
	i0nQXlqtijUvDJ+oJoBaDJCUFURHm8Jf0ZiuaQFCJrC6oo5NLhH2qQMrTVIvBBVQHDrdha1o+Eg9Z
	UKZnRYdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT5T-0000000A0IC-0R1F;
	Thu, 13 Feb 2025 06:52:39 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiT5P-0000000A0Et-0U70
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 06:52:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0F0AD5C4941;
	Thu, 13 Feb 2025 06:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FBBC4CED1;
	Thu, 13 Feb 2025 06:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739429554;
	bh=lMETJY8ozuztH65qpVwvRYDO+UnOyyocTaQUpCiuy2A=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=peIfEZvwP2ngcniWOHbjtqYUi7tBSv4RY3zgW+grtZY4iMF58zHB2Y2ng2xSXt67G
	 0tCW2obdnSSRktia8FL1MR8+K/sVr10l8ZJMXL/w06Wjp7W4kYxVppPu6LsVJ1kOgT
	 OnzED19k0xSqWCxSoXoTlzDCOA2YG3M4lnSVJvNE24L608jCyEOBlwEqge1/Ct2hyD
	 EOlvbnMzcxgGWYGkh9zbTYkR3JqoATetNa83RYn4jcvddgAE92OvEdh0cmr2mKeBQy
	 Kebt20rue6VT3+1NPv2dg84EX1nKH+mY/1DM/hxS3xTzdcqDBnGwyRIk9zEYvwHR4/
	 eq416ysPSW+Fg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v3 2/4] nvmet: pci-epf: Do not uselessly write the CSTS register
Date: Thu, 13 Feb 2025 15:52:29 +0900
Message-ID: <20250213065231.598527-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213065231.598527-1-dlemoal@kernel.org>
References: <20250213065231.598527-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_225235_245569_7FB09313 
X-CRM114-Status: GOOD (  15.52  )
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

The function nvmet_pci_epf_poll_cc_work() will do nothing if there are
no changes to the controller configuration (CC) register. However, even
for such case, this function still calls nvmet_update_cc() and uselessly
writes the CSTS register. Avoid this by simply rescheduling the poll_cc
work if the CC register has not changed.

Also reschedule the poll_cc work if the function
nvmet_pci_epf_enable_ctrl() fails to allow the host the chance to try
again enabling the controller.

While at it, since there is no point in trying to handle the CC register
as quickly as possible, change the poll_cc work scheduling interval to
10 ms (from 5ms), to avoid excessive read accesses to that register.

Fixes: 0faa0fe6f90e ("nvmet: New NVMe PCI endpoint function target driver")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/pci-epf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index efd4623fb002..b646a8f468ea 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -46,7 +46,7 @@ static DEFINE_MUTEX(nvmet_pci_epf_ports_mutex);
 /*
  * BAR CC register and SQ polling intervals.
  */
-#define NVMET_PCI_EPF_CC_POLL_INTERVAL	msecs_to_jiffies(5)
+#define NVMET_PCI_EPF_CC_POLL_INTERVAL	msecs_to_jiffies(10)
 #define NVMET_PCI_EPF_SQ_POLL_INTERVAL	msecs_to_jiffies(5)
 #define NVMET_PCI_EPF_SQ_POLL_IDLE	msecs_to_jiffies(5000)
 
@@ -1910,12 +1910,15 @@ static void nvmet_pci_epf_poll_cc_work(struct work_struct *work)
 
 	old_cc = ctrl->cc;
 	new_cc = nvmet_pci_epf_bar_read32(ctrl, NVME_REG_CC);
+	if (new_cc == old_cc)
+		goto reschedule_work;
+
 	ctrl->cc = new_cc;
 
 	if (nvmet_cc_en(new_cc) && !nvmet_cc_en(old_cc)) {
 		ret = nvmet_pci_epf_enable_ctrl(ctrl);
 		if (ret)
-			return;
+			goto reschedule_work;
 	}
 
 	if (!nvmet_cc_en(new_cc) && nvmet_cc_en(old_cc))
@@ -1932,6 +1935,7 @@ static void nvmet_pci_epf_poll_cc_work(struct work_struct *work)
 	nvmet_update_cc(ctrl->tctrl, ctrl->cc);
 	nvmet_pci_epf_bar_write32(ctrl, NVME_REG_CSTS, ctrl->csts);
 
+reschedule_work:
 	schedule_delayed_work(&ctrl->poll_cc, NVMET_PCI_EPF_CC_POLL_INTERVAL);
 }
 
-- 
2.48.1


