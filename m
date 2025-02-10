Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33F7C0219E
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2025 22:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ypNvO6kzWyWyRrbpM3EloDqd/DA7Hb1F/agQq6iq/xE=; b=kDSdO+YloVTsCG8iug6oj8uEJd
	vZ62VM16CN6vRdmVU7PMiJ4AnfyOAyME2H0FnEvyC41bcQ+lGnfzHn8W3GT2qd9q9jLQpxhJNgA+d
	yf8hE+hvr7QDWPY/1vVe8XXcBnLoy3cNGU7+mTTzPLegukZ4nljhz6krrV313npj3jl3X2ePBuyKu
	qmeDe+IkKQoxhjP1eVfEPyfsQO5rP1wopd5tiXrS7m9AY5zQl+Xs0vbNABqzGK6+n/yO50+TeKpc7
	QxgbeVIAmqiRihg5G+swfdahSSire9eEW3iVD6g88FiLdExrLBEDfVcc0fjk5r8F+7tj1H5Ct9wNs
	ENewwOcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thbx0-00000001arJ-0lSY;
	Mon, 10 Feb 2025 22:08:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thbwy-00000001aqT-1yEO
	for linux-nvme@bombadil.infradead.org;
	Mon, 10 Feb 2025 22:08:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=ypNvO6kzWyWyRrbpM3EloDqd/DA7Hb1F/agQq6iq/xE=; b=ctl+2d1yqhzZWi1w1RfGjX+gVq
	oHRcn6iHQ2KjeWf01h4Px0qhNR6vkfZjxnKx/iCgqrLWSLoZKh1ljZ5zzOJPCBkWNJQUHH2dwJ83q
	7tp0LX+9w9EvYwFA7J4t15dT3oCkQGZqCB3BetD87dq3/e4sdqSWvWvU7/ddY25lxOsqowSWXlEN8
	2xD+GCO8xOy7S2vhjbBwoa+Y0BStPZiXZRz324tG3ScymdiJDu0mMfWyOwGge8+e8+Zqjod2t2SqN
	Qb/UmcMeDQDwpPp/JZiWdYk4m/m2P4SbD1Qy0nKB47PNP8uv+rmsByEV1lQpD3NKHpDK+VcaZAZrU
	AZp74D2w==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thbwk-00000000JCB-04X7
	for linux-nvme@lists.infradead.org;
	Mon, 10 Feb 2025 22:08:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 00B215C53C3;
	Mon, 10 Feb 2025 22:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04DCC4CED1;
	Mon, 10 Feb 2025 22:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739225284;
	bh=goZs3SRLkiPx4wc/cgQK3fOFodtzRedeu96JhKHZwOI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=R9YSigl6y/wc1q4gmLDOvNKCS5vnK3cPyfPq7d0t0A6bwYibrzzNCuLXQKJprmmN2
	 2iw+hWt4AS97fZBIQUs/4dlRyEK/1Gg1yWtq08krI1gVVr6thLCPEQki2ysmJhHLow
	 9Q+1uxtOehr1uoT7p//8Ded4jJzltqAfFat1whMi3niz3skBIaXDumnkPiAU3otFXp
	 NdjnXJX3Y6zos0F8nKStzuhqeY1WnDFn6pljpVQDxwKK/ZD/a7nEJB3DRYJB7mLTkl
	 413K0brt1o/5Uge+lOJrqelou+vu2BvnkSDuSnCCviXmHHg5NxbLvsNuV5DYFyLwNM
	 augleo6qfoE7w==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 2/4] nvmet: pci-epf: Do not uselessly write the CSTS register
Date: Tue, 11 Feb 2025 07:06:55 +0900
Message-ID: <20250210220657.1762684-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210220657.1762684-1-dlemoal@kernel.org>
References: <20250210220657.1762684-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250210_220806_463482_F8511225 
X-CRM114-Status: GOOD (  15.31  )
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


