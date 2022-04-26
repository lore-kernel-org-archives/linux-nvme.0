Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995D6C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 18:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RMg/pdGI137a+LXXuDX7KRZzylRtIXCVtW7Xo6wCy4Q=; b=QZmX6pqnEBFULGrK2pgkzmEfX6
	Y1n4EH9HaFVy830/RiO3+/KzUnxOz5A9328kZEn7+ucT298v5ztvDX+iuds1BBYEREvWFoa9fZiIu
	SydGae8uZRY/rA6M11h5Z3wZkG04EzOQuCBGXwdxoTL1KlsdyS26yHWDyNZnTXtWr7waoTdfayThu
	CcQJ8QX+swtumhC4susD954PCaZYi0PkKM3n7YCP3ux1RlXx0Hs16+EcYmVZM0lqTBeNOyQLSOYOB
	OFg2QTT2s+p+Fe5oJg46kKLe5vIeKA9ndDluVOenM3srrtg03NABa7X1hHJxLuAt+mnRlB70qmX2W
	CTRHLftg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njPwr-00FjEy-Je; Tue, 26 Apr 2022 18:30:05 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njPoy-00Ffho-LH
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 18:21:58 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QGQSXC024604
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 11:21:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=RMg/pdGI137a+LXXuDX7KRZzylRtIXCVtW7Xo6wCy4Q=;
 b=ft/0omjhz+rKtOMGxOgk9R++qLcuJqrkyf1PRgStjoaxNHOTIFS7X9CAUTiFqxiIHnSA
 sPkDNXfx7rI/QGt6q81qkrB5UfzSM3Mj8W2tNBRHKTLF+dk0DKjMC1GbYuXLUMIn7Tcp
 bI90EP8XvfmUJ8Zoi6299U2+1LLGH7wQoIU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fn1ge0d8v-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 11:21:56 -0700
Received: from twshared39027.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 11:21:54 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
 id 68D55E2E569A; Tue, 26 Apr 2022 11:21:36 -0700 (PDT)
From: Stefan Roesch <shr@fb.com>
To: <io-uring@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <kernel-team@fb.com>
CC: <shr@fb.com>, <joshi.k@samsung.com>
Subject: [PATCH v4 07/12] io_uring: flush completions for CQE32
Date: Tue, 26 Apr 2022 11:21:29 -0700
Message-ID: <20220426182134.136504-8-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426182134.136504-1-shr@fb.com>
References: <20220426182134.136504-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9bobOg7QOvSD_J8tTMVcd_MF_casiFRc
X-Proofpoint-GUID: 9bobOg7QOvSD_J8tTMVcd_MF_casiFRc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_05,2022-04-26_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_112156_752398_70E84CA9 
X-CRM114-Status: GOOD (  16.59  )
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
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
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


