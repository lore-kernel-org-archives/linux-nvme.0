Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DE0CDB465
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 23:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nixF1y6B0gHE1SsfORYh58tyf8DkdCMVjyZE3C/vDIU=; b=ezjtumvPJxMyB0qg/xcMmHZeRO
	j6kaZTLY6sE4Dt356cN6j7nHZe0OnKS2OpFt8XZWDekmtra7nz7IJ98y1HyG+LiRsWMupoJT586hf
	5uTDqzQb4LuaSh+w+7Y0CbtewcvzVFNcw9Co1DEuTcklBL5Xa2X9xPJC7Vo3lvg4vlg1UyRXugKcy
	pAxKxqpfIhTkdHpNkQe997oSE75Qai08XrO0j+3x5O14WwCM19q26CyBPPf4s0D2NbcqMBGudwN49
	m0Sa9117dxHM7fp/1zZ1w6H/YfKr7CfP3SJzxS1yfGSUlCQHsywQdtOCSBI3Fo166Qkvopm0l83ys
	0CN0oTHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsWfy-00Anmg-0V;
	Mon, 16 Oct 2023 23:07:06 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsWfv-00Anlo-0R
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 23:07:04 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GMfEJW032691
	for <linux-nvme@lists.infradead.org>; Mon, 16 Oct 2023 16:07:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=nixF1y6B0gHE1SsfORYh58tyf8DkdCMVjyZE3C/vDIU=;
 b=c4pixI9DlvihdRss5lbSOpT4x0d6ng77zdn8vTgUc12pInaK8ZufFpOtLDyUdBPRqQDF
 skeRvYCcO0z/rgZ0aDlYtlYtIGahNOlQRKV9OYmHaYpvH/WBZsLEHSaV4yz5JgfHRqBj
 PLK6EwmJ7QzCfQxYgM56EoGhLZ5AYdI8+p3TkR8cUlBN0ulx72EIfAJxh6KSQEjVWKgA
 rbJwkjTPrBOsVxjfyIULmVZ167bc4NinzFvCgKMec3Xved0qrIlOmm0pxXNpWMUpVtFJ
 ezxjitWLRqz7m5N88z31JLxnGm0RZojpCnG891D3nngkaiZ6WkLyqy4TzmDaBxt4oNVH PA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tsbx8135v-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 16 Oct 2023 16:07:00 -0700
Received: from twshared15247.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 16 Oct 2023 16:06:59 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 000E4204A247D; Mon, 16 Oct 2023 16:06:28 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>
CC: <sagi@grimberg.me>, <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2] nvme: sanitize metadata bounce buffer for reads
Date: Mon, 16 Oct 2023 16:06:25 -0700
Message-ID: <20231016230625.3792823-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zQkyhHmaxjMEQCq6EgO4dO-KOCyTxakN
X-Proofpoint-ORIG-GUID: zQkyhHmaxjMEQCq6EgO4dO-KOCyTxakN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_160703_393768_18EF07AC 
X-CRM114-Status: GOOD (  15.88  )
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

User can request more metadata bytes than the device will write. Ensure
kernel buffer is initialized so we are not leaking unsanitized memory on
the completion's copy-out.

Fixes: 0b7f1f26f95a51a ("nvme: use the block layer for userspace passthro=
ugh metadata")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  correctly split data direction handling (axboe)

 drivers/nvme/host/ioctl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 788b36e7915ab..eb2ef3e149614 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -36,9 +36,13 @@ static void *nvme_add_user_metadata(struct request *re=
q, void __user *ubuf,
 	if (!buf)
 		goto out;
=20
-	ret =3D -EFAULT;
-	if ((req_op(req) =3D=3D REQ_OP_DRV_OUT) && copy_from_user(buf, ubuf, le=
n))
-		goto out_free_meta;
+	if (req_op(req) =3D=3D REQ_OP_DRV_OUT) {
+		ret =3D -EFAULT;
+		if (copy_from_user(buf, ubuf, len))
+			goto out_free_meta;
+	} else {
+		memset(buf, 0, len);
+	}
=20
 	bip =3D bio_integrity_alloc(bio, GFP_KERNEL, 1);
 	if (IS_ERR(bip)) {
--=20
2.34.1


