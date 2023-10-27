Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B9FC25B72
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 18:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2MEE7cRzsGfeMnNn2eY3zHEqVKk2sJ/zEGUF3QOFPSY=; b=kgm+ezh5LUb1H10SQiaFeQPUxJ
	mFjCBaNxKPax+CRP/RvYv/1i2kPoQHHNXJ+1h1LhGlhy7bmujDYMv2WKfpmU3CC0ehPoYUZ5uBODk
	V2FUbu0oOrVHn/r+/sRF/ZU63cfQxfBJUQ32s0EpB5O2iOLFHkAoYsPLm1g2lLVPzWzVcinoavzn2
	Yvj9f5Rq3+rFu8WX6XtsujGuSx/3WQvUUelSjyI8isEQyD+9OSjBRA3Ghx52snFX0J0xgmqAOp6tf
	JT9oGTJ9YC78Ik6eYup8pV4PMi8OpDyGU3gncYFeF0hgf8Tu9KXjRPKjpIpa/OXQq7GsoL4zkP4ek
	XK6xxzxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwRRI-00Gw7v-1o;
	Fri, 27 Oct 2023 18:20:08 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwRRD-00Gw4x-1g
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 18:20:04 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RE5bRM006325
	for <linux-nvme@lists.infradead.org>; Fri, 27 Oct 2023 11:20:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=2MEE7cRzsGfeMnNn2eY3zHEqVKk2sJ/zEGUF3QOFPSY=;
 b=KWJuyjy+x/LAlqbRsk/xsVlv18Yc6lOYqXbkvmdkogqh3LaxyJvQCkcCMpkkAL2J+w2q
 Y9iFu8NYxIpFxKbdlN/zh1dOvERifnzPnRiOfuvrmfvz/LvBbdIoOZWI1YPtk0e7tvEb
 UMjsjsYWwfD2ByiMzztD6IGABzDeDLrDuddVlCMGKP0OGEuZ69bdc+74ngUA+guITMC+
 zUNsvzjzeVvz0gKLGDdPjV4fpUAJdRkUc32RM3g97Jq0JlI16DxZ55mBfY+mjpsjyyBB
 4F/QKsDzPFX2BAA2+NGNPcy89nQ7dvnmivsrIgRoNRMl6sQCwHz5ESLi12llCWAB5Dwp TA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u0c4pu421-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 27 Oct 2023 11:20:02 -0700
Received: from twshared9012.02.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 11:20:01 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 837F820D093C8; Fri, 27 Oct 2023 11:19:50 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 4/4] io_uring: remove uring_cmd cookie
Date: Fri, 27 Oct 2023 11:19:29 -0700
Message-ID: <20231027181929.2589937-5-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027181929.2589937-1-kbusch@meta.com>
References: <20231027181929.2589937-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: N5RPGl4gKYiAkrBx5IObTedaMDCEvV-J
X-Proofpoint-ORIG-GUID: N5RPGl4gKYiAkrBx5IObTedaMDCEvV-J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_17,2023-10-27_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_112003_672141_416AFA9C 
X-CRM114-Status: GOOD (  16.33  )
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


