Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC15C27C54
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mFhCe4DOU2WAROF9cUCSDc3/RD+V687u+vWLh/EiTJ0=; b=v1PahckAZ7j8cdQycfaNrjSLwb
	S/bCWvsiOkhagO7cyJFW87vJVe/nY34GCJZ6dv6Y59sEFJXekrMpwjpVk+xNXrAU9CNyVjT6QIFcS
	yMylZXFyFYpDTFH8IBjZGH2RkJyYzuZr9hYaXPYghn9yi1ue3ABy3rVO/+atJIHW+ndCdCExjY4PE
	IgweTjCpzZX0kOOpxyluq8MKeCQ6jvG9Pb1A3jds21e9C5BIC/jxDhnj3LaarJhtu9e3bFBM+CUxx
	1VwIM8zWqf6i3w6SSY8hIRfnNQv3KNTKD4C9Uy/Mtom5e11NAU7ZuLPttUIJb6G1yqGjOW6qmE4Jd
	t2M59RKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEZNp-00000003W3p-05X2;
	Tue, 04 Jun 2024 18:59:45 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEZNk-00000003W0z-3pph
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 18:59:42 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Hmglk006342
	for <linux-nvme@lists.infradead.org>; Tue, 4 Jun 2024 11:59:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=mFhCe4DOU2WAROF9cUCSDc3/RD+V687u+vWLh/EiTJ0=;
 b=FS5YsgKmYwzuHUsIaAZJSk1VSHXJl1oXEFxZN0w9n3yYdELdD2+b5bAKkk2zZr52DJ4O
 qqJVaI7I1GC3ZeE8vhnCkCPwIeLOmtNWUxrFZ6mOod+58CeUmM0hEYIOqQjTbRj2QJbZ
 j9TZrHbLkJxJeI3nJNdbgxhhwqxcAgYS4JJmk3DLv2Go8ckn0a8bGvUPWhDpn/ige9Yo
 1p8VAUVWGtnK4lKH2jjHYVfaBghxrKk71BEt+GaWnKoUq1I1nN7/tvr3EVr3e3Dg6V2n
 oRl4V3BLQCh6aUUxtAP7XX7MhM+PAk31d9EUrRQ2CLdt4ZZNZWrcPePNzQqvUTH/o+d6 HA== 
Received: from mail.thefacebook.com ([163.114.134.6])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yhqbxpg8m-15
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 04 Jun 2024 11:59:40 -0700
Received: from twshared55396.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 4 Jun 2024 18:59:37 +0000
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id 0C00F35076CB; Tue,  4 Jun 2024 11:59:26 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <mlombard@redhat.com>, <hare@suse.de>,
        <shinichiro.kawasaki@wdc.com>, <james.smart@broadcom.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 1/5] nvme: apple: fix device reference counting
Date: Tue, 4 Jun 2024 11:59:04 -0700
Message-ID: <20240604185908.3703052-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604185908.3703052-1-kbusch@meta.com>
References: <20240604185908.3703052-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: H_zkl7W25iOlvJ-3fN735cNwiU1tf9B2
X-Proofpoint-ORIG-GUID: H_zkl7W25iOlvJ-3fN735cNwiU1tf9B2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_115941_139370_1A5E007A 
X-CRM114-Status: GOOD (  17.74  )
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
 drivers/nvme/host/apple.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index dd6ec0865141a..d3384aecc0d39 100644
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
@@ -1516,10 +1516,26 @@ static int apple_nvme_probe(struct platform_devic=
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
+		anv->ctrl.admin_q =3D NULL;
+		goto out_uninit_ctrl;
 	}
=20
 	nvme_reset_ctrl(&anv->ctrl);
@@ -1527,8 +1543,9 @@ static int apple_nvme_probe(struct platform_device =
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


