Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E1BC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 00:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mGIiQBGHwTq4LZPZIgfpEn1kPNmljOkNPrnhhyYBktM=; b=T5QUgd9ZkY9cMdGyYAToF+kGpD
	DIddfthh6GdChX6+wBlDJTcPtxHWyAfNZjLaHhtKVXo1G0HEqLYvMacMsX2ncGJ3MmvCVZHes8J+J
	l72iogm7EhYJ4K7Gxx4XXxOzM7luzDY1NI+4a1YdzcyamhUU8WhLktCNHYb756Nan2oUHFa62Ncpp
	KU3CGI68lF2NH7TF1gBMaTAub7H/josjjhjbohl1Jgz4a2Diu1hAQg1+G2Cz0xpAyLcbpbrSyV1S5
	64i3ed7+GbNg1tus3EE2KVwMkDUoxrFwXZ40nUCu6wEr/L6dGQ5eKmRzkcaHYt42xQ8NqnFqStvVk
	m1DyllIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oilwC-009nTz-SA; Thu, 13 Oct 2022 00:19:00 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oilvU-009n4Y-8W
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 00:18:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CCCF8616BF;
	Thu, 13 Oct 2022 00:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BD7C43470;
	Thu, 13 Oct 2022 00:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665620295;
	bh=a1NmIaOeyYaTxwOAA1EU/07zKuDViUH5GJZYzsjpOSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dZaX5GcVuv8kvLOf1N2bj4mr1Tko+b5F9R7nbezPiNGW7A8Xgr7/6WBmTITUIK8Tl
	 0CFLePSWbRYxzaq1gcEXFL3kDcgnRtRXIy5ypfbMAlM46VftGj0g1OnVFQSyCEoTHm
	 M/ViZdCuYNqYNm/EYggsTP9NZ23eND23CGi6y9SJe1v3bCNCSuIjqyfkgi2RO0lovB
	 cyqMcmFZLEQbau5evwKQ7A9BOKkt4Ishiebsp09337D9A1yyKInB0ShXNmDLga7v8T
	 tYNRMIMmD451swUCznTU3ptTdxlNlB3bvJMt6Z9sdBw7A811UAIu8SHuP4do1FvGx/
	 Uy2hRzJCrwB8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.0 59/67] nvmet: don't look at the request_queue in nvmet_bdev_set_limits
Date: Wed, 12 Oct 2022 20:15:40 -0400
Message-Id: <20221013001554.1892206-59-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013001554.1892206-1-sashal@kernel.org>
References: <20221013001554.1892206-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_171816_411787_FA1984EF 
X-CRM114-Status: GOOD (  15.13  )
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 84fe64f898913ef69f70a8d91aea613b5722b63b ]

nvmet is a consumer of the block layer and should not directly look at
the request_queue.  Use the bdev_ helpers to retrieve the device limits
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/io-cmd-bdev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 2dc1c1035626..77c20c0db9d5 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -12,11 +12,9 @@
 
 void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 {
-	const struct queue_limits *ql = &bdev_get_queue(bdev)->limits;
-	/* Number of logical blocks per physical block. */
-	const u32 lpp = ql->physical_block_size / ql->logical_block_size;
 	/* Logical blocks per physical block, 0's based. */
-	const __le16 lpp0b = to0based(lpp);
+	const __le16 lpp0b = to0based(bdev_physical_block_size(bdev) /
+				      bdev_logical_block_size(bdev));
 
 	/*
 	 * For NVMe 1.2 and later, bit 1 indicates that the fields NAWUN,
@@ -42,11 +40,12 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
-	id->npdg = to0based(ql->discard_granularity / ql->logical_block_size);
+	id->npdg = to0based(bdev_discard_granularity(bdev) /
+			    bdev_logical_block_size(bdev));
 	/* NPDG = Namespace Preferred Deallocate Alignment */
 	id->npda = id->npdg;
 	/* NOWS = Namespace Optimal Write Size */
-	id->nows = to0based(ql->io_opt / ql->logical_block_size);
+	id->nows = to0based(bdev_io_opt(bdev) / bdev_logical_block_size(bdev));
 }
 
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
-- 
2.35.1


