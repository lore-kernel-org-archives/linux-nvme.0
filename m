Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CE7CD1288
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 08:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wD+Kdgw5GYrROVMSejmtoz5NdGR1pfZmC4ExEqSCfrM=; b=lIoMXlmaG2euRQKX5j08MMcHxg
	q6BaHloKewU/T4WWkauEtQq2o4c8g9MkZW9Q1kfxcNwns5p+dl1+zm2fgKjT5brp6Bq+7xmfStqZU
	ma4J8EYdKuA3dzfINAESGGjQP78va70v+Nge7Ih8qLEXC8PAZcKCGj73zsB8VooV1kUWtsMhsNnwI
	tb9ZqfxQXoUG/YugAY707T6skV+RJCwM0qLGGC6G03ht/iDfP43TLJ19VD6w+PccX1SAi+oaKAaU+
	YUUgiRQd1Rog01OL4NBhLIiKILmHbQ5dFLENAaXf1OkAbi25YW3c64mGP+jvGTeoRxhmVevbuMHP6
	zrVVEwHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwDX-0000000Ez9A-2dl7;
	Wed, 03 Apr 2024 08:43:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwDH-0000000Eyrp-0h7t
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 08:43:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E60ED61357;
	Wed,  3 Apr 2024 08:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5884FC43399;
	Wed,  3 Apr 2024 08:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712133798;
	bh=ZqWxRKy0BiC3ofFZbofkWToZYi/vcXeY+FC2wZOs0FI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Iz9I7sd4/aSq4vDOd2lSxyzNsdkzO/CXcYaqW6eo4n4IPI96Jv9BYwD3qR9LfAK/Q
	 ZztYki5JIYVSp8xQfENRNYWivBEPHy13m7HmIQxNcLeyMgcPvMwL7PFFeVQQlCbKcT
	 rlKpJcpTNgKSniGRibz8zTiwMU/oiaw0CwmcxQ+w0VEJunYCgAi3cvlcOMMiPDDBJI
	 xdqIZ8l/64z/hNEAnVsFahW/4Agismx/obGhWidDyRKw7t7U7l/YxvEMomBEWKU93N
	 z+pfQE4DhNF5IUotL4FZU91QsHroudpx77yvHzBPOYrqnr+KX1uR0rB4brQPUPQTXy
	 ort6NJjRPVguA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 18/28] nvmet: zns: Do not reference the gendisk conv_zones_bitmap
Date: Wed,  3 Apr 2024 17:42:37 +0900
Message-ID: <20240403084247.856481-19-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403084247.856481-1-dlemoal@kernel.org>
References: <20240403084247.856481-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_014319_521062_33248B5F 
X-CRM114-Status: GOOD (  13.06  )
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

The gendisk conventional zone bitmap is going away. So to check for the
presence of conventional zones on a zoned target device, always use
report zones.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/zns.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 3148d9f1bde6..0021d06041c1 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -52,14 +52,10 @@ bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
 	if (get_capacity(bd_disk) & (bdev_zone_sectors(ns->bdev) - 1))
 		return false;
 	/*
-	 * ZNS does not define a conventional zone type. If the underlying
-	 * device has a bitmap set indicating the existence of conventional
-	 * zones, reject the device. Otherwise, use report zones to detect if
-	 * the device has conventional zones.
+	 * ZNS does not define a conventional zone type. Use report zones
+	 * to detect if the device has conventional zones and reject it if
+	 * it does.
 	 */
-	if (ns->bdev->bd_disk->conv_zones_bitmap)
-		return false;
-
 	ret = blkdev_report_zones(ns->bdev, 0, bdev_nr_zones(ns->bdev),
 				  validate_conv_zones_cb, NULL);
 	if (ret < 0)
-- 
2.44.0


