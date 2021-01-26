Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20563C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 14:37:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5750E2251F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 14:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5750E2251F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1WWt21/zY82aEkGQLwY5qpWbKDDqQplbE+MrWwVc2Gs=; b=IQ3Ube65g7qqJtMvEafazpze7
	Sh5BAhp4eMcYIdDqTCF0Bi7JaXzWiPRB4R2eEawqm3JnKUtbRDAJwYuWeBcS6kmZZ/aOzOkyZBmTj
	qB8TfNnZLwtyjBbkd/sI+GkBTABKtaOMUJJr4vH6DM8uBlROtnc6cRVv8en+JZMkTbV6QfaMLD5kY
	zg/5iG5lp+v9NsXAclaXkHiEzWmskpKZY0Ci2BX2HUrkr4Ie01Olt/OajjWKoAXpbVxNRp98ULYVo
	IZO3uEG8l9IfVUFJlnv9/li3fRGzUv3IPNGgC/qlZfb4RB2uimiT8EfAN+3HKHpVz2Z3m0rQBZWxT
	LiJMpKH4A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4PSk-00041l-J3; Tue, 26 Jan 2021 14:36:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4PSj-00041D-0S
 for linux-nvme@merlin.infradead.org; Tue, 26 Jan 2021 14:36:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=2XqxOZtHM5Bw3MRdYJR44mpyg5vHzYUaISWk2JVAadc=; b=edrJAdJuPY6f6qVPJO4fPTtVAX
 iMRzc0A+vsa3NTAFYev7OmOY7x/E+P9UHYBInZlxwfF+EBNsvbnmn9tf4WQPAufCPbH7rZZnlL7hY
 TUeviDNB5qbrRbIxoFaukOhCRra93/besKn1YtVMHtXkCnzAczbRJVsi9kxZb2A6zHWZWNz+Oxpg0
 G0AVtYRsexRC2I6frlCUwMxznPmpGRqgV0MUeIi6JB5uce57AAmjBls4yBJNQW/PVL7eJtXRgDygM
 kcS6hKjuc/axg0POGV6FZKmqSMx0LsWogSMRvCMHl6s2th3Uph1VeDgLRTWYNCWuhadNK/ZtYyY5A
 nNPdeXjQ==;
Received: from [2001:4bb8:191:e347:5918:ac86:61cb:8801] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l4PRk-005kQp-5o; Tue, 26 Jan 2021 14:36:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Subject: [PATCH 2/3] bcache: use bio_set_dev to assign ->bi_bdev
Date: Tue, 26 Jan 2021 15:33:07 +0100
Message-Id: <20210126143308.1960860-3-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126143308.1960860-1-hch@lst.de>
References: <20210126143308.1960860-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Always use the bio_set_dev helper to assign ->bi_bdev to make sure
other state related to the device is uptodate.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 058dd80144281e..63e809f38e3f51 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -114,7 +114,7 @@ void bch_data_verify(struct cached_dev *dc, struct bio *bio)
 	check = bio_kmalloc(GFP_NOIO, bio_segments(bio));
 	if (!check)
 		return;
-	check->bi_bdev = bio->bi_bdev;
+	bio_set_dev(check, bio->bi_bdev);
 	check->bi_opf = REQ_OP_READ;
 	check->bi_iter.bi_sector = bio->bi_iter.bi_sector;
 	check->bi_iter.bi_size = bio->bi_iter.bi_size;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
