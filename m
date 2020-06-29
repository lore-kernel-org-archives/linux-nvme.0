Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22856C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 19:40:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8563206A1
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 19:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LCp/n5Lg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oq4DxXRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8563206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tKHAkfb/eBhhQ/oMIk24RuR1YidwW3SfrPlzlDMHz+c=; b=LCp/n5Lg6v2kOYCKmK8MiCWXB
	IaAOhH49983t3BMsiO/9XwTxQehWtLwD8cHCAA46Mfjd8XWEEqhOUMjMSq/a5hiRf33fJwZpHPeOQ
	AP7OO/9lfU4u1TxA0cKjKQj0d0ydSRfjP4hq8FTDDQZPRtP37OHcckeNkxyFkXYVDrzs9XyjmnrSA
	mnIV3wNUl04gaG6cj90ms2P33Na/7piVmVeyLfdS9pNoeMZZ4iXp4Mh3adMHN2DG0Kn0JDuEom5+4
	26m5r5NpFZcYSxrXJEcx351zBxsn4VJi/yfg85ztBsX61XJrCqetpbGNDniZhgOYpQ+E92dq1rXry
	iv55xy74g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpzdv-0004Ds-IX; Mon, 29 Jun 2020 19:40:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpzdP-0003y8-Kv
 for linux-nvme@merlin.infradead.org; Mon, 29 Jun 2020 19:40:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=KKN2Rzx949H+NoG0kbydbtU4p/7MhBgkwEQu/fGRZVo=; b=oq4DxXRygnkoBpVqu4ShnFx67a
 pJSZTPl/8bQB6t5SbLzEq7GEtk7yVppnDQoMDkwlIASlkU5Gv3TVvPrB44rfw3eqnI/6/46THwVdz
 bpj2LW1dF9GjmaqLsSZnWCGOiWCgne+0b3/wk5CW3PxduJhQZcvYQZkZnB44cjXI3RV8EqpdASKu/
 RkLdLy683AjRfxZt01zPKBwDhf+S1bMB3O91CxDduFf+rpctsL9V3FYWiqw0E6KmkpHgdogcoq/bv
 FM6mYXGlxSu8Yj3wFLmkB7cMQ6vzzc2fkWPIa1S/y8ELqgdqrW/IuX4PrQsWtaDG8vRqd88y0uRuj
 7Jl9LgYQ==;
Received: from [2001:4bb8:184:76e3:fcca:c8dc:a4bf:12fa] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpzdN-0004Ju-WF; Mon, 29 Jun 2020 19:40:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/20] dm: stop using ->queuedata
Date: Mon, 29 Jun 2020 21:39:37 +0200
Message-Id: <20200629193947.2705954-11-hch@lst.de>
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
 drivers/md/dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index e44473fe0f4873..c8d91f271c272e 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1789,7 +1789,7 @@ static blk_qc_t dm_process_bio(struct mapped_device *md,
 
 static blk_qc_t dm_make_request(struct request_queue *q, struct bio *bio)
 {
-	struct mapped_device *md = q->queuedata;
+	struct mapped_device *md = bio->bi_disk->private_data;
 	blk_qc_t ret = BLK_QC_T_NONE;
 	int srcu_idx;
 	struct dm_table *map;
@@ -1995,7 +1995,6 @@ static struct mapped_device *alloc_dev(int minor)
 	md->queue = blk_alloc_queue(dm_make_request, numa_node_id);
 	if (!md->queue)
 		goto bad;
-	md->queue->queuedata = md;
 
 	md->disk = alloc_disk_node(1, md->numa_node_id);
 	if (!md->disk)
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
