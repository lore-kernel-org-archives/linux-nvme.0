Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0E7C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 19:40:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B84420672
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 19:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gj+WAhP5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nX6H72rw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B84420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wPNouyREAiNrxj87QPnUq1FOt1pSETf1SZgGlQ91HcM=; b=gj+WAhP5jkCzofKxAxHH0wj4s
	YiztjaMHueVsU4+GVN101JWlZH+ClhiHahEY3oWdj8iCszOUJODScay18s0bwgA7qMBUQuM8wHkIK
	e1Cj+cIAxAsQNtyTBhs0wm87qfbIoznRPLHTXwlHh5HlcZ/gbul1SHiKGgOS1PtI9Syne8VP5YJ4a
	MUp4xzQxUz53bwp/L7qk8RM94pSEnZ8wNq8nunGzucqDsGS7R7hWgl8TaaCOysu3YIfHnWvMMoISa
	oT8QtgiQocTxENhjf3tmAosWj0SWmmPlD2F4DX6Ytt0kKPaqbHdS6arvP/jBLRkALaIFfwt0NN9Mh
	s7AnWNVOw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpzdI-0003vp-CY; Mon, 29 Jun 2020 19:40:00 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpzdB-0003u8-NH
 for linux-nvme@merlin.infradead.org; Mon, 29 Jun 2020 19:39:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=U8tCb4h17a0rL+ZZdq18PAV+yDbvWsH96GC5gLr1vuc=; b=nX6H72rwNYY0Uodz17aYP0bvqk
 9gSPPIErWrLN9tgBHhvIIJkOaKgVsJo4ToReNXQeJGEcFnMtOneeM9lvCktfvClRYHDtNElRZj2F6
 8v+5TR40P7wF9sVI6FNZgxu5kOa2TO9rd1Tk/CVbrQpxDd6MTudpLktSUdh658nMTs0t6pbT8L0DU
 oLPd3ny9KNPaRYcpjp5BKqZJvHEO/AQA8V3gJ3oEvuI02EACAolGm1l5wddF6nve0W3P8jOwehhxt
 HUK/Vlvd1nnX1ZKXj4mHlQgYSZ/JMOLFPBM2+5fH9Dc8Y+nLWvs6b4VA5Ugvca4/Jx5cC4ko7Xilx
 7KEB9k7g==;
Received: from [2001:4bb8:184:76e3:fcca:c8dc:a4bf:12fa] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpzd9-0004Eg-CR; Mon, 29 Jun 2020 19:39:52 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/20] nfblock: stop using ->queuedata
Date: Mon, 29 Jun 2020 21:39:28 +0200
Message-Id: <20200629193947.2705954-2-hch@lst.de>
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

Instead of setting up the queuedata as well just use one private data
field.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/emu/nfblock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/m68k/emu/nfblock.c b/arch/m68k/emu/nfblock.c
index c3a630440512e9..87e8b1700acd28 100644
--- a/arch/m68k/emu/nfblock.c
+++ b/arch/m68k/emu/nfblock.c
@@ -61,7 +61,7 @@ struct nfhd_device {
 
 static blk_qc_t nfhd_make_request(struct request_queue *queue, struct bio *bio)
 {
-	struct nfhd_device *dev = queue->queuedata;
+	struct nfhd_device *dev = bio->bi_disk->private_data;
 	struct bio_vec bvec;
 	struct bvec_iter iter;
 	int dir, len, shift;
@@ -122,7 +122,6 @@ static int __init nfhd_init_one(int id, u32 blocks, u32 bsize)
 	if (dev->queue == NULL)
 		goto free_dev;
 
-	dev->queue->queuedata = dev;
 	blk_queue_logical_block_size(dev->queue, bsize);
 
 	dev->disk = alloc_disk(16);
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
