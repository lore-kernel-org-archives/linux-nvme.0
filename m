Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EB3C6FD1D
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 19:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OUahnU2vQF7v2u8mdfu+tv4js0n8ogHNDJ3QjG1WFzs=; b=zJjgHS9Wq3/V3zpTCRK3823J0F
	JCSuJ/EG/hND6+2h8ieMmslg7Ix+yNcxqUiUE5/W1OM+2BtbtRE1YJNyvA6pEed0aM7u+rJ3Z526M
	VnYEbmIe7I1wHV86MWaM9/Vk1NkxC66sqoYUUaJ3jBR0G+6COBefzTlABFLb7KV393pHxx8pNU+xW
	8q7xvF3D6ymDnFYRhZWj7kAtKFDcphYlzAQxNf4WdfnHwtea4ipXessEA6vFDVcAGWuq/Ir2vkXzW
	29O1AM8+XqFw9mMtL7/ccWPfc8zZtUHy48MD5/CnX88zf4xBo1PF4CKWwvrJjbk2KgrwfBw7xvGo+
	+TgoQwrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkra7-00AxLI-0f;
	Fri, 07 Apr 2023 19:17:07 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkra3-00AxJW-23
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 19:17:04 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337GhjMc000804
	for <linux-nvme@lists.infradead.org>; Fri, 7 Apr 2023 12:17:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=OUahnU2vQF7v2u8mdfu+tv4js0n8ogHNDJ3QjG1WFzs=;
 b=M09D4pjBtkENGGsAcvpvv5MsN+ic1NkADHSeasf5TJsmgU64TGEq10veYT5dnaIOWddh
 sxTrhwYhr3icf3iGxRecM6j/xfIy+htS/zIIGurWplAvqMtobpyAQ0EHTohX7kdXnmUn
 VtJl0IAi+Bnd7cjKuGEyURoAFibYz3oG3bBdGCG5a7uAZpzHFsyYUHq/QRCKWXdaMad4
 s9r3gvg+cKTXGE3pGIi2mOWfwt/S+IFPqDtkoKaLGF2M35acRdskWJ9lE0XZPbR0UV/L
 ZmvbbgQ3FaLj8VikP+IY6C+cxhCBYpbGaY6xHAPrG8fGjwedxPaN84wQH2GspF3Dk+C2 pA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3psyun981b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 07 Apr 2023 12:17:03 -0700
Received: from twshared15216.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 7 Apr 2023 12:17:02 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id CC8D1157B5F8C; Fri,  7 Apr 2023 12:16:48 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <io-uring@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>
CC: <sagi@grimberg.me>, <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 5/5] io_uring: remove uring_cmd cookie
Date: Fri, 7 Apr 2023 12:16:36 -0700
Message-ID: <20230407191636.2631046-6-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407191636.2631046-1-kbusch@meta.com>
References: <20230407191636.2631046-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: cjYkZEhOgK_DY1v40UYGLViuNA68MWS_
X-Proofpoint-ORIG-GUID: cjYkZEhOgK_DY1v40UYGLViuNA68MWS_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_12,2023-04-06_03,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_121703_676679_B72BA2B6 
X-CRM114-Status: GOOD (  15.72  )
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

No users of this field anymore, so remove it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/io_uring.h | 8 ++------
 io_uring/uring_cmd.c     | 1 -
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index 35b9328ca3352..235307bf6a072 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -25,12 +25,8 @@ enum io_uring_cmd_flags {
 struct io_uring_cmd {
 	struct file	*file;
 	const void	*cmd;
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
index f7a96bc76ea13..94586f691984c 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -127,7 +127,6 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int i=
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


