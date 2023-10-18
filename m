Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC67ECDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 15:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a+CBAEnmZsjKkElSI8KyeZYdLbO9F0M1lGnJEP99RWs=; b=JwIg2xv0qNM7vOH2yPgGxGROkV
	6xOMzhLH6Q63zrGPON9j99jgZOadoyLYgiatuNvNGLlyvjuvRHUtTrafrBwTO8rRplbnGn0vfChx8
	AX4lAVLzWSBs+N7VwzY4W6ke/IXUTQ7NrTOWLlHm+cW8mEizhtv3AkXx6AFTlAFHDm8udxlbTfyD2
	bXOioZiBvYYXz8AZ+dlFOnBWmugjcvf4YKA7e8+SmQJNcv3E5+JgLNw2j4pYKjEzsMihbGVEqQooS
	v4ChgILnU+l5PP0wGloc1TumGnx6m9eu9jUPH5X1LpGCUCi1v9xV+znUPpWuDpqUoUFI4/1NadZw9
	Qz08sW1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qt8Pg-00F28g-0j;
	Wed, 18 Oct 2023 15:24:48 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qt8Pc-00F26l-32
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 15:24:46 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 39I84NIV015181
	for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 08:24:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=a+CBAEnmZsjKkElSI8KyeZYdLbO9F0M1lGnJEP99RWs=;
 b=N8CshzJ9Eq9BIS21Znz+dzoSBoCZigVCBULa8imL7wj00d7+P2QvPQcEJfhBbfsrsCrE
 KFdAQE11y/uTPNNfMYhJk6wciRVGJkPeLZVYBeUXUMLqIRNZ0bz3yjExy+MfL77IPt8P
 azeGX1r9d/H3wtR4xaxG4w3EQOgzGxsuvwmsQtPCKwgFlMG6+sRS7EAjxS6cAOmWw822
 eTP3oAjZcDvyVmL+urGvSDXmNOZtVkxECdaNgtqXVbR8O/+nWgbKpcONcpbema0SvdkP
 a7mQQJPcAY/pchvwuEuuD0SS3ZA1XEQ3hB8tR6WzpvsljCxLQBU+qsO880MCvypb7P7d eA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3ttbhatctk-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 08:24:44 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 18 Oct 2023 08:24:32 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 90DE9205F440F; Wed, 18 Oct 2023 08:24:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 4/4] io_uring: remove uring_cmd cookie
Date: Wed, 18 Oct 2023 08:18:43 -0700
Message-ID: <20231018151843.3542335-5-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018151843.3542335-1-kbusch@meta.com>
References: <20231018151843.3542335-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: YQeUrRshfyP5VWtbiQb4mdZKTCZvHecn
X-Proofpoint-ORIG-GUID: YQeUrRshfyP5VWtbiQb4mdZKTCZvHecn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_13,2023-10-18_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_082445_097051_EDFE0DC4 
X-CRM114-Status: GOOD (  17.34  )
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
index 106cdc55ff3bd..30d3db4bc61a7 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -25,12 +25,8 @@ enum io_uring_cmd_flags {
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
index 537795fddc87d..56f3ef8206057 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -133,7 +133,6 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int i=
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


