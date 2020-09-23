Return-Path: <SRS0=afDi=DA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D80C4363D
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 05:57:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDBE421924
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 05:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IvTn6ImO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBE421924
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bonNiMikO0gUUYMILzk7NVynSxpJ59MmM9f+HRqbtzk=; b=IvTn6ImOuxS/HyL/6hmVj6DSp
	4NmUJSd5lf2aCEr7VVattGtxrboinfiO0uXmnPv+nPNGyXmpXtfR7n8njBQGMQXZIzrLa5TGHCsHc
	9UFXBLr3BsavqVS0PBOO9Y7gPfZ2bmwFGKBDlW3f2p3+D5MQCXFD/9PNGCNnLEcrPVehavjRncPjJ
	uPi4Fu2UBr5RV1efiKsxi98gUA8QTQsdYrn6LUOQfnoR/XxUSqxqRfhIwcS7uux6RfkdZV85byNWb
	UMOQinDCS1TC2ehYw3da04teUMMwcg4oySn5oGBctotziQz2cEVHVK1JunHTTp5+clvOO+c++wPSn
	I/bXhjwdw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKxmV-0000ky-CP; Wed, 23 Sep 2020 05:57:31 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKxmT-0000kQ-8t
 for linux-nvme@lists.infradead.org; Wed, 23 Sep 2020 05:57:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E41F668AFE; Wed, 23 Sep 2020 07:57:25 +0200 (CEST)
Date: Wed, 23 Sep 2020 07:57:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tong Zhang <ztong0001@gmail.com>
Subject: Re: [PATCH] nvme: fix use-after-free during booting
Message-ID: <20200923055725.GA15442@lst.de>
References: <20200916153605.5253-1-ztong0001@gmail.com>
 <20200922135956.GA23437@lst.de>
 <CAA5qM4BPKZaqH0SHS3zCO7oz=f3Ow_zB2fqtJYUrbbFBNbWsNQ@mail.gmail.com>
 <20200922164154.GA1894@lst.de>
 <61E8905E-E3FE-46EB-8283-9B35B4F069E1@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61E8905E-E3FE-46EB-8283-9B35B4F069E1@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200923_015729_446886_4AC4738B 
X-CRM114-Status: GOOD (  13.76  )
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

I suspect the patch below might be better.  Can you send me a full dmesg
with this one applied?  Preferably on top of Jens' for-next branch?


diff --git a/block/genhd.c b/block/genhd.c
index 9d060e79eb31d8..ef2784c69d59ee 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -832,7 +832,9 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
 	 * Take an extra ref on queue which will be put on disk_release()
 	 * so that it sticks around as long as @disk is there.
 	 */
-	WARN_ON_ONCE(!blk_get_queue(disk->queue));
+	WARN_ON_ONCE(blk_queue_dying(disk->queue));
+	__blk_get_queue(disk->queue);
+	disk->flags |= GENHD_FL_QUEUE_REF;
 
 	disk_add_events(disk);
 	blk_integrity_add(disk);
@@ -1564,7 +1566,7 @@ static void disk_release(struct device *dev)
 	kfree(disk->random);
 	disk_replace_part_tbl(disk, NULL);
 	hd_free_part(&disk->part0);
-	if (disk->queue)
+	if (disk->flags & GENHD_FL_QUEUE_REF)
 		blk_put_queue(disk->queue);
 	kfree(disk);
 }
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 1c97cf84f011a7..822a619924e3b5 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -133,6 +133,7 @@ struct hd_struct {
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
