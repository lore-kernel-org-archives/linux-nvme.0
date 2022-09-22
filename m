Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB2DC54EE9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 15:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iWW/j0eIqi8RQKFious08g0pBgasUN8m6yK62wJwb2o=; b=hvkezRLxLLfKSrAg1ugzWUMXiy
	7Q9qKtqkpadzwgIYQi68YCKCAuXUs118/1KBBpyHDToetR7mmadmYgDAUu4/EBZB+VWiNcBsnazyr
	A2sqv4bsHsDMw9tDsjS3Bsc8Bucg0vpRNNKF7a+jMU9GizKsFAOzNqZKI6KPAIxxkVuQfYYr0GObb
	lNbKDq3xky0Baqm56KQpROn76fQVNnjmeOJg0I1URbvVvnkrMouj8yQPmRixI2saHpJUw9T6egnsm
	YsYcUKtdu/H0ZITG5uH5pFKnxhH2czG/JjGHoTVufvPk8pe2cU6XRgmAohGlOMwgGlMVcSSsPQZeP
	digzScjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obNoa-00GItX-GB; Thu, 22 Sep 2022 15:08:36 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obNaq-00GCWc-1N
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 14:54:28 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28M5R2BS013924
	for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 07:54:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=iWW/j0eIqi8RQKFious08g0pBgasUN8m6yK62wJwb2o=;
 b=rrq9Q3F7wMS8MB1HZ+wj1mZ9DncZjmyn4qwugVZssmphx/wCzW1qp4k9vppRH14FdZHW
 FZoBE97Nd01ojrzbFvXanelOJoAB9t1coHQhJ2RpzzWN04Cqvs79jaWpHHIARgj/lsKS
 VwY1vsZsyWwaMmXQjuYtJe/uNuWmchEdqTc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jrhjgk1yw-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 07:54:20 -0700
Received: from twshared2273.16.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 07:54:18 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 591188E8756C; Thu, 22 Sep 2022 07:54:07 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2] nvme: restrict management ioctls to admin
Date: Thu, 22 Sep 2022 07:54:06 -0700
Message-ID: <20220922145406.594231-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: cG_CglK9sE2VSG6xtKNzuIhwJNIWcGh-
X-Proofpoint-ORIG-GUID: cG_CglK9sE2VSG6xtKNzuIhwJNIWcGh-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_075424_151267_0F6349C0 
X-CRM114-Status: GOOD (  13.67  )
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
these operations, which include resets and rescans, can be disruptive.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:
  Check the user's capability in each case individually.

 drivers/nvme/host/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d3281f87cd6e..a48a79ed5c4c 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -764,11 +764,17 @@ long nvme_dev_ioctl(struct file *file, unsigned int=
 cmd,
 	case NVME_IOCTL_IO_CMD:
 		return nvme_dev_user_cmd(ctrl, argp);
 	case NVME_IOCTL_RESET:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EACCES;
 		dev_warn(ctrl->device, "resetting controller\n");
 		return nvme_reset_ctrl_sync(ctrl);
 	case NVME_IOCTL_SUBSYS_RESET:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EACCES;
 		return nvme_reset_subsystem(ctrl);
 	case NVME_IOCTL_RESCAN:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EACCES;
 		nvme_queue_scan(ctrl);
 		return 0;
 	default:
--=20
2.30.2


