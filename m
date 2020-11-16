Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5908DC4742C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:06:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02A9320B80
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ni/djhdl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NxdcCH21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A9320B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9qX+3fDUOMQXiJLmHkjeR7OVOQCSaSE1ZpNIcNzkTF8=; b=Ni/djhdlIeARWpOUjuab5lMiS
	7wAArO4tVsQJgnWdxEekYEvTm8RXKblvjZYZCOaqHSIjQTH9zkepr5mmlTpxRgk/gWpDoLAyej0Wm
	vqeo48BLdDYXednDUvG5rcAIJ0cS9LHdtRbCpajtsIdoNsxg5jteB9tYZ8m629AdwG1dm0BfR4lWX
	QUaSp6plz6VHPh6SAm7YaMdF4d0x+K6ErNiQMvBhb+tz5sJ/xZs4WEjdDO13I+5U93KsxjOlgTYvB
	plbaOkyk7fzJmN60cLdDK5B1GOCBJ+5aNPPh0JZdfi9IsklOvhNqUHvgjpq9vXGK1kUN9SHbtczS5
	A7RTuUdQA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg5G-0000ZP-Ql; Mon, 16 Nov 2020 15:06:23 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyG-0003iF-9w
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=432B/HqYIabrrukDRcMGdzlFQ4i1D0sjcTyhKWP2cJc=; b=NxdcCH21KU0PaY1Ri6HGwnc/L0
 Pm1N/StwGgisA5L0p+2kPsr3LyRSKmgmK71GuTbdbvT9TCfwbfRA1dvjC1q7rJtFSAtSyf3mHxeWW
 EZ5rlOqNukX80JHmh+gFjJH5eHC5ab37sgk28CMqNBjsJHct6TH7Aec/aHSrjGlIQeH8J/fYjoVWT
 m9S/ORPThsGxcTn9lN7RKKBuWsC/aTMeA81vfKRaWx1OhdXImDLKffH2sllTwanrVTcnLmBpn+vIK
 rxhCqctUbf1QtVmOhyQKeyb0Bskq73OmiuHEGSYFZZUivRg1xuCXEdg0WX9hj3ohTWz5bCrIzwOJR
 oOsbfaxQ==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyE-0003y0-K9; Mon, 16 Nov 2020 14:59:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 40/78] ide: remove ide_{,un}register_region
Date: Mon, 16 Nov 2020 15:57:31 +0100
Message-Id: <20201116145809.410558-41-hch@lst.de>
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

There is no need to ever register the fake gendisk used for ide-tape.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ide/ide-probe.c | 32 --------------------------------
 drivers/ide/ide-tape.c  |  2 --
 include/linux/ide.h     |  3 ---
 3 files changed, 37 deletions(-)

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 1ddc45a04418cd..076d34b381720f 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -929,38 +929,6 @@ static struct kobject *ata_probe(dev_t dev, int *part, void *data)
 	return NULL;
 }
 
-static struct kobject *exact_match(dev_t dev, int *part, void *data)
-{
-	struct gendisk *p = data;
-	*part &= (1 << PARTN_BITS) - 1;
-	return &disk_to_dev(p)->kobj;
-}
-
-static int exact_lock(dev_t dev, void *data)
-{
-	struct gendisk *p = data;
-
-	if (!get_disk_and_module(p))
-		return -1;
-	return 0;
-}
-
-void ide_register_region(struct gendisk *disk)
-{
-	blk_register_region(MKDEV(disk->major, disk->first_minor),
-			    disk->minors, NULL, exact_match, exact_lock, disk);
-}
-
-EXPORT_SYMBOL_GPL(ide_register_region);
-
-void ide_unregister_region(struct gendisk *disk)
-{
-	blk_unregister_region(MKDEV(disk->major, disk->first_minor),
-			      disk->minors);
-}
-
-EXPORT_SYMBOL_GPL(ide_unregister_region);
-
 void ide_init_disk(struct gendisk *disk, ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
index 6f26634b22bbec..88b96437b22e62 100644
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -1822,7 +1822,6 @@ static void ide_tape_remove(ide_drive_t *drive)
 
 	ide_proc_unregister_driver(drive, tape->driver);
 	device_del(&tape->dev);
-	ide_unregister_region(tape->disk);
 
 	mutex_lock(&idetape_ref_mutex);
 	put_device(&tape->dev);
@@ -2026,7 +2025,6 @@ static int ide_tape_probe(ide_drive_t *drive)
 		      "n%s", tape->name);
 
 	g->fops = &idetape_block_ops;
-	ide_register_region(g);
 
 	return 0;
 
diff --git a/include/linux/ide.h b/include/linux/ide.h
index 62653769509f89..2c300689a51a5c 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1493,9 +1493,6 @@ static inline void ide_acpi_port_init_devices(ide_hwif_t *hwif) { ; }
 static inline void ide_acpi_set_state(ide_hwif_t *hwif, int on) {}
 #endif
 
-void ide_register_region(struct gendisk *);
-void ide_unregister_region(struct gendisk *);
-
 void ide_check_nien_quirk_list(ide_drive_t *);
 void ide_undecoded_slave(ide_drive_t *);
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
