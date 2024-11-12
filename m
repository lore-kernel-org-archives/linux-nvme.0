Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD5CD3ABFB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2024 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RrRHtghbsHFFBUWb+voimZkLJOSiwDcghsoxgcLorao=; b=t4H1fetHZ1Hc+TWLFcbYGrjpdr
	q6n4uyCDzAVAyKTcjlDKN9uGt4woffGsLBmd1tQpWiEY8MYj+1j/LjOKsMzAlFEReF7doIG/hx/gh
	y+cmGRCUtd9NwdU5Saw7zC2DLsrXj0KtXtH7svtorbqwyMfFJEinymuFGshVl+ookYM39+uPfOrCL
	Uj/EHvDfjVOnkq51pgSO02d6w7EAbvv1053PoSN0TNkCaeqOvf9wlBGbhzMkY9gQTpL4ltUDCqeU1
	s6/ZFBAnMThevBjTk0KIf+/M9XfBROdypqInE4Dg+aAohCHDEop70CRgj9MwViUcArlW/Lc8z8pkr
	ThQbFKxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAr0G-00000003ZwJ-0uFN;
	Tue, 12 Nov 2024 13:32:20 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAqum-00000003YTh-23Y4
	for linux-nvme@lists.infradead.org;
	Tue, 12 Nov 2024 13:26:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 28B91A41BB5;
	Tue, 12 Nov 2024 13:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4ADC4CED5;
	Tue, 12 Nov 2024 13:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731417999;
	bh=8c9yRiNz5l6j6ma+lUrUvRBWbUG9fNcB/XLsfuWbhOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WF8qYi2pzIBf0y54sQH9lmK5MdgbBym3p6VgwVSB9az4eQJUNihiXZHYuvpA0nkOk
	 7R3spOcB97zvmUjmb3PmSTgPqDRMIFAHMYd5LgfyJiJeb4FgtmKu6HVLQhHodUW7PJ
	 JRDX8f+b3Uk/hJUHu7Cr6xD5NaT5+QR7rmDceoBlEf2SGDmLcxyCcDN0bFxMwGLPWY
	 Qvq1cQf6sDzCO/kBTKVhy9fFXSPe7dTezWSBH9Sm8LpuIwienLYv5kEgefnxsxpUL3
	 QrvsIDCfvVK6GcBYlTxoQCPGePETggQ2sggtwivfG6rPTT+FurgcrgVXLI5vx6AS5N
	 kP2uno8dbV+6A==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 12 Nov 2024 14:26:17 +0100
Subject: [PATCH v3 2/8] PCI: hookup irq_get_affinity callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-refactor-blk-affinity-helpers-v3-2-573bfca0cbd8@kernel.org>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_052640_660787_0755D635 
X-CRM114-Status: GOOD (  11.15  )
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


