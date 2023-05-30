Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571A0C77B7A
	for <linux-nvme@archiver.kernel.org>; Tue, 30 May 2023 17:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ApPjhbD0YCmJA9+SszNafaDNZtkZLNh6kXcyxMsgIs=; b=wOuvZvN78RTS+gwjk3FHbJyqxm
	il9eD+0VsieGl4HNKper+cpr4hWi/DJaIo661cg0U+JldvbMsmbpxgjwvFbYQOEs2WSNAPwN12Spt
	CLK8F2+lxpp0+phAQee3oJtFUXKNOlNmv8qxz0yvk0p9EExI2iytx/RKItOd8uZQW6UOjNpuEsgU5
	hS/Cw9cm4oa5UWlC0VG4b8dZ3dPMAEgaUF+FWVcIKeG5RZXedf3hnA6LIWyshytwJ1Z1jDY0DzkdE
	VqKBNhEnq0950rfaqOLqDxZEaNKUq5VTprd0PE63gJNezob4d4GWEOnhd2c5uqzU3/liHpWnxy9QE
	qSwBIvpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q434o-00Eja0-1F;
	Tue, 30 May 2023 17:24:06 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q434l-00EjZ0-0C
	for linux-nvme@lists.infradead.org;
	Tue, 30 May 2023 17:24:04 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UGYQCd012165
	for <linux-nvme@lists.infradead.org>; Tue, 30 May 2023 10:24:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=7ApPjhbD0YCmJA9+SszNafaDNZtkZLNh6kXcyxMsgIs=;
 b=cNJEJ9sESzq+U8rY7Xkot+YAY9g061OqLEzBmI7MsEqRL5fnHWuV2Ns+JzeyRrvuM8Gn
 HEwIsjc0w9HNjs+zo2XLee0Bc2kZPfg7uFLXW08IXvsn6xoFRkQcPfG9mxs1ltDccav/
 t9vhDn+13RBoq9pMWQAIaewwQ6usmdH9brtnggvxaG/5193BaQVr6fFv72OdHYZViLq2
 t6qJDXf7VoZlwcRmJMH9gPcLO9cFPWAGHnOj9F5QQnX7OCLqPAFgeBzbfH0Ps/0Gqz2E
 p8o4sxlIeQXE2zDYw1+NfqCg6uwZc0wTe23tzMUANhNK+F016xY9Wy554beJzvCFkBiA Zw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qwgxdah1h-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 30 May 2023 10:24:01 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 10:24:00 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id B7A40194BF687; Tue, 30 May 2023 10:23:48 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <hch@lst.de>, <axboe@kernel.dk>
CC: <sagi@grimberg.me>, <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme: improved uring polling
Date: Tue, 30 May 2023 10:23:43 -0700
Message-ID: <20230530172343.3250958-2-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530172343.3250958-1-kbusch@meta.com>
References: <20230530172343.3250958-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 57bsc2tI6WeiLwao7XlE0pXrL4MvCVu1
X-Proofpoint-ORIG-GUID: 57bsc2tI6WeiLwao7XlE0pXrL4MvCVu1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_12,2023-05-30_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230530_102403_120279_3F6878CD 
X-CRM114-Status: GOOD (  24.67  )
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

Drivers can poll requests directly, so use that. We just need to ensure
the driver's request was allocated from a polled hctx, so a special
driver flag is added to struct io_uring_cmd.

The first advantage is unshared and multipath namespaces can use the same
polling callback, and multipath is guaranteed to get the same queue as
the command was submitted on. Previously multipath polling might check
a different path and poll the wrong info.

The other advantage is we don't need a bio payload in order to poll,
allowing commands like 'flush' and 'write zeroes' to be submitted on
the same high priority queue as read and write commands. And using the
request based polling skips the unnecessary bio overhead and xarray hctx
lookup when we have a request.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c     | 68 +++++++++--------------------------
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      |  2 --
 include/uapi/linux/io_uring.h |  2 ++
 4 files changed, 20 insertions(+), 54 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d24ea2e051564..3fa9a50433f18 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -505,7 +505,6 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struc=
t request *req,
 {
 	struct io_uring_cmd *ioucmd =3D req->end_io_data;
 	struct nvme_uring_cmd_pdu *pdu =3D nvme_uring_cmd_pdu(ioucmd);
-	void *cookie =3D READ_ONCE(ioucmd->cookie);
=20
 	req->bio =3D pdu->bio;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
@@ -518,9 +517,10 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(stru=
ct request *req,
 	 * For iopoll, complete it directly.
 	 * Otherwise, move the completion to task work.
 	 */
-	if (cookie !=3D NULL && blk_rq_is_poll(req))
+	if (blk_rq_is_poll(req)) {
+		WRITE_ONCE(ioucmd->cookie, NULL);
 		nvme_uring_task_cb(ioucmd, IO_URING_F_UNLOCKED);
-	else
+	} else
 		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_cb);
=20
 	return RQ_END_IO_FREE;
@@ -531,7 +531,6 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io_meta(=
struct request *req,
 {
 	struct io_uring_cmd *ioucmd =3D req->end_io_data;
 	struct nvme_uring_cmd_pdu *pdu =3D nvme_uring_cmd_pdu(ioucmd);
-	void *cookie =3D READ_ONCE(ioucmd->cookie);
=20
 	req->bio =3D pdu->bio;
 	pdu->req =3D req;
@@ -540,9 +539,10 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io_meta=
(struct request *req,
 	 * For iopoll, complete it directly.
 	 * Otherwise, move the completion to task work.
 	 */
-	if (cookie !=3D NULL && blk_rq_is_poll(req))
+	if (blk_rq_is_poll(req)) {
+		WRITE_ONCE(ioucmd->cookie, NULL);
 		nvme_uring_task_meta_cb(ioucmd, IO_URING_F_UNLOCKED);
-	else
+	} else
 		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_meta_cb);
=20
 	return RQ_END_IO_NONE;
@@ -599,7 +599,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
 	if (issue_flags & IO_URING_F_IOPOLL)
 		rq_flags |=3D REQ_POLLED;
=20
-retry:
 	req =3D nvme_alloc_user_request(q, &c, rq_flags, blk_flags);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
@@ -613,17 +612,11 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl=
, struct nvme_ns *ns,
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
+	if (blk_rq_is_poll(req)) {
+		ioucmd->flags |=3D IORING_URING_CMD_POLLED;
+		WRITE_ONCE(ioucmd->cookie, req);
 	}
+
 	/* to free bio on completion, as req->bio will be null at that time */
 	pdu->bio =3D req->bio;
 	pdu->meta_len =3D d.metadata_len;
@@ -782,18 +775,16 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cm=
d *ioucmd,
 				 struct io_comp_batch *iob,
 				 unsigned int poll_flags)
 {
-	struct bio *bio;
+	struct request *req;
 	int ret =3D 0;
-	struct nvme_ns *ns;
-	struct request_queue *q;
+
+	if (!(ioucmd->flags & IORING_URING_CMD_POLLED))
+		return 0;
=20
 	rcu_read_lock();
-	bio =3D READ_ONCE(ioucmd->cookie);
-	ns =3D container_of(file_inode(ioucmd->file)->i_cdev,
-			struct nvme_ns, cdev);
-	q =3D ns->queue;
-	if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
-		ret =3D bio_poll(bio, iob, poll_flags);
+	req =3D READ_ONCE(ioucmd->cookie);
+	if (req && blk_rq_is_poll(req))
+		ret =3D blk_rq_poll(req, iob, poll_flags);
 	rcu_read_unlock();
 	return ret;
 }
@@ -885,31 +876,6 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *=
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
index 9171452e2f6d4..f17be1c72f4de 100644
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
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.=
h
index 0716cb17e4360..f8d6ffe78073e 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -232,8 +232,10 @@ enum io_uring_op {
  * sqe->uring_cmd_flags
  * IORING_URING_CMD_FIXED	use registered buffer; pass this flag
  *				along with setting sqe->buf_index.
+ * IORING_URING_CMD_POLLED	driver use only
  */
 #define IORING_URING_CMD_FIXED	(1U << 0)
+#define IORING_URING_CMD_POLLED	(1U << 31)
=20
=20
 /*
--=20
2.34.1


