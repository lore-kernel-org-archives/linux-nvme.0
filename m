Return-Path: <SRS0=M7ZW=NH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB53C4320A
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 13:30:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A6E6632E3
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 13:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3A6E6632E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1NoIrExU1Bf4Q7efrGUFLr9odnphzGXqoPypgb1pvSA=; b=SV4kH+IN2qc4z0
	/EX785fZHT+/D5/kd8NMBSk1BgmNTqIYoqzxJqshIYlCpqPCL8lwbV0Rfj1BbHk4QzXdSkgmJDd+y
	b3DsfQX2uL6FXFE/BFwN/C4Lj8pK2p0Niu/C93hq2HeWKReDgUQXULXFXo47Yx8XWkvkaBbK8IMlX
	Uf2ivnH/gWHu9PafrTh3bNdbE6fG2HB9S4C3b0sf/RyN2ICf1I126wFC3fVl7nHHxfuCBE2pS7Kw0
	/qYynqlG5CNO+6FaiUM57Wzsbv8agKD4AOZ4eWzjqKNhWdxC2yjvhr/l2Ub7TRV15JqTp2cYEUqE9
	vwD4izxKdv5oNLvS39Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mFcgf-00H7q0-R0; Mon, 16 Aug 2021 13:29:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFcgd-00H7pH-F9
 for linux-nvme@bombadil.infradead.org; Mon, 16 Aug 2021 13:29:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=Z9Yri10K8M6BGWsRMrTxjIL24t36teCRg8L/pCbSkH8=; b=oG5gOuW0HzJM1OtrDGoUAqkcm6
 EUTmPZK9dTTxPIk9iHscmU26urUK0QQYRXEOBAi/bGIBXubzyJ2hvFjHMtCcIwa4IkxDIUDotxF/m
 OwKAGW3farxT2NRauRfLByQ2l4iDWaL92S+uvrZgItcNeqgbqc4Mxx63rD/lxVSukC+SfxjthoQ+E
 7fdO9qh3k/mg72P44vGRuxmcYn5n951Wl3T/9zaRPovcHBXmz2e16zVs5xPAnRetAhYK3craFqxJa
 ACZ0gPNAU+9asBoBW+QM437oIlXha/0BqnfwvY8N6GegluALpo7QasyHEnppYNs/tB3YPmgzoOl+0
 ARv0jBkw==;
Received: from [2001:4bb8:188:1b1:3731:604a:a6cd:dc60] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFcfm-001PUw-0D; Mon, 16 Aug 2021 13:29:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Doug Gilbert <dgilbert@interlog.com>,
 =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
Subject: [PATCH 8/9] block: hold a request_queue reference for the lifetime of
 struct gendisk
Date: Mon, 16 Aug 2021 15:19:09 +0200
Message-Id: <20210816131910.615153-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210816131910.615153-1-hch@lst.de>
References: <20210816131910.615153-1-hch@lst.de>
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

Acquire the queue ref dropped in disk_release in __blk_alloc_disk so any
allocate gendisk always has a queue reference.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 19 +++++++------------
 include/linux/genhd.h |  1 -
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index f18122ee2778..6294517cebe6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -551,15 +551,6 @@ void device_add_disk(struct device *parent, struct gendisk *disk,
 	register_disk(parent, disk, groups);
 	blk_register_queue(disk);
 
-	/*
-	 * Take an extra ref on queue which will be put on disk_release()
-	 * so that it sticks around as long as @disk is there.
-	 */
-	if (blk_get_queue(disk->queue))
-		set_bit(GD_QUEUE_REF, &disk->state);
-	else
-		WARN_ON_ONCE(1);
-
 	disk_add_events(disk);
 	blk_integrity_add(disk);
 }
@@ -1087,8 +1078,7 @@ static void disk_release(struct device *dev)
 	disk_release_events(disk);
 	kfree(disk->random);
 	xa_destroy(&disk->part_tbl);
-	if (test_bit(GD_QUEUE_REF, &disk->state) && disk->queue)
-		blk_put_queue(disk->queue);
+	blk_put_queue(disk->queue);
 	iput(disk->part0->bd_inode);	/* frees the disk */
 }
 
@@ -1259,9 +1249,12 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 {
 	struct gendisk *disk;
 
+	if (!blk_get_queue(q))
+		return NULL;
+
 	disk = kzalloc_node(sizeof(struct gendisk), GFP_KERNEL, node_id);
 	if (!disk)
-		return NULL;
+		goto out_put_queue;
 
 	disk->bdi = bdi_alloc(node_id);
 	if (!disk->bdi)
@@ -1296,6 +1289,8 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 	bdi_put(disk->bdi);
 out_free_disk:
 	kfree(disk);
+out_put_queue:
+	blk_put_queue(q);
 	return NULL;
 }
 EXPORT_SYMBOL(__alloc_disk_node);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 13e90e6231d8..55acefdd8a20 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -149,7 +149,6 @@ struct gendisk {
 	unsigned long state;
 #define GD_NEED_PART_SCAN		0
 #define GD_READ_ONLY			1
-#define GD_QUEUE_REF			2
 
 	struct mutex open_mutex;	/* open/close mutex */
 	unsigned open_partitions;	/* number of open partitions */
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
