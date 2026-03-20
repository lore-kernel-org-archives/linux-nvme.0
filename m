Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096301099B35
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 19:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FJebzSqdReo0xcFer9aNgjCgZ2kJTufALDifSVgTt8A=; b=U2ZSaGrsCwzWyFn19G5LCISuQg
	Aeyt0XR1Djrg4/DjeTrZjaBQH4Oug4ZS1m4Qy2Gl9gMPOH/EAbvsQKl82Qqt4n4uxBbGfCHOzLjDa
	OhGrJ/vW7CWdWF7w4IsM/uWph4KzuD+fx7IlzigW9/8zBGCm56LB9hOsWtETFH+tvsgAjTKSg8cZX
	4fjYhe+4Esj9yvUun6Na0vYnK2AC+H+GPFwPcd3NbmlI/uqzLL151ZzDIAji4B6bd85MdmKZvNpqt
	5fxrrm2BJZaxJJbXyZ5sOFdxI9MJIwbkZrL2Fgg2mUzQrDPl3bhRjjWpjXcfH1fhv9mVRiLDsoP82
	So7cpwaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3fYZ-0000000DSJH-1HAE;
	Fri, 20 Mar 2026 19:30:51 +0000
Received: from bali.collaboradmins.com ([148.251.105.195])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3fYW-0000000DSIT-48OE
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 19:30:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1774035045;
	bh=mV/PuKi79vs/DLWR1rcZUS+2XIjd7LWrXdurOUeDB0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gg6cvlfm+9izCqjlakRWquFyhpMjPSLyvI8La4UYLYDAy5KvqGkPC9259TCgtBAoU
	 ZuWIRqPUhvkxdriApq/mMyt5Sk+3o7q/Z0mYlKqCB3woV2nydQeslPzKmc7Oq+emty
	 j4H1oh/7XBTxgT/P+aDYK43KpXcdjFIInhHacPsN37k7UPHf4SsDOuPRaKmTEyxqOm
	 YMORUr1Mx3cOTF1ag+hmdXmwLNbupxiyZza3wzJ5lfbt7EgyOUcZ4a6Th2Conl2Vci
	 TM4UeaEjW9enu74Mka9v6p0xK6x3ltP82TiVbinWI/pKVvG1FEyiP7ZQppI0pnFZ3D
	 6b5NCD1zYbhbQ==
Received: from localhost.localdomain (unknown [84.18.237.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbeckett)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7C6B017E05B5;
	Fri, 20 Mar 2026 20:30:45 +0100 (CET)
From: Bob Beckett <bob.beckett@collabora.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: kernel@collabora.com,
	Robert Beckett <bob.beckett@collabora.com>,
	stable@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvme-pci: add NVME_QUIRK_DISABLE_WRITE_ZEROES for Kingston OM3SGP4
Date: Fri, 20 Mar 2026 19:22:09 +0000
Message-ID: <20260320192217.365936-2-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260320192217.365936-1-bob.beckett@collabora.com>
References: <20260320192217.365936-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_123049_189605_194F6BD1 
X-CRM114-Status: GOOD (  12.49  )
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

From: Robert Beckett <bob.beckett@collabora.com>

The Kingston OM3SGP42048K2-A00 (PCI ID 2646:502f) firmware has a race
condition when processing concurrent write zeroes and DSM (discard)
commands, causing spurious "LBA Out of Range" errors and IOMMU page
faults at address 0x0.

The issue is reliably triggered by running two concurrent mkfs commands
on different partitions of the same drive, which generates interleaved
write zeroes and discard operations.

Disable write zeroes for this device, matching the pattern used for
other Kingston OM* drives that have similar firmware issues.

Cc: stable@vger.kernel.org
Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Assisted-by: claude-opus-4-6-v1
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b78ba239c8ea..db5fc9bf6627 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4178,6 +4178,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x501E),   /* KINGSTON OM3PGP4xxxxQ OS21011 NVMe SSD */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x2646, 0x502F),   /* KINGSTON OM3SGP4xxxxK NVMe SSD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1f40, 0x1202),   /* Netac Technologies Co. NV3000 NVMe SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1f40, 0x5236),   /* Netac Technologies Co. NV7000 NVMe SSD */
-- 
2.48.1


