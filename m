Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAD3CD98F0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2026 08:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L1GHUJPrepxfo82QlTsNLx0KnZYM8RytR/DHFHL7li4=; b=HePapeqLV7hCkw/m7ZTGf3sSYe
	TFM8mzJ4Om/q1Yu28hPA+JmLPRrhUzqPx0gQIJrwuuWL0Z3O1XSfMXS2io4pFVWzrYj3maf2X2Y3P
	opwDwhaXmU2OvGLdhFAmHcJ0xRRCeZ2Ma0eBiynO+WYGF9V25sDjyyw7uA8aNSefeF9QedEC8hQso
	x4OH1gmYFNpalGoeWZuHf2TgvW1JC5xNdcGMfhO8dFe9LjWZPdUewvvsUDnQ4nnKmMULMBiN8ZwPc
	pnz0TCCHFNh27H2q8cfbKQQuCxBWY/1+I+GWB7yAtfXbFxrRSL9Ruip8HI/DwAfKKnPluwmeXVeh6
	zoSHHz5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa85M-00000000qbZ-18N1;
	Thu, 18 Jun 2026 08:26:52 +0000
Received: from canpmsgout03.his.huawei.com ([113.46.200.218])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa85J-00000000qam-3mSe
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jun 2026 08:26:51 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=L1GHUJPrepxfo82QlTsNLx0KnZYM8RytR/DHFHL7li4=;
	b=DoEwg0B0pZwO7JCjHjs90jiL+oI3N5tUboigvanWzr3yN2xMslliScvbsZVZw6wJmdyWu1NR4
	wkJiwm5E7jRdOCPbzdUkA5+gya6DrDPJ1Tk+dWrdAn1Gm93YSHRbd7Xqgtec+rkda6nz6QCLZWA
	YQ6+dwAVxCzb1f8nqaUhq0o=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4ggtsM27w9zpTK8;
	Thu, 18 Jun 2026 16:18:31 +0800 (CST)
Received: from dggpemf100007.china.huawei.com (unknown [7.185.36.214])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EEC740571;
	Thu, 18 Jun 2026 16:26:36 +0800 (CST)
Received: from huawei.com (10.67.121.11) by dggpemf100007.china.huawei.com
 (7.185.36.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 18 Jun
 2026 16:26:35 +0800
From: kangfenglong <kangfenglong@huawei.com>
To: <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <linux-pci@vger.kernel.org>,
	<liuyonglong@huawei.com>, <seven.wangyu@huawei.com>
Subject: [PATCH] nvme-pci: fix CMB mapping when CMBSZ Size field is zero
Date: Thu, 18 Jun 2026 16:26:16 +0800
Message-ID: <20260618082616.20656-1-kangfenglong@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.121.11]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf100007.china.huawei.com (7.185.36.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260618_012650_096143_831F597E 
X-CRM114-Status: GOOD (  12.29  )
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

The controller memory buffer size is defined by the SZ field in the
CMBSZ register (bits 31:12). According to the NVMe specification, a
value of zero in the SZ field indicates that no CMB is present.

Commit f65efd6dfe4e ("nvme-pci: clean up CMB initialization") replaced
the check for a zero SZ field with a check for a zero CMBSZ register
value, under the assumption that a zero register implies no CMB.
However, a CMBSZ register can be non-zero while the SZ field is zero,
for example when Size Units (SZU) is set to a non-zero value but the
actual size is zero (e.g. CMBSZ = 0x100: SZU = 1, SZ = 0).

When this happens, nvme_map_cmb() proceeds to compute a size of zero,
passes the alignment checks (zero is always aligned), and calls
pci_p2pdma_add_resource() with size=0. The P2PDMA subsystem then
defaults size to the entire remaining BAR, which may not be properly
aligned for memory hotplug, triggering:

  WARNING: CPU: 0 PID: 10 at mm/memory_hotplug.c:396 __add_pages
  Misaligned __add_pages start: 0x494a0000 end: 0x494a000f

Fix this by restoring the check for a zero SZ field, which explicitly
verifies that the controller actually has a CMB before proceeding with
the mapping.

Fixes: f65efd6dfe4e ("nvme-pci: clean up CMB initialization")
Signed-off-by: kangfenglong <kangfenglong@huawei.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8438c904ec49..530751b11019 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2472,6 +2472,8 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
 	if (!dev->cmbsz)
 		return;
+	if (!nvme_cmb_size(dev))
+		return;
 	dev->cmbloc = readl(dev->bar + NVME_REG_CMBLOC);

 	size = nvme_cmb_size_unit(dev) * nvme_cmb_size(dev);
--
2.47.0

