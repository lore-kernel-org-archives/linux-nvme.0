Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD57C54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 15:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0jRMO28hlSvt3zadSNwOLNWqxW82YvXZ34Ykj2ec+Tw=; b=oqkPGfuP+l06QF7f7aPL3ohhKg
	pNvTJpiUSVutPAiSGErysjJ1JoYkOJ4WfmxQrlLqKN7ixd1OjTxygNx13YrCcPBk32lk0YvVxj9Jv
	m7ahYrpTi1i7364jI8uY3IDb8UpuHU2zAAyfJO+04l56cYod4LTs2S5H4hsqGipjzmOi5KCwZEBug
	BXYZRIsIpwqA+j6J8qxkftrQRxK6iAb0xFjKeYz5vD0qGduj+sqMpMzZCdUklJoKQxdw6rSf/kizV
	3oYAoJHf/BgzcSqP5Tcjw0M+jHbooD7Z0P4Jv9Uuda2HeSNmeODCKMAGeccviAu6r+zokEnG6wXp0
	WmwwIlyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPu-00000005DKF-2yje;
	Thu, 07 Mar 2024 15:12:19 +0000
Received: from [66.60.99.14] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riFPj-00000005DAn-1aQv;
	Thu, 07 Mar 2024 15:12:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 08/10] md: switch to using blk_next_discard_bio directly
Date: Thu,  7 Mar 2024 08:11:55 -0700
Message-Id: <20240307151157.466013-9-hch@lst.de>
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
 drivers/md/md.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 7d7b982e369c11..5803a298dd40f9 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8722,8 +8722,10 @@ void md_submit_discard_bio(struct mddev *mddev, struct md_rdev *rdev,
 {
 	struct bio *discard_bio = NULL;
 
-	if (__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO,
-			&discard_bio) || !discard_bio)
+	while (blk_next_discard_bio(rdev->bdev, &discard_bio, &start, &size,
+			GFP_NOIO))
+		;
+	if (!discard_bio)
 		return;
 
 	bio_chain(discard_bio, bio);
-- 
2.39.2


