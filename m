Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238C7C433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3950206EB
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h7M+CPGR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a3R6hLNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3950206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M3a8iFxbBeBMLoPzT/PFlaUmh+ln1FaaFv+aY39UMD8=; b=h7M+CPGRGx8etEfMsZL0NrjCG
	/Gx9xSigcpaIlyAMXcPqT1yIx4QAvETuEgfWe8Jj8K9IUIDvbBHxWuDTANSBxweH9A0tg0J2NOI2K
	vC0sKqbAGxlMTZeJPQ/Uqs+yQq0DxcWKWTHEz1M3TfZW/0uYiWdMWIKQLxO4UQQrxJua+CdZTPmAP
	eqTsq2byv60poaKJT5hUwT2wjxF+kdkpWWD2NLf3LsHmKk/FQrO5ULFDeFytDaNMpeDk6yIkBBwEG
	JqlYch/rlg93K5Piu8RyCDVZpBhl7YLVWpMdJV+Tv53yZRonJUxZ8cXKiRrCeD95nAlGuV2GlXyg9
	YXxkQrqtA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD8fh-0002RX-1t; Tue, 01 Sep 2020 15:58:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8fZ-0002ND-9s
 for linux-nvme@merlin.infradead.org; Tue, 01 Sep 2020 15:58:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=X/wfONNMX9AkocUJrvkgvfoHlYcJ3otMPBdPBvDFSjg=; b=a3R6hLNAfPXw6R8QRXbGznXJl/
 XYw3Qcp5GUZVdLvYz3g7yZTdhLBPVHDMlSfggoOPLUZWWTlpi4VSyTLAeSxeaGxz4415i0HuxYlHn
 Rrzp4jXd9c1wB6Wl3fp75EZkwMR2pMOu0V4GqphS42Sy5cwGMmFOYSTu0f0WbNwh1AsqMoTho9gFC
 RdhXzlE/7Zkah6VP7mUGqtnJKwpPFotBogYpnKN+bSpdkd42Pcgek9fWuBUDFm0apHm4YOMPi1N2y
 tFJ5Kmb07jMbKgTkS/gXIrjXeu0LFRibRlegC43oSpS4bZjr/7ucSGkobwgV+XWFLT35JhGnmQ+r9
 HsMdIZtA==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8fX-0004QE-CS; Tue, 01 Sep 2020 15:57:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/9] block: use revalidate_disk_size in
 set_capacity_revalidate_and_notify
Date: Tue,  1 Sep 2020 17:57:44 +0200
Message-Id: <20200901155748.2884-6-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
References: <20200901155748.2884-1-hch@lst.de>
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
Cc: linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, nbd@other.debian.org,
 virtualization@lists.linux-foundation.org, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Only virtio_blk and xen-blkfront set the revalidate argument to true,
and both do not implement the ->revalidate_disk method.  So switch
to the helper that just updates the size instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 7 +++----
 include/linux/genhd.h | 4 ++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index a2c0ec694918e5..431d4081b50ec7 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -50,14 +50,13 @@ static void disk_release_events(struct gendisk *disk);
  * zero and will not be set to zero
  */
 void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
-					bool revalidate)
+					bool update_bdev)
 {
 	sector_t capacity = get_capacity(disk);
 
 	set_capacity(disk, size);
-
-	if (revalidate)
-		revalidate_disk(disk);
+	if (update_bdev)
+		revalidate_disk_size(disk, true);
 
 	if (capacity != size && capacity != 0 && size != 0) {
 		char *envp[] = { "RESIZE=1", NULL };
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 8e9c9d3a493fae..c340b392452ce6 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -315,8 +315,8 @@ static inline int get_disk_ro(struct gendisk *disk)
 extern void disk_block_events(struct gendisk *disk);
 extern void disk_unblock_events(struct gendisk *disk);
 extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
-extern void set_capacity_revalidate_and_notify(struct gendisk *disk,
-			sector_t size, bool revalidate);
+void set_capacity_revalidate_and_notify(struct gendisk *disk, sector_t size,
+		bool update_bdev);
 extern unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask);
 
 /* drivers/char/random.c */
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
