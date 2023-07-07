Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447C4EB64D9
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Jul 2023 09:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bFNjkpFVsr0wX1IV59D92iuCTOU9SUmgiQChjqVJEPc=; b=G5IR7awriufLmyLz+ZEoov7yzz
	JHQAAqvoNLlunuyx2gVDaJ7HG/Oh+8EuZT0eVlMuUNtLD2j8tw4ZmKhpWBjAN6NwHhpoH1VPCMvR+
	1MP9+g12HkF3wE05uMAPNkKInhxh+oWHVrq0WO+EuJ3tC7boX1SZRXHY4PpFFZwOaqhluCiYnBybw
	TV+Z1nW/RyG5SR7NwD15FUMnOvdN4cQ2IoHkNtZMSt/JBsFFxi4dEQ+ml+yifLhuF/PCOVxErOwC3
	0Jn//+zTMYHfDAsZ8l5KfsDqtcyIv2JqhdUZ9n+5xJIweli5BGs4XP7ndzCSvbrxOLCa6o69jC8Z/
	BkdWFs2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHi2r-0049iB-1G;
	Fri, 07 Jul 2023 09:46:33 +0000
Received: from [89.144.223.112] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qHi2o-0049h8-2h;
	Fri, 07 Jul 2023 09:46:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/4] block: don't unconditionally set max_discard_sectors in blk_queue_max_discard_sectors
Date: Fri,  7 Jul 2023 11:46:13 +0200
Message-Id: <20230707094616.108430-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230707094616.108430-1-hch@lst.de>
References: <20230707094616.108430-1-hch@lst.de>
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

max_discard_sectors is split into a hardware and a tunable value, but
blk_queue_max_discard_sectors sets both unconditionally, thus dropping
any user stored value on a rescan.  Fix blk_queue_max_discard_sectors to
only set max_discard_sectors if it either wasn't set, or the new hardware
limit is smaller than the previous user limit.

Fixes: 0034af036554 ("block: make /sys/block/<dev>/queue/discard_max_bytes writeable")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 0046b447268f91..978d2e1fd67a51 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -179,7 +179,9 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
 		unsigned int max_discard_sectors)
 {
 	q->limits.max_hw_discard_sectors = max_discard_sectors;
-	q->limits.max_discard_sectors = max_discard_sectors;
+	if (!q->limits.max_discard_sectors ||
+	     q->limits.max_discard_sectors > max_discard_sectors)
+		q->limits.max_discard_sectors = max_discard_sectors;
 }
 EXPORT_SYMBOL(blk_queue_max_discard_sectors);
 
-- 
2.39.2


