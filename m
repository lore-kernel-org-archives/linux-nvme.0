Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA95D216B7
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 14:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kGvO1Kawr3MTYf6nAwN4jW34SokY4Uzp4aiZ/Do55t0=; b=kB9cYRsfUBiSyYUHagLXDGIZpe
	9oNNosJn0Ca93CMIxSwuSTP/XiffWziIPmiCP9gpJP9pC8Owe3DPfQmplneBG0Ow5n1tu440yO8NB
	A5vKQKtA2gbNHDoO3Gw0g2a1p8NzTgxhEnPSTqrVYOh9rgIL2m53pK3Mu9HsJUTd06BSkpza8/maP
	mR7an/2/b3NGDRg2W+t8Sw5kxe0dt0RRsiYsbeJtaN2hcIayUxcyBxFk14DeJoItEDdH9kETqosip
	psNTTfCN4EwdUkzFqLfhqrGvHX1Uc0ENO15yfB5jPAtLJDJMda9+SXW4RuTyKesdue/4dxjRISqtO
	u7jTTGZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0iaU-00000008WW3-1I1y;
	Tue, 15 Oct 2024 14:31:50 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0iaR-00000008WVX-1tNZ
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 14:31:48 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F6Q9SB007980
	for <linux-nvme@lists.infradead.org>; Tue, 15 Oct 2024 07:31:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=kGvO1Kawr3MTYf6nAw
	N4jW34SokY4Uzp4aiZ/Do55t0=; b=UoNTZv1wSterSvRzUJPv3xPha7ABuqT4jf
	jdRx/5vji/tPSL23l/2b0m0tiOQgtHgwy4Dy1uYXR5btD688LKU+sw5aiqT1eP86
	38lPrDLLNrVQ/fFIrrJmpkh5YMxQ7n9j1cPrQGx2K5cPDoqKdOSANsdAfAnOV23W
	dHFfu651AsHJOxRseswwQtJZWLP6qhfFj50loPwI1jN5wmG0vusGWvj+Qn1jufXp
	oNgamGire9XZs0LybEp5ks8Y8kVRlFvZW5zRck/iY3+fzH/vQPGrvv4Ow+rq9i6T
	ecbpCjTcX58vEO9bMGmzLWGt7HpWyJEdeQ8QEOPgDoU4vDO6bNrw==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4291rjh75t-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 15 Oct 2024 07:31:45 -0700 (PDT)
Received: from twshared4085.05.ash9.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 15 Oct 2024 14:31:43 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id A1633142A52B2; Tue, 15 Oct 2024 07:31:37 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme-multipath: defer partition scanning
Date: Tue, 15 Oct 2024 07:31:36 -0700
Message-ID: <20241015143136.810779-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 41X_C8jwKR1EuvsUBzOq61sCL_RFjsN9
X-Proofpoint-ORIG-GUID: 41X_C8jwKR1EuvsUBzOq61sCL_RFjsN9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241015_073147_526149_0ACF4C42 
X-CRM114-Status: GOOD (  17.84  )
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

From: Keith Busch <kbusch@kernel.org>

We need to suppress the partition scan from occuring within the controlle=
r's
scan_work context. If a path error occurs here, the submission will wait =
until
a path becomes available or all paths are torn down, but that action also
occurs within scan_work, so it would deadlock. Defer the partion scan a
different one that does not block scan_work.

Reported-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>

will be ignored, and an empty message aborts the commit.
---
 drivers/nvme/host/multipath.c | 39 +++++++++++++++++++++++++++++------
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index bad1620fbbfc1..d371aa03f9851 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -579,6 +579,20 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head=
 *head)
 	return ret;
 }
=20
+static void nvme_partition_scan_work(struct work_struct *work)
+{
+	struct nvme_ns_head *head =3D
+		container_of(work, struct nvme_ns_head, partition_scan_work);
+
+	if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
+					     &head->disk->state)))
+		return;
+
+	mutex_lock(&head->disk->open_mutex);
+	bdev_disk_changed(head->disk, false);
+	mutex_unlock(&head->disk->open_mutex);
+}
+
 static void nvme_requeue_work(struct work_struct *work)
 {
 	struct nvme_ns_head *head =3D
@@ -605,6 +619,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, str=
uct nvme_ns_head *head)
 	bio_list_init(&head->requeue_list);
 	spin_lock_init(&head->requeue_lock);
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
+	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
=20
 	/*
 	 * Add a multipath node if the subsystems supports multiple controllers=
.
@@ -628,6 +643,16 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, st=
ruct nvme_ns_head *head)
 		return PTR_ERR(head->disk);
 	head->disk->fops =3D &nvme_ns_head_ops;
 	head->disk->private_data =3D head;
+
+	/*
+	 * We need to suppress the partition scan from occuring within the
+	 * controller's scan_work context. If a path error occurs here, the
+	 * submission will wait until a path becomes available or all paths are
+	 * torn down, but that action also occurs within scan_work, so it would
+	 * deadlock. Defer the partion scan a different one that does not block
+	 * scan_work.
+	 */
+	set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
 	sprintf(head->disk->disk_name, "nvme%dn%d",
 			ctrl->subsys->instance, head->instance);
 	return 0;
@@ -654,6 +679,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 			return;
 		}
 		nvme_add_ns_head_cdev(head);
+		kblockd_schedule_work(&head->partition_scan_work);
 	}
=20
 	mutex_lock(&head->lock);
@@ -973,14 +999,14 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *=
head)
 		return;
 	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
+		/*
+		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
+		 * to allow multipath to fail all I/O.
+		 */
+		synchronize_srcu(&head->srcu);
+		kblockd_schedule_work(&head->requeue_work);
 		del_gendisk(head->disk);
 	}
-	/*
-	 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
-	 * to allow multipath to fail all I/O.
-	 */
-	synchronize_srcu(&head->srcu);
-	kblockd_schedule_work(&head->requeue_work);
 }
=20
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
@@ -990,6 +1016,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *hea=
d)
 	/* make sure all pending bios are cleaned up */
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
+	flush_work(&head->partition_scan_work);
 	put_disk(head->disk);
 }
=20
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 313a4f978a2cf..093cb423f536b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -494,6 +494,7 @@ struct nvme_ns_head {
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
+	struct work_struct	partition_scan_work;
 	struct mutex		lock;
 	unsigned long		flags;
 #define NVME_NSHEAD_DISK_LIVE	0
--=20
2.43.5


