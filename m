Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D0ECD129A
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 05:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JPt/qBTq+7JMCCOOydhbIQTvMs+/oRiYZsjFghKZtqQ=; b=o+dPnGsBXxQuaVYA/uqbvaOzml
	7tJNW0BHqQ9RVZqkKgR8NNd4mER7mvES2r24X+skCliRjS0zmeLg8P6iV8ODvVr5oxGBoF7lrv19Y
	kjRJhVvU0f/CaqW16nN20yJPxJBK5h/eyWMSxk+dNchbeJzJ/i+spJKHxsbo/2hQK8uRdc60Pt5XB
	Pck0QEku/p5FccBfkYzGL0buiCdgXK3vJ1jvWEF4VOwM+z17FbH5WziAc3K6JooOmLMmj6jb22mXQ
	dmroD0CE8AHFnBn3osQdmBja1X1dlGBYK3fGiijkMUG7zSy2kF92hlQ3FzoBjyVuR7q+I9+jkVzHe
	64IZKDpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rscSU-00000005LQL-2GEi;
	Fri, 05 Apr 2024 05:49:50 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsbPS-00000005BRP-3aVO
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 04:42:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D86AFCE35EC;
	Fri,  5 Apr 2024 04:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F256CC433C7;
	Fri,  5 Apr 2024 04:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712292156;
	bh=bZ6CmoUZHeF0V+yCdDX4vQwkiIgUMYj2IlheLcYsEw4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ehQC4oNYoS7eV9v/xjeCQc0uguM7tdTrX+cULWOZzCPYiiNx2vCqw8PA2Iky0huz8
	 rYnyFrNIP/uJFy6LrOLmKVIprZP0q3hC9/ZJhbrJ4auotTlr3om9rtLiUoq0Q1q3ea
	 awvVKl7/36F0oHn2FDxkkRBTpVaUjbJjJ//7x9lgdLegnefpU1hWcuS12/m8LDAa8p
	 jDa2wnKwYb+1bZcyx0DJkA5krnUvyrKVFw15nTi/lYUhRdrSBvJQJb3pi7u2SAz2av
	 7dUXRk1/wv3nMHBuaO/clOIyVFqH5mdIew9BqzICkiQabnjTe+KCbzKJ3QYOlEwHko
	 bBl+09RbHYNOQ==
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
Subject: [PATCH v6 18/28] nvmet: zns: Do not reference the gendisk conv_zones_bitmap
Date: Fri,  5 Apr 2024 13:41:57 +0900
Message-ID: <20240405044207.1123462-19-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405044207.1123462-1-dlemoal@kernel.org>
References: <20240405044207.1123462-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_214239_462670_0DDF9EDA 
X-CRM114-Status: GOOD (  12.84  )
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
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
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


