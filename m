Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015E7C19776
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 18:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nwmAP8sUV6CYBzcCZL2YWO0LfzfSw2Y16cunh72RRkE=; b=P0fQHjGz0e8lp0z+hE6G2v1yVz
	QaZay/k0og3KGk3vuTTqDOIR4HRkfYdQ+wEE5gaRMcr8zmlPrzcguR964H+61tGbOtzoyhcGpfw3J
	DDMStjohZvETa4XNyZLkXcd9xbGqMgFVhSz87BlftCUkcFLUVW1epJcy2EbDGf2D6h/aYTKwrrvWa
	ZTGRt/hLfyuYCR9mlHYR1mB1VmUEajlgHHooxsTZ9xP1Za0IIiN2bIDKJ7fZ/aeb+fEvq82Zi/igl
	H+p62uX6px/3G2UqrW8DyZUWk1rHEde8eABl5M7QJ62Bgq5qeGUofQr8ZSZ4AOvlzfwXaHaA7P2XV
	S2IUsMag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnLrW-00000004qsQ-10pv;
	Wed, 26 Feb 2025 18:10:26 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnLrT-00000004qo8-1Iul
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 18:10:24 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QBHDHt021853
	for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 10:10:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=nwmAP8sUV6CYBzcCZL2YWO0LfzfSw2Y16cunh72RRkE=; b=fzubWNqH/j45
	tn6PWkXaVTYAzhdt1hpST0yWexLCxC7tAGKnY9xs7LrSRsXGB7VfKGT5wjuT7EoF
	bq4CzrtB+aLt+P7PCZBxtC7SyKPtSi846stkk4ooD1XSddPhkBsY6wFC28VtPvsu
	2sAwxOteNPxhmac90igySbE6oc7fooPaluFzpo/Zb4RRlBdDY88DUNecAl6V+vZh
	SyxIGv3pre6crQUBuo8u3R5kHx56mjcb4TL/NxPio/agHFup/MxsUolw5PDQRntQ
	HJLzZz14RmQ+YItwx/2yZMmJZobE50iZuo1Un4nRPQwaruzciPp6ub67q+AkqEn5
	znENuAX8nA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4521xrjngk-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 10:10:22 -0800 (PST)
Received: from twshared8234.09.ash9.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 26 Feb 2025 18:10:04 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id D9661187C4ADF; Wed, 26 Feb 2025 10:10:06 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <ming.lei@redhat.com>, <asml.silence@gmail.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <bernd@bsbernd.com>, <csander@purestorage.com>,
        <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv6 3/5] ublk: zc register/unregister bvec
Date: Wed, 26 Feb 2025 10:09:57 -0800
Message-ID: <20250226181002.2574148-7-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250226181002.2574148-1-kbusch@meta.com>
References: <20250226181002.2574148-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: d1IRQjQlvRlvt-VeQxGl4NvRSbvzZ6oE
X-Proofpoint-ORIG-GUID: d1IRQjQlvRlvt-VeQxGl4NvRSbvzZ6oE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_101023_350840_87713054 
X-CRM114-Status: GOOD (  19.10  )
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

Provide new operations for the user to request mapping an active request
to an io uring instance's buf_table. The user has to provide the index
it wants to install the buffer.

A reference count is taken on the request to ensure it can't be
completed while it is active in a ring's buf_table.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/block/ublk_drv.c      | 119 +++++++++++++++++++++++-----------
 include/uapi/linux/ublk_cmd.h |   4 ++
 2 files changed, 86 insertions(+), 37 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 529085181f355..dc9ff869aa560 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -51,6 +51,9 @@
 /* private ioctl command mirror */
 #define UBLK_CMD_DEL_DEV_ASYNC	_IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
=20
+#define UBLK_IO_REGISTER_IO_BUF		_IOC_NR(UBLK_U_IO_REGISTER_IO_BUF)
+#define UBLK_IO_UNREGISTER_IO_BUF	_IOC_NR(UBLK_U_IO_UNREGISTER_IO_BUF)
+
 /* All UBLK_F_* have to be included into UBLK_F_ALL */
 #define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY \
 		| UBLK_F_URING_CMD_COMP_IN_TASK \
@@ -201,7 +204,7 @@ static inline struct ublksrv_io_desc *ublk_get_iod(st=
ruct ublk_queue *ubq,
 						   int tag);
 static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
 {
-	return ub->dev_info.flags & UBLK_F_USER_COPY;
+	return ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COP=
Y);
 }
=20
 static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
@@ -581,7 +584,7 @@ static void ublk_apply_params(struct ublk_device *ub)
=20
 static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 {
-	return ubq->flags & UBLK_F_USER_COPY;
+	return ubq->flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY);
 }
=20
 static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
@@ -1747,6 +1750,77 @@ static inline void ublk_prep_cancel(struct io_urin=
g_cmd *cmd,
 	io_uring_cmd_mark_cancelable(cmd, issue_flags);
 }
=20
+static inline struct request *__ublk_check_and_get_req(struct ublk_devic=
e *ub,
+		struct ublk_queue *ubq, int tag, size_t offset)
+{
+	struct request *req;
+
+	if (!ublk_need_req_ref(ubq))
+		return NULL;
+
+	req =3D blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
+	if (!req)
+		return NULL;
+
+	if (!ublk_get_req_ref(ubq, req))
+		return NULL;
+
+	if (unlikely(!blk_mq_request_started(req) || req->tag !=3D tag))
+		goto fail_put;
+
+	if (!ublk_rq_has_data(req))
+		goto fail_put;
+
+	if (offset > blk_rq_bytes(req))
+		goto fail_put;
+
+	return req;
+fail_put:
+	ublk_put_req_ref(ubq, req);
+	return NULL;
+}
+
+static void ublk_io_release(void *priv)
+{
+	struct request *rq =3D priv;
+	struct ublk_queue *ubq =3D rq->mq_hctx->driver_data;
+
+	ublk_put_req_ref(ubq, rq);
+}
+
+static int ublk_register_io_buf(struct io_uring_cmd *cmd,
+				struct ublk_queue *ubq, unsigned int tag,
+				const struct ublksrv_io_cmd *ub_cmd,
+				unsigned int issue_flags)
+{
+	struct ublk_device *ub =3D cmd->file->private_data;
+	int index =3D (int)ub_cmd->addr, ret;
+	struct request *req;
+
+	req =3D __ublk_check_and_get_req(ub, ubq, tag, 0);
+	if (!req)
+		return -EINVAL;
+
+	ret =3D io_buffer_register_bvec(cmd, req, ublk_io_release, index,
+				      issue_flags);
+	if (ret) {
+		ublk_put_req_ref(ubq, req);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
+				  const struct ublksrv_io_cmd *ub_cmd,
+				  unsigned int issue_flags)
+{
+	int index =3D (int)ub_cmd->addr;
+
+	io_buffer_unregister_bvec(cmd, index, issue_flags);
+	return 0;
+}
+
 static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 			       unsigned int issue_flags,
 			       const struct ublksrv_io_cmd *ub_cmd)
@@ -1798,6 +1872,10 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd=
 *cmd,
=20
 	ret =3D -EINVAL;
 	switch (_IOC_NR(cmd_op)) {
+	case UBLK_IO_REGISTER_IO_BUF:
+		return ublk_register_io_buf(cmd, ubq, tag, ub_cmd, issue_flags);
+	case UBLK_IO_UNREGISTER_IO_BUF:
+		return ublk_unregister_io_buf(cmd, ub_cmd, issue_flags);
 	case UBLK_IO_FETCH_REQ:
 		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
 		if (ublk_queue_ready(ubq)) {
@@ -1872,36 +1950,6 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd=
 *cmd,
 	return -EIOCBQUEUED;
 }
=20
-static inline struct request *__ublk_check_and_get_req(struct ublk_devic=
e *ub,
-		struct ublk_queue *ubq, int tag, size_t offset)
-{
-	struct request *req;
-
-	if (!ublk_need_req_ref(ubq))
-		return NULL;
-
-	req =3D blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag);
-	if (!req)
-		return NULL;
-
-	if (!ublk_get_req_ref(ubq, req))
-		return NULL;
-
-	if (unlikely(!blk_mq_request_started(req) || req->tag !=3D tag))
-		goto fail_put;
-
-	if (!ublk_rq_has_data(req))
-		goto fail_put;
-
-	if (offset > blk_rq_bytes(req))
-		goto fail_put;
-
-	return req;
-fail_put:
-	ublk_put_req_ref(ubq, req);
-	return NULL;
-}
-
 static inline int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		unsigned int issue_flags)
 {
@@ -2459,7 +2507,7 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *c=
md)
 		 * buffer by pwrite() to ublk char device, which can't be
 		 * used for unprivileged device
 		 */
-		if (info.flags & UBLK_F_USER_COPY)
+		if (info.flags & UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY)
 			return -EINVAL;
 	}
=20
@@ -2527,9 +2575,6 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *c=
md)
 		goto out_free_dev_number;
 	}
=20
-	/* We are not ready to support zero copy */
-	ub->dev_info.flags &=3D ~UBLK_F_SUPPORT_ZERO_COPY;
-
 	ub->dev_info.nr_hw_queues =3D min_t(unsigned int,
 			ub->dev_info.nr_hw_queues, nr_cpu_ids);
 	ublk_align_max_io_size(ub);
@@ -2860,7 +2905,7 @@ static int ublk_ctrl_get_features(struct io_uring_c=
md *cmd)
 {
 	const struct ublksrv_ctrl_cmd *header =3D io_uring_sqe_cmd(cmd->sqe);
 	void __user *argp =3D (void __user *)(unsigned long)header->addr;
-	u64 features =3D UBLK_F_ALL & ~UBLK_F_SUPPORT_ZERO_COPY;
+	u64 features =3D UBLK_F_ALL;
=20
 	if (header->len !=3D UBLK_FEATURES_LEN || !header->addr)
 		return -EINVAL;
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
index a8bc98bb69fce..74246c926b55f 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -94,6 +94,10 @@
 	_IOWR('u', UBLK_IO_COMMIT_AND_FETCH_REQ, struct ublksrv_io_cmd)
 #define	UBLK_U_IO_NEED_GET_DATA		\
 	_IOWR('u', UBLK_IO_NEED_GET_DATA, struct ublksrv_io_cmd)
+#define	UBLK_U_IO_REGISTER_IO_BUF	\
+	_IOWR('u', 0x23, struct ublksrv_io_cmd)
+#define	UBLK_U_IO_UNREGISTER_IO_BUF	\
+	_IOWR('u', 0x24, struct ublksrv_io_cmd)
=20
 /* only ABORT means that no re-fetch */
 #define UBLK_IO_RES_OK			0
--=20
2.43.5


