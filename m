Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E465C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 19:41:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1E120672
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 19:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eA9H82Jp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cWpKHTPU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1E120672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4UUhbwkCYWO0TmYFIF7ZhYuQzRodqWzU5GY6yv2WHQU=; b=eA9H82JphzkoaX3xSEsrfiL0p
	UVGmUeV4cD9WBKdarFEIxbxr/XivvtCEFqGtBIwB2yx1iwiejfLfYGViymH4K8YLbtCSXn7UqnkNT
	pljcuY7GVN09M+oD9is2ErYcsVSEstjR093fVeJPbnHinfUgd/5SxXUpNcO++eDy+Ov0BwIj+9Wyr
	LboS8xC+pCIsWexI8W6LMqrslZoPWQ6XaJXMJovr6+nxM2VvxCQY8AjsiNV7WxsK/8YX7q2dP/EIG
	ZhpYqMmpLVD9VxI+AX1pn3Cxquy4ODR3WBRYmaYioSNEOnsj2MUedzui428+5ctMn6m6emJA2vilE
	MiSWEAbHA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpzeU-0004VC-Q2; Mon, 29 Jun 2020 19:41:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpzdb-000436-CR
 for linux-nvme@merlin.infradead.org; Mon, 29 Jun 2020 19:40:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=MVPFkWqT27H+EK/gr/8Zgz6Ls+wUfbhG+l5NiS06UDM=; b=cWpKHTPUn3rA32xoo333LDplGG
 /0xAWYcWkkFDjIBXGHO+45kIoIvtpWwTdJKbTnhm3os86dmo4mBSUI/NlHDdmV2gaqavEMZMtq3gr
 M3snlpc+56l3kOCu7MnQN7N8WQWb3nphprLavnWPrBA4mxdkJSQ8Tut/tMvH3ls/uG8kN7J9CITXs
 A7iClohCANn04aASv5Pb/v3HjCVtqEJIIyqmnMeFPQEhuHkV0uuQWfF7wIH1afLqTWPS6uIq2i+kb
 8Tr2FGLqiWdoGJayxvKNyukUZkTuV8pg9R5jKUz7TmEOASWR1oATE02aF8Ax3xwDPyvtVg3FdUUNQ
 Bmg5Q2MA==;
Received: from [2001:4bb8:184:76e3:fcca:c8dc:a4bf:12fa] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpzdY-0004MD-RU; Mon, 29 Jun 2020 19:40:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/20] block: remove the nr_sectors variable in
 generic_make_request_checks
Date: Mon, 29 Jun 2020 21:39:42 +0200
Message-Id: <20200629193947.2705954-16-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629193947.2705954-1-hch@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
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
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The variable is only used once, so just open code the bio_sector()
there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 37435d0d433564..28f60985dc75cc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -974,7 +974,6 @@ static noinline_for_stack bool
 generic_make_request_checks(struct bio *bio)
 {
 	struct request_queue *q = bio->bi_disk->queue;
-	int nr_sectors = bio_sectors(bio);
 	blk_status_t status = BLK_STS_IOERR;
 
 	might_sleep();
@@ -1007,7 +1006,7 @@ generic_make_request_checks(struct bio *bio)
 	if (op_is_flush(bio->bi_opf) &&
 	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
 		bio->bi_opf &= ~(REQ_PREFLUSH | REQ_FUA);
-		if (!nr_sectors) {
+		if (!bio_sectors(bio)) {
 			status = BLK_STS_OK;
 			goto end_io;
 		}
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
