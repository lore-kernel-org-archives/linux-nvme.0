Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA3EC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 18:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6aVF9J6eGKImh+OJ6T4FWAYQVcZJWTrpZYloxQUqrDs=; b=m+UJ+mOA4yRyDDYU8JKF5XUkCX
	QoMgtPbo4hr1xYgAk34E1amOJ5smjAgbTq2ZQWIXu9/Hev8dWl3q3Q7WhcgfSmF5KUVXhgz6H0Qvj
	4cOAD8P8bDAppvE25xiBMAxz2QbKkp2lOfdSwGfWhRk4O98k0MoZJ9HsHPgL8+FTup5rwA4z0ZL2x
	+AZuqUZkIUh1S4GTItjHui0DJPTuNgMwJwL6DqdwSwC0cPhjGHn4Xhr23ZJ73/S2W+ozi+TqWh0vQ
	NVBEDLJpN+vV/YJlQZHzRV/Qfqp9ycrRa5a6mJ/GsfrG3aSAAZu9WRUQ47+najeGvlDRPqGWv+N4q
	uBiUZRRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njPvT-00Fih3-20; Tue, 26 Apr 2022 18:28:39 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njPou-00Ffeu-AQ
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 18:21:55 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 23QGQSgO018712
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 11:21:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=6aVF9J6eGKImh+OJ6T4FWAYQVcZJWTrpZYloxQUqrDs=;
 b=l3v5Elw7tAgwqIVsZgbL5kXjKZptuaTXYuBTYnn9D4m2Hn13wNQKIyTNQmezBok44Koz
 oZV2jFLbLkcWK+LgSMRL579Z330IMoGbheb/5kkNLO+klEdVbKcLaB+/nREtWs042xui
 fXH+n8ZluI3JydizYGnvstg44ZmrqBf4N7A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by m0001303.ppops.net (PPS) with ESMTPS id 3fmd4rv7gd-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 11:21:51 -0700
Received: from twshared14141.02.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 11:21:49 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
 id 749E6E2E569E; Tue, 26 Apr 2022 11:21:36 -0700 (PDT)
From: Stefan Roesch <shr@fb.com>
To: <io-uring@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <kernel-team@fb.com>
CC: <shr@fb.com>, <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 09/12] io_uring: add tracing for additional CQE32 fields
Date: Tue, 26 Apr 2022 11:21:31 -0700
Message-ID: <20220426182134.136504-10-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426182134.136504-1-shr@fb.com>
References: <20220426182134.136504-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Wsq-mY7Yu6ADWdNFidrT4tYver4ZWUlx
X-Proofpoint-GUID: Wsq-mY7Yu6ADWdNFidrT4tYver4ZWUlx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_05,2022-04-26_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_112152_566262_C4C21B95 
X-CRM114-Status: GOOD (  15.59  )
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

This adds tracing for the extra1 and extra2 fields.

Co-developed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Stefan Roesch <shr@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/io_uring.c                   | 11 ++++++-----
 include/trace/events/io_uring.h | 18 ++++++++++++++----
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3630671325ea..9dd075e39850 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2187,7 +2187,7 @@ static inline bool __io_fill_cqe_req_filled(struct =
io_ring_ctx *ctx,
 	struct io_uring_cqe *cqe;
=20
 	trace_io_uring_complete(req->ctx, req, req->cqe.user_data,
-				req->cqe.res, req->cqe.flags);
+				req->cqe.res, req->cqe.flags, 0, 0);
=20
 	/*
 	 * If we can't get a cq entry, userspace overflowed the
@@ -2211,7 +2211,7 @@ static inline bool __io_fill_cqe32_req_filled(struc=
t io_ring_ctx *ctx,
 	u64 extra2 =3D req->extra2;
=20
 	trace_io_uring_complete(req->ctx, req, req->cqe.user_data,
-				req->cqe.res, req->cqe.flags);
+				req->cqe.res, req->cqe.flags, extra1, extra2);
=20
 	/*
 	 * If we can't get a cq entry, userspace overflowed the
@@ -2232,7 +2232,7 @@ static inline bool __io_fill_cqe32_req_filled(struc=
t io_ring_ctx *ctx,
=20
 static inline bool __io_fill_cqe_req(struct io_kiocb *req, s32 res, u32 =
cflags)
 {
-	trace_io_uring_complete(req->ctx, req, req->cqe.user_data, res, cflags)=
;
+	trace_io_uring_complete(req->ctx, req, req->cqe.user_data, res, cflags,=
 0, 0);
 	return __io_fill_cqe(req->ctx, req->cqe.user_data, res, cflags);
 }
=20
@@ -2247,7 +2247,8 @@ static inline void __io_fill_cqe32_req(struct io_ki=
ocb *req, s32 res, u32 cflags
 	if (req->flags & REQ_F_CQE_SKIP)
 		return;
=20
-	trace_io_uring_complete(ctx, req, req->cqe.user_data, res, cflags);
+	trace_io_uring_complete(ctx, req, req->cqe.user_data, res, cflags,
+				extra1, extra2);
=20
 	/*
 	 * If we can't get a cq entry, userspace overflowed the
@@ -2271,7 +2272,7 @@ static noinline bool io_fill_cqe_aux(struct io_ring=
_ctx *ctx, u64 user_data,
 				     s32 res, u32 cflags)
 {
 	ctx->cq_extra++;
-	trace_io_uring_complete(ctx, NULL, user_data, res, cflags);
+	trace_io_uring_complete(ctx, NULL, user_data, res, cflags, 0, 0);
 	return __io_fill_cqe(ctx, user_data, res, cflags);
 }
=20
diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_ur=
ing.h
index 8477414d6d06..2eb4f4e47de4 100644
--- a/include/trace/events/io_uring.h
+++ b/include/trace/events/io_uring.h
@@ -318,13 +318,16 @@ TRACE_EVENT(io_uring_fail_link,
  * @user_data:		user data associated with the request
  * @res:		result of the request
  * @cflags:		completion flags
+ * @extra1:		extra 64-bit data for CQE32
+ * @extra2:		extra 64-bit data for CQE32
  *
  */
 TRACE_EVENT(io_uring_complete,
=20
-	TP_PROTO(void *ctx, void *req, u64 user_data, int res, unsigned cflags)=
,
+	TP_PROTO(void *ctx, void *req, u64 user_data, int res, unsigned cflags,
+		 u64 extra1, u64 extra2),
=20
-	TP_ARGS(ctx, req, user_data, res, cflags),
+	TP_ARGS(ctx, req, user_data, res, cflags, extra1, extra2),
=20
 	TP_STRUCT__entry (
 		__field(  void *,	ctx		)
@@ -332,6 +335,8 @@ TRACE_EVENT(io_uring_complete,
 		__field(  u64,		user_data	)
 		__field(  int,		res		)
 		__field(  unsigned,	cflags		)
+		__field(  u64,		extra1		)
+		__field(  u64,		extra2		)
 	),
=20
 	TP_fast_assign(
@@ -340,12 +345,17 @@ TRACE_EVENT(io_uring_complete,
 		__entry->user_data	=3D user_data;
 		__entry->res		=3D res;
 		__entry->cflags		=3D cflags;
+		__entry->extra1		=3D extra1;
+		__entry->extra2		=3D extra2;
 	),
=20
-	TP_printk("ring %p, req %p, user_data 0x%llx, result %d, cflags 0x%x",
+	TP_printk("ring %p, req %p, user_data 0x%llx, result %d, cflags 0x%x "
+		  "extra1 %llu extra2 %llu ",
 		__entry->ctx, __entry->req,
 		__entry->user_data,
-		__entry->res, __entry->cflags)
+		__entry->res, __entry->cflags,
+		(unsigned long long) __entry->extra1,
+		(unsigned long long) __entry->extra2)
 );
=20
 /**
--=20
2.30.2


