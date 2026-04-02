Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEA4D3942D
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2026 14:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WXQBh+3u+MJvhba/wycvWbO/cH1qS5tV/vhN0sfRQX4=; b=VBoMzxqdjAtf5irIzQzbt2fPVu
	VVNKfsbGAzguvgDRp4pS84CYIOe996uT+KRPnIaJBRQUAcPEECHoCGmETX72Bl4cS6xAVTtrYns7I
	IX+MmemQPm3t+bIaXwa8AMm6FiSaSdrEVlEYbXPG4LPPt6Q8wTqgeBn7jwvi8dtglUpAIcnn0H8yJ
	XrUz+V/PQiuNSm3X3wYOwbX6CRP5tzKl+smvXcWVt+oJ41R0txkCaB+Ymg88gleRbwpbVVeFnBhYG
	ZCP4/oVP7DrCoSJBw7Sfyh38WfqSDjw1b3RyAJ/9AsolelMawXt3JJ59H4MkKjhCV/DXebMTtH653
	V/kHWJHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8Iov-00000000GZs-24NP;
	Thu, 02 Apr 2026 14:14:53 +0000
Received: from iad-out-014.esa.us-east-1.outbound.mail-perimeter.amazon.com ([50.16.246.183])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8IXy-00000000DrG-36vI;
	Thu, 02 Apr 2026 13:57:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1775138242; x=1806674242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=WXQBh+3u+MJvhba/wycvWbO/cH1qS5tV/vhN0sfRQX4=;
  b=nYGqoCQy5XFzcPdHMYAB8WDlM6CFtVpjVzZa3NMcj5iellTH1rrZLc/e
   JAz5K4ANwXA5BtzNu/cwepdzklb08TN/m7uJne45Z5oZqIhMAwEIM2WP+
   DMr5O3Cxpi4o2PpdNcnU8JlwlZE6mFHmlBxewadYgjdYMeBAWtF9a3WLf
   DtzZIY48b758OOlWtz8MIWruu7VoKyy09wwrmMkZEjSeRX/JGw7oCiXOH
   30hOjS1iDxmwrRjSQl5Jqr4+epCbw2ebVxBmX3+p+euBdrG9aBeQkQZS2
   UGmuPzxcOKzyczQZRURMrED1Lbz1JB2vfOL6qGpI8lOo8rI0knZvY3Hch
   Q==;
X-CSE-ConnectionGUID: 6EE9QzjYSfSvXrwAMhe2Vw==
X-CSE-MsgGUID: Dc/I/MAIT/OUT1pEzlTaXg==
X-IronPort-AV: E=Sophos;i="6.23,155,1770595200"; 
   d="scan'208";a="14829491"
Received: from ip-10-4-3-150.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.3.150])
  by internal-iad-out-014.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 13:57:16 +0000
Received: from EX19MTAUEC001.ant.amazon.com [52.94.133.134:3493]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.12.35:2525] with esmtp (Farcaster)
 id 1f5fa28a-0598-48c2-a506-36b920804b66; Thu, 2 Apr 2026 13:57:16 +0000 (UTC)
X-Farcaster-Flow-ID: 1f5fa28a-0598-48c2-a506-36b920804b66
Received: from EX19D012UEC004.ant.amazon.com (10.252.135.219) by
 EX19MTAUEC001.ant.amazon.com (10.252.135.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 2 Apr 2026 13:57:15 +0000
Received: from EX19D012UEC003.ant.amazon.com (10.252.135.160) by
 EX19D012UEC004.ant.amazon.com (10.252.135.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 2 Apr 2026 13:57:15 +0000
Received: from EX19D012UEC003.ant.amazon.com ([fe80::67ea:859:1e17:25a9]) by
 EX19D012UEC003.ant.amazon.com ([fe80::67ea:859:1e17:25a9%3]) with mapi id
 15.02.2562.037; Thu, 2 Apr 2026 13:57:15 +0000
From: "Heyne, Maximilian" <mheyne@amazon.de>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Heyne, Maximilian" <mheyne@amazon.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, "Keith
 Busch" <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Hector Martin
	<marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig
	<alyssa@rosenzweig.io>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin
 K. Petersen" <martin.petersen@oracle.com>, Alim Akhtar
	<alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, Bart Van Assche
	<bvanassche@acm.org>, Sasha Levin <sashal@kernel.org>, Peter Wang
	<peter.wang@mediatek.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adrian Hunter <adrian.hunter@intel.com>, Thomas Yen <thomasyen@google.com>,
	Brian Kao <powenkao@google.com>, Seunghui Lee <sh043.lee@samsung.com>,
	Sanjeev Yadav <sanjeev.y@mediatek.com>, Wonkon Kim <wkon.kim@samsung.com>,
	Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
Subject: [PATCH 6.1.y v2 2/6] blk-mq: move the call to blk_put_queue out of
 blk_mq_destroy_queue
Thread-Topic: [PATCH 6.1.y v2 2/6] blk-mq: move the call to blk_put_queue out
 of blk_mq_destroy_queue
Thread-Index: AQHcwqich41sprKN6EWvyx0ADvz7kg==
Date: Thu, 2 Apr 2026 13:57:15 +0000
Message-ID: <20260402-model-paradox-ae8cef60@mheyne-amazon>
References: <20260402-moral-jockey-f072379b@mheyne-amazon>
In-Reply-To: <20260402-moral-jockey-f072379b@mheyne-amazon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.235.223]
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_065722_922477_49D5AD4F 
X-CRM114-Status: GOOD (  16.36  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 07:14:40 -0700
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 2b3f056f72e56fa07df69b4705e0b46a6c08e77c ]

The fact that blk_mq_destroy_queue also drops a queue reference leads
to various places having to grab an extra reference.  Move the call to
blk_put_queue into the callers to allow removing the extra references.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Link: https://lore.kernel.org/r/20221018135720.670094-2-hch@lst.de
[axboe: fix fabrics_q vs admin_q conflict in nvme core.c]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 03b3bcd319b3 ("nvme: fix admin request_queue lifetime")
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 block/blk-mq.c            |  4 +---
 block/bsg-lib.c           |  2 ++
 drivers/nvme/host/apple.c |  1 +
 drivers/nvme/host/core.c  | 10 ++++++++--
 drivers/nvme/host/pci.c   |  1 +
 drivers/scsi/scsi_sysfs.c |  1 +
 drivers/ufs/core/ufshcd.c |  2 ++
 7 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a9697541d67f9..8b9e5ca398242 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4194,9 +4194,6 @@ void blk_mq_destroy_queue(struct request_queue *q)
 	blk_sync_queue(q);
 	blk_mq_cancel_work_sync(q);
 	blk_mq_exit_queue(q);
-
-	/* @q is and will stay empty, shutdown and put */
-	blk_put_queue(q);
 }
 EXPORT_SYMBOL(blk_mq_destroy_queue);
 =

@@ -4213,6 +4210,7 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag=
_set *set, void *queuedata,
 	disk =3D __alloc_disk_node(q, set->numa_node, lkclass);
 	if (!disk) {
 		blk_mq_destroy_queue(q);
+		blk_put_queue(q);
 		return ERR_PTR(-ENOMEM);
 	}
 	set_bit(GD_OWNS_QUEUE, &disk->state);
diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index d6f5dcdce748c..435c32373cd68 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -325,6 +325,7 @@ void bsg_remove_queue(struct request_queue *q)
 =

 		bsg_unregister_queue(bset->bd);
 		blk_mq_destroy_queue(q);
+		blk_put_queue(q);
 		blk_mq_free_tag_set(&bset->tag_set);
 		kfree(bset);
 	}
@@ -400,6 +401,7 @@ struct request_queue *bsg_setup_queue(struct device *de=
v, const char *name,
 	return q;
 out_cleanup_queue:
 	blk_mq_destroy_queue(q);
+	blk_put_queue(q);
 out_queue:
 	blk_mq_free_tag_set(set);
 out_tag_set:
diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 262d2b60ac6dd..c5fc293c22123 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1510,6 +1510,7 @@ static int apple_nvme_probe(struct platform_device *p=
dev)
 	if (!blk_get_queue(anv->ctrl.admin_q)) {
 		nvme_start_admin_queue(&anv->ctrl);
 		blk_mq_destroy_queue(anv->ctrl.admin_q);
+		blk_put_queue(anv->ctrl.admin_q);
 		anv->ctrl.admin_q =3D NULL;
 		ret =3D -ENODEV;
 		goto put_dev;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 938af571dc13e..044e1a9c099b3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5031,6 +5031,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, =
struct blk_mq_tag_set *set,
 =

 out_cleanup_admin_q:
 	blk_mq_destroy_queue(ctrl->admin_q);
+	blk_put_queue(ctrl->admin_q);
 out_free_tagset:
 	blk_mq_free_tag_set(set);
 	ctrl->admin_q =3D NULL;
@@ -5042,8 +5043,11 @@ EXPORT_SYMBOL_GPL(nvme_alloc_admin_tag_set);
 void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl)
 {
 	blk_mq_destroy_queue(ctrl->admin_q);
-	if (ctrl->ops->flags & NVME_F_FABRICS)
+	blk_put_queue(ctrl->admin_q);
+	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		blk_mq_destroy_queue(ctrl->fabrics_q);
+		blk_put_queue(ctrl->fabrics_q);
+	}
 	blk_mq_free_tag_set(ctrl->admin_tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_remove_admin_tag_set);
@@ -5099,8 +5103,10 @@ EXPORT_SYMBOL_GPL(nvme_alloc_io_tag_set);
 =

 void nvme_remove_io_tag_set(struct nvme_ctrl *ctrl)
 {
-	if (ctrl->ops->flags & NVME_F_FABRICS)
+	if (ctrl->ops->flags & NVME_F_FABRICS) {
 		blk_mq_destroy_queue(ctrl->connect_q);
+		blk_put_queue(ctrl->connect_q);
+	}
 	blk_mq_free_tag_set(ctrl->tagset);
 }
 EXPORT_SYMBOL_GPL(nvme_remove_io_tag_set);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 518f8c5012bdf..727585f580362 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1782,6 +1782,7 @@ static void nvme_dev_remove_admin(struct nvme_dev *de=
v)
 		 */
 		nvme_start_admin_queue(&dev->ctrl);
 		blk_mq_destroy_queue(dev->ctrl.admin_q);
+		blk_put_queue(dev->ctrl.admin_q);
 		blk_mq_free_tag_set(&dev->admin_tagset);
 	}
 }
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 456b92c3a7811..af81b2ba0c9b3 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1486,6 +1486,7 @@ void __scsi_remove_device(struct scsi_device *sdev)
 	mutex_unlock(&sdev->state_mutex);
 =

 	blk_mq_destroy_queue(sdev->request_queue);
+	blk_put_queue(sdev->request_queue);
 	kref_put(&sdev->host->tagset_refcnt, scsi_mq_free_tags);
 	cancel_work_sync(&sdev->requeue_work);
 =

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f72ba0b206437..a39ffc62d88a1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -9651,6 +9651,7 @@ void ufshcd_remove(struct ufs_hba *hba)
 	ufshpb_remove(hba);
 	ufs_sysfs_remove_nodes(hba->dev);
 	blk_mq_destroy_queue(hba->tmf_queue);
+	blk_put_queue(hba->tmf_queue);
 	blk_mq_free_tag_set(&hba->tmf_tag_set);
 	scsi_remove_host(hba->host);
 	/* disable interrupts */
@@ -9953,6 +9954,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mm=
io_base, unsigned int irq)
 =

 free_tmf_queue:
 	blk_mq_destroy_queue(hba->tmf_queue);
+	blk_put_queue(hba->tmf_queue);
 free_tmf_tag_set:
 	blk_mq_free_tag_set(&hba->tmf_tag_set);
 out_remove_scsi_host:
-- =

2.50.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


