Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550C1C54E41
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 14:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wsZU1colcU8zKU07BYfpdG3aGjtjr1iWQbZBq/u/k8Q=; b=wMyfVMfkwpbTSuDRuMAn+wQjXy
	2DEAfCZAbnC4clmP3GGNgnqYpWOb2x3fACaqrAjxcoc4XYqt/Lgkl7Ga0ZBT+tp36LvG2MOnrXtpR
	DCFEVKRk1azCx0eYosMZfunXXlYpsDCr1lUgtm3X5FQ0t1VzVcI2qk/kLhHWbZoQz3oJWpsQUGnZj
	kNYCU0ykgAwTGPFpqK2I4+ztq0fHe8i4eTLfNRcu6PlxSOddsjfgU5h9TfFbKxbyGg9Ru6XVXKB1X
	xSZyGWu8Tc3S8MKzSBHnJbsCD09SKJxyZ5gBKwwVFxBR/RjVNeC6Ahh1cHqxxpZAHui34Uhr0eWwD
	srBXqReQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhsDB-00000000Yz4-49WC;
	Wed, 06 Mar 2024 14:25:37 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhsD9-00000000Ywe-0OzR
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 14:25:36 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 426DRH4J028471
	for <linux-nvme@lists.infradead.org>; Wed, 6 Mar 2024 06:25:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=wsZU1colcU8zKU07BYfpdG3aGjtjr1iWQbZBq/u/k8Q=;
 b=lS+MLI6jCgcSw4XdcSU+hfeBkLYPAt4E2B2hl7Miz6FnzX8z7U7kbMA3rFoSww1FdV4y
 Iv632gDz9DHYs8A/rvDMrLW5dt0gqMBVk4RcfsZcN9QQzHRJkudjhMiFlRI60FSvXbuR
 OiiGtg+VK6PFw0V1Phvv0PaimMD3JGgSZg2jNu0h6CZ9/vQYhBAbP5+VyoZRwjS1+gnw
 3dt5rnumFXmAdldE0KHll700K4OgkPtQ38e8GuUEalsE2UvFosw2XfwLMIwUXagCoOF6
 R6kKN28bL5e2CF7M1SlCPYbu2QRWTcBvOC/uMNhCtu9xwky5C27sojJq+F+8uMdbi74Z 6A== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3wpg79jnq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 06 Mar 2024 06:25:32 -0800
Received: from twshared11801.09.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 06:25:30 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 3D4F225DE9171; Wed,  6 Mar 2024 06:25:23 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <shinichiro.kawasaki@wdc.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH] nvme: clear caller pointer on identify failure
Date: Wed, 6 Mar 2024 06:25:19 -0800
Message-ID: <20240306142519.1213814-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0zTAOadXMkg5x2c2cgt0bcn-bZpsal1d
X-Proofpoint-ORIG-GUID: 0zTAOadXMkg5x2c2cgt0bcn-bZpsal1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_09,2024-03-05_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240306_062535_262405_0A0C73C5 
X-CRM114-Status: GOOD (  15.59  )
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

The memory allocated for the identifification is freed on failure. Set
it to NULL so the caller doesn't have a pointer to that freed address.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c4d928585ce35..2baf5786a92fe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1403,8 +1403,10 @@ static int nvme_identify_ctrl(struct nvme_ctrl *de=
v, struct nvme_id_ctrl **id)
=20
 	error =3D nvme_submit_sync_cmd(dev->admin_q, &c, *id,
 			sizeof(struct nvme_id_ctrl));
-	if (error)
+	if (error) {
 		kfree(*id);
+		*id =3D NULL;
+	}
 	return error;
 }
=20
@@ -1533,6 +1535,7 @@ int nvme_identify_ns(struct nvme_ctrl *ctrl, unsign=
ed nsid,
 	if (error) {
 		dev_warn(ctrl->device, "Identify namespace failed (%d)\n", error);
 		kfree(*id);
+		*id =3D NULL;
 	}
 	return error;
 }
--=20
2.34.1


