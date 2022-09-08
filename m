Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEADC54EE9
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Sep 2022 21:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6HkgPoUm80hlWKiejuU5qYXh57HFasqRtl7tp0vRaAE=; b=dXffL0RIZ/CeFF4t84F0A3522R
	Q0AoncKq9BIaNMn0oZl+oQe0rInFzjLUiE5Bt5W4qt8V4APoXDWXXl6OK2MHi3xWJKHSpcgqGfCAy
	C5s4X2Ym00qiOE17yhGf+XyjR+WpuVdZ4UweKuNqwFVeXJdGyaAMsBa4HWxymMRAuBzDIBE4wCLro
	hGG2+8Q3Lvm964ModK5yLqGTxPlbLByW9fangIpt2ep4DYJbKPZoayZX/UI6vqd+4QPTjc+dgR20B
	8Lrr9PDIXSp4NFidchO/fz/sOtlfhrNvfYnxPrDaVsiXbpWWwU7K23c2wEPvexjqGl0rr3KBk4VgZ
	gfgYNZVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWPBH-0091ng-LU; Thu, 08 Sep 2022 21:35:27 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWPBF-0091mv-Cp
	for linux-nvme@lists.infradead.org; Thu, 08 Sep 2022 21:35:26 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288LHDXF010698
	for <linux-nvme@lists.infradead.org>; Thu, 8 Sep 2022 14:35:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=6HkgPoUm80hlWKiejuU5qYXh57HFasqRtl7tp0vRaAE=;
 b=cKnGcxlY+tikH0PWF0fIVn2zo5b+7KCO7XkPJUJTSJJJKJcBVn9fkdfrCXiDxprK3V0B
 cGAefLruJgYIZH/GogOSABiqQCP2MuQYzkahWnQvvfcFnChqFyJGIIUd9fKz2Ro0v3Yb
 Mc7eZjf80N37xNM4yYHokHfP/4IInMN9mPU= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jfq2p0mms-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 08 Sep 2022 14:35:22 -0700
Received: from twshared47013.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 14:35:21 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id A2DA385FF612; Thu,  8 Sep 2022 14:35:18 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: restrict management ioctls to admin
Date: Thu, 8 Sep 2022 14:35:17 -0700
Message-ID: <20220908213517.3085323-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: wzQSJ3a0TBhi8jyf1oyvwiEVeNUH6JIC
X-Proofpoint-ORIG-GUID: wzQSJ3a0TBhi8jyf1oyvwiEVeNUH6JIC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220908_143525_467950_A4DC0D84 
X-CRM114-Status: GOOD (  14.69  )
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

The passthrough commands already have this restriction, but the other
operations do not. Require the same capabilities for all users as all of
these operations can be disruptive.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 27614bee7380..d23978e993c6 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -749,6 +749,9 @@ long nvme_dev_ioctl(struct file *file, unsigned int c=
md,
 	struct nvme_ctrl *ctrl =3D file->private_data;
 	void __user *argp =3D (void __user *)arg;
=20
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
 		return nvme_user_cmd(ctrl, NULL, argp);
--=20
2.30.2


