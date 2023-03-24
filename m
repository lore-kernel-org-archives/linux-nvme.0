Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3F3C76195
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Mar 2023 21:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ew2/7YOABj/xxRnE82Pgnxl3dvtRKrOlEQpS4eeLiwo=; b=wYPHF8lsiiaMnFxJJnImIldCv7
	uLXtz2QWZGr4ivn0wpdJ3p45eGt6qpMf828zGYvHtx2eMcZ99riYpGgJsGkG8DojZwstesyhBsLbf
	el4uLVZYnyFh9bT9ngZpRt+y7RSdo4kAIhCPF+6vabKq3DIbefkMjoPzWGdgTidP3c8kKrtkWsioe
	Z4tJ12QoOCI4mXSBS5B8FHwPNejCBlL8VNovWClzfdItp405nRLVbfsiQgrYta1/KRFQArwp1iQsb
	/YPQONnkph0Gul3KWcIMQh3aX7wBDImiEM+hFWOpNjjp+GunV1iPnAzJlM/rUyyAImGahQurcON9y
	Iqov7PfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfoxO-005eBf-1m;
	Fri, 24 Mar 2023 21:28:18 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfoxL-005eAv-0H
	for linux-nvme@lists.infradead.org;
	Fri, 24 Mar 2023 21:28:16 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OJeV21015470
	for <linux-nvme@lists.infradead.org>; Fri, 24 Mar 2023 14:28:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=ew2/7YOABj/xxRnE82Pgnxl3dvtRKrOlEQpS4eeLiwo=;
 b=GFR19Ig6D/XBTX3XdOkWWAjJRbEkoy4zbYByMV4ijkEGCdjjvX26yKHtQHuvevk+lFrr
 MK2yU7OS+q2fOL9KxIoYusTkMd8Y2iUI+zPIBdT/WgCSNUgsseu/r+14fzTwHzr3ENI0
 HWbL3n1Vs+vC9OnoU/VrEM762C/z/Ho+ecfKTVd/eTvvDMjnVQxGfIQ1bWxkJXZj9RpN
 pbMAIS/mcvTIo8znOIPWVthn9WzMazb56CNY81PizFPMhwz5MIz2RPAliuRqVdzbcAAx
 676j5FzIyjQknDqPLQ/W8vFGah7L3oMQJZ8boGX8zl3lly2rE3QueBz8qbXnHu6fLhSD Yw== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3phj7drhwy-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 24 Mar 2023 14:28:12 -0700
Received: from twshared1938.08.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Mar 2023 14:28:10 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id CC59414564771; Fri, 24 Mar 2023 14:28:04 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <axboe@kernel.dk>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme: use blk-mq polling for uring commands
Date: Fri, 24 Mar 2023 14:28:03 -0700
Message-ID: <20230324212803.1837554-2-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324212803.1837554-1-kbusch@meta.com>
References: <20230324212803.1837554-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: RGicReEYE-Xfob6ejU7fjNjtPuoP65_N
X-Proofpoint-ORIG-GUID: RGicReEYE-Xfob6ejU7fjNjtPuoP65_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_142815_384580_384C73BB 
X-CRM114-Status: GOOD (  25.03  )
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

The first advantage is that unshared and multipath namespaces can use
the same polling callback.

The other advantage is that we don't need a bio payload in order to
poll, allowing commands like 'flush' and 'write zeroes' to be submitted
on the same high priority queue as read and write commands.

This can also allow for a future optimization for the driver since we no
longer need to create special hidden block devices to back nvme-generic
char dev's with unsupported command sets.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c     | 79 ++++++++++++-----------------------
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      |  2 -
 3 files changed, 28 insertions(+), 55 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 723e7d5b778f2..369e8519b87a2 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -503,7 +503,6 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struc=
t request *req,
 {
 	struct io_uring_cmd *ioucmd =3D req->end_io_data;
 	struct nvme_uring_cmd_pdu *pdu =3D nvme_uring_cmd_pdu(ioucmd);
-	void *cookie =3D READ_ONCE(ioucmd->cookie);
=20
 	req->bio =3D pdu->bio;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
@@ -516,9 +515,10 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(stru=
ct request *req,
 	 * For iopoll, complete it directly.
 	 * Otherwise, move the completion to task work.
 	 */
-	if (cookie !=3D NULL && blk_rq_is_poll(req))
+	if (blk_rq_is_poll(req)) {
+		WRITE_ONCE(ioucmd->cookie, NULL);
 		nvme_uring_task_cb(ioucmd);
-	else
+	} else
 		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_cb);
=20
 	return RQ_END_IO_FREE;
@@ -529,7 +529,6 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io_meta(=
struct request *req,
 {
 	struct io_uring_cmd *ioucmd =3D req->end_io_data;
 	struct nvme_uring_cmd_pdu *pdu =3D nvme_uring_cmd_pdu(ioucmd);
-	void *cookie =3D READ_ONCE(ioucmd->cookie);
=20
 	req->bio =3D pdu->bio;
 	pdu->req =3D req;
@@ -538,9 +537,10 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io_meta=
(struct request *req,
 	 * For iopoll, complete it directly.
 	 * Otherwise, move the completion to task work.
 	 */
-	if (cookie !=3D NULL && blk_rq_is_poll(req))
+	if (blk_rq_is_poll(req)) {
+		WRITE_ONCE(ioucmd->cookie, NULL);
 		nvme_uring_task_meta_cb(ioucmd);
-	else
+	} else
 		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_meta_cb);
=20
 	return RQ_END_IO_NONE;
@@ -597,7 +597,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
 	if (issue_flags & IO_URING_F_IOPOLL)
 		rq_flags |=3D REQ_POLLED;
=20
-retry:
 	req =3D nvme_alloc_user_request(q, &c, rq_flags, blk_flags);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
@@ -611,17 +610,9 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl,=
 struct nvme_ns *ns,
 			return ret;
 	}
=20
-	if (issue_flags & IO_URING_F_IOPOLL && rq_flags & REQ_POLLED) {
-		if (unlikely(!req->bio)) {
-			/* we can't poll this, so alloc regular req instead */
-			blk_mq_free_request(req);
-			rq_flags &=3D ~REQ_POLLED;
-			goto retry;
-		} else {
-			WRITE_ONCE(ioucmd->cookie, req->bio);
-			req->bio->bi_opf |=3D REQ_POLLED;
-		}
-	}
+	if (blk_rq_is_poll(req))
+		WRITE_ONCE(ioucmd->cookie, req);
+
 	/* to free bio on completion, as req->bio will be null at that time */
 	pdu->bio =3D req->bio;
 	pdu->meta_len =3D d.metadata_len;
@@ -780,18 +771,27 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cm=
d *ioucmd,
 				 struct io_comp_batch *iob,
 				 unsigned int poll_flags)
 {
-	struct bio *bio;
+	struct request *req;
 	int ret =3D 0;
-	struct nvme_ns *ns;
-	struct request_queue *q;
=20
+	/*
+	 * The rcu lock ensures the 'req' in the command cookie will not be
+	 * freed until after the unlock. The queue must be frozen to free the
+	 * request, and the freeze requires an rcu grace period. The cookie is
+	 * cleared before the request is completed, so we're fine even if a
+	 * competing polling thread completes this thread's request.
+	 */
 	rcu_read_lock();
-	bio =3D READ_ONCE(ioucmd->cookie);
-	ns =3D container_of(file_inode(ioucmd->file)->i_cdev,
-			struct nvme_ns, cdev);
-	q =3D ns->queue;
-	if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
-		ret =3D bio_poll(bio, iob, poll_flags);
+	req =3D READ_ONCE(ioucmd->cookie);
+	if (req) {
+		struct request_queue *q =3D req->q;
+
+		if (percpu_ref_tryget(&q->q_usage_counter)) {
+			ret =3D blk_mq_poll(q, blk_rq_to_qc(req), iob,
+					  poll_flags);
+			blk_queue_exit(q);
+		}
+	}
 	rcu_read_unlock();
 	return ret;
 }
@@ -883,31 +883,6 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *=
ioucmd,
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
 }
-
-int nvme_ns_head_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
-				      struct io_comp_batch *iob,
-				      unsigned int poll_flags)
-{
-	struct cdev *cdev =3D file_inode(ioucmd->file)->i_cdev;
-	struct nvme_ns_head *head =3D container_of(cdev, struct nvme_ns_head, c=
dev);
-	int srcu_idx =3D srcu_read_lock(&head->srcu);
-	struct nvme_ns *ns =3D nvme_find_path(head);
-	struct bio *bio;
-	int ret =3D 0;
-	struct request_queue *q;
-
-	if (ns) {
-		rcu_read_lock();
-		bio =3D READ_ONCE(ioucmd->cookie);
-		q =3D ns->queue;
-		if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio
-				&& bio->bi_bdev)
-			ret =3D bio_poll(bio, iob, poll_flags);
-		rcu_read_unlock();
-	}
-	srcu_read_unlock(&head->srcu, srcu_idx);
-	return ret;
-}
 #endif /* CONFIG_NVME_MULTIPATH */
=20
 int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_f=
lags)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index fc39d01e7b63b..fcecb731c8bd9 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -470,7 +470,7 @@ static const struct file_operations nvme_ns_head_chr_=
fops =3D {
 	.unlocked_ioctl	=3D nvme_ns_head_chr_ioctl,
 	.compat_ioctl	=3D compat_ptr_ioctl,
 	.uring_cmd	=3D nvme_ns_head_chr_uring_cmd,
-	.uring_cmd_iopoll =3D nvme_ns_head_chr_uring_cmd_iopoll,
+	.uring_cmd_iopoll =3D nvme_ns_chr_uring_cmd_iopoll,
 };
=20
 static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1e..ca4ea89333660 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -847,8 +847,6 @@ long nvme_dev_ioctl(struct file *file, unsigned int c=
md,
 		unsigned long arg);
 int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 		struct io_comp_batch *iob, unsigned int poll_flags);
-int nvme_ns_head_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
-		struct io_comp_batch *iob, unsigned int poll_flags);
 int nvme_ns_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 		unsigned int issue_flags);
 int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
--=20
2.34.1


