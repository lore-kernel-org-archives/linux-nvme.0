Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C783CF6487
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Nov 2025 22:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=INS73H9fpfKpTzIXcq0TyWJMVVqIF72st9McdWRmVUY=; b=0Za2rWXNC4sQH/5teV2UlLFiYl
	DoAofTEfSmPXlIa7tN6ssQuA0vPhFt649a+bCw6pQmN9hJq981oRRg7aGe7jTTQ/v6iM6nbl8aH3p
	6RCUSMlGGr3uB6mQe/gZ3YQmEWuwZy9pTlUMRbi9VsRfAqFVYIaKFQ5VOBARC5EkVcxT4UMKKFldp
	iCqyeLKr/GLhBrVt5ax4VkoMunafydn35jClyojAqNKQMG5DTwSNhGeLjJoB+Ng1xAWyb6RbPiS2M
	+Z+bJakOizk9cTuHObDoOKAclmV0lq3bYZksnn0B4iDaxWaysEmsIE5Oxdoyay7RBwNO/Ytkh33dO
	CLx5+Sxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLqtJ-00000005oEi-0rSB;
	Wed, 19 Nov 2025 22:43:09 +0000
Received: from mailtransmit04.runbox.com ([2a0c:5a00:149::25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLqtB-00000005oDt-2yO8
	for linux-nvme@lists.infradead.org;
	Wed, 19 Nov 2025 22:43:03 +0000
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt3-006yx8-Mr; Wed, 19 Nov 2025 23:42:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=INS73H9fpfKpTzIXcq0TyWJMVVqIF72st9McdWRmVUY=; b=yC8kwNa+YVjK5AcjHJjwXb3Gvt
	uXqDA6KXj2213Be1u7D3HuvZ4X8Bds23OamTIfyV7fEylE8QAnQcsS+mOHwU9fWLlAr6u0OB4MZZj
	aBprvZBLOsh+3i3Ab8nBivV2nX1Zn5YfLKDOxZi5ZR7a0KAl7OUyRDD8XWfjP6BGhr7A0f9kJMCEm
	iWaY0rzLcN9hzhF4pPmjeldP842gJxTRxDACHKFKTCJRcjNc6EJqQwcgZ2cvnXs60Psl0X6PfsIih
	dMXTaKCM/8OK3aYf/RGYcOIJ8LzYUQBNHnGhI45L0ngkV3xNeAmJhj5yh/WU2ZTmgp+wzWT8XzEGS
	Wj/wmy3Q==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt3-00086p-CJ; Wed, 19 Nov 2025 23:42:53 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsf-00Fos6-Da; Wed, 19 Nov 2025 23:42:29 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 22/44] drivers/nvme: use min() instead of min_t()
Date: Wed, 19 Nov 2025 22:41:18 +0000
Message-Id: <20251119224140.8616-23-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_144302_362021_C3A4E504 
X-CRM114-Status: GOOD (  14.81  )
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

From: David Laight <david.laight.linux@gmail.com>

min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
and so cannot discard significant bits.

In this case the 'unsigned long' value is small enough that the result
is ok.

Detected by an extra check added to min_t().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 drivers/nvme/host/pci.c | 3 +--
 drivers/nvme/host/zns.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 72fb675a696f..c74be555a7e9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3412,8 +3412,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	 * Limit the max command size to prevent iod->sg allocations going
 	 * over a single page.
 	 */
-	dev->ctrl.max_hw_sectors = min_t(u32,
-			NVME_MAX_BYTES >> SECTOR_SHIFT,
+	dev->ctrl.max_hw_sectors = min(NVME_MAX_BYTES >> SECTOR_SHIFT,
 			dma_opt_mapping_size(&pdev->dev) >> 9);
 	dev->ctrl.max_segments = NVME_MAX_SEGS;
 	dev->ctrl.max_integrity_segments = 1;
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index cce4c5b55aa9..c0b05a220f36 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -126,8 +126,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 	const size_t min_bufsize = sizeof(struct nvme_zone_report) +
 				   sizeof(struct nvme_zone_descriptor);
 
-	nr_zones = min_t(unsigned int, nr_zones,
-			 get_capacity(ns->disk) >> ilog2(ns->head->zsze));
+	nr_zones = min(nr_zones, get_capacity(ns->disk) >> ilog2(ns->head->zsze));
 
 	bufsize = sizeof(struct nvme_zone_report) +
 		nr_zones * sizeof(struct nvme_zone_descriptor);
-- 
2.39.5


