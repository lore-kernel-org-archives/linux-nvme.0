Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D1A3EB64DC
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lBoy3YZfXX+1xkjVJTII1JcIE++cDJmqouXMfn8sabo=; b=BMeYZj91OLsDLvC4ejgBgAOy2r
	w/DmwaNlOaONII19CSIWBORR7GdmhnBqOPz9fF2bFFBt/JQTW22znfAU6naBo4DToYhf1d5+GTctB
	e1Q5QOebwEp92DqoRrIim7XthH17KQH+EIMR3hDKxbwzoRSAPsV7h1cbLCNNdvylgqqWxdsmxQ9jd
	4G5OP3gMHe21GiqQAzN4GI1M0XtgPIZdwOMd1Ldl4BqAe8G9pYoTovy05Kvfz/j7yZV5xpBBxyT9H
	q4qLmy43tGBazKNcdl9kSme7eZ7kK/66EyeAiwjILZsJqluOHYHHl00TY+0phVnKmUeQlQE0IptNJ
	7NZWi3/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWcl-00Fun4-1N;
	Wed, 28 Jun 2023 14:58:27 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEWcj-00FumP-0o
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 14:58:26 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SA4dkw016376
	for <linux-nvme@lists.infradead.org>; Wed, 28 Jun 2023 07:58:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=lBoy3YZfXX+1xkjVJTII1JcIE++cDJmqouXMfn8sabo=;
 b=E47uu154dJJ2jMsr6wz96LPZNfW2wy7/KHoxIcIs0whCa1PIAQXCQ7J8Xo9TZ2m0rCwu
 oLhBerO45n3HQrNyZDIZRz5WZaSdC3dXu8POIqRsuDWlXR3o1L71mBEKhz6z/eNGhca4
 a+TNAan17y2kE5qrY4UO3KpAsVDUSckE3OVXyqf37KKN+qJwRUATSzucw//VUH7rmKi7
 Z9n9p6IjiA7KzZvK15Ai8TygfhPLAXlm71y4X4J0TPxr/MpIiYLub3lgwz5qmdgdTtug
 rtOGbhERUIIDTSqJ8tmQAsjZIytapsYreZehIJ+jrAEiOcsKU55vR4XKlpxMJuqvUg7D PQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rgaf7nkmd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 28 Jun 2023 07:58:23 -0700
Received: from twshared37136.03.ash8.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 07:58:22 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id E5C6F1AC9AB40; Wed, 28 Jun 2023 07:58:14 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
        <ming.lei@redhat.com>
CC: <brookxu.cn@gmail.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/3] nvme: disable controller on reset state failure
Date: Wed, 28 Jun 2023 07:58:14 -0700
Message-ID: <20230628145814.1068653-3-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628145814.1068653-1-kbusch@meta.com>
References: <20230628145814.1068653-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VEFuRc413bn2CcwAQw-TkRA63t5BKLSd
X-Proofpoint-GUID: VEFuRc413bn2CcwAQw-TkRA63t5BKLSd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_10,2023-06-27_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_075825_448285_3E82AB7E 
X-CRM114-Status: GOOD (  16.72  )
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

If the controller is not in a RESETTING state at the point of reset
work, we have to conclude the controller is being deleted. Go to the
cleanup on this condition to ensure proper pairing of request_queue
quiesce state.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bfeadecf9e15b..c9224d39195e5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2690,7 +2690,8 @@ static void nvme_reset_work(struct work_struct *wor=
k)
 	if (dev->ctrl.state !=3D NVME_CTRL_RESETTING) {
 		dev_warn(dev->ctrl.device, "ctrl state %d is not RESETTING\n",
 			 dev->ctrl.state);
-		return;
+		result =3D -ENODEV;
+		goto out;
 	}
=20
 	/*
--=20
2.34.1


