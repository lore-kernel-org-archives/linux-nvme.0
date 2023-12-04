Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22112C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 17:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1qv0DoiKmoyUZa14a5LG+bbxmqPFPFQcDu/E68ZKoZ0=; b=CzrfgE0agIC9fyYeVxPqNlvRws
	igtTF9EHMNUMPcOQsfNtkeBuM5YjDPM6AXknphUoroS25oU2ZjEEYXYVtWTnngLWnsWDy4CV0PjRd
	edzqhfcXFdhWrwpB2U+rd3hVr1TA6YApX8OGyvjJ4awG4r24YFT9S1Ptm+Kzz3umO8DPZJVkk8AGq
	+PPw/SzVHjZkCVw7kaK5WnnKie1EPoUJZmQe9WT94YfT+jmsmDznOj+xfLgMvAHntTft6+vvj2qiA
	pp9oOXrZbk9wTDE0yMPgXGD+pW8RgnEGSUNHg1gSdP1KG+JFpM2N5HoMXfL/P9wpYsz3op8PzCX5N
	sVab2n6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAD8u-005EoD-2N;
	Mon, 04 Dec 2023 17:54:04 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAD8r-005EnW-1Q
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 17:54:03 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4Ha6mV021386
	for <linux-nvme@lists.infradead.org>; Mon, 4 Dec 2023 09:53:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=1qv0DoiKmoyUZa14a5LG+bbxmqPFPFQcDu/E68ZKoZ0=;
 b=n33naqaOCnd95KyhpQzW8L01VE32dSqjsSsOoqWq0uEuOn/5V9ah/2gvQ58tAdP8pneK
 ZEicv1dQ9N4c/EHD5rLf3HU60tFTuZf/yMcvihOmp/eGXxkcA3fiQH5qsSSFvl5xrQNz
 FLAWZ7nxWQIbZNtmTw1J9AMMaDIyF3uqkhuVunX7wgtAzXk0Qwwgl0+6mIeG/paF0NRx
 rX17XNC9XqvctGUxxgrQxpybuY4/dL038egScjBR6847MGcdKDxf6Vg6wixzTCZ2fMVY
 CAYqQ597Y29PX/7k9v+gCM6RMJrHoWMaa9Tw7hC0q5b7JoE7+Qf+xiNnGbDeMRDq0Jbq yg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3use4j2n3f-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 09:53:58 -0800
Received: from twshared22605.07.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 4 Dec 2023 09:53:57 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id EE937229B6E9B; Mon,  4 Dec 2023 09:53:48 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <asml.silence@gmail.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme: use uring_cmd sys_admin flag
Date: Mon, 4 Dec 2023 09:53:42 -0800
Message-ID: <20231204175342.3418422-2-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204175342.3418422-1-kbusch@meta.com>
References: <20231204175342.3418422-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: IUnA55Fyjhhp2PB0Incj-k7YywVo9YvX
X-Proofpoint-ORIG-GUID: IUnA55Fyjhhp2PB0Incj-k7YywVo9YvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_17,2023-12-04_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_095401_848095_16FA83DF 
X-CRM114-Status: GOOD (  17.80  )
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

The nvme passthrough interface through io_uring is intended to be fast, s=
o we
should avoid calling capable() every io. Checking other permission first =
helped
reduce this overhead, but it's still called for many commands.

Use the new uring_cmd sys admin issue_flag to see if we can skip
additional checks. The ioctl path won't be able to use this
optimization, but that wasn't considered a fast path anyway.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 6c5ae820bc0fc..83c0a1170505c 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -11,6 +11,7 @@
 enum {
 	NVME_IOCTL_VEC		=3D (1 << 0),
 	NVME_IOCTL_PARTITION	=3D (1 << 1),
+	NVME_IOCTL_SYS_ADMIN	=3D (1 << 2),
 };
=20
 static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
@@ -18,6 +19,9 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct=
 nvme_command *c,
 {
 	u32 effects;
=20
+	if (flags & NVME_IOCTL_SYS_ADMIN)
+		return true;
+
 	/*
 	 * Do not allow unprivileged passthrough on partitions, as that allows =
an
 	 * escape from the containment of the partition.
@@ -445,7 +449,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
 	struct request *req;
 	blk_opf_t rq_flags =3D REQ_ALLOC_CACHE;
 	blk_mq_req_flags_t blk_flags =3D 0;
-	int ret;
+	int ret, flags =3D 0;
=20
 	c.common.opcode =3D READ_ONCE(cmd->opcode);
 	c.common.flags =3D READ_ONCE(cmd->flags);
@@ -468,7 +472,11 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl,=
 struct nvme_ns *ns,
 	c.common.cdw14 =3D cpu_to_le32(READ_ONCE(cmd->cdw14));
 	c.common.cdw15 =3D cpu_to_le32(READ_ONCE(cmd->cdw15));
=20
-	if (!nvme_cmd_allowed(ns, &c, 0, ioucmd->file->f_mode & FMODE_WRITE))
+	if (issue_flags & IO_URING_F_SYS_ADMIN)
+		flags |=3D NVME_IOCTL_SYS_ADMIN;
+
+	if (!nvme_cmd_allowed(ns, &c, flags,
+			      ioucmd->file->f_mode & FMODE_WRITE))
 		return -EACCES;
=20
 	d.metadata =3D READ_ONCE(cmd->metadata);
--=20
2.34.1


