Return-Path: <SRS0=f2/u=AV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2462DC433EA
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 13:26:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95CD207BB
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 13:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fMiW2iu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95CD207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ajFWkxymls83e66JeA2kfD0Or1QP+cwrM9OYmiPVTuI=; b=fMiW2iu1NXv8fjPCKIGjLJwiU
	p+dnbaGu2kiMElanZiDwztBxb0wrJpcrhQUwiN35RypPJ55cddmCLWWpiNJO4prcer2jWNEEoEq3r
	LGzFA01PF02FYIQbo8k15hZGgHpg0a52K/R6dLyqkHhO9310+LRiQmI6ibYKkMAZpEBo7Oo2nrpym
	65PssneedeR9UgxnNSSRuXJW1Fi8qtqcC4VkCCKJ0lBjl0yP6ARtxiuSRc1dOBi0bDjMAXK0Nmh7v
	3rWZnHm86QqOB0Frs0rhC5twoljKZcI0STNzHkS/+ENYnCCbPF7ZMDxte3Pfz7WdAIFGoUT48+Tpw
	Sj0aAiKIQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtt2r-0004xp-Fl; Fri, 10 Jul 2020 13:26:29 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtt2o-0004wH-7q
 for linux-nvme@lists.infradead.org; Fri, 10 Jul 2020 13:26:27 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8E585AD1E;
 Fri, 10 Jul 2020 13:26:25 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-bcache@vger.kernel.org
Subject: [PATCH 2/2] bcache: allocate meta data pages as compound pages
Date: Fri, 10 Jul 2020 21:26:10 +0800
Message-Id: <20200710132610.11756-2-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200710132610.11756-1-colyli@suse.de>
References: <20200710132610.11756-1-colyli@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200710_092626_528615_43CF6E8E 
X-CRM114-Status: GOOD (  13.24  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>, stable@vger.kernel.org,
 Coly Li <colyli@suse.de>, Hannes Reinecke <hare@suse.de>,
 Jan Kara <jack@suse.com>, Philipp Reisner <philipp.reisner@linbit.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

There are some meta data of bcache are allocated by multiple pages,
and they are used as bio bv_page for I/Os to the cache device. for
example cache_set->uuids, cache->disk_buckets, journal_write->data,
bset_tree->data.

For such meta data memory, all the allocated pages should be treated
as a single memory block. Then the memory management and underlying I/O
code can treat them more clearly.

This patch adds __GFP_COMP flag to all the location allocating >0 order
pages for the above mentioned meta data. Then their pages are treated
as compound pages now.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Jan Kara <jack@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Vlastimil Babka <vbabka@suse.com>
Cc: stable@vger.kernel.org
---
 drivers/md/bcache/bset.c    | 2 +-
 drivers/md/bcache/btree.c   | 2 +-
 drivers/md/bcache/journal.c | 4 ++--
 drivers/md/bcache/super.c   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
index 4995fcaefe29..67a2c47f4201 100644
--- a/drivers/md/bcache/bset.c
+++ b/drivers/md/bcache/bset.c
@@ -322,7 +322,7 @@ int bch_btree_keys_alloc(struct btree_keys *b,
 
 	b->page_order = page_order;
 
-	t->data = (void *) __get_free_pages(gfp, b->page_order);
+	t->data = (void *) __get_free_pages(__GFP_COMP|gfp, b->page_order);
 	if (!t->data)
 		goto err;
 
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 6548a601edf0..dd116c83de80 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -785,7 +785,7 @@ int bch_btree_cache_alloc(struct cache_set *c)
 	mutex_init(&c->verify_lock);
 
 	c->verify_ondisk = (void *)
-		__get_free_pages(GFP_KERNEL, ilog2(bucket_pages(c)));
+		__get_free_pages(GFP_KERNEL|__GFP_COMP, ilog2(bucket_pages(c)));
 
 	c->verify_data = mca_bucket_alloc(c, &ZERO_KEY, GFP_KERNEL);
 
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 90aac4e2333f..d8586b6ccb76 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -999,8 +999,8 @@ int bch_journal_alloc(struct cache_set *c)
 	j->w[1].c = c;
 
 	if (!(init_fifo(&j->pin, JOURNAL_PIN, GFP_KERNEL)) ||
-	    !(j->w[0].data = (void *) __get_free_pages(GFP_KERNEL, JSET_BITS)) ||
-	    !(j->w[1].data = (void *) __get_free_pages(GFP_KERNEL, JSET_BITS)))
+	    !(j->w[0].data = (void *) __get_free_pages(GFP_KERNEL|__GFP_COMP, JSET_BITS)) ||
+	    !(j->w[1].data = (void *) __get_free_pages(GFP_KERNEL|__GFP_COMP, JSET_BITS)))
 		return -ENOMEM;
 
 	return 0;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 2014016f9a60..daa4626024a2 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1776,7 +1776,7 @@ void bch_cache_set_unregister(struct cache_set *c)
 }
 
 #define alloc_bucket_pages(gfp, c)			\
-	((void *) __get_free_pages(__GFP_ZERO|gfp, ilog2(bucket_pages(c))))
+	((void *) __get_free_pages(__GFP_ZERO|__GFP_COMP|gfp, ilog2(bucket_pages(c))))
 
 struct cache_set *bch_cache_set_alloc(struct cache_sb *sb)
 {
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
