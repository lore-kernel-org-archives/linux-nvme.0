Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AD3C48BE5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:36:49 +0000 (UTC)
Received: from bombadil.infradead.org (unknown [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2645961464
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2645961464
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Jn370UM3lSkkOlmguumiErU47x7F2DdBtaxiatg9qho=; b=S6GXAlLX4T1YNQ
	LoBeeoLN8m8uGigZ+WgApUsGY8aHcapFG7lBzquT6/gBsqejFIwjyKlBBMbuuN8TH5qeLki2lUKrt
	Sj39oY9hwobH0YdSpCkyR5uRfApH80CiP/OKd60xnYGhAAEQ37AwZbtU9v17oEP7O65lqGH1jLvXQ
	GmnkIFW8Cjl5Kj2vu4B8Fr56nygUB82vUu8YSeDKI7VwrdXkaUBQLi4jSRA5+8w/HqZ6KMA7pAXZ8
	8hGTl6t51kT+LmOFBTjebusZERJBUN1jrU/GHhUyiiSPQxj8RZLTQcYq9sULu+MTPAUNJfTxMloOL
	bvCwe2a8xGdi9mERk/pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltAAm-000dg7-TR; Tue, 15 Jun 2021 14:36:13 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt9NA-000FmL-Mv
 for linux-nvme@bombadil.infradead.org; Tue, 15 Jun 2021 13:44:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=4AJHuabwZbAx4k/MvJNAp/pK/y48NSs1yk3HXkV1xfU=; b=oAvcwy/u++6FMQ8ONqgnVOC+Ef
 DMfOEm5rkf7xTca3/RyEo6RQGgqlyxEH/dlp4Uiqrq9I/ro/q46SlioQJYWi0M7T3RW+hq9Q2gj2c
 z5PIgNsgNilCBozSaicMyLTuZh/1r6GoxrDYu5168+A6sEdtkGgWSxWrgUfyWogTMPwcCDL9PGLqe
 EF/GuT8vIay8ogBYv9YqxRsBg+bwc+24jhC2C35TmazKlwL9LRsvfp5VXBsIPHi4oRDej4A4YdZNO
 hBguiD05S8XYOxEIEpKPijcvehnLu2+s/oh9DM/nGe0ynkwEK/j4wdaP4e6+ylr/1XPQL3ruzPZMQ
 1UU9kWMA==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt8sX-006nLV-4Z; Tue, 15 Jun 2021 13:13:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 09/16] io_uring: don't sleep when polling for I/O
Date: Tue, 15 Jun 2021 15:10:27 +0200
Message-Id: <20210615131034.752623-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615131034.752623-1-hch@lst.de>
References: <20210615131034.752623-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

There is no point in sleeping for the expected I/O completion timeout
in the io_uring async polling model as we never poll for a specific
I/O.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 block/blk-mq.c         | 3 ++-
 fs/io_uring.c          | 2 +-
 include/linux/blkdev.h | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c2b2c7abd712..86e59ffcca44 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4002,7 +4002,8 @@ int blk_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags)
 	if (current->plug)
 		blk_flush_plug_list(current->plug, false);
 
-	if (q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
+	if (!(flags & BLK_POLL_NOSLEEP) &&
+	    q->poll_nsec != BLK_MQ_POLL_CLASSIC) {
 		if (blk_mq_poll_hybrid(q, cookie))
 			return 1;
 	}
diff --git a/fs/io_uring.c b/fs/io_uring.c
index de8d39e9a154..6ce1e5b60725 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2290,7 +2290,7 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 static int io_do_iopoll(struct io_ring_ctx *ctx, unsigned int *nr_events,
 			long min)
 {
-	unsigned int poll_flags = 0;
+	unsigned int poll_flags = BLK_POLL_NOSLEEP;
 	struct io_kiocb *req, *tmp;
 	LIST_HEAD(done);
 	int ret = 0;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c7061f25ee5f..821d721f78e7 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -948,6 +948,8 @@ blk_status_t errno_to_blk_status(int errno);
 
 /* only poll the hardware once, don't continue until a completion was found */
 #define BLK_POLL_ONESHOT		(1 << 0)
+/* do not sleep to wait for the expected completion time */
+#define BLK_POLL_NOSLEEP		(1 << 1)
 int blk_poll(struct request_queue *q, blk_qc_t cookie, unsigned int flags);
 
 static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
