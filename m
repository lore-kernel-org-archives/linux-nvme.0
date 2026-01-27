Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7325D2595A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jan 2026 07:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=idOkLLnmCVOgmXLA+cDIFdq4OYM60hXY0LV1Pt4+4XQ=; b=gM2bsemCDgucnWUu8gHR2dCn8U
	df6lzqHt/yakwaguXLIlZmZCtYbXAmmSs64jleWbGDsI/JILSTM/PhD7dpNVDUH15g4XQEwuk0W6j
	kdx7vfF9lLwkSxMpmvNAFCjRCjf3VKID0yWPGUXYJbepgIZeYfHZ9GFjagr6zGbYSjgQ0b1PBIbjJ
	xL2FsbX8+wQwyVG20h3JIfAaWj7k+y1Ag9OcQfeRXRPOnWXBFSXs2PunTL/ZcIA/3FwxP1e45CNf1
	iwiXXYdme4zo1zHKPo7oEeSp1eOGS6ExctQTYmdSOO/rKcq//UTvSCJaH8viiPZO6ZTpfr/mO6q1l
	tiiO3IkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkdaU-0000000Dmk1-3a4e;
	Tue, 27 Jan 2026 07:34:10 +0000
Received: from out30-100.freemail.mail.aliyun.com ([115.124.30.100])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkdaN-0000000Dmhv-2PDD
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jan 2026 07:34:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769499231; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=idOkLLnmCVOgmXLA+cDIFdq4OYM60hXY0LV1Pt4+4XQ=;
	b=dabqMkIZyI+zRgEaL+Ktvrs8Te/whrkQKGkbVtlTD4HUrlN/4Ek83N6pwZWiUZ19sxsCOi8Mdd1nvpSJrZC6ytx61PIJ6iB7+AVaFouctadsKhOeb9MWVd2gFCJlYcLUZfV4LisOwNRwvDRpUSlvp3D65uuBnfDEr37KdATCGDk=
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0Wy-xQPb_1769499226 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Jan 2026 15:33:47 +0800
From: Qinyun Tan <qinyuntan@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	Guixin Liu <kanie@linux.alibaba.com>,
	oliver.yang@linux.alibaba.com,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Qinyun Tan <qinyuntan@linux.alibaba.com>
Subject: [PATCH V1] nvme-pci: disable SR-IOV VFs on driver unbind
Date: Tue, 27 Jan 2026 15:33:44 +0800
Message-ID: <20260127073344.2489873-1-qinyuntan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_233404_384615_9AB39D9A 
X-CRM114-Status: GOOD (  11.50  )
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

The NVMe PCI driver exports the sriov_configure callback via
pci_sriov_configure_simple(), which allows userspace to enable SR-IOV
VFs through sysfs. However, when the PF driver is unbound, the driver
does not disable SR-IOV, leaving VFs orphaned in the system.

This causes the PCI core to emit a warning in pci_iov_remove():
  "driver left SR-IOV enabled after remove"

According to Documentation/PCI/pci-iov-howto.rst, PCI drivers that
support SR-IOV should call pci_disable_sriov() in their remove callback
to properly clean up VFs before the driver is unloaded.

Fix this by disabling SR-IOV in nvme_remove(). If VFs are not assigned
to a guest, disable SR-IOV. If VFs are still assigned, emit a warning
since forcibly disabling would disrupt the guest.

Signed-off-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
Reviewed-by: Xunlei Pang <xlpang@linux.alibaba.com>
Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 58f3097888a7..4f2dc13de48b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3666,6 +3666,15 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
+
+	if (pci_num_vf(pdev)) {
+		if (pci_vfs_assigned(pdev))
+			dev_warn(&pdev->dev,
+				 "WARNING: Removing PF while VFs are assigned - VFs will not be deallocated!\n");
+		else
+			pci_disable_sriov(pdev);
+	}
+
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_dbbuf_dma_free(dev);
-- 
2.43.5


