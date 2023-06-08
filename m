Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44893C7EE23
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jun 2023 11:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eGImU7RddjAi80e+tW424dPAVsMSpId5HtotbM4PBXg=; b=NxSf9egcI3mW6+VGozvUyZFh9z
	rsTEXDAT6b+zVzbbQWOygqEo4u6MAPgpO+d/KhaSUQUzcjzRgHjETdl96pcmry7d+GW/zxabfontY
	rXuphEWF909ndDPna3ziFCcuIo0RMmAC5nKr0qP4+pYMZJbkI2i+02wuo3TBh+FsiYR0KsAOQ1qfH
	XGcSYBD3/7DL54vswbdQDPWi6gKCUKpxg6TY21Pth+xlx6MMuK9puliLe3uMnhtM5yoEqjMMXlKyD
	uUCAXLeLFRJBRjsPnv/NyAqLkQshQwkLXXE5/juXjt/rCIu6N9EThjUyZ68VXK98PGigzqBjtTVen
	YNrQ17DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7DQA-0091jC-0c;
	Thu, 08 Jun 2023 11:03:14 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q7DQ4-0091eW-27;
	Thu, 08 Jun 2023 11:03:09 +0000
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
Subject: [PATCH 03/30] cdrom: remove the unused mode argument to cdrom_ioctl
Date: Thu,  8 Jun 2023 13:02:31 +0200
Message-Id: <20230608110258.189493-4-hch@lst.de>
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
 drivers/cdrom/cdrom.c | 2 +-
 drivers/cdrom/gdrom.c | 2 +-
 drivers/scsi/sr.c     | 2 +-
 include/linux/cdrom.h | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index e3eab319cb0474..245e5bbb05d41c 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3336,7 +3336,7 @@ static int mmc_ioctl(struct cdrom_device_info *cdi, unsigned int cmd,
  * ATAPI / SCSI specific code now mainly resides in mmc_ioctl().
  */
 int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
-		fmode_t mode, unsigned int cmd, unsigned long arg)
+		unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
 	int ret;
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index eaa2d5a90bc82f..14922403983e9e 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -505,7 +505,7 @@ static int gdrom_bdops_ioctl(struct block_device *bdev, fmode_t mode,
 	int ret;
 
 	mutex_lock(&gdrom_mutex);
-	ret = cdrom_ioctl(gd.cd_info, bdev, mode, cmd, arg);
+	ret = cdrom_ioctl(gd.cd_info, bdev, cmd, arg);
 	mutex_unlock(&gdrom_mutex);
 
 	return ret;
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 61b83880e395a4..444c7efc14cba7 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -539,7 +539,7 @@ static int sr_block_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	scsi_autopm_get_device(sdev);
 
 	if (cmd != CDROMCLOSETRAY && cmd != CDROMEJECT) {
-		ret = cdrom_ioctl(&cd->cdi, bdev, mode, cmd, arg);
+		ret = cdrom_ioctl(&cd->cdi, bdev, cmd, arg);
 		if (ret != -ENOSYS)
 			goto put;
 	}
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index cc5717cb0fa8a8..4aea8c82d16971 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -103,8 +103,8 @@ int cdrom_read_tocentry(struct cdrom_device_info *cdi,
 /* the general block_device operations structure: */
 int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode);
 extern void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode);
-extern int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
-		       fmode_t mode, unsigned int cmd, unsigned long arg);
+int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
+		unsigned int cmd, unsigned long arg);
 extern unsigned int cdrom_check_events(struct cdrom_device_info *cdi,
 				       unsigned int clearing);
 
-- 
2.39.2


