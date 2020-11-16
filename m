Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D01C61DD8
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:20:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 410D521D93
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="24gMS76u";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sSbJyd5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 410D521D93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pV/lkWhisJDyqbzz6M6Dd8uIeHdgQ7s0fNoKwRhHTBA=; b=24gMS76uBusMZUuzUPbn/isKP
	ePhlEWw3rhc3TtePC9rmpXWBFa15rj2oGjUlLHDkLng1O6sZV1nS9UdRnaX7iOnU5n6/VIgVlxmxk
	ZSA5VbzxsP6Yuk9JlRLKnqu6dLv89ToQsB6fC6R7pG6tpG5WKmlEkXEBbifdd/e602rhoDw/xUKaz
	cVUsAkdD13foanv6izGUXewPbJ+Zul30/9gyTGaKUUCrCL5OJZ5Uvoh15m1fVNVOYdbIu63VGCyBg
	BMHUqCyKiPuhCgN84h9ZOMYvcswE4+Sw+cEf+SPCSsKX6UG2Ut0YMtKn4HZ2M+BmrJeA04qRz1Hd1
	YW3tTCwNw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kegIX-00069i-Np; Mon, 16 Nov 2020 15:20:06 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefzA-0004Df-PN
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 15:00:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=YfjTrndpak8c8C7A2Wr6OEv1ltyYeLktzUiwQ2pu+CA=; b=sSbJyd5Z5KD2Jm06fbaragik+M
 U4XXVDpuxMNv4/WjvlIpVZ5hUtJVUjJwX0o6moSI38FP1aoBNjPnqu8o8kZG9K4b+WNesnRErmT0w
 c6uY7DfOfd9C5ydCEyUMR677DxoiIxYLRbGGQfJ2J5j6waIzphSYMTKUR+nE58YtYY8s0sKyBH3Ag
 gi1DVUl5tW1CH54AIrFJbhR7wa+qgoeCULdOKd8s1qQnapCkGCpIt0k3E1/tTPjMNE85mVQKwftyC
 EQD17+/p3VVrTmL/7uawHNQSIdYnwo33SsrBvTjwr6J9LQP9HpQU2Rf1rToCbxKxVr+U/txNCS6he
 amu9O3qQ==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefz7-0004KI-Jc; Mon, 16 Nov 2020 15:00:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 77/78] fs: simplify the get_super_thawed interface
Date: Mon, 16 Nov 2020 15:58:08 +0100
Message-Id: <20201116145809.410558-78-hch@lst.de>
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

Merge get_super_thawed and get_super_exclusive_thawed into a single
function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/quota/quota.c   |  4 ++--
 fs/super.c         | 42 +++++++++++-------------------------------
 include/linux/fs.h |  3 +--
 3 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 9af95c7a0bbe3c..21d43933213965 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -876,9 +876,9 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
 	if (IS_ERR(bdev))
 		return ERR_CAST(bdev);
 	if (quotactl_cmd_onoff(cmd))
-		sb = get_super_exclusive_thawed(bdev);
+		sb = get_super_thawed(bdev, true);
 	else if (quotactl_cmd_write(cmd))
-		sb = get_super_thawed(bdev);
+		sb = get_super_thawed(bdev, false);
 	else
 		sb = get_super(bdev);
 	bdput(bdev);
diff --git a/fs/super.c b/fs/super.c
index b327a82bc1946b..50995f8abd1bf1 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -789,8 +789,17 @@ struct super_block *get_super(struct block_device *bdev)
 }
 EXPORT_SYMBOL(get_super);
 
-static struct super_block *__get_super_thawed(struct block_device *bdev,
-					      bool excl)
+/**
+ * get_super_thawed - get thawed superblock of a device
+ * @bdev: device to get the superblock for
+ * @excl: lock s_umount exclusive if %true, else shared.
+ *
+ * Scans the superblock list and finds the superblock of the file system mounted
+ * on the device.  The superblock is returned with s_umount held once it is
+ * thawed (or immediately if it was not frozen), or %NULL if no superblock was
+ * found.
+ */
+struct super_block *get_super_thawed(struct block_device *bdev, bool excl)
 {
 	while (1) {
 		struct super_block *s = __get_super(bdev, excl);
@@ -805,37 +814,8 @@ static struct super_block *__get_super_thawed(struct block_device *bdev,
 		put_super(s);
 	}
 }
-
-/**
- *	get_super_thawed - get thawed superblock of a device
- *	@bdev: device to get the superblock for
- *
- *	Scans the superblock list and finds the superblock of the file system
- *	mounted on the device. The superblock is returned once it is thawed
- *	(or immediately if it was not frozen). %NULL is returned if no match
- *	is found.
- */
-struct super_block *get_super_thawed(struct block_device *bdev)
-{
-	return __get_super_thawed(bdev, false);
-}
 EXPORT_SYMBOL(get_super_thawed);
 
-/**
- *	get_super_exclusive_thawed - get thawed superblock of a device
- *	@bdev: device to get the superblock for
- *
- *	Scans the superblock list and finds the superblock of the file system
- *	mounted on the device. The superblock is returned once it is thawed
- *	(or immediately if it was not frozen) and s_umount semaphore is held
- *	in exclusive mode. %NULL is returned if no match is found.
- */
-struct super_block *get_super_exclusive_thawed(struct block_device *bdev)
-{
-	return __get_super_thawed(bdev, true);
-}
-EXPORT_SYMBOL(get_super_exclusive_thawed);
-
 /**
  * get_active_super - get an active reference to the superblock of a device
  * @bdev: device to get the superblock for
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8667d0cdc71e76..d026d177a526bf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3132,8 +3132,7 @@ extern struct file_system_type *get_filesystem(struct file_system_type *fs);
 extern void put_filesystem(struct file_system_type *fs);
 extern struct file_system_type *get_fs_type(const char *name);
 extern struct super_block *get_super(struct block_device *);
-extern struct super_block *get_super_thawed(struct block_device *);
-extern struct super_block *get_super_exclusive_thawed(struct block_device *bdev);
+struct super_block *get_super_thawed(struct block_device *bdev, bool excl);
 extern struct super_block *get_active_super(struct block_device *bdev);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
