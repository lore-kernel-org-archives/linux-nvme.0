Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2141C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Apr 2022 18:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NXD9KVajxJV9lmS7UhO+CGaB9LHYu9wb8QSJ14OUa9M=; b=hhZU4hI1FDq4e3HbK5KjNY/xIs
	XQ4QZHglNzjChc75T6t40UH37C0r9Txpk1gU5LEwV4gBxOv3YOHGueThrU/HoFaMPbdaPb7X6j8pU
	Ggv8ul3o1a5ckNxUMlZsNPtYpEAAywtTlCpCiY7TNi9D90heQSQJKO8joUgblHqVVg7/FsIwRQTVY
	OMZdd/udluUDmqV12nWAEILe54ObeuuM3b5zNJvqBO1utJ+pljONCOFtH2E20pZQlqg53wIak/Uxv
	qL6eB/8Qsv7s4eeGcYjJhPJlOelFIROhyDQYcJgh82kfCVZH78Dml4whMI4SiEaGXHq7nI6f5ZWtY
	uVWcckeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nj3Pr-00AqvE-O9; Mon, 25 Apr 2022 18:26:31 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nj3PM-00AqdW-FM
 for linux-nvme@lists.infradead.org; Mon, 25 Apr 2022 18:26:01 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PHP6vY019390
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:25:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NXD9KVajxJV9lmS7UhO+CGaB9LHYu9wb8QSJ14OUa9M=;
 b=K4TbR1pGsFxLNw8vTtw9NZtq2sPynvgvz2QHkGA6kSkHEwKK6g3959swPoxYOjJfzOJk
 UrtQC3p1JpvrHdA1udEMoQov+fzJ/xo6zV65egI0wFquz0gF8M94UCF6NGzA59EvwUUH
 ipDPMCA9tCymeYhpcIr+TYUiHlWewcMXXG0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmf6v3wh4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:25:59 -0700
Received: from twshared6486.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 11:25:58 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
 id 453C6E1F2A61; Mon, 25 Apr 2022 11:25:41 -0700 (PDT)
From: Stefan Roesch <shr@fb.com>
To: <io-uring@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <kernel-team@fb.com>
CC: <shr@fb.com>, <joshi.k@samsung.com>
Subject: [PATCH v3 07/12] io_uring: flush completions for CQE32
Date: Mon, 25 Apr 2022 11:25:25 -0700
Message-ID: <20220425182530.2442911-8-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425182530.2442911-1-shr@fb.com>
References: <20220425182530.2442911-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tGic5YWgSYbc78Mxqj-j6fFive7xzlhl
X-Proofpoint-ORIG-GUID: tGic5YWgSYbc78Mxqj-j6fFive7xzlhl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220425_112600_672481_DF4F48B6 
X-CRM114-Status: GOOD (  16.67  )
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

This flushes the completions according to their CQE type: the same
processing is done for the default CQE size, but for large CQE's the
extra1 and extra2 fields are filled in.

Signed-off-by: Stefan Roesch <shr@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 726238dc65dc..68b61d2b356d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2885,8 +2885,12 @@ static void __io_submit_flush_completions(struct i=
o_ring_ctx *ctx)
 			struct io_kiocb *req =3D container_of(node, struct io_kiocb,
 						    comp_list);
=20
-			if (!(req->flags & REQ_F_CQE_SKIP))
-				__io_fill_cqe_req_filled(ctx, req);
+			if (!(req->flags & REQ_F_CQE_SKIP)) {
+				if (!(ctx->flags & IORING_SETUP_CQE32))
+					__io_fill_cqe_req_filled(ctx, req);
+				else
+					__io_fill_cqe32_req_filled(ctx, req);
+			}
 		}
=20
 		io_commit_cqring(ctx);
--=20
2.30.2


