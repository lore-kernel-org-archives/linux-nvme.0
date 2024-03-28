Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A308C54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 00:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UostkH86LqEIGiytXfKF9pX7K+7Iu/M2QkR0XXoMjm0=; b=ALPrCyGOh+/PRn1flxP/qQHm9s
	O9y911V4JYprY+sruKOgKcnWjoMTUb15/vivpm24FMgOAqMMToV0Lvf0rE+NHb7HbZTjEZtwNbKjD
	1e+nUAbtaQF//HgwJlrmM4ced+tF5WdNfRZJAUT41ABKkRwWQMeAG+jwqWewD1ljNtCstcZOlASJH
	yKU7hlU/gls49kFGFK+t/dreTTmplmGa0ZPNV25OXXc2JDlx2bP//Wl+lPZLBIEbRo7RKB2WPcTzG
	dUAlV/p2tqSHBV43Ccn4Nw16eqperXf/dGiOgSpN6upwMAaYnAVBEyXWF9ahIa7EkYykL/G/7dOYU
	7q65NChQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdtj-0000000BoDT-03iP;
	Thu, 28 Mar 2024 00:45:39 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdsv-0000000Bne9-0j8L
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 00:44:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B65E361714;
	Thu, 28 Mar 2024 00:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6203DC43394;
	Thu, 28 Mar 2024 00:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586687;
	bh=Q82us1KAyFFbFVCmhiR9y5cPq6FqICqZqK9wxosWHF8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mTAawlAPCDUKCaTbep2ShjXFAtHPlJVDeOYnwSmD27+h8oymA5/hx7xxNwenDqH16
	 WhT+exGh5iFYP2NLEjajB0tNxKi3jowaJDPRnIm/xOM0lGANdOCRKR4pR94QoJpObA
	 bpLA3XJxLrIm4uBwKI9jDBHFOzQEu2l4y74v+8lbhrMwjvjqYLKfQF/+Fy4VEZfNXx
	 ur8W6KUY93uQd++BMqyTsshGnyKsXjDr+RhuxSQKVNkktHRWr05wz4pCbKxM8M0qzI
	 0CJNbfQEoSwSNCYP4Vb3SQNcf6rU1+gLE4eGENe3pZ6stltk8X6CQ5IAdVwHTW3/5z
	 zH8okJcTAX25g==
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
Subject: [PATCH v3 20/30] nvmet: zns: Do not reference the gendisk conv_zones_bitmap
Date: Thu, 28 Mar 2024 09:43:59 +0900
Message-ID: <20240328004409.594888-21-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_174449_841047_E4E06A15 
X-CRM114-Status: GOOD (  13.02  )
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


