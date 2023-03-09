Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A6AC61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Mar 2023 15:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7QLreyenyaX3qMOy+oTy/O93s5OJaIitPUBMmpmb6uA=; b=O7ZpgtkmQpDNOWOCI+ZV7wXfUW
	1NlDa7wu/xibUpgli8j5BHwCGJr5s6wnJ41N2tkzMaABsjVfTD2fSkO0RITu+FiqoKTYVX+3HJ2XJ
	/8RovL832Atkbes6psNbdZkT+awlo/k/IbGWOHFP8QPsmPLO7pNNeigIsebLir6g09kSv4iaYXcRZ
	tb4vy5VEpefMttuhsk5RFAvSD3Dn5maKXeVpON7kQpJPHuZBG0O2bnAKe7n5BoG0fxaLCLuxD9snG
	Afjpo8HZpmEhIjT2hpjPbVfwJktQS8awtiBtmrX/yPj+WwQFsIw8EeXdFhGMLDuNrAlztflsr537J
	r0qxrGIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paIGg-00Avqm-PB; Thu, 09 Mar 2023 15:33:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paHwW-00AoZH-P8
	for linux-nvme@lists.infradead.org; Thu, 09 Mar 2023 15:12:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D1C8B68AA6; Thu,  9 Mar 2023 16:12:18 +0100 (CET)
Date: Thu, 9 Mar 2023 16:12:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	"Khandelwal, Rajat" <rajat.khandelwal@intel.com>
Subject: Re: [BUG] nvme-pci: NVMe probe fails with ENODEV
Message-ID: <20230309151218.GA17235@lst.de>
References: <f1ad4c1a-2871-57be-48cb-2b0e5cec1bfa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1ad4c1a-2871-57be-48cb-2b0e5cec1bfa@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_071233_013410_F4A28980 
X-CRM114-Status: GOOD (  21.56  )
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

On Thu, Mar 09, 2023 at 07:31:07PM +0530, Rajat Khandelwal wrote:
> Hi,
> I am seeking some help regarding an issue I encounter sporadically
> with Samsung Portable TBT SSD X5.
>
> Right from the thunderbolt discovery to the PCIe enumeration, everything
> is fine, until 'NVME_REG_CSTS' is tried to be read in 'nvme_reset_work'.
> Precisely, 'readl(dev->bar + NVME_REG_CSTS)' fails.
>
> I handle type-C, thunderbolt and USB4 on Chrome platforms, and currently
> we are working on Intel Raptorlake systems.
> This issue has been witnessed from ADL time-frame and now is seen
> on RPL as well. I would really like to get to the bottom of the problem
> and close the issue.
>
> I have tried 5.10 and 6.1.15 kernels.

So we have a quirk for a device called Samsung X5 in core.c, which is a
bit of an unusual match.  Can you check that it gets applied for the
device that you are testing?

Also if it gets applied, can you test this patch?

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2730b116dc680..7eb980105ce6c1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2264,6 +2264,9 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 	u32 csts;
 	int ret;
 
+	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
+		msleep(NVME_QUIRK_DELAY_AMOUNT);
+
 	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
 		if (csts == ~0)
 			return -ENODEV;
@@ -2303,8 +2306,6 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 				       NVME_CSTS_SHST_CMPLT,
 				       ctrl->shutdown_timeout, "shutdown");
 	}
-	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
-		msleep(NVME_QUIRK_DELAY_AMOUNT);
 	return nvme_wait_ready(ctrl, NVME_CSTS_RDY, 0,
 			       (NVME_CAP_TIMEOUT(ctrl->cap) + 1) / 2, "reset");
 }

