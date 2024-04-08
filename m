Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25087CD128A
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 01:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CyqUwUlvubr0O+K6H5auqloAcJ7M1yn0623lq8iACAQ=; b=P1KlUj1T0qQxOlPp14Bax0s9GK
	4xCKsYE4veUR1wpveQv9v4b5JVfj8/8LkROMPS5HLvLckYd1BlyivHkV22zFma4ZD0fZnMgR0oO3b
	9yMKCC2uKEz44XASWJOCHSxKCXfXjH4jE85CmGB17rUBveXhMxk6s1LIgFOO01KK+x31DecX6Jm1q
	p+IOG3/fx9Du3601l2hB18TClctay4AbkF2PXe+hyifaEzN7qgCw6P75Dd4VaeridwR2+COkdpCdJ
	8SNmq+BiIVObMEASbhPFM0KqkaqY+3qHu7ArdCO8c5Yk9WbifjG1yUazd0ejXFG1ZNuxbzcnvjVFX
	GolqX59Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte23-0000000DwAS-3z5n;
	Mon, 08 Apr 2024 01:42:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte1N-0000000DvXM-2StY
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 01:42:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 59EB560DEA;
	Mon,  8 Apr 2024 01:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F00EC43394;
	Mon,  8 Apr 2024 01:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540525;
	bh=eK0oimqtGMQwdEQJvds7CbqZFh112249PiZX4tEvXd4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=s5GKAsbWGHxk+rbp6jA+LQ/BUhioacF0kAyHjquafipgrRp0G24e8bWuIV0Cs3DZ+
	 K1vE4vtLgejnf3+bQCT2HO358ozPN963grkNKb2dPxXJYFiaWBX5R6XE5Z0zZMjWOg
	 bGABdT5dIGlpu95Mf4AJN7Vsca3hKlBXKkLzx1DN9OA+Uesg1nwo09X5Jp2s6zFMLF
	 LFpudfiz+RDsOc4Tb7CVCjdDviK6gp7yIh+Aqahdu78ZLxsKGeykpztUPQVHzNZOm2
	 FG6tTuXTi/GPNyPvH6LctRKgFLws/ns4ZaiQzLE96LcZFlXdHn4BbZ+2CMM4rzydk2
	 otqcmAludp8Gw==
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
Subject: [PATCH v7 18/28] nvmet: zns: Do not reference the gendisk conv_zones_bitmap
Date: Mon,  8 Apr 2024 10:41:18 +0900
Message-ID: <20240408014128.205141-19-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408014128.205141-1-dlemoal@kernel.org>
References: <20240408014128.205141-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_184206_088652_D5C7C660 
X-CRM114-Status: GOOD (  13.04  )
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
Tested-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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


