Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54210C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 18:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8bEH++r+nOCEp5EwRShOwnjZVPfu74jpFjuZj+XFwoY=; b=bD87BqfhRfuhnAeJgBXQJwAk3/
	gHhEm6H6+Tmz1YgKTv2bcIZYzdx3JlDWTERccfPhxKnTtYBShnBRxSVV9zeWjwFpAAVYJ2HNlaEW8
	1gdtj+C/die2Kj3ELENyZxASUaQ5XfH8KEUHEvPgoq2JZxpEmFKGWqySF7Cq1lY9TRQTNwqnhJcvZ
	r+yq6FfzwiYgQaawwJFIocrQkUM1YPkN6rh/3LrtyeB6VhPwAV0hhRL/awoulyJo32Zy03r18Gx2Z
	B/XksegdVg1CKm6D3b5WvCZ5/V7IWFkrfvMRoaeoLDa5HLEwWqY1BJOc9BKIMwNceLkqMbsQ6i3pL
	W3XNduYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njPw8-00Fiwg-RM; Tue, 26 Apr 2022 18:29:21 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njPot-00Ffdy-An
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 18:21:55 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QGQXBI011623
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 11:21:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=8bEH++r+nOCEp5EwRShOwnjZVPfu74jpFjuZj+XFwoY=;
 b=N6qHV+eMBuQGLB5qgQqIvKpoBFON9dPjyCb5l7tK27tkbwpwSk804we4oIMe1hQewpi7
 qpzoX0ZATJgNP/8LlSRBSnpEIATvsIcUsreK9h4OFGf7DSV+AfYOHw2cX5YGkOLZ77P4
 xZ6A9U6986lbBAKbAZ8pEEoiq0FRx6rqKVw= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmeyu3ykh-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 11:21:50 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 11:21:48 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
 id 6E62AE2E569C; Tue, 26 Apr 2022 11:21:36 -0700 (PDT)
From: Stefan Roesch <shr@fb.com>
To: <io-uring@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <kernel-team@fb.com>
CC: <shr@fb.com>, <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 08/12] io_uring: overflow processing for CQE32
Date: Tue, 26 Apr 2022 11:21:30 -0700
Message-ID: <20220426182134.136504-9-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426182134.136504-1-shr@fb.com>
References: <20220426182134.136504-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vE-TDDU-spUO3WzGGyrdyxmkIjEbRTpQ
X-Proofpoint-ORIG-GUID: vE-TDDU-spUO3WzGGyrdyxmkIjEbRTpQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_05,2022-04-26_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_112151_572318_975B5ADA 
X-CRM114-Status: GOOD (  20.30  )
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

This adds the overflow processing for large CQE's.

This adds two parameters to the io_cqring_event_overflow function and
uses these fields to initialize the large CQE fields.

Allocate enough space for large CQE's in the overflow structue. If no
large CQE's are used, the size of the allocation is unchanged.

The cqe field can have a different size depending if its a large
CQE or not. To be able to allocate different sizes, the two fields
in the structure are re-ordered.

Co-developed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Stefan Roesch <shr@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/io_uring.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 68b61d2b356d..3630671325ea 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -220,8 +220,8 @@ struct io_mapped_ubuf {
 struct io_ring_ctx;
=20
 struct io_overflow_cqe {
-	struct io_uring_cqe cqe;
 	struct list_head list;
+	struct io_uring_cqe cqe;
 };
=20
 struct io_fixed_file {
@@ -2017,10 +2017,14 @@ static void io_cqring_ev_posted_iopoll(struct io_=
ring_ctx *ctx)
 static bool __io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool for=
ce)
 {
 	bool all_flushed, posted;
+	size_t cqe_size =3D sizeof(struct io_uring_cqe);
=20
 	if (!force && __io_cqring_events(ctx) =3D=3D ctx->cq_entries)
 		return false;
=20
+	if (ctx->flags & IORING_SETUP_CQE32)
+		cqe_size <<=3D 1;
+
 	posted =3D false;
 	spin_lock(&ctx->completion_lock);
 	while (!list_empty(&ctx->cq_overflow_list)) {
@@ -2032,7 +2036,7 @@ static bool __io_cqring_overflow_flush(struct io_ri=
ng_ctx *ctx, bool force)
 		ocqe =3D list_first_entry(&ctx->cq_overflow_list,
 					struct io_overflow_cqe, list);
 		if (cqe)
-			memcpy(cqe, &ocqe->cqe, sizeof(*cqe));
+			memcpy(cqe, &ocqe->cqe, cqe_size);
 		else
 			io_account_cq_overflow(ctx);
=20
@@ -2121,11 +2125,16 @@ static __cold void io_uring_drop_tctx_refs(struct=
 task_struct *task)
 }
=20
 static bool io_cqring_event_overflow(struct io_ring_ctx *ctx, u64 user_d=
ata,
-				     s32 res, u32 cflags)
+				     s32 res, u32 cflags, u64 extra1, u64 extra2)
 {
 	struct io_overflow_cqe *ocqe;
+	size_t ocq_size =3D sizeof(struct io_overflow_cqe);
+	bool is_cqe32 =3D (ctx->flags & IORING_SETUP_CQE32);
+
+	if (is_cqe32)
+		ocq_size +=3D sizeof(struct io_uring_cqe);
=20
-	ocqe =3D kmalloc(sizeof(*ocqe), GFP_ATOMIC | __GFP_ACCOUNT);
+	ocqe =3D kmalloc(ocq_size, GFP_ATOMIC | __GFP_ACCOUNT);
 	if (!ocqe) {
 		/*
 		 * If we're in ring overflow flush mode, or in task cancel mode,
@@ -2144,6 +2153,10 @@ static bool io_cqring_event_overflow(struct io_rin=
g_ctx *ctx, u64 user_data,
 	ocqe->cqe.user_data =3D user_data;
 	ocqe->cqe.res =3D res;
 	ocqe->cqe.flags =3D cflags;
+	if (is_cqe32) {
+		ocqe->cqe.big_cqe[0] =3D extra1;
+		ocqe->cqe.big_cqe[1] =3D extra2;
+	}
 	list_add_tail(&ocqe->list, &ctx->cq_overflow_list);
 	return true;
 }
@@ -2165,7 +2178,7 @@ static inline bool __io_fill_cqe(struct io_ring_ctx=
 *ctx, u64 user_data,
 		WRITE_ONCE(cqe->flags, cflags);
 		return true;
 	}
-	return io_cqring_event_overflow(ctx, user_data, res, cflags);
+	return io_cqring_event_overflow(ctx, user_data, res, cflags, 0, 0);
 }
=20
 static inline bool __io_fill_cqe_req_filled(struct io_ring_ctx *ctx,
@@ -2187,7 +2200,7 @@ static inline bool __io_fill_cqe_req_filled(struct =
io_ring_ctx *ctx,
 		return true;
 	}
 	return io_cqring_event_overflow(ctx, req->cqe.user_data,
-					req->cqe.res, req->cqe.flags);
+					req->cqe.res, req->cqe.flags, 0, 0);
 }
=20
 static inline bool __io_fill_cqe32_req_filled(struct io_ring_ctx *ctx,
@@ -2213,8 +2226,8 @@ static inline bool __io_fill_cqe32_req_filled(struc=
t io_ring_ctx *ctx,
 		return true;
 	}
=20
-	return io_cqring_event_overflow(ctx, req->cqe.user_data,
-					req->cqe.res, req->cqe.flags);
+	return io_cqring_event_overflow(ctx, req->cqe.user_data, req->cqe.res,
+					req->cqe.flags, extra1, extra2);
 }
=20
 static inline bool __io_fill_cqe_req(struct io_kiocb *req, s32 res, u32 =
cflags)
@@ -2251,7 +2264,7 @@ static inline void __io_fill_cqe32_req(struct io_ki=
ocb *req, s32 res, u32 cflags
 		return;
 	}
=20
-	io_cqring_event_overflow(ctx, req->cqe.user_data, res, cflags);
+	io_cqring_event_overflow(ctx, req->cqe.user_data, res, cflags, extra1, =
extra2);
 }
=20
 static noinline bool io_fill_cqe_aux(struct io_ring_ctx *ctx, u64 user_d=
ata,
--=20
2.30.2


