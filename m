Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F848C197A0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 22:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2MEE7cRzsGfeMnNn2eY3zHEqVKk2sJ/zEGUF3QOFPSY=; b=Nu1dUA/r47Fu0ZKPgwyF3GRZ5h
	z6cN1c5ejXQiqHSvkkHR/kn9eyEN5u6Ul3iH2gfpQvlxAi9uko9M71owV2nocqmTKYVpGES37HKRf
	XWUOxWnxnhHDJIl7MU0TVC+SMmwyTMZMzTH6UO7RWtQRxusyk9LUZ3R7SbM7iRx1U9AHtJQDyEuBE
	MLPLdrunQyeJgHPUcV7T9uR0z/iwfNOiypl8RowSOthxzn1pGwIMARSuTbS5XAmbnB4YUasYHMX4c
	IuD26CSjZdBy7u23HKEKIN2SZLefOzWY/MMrieZqX63hEtTuRf++Ck9JIKlRamhgvf/6L7RkoWYEk
	kfWIeMbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Cxt-00Ezqq-12;
	Mon, 20 Nov 2023 22:42:01 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Cxo-00EzpF-35
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 22:41:59 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3AKMSZph013394
	for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 14:41:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=2MEE7cRzsGfeMnNn2eY3zHEqVKk2sJ/zEGUF3QOFPSY=;
 b=Mh+x1TjC4FIzMOsljvj5+lsZG7R5Oek5Hvraj8UoFwSakqsXDb0iy1BGI8oenTp3cZ6t
 F3zTqIFm/IgFz6ArVt777R7CwIIqqow8PwozK+/XCZTiVh6U6MqlyHs/kY0wrriKyrs8
 b5EvbL5rC3/XPV9GgQrzbT2LxP2EOeviPU+4CO9mTFCMyDhUxpZxFNsgk0VdbbE3ulH3
 wlEAeJ7LD/QifQWO/Jzuk2Icc5SFR+LZ+NtFTBUMaa9My5BMSQYorcXP8AZyNxyxL1nu
 T2UhDOeY77MOCp4NYFhfOIESGOx4ZpQ2i0nckJiJ1FKeDNaqYY1lD/FKn0g0LniC/Nwd fg== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3ugbt1ac0d-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 14:41:55 -0800
Received: from twshared32169.15.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:41:11 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 0653321F1B1B4; Mon, 20 Nov 2023 14:40:59 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 5/5] io_uring: remove uring_cmd cookie
Date: Mon, 20 Nov 2023 14:40:58 -0800
Message-ID: <20231120224058.2750705-6-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120224058.2750705-1-kbusch@meta.com>
References: <20231120224058.2750705-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: tRU1O85JndMg-d5IYz7cDR8IRkNUkfmI
X-Proofpoint-ORIG-GUID: tRU1O85JndMg-d5IYz7cDR8IRkNUkfmI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_144157_266971_EF58A9DC 
X-CRM114-Status: GOOD (  15.67  )
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


