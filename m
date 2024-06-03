Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761D8C25B78
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 23:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8rDoOZSB8zD1s4PE1bgGnGX+FK0D4ijkDneNUNzad0Q=; b=PQAT9ZWS0L6/V1kKQNRZ3uIkj9
	iQVczstbpgSVill9lCysfHpYXEVBGwJovJ8CFdvtv2YMOxoeJ3Og4WTQmFQlIDozWUJ7nBUigm639
	RwcebRABg9X6zDEZQoT6fK76OxG1hX6CjorN4T/GsK+QdmV9MbaIr85zPaVZIHAJeHs0Qnt0d6bte
	kDF+mhrDs6T/Xm67ObyFOQVC+30G865zT0uyR3ujEDmC7OUysQ97Ff9CtcUvmFoxbJICd/0mXW2lA
	I3+8duBivkSuPISMY4w0WDky2h8mMhwxUCrv2rVuD9SW+TGE40lwIo4CNy88obTE2M/iESK9rLZoe
	amebi87g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEGkL-00000000a5y-3sUL;
	Mon, 03 Jun 2024 23:05:45 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEGkJ-00000000a55-0ZeD
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 23:05:44 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453N1kt4027143
	for <linux-nvme@lists.infradead.org>; Mon, 3 Jun 2024 16:05:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=8rDoOZSB8zD1s4PE1bgGnGX+FK0D4ijkDneNUNzad0Q=;
 b=Aae7zfATGU02nNYc4YNF7c2CEVcT65wiHrXfp5a47KuOBxs0A9wyeqZeWbR3zgDYhhZs
 WtCuzWdlLYgIo5aGyEpwIuMHKgriofRJMTM14zHvp/auCcrBSlQ5qH576TQyhR6GmNJE
 2X9Jotto0G6mnaOmkq+zVirDPztx6OYZsF9CCSuLSUotylBUfEQhxPjMR5OvxALDgkz+
 DwoO/DPDmMG6mOPLzYM0uzXCHLKMP6wHpb+XJA5Dl3d3Nbhacts2Xjep9nwc+jZ8F6mD
 ShKWPMvM9ArzIhtO++tZgIhChE8cPDqDSpr1JbKLPq/MuVMHJzKhmre7ihL7gXgzgn7y lw== 
Received: from mail.thefacebook.com ([163.114.134.6])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yhq5180qe-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 03 Jun 2024 16:05:40 -0700
Received: from twshared10578.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 3 Jun 2024 23:05:29 +0000
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id D2CAA3481EB7; Mon,  3 Jun 2024 16:05:25 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <mlombard@redhat.com>, <hare@suse.de>,
        <shinichiro.kawasaki@wdc.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH-RFC 1/5] nvme: apple: fix device reference counting
Date: Mon, 3 Jun 2024 16:05:19 -0700
Message-ID: <20240603230524.3854115-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603230524.3854115-1-kbusch@meta.com>
References: <20240603230524.3854115-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: eT108OuHCk3Vv7pl8-jvYFGY8mUjoZ6b
X-Proofpoint-ORIG-GUID: eT108OuHCk3Vv7pl8-jvYFGY8mUjoZ6b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_160543_408806_608AF4C4 
X-CRM114-Status: GOOD (  17.39  )
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

Drivers must call nvme_uninit_ctrl after a successful nvme_init_ctrl.
Split the allocation side out to make the error handling boundary easier
to navigate. The apple driver had been doing this wrong, leaking the
controller device memory on a tagset failure.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/apple.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index dd6ec0865141a..b6ac8a1630b2b 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1388,7 +1388,7 @@ static void devm_apple_nvme_mempool_destroy(void *d=
ata)
 	mempool_destroy(data);
 }
=20
-static int apple_nvme_probe(struct platform_device *pdev)
+static struct apple_nvme *apple_nvme_alloc(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
 	struct apple_nvme *anv;
@@ -1396,7 +1396,7 @@ static int apple_nvme_probe(struct platform_device =
*pdev)
=20
 	anv =3D devm_kzalloc(dev, sizeof(*anv), GFP_KERNEL);
 	if (!anv)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
=20
 	anv->dev =3D get_device(dev);
 	anv->adminq.is_adminq =3D true;
@@ -1516,10 +1516,25 @@ static int apple_nvme_probe(struct platform_devic=
e *pdev)
 		goto put_dev;
 	}
=20
+	return anv;
+put_dev:
+	put_device(anv->dev);
+	return ERR_PTR(ret);
+}
+
+static int apple_nvme_probe(struct platform_device *pdev)
+{
+	struct apple_nvme *anv;
+	int ret;
+
+	anv =3D apple_nvme_alloc(pdev);
+	if (IS_ERR(anv))
+		return PTR_ERR(anv);
+
 	anv->ctrl.admin_q =3D blk_mq_alloc_queue(&anv->admin_tagset, NULL, NULL=
);
 	if (IS_ERR(anv->ctrl.admin_q)) {
 		ret =3D -ENOMEM;
-		goto put_dev;
+		goto out_uninit_ctrl;
 	}
=20
 	nvme_reset_ctrl(&anv->ctrl);
@@ -1527,8 +1542,9 @@ static int apple_nvme_probe(struct platform_device =
*pdev)
=20
 	return 0;
=20
-put_dev:
-	put_device(anv->dev);
+out_uninit_ctrl:
+	nvme_uninit_ctrl(&dev->ctrl);
+	nvme_put_ctrl(&dev->ctrl);
 	return ret;
 }
=20
--=20
2.43.0


