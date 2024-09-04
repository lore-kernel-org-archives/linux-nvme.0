Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACA8CD4F3E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 21:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nwV6EtZE3bh8Ik5sy4ohQoMbL2R1JeH4gFJYKYxyYic=; b=ZO9dwPOaf3w4ZD7Dpvzfu/K4jy
	NWELWiipMVP7dWhh7A26UQa3t5mQcRoq+JK3Gj4N3D2m419p7puOOV+jlWgDC/tW3dAGRNhcSW3KD
	CGYYsg/+Ub3mkHfM2j5/f4//gkKYwASq2mXVVzjTmFbg//Hf9kL9zj0/2Xom1s1dMJseCWbqbuZfi
	ktMLsrA40ikfjQq0KYI+EqmViuoaL4nOIrAPSgFB4qyKLuwp+hJqSDLmmn+u2IHfe5azQkybKOlja
	cMj4T+QKi0HyB8EWGNdO5Skbt21KY54n0q2JATLoBZ4vER6Boh1JETIivsB0KnVeBLzZ88lTSXqEH
	lm0a0Q7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slxx9-00000006B1h-1RW1;
	Wed, 04 Sep 2024 21:54:15 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slxx5-00000006B0f-2wX6
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 21:54:13 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484LeMNB009027
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 14:54:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=nwV
	6EtZE3bh8Ik5sy4ohQoMbL2R1JeH4gFJYKYxyYic=; b=VVjunz+CZdAUg8Dhfnu
	wIca80YD7DHnbybg3clUGdnbGrMoFtS6MjuYsbV3gh+/tAG3RrY9IzUs9DeWztc9
	zb05y+G5L7Ii1kvDR2WGU/0eeO6MqUjEqk2QF4LpbrKS+4FxdG07kI/RZDTT9TaW
	eaR03JAE+sD7QW6ZvxO9lhKgYZ17+duh4ttzGs94dIq+xjO1j+6q2aNFlA86kdd0
	TYv5475jlm8xOilqYxuQcAptjlQqUzz49nQA9jsVVup3WdVVsTE7FPnQq14QqTIn
	949/KBeLe3ma+Yh6V0E+rrqUbJagsLXb4U1xuaK0H+LRrY1EFUK/DKfSjjzGFY89
	J1g==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41emyp4jk6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 14:54:10 -0700 (PDT)
Received: from twshared10900.35.frc1.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 21:54:08 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 6785E12A371AA; Wed,  4 Sep 2024 14:54:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: remove CC register read-back during enabling
Date: Wed, 4 Sep 2024 14:54:05 -0700
Message-ID: <20240904215405.1980512-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Ut6O0yE0BDbDzFoiGsy9dw9DQLyFUADt
X-Proofpoint-ORIG-GUID: Ut6O0yE0BDbDzFoiGsy9dw9DQLyFUADt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_19,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_145411_853373_5E386B0C 
X-CRM114-Status: GOOD (  12.74  )
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

Any non-posted read should flush the previous write, so we don't
necessarily need to read back the value we just wrote. I've found at
least some controllers that respond with 0 for short moments after
writing the CC register with EN (enable) cleared, so the read-back is
overwriting our valid ctrl_config value and ends up breaking on the
subsequent enabling.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 983909a600adb..3172d7dab43bb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2467,11 +2467,6 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
=20
-	/* Flush write to device (required if transport is PCI) */
-	ret =3D ctrl->ops->reg_read32(ctrl, NVME_REG_CC, &ctrl->ctrl_config);
-	if (ret)
-		return ret;
-
 	/* CAP value may change after initial CC write */
 	ret =3D ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
 	if (ret)
--=20
2.43.5


