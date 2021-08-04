Return-Path: <SRS0=aO7+=M3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3915AC432BE
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 10:01:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0306561004
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 10:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0306561004
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P8A/6NILTMtaustNCnckwSzcrwBkdtVFNHJU+7AqoaE=; b=v5S8lsBXFL55i5
	8LKh5UmMjuy9OHZg6Bfh2AIHTcBEwRHvuF6+1xaGGkKllF2nW53f2mbLH07NLHD4kWRbd/4lH/4jr
	YJRf1Dhzz2ingGrk0S/MIKN1fwbOrOsJYbHZh4cy47DDaBxCFjvlwU1NbBgpovRkqYkVEjgH2fxMm
	O4xxtJsBg3kUaMVTyh4W6aR6doRuuxmqWvxpIfaGdtsfJlnom6yFrqYVxvvxXpz7g0DFVVU15nrol
	YJFhjpNkM4B0UtexIFCLg4hM9TXJ9SVIOZkaz+pEfj2e8iHQaQthE+IHGZ4e7LLMxXc5Gh6FmuxDL
	EyH0PuJ/7P18FlqMSHWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBDi4-005ZXQ-Uv; Wed, 04 Aug 2021 10:01:12 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBDi2-005ZWG-6a; Wed, 04 Aug 2021 10:01:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=38PP0nqE1Rr5Q2SngGpX8SaabB796rszA7pe5/OYcCE=; b=NZVo6Syey+ucG1T/H4GNaod0LQ
 R3HS7TqZ5afkR+W+LPQJkznZOdAp8uReL+jaUNSYRPcVYrEd+QKJpXhyMJeIOUpxn6c6kg6oOcnrj
 ycZVGqV90IGpgWJAdd/4RU4VedNIa+ouNFQPdggcsnOZH0MibUQDRqjnN6Klph1gOoqn8Oowgd+90
 SKSpiLwMFkfPxHoVq1iUv+bgY8YaLlGZCl1KwsC1LwwnnIhdy0CzjMqtFV9iC0vVxrqjp46rQonBS
 dvE79Kmj5hVeLSHgBE3iwZOdeXA8BcSCT2lsyusJ9iEyY1RsgiF6m8nRVF5xP1/KOWT5fQu+V9TFA
 MzZrJ0rg==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBDhE-005fC7-4b; Wed, 04 Aug 2021 10:00:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Geoff Levand <geoff@infradead.org>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Song Liu <song@kernel.org>, Mike Snitzer <snitzer@redhat.com>,
 Coly Li <colyli@suse.de>, Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Phillip Lougher <phillip@squashfs.org.uk>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-um@lists.infradead.org,
 ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
Subject: [PATCH 05/15] dm-integrity: use bvec_virt
Date: Wed,  4 Aug 2021 11:56:24 +0200
Message-Id: <20210804095634.460779-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210804095634.460779-1-hch@lst.de>
References: <20210804095634.460779-1-hch@lst.de>
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

Use bvec_virt instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-integrity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 20f2510db1f6..a9ea361769a7 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1819,7 +1819,7 @@ static void integrity_metadata(struct work_struct *w)
 				unsigned this_len;
 
 				BUG_ON(PageHighMem(biv.bv_page));
-				tag = lowmem_page_address(biv.bv_page) + biv.bv_offset;
+				tag = bvec_virt(&biv);
 				this_len = min(biv.bv_len, data_to_process);
 				r = dm_integrity_rw_tag(ic, tag, &dio->metadata_block, &dio->metadata_offset,
 							this_len, dio->op == REQ_OP_READ ? TAG_READ : TAG_WRITE);
@@ -2006,7 +2006,7 @@ static bool __journal_read_write(struct dm_integrity_io *dio, struct bio *bio,
 					unsigned tag_now = min(biv.bv_len, tag_todo);
 					char *tag_addr;
 					BUG_ON(PageHighMem(biv.bv_page));
-					tag_addr = lowmem_page_address(biv.bv_page) + biv.bv_offset;
+					tag_addr = bvec_virt(&biv);
 					if (likely(dio->op == REQ_OP_WRITE))
 						memcpy(tag_ptr, tag_addr, tag_now);
 					else
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
