Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F40C46CA7
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 22:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CtCSQu7SBwAU5RA4TEPV6ClvLhwUfelUCahho9yo6No=; b=Y73eVaMxONg84QTXh+9bEiZ/NR
	kBLIW3dsIXg9GcuuT/zl7Z3PueRW6k0FLAi8lZqdncxt9RjIMjoK6KEKOJ+khnbYelP4jH4tgcdOU
	M3+SvuUGM5RrjW8AORrNePi3ySz1/aQsg3uPAqWVSuDjsM9PLq1iGsZqkzINIsYSxpeDATnQKnAGt
	amq7IKc59ChREIGUD9tjewuJ06qu9WBucl/A+pRnyQx3rrff59JyQXokRIyjMinEdkCGUBM40HDtK
	QnAT7UPBDTJOSCyKJi2u997KbgtjGqkj2GveIBAilvQhGpxi63E0EqoocGsuKLLXmVDQ90XGTe121
	miIG72rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r86Yw-006UDa-0l;
	Tue, 28 Nov 2023 22:28:14 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r86Yt-006UCY-1g
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 22:28:12 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3ASMGMft014696
	for <linux-nvme@lists.infradead.org>; Tue, 28 Nov 2023 14:28:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=CtCSQu7SBwAU5RA4TEPV6ClvLhwUfelUCahho9yo6No=;
 b=kFSWOWNNg1c2o2i3LDqJ/HRlQmRdwjTjFZqxvar/dMbXbEJfwKcMCi5R1+9Piq9tM6BR
 ltUQZ/r2SKuLUG7BOT4yhbTSSphf0U2DEIWAu/z1pr+2j5FPpIdrHSJV1PQKo2Mvopsj
 6FYcVsfOndIb1BJdPRs4hdNoaIWWCoFIVj/p8npN/u9s2w/wrCKzuCeWFriitqdy67Vh
 FKRE8sYp/JaxC6moIxgQr5NRF8xnENL/YScEhCyyOHW6EDMg9UhYWQMKT/o0KHsOvFz4
 xhq4RWLGmFrVgVCAdKpjYxvCYHNBczGPCIkARNFSIPQequuvuU8vUCZhz5LlRPQ1mlyg xQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3unf81cty6-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 28 Nov 2023 14:28:10 -0800
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:28:05 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 7316C2252F0CC; Tue, 28 Nov 2023 14:27:54 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, <ming.lei@redhat.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 4/4] io_uring: remove uring_cmd cookie
Date: Tue, 28 Nov 2023 14:27:52 -0800
Message-ID: <20231128222752.1767344-5-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128222752.1767344-1-kbusch@meta.com>
References: <20231128222752.1767344-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: YW1lwTjt1C5itrEGDgzWw4EtazVeQa1-
X-Proofpoint-ORIG-GUID: YW1lwTjt1C5itrEGDgzWw4EtazVeQa1-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_24,2023-11-27_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_142811_670908_B1497101 
X-CRM114-Status: GOOD (  16.04  )
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


