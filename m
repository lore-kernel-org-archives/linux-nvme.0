Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F4CC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Apr 2022 18:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dVtUF55jtgEmVrBg6DLq2P86ucjfdRAqoPrT/PGz08Y=; b=r2iB4wsSqRxlqynZ7xQmA4q8Ks
	+HkuxI8QmDbEpWcZYhRIqOvxydE3/PgHE3CuPZreWuUjK4eUEKv8qx4XkxSA1K53yNSwd7uwXHeSW
	rSnFG3XDdHKId+y130F03M/9UCLsHrJbz1s9cHl4HgLjvafZS8YU4OtSxSxsiIjudR0kU2Qbrgf/g
	hwomWv/+QAvMNxxCx8Lk5IjUTYtTWQTTgBHFL9K6YCwUoexa7zXvyOt4Q8XEi9ymeYVxjwknNX8a2
	bN0gZ4om3ZX04fYsGJqTq68Blcl7A0xszinxkHHEdCTUsZn+soD4r0iab3NEXmwK7v5yL49D3kdj/
	Hph44Hgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nj3Q0-00Ar0y-SG; Mon, 25 Apr 2022 18:26:41 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nj3PN-00Aqdq-70
 for linux-nvme@lists.infradead.org; Mon, 25 Apr 2022 18:26:02 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 23PHP3cv021763
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:26:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=dVtUF55jtgEmVrBg6DLq2P86ucjfdRAqoPrT/PGz08Y=;
 b=FM+ceT3R7vdDHi+wgWrB0g/zGGrJkaQy8Al8csqAfzfBiWwSfbtb4a5Bm2rm1e2XnjtK
 elpRW82AXvGVi/7x/dyvQI7tXjNi1h1UvtP8WY3agaCBtVHwcBE4iBEnzJtiThAPrXWw
 VgNzy+U7JcaVj4j3Lpg1geUmYxJMa6UGQWk= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by m0001303.ppops.net (PPS) with ESMTPS id 3fmd4rma9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:26:00 -0700
Received: from twshared4937.07.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 11:25:58 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
 id 59490E1F2A67; Mon, 25 Apr 2022 11:25:41 -0700 (PDT)
From: Stefan Roesch <shr@fb.com>
To: <io-uring@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <kernel-team@fb.com>
CC: <shr@fb.com>, <joshi.k@samsung.com>
Subject: [PATCH v3 10/12] io_uring: support CQE32 in /proc info
Date: Mon, 25 Apr 2022 11:25:28 -0700
Message-ID: <20220425182530.2442911-11-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425182530.2442911-1-shr@fb.com>
References: <20220425182530.2442911-1-shr@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UkxN1OgqBZrmBKcnF_8JV8Z_Qc_RjSYC
X-Proofpoint-GUID: UkxN1OgqBZrmBKcnF_8JV8Z_Qc_RjSYC
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220425_112601_463614_18C51A79 
X-CRM114-Status: GOOD (  18.67  )
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

This exposes the extra1 and extra2 fields in the /proc output.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 fs/io_uring.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 9dd075e39850..e1b84204b0ab 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -11354,10 +11354,15 @@ static __cold void __io_uring_show_fdinfo(struct =
io_ring_ctx *ctx,
 	unsigned int sq_tail =3D READ_ONCE(r->sq.tail);
 	unsigned int cq_head =3D READ_ONCE(r->cq.head);
 	unsigned int cq_tail =3D READ_ONCE(r->cq.tail);
+	unsigned int cq_shift =3D 0;
 	unsigned int sq_entries, cq_entries;
 	bool has_lock;
+	bool is_cqe32 =3D (ctx->flags & IORING_SETUP_CQE32);
 	unsigned int i;
=20
+	if (is_cqe32)
+		cq_shift =3D 1;
+
 	/*
 	 * we may get imprecise sqe and cqe info if uring is actively running
 	 * since we get cached_sq_head and cached_cq_tail without uring_lock
@@ -11390,11 +11395,18 @@ static __cold void __io_uring_show_fdinfo(struct =
io_ring_ctx *ctx,
 	cq_entries =3D min(cq_tail - cq_head, ctx->cq_entries);
 	for (i =3D 0; i < cq_entries; i++) {
 		unsigned int entry =3D i + cq_head;
-		struct io_uring_cqe *cqe =3D &r->cqes[entry & cq_mask];
+		struct io_uring_cqe *cqe =3D &r->cqes[(entry & cq_mask) << cq_shift];
=20
-		seq_printf(m, "%5u: user_data:%llu, res:%d, flag:%x\n",
+		if (!is_cqe32) {
+			seq_printf(m, "%5u: user_data:%llu, res:%d, flag:%x\n",
 			   entry & cq_mask, cqe->user_data, cqe->res,
 			   cqe->flags);
+		} else {
+			seq_printf(m, "%5u: user_data:%llu, res:%d, flag:%x, "
+				"extra1:%llu, extra2:%llu\n",
+				entry & cq_mask, cqe->user_data, cqe->res,
+				cqe->flags, cqe->big_cqe[0], cqe->big_cqe[1]);
+		}
 	}
=20
 	/*
--=20
2.30.2


