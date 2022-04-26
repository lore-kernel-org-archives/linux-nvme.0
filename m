Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7F8C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 18:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sf+7cZhGMKBiHcuOnvVECGvMjvJxKiAQfcMWEmSFo9k=; b=pFOqYDso0Gs4OI0c0Mp40EFrw4
	UyfA6d7IoU7QOWv4zDw/tt8kBSJQplbpYnOYJ1ejvLY2AzPcNMqWo69lJdWh34pwRwCoI5YclLkzK
	8ytpZ2JGv2dD8G1OxPcy4zgdzdYyZE5w+TMCGhhlgmZplWdV8yLVhYcw6cUNAgnxEkUI0Us3xTX8y
	yj8o5+0X9jEEGEEqNxHirifm9fuVOjdgNYSiWKrDXCQaQuU+qUPR2Cbr35zvIGt4veBjXfuKJIpPV
	pZbIYTKJW1dNIK5uzP0euDUub6wQOumL8CKz69oW/SlYeuM9YwK3wK+Qi9SWVs1lIHGR/e5GcL4Gx
	LdsgT0Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njPzS-00FkHO-Cy; Tue, 26 Apr 2022 18:32:46 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njPp5-00Fflu-9R
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 18:22:04 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QGQbnW003467
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 11:22:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=sf+7cZhGMKBiHcuOnvVECGvMjvJxKiAQfcMWEmSFo9k=;
 b=HL3HfkOykyj35rXHIr5Bhn6ZDx0gGTi3GetLmAQhfsIQSgSW2JdbytNPXVTdALL83ByT
 wpwqrtpmg27PBpi3zTITI1P9er6BkhAGldPRgb9zWnmgw4gnzMOdgQqaFiXBMn1B+vQF
 QjlPHqWxE+4EmY+KJdLNPgF5LT+aNzgnzH4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fp6a35cgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 11:22:02 -0700
Received: from twshared14141.02.ash7.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 11:22:01 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
 id 79F67E2E56A0; Tue, 26 Apr 2022 11:21:36 -0700 (PDT)
From: Stefan Roesch <shr@fb.com>
To: <io-uring@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <kernel-team@fb.com>
CC: <shr@fb.com>, <joshi.k@samsung.com>
Subject: [PATCH v4 10/12] io_uring: support CQE32 in /proc info
Date: Tue, 26 Apr 2022 11:21:32 -0700
Message-ID: <20220426182134.136504-11-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426182134.136504-1-shr@fb.com>
References: <20220426182134.136504-1-shr@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: qEcMa0_-p8H7QDlQEGfCxRyh0tA2tqsS
X-Proofpoint-ORIG-GUID: qEcMa0_-p8H7QDlQEGfCxRyh0tA2tqsS
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_05,2022-04-26_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_112203_402518_831959EE 
X-CRM114-Status: GOOD (  18.18  )
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
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
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


