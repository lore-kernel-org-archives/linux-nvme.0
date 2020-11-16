Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0075C64E69
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:06:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF792344C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CQhkiebW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uXQm/yyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF792344C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cXc5DeN2uyaV9fcDSuPzHqW7xggCIT5MjEV9JA0Gjb4=; b=CQhkiebWfItA/XCrT3X1djwnR
	XdFMmCV6Zly49xQev7OIv9vIt3TOKuhCDMKpBiFyY7mHkhVKeblmov1imQt8G3P4SPCg5WTCHwzzz
	lsNXnU6tH9PjPMgBc5O6IlIFqz8hyPwA0NqH1ia7N4iv2YkLRWjKT3AhVuHzkbd/hrqGlGEgy5Pyd
	V0yRPo2bfa9t0Ex9VVvYYBNyd4bIAsGQIsdrDyAFYnyv1ZMlli6Ug2SOCd2FHWhxcldjhxLj0ausY
	lY8jtczzhfIdUgvrEThSyv0rOci4iYVoc3oeVQmQ04mWBi3IMfUmHhijNlEBVNHPtIzjU/hQiDGj7
	C6lcY3cPQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg4o-0000SU-Rt; Mon, 16 Nov 2020 15:05:54 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyB-0003g9-Rs
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=9MasGm4sRMlqjIfBzvyRbCzoZ9vCizFcPgSc5rhaRew=; b=uXQm/yyIiJQnYODeCv7tLBroh6
 arXMrp0Tk+2mkvK5mlMoVYQZhqOzsPFVFoVsNhqaXKjdbjxT6ddIFdHimSsiofqQFd042iVeyoPjf
 kjJVvZC7dJvRJWgFk5vnXEzcfiS2wRI+9CAHzFb6PaF2pf3aK/Vv/y+iBA3+wNlveiknIb+cM4k72
 sy6+79pc3yQnXdRLw5qP9MUrMQWCUQr94hrqb0BHYJRuZX0RRf1WPApUNdGnDYjJKsodIy93uSBGl
 mXFAo94CwxYf32WkNugPW9wMsBEd2E2lCs3nmZ+m6b8g/Nfawh6vTjWCNJv2VNFFCFBCwJLajvHZl
 HFZ0RH2Q==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyA-0003wx-DT; Mon, 16 Nov 2020 14:59:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 37/78] block: split block_class_lock
Date: Mon, 16 Nov 2020 15:57:28 +0100
Message-Id: <20201116145809.410558-38-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
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
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Split the block_class_lock mutex into one each to protect bdev_map
and major_names.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/genhd.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 482f7b89802010..2a20372756625e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -25,7 +25,6 @@
 
 #include "blk.h"
 
-static DEFINE_MUTEX(block_class_lock);
 static struct kobject *block_depr;
 
 struct bdev_map {
@@ -37,6 +36,7 @@ struct bdev_map {
 	int (*lock)(dev_t, void *);
 	void *data;
 } *bdev_map[255];
+static DEFINE_MUTEX(bdev_map_lock);
 
 /* for extended dynamic devt allocation, currently only one major is used */
 #define NR_EXT_DEVT		(1 << MINORBITS)
@@ -400,6 +400,7 @@ static struct blk_major_name {
 	int major;
 	char name[16];
 } *major_names[BLKDEV_MAJOR_HASH_SIZE];
+static DEFINE_MUTEX(major_names_lock);
 
 /* index in the above - for now: assume no multimajor ranges */
 static inline int major_to_index(unsigned major)
@@ -412,11 +413,11 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
 {
 	struct blk_major_name *dp;
 
-	mutex_lock(&block_class_lock);
+	mutex_lock(&major_names_lock);
 	for (dp = major_names[major_to_index(offset)]; dp; dp = dp->next)
 		if (dp->major == offset)
 			seq_printf(seqf, "%3d %s\n", dp->major, dp->name);
-	mutex_unlock(&block_class_lock);
+	mutex_unlock(&major_names_lock);
 }
 #endif /* CONFIG_PROC_FS */
 
@@ -445,7 +446,7 @@ int register_blkdev(unsigned int major, const char *name)
 	struct blk_major_name **n, *p;
 	int index, ret = 0;
 
-	mutex_lock(&block_class_lock);
+	mutex_lock(&major_names_lock);
 
 	/* temporary */
 	if (major == 0) {
@@ -498,7 +499,7 @@ int register_blkdev(unsigned int major, const char *name)
 		kfree(p);
 	}
 out:
-	mutex_unlock(&block_class_lock);
+	mutex_unlock(&major_names_lock);
 	return ret;
 }
 
@@ -510,7 +511,7 @@ void unregister_blkdev(unsigned int major, const char *name)
 	struct blk_major_name *p = NULL;
 	int index = major_to_index(major);
 
-	mutex_lock(&block_class_lock);
+	mutex_lock(&major_names_lock);
 	for (n = &major_names[index]; *n; n = &(*n)->next)
 		if ((*n)->major == major)
 			break;
@@ -520,7 +521,7 @@ void unregister_blkdev(unsigned int major, const char *name)
 		p = *n;
 		*n = p->next;
 	}
-	mutex_unlock(&block_class_lock);
+	mutex_unlock(&major_names_lock);
 	kfree(p);
 }
 
@@ -671,7 +672,7 @@ void blk_register_region(dev_t devt, unsigned long range, struct module *module,
 		p->data = data;
 	}
 
-	mutex_lock(&block_class_lock);
+	mutex_lock(&bdev_map_lock);
 	for (i = 0, p -= n; i < n; i++, p++, index++) {
 		struct bdev_map **s = &bdev_map[index % 255];
 		while (*s && (*s)->range < range)
@@ -679,7 +680,7 @@ void blk_register_region(dev_t devt, unsigned long range, struct module *module,
 		p->next = *s;
 		*s = p;
 	}
-	mutex_unlock(&block_class_lock);
+	mutex_unlock(&bdev_map_lock);
 }
 EXPORT_SYMBOL(blk_register_region);
 
@@ -690,7 +691,7 @@ void blk_unregister_region(dev_t devt, unsigned long range)
 	unsigned i;
 	struct bdev_map *found = NULL;
 
-	mutex_lock(&block_class_lock);
+	mutex_lock(&bdev_map_lock);
 	for (i = 0; i < min(n, 255u); i++, index++) {
 		struct bdev_map **s;
 		for (s = &bdev_map[index % 255]; *s; s = &(*s)->next) {
@@ -703,7 +704,7 @@ void blk_unregister_region(dev_t devt, unsigned long range)
 			}
 		}
 	}
-	mutex_unlock(&block_class_lock);
+	mutex_unlock(&bdev_map_lock);
 	kfree(found);
 }
 EXPORT_SYMBOL(blk_unregister_region);
@@ -1034,7 +1035,7 @@ static struct gendisk *lookup_gendisk(dev_t dev, int *partno)
 	unsigned long best = ~0UL;
 
 retry:
-	mutex_lock(&block_class_lock);
+	mutex_lock(&bdev_map_lock);
 	for (p = bdev_map[MAJOR(dev) % 255]; p; p = p->next) {
 		struct kobject *(*probe)(dev_t, int *, void *);
 		struct module *owner;
@@ -1055,7 +1056,7 @@ static struct gendisk *lookup_gendisk(dev_t dev, int *partno)
 			module_put(owner);
 			continue;
 		}
-		mutex_unlock(&block_class_lock);
+		mutex_unlock(&bdev_map_lock);
 		kobj = probe(dev, partno, data);
 		/* Currently ->owner protects _only_ ->probe() itself. */
 		module_put(owner);
@@ -1063,7 +1064,7 @@ static struct gendisk *lookup_gendisk(dev_t dev, int *partno)
 			return dev_to_disk(kobj_to_dev(kobj));
 		goto retry;
 	}
-	mutex_unlock(&block_class_lock);
+	mutex_unlock(&bdev_map_lock);
 	return NULL;
 }
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
