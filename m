Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA42AD2B941
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 15:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c4Xt+KF6M3NsNW/Vd0vXkfHzIET7y4QZarV6dRACmNI=; b=2qGsO20GBdPKvwSUyNQESEhayT
	7+iqCtJzTg0eeEQ/+dCQR56IF+wj2F3ruzbiV0YV7IcBJ67J7V/HTceWOYLuUD8XhMYiT1aPU+Z3k
	72PM8QFcxuAaZRC8nibZnONpu4MNAO+IhGEDLqTm+YaDTf2tT+edIKPiqoNLFmBKaTpVBBCfwwc+G
	fLpMW7t6OL3rCAOj1k9a6DaXeAh4INiZCGzlufjMnj3BPxQOBy/TA+y2m6Ld+lbNqp/XHuUckKhTm
	RrhElvv9jvqMC7TeUNlnm1L8sUfFu029S9S/Qon1HJE7rXsIT9eGj7NXcDhzm6+1HxgmAPBXIdBDF
	0qbmQKIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Lo6-0000000HUEy-3wRO;
	Tue, 05 Nov 2024 15:49:26 +0000
Received: from 2a02-8389-2341-5b80-f6e3-83d3-c134-af6a.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:f6e3:83d3:c134:af6a] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ln5-0000000HU8X-2rEB;
	Tue, 05 Nov 2024 15:48:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] block: initialize max_hw_zone_append_sectors in blk_set_stacking_limits
Date: Tue,  5 Nov 2024 16:48:11 +0100
Message-ID: <20241105154817.459638-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105154817.459638-1-hch@lst.de>
References: <20241105154817.459638-1-hch@lst.de>
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

Because max_zone_append_sectors is now just derived from it.

Fixes: 2a8f6153e1c2 ("block: pre-calculate max_zone_append_sectors")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 5cb69d85af0e..7d6b296997c2 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -50,7 +50,7 @@ void blk_set_stacking_limits(struct queue_limits *lim)
 	lim->max_sectors = UINT_MAX;
 	lim->max_dev_sectors = UINT_MAX;
 	lim->max_write_zeroes_sectors = UINT_MAX;
-	lim->max_zone_append_sectors = UINT_MAX;
+	lim->max_hw_zone_append_sectors = UINT_MAX;
 	lim->max_user_discard_sectors = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_set_stacking_limits);
-- 
2.45.2


