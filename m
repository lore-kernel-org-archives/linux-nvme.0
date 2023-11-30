Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70605C4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Nov 2023 21:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gu7+KNmQ+XAgxD1FjreRoODLoAYKWRez/g+5c1+UaXA=; b=WGoBdxdvrzsSTGDeowwJyWphOi
	Ex24zGKLWZRiCH3VwziYksonWrAq3L7nAreCytOnnNZpTOSJZdx3m869CY9r+1z8IorzL7pWUIWjv
	bL9L2+VoH8gN6M53HvKAUAonvwnHg5szA0CyEZkcT1pVF0js6Rrs6egK4qQ5R5auZNu0AVw2q2t2U
	iv9Ml1JM/nykF31zGLEAENuxkfSDrRqISV8Y4eFvIivRzCPZrY4VDnpKJg3w9E8T/wQlapjzbAuDM
	+6qZ4yfCtjqc2U4GgdYwn1EeXAIxwX2+AQ5OBjq5SjSglIR78TZoNERXONWqdHsDAG5rqRxWfXsrY
	8BEWnkNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8oyG-00BzOi-00;
	Thu, 30 Nov 2023 21:53:20 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8oyC-00BzOI-1D
	for linux-nvme@lists.infradead.org;
	Thu, 30 Nov 2023 21:53:18 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AULJC1v021472
	for <linux-nvme@lists.infradead.org>; Thu, 30 Nov 2023 13:53:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=Gu7+KNmQ+XAgxD1FjreRoODLoAYKWRez/g+5c1+UaXA=;
 b=eQkaGhyQQOLyco7sBP/Cf340kzWk1WyszAHKyHGlSRXD3Q/s08WYUI7jmipMxxIGosP1
 +hpu8VxQ4Ds2yzfwyKUpn4sN0KE0pQtsuCz0zbPEHu2jfwCG89GQVnW/oSi9bGWIHUcP
 hh6k1cPBCki+e0qdQSafqOz9ZsPTXSFccBYjWrozN350K3Qb/h9kkbvUOUYjrlGg1G7d
 FHAgTzG2GtHSOthMGG1kcmWKZGWVEh0Ed5veKccgXfyIzh+UQapE999bAsCLOot6OV2X
 AV5GNhNlfaC5YYTXnjSbF0NczH4jXij1PA6/5lnOuFQHt2ho8ZNxSF63dD4c3PtIJyMP ew== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3uphu86vnn-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 30 Nov 2023 13:53:14 -0800
Received: from twshared6844.02.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 13:53:13 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 884DD226BF68B; Thu, 30 Nov 2023 13:53:10 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, <ming.lei@redhat.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 4/4] io_uring: remove uring_cmd cookie
Date: Thu, 30 Nov 2023 13:53:09 -0800
Message-ID: <20231130215309.2923568-5-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130215309.2923568-1-kbusch@meta.com>
References: <20231130215309.2923568-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: r21xoMFLaQwRRwoacozWypS59p-471YA
X-Proofpoint-ORIG-GUID: r21xoMFLaQwRRwoacozWypS59p-471YA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_22,2023-11-30_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231130_135316_441042_E6EAA408 
X-CRM114-Status: GOOD (  16.34  )
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

From: Keith Busch <kbusch@kernel.org>

No more users of this field.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/io_uring.h | 8 ++------
 io_uring/uring_cmd.c     | 1 -
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index fe23bf88f86fa..9e6ce6d4ab51f 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -32,12 +32,8 @@ enum io_uring_cmd_flags {
 struct io_uring_cmd {
 	struct file	*file;
 	const struct io_uring_sqe *sqe;
-	union {
-		/* callback to defer completions to task context */
-		void (*task_work_cb)(struct io_uring_cmd *cmd, unsigned);
-		/* used for polled completion */
-		void *cookie;
-	};
+	/* callback to defer completions to task context */
+	void (*task_work_cb)(struct io_uring_cmd *cmd, unsigned);
 	u32		cmd_op;
 	u32		flags;
 	u8		pdu[32]; /* available inline for free use */
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index acbc2924ecd21..b39ec25c36bc3 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -182,7 +182,6 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int i=
ssue_flags)
 			return -EOPNOTSUPP;
 		issue_flags |=3D IO_URING_F_IOPOLL;
 		req->iopoll_completed =3D 0;
-		WRITE_ONCE(ioucmd->cookie, NULL);
 	}
=20
 	ret =3D file->f_op->uring_cmd(ioucmd, issue_flags);
--=20
2.34.1


