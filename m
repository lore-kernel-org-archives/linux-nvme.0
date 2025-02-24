Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F53FC021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rCDpGqHMuD0g4Q2IGKBrxsuHZAqNfi7TU5XyKpZNqg0=; b=tH21zENAeZ4CO1BRE46pjxNuS8
	HjN+ztW6q7UF5XW+nGaYGLHYL4YvC3GE13t4e7uDQL82v9qe/Aske8rj71QuT9vepwodbU3xZWbtj
	l9zeK88qex0FCpilAwoF+bPN+v432UDjqeJs9BAbqufUgpame0g75wT2UC5PWXj6745V4NoqqFmbJ
	lxPHBF4M1pwxDLQ2UCYiitk+ZP9ZkImvZtAk0hOUi5AzvR02JjBso1v5tiNa1GgGkzb9v/6g35EYi
	wsbFpe2xYjKkoIHuKYokLwij7O79txL/pzV1zZFo/QeoE3uPP3x5wIH8ZJNVUlMK6ZM8HEDPoWuaM
	+R+6aBfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmdFl-0000000EokA-1PNX;
	Mon, 24 Feb 2025 18:32:29 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd5I-0000000Eme3-0xbZ
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 18:21:41 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 51OFDQq5009028
	for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 10:21:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=rCDpGqHMuD0g4Q2IGKBrxsuHZAqNfi7TU5XyKpZNqg0=; b=c6Ljk0ulOeh7
	rvxmaNznZmOQz+txniRgLtjAWqVMNloyABVx5OkUHlDtaCQown6le93FrDmqeHjf
	IJ5n//RjCKbPcV3yiRcs+y+dXbi1wp4xb5LBILmN8hb3VjbNen3saeJqyB21/qaD
	8Wi+CGaPsqe7q/FiD4mg+zkBDZPG0wI7jp7HwOP2/5ezqUzJKTC412tnjFB0WYPa
	HYlwTQRxt2KyeM2HyklsXHmqVL4raDbXoOsoiK2+nTnFg0u/7Yh+dcAWuGkWordp
	CrDr3aauX6pzmrH2LQ8WSSTS2xI+kWdsAuIreYFNg97talekRVearBNNlppoDoIW
	bR6jPetffA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 450su1a9x4-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 10:21:38 -0800 (PST)
Received: from twshared18153.09.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 24 Feb 2025 18:21:30 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id BB09518678FB5; Mon, 24 Feb 2025 10:21:29 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/6] nvme-ioctl: use common type for user data addresses
Date: Mon, 24 Feb 2025 10:21:24 -0800
Message-ID: <20250224182128.2042061-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250224182128.2042061-1-kbusch@meta.com>
References: <20250224182128.2042061-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: LE1b3ZbWNqUwYotLDxzIAlK8wS8Rdbqz
X-Proofpoint-GUID: LE1b3ZbWNqUwYotLDxzIAlK8wS8Rdbqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_102140_391095_A6AFADEF 
X-CRM114-Status: GOOD (  15.11  )
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

The data type is represented as a u64, but the metadata type as a __user
void *. These two fields represent the same thing, so treating them so
differently looks a bit odd. Just pick one consistent type of
representation.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a3082414c7714..f1233a280d3b3 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -114,7 +114,7 @@ static struct request *nvme_alloc_user_request(struct=
 request_queue *q,
 }
=20
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
-		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
+		unsigned bufflen, u64 meta_buffer, unsigned meta_len,
 		struct io_uring_cmd *ioucmd, unsigned int flags)
 {
 	struct request_queue *q =3D req->q;
@@ -161,7 +161,8 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
 		bio_set_dev(bio, bdev);
=20
 	if (has_metadata) {
-		ret =3D blk_rq_integrity_map_user(req, meta_buffer, meta_len);
+		ret =3D blk_rq_integrity_map_user(req,
+				nvme_to_user_ptr(meta_buffer), meta_len);
 		if (ret)
 			goto out_unmap;
 	}
@@ -178,8 +179,8 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
=20
 static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, u64 ubuffer, unsigned bufflen,
-		void __user *meta_buffer, unsigned meta_len,
-		u64 *result, unsigned timeout, unsigned int flags)
+		u64 meta_buffer, unsigned meta_len, u64 *result,
+		unsigned timeout, unsigned int flags)
 {
 	struct nvme_ns *ns =3D q->queuedata;
 	struct nvme_ctrl *ctrl;
@@ -222,7 +223,6 @@ static int nvme_submit_io(struct nvme_ns *ns, struct =
nvme_user_io __user *uio)
 	struct nvme_user_io io;
 	struct nvme_command c;
 	unsigned length, meta_len;
-	void __user *metadata;
=20
 	if (copy_from_user(&io, uio, sizeof(io)))
 		return -EFAULT;
@@ -246,13 +246,12 @@ static int nvme_submit_io(struct nvme_ns *ns, struc=
t nvme_user_io __user *uio)
 		 * Protection information is stripped/inserted by the
 		 * controller.
 		 */
-		if (nvme_to_user_ptr(io.metadata))
+		if (io.metadata)
 			return -EINVAL;
 		meta_len =3D 0;
-		metadata =3D NULL;
+		io.metadata =3D 0;
 	} else {
 		meta_len =3D (io.nblocks + 1) * ns->head->ms;
-		metadata =3D nvme_to_user_ptr(io.metadata);
 	}
=20
 	if (ns->head->features & NVME_NS_EXT_LBAS) {
@@ -275,7 +274,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct =
nvme_user_io __user *uio)
 	c.rw.lbat =3D cpu_to_le16(io.apptag);
 	c.rw.lbatm =3D cpu_to_le16(io.appmask);
=20
-	return nvme_submit_user_cmd(ns->queue, &c, io.addr, length, metadata,
+	return nvme_submit_user_cmd(ns->queue, &c, io.addr, length, io.metadata=
,
 			meta_len, NULL, 0, 0);
 }
=20
@@ -329,8 +328,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, stru=
ct nvme_ns *ns,
 		timeout =3D msecs_to_jiffies(cmd.timeout_ms);
=20
 	status =3D nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			cmd.addr, cmd.data_len, nvme_to_user_ptr(cmd.metadata),
-			cmd.metadata_len, &result, timeout, 0);
+			cmd.addr, cmd.data_len, cmd.metadata, cmd.metadata_len,
+			&result, timeout, flags);
=20
 	if (status >=3D 0) {
 		if (put_user(result, &ucmd->result))
@@ -375,8 +374,8 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, st=
ruct nvme_ns *ns,
 		timeout =3D msecs_to_jiffies(cmd.timeout_ms);
=20
 	status =3D nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
-			cmd.addr, cmd.data_len, nvme_to_user_ptr(cmd.metadata),
-			cmd.metadata_len, &cmd.result, timeout, flags);
+			cmd.addr, cmd.data_len, cmd.metadata, cmd.metadata_len,
+			&cmd.result, timeout, flags);
=20
 	if (status >=3D 0) {
 		if (put_user(cmd.result, &ucmd->result))
@@ -514,9 +513,8 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
 	req->timeout =3D d.timeout_ms ? msecs_to_jiffies(d.timeout_ms) : 0;
=20
 	if (d.addr && d.data_len) {
-		ret =3D nvme_map_user_request(req, d.addr,
-			d.data_len, nvme_to_user_ptr(d.metadata),
-			d.metadata_len, ioucmd, vec);
+		ret =3D nvme_map_user_request(req, d.addr, d.data_len, d.metadata,
+					    d.metadata_len, ioucmd, vec);
 		if (ret)
 			return ret;
 	}
--=20
2.43.5


