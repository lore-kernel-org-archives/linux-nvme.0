Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61971C3DA6E
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Dec 2023 16:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ctU7eNWyO5uU8k+K1R2TcQkMR0gAuYk2v8Yjsja/Y1c=; b=R9yoMF5DjNWRCNln5RHYlO0KRX
	6el23It6lRa8dFS6BbtKo53DnX5MKfyMkegVwFZPKlkm7Ovnott6snSRp/NJYMNJePnGEhALoZtnf
	qBio0tDxPx8wLHQ4o2cLlYc99ka3XwDThCvNQ5NBf0kfFRaOVZuSu9bbD1pUviFrDdm0KOkvJ6pFA
	hbeFevwpfz0w4wY8Lz3cxevk1cTjnf1ItK5XBk3LBNBKUWb4uaFyquMOAP1ncKsOtnjaosG/4DlNo
	K9LXiNRJgTOe+oEaJLuM9LP2VID2apPLSK1WdTk8pADyRvWHjzWSiQHQ8PkMYR0UA9+N1OfGngwWP
	GcpT7qMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEuPC-0088Pt-2n;
	Sun, 17 Dec 2023 16:54:18 +0000
Received: from [88.128.92.84] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEuPB-0088Od-1n;
	Sun, 17 Dec 2023 16:54:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 5/5] sd: only call disk_clear_zoned when needed
Date: Sun, 17 Dec 2023 17:53:59 +0100
Message-Id: <20231217165359.604246-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231217165359.604246-1-hch@lst.de>
References: <20231217165359.604246-1-hch@lst.de>
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

disk_clear_zoned only needs to be called when a device reported zone
managed mode first and we clear it.  Add a check so that disk_clear_zoned
isn't called on devices that were never zoned.

This avoids a fairly expensive queue freezing when revalidating
conventional devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index dbed075cdb981a..8c8ac5cd1833b4 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3149,7 +3149,7 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
 		 * the device physical block size.
 		 */
 		blk_queue_zone_write_granularity(q, sdkp->physical_block_size);
-	} else {
+	} else if (blk_queue_is_zoned(q)) {
 		/*
 		 * Anything else.  This includes host-aware device that we treat
 		 * as conventional.
-- 
2.39.2


