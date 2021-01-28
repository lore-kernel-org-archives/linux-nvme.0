Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EF7C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:48:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B4D64DDA
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B4D64DDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UQ0G6BZ9qvXVFPyjtSIuuqsNlKZ8gWd8deItm77I3nA=; b=V9Eq9Z1Ocu3571kVIOQRHK5I8
	p35IEq9/FmpVsMuzJzhB14hV8PyQ04MSI0SdsMZkeNLxzlvyOx8p0bURqSCB0VC+uGO06qcwiShfb
	GeQGPoIUm/fxypfhaxfQ2s8jXH6TEyOJemwtFsiZkvsC3//sFO6pAKJM4VxBZ6BR/ZcpVki0rRS9B
	0VrCiMK/Htw9pD9NMWRwanb4FVtv77JP96PcQ+IpXPmuVIdgN0VW7GGus089A2jMvlAzgT7+JNFTB
	/OW5MmP/lyOTXCuyoONeC9S732oFxLcqZb6zMKcBBIWNmv0UuniNwEz7/hRQYKrajGCyOQRnlbDHQ
	JDGwhsbEQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4zDl-00029Y-Sg; Thu, 28 Jan 2021 04:47:54 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4zDa-00024w-Ke
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 04:47:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611809262; x=1643345262;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=O5qP2BvielJYmUlUhNylv6LuJjfmaS7aLBnXfbQBd5s=;
 b=pubWydT9FmY36/ZQLi/avTifv4BrYkxS/WsvsigbO+IiWl7bAGOqy5fK
 ONPDOV0PDlg9iMfyoBGpV7J1Fg72aXbmxAGiJzs0tbtR6sG+pTDqf4IS6
 ifMWzSVffh2HrGGVdC3cybr7XOJQ+gRmB5ng7nslj4f7KSXIeDO5DcLVA
 Lf/z+eCon0z1iTZHorW+nPcHsf+fUyTs6yXInDL5BSrou45KoF+nNKTmM
 ew83alrkuq+WHjDaQXQR1XdjrOBpb9Sv6z4NFBhXAVE9jur03SBBTO6S1
 Ip1vEg0wFWddIXBlC/TqThV6p8sUZSOQoteIc7r3BCjNqUfgHDlMc/axo Q==;
IronPort-SDR: LLyJ7XnqHCYLxpkw4CgUWCLAu194bscGdgtsXRMTfR1qfBhHIxOZIHgu8SNAvxnGAr39sa9WWC
 Rdp/Gt6YsMM3yZv1ao2pfElMQSoG42PuE9N62W/vzt2tyvsoqRi0dvNwC+NmoPUyinjar8paVU
 p0SUosw3g4RkgvkwmC69D/7xyAHSTmpRwT6YhTR+WLMsfX+SDh2GX0tgNXi5sFOYxfWL4e2Y38
 M7X3HGR608rst5WS/XHaayj8YItd42TRsY/Bvrxq6BC2E6gDy+izv7aPdho0ZdcnX0ci+KdIbZ
 6tQ=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; d="scan'208";a="158509627"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 12:47:42 +0800
IronPort-SDR: wMOOmrAnnl7+BNjPOcyC8W5WuySGR1+/JZ6EtxV0hlCegJHIizbtSJa5mFIDM6wnfGiRqVUVqh
 Z/nf0Fa4mDiLvCAg8xgF+c4is+NPgdMKKFrvSkPFKgnfVLnZtCDIBUVYqUxAjP7OoPyEEjBaBt
 tDA80G60YZOxnlBogQiY1vHgBm1QT6R9MnJziFi0q3E64I15KExX1usA+l3mtDeUkKZATuAnrl
 ZvZ3EVucIIzIgoZBFeR9c2LYQhnXbFzT0PfFqwC5nWhCcOey+9onYJNAm/Vaecf7Z4jKuBXAyc
 Mn5cWcaUD7HvSXNdDPvaG9zh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 20:32:02 -0800
IronPort-SDR: 8FBSkmLkyjz/GhHTUchlUwVPFmI+pC7A7EzrMqfa3aKCq8hn1uhE8WCrOLREjJOTmvCt3/CE0A
 PFi6FIaeYm42gCoDFulkqJRp74RBKkiObqip/8YLU5qrv8PTMAeTu2Y9odXlKxxFlbZvu5ejsU
 DGiolIEupzXSPUdqBMUlhiyub/QZ2ynvdm9KWsJN5/8O/dopTirjNGr2qnZcoR/3ZX46Jkviex
 Gz0JFZ39uG0fQ+i29cUV7N2vlNDYZQSEONJZF6Z8/4lc7Vm5g5Hsn3WR+vBMeqsEL0dpBkHiBi
 /QE=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 Jan 2021 20:47:40 -0800
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 4/8] block: use blk_queue_set_zoned in add_partition()
Date: Thu, 28 Jan 2021 13:47:29 +0900
Message-Id: <20210128044733.503606-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128044733.503606-1-damien.lemoal@wdc.com>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_234742_912345_A23DB917 
X-CRM114-Status: GOOD (  12.53  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When changing the zoned model of host-aware zoned block devices, use
blk_queue_set_zoned() instead of directly assigning the gendisk queue
zoned limit.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index b1cdf88f96e2..d6094203116a 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -334,7 +334,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	case BLK_ZONED_HA:
 		pr_info("%s: disabling host aware zoned block device support due to partitions\n",
 			disk->disk_name);
-		disk->queue->limits.zoned = BLK_ZONED_NONE;
+		blk_queue_set_zoned(disk, BLK_ZONED_NONE);
 		break;
 	case BLK_ZONED_NONE:
 		break;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
