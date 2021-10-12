Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB01C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:35:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A48560187
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 11:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9A48560187
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mOOH7RjNIEmRIbl97kJGg42JzM+Qy5Ce+da1EauMQfM=; b=Kxyr6PLF+8CzKD
	QePXKgV31vQlxnQFz3ltLPrgyN4BmtNpTiF6ay9z/pn1vWUX1yG/iyUs/w14vuezqdzncKepIsqgD
	z8/hmZ3O9GTgkpLvMIm8rlVfM/VBDtwKIQ4JDfbvVIeVqA2TonbIMvAjWWvwap0pQvrMrNs2TFxk4
	vPi0AeJY4o/9Zln+h1mdxSiwV7XCQe/BhhlRLkfQSWr1s4YJSnjGQjzjrkTMEsFy/SYgIiF827cLQ
	mmiFSu95f04rLPYodHY9eAKBaXMyL+RRdqgwtX9wQXIYMvpB8tAH4Av1fpBMWmO1wbFptnjFsO8S0
	D/UETB3hEg4CUcSIn3UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maG3z-00Ce4M-Ve; Tue, 12 Oct 2021 11:35:20 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maG22-00CdKT-1A
 for linux-nvme@bombadil.infradead.org; Tue, 12 Oct 2021 11:33:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=tneaoMD9sFq3X6FLJdwBi1IxEWuqgBQnrLkwkZNVHD4=; b=OaId8asF2rWnk2NFA8OnHW8gJB
 mmSa1VY8nNIqtFC5h4WwG7RzwsHD87I07v6Dopgnc/WAoRnDMuh+WDxx5i+a4safPiaerC3/u26yk
 oNxfwQog9k6KQvRT0SITL2uNUWhvhMFnkvH/u5xSNkhXZp0nQd7sLDa7eozCW8wzIAHdDnJHibaQD
 Xu8vHwMbsoFv56RiYqz80i55zjz0Ddu2jzPYMQHZngg/O2gi/G1n9kxiXzvP1tiqfOEuKeH3ARQYw
 qqxpR9SoHZ9ZbE14d0+BVbuKHVOQ+ha+jpbZDDy0copLt6qGMgpNYpsOsQmL2n6wu4084++9s4lV4
 feKL5wCw==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maG13-006SUg-A2; Tue, 12 Oct 2021 11:32:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 15/16] block: don't allow writing to the poll queue attribute
Date: Tue, 12 Oct 2021 13:12:25 +0200
Message-Id: <20211012111226.760968-16-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012111226.760968-1-hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
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

The poll attribute is a historic artefact from before when we had
explicit poll queues that require driver specific configuration.
Just print a warning when writing to the attribute.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 block/blk-sysfs.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index da883efcba33a..36f14d658e816 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -433,26 +433,11 @@ static ssize_t queue_poll_show(struct request_queue *q, char *page)
 static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 				size_t count)
 {
-	unsigned long poll_on;
-	ssize_t ret;
-
-	if (!q->tag_set || q->tag_set->nr_maps <= HCTX_TYPE_POLL ||
-	    !q->tag_set->map[HCTX_TYPE_POLL].nr_queues)
+	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
 		return -EINVAL;
-
-	ret = queue_var_store(&poll_on, page, count);
-	if (ret < 0)
-		return ret;
-
-	if (poll_on) {
-		blk_queue_flag_set(QUEUE_FLAG_POLL, q);
-	} else {
-		blk_mq_freeze_queue(q);
-		blk_queue_flag_clear(QUEUE_FLAG_POLL, q);
-		blk_mq_unfreeze_queue(q);
-	}
-
-	return ret;
+	pr_info_ratelimited("writes to the poll attribute are ignored.\n");
+	pr_info_ratelimited("please use driver specific parameters instead.\n");
+	return count;
 }
 
 static ssize_t queue_io_timeout_show(struct request_queue *q, char *page)
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
