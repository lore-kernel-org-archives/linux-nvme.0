Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD1FC7EE29
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jun 2023 11:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BmFZdJDxSYPrPp/5b46O5wB0cxwTyzebO+dineKE9zs=; b=fcErPnCekE18WcNEYk2fMqzm1h
	fk8JpB8df5uqVhyP7HkzgNP+OM3ycEqkEtxBqOd04aXjJTWH7GMC8kGsEJJQfSvFbdBodSDgj7+MF
	Hp6ClwyK3CKph/Ro7Sd7BfAocv2h/ZE1bLi2S1Mh1u2KCyVTN2JmkpX1ArhMpZXtIgcbcsLyUqcnr
	VQiEJFucbr8e5za7b/sdnTLMByfKIMkZ4P/h+9e9QYogKEK8nQo1CaiiDcJv5Ogy93HZrfHxN4VZ1
	5y6MYu1bCb7AVwyoG/z64DBQ/G7eEecEJzOr0RG80/uzx8o9iVduB01ruBzKKVnxchsdrH9p88x1R
	fVvjcBOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7DQD-0091mk-2k;
	Thu, 08 Jun 2023 11:03:17 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q7DQ8-0091fh-0H;
	Thu, 08 Jun 2023 11:03:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>,
	Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 04/30] cdrom: remove the unused cdrom_close_write release code
Date: Thu,  8 Jun 2023 13:02:32 +0200
Message-Id: <20230608110258.189493-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608110258.189493-1-hch@lst.de>
References: <20230608110258.189493-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

cdrom_close_write is empty, and the for_data flag it is keyed off is
never set.  Remove all this clutter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 drivers/cdrom/cdrom.c | 15 ---------------
 include/linux/cdrom.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 245e5bbb05d41c..08abf1ffede002 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -978,15 +978,6 @@ static void cdrom_dvd_rw_close_write(struct cdrom_device_info *cdi)
 	cdi->media_written = 0;
 }
 
-static int cdrom_close_write(struct cdrom_device_info *cdi)
-{
-#if 0
-	return cdrom_flush_cache(cdi);
-#else
-	return 0;
-#endif
-}
-
 /* badly broken, I know. Is due for a fixup anytime. */
 static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 {
@@ -1282,12 +1273,6 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
 	opened_for_data = !(cdi->options & CDO_USE_FFLAGS) ||
 		!(mode & FMODE_NDELAY);
 
-	/*
-	 * flush cache on last write release
-	 */
-	if (CDROM_CAN(CDC_RAM) && !cdi->use_count && cdi->for_data)
-		cdrom_close_write(cdi);
-
 	cdo->release(cdi);
 	if (cdi->use_count == 0) {      /* last process that closes dev*/
 		if (opened_for_data &&
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 4aea8c82d16971..0a5db0b0c958a1 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -61,7 +61,6 @@ struct cdrom_device_info {
 	__u8 last_sense;
 	__u8 media_written;		/* dirty flag, DVD+RW bookkeeping */
 	unsigned short mmc3_profile;	/* current MMC3 profile */
-	int for_data;
 	int (*exit)(struct cdrom_device_info *);
 	int mrw_mode_page;
 	__s64 last_media_change_ms;
-- 
2.39.2


