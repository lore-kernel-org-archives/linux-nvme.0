Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D318CE7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 03:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m97TAu6Js57xN8yL3i7cpD0PTgTFZMer5PHlGnR+tqI=; b=g7JY8+OToP/cAIl+aGCp1qwEZj
	RkOAqtIg7h/7aUcofk71Dg5CXpQq44IysZyImVDsNEh3mw6YpMXu43ebHqZgLh9LamScol4qXYQhQ
	wQZuJmxjLSU+r76Ha1d3StDHOgV9bqSziTQI+CDTWus8PROAJdd8Og722LpgTGyqEqknKDoxx6d8h
	nUa3IDHrn2MIBViJjhCVY8b2bkJk8ss5MBS6m17aF1OnOfCfmqQ8pgdqTQi1wHB0PKUPXe5ObxRvW
	8KhrRLPsonemKmVe0+iHPw21xE784OvdGBSEiydlIuOdrOtUr81oeAngADs99I3aZtJzvdfgM1+hM
	O1B+o80g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLZvg-0000000Gohz-269E;
	Thu, 12 Dec 2024 03:31:56 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tLZvb-0000000Gohc-0qnM;
	Thu, 12 Dec 2024 03:31:51 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	gost.dev@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH] nvmet: propagate npwg and awupf topology
Date: Wed, 11 Dec 2024 19:31:47 -0800
Message-ID: <20241212033148.4008110-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Ensure we propagate npwg and awupf to the target as well instead
of assuming its the same logical blocks per physical block.

This ensures devices with large IUs and large atomics get their
information properly propagated on the target.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/nvme/target/io-cmd-bdev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0bda83d0fc3e..567e5ac49fb0 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -26,7 +26,8 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	 */
 	id->nsfeat |= 1 << 1;
 	id->nawun = lpp0b;
-	id->nawupf = lpp0b;
+	id->nawupf = to0based(bdev_atomic_write_unit_max_bytes(bdev) /
+			      bdev_logical_block_size(bdev));
 	id->nacwu = lpp0b;
 
 	/*
@@ -36,7 +37,7 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	 */
 	id->nsfeat |= 1 << 4;
 	/* NPWG = Namespace Preferred Write Granularity. 0's based */
-	id->npwg = lpp0b;
+	id->npwg = to0based(bdev_io_min(bdev) / bdev_logical_block_size(bdev));
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
-- 
2.45.2


