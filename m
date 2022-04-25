Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED845C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Apr 2022 18:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aPxMNXS0jqrJlA0zWdOJ8JDIwfH8wD1AuLJPSvJxgPo=; b=17f4PTOfQU3FDKZDapfuvOafjQ
	yfmCCTIGu3vXY7Gg5eH3yxR6bWQCE1TbG0LQ2TXuf/OCeb/sAB5lEdS0gLX5SdZ1Vdlf9jhA/Wl/N
	hhVjRjvTqek86EuGGlj9xJaYt9ZGdFB/YcHn2GWAAEO6BJImWRoa9ZMUh59/Pk29W5BOy4dK6l0H2
	VhO3IDJL7wRpDFxGwDM+jdmV+uK7IxiASZ96Tz9sB0qNPxoukNxYCPBlETaSo8X7nVC5h3HUr9rQA
	bjtqbx7tDVuFInI4IIqo7Rz0oHqkkgmLvaNCYZmq1JiiczM6gqi0R+eOKZnhwBh4R+MXF1+mWsKmw
	h+sNyqJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nj3QY-00ArJN-7p; Mon, 25 Apr 2022 18:27:14 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nj3PS-00AqhV-NW
 for linux-nvme@lists.infradead.org; Mon, 25 Apr 2022 18:26:07 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PHP3an006596
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:26:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=aPxMNXS0jqrJlA0zWdOJ8JDIwfH8wD1AuLJPSvJxgPo=;
 b=oCgUXuNEr3UenUP7pFQ8PcUmwegVoyGaEJiIAHy22p53vfj/+boGDoFZ7l4WS+WMYZX/
 ApvqI86JqeQAIN/2phbzQjNLoycfdFcieNU3i/2QRdmFVTdFQ9312zzzv8cJGPMQpGFm
 +3YvedEKUg6JnyOClZx/HOqBmkwcjPvIOlg= 
Received: from mail.thefacebook.com ([163.114.132.120])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fmdgfvd61-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 25 Apr 2022 11:26:06 -0700
Received: from twshared4937.07.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Apr 2022 11:26:00 -0700
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
 id 5F86CE1F2A69; Mon, 25 Apr 2022 11:25:41 -0700 (PDT)
From: Stefan Roesch <shr@fb.com>
To: <io-uring@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <kernel-team@fb.com>
CC: <shr@fb.com>, <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 11/12] io_uring: enable CQE32
Date: Mon, 25 Apr 2022 11:25:29 -0700
Message-ID: <20220425182530.2442911-12-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425182530.2442911-1-shr@fb.com>
References: <20220425182530.2442911-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: i_0GTTu5liN3_meYf7NM2D7mTSbVn9Qm
X-Proofpoint-GUID: i_0GTTu5liN3_meYf7NM2D7mTSbVn9Qm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_10,2022-04-25_03,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220425_112606_785873_3A9F6662 
X-CRM114-Status: GOOD (  15.47  )
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


