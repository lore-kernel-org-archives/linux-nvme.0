Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C58C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 00:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZmOyIPxCE8Xs4cRgHcc5cEcyqTszchKMClRuI+6JH88=; b=uurhrDvy45km9gwrKQyHzfayjZ
	+SzuP1hMagTEBb7j/TTcTzXK7tzau02eSqCWuxSF7KZeIJLOm34i169SsAfQ0cUvi0Dy3oIPGUAtl
	PbmnUY7u5ihgIOKcpMkRG/HCjHp1+7eowqg7hIrhjVbSgzvWU8kIzw9pUvCXXqrEU0onW1maKS+Ak
	7Auc0X7nfU6j72GWx7Q9bqO5/vw5LnXM6zu8UgM3UaBwgvfv5Z7GtIJHz0XiFZfZPFtlz5b0lcc1P
	CvO/5hDDuSrLo02JN6afOEU/Bp6vVcG2xVH75cAtVFtZz9fPYoesLMYvuCA0cBJb6Ee+fCLwhP1lm
	7b9oview==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oilvw-009nKx-H9; Thu, 13 Oct 2022 00:18:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oilvT-009n3t-36
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 00:18:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9E23D61684;
	Thu, 13 Oct 2022 00:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8426C433C1;
	Thu, 13 Oct 2022 00:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665620294;
	bh=40nMb0QXbyHEzCCs04WjfBquDekogf4DJI5B2dFe7gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AqBHgsVvVuCbqSEoLhcYi6Z7EYBkCynKcXw1OIyQOH+Fi4ip6C0KAe8HyE1PVB34E
	 xjPtCdLEWs1X4XrkFQopZlWXMHc9BozC04w8oRh3OLb4XAwqz6xM9KI5MkFdLh5zVU
	 fP+xbW1a4OBFI2jKvXq0QNnP4nmROkyh5rkPGfCeSdS2ABvW87L0MnBs0ELYOBUSqk
	 XK1Pu6dlNLuuZkSa2P9SzD6vVFuk3x2vOWejkcM9CmA8F4QPZDy9LwjnOOdNP8PoJN
	 yjJKQDsPmfr28ws70pR7OTHlVXxTEi/qIptNbijW4hrjy30mpC09yirhL/LsW6MtIB
	 mwHoiqqgrZrBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.0 58/67] nvmet: don't look at the request_queue in nvmet_bdev_zone_mgmt_emulate_all
Date: Wed, 12 Oct 2022 20:15:39 -0400
Message-Id: <20221013001554.1892206-58-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013001554.1892206-1-sashal@kernel.org>
References: <20221013001554.1892206-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_171815_327120_55BEE73A 
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

[ Upstream commit 8df20252c06046ef4c68107bcaaca56c21028d8c ]

nvmet is a consumer of the block layer and should not directly look at
the request_queue.  Just use the NUMA node ID from the gendisk instead of
the request_queue.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/zns.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 835bfda86fcf..1254cf57e008 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -400,7 +400,6 @@ static u16 nvmet_bdev_zone_mgmt_emulate_all(struct nvmet_req *req)
 {
 	struct block_device *bdev = req->ns->bdev;
 	unsigned int nr_zones = bdev_nr_zones(bdev);
-	struct request_queue *q = bdev_get_queue(bdev);
 	struct bio *bio = NULL;
 	sector_t sector = 0;
 	int ret;
@@ -409,7 +408,7 @@ static u16 nvmet_bdev_zone_mgmt_emulate_all(struct nvmet_req *req)
 	};
 
 	d.zbitmap = kcalloc_node(BITS_TO_LONGS(nr_zones), sizeof(*(d.zbitmap)),
-				 GFP_NOIO, q->node);
+				 GFP_NOIO, bdev->bd_disk->node_id);
 	if (!d.zbitmap) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.35.1


