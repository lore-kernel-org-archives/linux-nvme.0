Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1103D462AC
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 14:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p8yCQoru7ysnzk1MesV8U2DviaBpCNe+Nil6tGNjAWw=; b=MiRVbbZDdQTvc3bfGsHeSzjKos
	XIZjd08lcIAt6nC1cxJLcgAKXDEGBETJlzqCIzqm8hFpdbKDaktrjjy9FBZwHeS6zK+whxevQFAy/
	nJvcnjqrePitRg1BjYPyNOkVKdJi79ecSjr1BZDl8b/ep9xgJUwYtJmyzBnMde/zxllxieu6WatmT
	JoZM7rEMp5RbbusvegQtpP4e/pM5k2PQPajpaw48OWel5mlKrJ0LL7PUnyLoM5651C5gHYb6MWzgr
	h2z9AfsVcRCf1QnKDN3OJcLis3inE7oGXANLMSADDk5Y15JoCZ7UhQzUcZMYH9LdcytkINtLbuW00
	PcDp8PGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBEKP-000000077tH-21Mp;
	Wed, 13 Nov 2024 14:26:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBEKL-000000077pr-39AS
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 14:26:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 620305C0221;
	Wed, 13 Nov 2024 14:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C17C4CED7;
	Wed, 13 Nov 2024 14:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731507996;
	bh=JR9s+9s4JVaf0Dm0rrSVFTiMXryGwL+tMrTpNDWY6Aw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TeE6Jsyu6aE4dc2hT/jSqj/MHJUI1U6Gnd6fiU959KdnyjKX1xSabZys4AQve+MD0
	 YtO8np8JCAMIY/wGIReivv4MFyeEYWnUewruK83tBsBie/1GjPOhpS0AKlifU0WmK9
	 0Fpwem/mbHuADFIm1X3EAhkUZUPXRQfV0ZS2l+W8jvtNpZUV1XtvHAPYToJe56O5L/
	 8aV3XHKothLZhQKWFgz/YuOQMiWSZcX8fdBn1cL6wLG+JJm1j3Eva2S4c8xlRMNx8X
	 aM6pfOyGfqVVrSsCuNers+D+O5sw5sutVHDwFT2HNCJXOfDDoK2EjyT3QAzHOOL1vt
	 luqE1ZpdQk82w==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 13 Nov 2024 15:26:17 +0100
Subject: [PATCH v4 03/10] PCI: hookup irq_get_affinity callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-refactor-blk-affinity-helpers-v4-3-dd3baa1e267f@kernel.org>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
In-Reply-To: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_062637_946089_7F50393A 
X-CRM114-Status: GOOD (  11.64  )
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


