Return-Path: <SRS0=M7ZW=NH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C96C4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 13:25:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E980E611C4
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Aug 2021 13:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E980E611C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HzW9BFtBjydj1sPMCVTlnqrIF6q+zVkkHaOdP5oIwmw=; b=OakSuzoXip5sGz
	k/+uu166t/ri+W2ZZErPApMnT0LhAqFmdKavDkzVIciFTkPIPuRgB30pV6hu2or8wy+w99xJBa60x
	YtuSqBgMREbQbb1mbS9aR7V7QQkXZzkyIhSgDo35xV0r6NKOtyOvm4NMng9DeLH+tjhqsZXmP7WZh
	erKjmYv1ymC/qiVMugnHehoxZcF2i0GuBGQT/Ib9mZ7WT6cni4N+MgXsZDRI5Yde+44FNFsVXHkvR
	mUxHqFDFat9UujDedl8cpCrrOV4V9gDJ8PiGy8NuHyHIrAMnMPqcf9Qr1oKF2wwbyF0JUDiT9LeWs
	l/QV2HamuqU3dkM3e05A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mFccd-00H6SU-4y; Mon, 16 Aug 2021 13:25:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFccb-00H6Ri-57
 for linux-nvme@bombadil.infradead.org; Mon, 16 Aug 2021 13:25:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=b+mPlQ41yJJaOaprcjDi6z6quhDobi/0BF6d4pv7hHY=; b=jO8bLjuDodO2AJaxaqUBG24sow
 S43kIQc7B8n+78Dz4WnZQSVGAjXtfKVgEqhH74Vp/qxhRNuvH7zD4qA4j9Uyvn9MSMVYTForPM6fZ
 /hePVQNCSNP8sQDSOLmzDInmfio5FPp7fMh0yevDzSp1hrT0RFGf88Acu9CfdufbDGVDPI8fZ6txn
 3UUYVxVuTmMEZdpmcdDFG4KsQ/bSNX/uniNYkGrIEx2M+2qOz57nD1NP1cp4uMyCIjnWmbWIHH0dQ
 Sf1XtjvS3R5PsMjlyPpj/0VbUs67+msxOoM3zzBMa4gm0+lFNWZCte0FVwektjfXFI8csLsGqzmhI
 jxG3vBbw==;
Received: from [2001:4bb8:188:1b1:3731:604a:a6cd:dc60] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mFcb7-001Oqz-N8; Mon, 16 Aug 2021 13:24:42 +0000
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
Subject: [PATCH 4/9] block: cleanup the lockdep handling in *alloc_disk
Date: Mon, 16 Aug 2021 15:19:05 +0200
Message-Id: <20210816131910.615153-5-hch@lst.de>
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

Pass the lockdep name to the low-level __blk_alloc_disk helper and
hardcode the name for it given that the number of minors or node_id
are not very useful information.  While this passes a pointless
argument for non-lockdep builds that is not really an issue as
disk allocation is a probe time only slow path.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c         |  5 +++--
 block/genhd.c          |  8 +++++---
 include/linux/blk-mq.h | 10 +++-------
 include/linux/genhd.h  | 23 ++++++-----------------
 4 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d2725f94491d..4c56e43e6992 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3133,7 +3133,8 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_init_queue);
 
-struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata)
+struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
+		struct lock_class_key *lkclass)
 {
 	struct request_queue *q;
 	struct gendisk *disk;
@@ -3142,7 +3143,7 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata)
 	if (IS_ERR(q))
 		return ERR_CAST(q);
 
-	disk = __alloc_disk_node(0, set->numa_node);
+	disk = __alloc_disk_node(0, set->numa_node, lkclass);
 	if (!disk) {
 		blk_cleanup_queue(q);
 		return ERR_PTR(-ENOMEM);
diff --git a/block/genhd.c b/block/genhd.c
index 731a46063132..2ad2b25dfc87 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1254,7 +1254,8 @@ dev_t blk_lookup_devt(const char *name, int partno)
 	return devt;
 }
 
-struct gendisk *__alloc_disk_node(int minors, int node_id)
+struct gendisk *__alloc_disk_node(int minors, int node_id,
+		struct lock_class_key *lkclass)
 {
 	struct gendisk *disk;
 
@@ -1282,6 +1283,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 	disk_to_dev(disk)->type = &disk_type;
 	device_initialize(disk_to_dev(disk));
 	inc_diskseq(disk);
+	lockdep_init_map(&disk->lockdep_map, "(bio completion)", lkclass, 0);
 #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
 	INIT_LIST_HEAD(&disk->slave_bdevs);
 #endif
@@ -1298,7 +1300,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 }
 EXPORT_SYMBOL(__alloc_disk_node);
 
-struct gendisk *__blk_alloc_disk(int node)
+struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
 {
 	struct request_queue *q;
 	struct gendisk *disk;
@@ -1307,7 +1309,7 @@ struct gendisk *__blk_alloc_disk(int node)
 	if (!q)
 		return NULL;
 
-	disk = __alloc_disk_node(0, node);
+	disk = __alloc_disk_node(0, node, lkclass);
 	if (!disk) {
 		blk_cleanup_queue(q);
 		return NULL;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 22215db36122..13ba1861e688 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -432,18 +432,14 @@ enum {
 	((policy & ((1 << BLK_MQ_F_ALLOC_POLICY_BITS) - 1)) \
 		<< BLK_MQ_F_ALLOC_POLICY_START_BIT)
 
+struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
+		struct lock_class_key *lkclass);
 #define blk_mq_alloc_disk(set, queuedata)				\
 ({									\
 	static struct lock_class_key __key;				\
-	struct gendisk *__disk = __blk_mq_alloc_disk(set, queuedata);	\
 									\
-	if (!IS_ERR(__disk))						\
-		lockdep_init_map(&__disk->lockdep_map,			\
-			"(bio completion)", &__key, 0);			\
-	__disk;								\
+	__blk_mq_alloc_disk(set, queuedata, &__key);			\
 })
-struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set,
-		void *queuedata);
 struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *);
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		struct request_queue *q);
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index b47e297cd551..3d2e5ee30677 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -259,27 +259,21 @@ static inline sector_t get_capacity(struct gendisk *disk)
 int bdev_disk_changed(struct gendisk *disk, bool invalidate);
 void blk_drop_partitions(struct gendisk *disk);
 
-extern struct gendisk *__alloc_disk_node(int minors, int node_id);
+struct gendisk *__alloc_disk_node(int minors, int node_id,
+		struct lock_class_key *lkclass);
 extern void put_disk(struct gendisk *disk);
 
 #define alloc_disk_node(minors, node_id)				\
 ({									\
 	static struct lock_class_key __key;				\
-	const char *__name;						\
-	struct gendisk *__disk;						\
 									\
-	__name = "(gendisk_completion)"#minors"("#node_id")";		\
-									\
-	__disk = __alloc_disk_node(minors, node_id);			\
-									\
-	if (__disk)							\
-		lockdep_init_map(&__disk->lockdep_map, __name, &__key, 0); \
-									\
-	__disk;								\
+	__alloc_disk_node(minors, node_id, &__key);			\
 })
 
 #define alloc_disk(minors) alloc_disk_node(minors, NUMA_NO_NODE)
 
+struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass);
+
 /**
  * blk_alloc_disk - allocate a gendisk structure
  * @node_id: numa node to allocate on
@@ -291,15 +285,10 @@ extern void put_disk(struct gendisk *disk);
  */
 #define blk_alloc_disk(node_id)						\
 ({									\
-	struct gendisk *__disk = __blk_alloc_disk(node_id);		\
 	static struct lock_class_key __key;				\
 									\
-	if (__disk)							\
-		lockdep_init_map(&__disk->lockdep_map,			\
-			"(bio completion)", &__key, 0);			\
-	__disk;								\
+	__blk_alloc_disk(node_id, &__key);				\
 })
-struct gendisk *__blk_alloc_disk(int node);
 void blk_cleanup_disk(struct gendisk *disk);
 
 int __register_blkdev(unsigned int major, const char *name,
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
