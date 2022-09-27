Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F37CC54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 12:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lxAA5rZdcHkAdTrfYPsR2+OQiDYMvxG2jPY89b/MLVc=; b=V/JrW1CST+xPphsvoEUFBANG06
	vCusRURW3eW64tQlpQIOX1ojMcRUHznS5whC2RsoGSK0RRQk1hPvemXUjma0m3+tZIHVYr1qQLEK9
	lYKM3+kFCdQUooVosYNOAtLFNz5hO7vbCAhnfh8n+eoXSrxr6CXaj0JYg5xlG57fLSNzwQNVtkZNG
	NglhoxVRkp8Kq5Kv3rGkuaWEtURYdw6rN23dd5r5ktwWHWoO4fhIUpLDuCa2pmRUlTIJzZjNPmP1Q
	SKVWbYLzdtoYuVeQI4LBXHQT5eNw5aD4pid0OU38z8oIBpuz+UDqpnTyA6pEbw3chliCWMEqlJscF
	rEc1teSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od9Ox-00APHW-JZ; Tue, 27 Sep 2022 12:09:27 +0000
Received: from [2001:4bb8:180:b903:ade8:c5dc:3782:5ee0] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od9Os-00APEf-Pw; Tue, 27 Sep 2022 12:09:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvmet: don't look at the request_queue in nvmet_bdev_set_limits
Date: Tue, 27 Sep 2022 14:09:15 +0200
Message-Id: <20220927120915.280166-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220927120915.280166-1-hch@lst.de>
References: <20220927120915.280166-1-hch@lst.de>
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

nvmet is a consumer of the block layer and should not directly look at
the request_queue.  Use the bdev_ helpers to retrieve the device limits
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/io-cmd-bdev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 8d527a8c0f542..c2d6cea0236b0 100644
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
2.30.2


