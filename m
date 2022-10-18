Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A6CC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 13:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2O0+kVa1PjbazyStYtpeTghJkhPX4oZ74tmjFAj5Rao=; b=vlYHwT9lp3nG1x2nyWnM+ZNPXo
	MBoIPWSM9B1QuCwldE3+v1XrqvOsYPke2/vCMULC8bzGFWtad2wH7LJtYInLy/KT1u4MUPyNMQHsI
	mjjiLTPT/efu96Cnp49RKjhO7boptpjfe+1Xdx47YLFL3aobHAMUeTDl8fFlfV/c99jnA1tJskvlY
	6I46IxWq+zfk8266Em9RU1YBnClqdc7+UemHz/uRsBRpS98L8BlOI9DzGQsmSMedhQVK+O6uE9e/d
	brX4fwqPEAfXL27k5Ur3x8NsIhCrrgMhJOhsW4lJ8LzK5Di8Ju0rdhbRCsfDsGodljZMZQMo5MyYG
	Rg8Rg3RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okn6G-007CEM-Ne; Tue, 18 Oct 2022 13:57:44 +0000
Received: from [2001:4bb8:199:ad84:3a05:173d:d0f5:e725] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okn63-007C79-TW; Tue, 18 Oct 2022 13:57:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 2/4] scsi: remove an extra queue reference
Date: Tue, 18 Oct 2022 15:57:18 +0200
Message-Id: <20221018135720.670094-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221018135720.670094-1-hch@lst.de>
References: <20221018135720.670094-1-hch@lst.de>
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

Now that blk_mq_destroy_queue does not release the queue reference, there
is no need for a second queue reference to be held by the scsi_device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsi_scan.c  | 1 -
 drivers/scsi/scsi_sysfs.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 5d27f5196de6f..0a95fa787fdf4 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -344,7 +344,6 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	sdev->request_queue = q;
 	q->queuedata = sdev;
 	__scsi_init_queue(sdev->host, q);
-	WARN_ON_ONCE(!blk_get_queue(q));
 
 	depth = sdev->host->cmd_per_lun ?: 1;
 
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 1214c6f07bc64..c95177ca6ed26 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1478,7 +1478,6 @@ void __scsi_remove_device(struct scsi_device *sdev)
 	mutex_unlock(&sdev->state_mutex);
 
 	blk_mq_destroy_queue(sdev->request_queue);
-	blk_put_queue(sdev->request_queue);
 	kref_put(&sdev->host->tagset_refcnt, scsi_mq_free_tags);
 	cancel_work_sync(&sdev->requeue_work);
 
-- 
2.30.2


