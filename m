Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C327DC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 00:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Uo+u04p8DXgHTn1kxYCw+cz26C9hQZuK26Rr4WFKPU=; b=H8KeoXQQEk/WgvVaTZcR9+xYy4
	rbeg4kO0n0kGOMxE4zijHEcO53sa5fpTICPoXR5tYbtqLZ5MtcBb8ys0+8UUUey0wwYVYpfsKb9KS
	JSDuQHZsRdEuGX/OGFJeoln3FvIH1pHMV5NWtat6VXRjGjSfduXWqPPLEUmr6B9OANezM2RrMDj4t
	Wr1cd6NR/sYP6N00AfnPxWmeXbGRMMJi/BVi3WIxc3LpyiwWxWxnNhBTMqQOkoHuW0xFilRCZTN/u
	o2tuV6GWhBel0bsa9D9eFCSILlgF9zPsdrkaNWu451ED6Desqa3eg+LfTVNRd7B/AXp3Qy1giApF7
	245DbWDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oim59-009rrc-6i; Thu, 13 Oct 2022 00:28:15 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oilyA-009oV9-UV
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 00:21:04 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7827E616DA;
	Thu, 13 Oct 2022 00:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B85DC433C1;
	Thu, 13 Oct 2022 00:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665620461;
	bh=FzWqlkmIfZ88xJBlNS5dF9AWOlGYzMLuODCBWHb3S3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qbVVnCWjrwZE/LmESXc8Yu0Hn2meb8YtxOxphHtrZKqSatqZkx4+n1/VRkLz0E0Vl
	 or7A+QN8lHXGHIexEVn2kmkV9mXy1B0T9oJnyD8QHxYFGRobwrWKdJM/Vg7VN639H7
	 +2jQWOvezJQE1yEXOIE3HOK9DDePpXilgvrsdytYwdwP9rnUTWsKNvU3nDfTevvq3q
	 xl6Nb1JkwvWxp7aZjUVpPwbVEAj2xyu2J9giDLBVRgMKdKGjjo7JAgJg0i5h4ftcbR
	 ASn9laf708cj/TTjY/BaKu42/zlJ0ro3tibeT1R31VpZBHFaLejUZlmBe+7Y5uiy+Y
	 3aZKJifMj0m6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.19 56/63] nvmet: don't look at the request_queue in nvmet_bdev_set_limits
Date: Wed, 12 Oct 2022 20:18:30 -0400
Message-Id: <20221013001842.1893243-56-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013001842.1893243-1-sashal@kernel.org>
References: <20221013001842.1893243-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_172103_094541_604958AE 
X-CRM114-Status: GOOD (  15.22  )
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
index 27a72504d31c..521fe9469e08 100644
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


