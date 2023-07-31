Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEE0C001E0
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 11:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HUjenkw+Rgt75erPXNIgvwmDiY0nCYdYQpl24QVWD5Q=; b=zLj50xYjopCsN8EGj5Pf/1gYDy
	AZ5lNK87YKflaYubsHgG8Gk/fQmklF+KPajPJg+mbCu0Cwu7kYm47/WFaffdWQ7qklEW/grzQF/Zq
	R4zcdg4Hg3Mg2hwhqGU4CfeqaPeczx+SMb1xC6gxYcaEUTuu/ssoY/qAEWmUCj2GGS+44aRD9V0r9
	Y/dobl68NWTWpNfO2sVYNV/GQ/+XJaLZqIJNBL+1VKbeXnGYJ1rIYw3A8cveXKy4/pVbJVEAQ8InT
	YpnSkmbbWmEox1kQipck9wLUz8BFx8JJrC2sL02MX7HfexB1DGf+pHwTIi4d6DAXsncp87/qhQlzi
	ut7qFpUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQRML-00FMhx-1a;
	Mon, 31 Jul 2023 11:46:45 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQRMI-00FMgx-2m
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 11:46:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690804002; x=1722340002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4WkqZUIEviJMXQPAQ62CKaYu2oTYBNuAHPt7/drzmu0=;
  b=espiUAZAvuRRZe8wYf6VryeZm2kPB73nYNfn+F8leptIJ77FjkG6TqEm
   6MmujdexXl8WUrhAS6doIqhW+KQ0jzCsaHDO/A06DlUzwulxlqy9uK4vl
   IasCfv4UbRelxTqW/7MLJqhdwkRVLk53sUXTxfqw45UjIMPcXGROBBbmC
   zSwVJ5U5+3WbZroNLbBCCB7Sm3plUt6EC8h37zUUjP4pvoLMPrbhFTH8f
   F4ZXMfHFldeE+Mj6N7mPU2mUKqmDbnQd/cFM6OxM8lnR8dXJPSHDF7clv
   4p2E0OrN4fMRh6bhJoPMf4OHaV+YHh8qx4VMNjKgIDDJYms9xhNqrx1mV
   w==;
X-IronPort-AV: E=Sophos;i="6.01,244,1684771200"; 
   d="scan'208";a="239992125"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2023 19:46:33 +0800
IronPort-SDR: yQyNCc0orcve2pw/IIVU8d6NBFqH/q3Dy5DHEWcj4FfQRvdDmOnaTokjVyiFLJob9EA+UfO1Kn
 9Z6EKsUbi+MMCQxCsg9J56ttU8FSkW+gWrC7ZNrV7WM7IPzZhHVV7PhK/qVsibcxmCSYE5G6bI
 dvPwXNxCq0fU35QVLid5kTDdwDGaYAwo8CreiAPbc647zfCahd8+GL1DLy6+dDKgOqrf8I/cQq
 mekbu/yKtoodW9Sd3MvSCzMatf+VkozZ+CveDEylIWirY7eF49vN5424+FOeL9gQnub2TbsB17
 LH8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2023 04:00:11 -0700
IronPort-SDR: LuY6TY0r2jaxLFHWFnhXIBC8F73JLUJI1rbN9n8CdaMS9w2t9fc9L5nATgdI3KmNak1uzW292W
 8z0zSKrKuWREnq2QeNSZkgWUsp7G2PHWNyUPJuqR/zbdIr/zOWTgfuMjptlL05bp86PxOs2j7Q
 nGEeWLKluM8dPUbZFoF5rkPd1fn3ubh8c/iuVmCc5AsJF6ck1jC7dIFe7yUANf5HAA2OiFeUba
 /sAeR2h4ObYG79KoNOXH8wGTokOlbcb/dvz1Fa2BF2lmA+fMtVsjCThrw8TC9avHEbhs8OSmn+
 RH0=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 31 Jul 2023 04:46:34 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@infradead.org>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvme: zns: limit max_zone_append by max_segments
Date: Mon, 31 Jul 2023 20:46:32 +0900
Message-Id: <20230731114632.1429799-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_044642_961971_31AAAAD2 
X-CRM114-Status: GOOD (  14.96  )
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

BIOs for zone append operation can not be split by nature, since device
returns the written sectors of the BIOs. Then the number of segments of
the BIOs shall not be larger than max_segments limit of devices to avoid
bio split due to the number of segments.

However, the nvme driver sets max_zone_append limit referring the limit
obtained from ZNS devices, regardless of max_segments limit of the
devices. This allows zone append BIOs to have large size, and also to
have number of segments larger than the max_segments limit. This causes
unexpected BIO split. It results in WARN in bio_split() followed by
KASAN issues. The recent commit 16d7fd3cfa72 ("zonefs: use iomap for
synchronous direct writes") triggered such BIO split. The commit
modified BIO preparation for zone append operations in zonefs, then
pages for the BIOs are set up not by bio_add_hw_page() but by
bio_iov_add_page(). This prepared each BIO segment to have one page, and
increased the number of segments. Hence the BIO split.

To avoid the unexpected BIO split, reflect the max_segments limit to the
max_zone_append limit. In the worst case, the safe max_zone_append size
is max_segments multiplied by PAGE_SIZE. Compare it with the
max_zone_append size obtained from ZNS devices, and set the smaller
value as the max_zone_append limit.

Fixes: 240e6ee272c0 ("nvme: support for zoned namespaces")
Cc: stable@vger.kernel.org
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/host/zns.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index ec8557810c21..9ee77626c235 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -10,9 +10,11 @@
 int nvme_revalidate_zones(struct nvme_ns *ns)
 {
 	struct request_queue *q = ns->queue;
+	unsigned int max_sectors = queue_max_segments(q) << PAGE_SECTORS_SHIFT;
 
 	blk_queue_chunk_sectors(q, ns->zsze);
-	blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
+	max_sectors = min(max_sectors, ns->ctrl->max_zone_append);
+	blk_queue_max_zone_append_sectors(q, max_sectors);
 
 	return blk_revalidate_disk_zones(ns->disk, NULL);
 }
-- 
2.40.1


