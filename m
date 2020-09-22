Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E30C4727F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 14:00:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC2E20719
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 14:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xCXIv3Y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC2E20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P5UC062nc6P+jO/iWXIH8rU20sGFtD8b5honFFrYHYY=; b=xCXIv3Y3OQk9/iHaeBVgxTnzL
	DYqqIFNpyh2wepnE8HTIIf73jGBbS0Kr1QEOWvMN7TQ5kwDagoOpeZeZb8W5DIrkvtTtZ/vd+Ab3z
	EbyNitP/VFBet/tsAUNLV8S/do+r2xoGjvedMbz09PImFALRZL1Pl0A+k1FK3JRuh2B8tVcuECe2c
	X2BoVWLr9rM3ak/L8MIZhJzUXDp9XVirbtic7fSTjWQiUkwZHH5mQ/UfZcIt9Cy9h8x6FnY6mM9PF
	2uifnKWdyIlEGo3kMtTJYYI3CPdqoxgoh+3F+qeW0dF8t+L/2FRbDSPdUFVL+uTG9kDAUSQJbyayS
	E2OY0FPhA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKipy-00029j-3t; Tue, 22 Sep 2020 14:00:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKipt-00028c-AH
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 14:00:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2652968AFE; Tue, 22 Sep 2020 15:59:57 +0200 (CEST)
Date: Tue, 22 Sep 2020 15:59:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tong Zhang <ztong0001@gmail.com>
Subject: Re: [PATCH] nvme: fix use-after-free during booting
Message-ID: <20200922135956.GA23437@lst.de>
References: <20200916153605.5253-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200916153605.5253-1-ztong0001@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_100001_577192_21CBDCBC 
X-CRM114-Status: GOOD (  11.81  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Tong,

can you test this patch?

diff --git a/block/genhd.c b/block/genhd.c
index 99c64641c3148c..6473ae703789e4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -836,6 +836,7 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	 * so that it sticks around as long as @disk is there.
 	 */
 	WARN_ON_ONCE(!blk_get_queue(disk->queue));
+	disk->flags |= GENHD_FL_QUEUE_REF;
 
 	disk_add_events(disk);
 	blk_integrity_add(disk);
@@ -1567,7 +1568,7 @@ static void disk_release(struct device *dev)
 	kfree(disk->random);
 	disk_replace_part_tbl(disk, NULL);
 	hd_free_part(&disk->part0);
-	if (disk->queue)
+	if (disk->flags & GENHD_FL_QUEUE_REF)
 		blk_put_queue(disk->queue);
 	kfree(disk);
 }
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 4ab853461dff25..9441077ee10329 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -135,6 +135,7 @@ struct hd_struct {
 #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	0x0100
 #define GENHD_FL_NO_PART_SCAN			0x0200
 #define GENHD_FL_HIDDEN				0x0400
+#define GENHD_FL_QUEUE_REF			0x0800
 
 enum {
 	DISK_EVENT_MEDIA_CHANGE			= 1 << 0, /* media changed */

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
