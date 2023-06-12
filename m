Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7420C7EE2F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 19:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yk/4kOW+1au1JCuvMoFmqdxb/rxmmIIdIi1gshRX62w=; b=XFTfrldFFzTaG97spFomT86Xib
	/2xSeadb9E1Yx3DQ70iHNLPu/plEdI9CHhO5Lpng0PXC/HErv5gRiXodhxTdVziVayOTFScK4eObA
	Z6iDsS/z5WPZR6xIGEJ+7v4O8JnUFlew0KrCreqS20BH1T11xvzUyQU0OsnpsNwpwFR7YUfr4FQjT
	Q3+kpX4bgb5M6TJ0ZsDx3W8ScLMiwTncb+qqn1fWs1hIvfuE+k/qf3FdpxPK+Z3ZmSKIHYgQhZewz
	vzJVsm4z9qU5ZN6m0zuZvW9YsrDcFSfw+Ab63e0Z+8WqEs5o/KwgOfbWuKrbMh+uNdKYSJE+xRnUC
	itQsKU5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8mpr-0052hI-1Q;
	Mon, 12 Jun 2023 19:04:15 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8mpn-0052fk-2E
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 19:04:13 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CHKcJs004290
	for <linux-nvme@lists.infradead.org>; Mon, 12 Jun 2023 12:04:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=yk/4kOW+1au1JCuvMoFmqdxb/rxmmIIdIi1gshRX62w=;
 b=Zv6I49YLTpF8cEnz48V8YybvoJaJMuKI0Pb0QIZjBfoq+CkqlKOXTg4kgxsC5QpjY0QI
 HGyvXid2A2bAemFuInikX3y7YHBv4rWfdQLHe5d/XsD3z68r1LyTL3qPFj2KRt9zo5+O
 qATSimYScCJgXrxRa4vjfFmzxkObGLm26i8IEl0x4VJAOV/nRRqAvGCpGCDMPKJcgcPM
 k8CzEqWAWKIWZ5xKQV0u0qkw3wAe5S0f9FV2HRhrbR9VXVkKMTY0a3CIKyEBnyLhPEpT
 QH6EGEPtRT0EE6TrHYVjtMK52Zk8fh97ESW3y4UeX9uXG1hH4hzJGLkt+Uk2nQGbttij 6Q== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r5xdtvdkw-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 12 Jun 2023 12:04:10 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 12:03:56 -0700
Received: from twshared6352.02.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 12:03:56 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id B236119FA77A7; Mon, 12 Jun 2023 12:03:46 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <hch@lst.de>, <axboe@kernel.dk>
CC: <sagi@grimberg.me>, <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 2/2] nvme: improved uring polling
Date: Mon, 12 Jun 2023 12:03:43 -0700
Message-ID: <20230612190343.2087040-3-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230612190343.2087040-1-kbusch@meta.com>
References: <20230612190343.2087040-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -iwj2dlxaYwH4qG54RM9NTZDmMuuqjja
X-Proofpoint-ORIG-GUID: -iwj2dlxaYwH4qG54RM9NTZDmMuuqjja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_14,2023-06-12_02,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_120411_846506_B323BF1C 
X-CRM114-Status: GOOD (  24.46  )
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

The allows unshared and multipath namespaces to use the same polling
callback, and multipath is guaranteed to get the same queue as the
command was submitted on. Previously multipath polling might check a
different path and poll the wrong info.

The other bonus is we don't need a bio payload in order to poll,
allowing commands like 'flush' and 'write zeroes' to be submitted on the
same high priority queue as read and write commands.

Finally, using the request based polling skips the unnecessary bio
overhead.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c     | 70 ++++++++++-------------------------
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      |  2 -
 include/uapi/linux/io_uring.h |  2 +
 4 files changed, 22 insertions(+), 54 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 52ed1094ccbb2..dd7603efed799 100644
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
@@ -518,10 +517,12 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(str=
uct request *req,
 	 * For iopoll, complete it directly.
 	 * Otherwise, move the completion to task work.
 	 */
-	if (cookie !=3D NULL && blk_rq_is_poll(req))
+	if (blk_rq_is_poll(req)) {
+		WRITE_ONCE(ioucmd->cookie, NULL);
 		nvme_uring_task_cb(ioucmd, IO_URING_F_UNLOCKED);
-	else
+	} else {
 		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
+	}
=20
 	return RQ_END_IO_FREE;
 }
@@ -531,7 +532,6 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io_meta(=
struct request *req,
 {
 	struct io_uring_cmd *ioucmd =3D req->end_io_data;
 	struct nvme_uring_cmd_pdu *pdu =3D nvme_uring_cmd_pdu(ioucmd);
-	void *cookie =3D READ_ONCE(ioucmd->cookie);
=20
 	req->bio =3D pdu->bio;
 	pdu->req =3D req;
@@ -540,10 +540,12 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io_met=
a(struct request *req,
 	 * For iopoll, complete it directly.
 	 * Otherwise, move the completion to task work.
 	 */
-	if (cookie !=3D NULL && blk_rq_is_poll(req))
+	if (blk_rq_is_poll(req)) {
+		WRITE_ONCE(ioucmd->cookie, NULL);
 		nvme_uring_task_meta_cb(ioucmd, IO_URING_F_UNLOCKED);
-	else
+	} else {
 		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_meta_cb);
+	}
=20
 	return RQ_END_IO_NONE;
 }
@@ -599,7 +601,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
 	if (issue_flags & IO_URING_F_IOPOLL)
 		rq_flags |=3D REQ_POLLED;
=20
-retry:
 	req =3D nvme_alloc_user_request(q, &c, rq_flags, blk_flags);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
@@ -613,17 +614,11 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl=
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
@@ -782,18 +777,16 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cm=
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
@@ -885,31 +878,6 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *=
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
index 2bc159a318ff0..61130b4976b04 100644
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
index a2d4f59e0535a..84aecf53870ae 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -852,8 +852,6 @@ long nvme_dev_ioctl(struct file *file, unsigned int c=
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
index f222d263bc555..08720c7bd92f8 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -244,8 +244,10 @@ enum io_uring_op {
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


