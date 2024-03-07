Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAC7C54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 15:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pWLnUFlzUEJhnbTRDkaJ8/zvGbZPOXeOdQeHsZIHfXk=; b=qYyMLu02RxF1XWAgw0FN7qY229
	m8EKtmIRIu2QMwrJm4eEgN46DJGZRRtPyVCTt/bARMRdXuu4Gss1FC0AEiOw6oH+Pejv7mybcgo02
	fbPda5dEebFYpJhtf3t0xYKqLZTm7QwIMcLhsPcgEd5wfAscouhr1TDRjoWj5WlndaKz5RY2THdx0
	KBVwXAnt+LA6C4ABsFUciMNaJzIcltgI6WdyoIWgomRvNHJ9EUWUjSx7k8DNR49VUD+Yd10GxJndV
	IOODqo6gp3m3IZBhX7t5C+BMboOhuutu1f8nWda+hfOtCq6IIFeamTqv/Hpo9p5QRBtb/wgupEMZA
	IJsM3bfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPq-00000005DGN-24QS;
	Thu, 07 Mar 2024 15:12:14 +0000
Received: from [66.60.99.14] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPh-00000005D9c-2TVa;
	Thu, 07 Mar 2024 15:12:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 06/10] ext4: switch to using blk_next_discard_bio directly
Date: Thu,  7 Mar 2024 08:11:53 -0700
Message-Id: <20240307151157.466013-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307151157.466013-1-hch@lst.de>
References: <20240307151157.466013-1-hch@lst.de>
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

This fixes fatal signals getting into the way and corrupting the bio
chain and removes the need to handle synchronous errors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/mballoc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e4f7cf9d89c45a..73437510bde26c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3840,12 +3840,16 @@ static inline int ext4_issue_discard(struct super_block *sb,
 	trace_ext4_discard_blocks(sb,
 			(unsigned long long) discard_block, count);
 	if (biop) {
-		return __blkdev_issue_discard(sb->s_bdev,
-			(sector_t)discard_block << (sb->s_blocksize_bits - 9),
-			(sector_t)count << (sb->s_blocksize_bits - 9),
-			GFP_NOFS, biop);
-	} else
-		return sb_issue_discard(sb, discard_block, count, GFP_NOFS, 0);
+		unsigned int sshift = (sb->s_blocksize_bits - SECTOR_SHIFT);
+		sector_t sector = (sector_t)discard_block << sshift;
+		sector_t nr_sects = (sector_t)count << sshift;
+
+		while (blk_next_discard_bio(sb->s_bdev, biop, &sector,
+				&nr_sects, GFP_NOFS))
+			;
+		return 0;
+	}
+	return sb_issue_discard(sb, discard_block, count, GFP_NOFS, 0);
 }
 
 static void ext4_free_data_in_buddy(struct super_block *sb,
-- 
2.39.2


