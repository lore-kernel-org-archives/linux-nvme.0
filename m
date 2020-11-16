Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266A2C5519F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:05:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908B52244C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N3mPcYr1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a7d0WKhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908B52244C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MuwGB/qkqPSKiwORcW/cV32x1HRKTaZg/kKuev1Rz08=; b=N3mPcYr1U5drsaCSQ3U1bzbED
	EjlO3zkZm/YVetLfKNwxPzYqLMgrBImEP+pE7tifxrWXOqXiBYZVEEcbesa9qX0u4ZAy+SRcWWgDy
	Dg0yqnE8gf875oI8MwPyKnJ5kkmzBSQ3dG4JT0JIMmiA4aof1cflnCCTWjca8rWJI6e+RAiSdLQUR
	n1+zqOIzBL90e3CaBB54nhKqctcCf9wAJzBsUJnBcY4E4rZ384b/ueNmC8fBcTKx44wI3FhjT9f+t
	CPvtMCwXws3V/nukfOcJwSgMkaqy7GGPpbkFnqMpL/Hm+k2+xCOYMOGUMtdMgiR7S3WR1DgYDX3Fz
	AslGx+2sg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg4K-0000LG-5o; Mon, 16 Nov 2020 15:05:24 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefy4-0003cj-Nt
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:58:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=xZanwokwrC93vQLNLNyxIE9cwRexAjHIbs3YFwVPsFg=; b=a7d0WKhPNBtgQ87fZA08kVqe1y
 s8Sr2lxZqA4u53myzeDnnzR5qIAz6vA3egUoMXd0PFkUGzFv/UxEUPI892XyeOmB7FRMPywqZgzFQ
 fvJvVKuwSCKubwUgCeDnhSdQj3zjceiRZRQvdQW64tflG1Ubobb0xgCwA9qgVb3P8bufG21KACqxF
 LdxKiVKNAom0BaCGTkLFBbfzny15lEtGihDxBpVpKvP1ZCnxYnkEVNdSSfERf5h6KpD5Xp1Gipw2N
 P3IlVQJDBBHLI1ckJlQziKc3EInlMrYDiIlMfsnRoAyesz+vylm3lK1KNLRuTKMEj958SrIUpqIbd
 95x8ALqA==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefy3-0003uy-0n; Mon, 16 Nov 2020 14:58:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 32/78] block: remove set_device_ro
Date: Mon, 16 Nov 2020 15:57:23 +0100
Message-Id: <20201116145809.410558-33-hch@lst.de>
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

Fold set_device_ro into its only remaining caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 7 -------
 block/ioctl.c         | 2 +-
 include/linux/genhd.h | 1 -
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 8c350fecfe8bfe..b0f0b0cac9aa7f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1843,13 +1843,6 @@ static void set_disk_ro_uevent(struct gendisk *gd, int ro)
 	kobject_uevent_env(&disk_to_dev(gd)->kobj, KOBJ_CHANGE, envp);
 }
 
-void set_device_ro(struct block_device *bdev, int flag)
-{
-	bdev->bd_part->policy = flag;
-}
-
-EXPORT_SYMBOL(set_device_ro);
-
 void set_disk_ro(struct gendisk *disk, int flag)
 {
 	struct disk_part_iter piter;
diff --git a/block/ioctl.c b/block/ioctl.c
index 96cb4544736468..04255dc5f3bff3 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -371,7 +371,7 @@ static int blkdev_roset(struct block_device *bdev, fmode_t mode,
 		if (ret)
 			return ret;
 	}
-	set_device_ro(bdev, n);
+	bdev->bd_part->policy = n;
 	return 0;
 }
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 4b22bfd9336e1a..8427ad8bef520d 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -304,7 +304,6 @@ extern void del_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk(dev_t dev, int *partno);
 extern struct block_device *bdget_disk(struct gendisk *disk, int partno);
 
-extern void set_device_ro(struct block_device *bdev, int flag);
 extern void set_disk_ro(struct gendisk *disk, int flag);
 
 static inline int get_disk_ro(struct gendisk *disk)
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
