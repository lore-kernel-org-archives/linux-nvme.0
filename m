Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4CDC48BDF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:29:56 +0000 (UTC)
Received: from bombadil.infradead.org (unknown [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF8C86109D
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 14:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF8C86109D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5eNy4poNpDP9s6NUcXi6FZNItGcXS5xM2YF1mdkgwTk=; b=TzaCpAl0PGDzRw
	vzSnqdVKxB5biIvA+TSlQeBprrNChLB86OXI7a0whnSqBNiJp6ifSIXMEZKQepYRRP8izyGZThEmO
	QqGtGYnlUZlBVBMwoEac4Q9DILCBK8cbJD377FeBs8NX7SoTHOFmCfTZVvZPOShYoIrvusXJGq9XD
	KbXq844CPF5l1hmKAmAecIYi2RES+1wZcjnlca0u7gGt9NSwhkGEWRBir/U8qHU0sUpXNfd/UKdbF
	ADKHUbwTWtJvgou6Ka1RaN6+whW/82JkzQLSdeHXi0iRaB7z6jdNZX9iAgMDQnNOf5mao3oxO0pe/
	dxymIRZYD5vLzQ2xSrZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltA4Q-000bDx-RJ; Tue, 15 Jun 2021 14:29:38 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt9L6-000FmL-Ol
 for linux-nvme@bombadil.infradead.org; Tue, 15 Jun 2021 13:42:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=3z22i3o1IYVvzDBHHwFmESs6m1NW1WLgP5++bAzjFgg=; b=rhGVhXPRuuMavZ8mOb+BymSVHB
 EHVl8Yzdi/UJpS3Z9ChEzJSWLaORZFCWSnkV9SJdbS86HaP1BNtgDdo4slchhO6yHVNT2/A6EugPf
 BhsCgg5jjPoxFlUyF7Qyb1uG4OOsihS/vNa4be12bnWCkhqtWg6Y+nvCExGXAzYj3GBcsTvXxdA67
 X5e383ErlNa2Q/X7yzudlEdPESPJj05+T/fkw82dP7tSpZkDc6wros7nJvKo9JY76KfRYhA0I5g/a
 yMr0TxB5fmN5ycLYokgKFXYglnYUCLo2hUkvmmiJl2JahkkxoNg4DGYRr320vBK1YogPtQKCGUJwj
 yzljWZQw==;
Received: from [2001:4bb8:19b:fdce:9045:1e63:20f0:ca9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lt8te-006nPp-4c; Tue, 15 Jun 2021 13:14:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH 14/16] block: don't allow writing to the poll queue attribute
Date: Tue, 15 Jun 2021 15:10:32 +0200
Message-Id: <20210615131034.752623-15-hch@lst.de>
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
index f89e2fc3963b..f78e73ca6091 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -428,26 +428,11 @@ static ssize_t queue_poll_show(struct request_queue *q, char *page)
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
