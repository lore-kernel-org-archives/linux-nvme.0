Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E4DC6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 12:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wD+Kdgw5GYrROVMSejmtoz5NdGR1pfZmC4ExEqSCfrM=; b=tpjNLPpyldE+I6+Gy3alIpy/4H
	gBxDRujR7d+Nv9ixFw6EnZiOdcEHUTK+2+suSIW6NYBy4BKZqlP5zXYUoWoGLRAeQ/kD+aRGIzNWw
	Us9JSxLO6nJuEZtEmOUEUqZyTqmfiYIzSRBo8LMmCisoUZWUBQbR1kNVrqEq02Nf/USJanbidoxeh
	nnekuJHtDzjBdTvfVv+2hubDbd4rP5J6fg/4HVDuFckb1GBMF+L8h8pLw2d10xUGxNMwC2Zd2DvFn
	amYwS9GP7zKAUSius4+yAgNgJMJwcAER6ZvDXpqBP0/5bQpuKttBFyebvu09In5tzaDTUIIKBa6Qi
	qtxIOObw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdRK-0000000B7AM-08Iy;
	Tue, 02 Apr 2024 12:40:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQY-0000000B6aL-1h43
	for linux-nvme@bombadil.infradead.org;
	Tue, 02 Apr 2024 12:39:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=wD+Kdgw5GYrROVMSejmtoz5NdGR1pfZmC4ExEqSCfrM=; b=WuSsdDbc0uQFiJnxC/Ifzi/InA
	I917+KKi4tvjjtcoob0DdlL+aGOoB0Ie3tV82qqLK3CClfY5Tm7r/gffB9SerxoQveGmsSC20CyMM
	FkWNIe9/rh9/PmwwXbBhDG3APEVCVvX8Ev9vHl+89r7LdZ4ZzNy/8/V5qFPD1YphyzVSTpNLoOiKn
	WIU7I5HDKcxqHB2gdi3CuKwyU9GEUrlS4Tb/ZkxMqxIdnvyQ334J/HlwsjgO/Awzb8hQKc8sCUL3A
	g4s3T7RYnIGfJhh8drd7UJ9TEXhpoXdrN3cRcGNr35M9ZFU79fpzZWWzA/BsLMXhtIMjRFpqG0x0J
	XMyBWoQg==;
Received: from sin.source.kernel.org ([145.40.73.55])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQV-000000032hY-02d6
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 12:39:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 03477CE1B7C;
	Tue,  2 Apr 2024 12:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843E2C433C7;
	Tue,  2 Apr 2024 12:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712061575;
	bh=ZqWxRKy0BiC3ofFZbofkWToZYi/vcXeY+FC2wZOs0FI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LJVerBMOcXI4hDfTfXNqW1eEDoL0m3fnn02stGN/tjROLoplmPfT0TMdU2ZLS9Nu2
	 oXeaPmfyOC01C8DllmwlBBLHvLpiDLtqCZknCNn9xh9NzEK/k5nevKLIcx6uFjfINM
	 UQ+/Wdf0tRLqnuywU/g7BJQrvz1s/vHPzVWp/L5n707x0HcAFoGSv0HDnVSkGkNMpw
	 sgTKDwi5aUyhx2MtPD/4XOc6NxwkzU7JtEXONnjps+a3a74MgFficr5rAhVU8uIByv
	 GB2vQk5RSHiFcuKeHFxwn5lrcbz/6AeM3LUCRssGdbZ8Cm33BqiNA/Qd1a2t3tI5hE
	 qAz2zn1TFx3Bg==
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
Subject: [PATCH v4 18/28] nvmet: zns: Do not reference the gendisk conv_zones_bitmap
Date: Tue,  2 Apr 2024 21:38:57 +0900
Message-ID: <20240402123907.512027-19-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402123907.512027-1-dlemoal@kernel.org>
References: <20240402123907.512027-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_133943_407024_A7DFA987 
X-CRM114-Status: GOOD (  10.96  )
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


