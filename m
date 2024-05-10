Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785E6C25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 10:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1RD5rLS4/IjhkHLeCWESLTrR7dV1oU8Oy1DxaZYec1E=; b=vJ2g8CVV46OOa4IvEnoG7MeATM
	dWuOhQmC+QEcu9hxovO4YlFjk/7oJ8EY5UQD2VupH2Gmx+caqw/WQPaBb6h6tivwcMzeGY7qR8Ghf
	7e8xnY4nIwz+1v/ulOX7p/U7Zcbd1lnmjzOi6cxAgEd6xU3DzMM4gSVmFt5chNifQo720IYhnPj5C
	zRIkKAARnG7otayTmumzwS4f28lc1bHg/G3XurN9ML3K9sljybgAlaBb8ZZgDHtOnaFx+PUB/jsE0
	BQMrKoHAwdsZ159vg7nsifV/B++/oLQ9huXkXk29tGDZ/D4+0E4fHovQZ+6tzA+S7wZQiImYbOapN
	dI5WaZeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5NVd-00000004s56-3YGE;
	Fri, 10 May 2024 10:29:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5NVW-00000004ryl-2DOa
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 10:29:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0CE2C61E9B;
	Fri, 10 May 2024 10:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42A1C113CC;
	Fri, 10 May 2024 10:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715336981;
	bh=fd+9PKpzde5Dk2onVoIgU5jMVRisFeNkKmSBmUuDNaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=doqzV8AOo3DUDX1k35UihgmWnqMHMO+4othTCsffGxit/c79LZuwvLbXKsCWe2CQ8
	 x231WUp8yIViuZFZWUgu206Y6HmXbPvXZybUsb7Lh7zaTJOoZubUNxSeiuFqfUMCaF
	 5wxbcgsdgAVhz5xkZKlKhmrmuLFm4yuM696HrWqSq1Ltz8ORJ72DRaRPWTMhkuGdY2
	 KN2G6isaVJRGRsIoy0VjsNvSbZ7BL2IrwjUZk0rRYygpikFm2RwsDwaxITKhK5kMnd
	 oP9/vDQinCfWG4FRDw9zNOo4mFI3Xn00OqcJHgYnXEqnZ5Z5XF4PXRyCYfKOCVyX+Q
	 E9GiCQWcFoG1w==
From: hare@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Date: Fri, 10 May 2024 12:29:06 +0200
Message-Id: <20240510102906.51844-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240510102906.51844-1-hare@kernel.org>
References: <20240510102906.51844-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_032942_708826_9687F6B8 
X-CRM114-Status: GOOD (  11.41  )
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

From: Pankaj Raghav <p.raghav@samsung.com>

Don't set the capacity to zero for when logical block size > PAGE_SIZE
as the block device with iomap aops support allocating block cache with
a minimum folio order.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 828c77fa13b7..5f1308daa74f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1963,11 +1963,10 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	bool valid = true;
 
 	/*
-	 * The block layer can't support LBA sizes larger than the page size
-	 * or smaller than a sector size yet, so catch this early and don't
-	 * allow block I/O.
+	 * The block layer can't support LBA sizes smaller than a sector size,
+	 * so catch this early and don't allow block I/O.
 	 */
-	if (head->lba_shift > PAGE_SHIFT || head->lba_shift < SECTOR_SHIFT) {
+	if (head->lba_shift < SECTOR_SHIFT) {
 		bs = (1 << 9);
 		valid = false;
 	}
-- 
2.35.3


