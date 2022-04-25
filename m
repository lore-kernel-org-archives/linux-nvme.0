Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54014C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Apr 2022 18:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=49nV4tBjg1d22Nfm2JNN53SEsUIcrfxLKsYXT9vRtH8=; b=NR8fGMYyNjGUUyo9vEurP4DQrI
	gGi2/xKsI6BZ0ODWRCmIq7gKb3uSfgwgXRgbZDm/S3cHwAbD0UUHhS6bYKFgR43B//Zx5ct84rfZB
	j1AUV18JQSYUDPn71YK/bc9gP8FPL/mD7RboA4QRGhBKMlnFtgH78WsNw45X/hMcw1Jh60rttjNtF
	/NHmMZfOewmxiAZyoo+Ym5Ola5Dhi5MOOpezpK35EtOdz5wWXauPPjR62Kzb+K2+8b1cvhgEgOlqz
	z4dS/d5ynKvZaYq5eSlxyWNYuvhN4HiLNImYBwySFMSDj2zq8khsYel7ezQkCaY8co2m1214TzTwM
	5sD/Qp7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nj3Pl-00AqsI-Tu; Mon, 25 Apr 2022 18:26:25 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nj3PK-00AqbO-Sj
 for linux-nvme@lists.infradead.org; Mon, 25 Apr 2022 18:26:01 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PHP6G3006698
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:25:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=49nV4tBjg1d22Nfm2JNN53SEsUIcrfxLKsYXT9vRtH8=;
 b=CdRnW+ztY9M0wHG8Z5n1q0VymXLSXyFr9ufLiQJ35kF0COIvPmEm5rDHmCq4S1UcKz2Q
 yJTMYbbejKgoN2Fqo9IH42wu2SQR5drV7hS2oP3XYo81Vza3asnioWFujZrvMxoDrp4x
 0ERjHyEvMsnd2Qgk9e8DiP9mhwONnyR4M4s= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmdgfvd4j-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:25:55 -0700
Received: from twshared14141.02.ash7.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 11:25:51 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
 id 36C15E1F2A5D; Mon, 25 Apr 2022 11:25:41 -0700 (PDT)
From: Stefan Roesch <shr@fb.com>
To: <io-uring@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <kernel-team@fb.com>
CC: <shr@fb.com>, <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 05/12] io_uring: add CQE32 completion processing
Date: Mon, 25 Apr 2022 11:25:23 -0700
Message-ID: <20220425182530.2442911-6-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425182530.2442911-1-shr@fb.com>
References: <20220425182530.2442911-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7xqDgmgDAhVDv7MrlElRg41QeoWQq_ub
X-Proofpoint-GUID: 7xqDgmgDAhVDv7MrlElRg41QeoWQq_ub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220425_112558_969850_983633C1 
X-CRM114-Status: GOOD (  17.76  )
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

This adds the completion processing for the large CQE's and makes sure
that the extra1 and extra2 fields are passed through.

Co-developed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Stefan Roesch <shr@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 53 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 8cb51676d38d..f300130fd9f0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2247,18 +2247,15 @@ static noinline bool io_fill_cqe_aux(struct io_ri=
ng_ctx *ctx, u64 user_data,
 	return __io_fill_cqe(ctx, user_data, res, cflags);
 }
=20
-static void __io_req_complete_post(struct io_kiocb *req, s32 res,
-				   u32 cflags)
+static void __io_req_complete_put(struct io_kiocb *req)
 {
-	struct io_ring_ctx *ctx =3D req->ctx;
-
-	if (!(req->flags & REQ_F_CQE_SKIP))
-		__io_fill_cqe_req(req, res, cflags);
 	/*
 	 * If we're the last reference to this request, add to our locked
 	 * free_list cache.
 	 */
 	if (req_ref_put_and_test(req)) {
+		struct io_ring_ctx *ctx =3D req->ctx;
+
 		if (req->flags & IO_REQ_LINK_FLAGS) {
 			if (req->flags & IO_DISARM_MASK)
 				io_disarm_next(req);
@@ -2281,8 +2278,23 @@ static void __io_req_complete_post(struct io_kiocb=
 *req, s32 res,
 	}
 }
=20
-static void io_req_complete_post(struct io_kiocb *req, s32 res,
-				 u32 cflags)
+static void __io_req_complete_post(struct io_kiocb *req, s32 res,
+				   u32 cflags)
+{
+	if (!(req->flags & REQ_F_CQE_SKIP))
+		__io_fill_cqe_req(req, res, cflags);
+	__io_req_complete_put(req);
+}
+
+static void __io_req_complete_post32(struct io_kiocb *req, s32 res,
+				   u32 cflags, u64 extra1, u64 extra2)
+{
+	if (!(req->flags & REQ_F_CQE_SKIP))
+		__io_fill_cqe32_req(req, res, cflags, extra1, extra2);
+	__io_req_complete_put(req);
+}
+
+static void io_req_complete_post(struct io_kiocb *req, s32 res, u32 cfla=
gs)
 {
 	struct io_ring_ctx *ctx =3D req->ctx;
=20
@@ -2293,6 +2305,18 @@ static void io_req_complete_post(struct io_kiocb *=
req, s32 res,
 	io_cqring_ev_posted(ctx);
 }
=20
+static void io_req_complete_post32(struct io_kiocb *req, s32 res,
+				   u32 cflags, u64 extra1, u64 extra2)
+{
+	struct io_ring_ctx *ctx =3D req->ctx;
+
+	spin_lock(&ctx->completion_lock);
+	__io_req_complete_post32(req, res, cflags, extra1, extra2);
+	io_commit_cqring(ctx);
+	spin_unlock(&ctx->completion_lock);
+	io_cqring_ev_posted(ctx);
+}
+
 static inline void io_req_complete_state(struct io_kiocb *req, s32 res,
 					 u32 cflags)
 {
@@ -2310,6 +2334,19 @@ static inline void __io_req_complete(struct io_kio=
cb *req, unsigned issue_flags,
 		io_req_complete_post(req, res, cflags);
 }
=20
+static inline void __io_req_complete32(struct io_kiocb *req,
+				       unsigned int issue_flags, s32 res,
+				       u32 cflags, u64 extra1, u64 extra2)
+{
+	if (issue_flags & IO_URING_F_COMPLETE_DEFER) {
+		io_req_complete_state(req, res, cflags);
+		req->extra1 =3D extra1;
+		req->extra2 =3D extra2;
+	} else {
+		io_req_complete_post32(req, res, cflags, extra1, extra2);
+	}
+}
+
 static inline void io_req_complete(struct io_kiocb *req, s32 res)
 {
 	__io_req_complete(req, 0, res, 0);
--=20
2.30.2


