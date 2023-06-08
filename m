Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58ED7C7EE29
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jun 2023 11:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cT8NDVtiIsZNzV7dqaCyqaAv6UgEz/7VfiIdR+IkQQM=; b=0SiwkhK4iCEjnqW7UhR271WmMm
	0y2BM9650xe18ZsCvLELYJMQEmjFsd2HZ0DwaVYrtW36hrY9kfL+8jwPxjWFSCXctCc0zqEOKLReL
	XFndvhBjwTPGOwV/kgx4QoquWRbJx27rUOVzCukbZpoMLM/I3LhelyVJKILCnok+IRccS6S9nAvg/
	ayhAYHpsMlpsCheRgQky43nqZHekQvlpZ2AGCcCu7FBNUBwSeTMPiwRXB/1BfWwx/fLJSns7xZmAs
	lpdTXrOh+J1wravcEwzPqDwBuVaj9vc8/9pSKYakDR7PQpPMoWQ0NJy+vm8QaIvtwTYyDyl9Vkrci
	EIjdyZXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7DTg-0095ZL-0c;
	Thu, 08 Jun 2023 11:06:52 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q7DRI-0092xn-1H;
	Thu, 08 Jun 2023 11:04:24 +0000
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
	linux-pm@vger.kernel.org
Subject: [PATCH 29/30] block: store the holder in file->private_data
Date: Thu,  8 Jun 2023 13:02:57 +0200
Message-Id: <20230608110258.189493-30-hch@lst.de>
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

Store the file struct used as the holder in file->private_data as an
indicator that this file descriptor was opened exclusively to  remove
the last use of FMODE_EXCL.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 0d714d050a462c..9871bd6052b416 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -478,7 +478,7 @@ blk_mode_t file_to_blk_mode(struct file *file)
 		mode |= BLK_OPEN_READ;
 	if (file->f_mode & FMODE_WRITE)
 		mode |= BLK_OPEN_WRITE;
-	if (file->f_mode & FMODE_EXCL)
+	if (file->private_data)
 		mode |= BLK_OPEN_EXCL;
 	if (file->f_flags & O_NDELAY)
 		mode |= BLK_OPEN_NDELAY;
@@ -507,12 +507,15 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	filp->f_flags |= O_LARGEFILE;
 	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 
+	/*
+	 * Use the file private data to store the holder for exclusive openes.
+	 * file_to_blk_mode relies on it being present to set BLK_OPEN_EXCL.
+	 */
 	if (filp->f_flags & O_EXCL)
-		filp->f_mode |= FMODE_EXCL;
+		filp->private_data = filp;
 
 	bdev = blkdev_get_by_dev(inode->i_rdev, file_to_blk_mode(filp),
-				 (filp->f_mode & FMODE_EXCL) ? filp : NULL,
-				 NULL);
+				 filp->private_data, NULL);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
@@ -523,8 +526,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 
 static int blkdev_release(struct inode *inode, struct file *filp)
 {
-	blkdev_put(I_BDEV(filp->f_mapping->host),
-		   (filp->f_mode & FMODE_EXCL) ? filp : NULL);
+	blkdev_put(I_BDEV(filp->f_mapping->host), filp->private_data);
 	return 0;
 }
 
-- 
2.39.2


