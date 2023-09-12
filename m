Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7554EE3F3B
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 21:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u/LH4gi68m/neg/ZVmZdtGqE7LFTa54emxaCDyVD81I=; b=v1ToM2IStcGQD19/Alfb+3lRfv
	OgtM9AnQhSiJH2FXnW07twsLjR3zZPRyWvG83M4Ov2Tf9jwmEYqrTp3FcoTE56jvh/9mrLTBLbIVX
	dfZpo4lQlPPcGlR+Y3sBo0lTS0d9R8AXki6jvYxH5xaTOAfgfmNCNtCa3w+T848P4TH1fJhRoe3y0
	DNPIfGZVTz1XagorHT9QZO/ib+yxX0nzVCCpN7jPvC0uugZiP/lVkYeuOWoL5jnjZek5cfCqWd4iu
	JW1uQHYp+w+D3Uvo2SSoS7sYvhXsUDEkIyzRHN795HzFjGLQokQCgZnTw3KNkOd0POc7SWsjp53lE
	Jjdb/OMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgBFK-0049d2-26;
	Tue, 12 Sep 2023 21:48:34 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgBFG-0049cb-1D
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 21:48:32 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38CKgUQi017546
	for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 14:48:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=u/LH4gi68m/neg/ZVmZdtGqE7LFTa54emxaCDyVD81I=;
 b=ToKI+OmDSsUZ7bhfdcInHLTcieduyZbp5mNTsu4wJ847Mwy/zzhoPSvbImCgRTaM/0/7
 dWJLS6LV0ZlD8rP5LvdzIN+nRCQvd7fv3wDXHUpVps9iw/vRmsDxNLynJbIhT04YtoFg
 +84V6WqiykvzGshOHM4LA7Xqk3KmXljCbFEppyPfm6mZ9CCSy5qHdCqQkZ0ueXWj+q07
 yXU1HT9j948V23klJqBTB3OlEUr4OdACQkjTV4z/dCK9Njl6Ryt6IyG2JWZ0V2AEAHnw
 fEXg9yi8s31KMD09BEi6p8N2glb+cuUfZuqLId3pfzuq2+FKgxpG+2isaPKkpvUtBgMG AQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3t2y8u0k4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 14:48:28 -0700
Received: from twshared19625.39.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 12 Sep 2023 14:48:27 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id DDB531E90F185; Tue, 12 Sep 2023 14:48:04 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        =?UTF-8?q?Cl=C3=A1udio=20Sampaio?= <patola@gmail.com>,
        Felix Yan
	<felixonmars@archlinux.org>, <stable@vger.kernel.org>
Subject: [PATCH] nvme: avoid bogus CRTO values
Date: Tue, 12 Sep 2023 14:47:33 -0700
Message-ID: <20230912214733.3178956-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-Proofpoint-GUID: 1iV69WEGPMCKUu6wVdxXi9xOE6UjmsyA
X-Proofpoint-ORIG-GUID: 1iV69WEGPMCKUu6wVdxXi9xOE6UjmsyA
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_21,2023-09-05_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_144830_652112_D74FB579 
X-CRM114-Status: GOOD (  20.77  )
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

Some devices are reporting controller ready mode support, but return 0
for CRTO. These devices require a much higher time to ready than that,
so they are failing to initialize after the driver starter preferring
that value over CAP.TO.

The spec requires that CAP.TO match the appropritate CRTO value, or be
set to 0xff if CRTO is larger than that. This means that CAP.TO can be
used to validate if CRTO is reliable, and provides an appropriate
fallback for setting the timeout value if not. Use whichever is larger.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217863
Reported-by: Cl=C3=A1udio Sampaio <patola@gmail.com>
Reported-by: Felix Yan <felixonmars@archlinux.org>
Based-on-a-patch-by: Felix Yan <felixonmars@archlinux.org>
Cc: stable@vger.kernel.org
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 48 ++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37b6fa7466620..4adc0b2f12f1e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2245,25 +2245,8 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	else
 		ctrl->ctrl_config =3D NVME_CC_CSS_NVM;
=20
-	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
-		u32 crto;
-
-		ret =3D ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
-		if (ret) {
-			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
-				ret);
-			return ret;
-		}
-
-		if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
-			ctrl->ctrl_config |=3D NVME_CC_CRIME;
-			timeout =3D NVME_CRTO_CRIMT(crto);
-		} else {
-			timeout =3D NVME_CRTO_CRWMT(crto);
-		}
-	} else {
-		timeout =3D NVME_CAP_TIMEOUT(ctrl->cap);
-	}
+	if (ctrl->cap & NVME_CAP_CRMS_CRWMS && ctrl->cap & NVME_CAP_CRMS_CRIMS)
+		ctrl->ctrl_config |=3D NVME_CC_CRIME;
=20
 	ctrl->ctrl_config |=3D (NVME_CTRL_PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
 	ctrl->ctrl_config |=3D NVME_CC_AMS_RR | NVME_CC_SHN_NONE;
@@ -2277,6 +2260,33 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
=20
+	/* CAP value may change after initial CC write */
+	ret =3D ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
+	if (ret)
+		return ret;
+
+	timeout =3D NVME_CAP_TIMEOUT(ctrl->cap);
+	if (ctrl->cap & NVME_CAP_CRMS_CRWMS) {
+		u32 crto;
+
+		ret =3D ctrl->ops->reg_read32(ctrl, NVME_REG_CRTO, &crto);
+		if (ret) {
+			dev_err(ctrl->device, "Reading CRTO failed (%d)\n",
+				ret);
+			return ret;
+		}
+
+		/*
+		 * CRTO should always be greater or equal to CAP.TO, but some
+		 * devices are known to get this wrong. Use the larger of the
+		 * two values.
+		 */
+		if (ctrl->ctrl_config & NVME_CC_CRIME)
+			timeout =3D max(timeout, NVME_CRTO_CRIMT(crto));
+		else
+			timeout =3D max(timeout, NVME_CRTO_CRWMT(crto));
+	}
+
 	ctrl->ctrl_config |=3D NVME_CC_ENABLE;
 	ret =3D ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
--=20
2.34.1


