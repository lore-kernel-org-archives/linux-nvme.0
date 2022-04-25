Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F991C43217
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Apr 2022 18:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/N/gNxRBe/NikFr05Gsxl6dhm/hRfDmfZb/uVTIY1qo=; b=B0Fu23evY2ZZz3rnMo8+AnpUuA
	v6h0Ra++UoiMLekExfOGukwSOMSNHPNgZRffsgEH5L8/Q1o1mwdS2g7puoXwf9kzL4dqryklRN1Ah
	XpnCCP7sARRdUV3P8qDebWb2T9mTGS+Fj4XkKrrLEb6+s6WqshxHC1NbDWDH9+DqJ6JmWzFUC3Cvg
	BDLlgNxXPqiF/3j3EgSID/UeLTNhqqb68ol3JjEwonwbgflT+RSsUWpc+B5awhERi2RMB180opu0B
	NxtWBSoQdySXSBnPfisfKL+Abn0MCDMSqV7qq7jrmOh4CAxoTKwxioJvENQoLkfm9h5bHGrqHyN+G
	Ho3RVqDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nj3PV-00AqjW-Nt; Mon, 25 Apr 2022 18:26:09 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nj3PD-00AqZ6-KV
 for linux-nvme@lists.infradead.org; Mon, 25 Apr 2022 18:25:53 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 23PHP6iO021904
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:25:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=/N/gNxRBe/NikFr05Gsxl6dhm/hRfDmfZb/uVTIY1qo=;
 b=QzVz9gKydavHWhFK6YAF1Wptd+D3KC5YP22PIgJNT83LNZ5ObyT9kdaq5OjC+RdiFzNS
 Gx109TZ5Hu8NktMf+XkSjWRvvuX/n9tfo+pHNsjjjLw+udAL4xwhbRvhkkFWVy6evuCz
 z6d5IpNWDUUfsCBPIAZjsObu9K4syJnQDGE= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by m0001303.ppops.net (PPS) with ESMTPS id 3fmd4rma80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:25:50 -0700
Received: from twshared14141.02.ash7.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 11:25:49 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
 id 2FEFEE1F2A5B; Mon, 25 Apr 2022 11:25:41 -0700 (PDT)
From: Stefan Roesch <shr@fb.com>
To: <io-uring@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <kernel-team@fb.com>
CC: <shr@fb.com>, <joshi.k@samsung.com>
Subject: [PATCH v3 04/12] io_uring: add CQE32 setup processing
Date: Mon, 25 Apr 2022 11:25:22 -0700
Message-ID: <20220425182530.2442911-5-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425182530.2442911-1-shr@fb.com>
References: <20220425182530.2442911-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yp5l3jh6moZ_bifQZ6epQ5h_3h5Pnvy8
X-Proofpoint-GUID: yp5l3jh6moZ_bifQZ6epQ5h_3h5Pnvy8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220425_112551_861004_6DE2AE8D 
X-CRM114-Status: GOOD (  16.14  )
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

This adds two new function to setup and fill the CQE32 result structure.

Signed-off-by: Stefan Roesch <shr@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 9712483d3a17..8cb51676d38d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2175,12 +2175,70 @@ static inline bool __io_fill_cqe_req_filled(struc=
t io_ring_ctx *ctx,
 					req->cqe.res, req->cqe.flags);
 }
=20
+static inline bool __io_fill_cqe32_req_filled(struct io_ring_ctx *ctx,
+					      struct io_kiocb *req)
+{
+	struct io_uring_cqe *cqe;
+	u64 extra1 =3D req->extra1;
+	u64 extra2 =3D req->extra2;
+
+	trace_io_uring_complete(req->ctx, req, req->cqe.user_data,
+				req->cqe.res, req->cqe.flags);
+
+	/*
+	 * If we can't get a cq entry, userspace overflowed the
+	 * submission (by quite a lot). Increment the overflow count in
+	 * the ring.
+	 */
+	cqe =3D io_get_cqe(ctx);
+	if (likely(cqe)) {
+		memcpy(cqe, &req->cqe, sizeof(struct io_uring_cqe));
+		cqe->big_cqe[0] =3D extra1;
+		cqe->big_cqe[1] =3D extra2;
+		return true;
+	}
+
+	return io_cqring_event_overflow(ctx, req->cqe.user_data,
+					req->cqe.res, req->cqe.flags);
+}
+
 static inline bool __io_fill_cqe_req(struct io_kiocb *req, s32 res, u32 =
cflags)
 {
 	trace_io_uring_complete(req->ctx, req, req->cqe.user_data, res, cflags)=
;
 	return __io_fill_cqe(req->ctx, req->cqe.user_data, res, cflags);
 }
=20
+static inline void __io_fill_cqe32_req(struct io_kiocb *req, s32 res, u3=
2 cflags,
+				u64 extra1, u64 extra2)
+{
+	struct io_ring_ctx *ctx =3D req->ctx;
+	struct io_uring_cqe *cqe;
+
+	if (WARN_ON_ONCE(!(ctx->flags & IORING_SETUP_CQE32)))
+		return;
+	if (req->flags & REQ_F_CQE_SKIP)
+		return;
+
+	trace_io_uring_complete(ctx, req, req->cqe.user_data, res, cflags);
+
+	/*
+	 * If we can't get a cq entry, userspace overflowed the
+	 * submission (by quite a lot). Increment the overflow count in
+	 * the ring.
+	 */
+	cqe =3D io_get_cqe(ctx);
+	if (likely(cqe)) {
+		WRITE_ONCE(cqe->user_data, req->cqe.user_data);
+		WRITE_ONCE(cqe->res, res);
+		WRITE_ONCE(cqe->flags, cflags);
+		WRITE_ONCE(cqe->big_cqe[0], extra1);
+		WRITE_ONCE(cqe->big_cqe[1], extra2);
+		return;
+	}
+
+	io_cqring_event_overflow(ctx, req->cqe.user_data, res, cflags);
+}
+
 static noinline bool io_fill_cqe_aux(struct io_ring_ctx *ctx, u64 user_d=
ata,
 				     s32 res, u32 cflags)
 {
--=20
2.30.2


