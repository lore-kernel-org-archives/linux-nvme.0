Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C92CCDB466
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 01:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VQDLcNX7H0RfY+nHyvxQRES1bhoVcOlkEWngyUigYTk=; b=nXqmRDumvoHmnXW9m4KQ2bv/25
	s0JN13zradS07cDg1drLQcMOjXv8E5nR7kUYY9z+Mal80JXNHgNkysK+jD93VMdfU4zn3KcZh90Qn
	71QPiEivF0DKyNoLU9OjCNds8Hb0rDo7bc5uJ5/mpiaszqCEhIN6hnOT6dtXNaS05pLqem1U2IBmj
	jGqo9HCE4ds1OfbnWEfQsmYO2Su7S5yqRBfOTtsVojTVlRkrQajCBZh2oYz41qJ2SmotKfS3nXql/
	nFx2wpafg0Cs81lcrmHXVGZgCQZPITcby+ZK9Fxi8DjizyW/xUCV08u5XMCitx74OLHuJPWq5kFbA
	g7Ome/Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbTMc-00000004Go3-3N8S;
	Mon, 22 Jun 2026 01:22:14 +0000
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbTMZ-00000004GnU-195Q
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 01:22:13 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VQDLcNX7H0RfY+nHyvxQRES1bhoVcOlkEWngyUigYTk=;
	b=eWFQcjj7EpevrocgXqU/46jI2z2e61Tr99vDk7CqI5CRIkEpqM9I7MHwS/CTB+Z0Q/Y4Nib4x
	czjkrFR7flkAc0cvV+wnh5fdKqfoPll+GuCHI0/gBhZC0LVYQJV8Sn9AyaPQy6Z1N6O65sdnZwq
	77RwO4qJgg98cx+8Rh4AjBc=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gk9Ds0xdtzcbTs;
	Mon, 22 Jun 2026 09:13:17 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VQDLcNX7H0RfY+nHyvxQRES1bhoVcOlkEWngyUigYTk=;
	b=eWFQcjj7EpevrocgXqU/46jI2z2e61Tr99vDk7CqI5CRIkEpqM9I7MHwS/CTB+Z0Q/Y4Nib4x
	czjkrFR7flkAc0cvV+wnh5fdKqfoPll+GuCHI0/gBhZC0LVYQJV8Sn9AyaPQy6Z1N6O65sdnZwq
	77RwO4qJgg98cx+8Rh4AjBc=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gk9Dm50ZPz1T4HL;
	Mon, 22 Jun 2026 09:13:12 +0800 (CST)
Received: from dggpemf100007.china.huawei.com (unknown [7.185.36.214])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AA0940561;
	Mon, 22 Jun 2026 09:21:50 +0800 (CST)
Received: from huawei.com (10.67.121.11) by dggpemf100007.china.huawei.com
 (7.185.36.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 22 Jun
 2026 09:21:49 +0800
From: kangfenglong <kangfenglong@huawei.com>
To: <kbusch@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <linux-pci@vger.kernel.org>,
	<liuyonglong@huawei.com>, <seven.wangyu@huawei.com>,
	<kangfenglong@huawei.com>
Subject: [PATCH v2] nvme-pci: fix CMB mapping when CMBSZ Size field is zero
Date: Mon, 22 Jun 2026 09:21:47 +0800
Message-ID: <20260622012147.40600-1-kangfenglong@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.121.11]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf100007.china.huawei.com (7.185.36.214)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260621_182211_951730_DD2CF871 
X-CRM114-Status: GOOD (  14.88  )
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

Fix this by:
1. Restoring the check for a zero SZ field, which explicitly verifies
   that the controller actually has a CMB before proceeding.
2. Adding a boundary check in nvme_cmb_size_unit() to reject SZU values
   greater than 6. The SZU field is 4 bits, but values 7-15 are reserved
   by the NVMe specification and produce a shift count >= 40 in the
   left-shift operation (1ULL << (12 + 4 * szu) when szu >= 7), which
   exceeds the maximum 64 GB unit size defined by the spec.
3. Using check_mul_overflow() for the size calculation to detect integer
   overflow that could wrap to a non-zero value and bypass the SZ check.

Fixes: f65efd6dfe4e ("nvme-pci: clean up CMB initialization")
Signed-off-by: kangfenglong <kangfenglong@huawei.com>
---
 drivers/nvme/host/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8438c904ec49..5c7b1e757e4d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2448,6 +2448,9 @@ static u64 nvme_cmb_size_unit(struct nvme_dev *dev)
 {
 	u8 szu = (dev->cmbsz >> NVME_CMBSZ_SZU_SHIFT) & NVME_CMBSZ_SZU_MASK;
 
+	if (szu > 6)
+		return 0;
+
 	return 1ULL << (12 + 4 * szu);
 }
 
@@ -2472,9 +2475,12 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
 	if (!dev->cmbsz)
 		return;
+	if (!nvme_cmb_size(dev))
+		return;
 	dev->cmbloc = readl(dev->bar + NVME_REG_CMBLOC);
 
-	size = nvme_cmb_size_unit(dev) * nvme_cmb_size(dev);
+	if (check_mul_overflow(nvme_cmb_size_unit(dev), nvme_cmb_size(dev), &size))
+		return;
 	offset = nvme_cmb_size_unit(dev) * NVME_CMB_OFST(dev->cmbloc);
 	bar = NVME_CMB_BIR(dev->cmbloc);
 	bar_size = pci_resource_len(pdev, bar);
-- 
2.12.0.windows.1


