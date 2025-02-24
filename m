Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BA7C021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 18:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7JqSt/JQS5UmtDOq3YgvOy3vth7Et3SdIZJaTRU4z+s=; b=AIhWcW7MwbVWG8pnz/lCnuUb3n
	7WFO6WmNuPDi3zjMdc4aGRCqMrYiS1PnfMqxpb5wOUMtj19GFxUu7toG77mirmxGNXdaM8ge4Vd+/
	v4hLOTXWdj1jQ8kGvZpt4wnceyLMpzFdDFPKi5Z8aOSWbBiMAoaMnANUiQG0cIZQAmGNYZTFNkuXY
	9/1oKafKu2B8s93BQoCiYjz9xF9Uh3lkAr+YEpZpgwD6a7Za0F1eyY+OAXJet44X2Adkz+nEU6B/v
	SJwmpGpeA/rquAzmmTSA/Wqvp46DE+TbXsoIw567UxT2YW2nKzQ4lP/ebSQo/fRuzsQboLC4kcVI1
	l2qoBcbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmdFl-0000000Eokj-44jC;
	Mon, 24 Feb 2025 18:32:29 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd5M-0000000EmeZ-3CxM
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 18:21:45 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OHU5hG017681
	for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 10:21:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=7JqSt/JQS5UmtDOq3YgvOy3vth7Et3SdIZJaTRU4z+s=; b=NNXraTRuvwU9
	CWK8Xpq9kDDsY36F+Ov0D4AD7SWag3+NxkYjznTop76lYzzJ/SCinpRzB0GIqTtO
	rTqa8E6v890obiHJJXMJn+dCU2ueklvkJVaF6+QkT7K85SxUbzQR7SV7kb6GmP13
	DuuXecI3MPRmpY8u9G/iQf3ydScfenHq2tWoC0g2Tg4/kl5U+f/zyxoEt62adljz
	QHXh7f/NdJpy76khgpMjCixiOx79kp6LD+5QPZlIM96oCdRIg1xBvWXyprJ+7pD8
	5TwxYaYLPoGSa5FBdslLf9Czl6iZ07PDaNySp7KYmsgO/08VJo4eR95rRWv22R31
	n3HuujThHw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 450w7fgens-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 10:21:44 -0800 (PST)
Received: from twshared11082.06.ash8.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 24 Feb 2025 18:21:35 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id EFE5918678FD0; Mon, 24 Feb 2025 10:21:29 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6/6] nvme-ioctl: simplify parameters
Date: Mon, 24 Feb 2025 10:21:28 -0800
Message-ID: <20250224182128.2042061-7-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250224182128.2042061-1-kbusch@meta.com>
References: <20250224182128.2042061-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: lcMX2MVjr236dUWQ8X15JWrNaL3WRYyu
X-Proofpoint-ORIG-GUID: lcMX2MVjr236dUWQ8X15JWrNaL3WRYyu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_102144_810853_541F8C82 
X-CRM114-Status: GOOD (  15.03  )
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

The uring_cmd handler already defines a struct to group all the
parameters needed to submit a request. Reuse this throughout to simplfy
the function signature.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 87 ++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 37 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 016a21a3861e9..729dac2d6ee0a 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -99,8 +99,15 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 	return (void __user *)ptrval;
 }
=20
-static int nvme_map_user_request(struct request *req, u64 ubuffer,
-		unsigned bufflen, u64 meta_buffer, unsigned meta_len,
+struct nvme_user_data {
+	__u64	metadata;
+	__u64	addr;
+	__u32	data_len;
+	__u32	metadata_len;
+	__u32	timeout_ms;
+};
+
+static int nvme_map_user_request(struct request *req, struct nvme_user_d=
ata *d,
 		struct io_uring_cmd *ioucmd, unsigned int flags)
 {
 	struct request_queue *q =3D req->q;
@@ -108,7 +115,7 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
 	struct block_device *bdev =3D ns ? ns->disk->part0 : NULL;
 	bool supports_metadata =3D bdev && blk_get_integrity(bdev->bd_disk);
 	struct nvme_ctrl *ctrl =3D nvme_req(req)->ctrl;
-	bool has_metadata =3D meta_buffer && meta_len;
+	bool has_metadata =3D d->metadata && d->metadata_len;
 	struct bio *bio =3D NULL;
 	int ret;
=20
@@ -128,14 +135,14 @@ static int nvme_map_user_request(struct request *re=
q, u64 ubuffer,
 		/* fixedbufs is only for non-vectored io */
 		if (WARN_ON_ONCE(flags & NVME_IOCTL_VEC))
 			return -EINVAL;
-		ret =3D io_uring_cmd_import_fixed(ubuffer, bufflen,
+		ret =3D io_uring_cmd_import_fixed(d->addr, d->data_len,
 				rq_data_dir(req), &iter, ioucmd);
 		if (ret < 0)
 			return ret;
 		ret =3D blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
 	} else {
-		ret =3D blk_rq_map_user_io(req, NULL, nvme_to_user_ptr(ubuffer),
-				bufflen, GFP_KERNEL, flags & NVME_IOCTL_VEC, 0,
+		ret =3D blk_rq_map_user_io(req, NULL, nvme_to_user_ptr(d->addr),
+				d->data_len, GFP_KERNEL, flags & NVME_IOCTL_VEC, 0,
 				0, rq_data_dir(req));
 	}
=20
@@ -148,7 +155,7 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
=20
 	if (has_metadata) {
 		ret =3D blk_rq_integrity_map_user(req,
-				nvme_to_user_ptr(meta_buffer), meta_len);
+				nvme_to_user_ptr(d->metadata), d->metadata_len);
 		if (ret)
 			goto out_unmap;
 	}
@@ -163,8 +170,7 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
=20
 static struct request *nvme_alloc_user_request(struct request_queue *q,
 		struct nvme_command *cmd, blk_opf_t rq_flags,
-		blk_mq_req_flags_t blk_flags, unsigned timeout_ms, u64 ubuffer,
-		unsigned bufflen, u64 meta_buffer, unsigned meta_len,
+		blk_mq_req_flags_t blk_flags, struct nvme_user_data *d,
 		struct io_uring_cmd *ioucmd, unsigned int flags)
 {
 	struct request *req;
@@ -175,11 +181,10 @@ static struct request *nvme_alloc_user_request(stru=
ct request_queue *q,
 		return req;
 	nvme_init_request(req, cmd);
 	nvme_req(req)->flags |=3D NVME_REQ_USERCMD;
-	req->timeout =3D timeout_ms ? msecs_to_jiffies(timeout_ms) : 0;
+	req->timeout =3D d->timeout_ms ? msecs_to_jiffies(d->timeout_ms) : 0;
=20
-	if (ubuffer && bufflen) {
-		ret =3D nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
-				meta_len, ioucmd, flags);
+	if (d->addr && d->data_len) {
+		ret =3D nvme_map_user_request(req, d, ioucmd, flags);
 		if (ret)
 			goto out;
 	}
@@ -191,9 +196,8 @@ static struct request *nvme_alloc_user_request(struct=
 request_queue *q,
 }
=20
 static int nvme_submit_user_cmd(struct request_queue *q,
-		struct nvme_command *cmd, u64 ubuffer, unsigned bufflen,
-		u64 meta_buffer, unsigned meta_len, u64 *result,
-		unsigned timeout_ms, unsigned int flags)
+		struct nvme_command *cmd, struct nvme_user_data *d,
+		u64 *result, unsigned int flags)
 {
 	struct nvme_ns *ns =3D q->queuedata;
 	struct nvme_ctrl *ctrl;
@@ -202,8 +206,7 @@ static int nvme_submit_user_cmd(struct request_queue =
*q,
 	u32 effects;
 	int ret;
=20
-	req =3D nvme_alloc_user_request(q, cmd, 0, 0, timeout_ms, ubuffer,
-		bufflen, meta_buffer, meta_len, NULL, flags);
+	req =3D nvme_alloc_user_request(q, cmd, 0, 0, d, NULL, flags);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
=20
@@ -229,6 +232,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct =
nvme_user_io __user *uio)
 	struct nvme_user_io io;
 	struct nvme_command c;
 	unsigned length, meta_len;
+	struct nvme_user_data d;
=20
 	if (copy_from_user(&io, uio, sizeof(io)))
 		return -EFAULT;
@@ -280,8 +284,13 @@ static int nvme_submit_io(struct nvme_ns *ns, struct=
 nvme_user_io __user *uio)
 	c.rw.lbat =3D cpu_to_le16(io.apptag);
 	c.rw.lbatm =3D cpu_to_le16(io.appmask);
=20
-	return nvme_submit_user_cmd(ns->queue, &c, io.addr, length, io.metadata=
,
-			meta_len, NULL, 0, 0);
+	d.addr =3D io.addr;
+	d.data_len =3D length;
+	d.metadata =3D io.metadata;
+	d.metadata_len =3D meta_len;
+	d.timeout_ms =3D 0;
+
+	return nvme_submit_user_cmd(ns->queue, &c, &d, NULL, 0);
 }
=20
 static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
@@ -302,6 +311,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, stru=
ct nvme_ns *ns,
 		struct nvme_passthru_cmd __user *ucmd, unsigned int flags)
 {
 	struct nvme_passthru_cmd cmd;
+	struct nvme_user_data d;
 	struct nvme_command c;
 	u64 result;
 	int status;
@@ -329,9 +339,14 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, str=
uct nvme_ns *ns,
 	if (!nvme_cmd_allowed(ns, &c, flags))
 		return -EACCES;
=20
-	status =3D nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			cmd.addr, cmd.data_len, cmd.metadata, cmd.metadata_len,
-			&result, cmd.timeout_ms, flags);
+	d.addr =3D cmd.addr;
+	d.data_len =3D cmd.data_len;
+	d.metadata =3D cmd.metadata;
+	d.metadata_len =3D cmd.metadata_len;
+	d.timeout_ms =3D cmd.timeout_ms;
+
+	status =3D nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c, &d,
+			&result, flags);
=20
 	if (status >=3D 0) {
 		if (put_user(result, &ucmd->result))
@@ -345,6 +360,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, st=
ruct nvme_ns *ns,
 		struct nvme_passthru_cmd64 __user *ucmd, unsigned int flags)
 {
 	struct nvme_passthru_cmd64 cmd;
+	struct nvme_user_data d;
 	struct nvme_command c;
 	int status;
=20
@@ -371,9 +387,14 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, s=
truct nvme_ns *ns,
 	if (!nvme_cmd_allowed(ns, &c, flags))
 		return -EACCES;
=20
-	status =3D nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			cmd.addr, cmd.data_len, cmd.metadata, cmd.metadata_len,
-			&cmd.result, cmd.timeout_ms, flags);
+	d.addr =3D cmd.addr;
+	d.data_len =3D cmd.data_len;
+	d.metadata =3D cmd.metadata;
+	d.metadata_len =3D cmd.metadata_len;
+	d.timeout_ms =3D cmd.timeout_ms;
+
+	status =3D nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c, &d,
+			&cmd.result, flags);
=20
 	if (status >=3D 0) {
 		if (put_user(cmd.result, &ucmd->result))
@@ -383,14 +404,6 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, s=
truct nvme_ns *ns,
 	return status;
 }
=20
-struct nvme_uring_data {
-	__u64	metadata;
-	__u64	addr;
-	__u32	data_len;
-	__u32	metadata_len;
-	__u32	timeout_ms;
-};
-
 /*
  * This overlays struct io_uring_cmd pdu.
  * Expect build errors if this grows larger than that.
@@ -459,7 +472,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
 	struct nvme_uring_cmd_pdu *pdu =3D nvme_uring_cmd_pdu(ioucmd);
 	const struct nvme_uring_cmd *cmd =3D io_uring_sqe_cmd(ioucmd->sqe);
 	struct request_queue *q =3D ns ? ns->queue : ctrl->admin_q;
-	struct nvme_uring_data d;
+	struct nvme_user_data d;
 	struct nvme_command c;
 	struct request *req;
 	blk_opf_t rq_flags =3D REQ_ALLOC_CACHE;
@@ -504,8 +517,8 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
 	if (issue_flags & IO_URING_F_IOPOLL)
 		rq_flags |=3D REQ_POLLED;
=20
-	req =3D nvme_alloc_user_request(q, &c, rq_flags, blk_flags, d.timeout_m=
s,
-		d.addr, d.data_len, d.metadata, d.metadata_len, ioucmd, flags);
+	req =3D nvme_alloc_user_request(q, &c, rq_flags, blk_flags, &d, ioucmd,
+		flags);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
=20
--=20
2.43.5


