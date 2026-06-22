Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DCBECDB46F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 14:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=R5BQMlcA4sBRd56V+bZyV0R8VPpI2nLqvrQGkIMBlao=; b=lyJszOmF6wMnmiklXr2N/QhhZf
	W90dWMYZifZFDtUX31AZOxhAgxRbOT9FWxK3TbzcX5RpsnmTzc48MwgaItA2yYw5ADA1TGLGbV4F7
	tkGzTiszEs1eoXc9k92qt8sWZflIA83k71Oz1cv0BBT4zMP+7r5LakuSXlUYngPIbLa/t2us2A9Kd
	2NucBuV54iqZi3CZSiM5s5OhMzLPFQOo3+MQAWhkaxeuqltLrRNIJc6Skuaj445//MCgv1f6AbEly
	3IlAwpZfNT5JrbesAOBJbBUqabbRp3cc3A0MlpGGAHNAxB7MyNKEnbQ2vtI2doKE3y/ugspdPq0mr
	AS1exKEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbfRU-000000053Xa-1RLo;
	Mon, 22 Jun 2026 14:16:04 +0000
Received: from smtp.missinglinkelectronics.com ([162.55.135.183])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbfRM-000000053WH-2eY1
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 14:15:58 +0000
Received: from ubuntu-server (ppp-88-217-75-1.dynamic.mnet-online.de [88.217.75.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: david)
	by smtp.missinglinkelectronics.com (Postfix) with ESMTPSA id 9FA1B202AB;
	Mon, 22 Jun 2026 16:15:51 +0200 (CEST)
Date: Mon, 22 Jun 2026 16:15:42 +0200
From: David Epping <david.epping@missinglinkelectronics.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leon@kernel.org>,
	Joachim Foerster <joachim.foerster@missinglinkelectronics.com>
Subject: [PATCH RFC] nvme-ioctl: propagate PRP1 from ioctl to admin cmd
Message-ID: <ajlDjpjK_clMrnwx@ubuntu-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_071556_831064_1C322A71 
X-CRM114-Status: GOOD (  19.58  )
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

Hello,

some NVMe admin commands (like IO queue creation) require information to
be provided via the PRP1 field of the command.
This information has not previously been passed from the ioctl to the NVMe
command structure, which prevented execution of such commands from userspace.
Likely this is not an oversight but intentional because of security concerns?

With this email I'm seeking to see if there is interest in getting support
for userspace NVMe IO queue creation in the upstream driver.
The attached patch is one way to do it and has been used for multiple years
with multiple Kernel versions now. There are additional patches required to
for example allocate sufficiently many IO queues at initialization time, but
I would like to focus on the ability to create queues for now.
A final patch would also not ignore nvme_user_cmd64().

The system setup where this patch has been used is as follows:
- P2P PCIe capable CPU (currently also IOMMU disabled)
- patched Linux in-Kernel NVMe driver for local PCIe NVMe SSDs
- FPGA accelerator implementing NVMe IO queue memory and IO queue handling,
  exposed via PCIe BAR
- vfio-pcie Kernel driver plus vfio userspace FPGA driver / application
- The userspace application creates new NVMe IO queues at the SSD using the
  patched admin ioctl and points them towards the FPGA BAR. It then informs
  the FPGA about the SSD BAR address and IO queue ID. From then on the FPGA
  can access the SSD storage entirely without software interaction.

Since the omition of PRP1 access from userspace is likely intentional, maybe
the discussion and patches by Leon Romanovsky for making dmabuf and p2pdma
available via vfio lead in the right direction:
https://lore.kernel.org/all/20251106-dmabuf-vfio-v7-0-2503bf390699@nvidia.com/

It currently seems focused on SPDK for handling the SSDs in userspace, but the
author also describes it as a general mechanism that can support other
scenarios.
How about having the in-Kernel NVMe driver accept a dmabuf as IO queue location
for creating a new IO queue? And in turn it likely has to provide a small
dmabuf to the FPGA VFIO world for access to the queue doorbells on the SSD.

Looking forward to your feedback,
David

Signed-off-by: David Epping <david.epping@missinglinkelectronics.com>
---
 drivers/nvme/host/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index ca86d3bf7ea4..d5d740f1b554 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -306,6 +306,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.nsid = cpu_to_le32(cmd.nsid);
 	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
 	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
+	c.common.dptr.prp1 = cpu_to_le64(cmd.addr);
 	c.common.cdw10 = cpu_to_le32(cmd.cdw10);
 	c.common.cdw11 = cpu_to_le32(cmd.cdw11);
 	c.common.cdw12 = cpu_to_le32(cmd.cdw12);
-- 
2.43.0


