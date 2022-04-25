Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E79C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Apr 2022 18:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qjQT4TdGjYQP+fFIUJysux2Jl90fDRSvqrS2tPCEO04=; b=srx44bBHt1WjKPpnUyAjtvjEWy
	QVANpz8s4whVPfmafUZ0T8AIdgzT+Vq8nTZMTYR8sZZv/LpIr6HofyYjrYhg2xYZziM2AgsPJ+1U8
	BmedZVqSyDLnWcDZTvqgrguP+uuZ5WxlKEUNg2iyoZ4eLuFB5dmmE7UEZVjK3QFTyi2qrnEOCXL5S
	H/dJqVutoXsAWRd93AyVvOKSSDJqJZEpiznjsvueAmgEzKTLG81VCPfyT3nboHG2vRZeHDfPRDMMH
	y4Fd76Ib6Y7wht8jfBgezzIItLwZNdxQI6b7JRL67G63L1UAOL88H/Yt2xfA6TLt8RWoqwTaMXHu+
	26nrqwVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nj3QG-00Ar9O-7j; Mon, 25 Apr 2022 18:26:56 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nj3PQ-00Aqff-Ml
 for linux-nvme@lists.infradead.org; Mon, 25 Apr 2022 18:26:06 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 23PHP6pR021949
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:26:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=qjQT4TdGjYQP+fFIUJysux2Jl90fDRSvqrS2tPCEO04=;
 b=GDhEtA7GXgSc2FOdMQgDbfj1EIqUdKPmt08O9c+9BMMVvyNLtSkwcr/GLi/YghbYdcEV
 pPHd43t8PDXhIlvQYTAu9fTsibrI/XCfHM4sSKL4GtrWy3rPsTAgnS5B0xUm/hsB1PyU
 HWnUiGNUabHFT3Akl6SxhCy9EJivLORc3TY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by m0001303.ppops.net (PPS) with ESMTPS id 3fmd4rmab3-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:26:03 -0700
Received: from twshared16483.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 11:26:02 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
 id 3E5E8E1F2A5F; Mon, 25 Apr 2022 11:25:41 -0700 (PDT)
From: Stefan Roesch <shr@fb.com>
To: <io-uring@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <kernel-team@fb.com>
CC: <shr@fb.com>, <joshi.k@samsung.com>
Subject: [PATCH v3 06/12] io_uring: modify io_get_cqe for CQE32
Date: Mon, 25 Apr 2022 11:25:24 -0700
Message-ID: <20220425182530.2442911-7-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425182530.2442911-1-shr@fb.com>
References: <20220425182530.2442911-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3_elJ17a7p7_CRrfkOWZSH8Z86tqyP_c
X-Proofpoint-GUID: 3_elJ17a7p7_CRrfkOWZSH8Z86tqyP_c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220425_112604_891734_83309AB8 
X-CRM114-Status: GOOD (  18.33  )
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

Modify accesses to the CQE array to take large CQE's into account. The
index needs to be shifted by one for large CQE's.

Signed-off-by: Stefan Roesch <shr@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f300130fd9f0..726238dc65dc 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1909,8 +1909,12 @@ static noinline struct io_uring_cqe *__io_get_cqe(=
struct io_ring_ctx *ctx)
 {
 	struct io_rings *rings =3D ctx->rings;
 	unsigned int off =3D ctx->cached_cq_tail & (ctx->cq_entries - 1);
+	unsigned int shift =3D 0;
 	unsigned int free, queued, len;
=20
+	if (ctx->flags & IORING_SETUP_CQE32)
+		shift =3D 1;
+
 	/* userspace may cheat modifying the tail, be safe and do min */
 	queued =3D min(__io_cqring_events(ctx), ctx->cq_entries);
 	free =3D ctx->cq_entries - queued;
@@ -1922,15 +1926,26 @@ static noinline struct io_uring_cqe *__io_get_cqe=
(struct io_ring_ctx *ctx)
 	ctx->cached_cq_tail++;
 	ctx->cqe_cached =3D &rings->cqes[off];
 	ctx->cqe_sentinel =3D ctx->cqe_cached + len;
-	return ctx->cqe_cached++;
+	ctx->cqe_cached++;
+	return &rings->cqes[off << shift];
 }
=20
 static inline struct io_uring_cqe *io_get_cqe(struct io_ring_ctx *ctx)
 {
 	if (likely(ctx->cqe_cached < ctx->cqe_sentinel)) {
+		struct io_uring_cqe *cqe =3D ctx->cqe_cached;
+
+		if (ctx->flags & IORING_SETUP_CQE32) {
+			unsigned int off =3D ctx->cqe_cached - ctx->rings->cqes;
+
+			cqe +=3D off;
+		}
+
 		ctx->cached_cq_tail++;
-		return ctx->cqe_cached++;
+		ctx->cqe_cached++;
+		return cqe;
 	}
+
 	return __io_get_cqe(ctx);
 }
=20
--=20
2.30.2


