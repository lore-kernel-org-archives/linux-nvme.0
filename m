Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6310D68BCE
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 16:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6lWdOdFFQMQdAlVH7zjIcf3wl0VdAxJVvbIjh8MvAMM=; b=z3z3ohrBQMzREPNyTktZWP96bn
	6LN4fTk4BrnLk8VFnA0irNMvouhL3Cn1kYx6Ojmb1yrzlPaopWZSenbYSpEKEAciIqGcUIQbqs5LO
	N0096RZkPGGeB8C49mGVswm8331GX0Erga/RHfOQMz6z2tLohhi+W+W9axld9Tznx0qX/Z+97R4EA
	nVJdWElTpD9zAE7/m26bGLL6IqEN/MHq/3eWQ+EY6bGUcth7sGuSm0uPuCPVxfHhefxC8oM9IHh/g
	xQ5gE7KxpN74tX5AXF912qERjmpASgnKgQMVgqLukTSx2ytF9wzxvqGYk7nZ41ncIr4/IJWa98FbS
	0bUGtFeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBzKb-00000003MuZ-0o2d;
	Fri, 15 Nov 2024 16:38:01 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBzKY-00000003Ms0-2Kmo
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 16:37:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9543AA42AD1;
	Fri, 15 Nov 2024 16:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2B8C4CED5;
	Fri, 15 Nov 2024 16:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731688677;
	bh=b3SULPoG7TV8R1Uq/VGS/o6LyNqWL9JV5NNkp2h0Sik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DTbph4s8r2YYm6XpOLpxDEG+pIi1dcJgbQwkP9r+Zngp08n26ZOADnmv92f0j85z4
	 JNGF/J/dpE1AD5cwgXP8qLnQ4ZywSjqMMohihayeBVnPJf48hkcR0SxaFwYgiyNe85
	 3YC8BBzhYRlazSVikpMbvUAGmeXY9OjEsQAHkPLMRq9efdbWznllS+VsjUv7EqJP0A
	 OaT1HwEv+fjsGGs4dkVkzJ1nt+QrLDhNZHMAlVFOATSOTgQAY24V+vLOrpzqEG6Emv
	 2oaT1J8BsdwiZ1wcghNFtVhCRIHeB/NWPL4s/j3Eid/fs0aASA/m3jbf7fvKHPDQU9
	 A0ejAc9RlCnxQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 15 Nov 2024 17:37:46 +0100
Subject: [PATCH v5 2/8] PCI: hookup irq_get_affinity callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-refactor-blk-affinity-helpers-v5-2-c472afd84d9f@kernel.org>
References: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_083758_680196_28B20697 
X-CRM114-Status: GOOD (  12.20  )
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

struct bus_type has a new callback for retrieving the IRQ affinity for a
device. Hook this callback up for PCI based devices.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/pci/pci-driver.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 35270172c833186995aebdda6f95ab3ffd7c67a0..a9cb0e3ad2e6eca58c34683303b1242228e96909 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1670,6 +1670,19 @@ static void pci_dma_cleanup(struct device *dev)
 		iommu_device_unuse_default_domain(dev);
 }
 
+/**
+ * pci_device_irq_get_affinity - get IRQ affinity mask for device
+ * @dev: ptr to dev structure
+ * @irq_vec: interrupt vector number
+ *
+ * Return the CPU affinity mask for @dev and @irq_vec.
+ */
+static const struct cpumask *pci_device_irq_get_affinity(struct device *dev,
+					unsigned int irq_vec)
+{
+	return pci_irq_get_affinity(to_pci_dev(dev), irq_vec);
+}
+
 const struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
@@ -1677,6 +1690,7 @@ const struct bus_type pci_bus_type = {
 	.probe		= pci_device_probe,
 	.remove		= pci_device_remove,
 	.shutdown	= pci_device_shutdown,
+	.irq_get_affinity = pci_device_irq_get_affinity,
 	.dev_groups	= pci_dev_groups,
 	.bus_groups	= pci_bus_groups,
 	.drv_groups	= pci_drv_groups,

-- 
2.47.0


