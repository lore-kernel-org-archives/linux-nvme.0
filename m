Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F1AC8300C
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jun 2023 11:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WVOLYCYgNhurfOY8cVan3fvTgQgKmYPWrYutrJ2vXRM=; b=D42m+r1VubvpasdxZZy0Bo5BAS
	8ExWoVUHemk/axu+8ayvJDBoA9UQ4SgbYD31GPeRmzyY5QlRojoHjSCci+vOsytqYaiKXse/I7A5A
	kIY/3AVNpcfbQjD0RGUG/FF6RhhdAsCpDkYBppNgAo6fwn71Q1NlEjujn28cgOcPN5+z56SCipodi
	ux4pIVKughPYmrwfr3cUdmxoorYSVhViVashi7vJ+zMBK0yPlgNVZiWkUcg35fg55IcGCA51sUd/S
	iOiU1/nduYm54nsS/+J4dgJWk1mCppyaCkOi4cRpEw7Iiuna8YHwHlZbfTixaeulo5zvwOI8194dH
	GeXJRHOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7DQ8-0091he-0m;
	Thu, 08 Jun 2023 11:03:12 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q7DQ2-0091dM-18;
	Thu, 08 Jun 2023 11:03:06 +0000
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
Subject: [PATCH 02/30] cdrom: remove the unused bdev argument to cdrom_open
Date: Thu,  8 Jun 2023 13:02:30 +0200
Message-Id: <20230608110258.189493-3-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 drivers/cdrom/cdrom.c | 3 +--
 drivers/cdrom/gdrom.c | 2 +-
 drivers/scsi/sr.c     | 2 +-
 include/linux/cdrom.h | 3 +--
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 416f723a2dbb33..e3eab319cb0474 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1155,8 +1155,7 @@ int open_for_data(struct cdrom_device_info *cdi)
  * is in their own interest: device control becomes a lot easier
  * this way.
  */
-int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
-	       fmode_t mode)
+int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode)
 {
 	int ret;
 
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index ceded5772aac6d..eaa2d5a90bc82f 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -481,7 +481,7 @@ static int gdrom_bdops_open(struct block_device *bdev, fmode_t mode)
 	bdev_check_media_change(bdev);
 
 	mutex_lock(&gdrom_mutex);
-	ret = cdrom_open(gd.cd_info, bdev, mode);
+	ret = cdrom_open(gd.cd_info, mode);
 	mutex_unlock(&gdrom_mutex);
 	return ret;
 }
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 12869e6d4ebda8..61b83880e395a4 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -498,7 +498,7 @@ static int sr_block_open(struct block_device *bdev, fmode_t mode)
 		sr_revalidate_disk(cd);
 
 	mutex_lock(&cd->lock);
-	ret = cdrom_open(&cd->cdi, bdev, mode);
+	ret = cdrom_open(&cd->cdi, mode);
 	mutex_unlock(&cd->lock);
 
 	scsi_autopm_put_device(sdev);
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 67caa909e3e615..cc5717cb0fa8a8 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -101,8 +101,7 @@ int cdrom_read_tocentry(struct cdrom_device_info *cdi,
 		struct cdrom_tocentry *entry);
 
 /* the general block_device operations structure: */
-extern int cdrom_open(struct cdrom_device_info *cdi, struct block_device *bdev,
-			fmode_t mode);
+int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode);
 extern void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode);
 extern int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
 		       fmode_t mode, unsigned int cmd, unsigned long arg);
-- 
2.39.2


