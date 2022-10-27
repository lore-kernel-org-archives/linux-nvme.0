Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC7DECAAA1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 16:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JdGDU0Lf047DZGB6qqBRPxoyAi0hNlnMbFVdJTPWWG4=; b=a44s36kgdC1yK3cS2pYbyjLSps
	rjdO7oZmar5Dz5J1Q1APXKxBZxMPJh4Fzyo1KNd0pcfjpzwn6VoQPOglmAysqRbyTqKuXt46YZyvS
	tETB24VMZzsz+m6eyeUt4VPCjvyRuPkxLbCzU52uQf2ZxDeyoH7rkgwUlTLOIEvi9FA2Alk8Pvd9T
	ZqoZ4IxAGuw1o1DOIcV5oC/xOeo4p2DIQ6xtVgD4/HSl+xHZg26e885udb0lXEDTCoswbPxUbvJGY
	q9jdi/2NvIhjZ7V6IyNAkgbzAc0h4TKA5Y+gUX4o0pag/cTopMXSCdvuhCLa7jdaK6gFkPpAQsLp3
	VQJ6XmHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo5KA-00E9uV-OV; Thu, 27 Oct 2022 16:01:42 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo5Ji-00E9bi-8p
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 16:01:19 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221027160108euoutp028b8d6678c5fc4f7229ac99240465c3ae~h_GlkMiHM2948529485euoutp02Q
	for <linux-nvme@lists.infradead.org>; Thu, 27 Oct 2022 16:01:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221027160108euoutp028b8d6678c5fc4f7229ac99240465c3ae~h_GlkMiHM2948529485euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1666886468;
	bh=JdGDU0Lf047DZGB6qqBRPxoyAi0hNlnMbFVdJTPWWG4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=qPEl+4QG0J1Da9v/Bl5t4N0t5fnNYeBwNBJUQ8ZV4bd/rEZmRR4W2zZGfHIDvUsSS
	 A87kPWW+BdOPjE52peUKUix0CfAxX9RbFTSZ6xa2DhOKeWStYcubgI/tuQd29fQ3U9
	 n+wxG2GnaREwFuWFz5Abb8ZAyfh32znREgWr6Tvo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221027160108eucas1p105543cf1b76db714008467c64e1b85fb~h_GlazSPC3121431214eucas1p1z;
	Thu, 27 Oct 2022 16:01:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id B0.89.29727.44BAA536; Thu, 27
	Oct 2022 17:01:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221027160108eucas1p223383fc27ba0a27a38f7b768c562a1ed~h_Gk-OraW0379303793eucas1p2j;
	Thu, 27 Oct 2022 16:01:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221027160107eusmtrp1c785a25f56f42d887f016da15417f78f~h_Gk9Xfm72493524935eusmtrp1W;
	Thu, 27 Oct 2022 16:01:07 +0000 (GMT)
X-AuditID: cbfec7f2-21dff7000001741f-1e-635aab449b4c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id A8.B7.07473.34BAA536; Thu, 27
	Oct 2022 17:01:07 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221027160107eusmtip26e4e481e82b0e4a85bb9bb99d4000909~h_Gkzk_t31597815978eusmtip2U;
	Thu, 27 Oct 2022 16:01:07 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 27 Oct 2022 17:01:02 +0100
From: Joel Granados <j.granados@samsung.com>
To: <kbusch@kernel.org>, <sagi@grimberg.me>, <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>,
	<joshi.k@samsung.com>, <javier.gonz@samsung.com>, <p.raghav@samsung.com>,
	Joel Granados <j.granados@samsung.com>
Subject: [RFC 1/3] nvme: Return -ENOMEM when kzalloc fails
Date: Thu, 27 Oct 2022 17:57:22 +0200
Message-ID: <20221027155724.1161670-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221027155724.1161670-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7djPc7ouq6OSDa7fk7RYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRXDYpqTmZZalF+nYJXBkbphxm
	K5jFVnF+Y0QD4xzWLkZODgkBE4n+mQvYuhi5OIQEVjBKvNh+gxnC+cIocaL5ESOE85lR4t6p
	04wwLS3bp7KB2EICyxklln6whCu6/2s/1KzNjBJ9GyaALWET0JE4/+YOM4gtImApMeHNfxaQ
	ImaBTYwStzYuY+pi5OAQFrCSmLaSE6SGRUBVYvuRk+wgNq+ArcTmJ/eZITbLS7Rdn84IUs4p
	YCfRcd4cokRQ4uTMJywgNjNQSfPW2cwQtoTEwRcvoFoVJbbM+Q71c63E3uYD7CAnSAhc4JDo
	OLiMDSLhItH1fSs7hC0s8er4FihbRuL05B4WCDtbYueUXVBDCyRmnQSFBAeQbS3RdyYHwnSU
	6OzzgjD5JG68FYS4hk9i0rbpzBBhXomONqEJjCqzkNw/C8n9s5Dcv4CReRWjeGppcW56arFh
	Xmq5XnFibnFpXrpecn7uJkZg+jj97/inHYxzX33UO8TIxMF4iFGCg1lJhPfsjfBkId6UxMqq
	1KL8+KLSnNTiQ4zSHCxK4rxsM7SShQTSE0tSs1NTC1KLYLJMHJxSDUwqa39+W8Yh8+924dF5
	DY6lMpu/Bl/9taTV456f4Br/6mv655X8C+XOHZezfj73f5pL54X5qmunbOs9tHvNu+Oem669
	yLLbPnvVi8uK/5svbOXv2/umvDVq66Itevwbv5y42Jzw/KfINPmW6Wn6lUuncZzc+Fiu52uo
	uqCC5n/dfbVsfXcuTH5ttVBR+o/j4QuO17KCV5+uDZ4jZd76ojbu0OoVhZolOqVRf1dMZs4z
	ubpOd49yR0BzZYbkvOOM380DrDmss97Yxfpz3Qx4mvp9yaOVr7ft9LxdLDFR3bkiPepTZomB
	8aaKt17ZXqvYrVsO6UhERtQWzmi8uzKRxXft1MCZZU/0vylpV6YKclgqsRRnJBpqMRcVJwIA
	TvGNNI4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7rOq6OSDSbesbBYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRejZF+aUlqQoZ+cUltkrRhhZG
	eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkbphxmK5jFVnF+Y0QD4xzWLkZODgkB
	E4mW7VPZuhi5OIQEljJKLFi1iRkiISPx6cpHdghbWOLPtS6ooo+MEntuv2eEcDYzSky4fYQF
	pIpNQEfi/Js7YN0iApYSE978ZwEpYhbYxChxa+Mypi5GDg5hASuJaSs5QWpYBFQlth85CbaB
	V8BWYvOT+1Cb5SXark9nBCnnFLCT6DhvDhIWAir5MWkDM0S5oMTJmU/A1jIDlTdvnc0MYUtI
	HHzxAmqMosSWOd+hvqyV6Hx1mm0Co8gsJO2zkLTPQtK+gJF5FaNIamlxbnpusaFecWJucWle
	ul5yfu4mRmCMbTv2c/MOxnmvPuodYmTiYDzEKMHBrCTCe/ZGeLIQb0piZVVqUX58UWlOavEh
	RlOgNycyS4km5wOjPK8k3tDMwNTQxMzSwNTSzFhJnNezoCNRSCA9sSQ1OzW1ILUIpo+Jg1Oq
	gcno3//Wf4JMisqsr5Y0NF9QsdbQ8ly6/hTnwkhVS/sj0W+jG5ZpCzadcdu+enNWJb/jf0Vp
	vuV/P8/6+0qLQWuSwE/LlS/SXv6bzrtR7+ufH28fcLW/OlXEWl9Y7/nqfeS/qOBS5pi6dyKn
	BP8typE7z1Dm/6unfSn38VVrdz29Z1l5SH/RFRejvf96bB6caE0t1Vgad76wpFJv1Z/MF4z7
	G9933ORqYP/McjSl6+UOR6vjb8pP20ZXiR9cVHJj75I1y++acUy/dPD/rZxKg2w9+bn3GKdL
	31lWUTvR5WYM45L1hY3ZNVcWvZitwbqpaI7J9OkzdzWJZirJWEdm+sy380+67HI9bfOpmH/B
	TyYrsRRnJBpqMRcVJwIA1pZiazoDAAA=
X-CMS-MailID: 20221027160108eucas1p223383fc27ba0a27a38f7b768c562a1ed
X-Msg-Generator: CA
X-RootMTR: 20221027160108eucas1p223383fc27ba0a27a38f7b768c562a1ed
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221027160108eucas1p223383fc27ba0a27a38f7b768c562a1ed
References: <20221027155724.1161670-1-j.granados@samsung.com>
	<CGME20221027160108eucas1p223383fc27ba0a27a38f7b768c562a1ed@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_090114_621257_40AF68D1 
X-CRM114-Status: GOOD (  12.71  )
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

In nvme_init_non_mdts_limits function we were returning 0 when kzalloc
failed. This patch corrects this behavior and return -ENOMEM
Fixes: 5befc7c26e5a ("nvme: implement non-mdts command limits")

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 059737c1a2c1..7dbf221247f7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3050,7 +3050,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id)
-		return 0;
+		return -ENOMEM;
 
 	c.identify.opcode = nvme_admin_identify;
 	c.identify.cns = NVME_ID_CNS_CS_CTRL;
-- 
2.30.2


