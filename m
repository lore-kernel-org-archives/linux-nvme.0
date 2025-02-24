Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C1FC021BB
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 18:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Um07RsKB4nglRJwOw+hdagXw4nRFhRPPFg+Kc6qBAM=; b=xijyC7vtvqrgTSj2K4iIJc2NBc
	uzKfAEX3VIkUYRoNnGYFxTlx7RJLmOWxZdlI7Vv/G7kmwr34bds0x1LQZiNlOKRQb+C7upGAmNkSD
	fwYQ/37EKUJ9h5jYxNFzIwwvESMTwAmjtkKpZzQP2Iq7sZwMeXa55J/DyG1Oo0xHcPOOfAWtwmDtd
	mNnXmbZQrfIAE2xBRG23xjWNNex05WF1m7squXTr/l/p7doJBfb3wI96+gCVVUZjNZUPmVR/vLkf1
	oY1X7vxVllAUCUMLigVtnJpHG0hW0RgicSu2C71QGUA1lF5DHIVsLt/y+nr5IbH8BJVCLbq33xf+t
	vRPy03qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmdFk-0000000Eojr-31o6;
	Mon, 24 Feb 2025 18:32:28 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd5E-0000000EmdN-3vyO
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 18:21:38 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OGBhqc003038
	for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 10:21:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=/Um07RsKB4nglRJwOw+hdagXw4nRFhRPPFg+Kc6qBAM=; b=XxuCNCLerppj
	awQDTUBoi8+t95+iWlcUC4TTYRldmNVNuLx6GUE629BU8wirQgw34On54iFXdlX9
	lkr4MhFUWWhPeUgG/vm//QfVNtKFe9pEDheJB7Tplr7XcmYRGe41yFgx8QzVvq/+
	GjDpZ/YNJpWa8R23hg78wpVFK3hFi5BGJ39BV1ojxmalKfFOKPpvHmjb1FEWNCkW
	HazJcnpuyEo8P+TXK1nFSlV0Bhh7QdbDN2UcZE48M9vPU7HmZxI63hcBLn6SE433
	C6V0yT57CnR0wwWXP8NeNiA/5jCbiJyKJvo8uALrjR45LfFVnKa7EyULMAZ3woDz
	/GfiQDS5qA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 450v2ws57h-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 10:21:34 -0800 (PST)
Received: from twshared53813.03.ash8.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 24 Feb 2025 18:21:25 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id E7C1418678FCE; Mon, 24 Feb 2025 10:21:29 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5/6] nvme-ioctl: combine alloc and map
Date: Mon, 24 Feb 2025 10:21:27 -0800
Message-ID: <20250224182128.2042061-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250224182128.2042061-1-kbusch@meta.com>
References: <20250224182128.2042061-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: LAfw5Mmf1Xc1SwhNKfcbl4-zOCi8Sjev
X-Proofpoint-ORIG-GUID: LAfw5Mmf1Xc1SwhNKfcbl4-zOCi8Sjev
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_102137_051740_A7AE82A3 
X-CRM114-Status: GOOD (  14.05  )
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

The same pattern repeats, so combine it. Also, the existing mapping
leaks a request if a user requests to map a vectored fixed buffer, or
unsupportable metadata formts, so these get fixed here too.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 69 +++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 1f28fc4b341dd..016a21a3861e9 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -99,21 +99,6 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 	return (void __user *)ptrval;
 }
=20
-static struct request *nvme_alloc_user_request(struct request_queue *q,
-		struct nvme_command *cmd, blk_opf_t rq_flags,
-		blk_mq_req_flags_t blk_flags, unsigned timeout_ms)
-{
-	struct request *req;
-
-	req =3D blk_mq_alloc_request(q, nvme_req_op(cmd) | rq_flags, blk_flags)=
;
-	if (IS_ERR(req))
-		return req;
-	nvme_init_request(req, cmd);
-	nvme_req(req)->flags |=3D NVME_REQ_USERCMD;
-	req->timeout =3D timeout_ms ? msecs_to_jiffies(timeout_ms) : 0;
-	return req;
-}
-
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		unsigned bufflen, u64 meta_buffer, unsigned meta_len,
 		struct io_uring_cmd *ioucmd, unsigned int flags)
@@ -146,7 +131,7 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
 		ret =3D io_uring_cmd_import_fixed(ubuffer, bufflen,
 				rq_data_dir(req), &iter, ioucmd);
 		if (ret < 0)
-			goto out;
+			return ret;
 		ret =3D blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
 	} else {
 		ret =3D blk_rq_map_user_io(req, NULL, nvme_to_user_ptr(ubuffer),
@@ -155,7 +140,7 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
 	}
=20
 	if (ret)
-		goto out;
+		return ret;
=20
 	bio =3D req->bio;
 	if (bdev)
@@ -173,9 +158,36 @@ static int nvme_map_user_request(struct request *req=
, u64 ubuffer,
 out_unmap:
 	if (bio)
 		blk_rq_unmap_user(bio);
+	return ret;
+}
+
+static struct request *nvme_alloc_user_request(struct request_queue *q,
+		struct nvme_command *cmd, blk_opf_t rq_flags,
+		blk_mq_req_flags_t blk_flags, unsigned timeout_ms, u64 ubuffer,
+		unsigned bufflen, u64 meta_buffer, unsigned meta_len,
+		struct io_uring_cmd *ioucmd, unsigned int flags)
+{
+	struct request *req;
+	int ret;
+
+	req =3D blk_mq_alloc_request(q, nvme_req_op(cmd) | rq_flags, blk_flags)=
;
+	if (IS_ERR(req))
+		return req;
+	nvme_init_request(req, cmd);
+	nvme_req(req)->flags |=3D NVME_REQ_USERCMD;
+	req->timeout =3D timeout_ms ? msecs_to_jiffies(timeout_ms) : 0;
+
+	if (ubuffer && bufflen) {
+		ret =3D nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
+				meta_len, ioucmd, flags);
+		if (ret)
+			goto out;
+	}
+
+	return req;
 out:
 	blk_mq_free_request(req);
-	return ret;
+	return ERR_PTR(ret);
 }
=20
 static int nvme_submit_user_cmd(struct request_queue *q,
@@ -190,17 +202,11 @@ static int nvme_submit_user_cmd(struct request_queu=
e *q,
 	u32 effects;
 	int ret;
=20
-	req =3D nvme_alloc_user_request(q, cmd, 0, 0, timeout_ms);
+	req =3D nvme_alloc_user_request(q, cmd, 0, 0, timeout_ms, ubuffer,
+		bufflen, meta_buffer, meta_len, NULL, flags);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
=20
-	if (ubuffer && bufflen) {
-		ret =3D nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
-				meta_len, NULL, flags);
-		if (ret)
-			return ret;
-	}
-
 	bio =3D req->bio;
 	ctrl =3D nvme_req(req)->ctrl;
=20
@@ -458,7 +464,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
 	struct request *req;
 	blk_opf_t rq_flags =3D REQ_ALLOC_CACHE;
 	blk_mq_req_flags_t blk_flags =3D 0;
-	int ret;
=20
 	c.common.opcode =3D READ_ONCE(cmd->opcode);
 	c.common.flags =3D READ_ONCE(cmd->flags);
@@ -499,17 +504,11 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl=
, struct nvme_ns *ns,
 	if (issue_flags & IO_URING_F_IOPOLL)
 		rq_flags |=3D REQ_POLLED;
=20
-	req =3D nvme_alloc_user_request(q, &c, rq_flags, blk_flags, d.timeout_m=
s);
+	req =3D nvme_alloc_user_request(q, &c, rq_flags, blk_flags, d.timeout_m=
s,
+		d.addr, d.data_len, d.metadata, d.metadata_len, ioucmd, flags);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
=20
-	if (d.addr && d.data_len) {
-		ret =3D nvme_map_user_request(req, d.addr, d.data_len, d.metadata,
-					    d.metadata_len, ioucmd, flags);
-		if (ret)
-			return ret;
-	}
-
 	/* to free bio on completion, as req->bio will be null at that time */
 	pdu->bio =3D req->bio;
 	pdu->req =3D req;
--=20
2.43.5


