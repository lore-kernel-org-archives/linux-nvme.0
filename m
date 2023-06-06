Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9605DC7EE24
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 07:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vLDKGJIN4sUAMcx+ss63SchZIFVZL96BaI3AvIUMzr4=; b=a7XSxmQpdWlY147Xbjt1um26gY
	6pYN5WwRTrC1Zs6S3RFaW9cc72qRMeSOot/Iq8+eRaTJetu/Qr4LHmqZaOi9XAmkXHoloEQPjUceb
	AEPWU/3sxLG1Q53UfEo/SzYXAvEN2JB03Q01gzG3Mj2+AKGvT4MS2Ec07ia2q31QSg0F+se7YEpzB
	mU4E9uy0GAEg15fx6reWtAYMFQltNOlkvDwb1WP1DRHb15134zDATInB79zTYsAbVlMurXSebg4Yo
	b6C1OuTLhmKvOFwBfdnovQJfK5nu7c6jV87r/dpUPUG96HxPQT/MbQuYe1yo0DVu2PmibS8pny/ug
	ZC5aKFJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6RM1-000cYl-0s;
	Tue, 06 Jun 2023 07:43:45 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q6RJX-000Zqu-1D;
	Tue, 06 Jun 2023 07:41:11 +0000
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
Subject: [PATCH 24/31] rnbd-srv: replace sess->open_flags with a "bool readonly"
Date: Tue,  6 Jun 2023 09:39:43 +0200
Message-Id: <20230606073950.225178-25-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606073950.225178-1-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de>
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

Stop passing the fmode_t around and just use a simple bool to track if
an export is read-only.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/rnbd/rnbd-srv-sysfs.c |  3 +--
 drivers/block/rnbd/rnbd-srv.c       | 15 +++++++--------
 drivers/block/rnbd/rnbd-srv.h       |  2 +-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index d5d9267e1fa5e4..ebd95771c85ec7 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -88,8 +88,7 @@ static ssize_t read_only_show(struct kobject *kobj, struct kobj_attribute *attr,
 
 	sess_dev = container_of(kobj, struct rnbd_srv_sess_dev, kobj);
 
-	return sysfs_emit(page, "%d\n",
-			  !(sess_dev->open_flags & FMODE_WRITE));
+	return sysfs_emit(page, "%d\n", sess_dev->readonly);
 }
 
 static struct kobj_attribute rnbd_srv_dev_session_ro_attr =
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 29d560472d05ba..b680071342b898 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -222,7 +222,7 @@ void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id)
 	blkdev_put(sess_dev->bdev, NULL);
 	mutex_lock(&sess_dev->dev->lock);
 	list_del(&sess_dev->dev_list);
-	if (sess_dev->open_flags & FMODE_WRITE)
+	if (!sess_dev->readonly)
 		sess_dev->dev->open_write_cnt--;
 	mutex_unlock(&sess_dev->dev->lock);
 
@@ -561,7 +561,7 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 static struct rnbd_srv_sess_dev *
 rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
 			      const struct rnbd_msg_open *open_msg,
-			      struct block_device *bdev, fmode_t open_flags,
+			      struct block_device *bdev, bool readonly,
 			      struct rnbd_srv_dev *srv_dev)
 {
 	struct rnbd_srv_sess_dev *sdev = rnbd_sess_dev_alloc(srv_sess);
@@ -576,7 +576,7 @@ rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
 	sdev->bdev		= bdev;
 	sdev->sess		= srv_sess;
 	sdev->dev		= srv_dev;
-	sdev->open_flags	= open_flags;
+	sdev->readonly		= readonly;
 	sdev->access_mode	= open_msg->access_mode;
 
 	return sdev;
@@ -681,13 +681,12 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	struct rnbd_srv_sess_dev *srv_sess_dev;
 	const struct rnbd_msg_open *open_msg = msg;
 	struct block_device *bdev;
-	fmode_t open_flags;
+	fmode_t open_flags = FMODE_READ;
 	char *full_path;
 	struct rnbd_msg_open_rsp *rsp = data;
 
 	trace_process_msg_open(srv_sess, open_msg);
 
-	open_flags = FMODE_READ;
 	if (open_msg->access_mode != RNBD_ACCESS_RO)
 		open_flags |= FMODE_WRITE;
 
@@ -736,9 +735,9 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		goto blkdev_put;
 	}
 
-	srv_sess_dev = rnbd_srv_create_set_sess_dev(srv_sess, open_msg,
-						     bdev, open_flags,
-						     srv_dev);
+	srv_sess_dev = rnbd_srv_create_set_sess_dev(srv_sess, open_msg, bdev,
+				open_msg->access_mode == RNBD_ACCESS_RO,
+				srv_dev);
 	if (IS_ERR(srv_sess_dev)) {
 		pr_err("Opening device '%s' on session %s failed, creating sess_dev failed, err: %ld\n",
 		       full_path, srv_sess->sessname, PTR_ERR(srv_sess_dev));
diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
index f5962fd31d62e4..76077a9db3dd55 100644
--- a/drivers/block/rnbd/rnbd-srv.h
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -52,7 +52,7 @@ struct rnbd_srv_sess_dev {
 	struct kobject                  kobj;
 	u32                             device_id;
 	bool				keep_id;
-	fmode_t                         open_flags;
+	bool				readonly;
 	struct kref			kref;
 	struct completion               *destroy_comp;
 	char				pathname[NAME_MAX];
-- 
2.39.2


