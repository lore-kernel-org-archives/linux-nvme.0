Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387BEC55178
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:04:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6380208C7
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hx8lJpPy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tH8UdTWn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6380208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QkuDkMkAkM779am3ewTHscoApaMfKKa33SmL8EkxgeI=; b=hx8lJpPypm85L61Py2VKaejSY
	bnInL7iO5byqFDbsf+NDybCf2vxMHoRXr/HdFwKmmUzL/BMsMT2JOE9BLoxwlgzgsRD4QwZGbDWEW
	D8Ck7I6tTfioJr6sHIAAZiLpjkd3N7a1TGzsdJbLiZ8hHCI6uasl1IK6BcV8ShPZQ0EvMMXmdcsKi
	kZq+uKF9KXkVqMlUi6QJwgGRO07EXDzIcyHp7/6AllUM/Q+JLmFlSkqdQvLe/CsRQMmTBxHJpx0VW
	3jQC08jQJt3osKxghcX5KGVmhLg6N4dHv1dF/wdbbGjK7EG6WMVC2panwbFK9lVZN0kybMzpdSwkp
	PI2AubqMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb71r-00016T-56; Fri, 06 Nov 2020 19:04:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb71l-00013c-IE
 for linux-nvme@merlin.infradead.org; Fri, 06 Nov 2020 19:04:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=msAxRVgou3+s48HjnTxbv/pHmvKh+OTllxGOwTa9PDs=; b=tH8UdTWnkIuPETR5ERZJsxXqO9
 RuvncvGLMp3eecYVL5xbljvoepHQIy9LJuMEB0q+0oEeVpE399lmWu6TR7di2UcX2jvpnbzMAgO+T
 lVDmVMLdl2vdcru/zg5P/TlhhczznEvHfAs7dYsm2yxmv3ZUvGZmRnMrTXcu7NYlNoXgOCzkHUicc
 AGwDOPnsGK9wvtFNI87/4PdBzDhhP3bDY7qTssXyAvbxU4+VHn4Hlisg3BkNqrDEoze0VUh2Ufbsg
 sLEPDubY8OG8SNMA5E0TVDhcZDYddMUr3C9Qfc/tX9zYtsMYh7soL6M1ihPRkp1F9FRPk6C6a4b5z
 IcLgD9AQ==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb71j-0000vL-Sx; Fri, 06 Nov 2020 19:04:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/24] block: add a return value to set_capacity_and_notify
Date: Fri,  6 Nov 2020 20:03:18 +0100
Message-Id: <20201106190337.1973127-7-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106190337.1973127-1-hch@lst.de>
References: <20201106190337.1973127-1-hch@lst.de>
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
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Return if the function ended up sending an uevent or not.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 7 +++++--
 include/linux/genhd.h | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index d8d9d6c1c916e1..8c350fecfe8bfe 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -47,9 +47,9 @@ static void disk_release_events(struct gendisk *disk);
 
 /*
  * Set disk capacity and notify if the size is not currently zero and will not
- * be set to zero.
+ * be set to zero.  Returns true if a uevent was sent, otherwise false.
  */
-void set_capacity_and_notify(struct gendisk *disk, sector_t size)
+bool set_capacity_and_notify(struct gendisk *disk, sector_t size)
 {
 	sector_t capacity = get_capacity(disk);
 
@@ -60,7 +60,10 @@ void set_capacity_and_notify(struct gendisk *disk, sector_t size)
 		char *envp[] = { "RESIZE=1", NULL };
 
 		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
+		return true;
 	}
+
+	return false;
 }
 EXPORT_SYMBOL_GPL(set_capacity_and_notify);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 596f31b5a3e133..4b22bfd9336e1a 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -315,7 +315,7 @@ static inline int get_disk_ro(struct gendisk *disk)
 extern void disk_block_events(struct gendisk *disk);
 extern void disk_unblock_events(struct gendisk *disk);
 extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
-void set_capacity_and_notify(struct gendisk *disk, sector_t size);
+bool set_capacity_and_notify(struct gendisk *disk, sector_t size);
 
 /* drivers/char/random.c */
 extern void add_disk_randomness(struct gendisk *disk) __latent_entropy;
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
