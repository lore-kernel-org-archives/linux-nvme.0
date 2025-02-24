Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61862C021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 18:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=snOUfdVBnPynElSc1XBsa3nS712vYvPexin3S6+od1c=; b=wSDbzB2d1f1B3gMpVyTOOtaGqF
	thxvINn8MYjyECGNsLpNZZrawO49q55WL8jLgs0x9V2q9fDq43ntew+ivs5b2JOZyAazpZsWcMNWU
	SKfDzchvjmTRpOJwe9Gept6wOsXTmdIZpRUsxLXLoI6Tf3Fum0JA/Iiqd8hzV6reFZHRs4NH2apWR
	55A0vkyTkYgm5DsRIRAs+hC84S/+i9xiYB5yC0soCTGIJ0M+JXHhvSPHXnUNR5ZhQL6yTG+bAUDti
	sPQb5R5oS42BuHEnXsJAee17ePx5Lw7ZO8DBF/tC5U3ShJOvrXyq07NYHcVr4huwxFG8i1vbX/IJR
	nd4PQQPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmdFm-0000000Eol2-2iYS;
	Mon, 24 Feb 2025 18:32:30 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd5N-0000000Emf5-3Eak
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 18:21:46 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OFDGTK000601
	for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 10:21:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=snOUfdVBnPynElSc1XBsa3nS712vYvPexin3S6+od1c=; b=Pm7/WCy2UEjZ
	jgUtAsx12GwGwwwWQDujr+O0gNL++GHleWN5tlsd+c3+qEwVyJ3zYUWHktEryO6u
	p+Ki2lvUVJoF/+RpGm0jI8gY5ruOLY9rfHFdqTC94RoO9EfMPVbKWMhDquxE0Fos
	mDnincrBPbWTLdqkd+Y8pppRt2HDHb1UyUjRgBu0Md6dMOG2lo6F1WiYv0BX5bfD
	R9lPsJp6JThV+eBEynuzI19ojqcMSe/U93P+Dv9Em5SdT5e2bOkeKAKurYNK+82R
	UwklDQRWIpLWN3bv+o5lB+006qL5nPZQIN6TycBBs9wKaP3ymmXR+0vSv/6xtVf7
	0ziIVE2nUg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 450tt7hunv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 10:21:45 -0800 (PST)
Received: from twshared32179.32.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 24 Feb 2025 18:21:36 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id C532F18678FB7; Mon, 24 Feb 2025 10:21:29 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/6] nvme-ioctl: fold 'vec' into flags
Date: Mon, 24 Feb 2025 10:21:25 -0800
Message-ID: <20250224182128.2042061-4-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250224182128.2042061-1-kbusch@meta.com>
References: <20250224182128.2042061-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zdKnlU4dyZc2kTj9sF36RklXs1yjzYmB
X-Proofpoint-ORIG-GUID: zdKnlU4dyZc2kTj9sF36RklXs1yjzYmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_102145_814080_E84C701D 
X-CRM114-Status: GOOD (  11.19  )
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

The vec indicator is already a flag and used as such, so use that type
instead of implicitly relying on a bool to happen to align to the enum
value.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index f1233a280d3b3..3da014ccbe550 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -455,7 +455,8 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struc=
t request *req,
 }
=20
 static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-		struct io_uring_cmd *ioucmd, unsigned int issue_flags, bool vec)
+		struct io_uring_cmd *ioucmd, unsigned int issue_flags,
+		unsigned int flags)
 {
 	struct nvme_uring_cmd_pdu *pdu =3D nvme_uring_cmd_pdu(ioucmd);
 	const struct nvme_uring_cmd *cmd =3D io_uring_sqe_cmd(ioucmd->sqe);
@@ -465,7 +466,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
 	struct request *req;
 	blk_opf_t rq_flags =3D REQ_ALLOC_CACHE;
 	blk_mq_req_flags_t blk_flags =3D 0;
-	unsigned int flags =3D 0;
 	int ret;
=20
 	c.common.opcode =3D READ_ONCE(cmd->opcode);
@@ -514,7 +514,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
=20
 	if (d.addr && d.data_len) {
 		ret =3D nvme_map_user_request(req, d.addr, d.data_len, d.metadata,
-					    d.metadata_len, ioucmd, vec);
+					    d.metadata_len, ioucmd, flags);
 		if (ret)
 			return ret;
 	}
@@ -651,10 +651,11 @@ static int nvme_ns_uring_cmd(struct nvme_ns *ns, st=
ruct io_uring_cmd *ioucmd,
=20
 	switch (ioucmd->cmd_op) {
 	case NVME_URING_CMD_IO:
-		ret =3D nvme_uring_cmd_io(ctrl, ns, ioucmd, issue_flags, false);
+		ret =3D nvme_uring_cmd_io(ctrl, ns, ioucmd, issue_flags, 0);
 		break;
 	case NVME_URING_CMD_IO_VEC:
-		ret =3D nvme_uring_cmd_io(ctrl, ns, ioucmd, issue_flags, true);
+		ret =3D nvme_uring_cmd_io(ctrl, ns, ioucmd, issue_flags,
+					NVME_IOCTL_VEC);
 		break;
 	default:
 		ret =3D -ENOTTY;
@@ -793,10 +794,11 @@ int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd,=
 unsigned int issue_flags)
=20
 	switch (ioucmd->cmd_op) {
 	case NVME_URING_CMD_ADMIN:
-		ret =3D nvme_uring_cmd_io(ctrl, NULL, ioucmd, issue_flags, false);
+		ret =3D nvme_uring_cmd_io(ctrl, NULL, ioucmd, issue_flags, 0);
 		break;
 	case NVME_URING_CMD_ADMIN_VEC:
-		ret =3D nvme_uring_cmd_io(ctrl, NULL, ioucmd, issue_flags, true);
+		ret =3D nvme_uring_cmd_io(ctrl, NULL, ioucmd, issue_flags,
+					NVME_IOCTL_VEC);
 		break;
 	default:
 		ret =3D -ENOTTY;
--=20
2.43.5


