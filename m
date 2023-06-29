Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746B6C0015E
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 06:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7sutpNIU8wVy4Wsj4aGIfD/aU1jnyOOkzw9bSdt9EC8=; b=Xs9YmdI6lMLQx4kEUv+n+Ge0H8
	UwOlMAwdDcPW6TTzVS/t5z3w1dV03M8ZQyJbOgaI3erRCzRq50qwjUoZ9mDSx6oOX43dvkjGuon3D
	C5m6nF48MeV3jeHvUh9oub6ijyV3Pu4EI9BaNg7WANO4JvYkn+0wwZm/xz4SF740Zvn9IbRX3e6aQ
	wRaxzxQiRpbSRilmIgzEAs6lJTxU49yDJ9uHdoDpMTLI/9iJY95HVZQlxWfpMttcAG/sKmjzSdU8I
	uss4tX/LfsPV0W3ylIJiLE33xRXJBYofTw2IGfUPM1YLU6ZqswKDp2o5abKZHpYm45/mXIr3N1G+K
	03zN8WNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEl6c-0005wH-39;
	Thu, 29 Jun 2023 06:26:15 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEl6V-0005tZ-2b
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 06:26:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5A287614CB;
	Thu, 29 Jun 2023 06:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00616C433C8;
	Thu, 29 Jun 2023 06:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688019966;
	bh=joAVWS+EMFJrm0FZ1gSAlMHImF7ENXf6lPvgI0U1N6E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=q5jZqlIVQSNV5RPB7hvQq+PNYSeDDeyiCigy1pKttWz5iAKN6JxqztU4c72DqoA5M
	 AMGhk7k8Gogr2Ts4y2J3HSY8OkK1LwUqQpzHqk9mFkLb50CmDa4hqSuHQr8Rl3DlTq
	 Uy8DD42lFZiw9AFTY71KPk4QBnpULPwFTplz5DgygTBIyIJx6zuRFTC8OcRTGjtzNV
	 QWIZwiRh2WIdyGE54Kl1qVRw6xmoo2txkRwbPO9uyAkwSmw2zZZb681WmJpM6onizF
	 IZYxD9Jj6uR1s65U/6Kh+lAKtAC0IAN6Nifj/3b16wLCssZuuvxOVrpd9qp9b/31ew
	 xcvjrXTPqCjvQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 2/5] nvme: zns: Set zone limits before revalidating zones
Date: Thu, 29 Jun 2023 15:25:59 +0900
Message-ID: <20230629062602.234913-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629062602.234913-1-dlemoal@kernel.org>
References: <20230629062602.234913-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_232607_887371_E2F62147 
X-CRM114-Status: GOOD (  11.54  )
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

In nvme_revalidate_zones(), call blk_queue_chunk_sectors() and
blk_queue_max_zone_append_sectors() to respectively set a ZNS device
zone size and maximum zone append sector limit before executing
blk_revalidate_disk_zones() to allow this function to check zone limits.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/host/zns.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 12316ab51bda..ec8557810c21 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -10,12 +10,11 @@
 int nvme_revalidate_zones(struct nvme_ns *ns)
 {
 	struct request_queue *q = ns->queue;
-	int ret;
 
-	ret = blk_revalidate_disk_zones(ns->disk, NULL);
-	if (!ret)
-		blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
-	return ret;
+	blk_queue_chunk_sectors(q, ns->zsze);
+	blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
+
+	return blk_revalidate_disk_zones(ns->disk, NULL);
 }
 
 static int nvme_set_max_append(struct nvme_ctrl *ctrl)
-- 
2.41.0


