Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E05C4742C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:07:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE1E22384
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KLaZ+i58";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E7BcK9hA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE1E22384
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=b26J1T1ix1AGCTFgwwgT+6oDoWRUmzCHxi2GVUtMwZg=; b=KLaZ+i58DIBLnMZI/P923Ibmq
	GUtIVbjUhy3F+2qRkIAvDFBny0xmxlkgdkHEOe1biVzEc6vT/6jjpoj4rAfgE9EPMTRLNRE8jUf9e
	zEVQVz0J6hVyjW2E6nY9MxkgT/tSc4XDwlJOgGQdfFj2rxvOha7CmyYtb0gl5bxLwxu3gbLg0Kv5P
	YdoSKmIQpPAWD0+2veLfXPI99chdA682JDzhTKkqxH5J9dS/EeK1f/SIFZ7aUsKmnoNJpmFwZ2NYX
	BbAT9+nRncPT06/RUFFhgTzFvRe2oWiUiW5WfrPlmQpziCi0vPriX1n9il5hcGUSKhsuwI1TsDS4v
	EskUD4tmQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg6f-00016S-II; Mon, 16 Nov 2020 15:07:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyO-0003nC-TP
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=O5A83Oi0Xx0wCgZ53MCDk0SimnnpHqXZpeb9/Xjg+3I=; b=E7BcK9hAyDSHxcI7VinrLs/x4+
 GbPQzDVUV1gmtfeik/ecOJf1xAz9adMm1AlR5n+8pmOFubRvS/7JC38pGCYM9ZwlEJ4zvxSDihrYM
 JGQCaf5k451aQcjTbxUWntTZRSfcMeTsf8Du7UrxdxqROv2m47Q52OOrWyg+7vXskLoftSze8ezz6
 aMmgYUku1QWTkRciIOFj5T0KMfHWt98qdMt4QXSWxtgUUImsabTkg/eANqkgiZzmVtnscOj29Xw6f
 e1x2pMJGB6+SMSCN0E1pYgQM50zCWis0+N6qx617dZwyzoH0THRVg26q4h6UoR9/dNcUrYteSODTY
 uCKNHu/A==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyN-000402-5y; Mon, 16 Nov 2020 14:59:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 46/78] ide: switch to __register_blkdev for command set probing
Date: Mon, 16 Nov 2020 15:57:37 +0100
Message-Id: <20201116145809.410558-47-hch@lst.de>
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

ide is the last user of the blk_register_region framework except for the
tracking of allocated gendisk.  Switch to __register_blkdev, even if that
doesn't allow us to trivially find out which command set to probe for.
That means we now always request all modules when a user tries to access
an unclaimed ide device node, but except for a few potentially loaded
modules for a fringe use case of a deprecated and soon to be removed
driver that doesn't make a difference.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ide/ide-probe.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 076d34b381720f..1c1567bb519429 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -902,31 +902,12 @@ static int init_irq (ide_hwif_t *hwif)
 	return 1;
 }
 
-static int ata_lock(dev_t dev, void *data)
+static void ata_probe(dev_t dev)
 {
-	/* FIXME: we want to pin hwif down */
-	return 0;
-}
-
-static struct kobject *ata_probe(dev_t dev, int *part, void *data)
-{
-	ide_hwif_t *hwif = data;
-	int unit = *part >> PARTN_BITS;
-	ide_drive_t *drive = hwif->devices[unit];
-
-	if ((drive->dev_flags & IDE_DFLAG_PRESENT) == 0)
-		return NULL;
-
-	if (drive->media == ide_disk)
-		request_module("ide-disk");
-	if (drive->media == ide_cdrom || drive->media == ide_optical)
-		request_module("ide-cd");
-	if (drive->media == ide_tape)
-		request_module("ide-tape");
-	if (drive->media == ide_floppy)
-		request_module("ide-floppy");
-
-	return NULL;
+	request_module("ide-disk");
+	request_module("ide-cd");
+	request_module("ide-tape");
+	request_module("ide-floppy");
 }
 
 void ide_init_disk(struct gendisk *disk, ide_drive_t *drive)
@@ -967,7 +948,7 @@ static int hwif_init(ide_hwif_t *hwif)
 		return 0;
 	}
 
-	if (register_blkdev(hwif->major, hwif->name))
+	if (__register_blkdev(hwif->major, hwif->name, ata_probe))
 		return 0;
 
 	if (!hwif->sg_max_nents)
@@ -989,8 +970,6 @@ static int hwif_init(ide_hwif_t *hwif)
 		goto out;
 	}
 
-	blk_register_region(MKDEV(hwif->major, 0), MAX_DRIVES << PARTN_BITS,
-			    THIS_MODULE, ata_probe, ata_lock, hwif);
 	return 1;
 
 out:
@@ -1582,7 +1561,6 @@ static void ide_unregister(ide_hwif_t *hwif)
 	/*
 	 * Remove us from the kernel's knowledge
 	 */
-	blk_unregister_region(MKDEV(hwif->major, 0), MAX_DRIVES<<PARTN_BITS);
 	kfree(hwif->sg_table);
 	unregister_blkdev(hwif->major, hwif->name);
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
