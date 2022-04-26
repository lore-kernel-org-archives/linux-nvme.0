Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C964EC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Apr 2022 18:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uBdzkvaCLmn9yKhjHEXYQLl+RFSjNoMs4ahMQdDpwec=; b=sS+S/NlYu7yw3P3QWizhyOrrxw
	AvZfnarJ4UOAbPxFGV0gNTIP8dgKzBMYnD/MDqKnq8IcuE3Jr1H5Z9tIVf7zIX4RdoqC5kLaBj8V6
	V0ALduQO9M2EDDid80tsmHKavcjtfUKdpdPM70qDfyDNLlwTF+garv8dF4qzkKf25ULRXbbJsb0AT
	5SP2Gyzhfc9qVc5cLfeTgQA+kMiTVy+cF098TC5ia45qs3pmZwuMtmC04rm1RuZQx+IRiCYUF48CP
	8abULhNZfkW5Tos4zeKf2MbLPInfZKKgS4qqHP9WIaDQ2t0MpE1oQJrfcpz3biKd1Rw5VvhwlBinB
	YUUiMaOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njQ1P-00Fl0R-My; Tue, 26 Apr 2022 18:34:47 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njPpc-00Fg1i-2W
 for linux-nvme@lists.infradead.org; Tue, 26 Apr 2022 18:22:38 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
 by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 23QGQSge018712
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 11:22:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=uBdzkvaCLmn9yKhjHEXYQLl+RFSjNoMs4ahMQdDpwec=;
 b=N/30elj8ZNOErAs+22zzoA/IcVCRU6lBBD7XZOGYMwINWVTPSvT0zQlyRWth5XDHwM96
 TsdBERB6alf3eE7U9dDflYWltWJRYZzB95B722MsTt3h+e6JMe/Iaehzey+vsmXAxDL0
 kWDPkNTOpX5fGG3m1lbmILC27sWbz7AtFB0= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by m0001303.ppops.net (PPS) with ESMTPS id 3fmd4rv7n5-10
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 26 Apr 2022 11:22:35 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub202.TheFacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 11:22:30 -0700
Received: from twshared41237.03.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 11:21:55 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
 id 7FDA5E2E56A2; Tue, 26 Apr 2022 11:21:36 -0700 (PDT)
From: Stefan Roesch <shr@fb.com>
To: <io-uring@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <kernel-team@fb.com>
CC: <shr@fb.com>, <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 11/12] io_uring: enable CQE32
Date: Tue, 26 Apr 2022 11:21:33 -0700
Message-ID: <20220426182134.136504-12-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426182134.136504-1-shr@fb.com>
References: <20220426182134.136504-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VQL1vbtUrnsBJug20AtdRFLhwNrOvH-Y
X-Proofpoint-GUID: VQL1vbtUrnsBJug20AtdRFLhwNrOvH-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-26_05,2022-04-26_02,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_112236_299151_188A8D26 
X-CRM114-Status: GOOD (  15.35  )
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

This enables large CQE's in the uring setup.

Co-developed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Stefan Roesch <shr@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e1b84204b0ab..caeddcf8a61c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -11752,7 +11752,7 @@ static long io_uring_setup(u32 entries, struct io=
_uring_params __user *params)
 			IORING_SETUP_SQ_AFF | IORING_SETUP_CQSIZE |
 			IORING_SETUP_CLAMP | IORING_SETUP_ATTACH_WQ |
 			IORING_SETUP_R_DISABLED | IORING_SETUP_SUBMIT_ALL |
-			IORING_SETUP_SQE128))
+			IORING_SETUP_SQE128 | IORING_SETUP_CQE32))
 		return -EINVAL;
=20
 	return  io_uring_create(entries, &p, params);
--=20
2.30.2


