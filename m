Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093E9E78D41
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 08:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D0Fx5A6x0QJXR2g7lvcn6Tcu3Z4Zu2XJjlnUcodUzHU=; b=UzzkFxhp6hM1h7Ps9SYEOSVogW
	qdNcJffPgFamQaTqZ9++eY1tg/NSGXril3IAza+rl34cMcl2MuK3BcgVZ69Vg3/N0CNEhQGonHjpS
	CiOij2vgbw9QkHq6ZwO4nTgrBTyQ1bj0+zFONPc2Vgc8r/9ikXjn6bW2+W5uFlP+BNi8KPaQXm2YV
	HZiEEmNAur62eQBEl1u8u6IpXQyxtHUcp3uYad2WXWn0e5NHr+P1AdI9spf1KJbueFRnXrOAeffdJ
	T7QZW0i77YxF3XU0pB4GIh1sQSF79zaMHiGSpCBdgJ4+YqB7puF0dXzdNLPW2n4ImdT78cJerMHwd
	zNNuLuxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpMev-0000000F1rX-1nw8;
	Mon, 09 Feb 2026 08:30:17 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpMet-0000000F1op-2Vhq;
	Mon, 09 Feb 2026 08:30:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 07FAC600C4;
	Mon,  9 Feb 2026 08:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4E9C2BCB1;
	Mon,  9 Feb 2026 08:30:11 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	sven@kernel.org,
	j@jannau.net,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	yukuai@fnnas.com
Subject: [PATCH 4/4] blk-mq: use blk_queue_enter/exit to protect debugfs file creation
Date: Mon,  9 Feb 2026 16:29:53 +0800
Message-ID: <20260209082953.3053721-5-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209082953.3053721-1-yukuai@fnnas.com>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
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

Replace the freeze depth check with blk_queue_enter()/blk_queue_exit()
which properly waits for the queue to be unfrozen and prevents new
freezes while creating debugfs files. This provides correct
synchronization without false warnings.

If the queue is dying (blk_queue_enter returns error), skip creating
the debugfs files as the queue is being torn down anyway.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/all/aYWQR7CtYdk3K39g@shinmob/
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-mq-debugfs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index faeaa1fc86a7..03583d0d3972 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -613,11 +613,6 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
 				 const struct blk_mq_debugfs_attr *attr)
 {
 	lockdep_assert_held(&q->debugfs_mutex);
-	/*
-	 * Creating new debugfs entries with queue freezed has the risk of
-	 * deadlock.
-	 */
-	WARN_ON_ONCE(q->mq_freeze_depth != 0);
 	/*
 	 * debugfs_mutex should not be nested under other locks that can be
 	 * grabbed while queue is frozen.
@@ -628,9 +623,19 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
 	if (IS_ERR_OR_NULL(parent))
 		return;
 
+	/*
+	 * Avoid creating debugfs files while the queue is frozen, wait for
+	 * the queue to be unfrozen and prevent new freeze while creating
+	 * debugfs files.
+	 */
+	if (blk_queue_enter(q, 0))
+		return;
+
 	for (; attr->name; attr++)
 		debugfs_create_file_aux(attr->name, attr->mode, parent,
 				    (void *)attr, data, &blk_mq_debugfs_fops);
+
+	blk_queue_exit(q);
 }
 
 void blk_mq_debugfs_register(struct request_queue *q)
-- 
2.51.0


