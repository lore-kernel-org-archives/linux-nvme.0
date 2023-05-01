Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F066C7EE25
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 15:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7qO5BfCAOXkvtaOr9B2pnxtHsiNg0vr5ImzNBFOoNvY=; b=FiIdDWOIX5af0748eMpv5jenUm
	37zZwSrUoeGVsXSlmgTU/kRE0HogYnofCdMj9Mb/B52saUzXccGN5P62K0uURXBPqbl5vy5/OHYD/
	3XCL02FV16hWQHaUc5uij+w4cb84RMXOtvh3XWu4z5Tdruj7VCKO03p6mqwUAuKCQUa8lYz3JTvfe
	bPjA945qNi9NAFFrgywd0K41589xtN7D22XTqDden4o1dE5o100hGn9u2dtGaVLHfLgUnZo4kArvc
	ywAM1VsoaQbhZ1XV9IFOl6XfDtozyCteGealpsIMO4t6vC2Jqohj3BNeavLZPBIWUW10ia6aTKmwf
	TSWQ3otg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptVWr-00GEVG-0g;
	Mon, 01 May 2023 15:33:29 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptVWm-00GETG-2i
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 15:33:27 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34144tjH022044
	for <linux-nvme@lists.infradead.org>; Mon, 1 May 2023 08:33:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=7qO5BfCAOXkvtaOr9B2pnxtHsiNg0vr5ImzNBFOoNvY=;
 b=AaTHe96nOeCMYhWTZJgeyADL4mIs6KacrhuFS08mlZFA2d2v7p+caU0BxX05kWWXdJfG
 YlWWzepw8tsfQY5+773a3bwkoUgu/Hmk6B0714Yhz3oNsvGjw1g21aCm/ciMD8qv+MOy
 Q7X/LyqYP3X1OAkJGro2b7ozHFzSWqun9F+0H8OX/7WhiPVNQWVEPsNmsu2YgUjYW/vD
 F542aQDLVFaU6oJX5/oA0mr7bVgoKzVb8z5hQwyZU1pQRcBQQPCchDOZTQC+Iw7ok5wk
 QA+Tz3s1AY9/d6qn4f0eyjmLrgrdsPP8S2ipTbL9y2ZEYRS2Ns+sPPGBhiRjy1UUKZ8g tQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3q8xx24h5x-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 01 May 2023 08:33:23 -0700
Received: from twshared4006.05.ash7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 08:33:20 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id CD27D1777ADC2; Mon,  1 May 2023 08:33:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <joshi.k@samsung.com>, <axboe@kernel.dk>, <hch@lst.de>,
        <xiaoguang.wang@linux.alibaba.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [RFC 3/3] nvme: create special request queue for cdev
Date: Mon, 1 May 2023 08:33:06 -0700
Message-ID: <20230501153306.537124-4-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230501153306.537124-1-kbusch@meta.com>
References: <20230501153306.537124-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: suaJujgeNjbefjyo_t8z4fWBLxeyO-ii
X-Proofpoint-GUID: suaJujgeNjbefjyo_t8z4fWBLxeyO-ii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_08,2023-04-27_01,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_083325_016414_BD29C3A7 
X-CRM114-Status: GOOD (  21.48  )
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

The cdev only services passthrough commands which don't merge, track
stats, or need accounting. Give it a special request queue with all
these options cleared so that we're not adding overhead for it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c  | 29 +++++++++++++++++++++++++----
 drivers/nvme/host/ioctl.c |  4 ++--
 drivers/nvme/host/nvme.h  |  1 +
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0f1cb6f418182..5bb05c91d866d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4071,21 +4071,39 @@ static const struct file_operations nvme_ns_chr_f=
ops =3D {
=20
 static int nvme_add_ns_cdev(struct nvme_ns *ns)
 {
+	struct nvme_ctrl *ctrl =3D ns->ctrl;
+	struct request_queue *q;
 	int ret;
=20
-	ns->cdev_device.parent =3D ns->ctrl->device;
+	ns->cdev_device.parent =3D ctrl->device;
 	ret =3D dev_set_name(&ns->cdev_device, "ng%dn%d",
-			   ns->ctrl->instance, ns->head->instance);
+			   ctrl->instance, ns->head->instance);
 	if (ret)
 		return ret;
=20
 	ret =3D nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
-			     ns->ctrl->ops->module);
+			     ctrl->ops->module);
 	if (ret)
 		goto out_free_name;
=20
+	q =3D blk_mq_init_queue(ctrl->tagset);
+	if (IS_ERR(q)) {
+		ret =3D PTR_ERR(q);
+		goto out_free_cdev;
+	}
+
+	blk_queue_flag_clear(QUEUE_FLAG_IO_STAT, q);
+	blk_queue_flag_clear(QUEUE_FLAG_STATS, q);
+	blk_queue_flag_clear(QUEUE_FLAG_NOMERGES, q);
+	q->queuedata =3D ns;
+	ns->cdev_queue =3D q;
+
 	return 0;
=20
+out_free_cdev:
+	cdev_device_del(&ns->cdev, &ns->cdev_device);
+	return ret;
+
 out_free_name:
 	kfree_const(ns->cdev_device.kobj.name);
 	return ret;
@@ -4399,8 +4417,11 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	/* guarantee not available in head->list */
 	synchronize_srcu(&ns->head->srcu);
=20
-	if (!nvme_ns_head_multipath(ns->head))
+	if (!nvme_ns_head_multipath(ns->head)) {
+		blk_mq_destroy_queue(ns->cdev_queue);
+		blk_put_queue(ns->cdev_queue);
 		nvme_cdev_del(&ns->cdev, &ns->cdev_device);
+	}
 	del_gendisk(ns->disk);
=20
 	down_write(&ns->ctrl->namespaces_rwsem);
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 3804e5205b42b..bf4fcb5d270e9 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -553,7 +553,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
 {
 	struct nvme_uring_cmd_pdu *pdu =3D nvme_uring_cmd_pdu(ioucmd);
 	const struct nvme_uring_cmd *cmd =3D ioucmd->cmd;
-	struct request_queue *q =3D ns ? ns->queue : ctrl->admin_q;
+	struct request_queue *q =3D ns ? ns->cdev_queue : ctrl->admin_q;
 	struct nvme_uring_data d;
 	struct nvme_command c;
 	struct request *req;
@@ -791,7 +791,7 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd =
*ioucmd,
 	bio =3D READ_ONCE(ioucmd->cookie);
 	ns =3D container_of(file_inode(ioucmd->file)->i_cdev,
 			struct nvme_ns, cdev);
-	q =3D ns->queue;
+	q =3D ns->cdev_queue;
 	if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
 		ret =3D bio_poll(bio, iob, poll_flags);
 	rcu_read_unlock();
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1e..d837c118f4f18 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -495,6 +495,7 @@ struct nvme_ns {
=20
 	struct cdev		cdev;
 	struct device		cdev_device;
+	struct request_queue	*cdev_queue;
=20
 	struct nvme_fault_inject fault_inject;
=20
--=20
2.34.1


