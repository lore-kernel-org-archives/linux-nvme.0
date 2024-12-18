Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743D6E7718A
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2024 02:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jhZCWpmhBitik/IbLKGzmJ1c/5BHTYghYQVmmbUuo2g=; b=aQXbQ2IbXApQm6xdTsJhotBm1p
	DO6QKuw0pxOGw+MyeP+FTlvYxcoptU0v8vapSt9vkjsxDb0Q/cPNUhbEcNxh+Q5tCh8Ad2gVj7JAd
	EKuWn75PRmWsHz3PfwjjTToGO9wYfP+LLFPp553UCSkbzWNaX2oobCptN1lTHKJJ7hEQhCcXRsbEK
	GE6qiPUs2DzDloqQoXiYZJYVdqqshZhYw5GIA6FqdDsIuQhzaIH6Z5GO4A3fxl7iQzQV5J2E1f+Jw
	KJ60I1rxDGAEwOYU5YGTZYUTCf5YFxIc5ALRbvfeX2PlOqnuODgfLN+C6XVt3WuI4YZJ5gzmqtMyE
	S+j2/6OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjOE-0000000FLPA-269L;
	Wed, 18 Dec 2024 02:02:18 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjO9-0000000FLOJ-1Q9w;
	Wed, 18 Dec 2024 02:02:13 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk,
	hch@lst.de,
	hare@suse.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH 2/2] nvme: use blk_validate_block_size() for max LBA check
Date: Tue, 17 Dec 2024 18:02:12 -0800
Message-ID: <20241218020212.3657139-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218020212.3657139-1-mcgrof@kernel.org>
References: <20241218020212.3657139-1-mcgrof@kernel.org>
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

The block layer already has support to validates proper block sizes
with blk_validate_block_size(), we can leverage that as well.

No functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d169a30eb935..a970168a3014 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2034,7 +2034,7 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	 * or smaller than a sector size yet, so catch this early and don't
 	 * allow block I/O.
 	 */
-	if (head->lba_shift > PAGE_SHIFT || head->lba_shift < SECTOR_SHIFT) {
+	if (blk_validate_block_size(bs)) {
 		bs = (1 << 9);
 		valid = false;
 	}
-- 
2.43.0


