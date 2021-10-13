Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE3CC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 15:04:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46AE560F21
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 15:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46AE560F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=o6NVz9hBunImt4WPxnHa5W63Xuw5xJQUbxKjektep6U=; b=RLz7yAQQZc344c5g82ZbqmNhyf
	qtDQ8K2dNZPY6ca7CLOwP/HwM/rvaNgIYLYzA79JoZ4hUdyvByYGOpM4Rzdh+I5xz6zZv4eDxr95C
	6ilj9kXFOBVJIW2FbTaoimKp0w1fVB2xucL9KzW3vFZ3F++Mg1pUtQckjQF6a1Fz0v05wVfdctvzD
	CvQ+I58WBqwORCc8E56ZGXWGxEEy/rk5sg1aQGylprIOh4eFRoPPGU0VfT7qGQ4kyHJqYKY362gmF
	R2Kk88zxTjGXluPJLi4l9AnnWOhVbrZHxW6Clx5uiyh1TPxk79xtVBSM2Vm8dwxp3g4g2U4qwOBeV
	QvYzcrxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mafnw-00HHlP-1N; Wed, 13 Oct 2021 15:04:28 +0000
Received: from mailout2.w2.samsung.com ([211.189.100.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mafns-00HHkP-3l
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 15:04:26 +0000
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
 by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id
 20211013150422usoutp027267e455e19109f0420036ba2b8a93e7~tn10bd90H0787407874usoutp029;
 Wed, 13 Oct 2021 15:04:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com
 20211013150422usoutp027267e455e19109f0420036ba2b8a93e7~tn10bd90H0787407874usoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1634137462;
 bh=o6NVz9hBunImt4WPxnHa5W63Xuw5xJQUbxKjektep6U=;
 h=From:To:CC:Subject:Date:References:From;
 b=QgwudczEHn5zX46ahS5WjOXA731xCbrqCqIx12AdyOfoYaUWbtk4ti10dHSM2He3o
 8Rmx7V6DZdA3GOSbgNPp578/QwYFAzcBZJqrq3mZFcfQRjSWz5P8IYqkW5MzA6q1M0
 9YR++hhN8MlNxMytfCLxeE7SUcAN97yv16rexqK8=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
 [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
 20211013150421uscas1p18a094883e6b2053fd367c6a7ba7c8c44~tn1zw5ndo2726627266uscas1p1X;
 Wed, 13 Oct 2021 15:04:21 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
 ussmges1new.samsung.com (USCPEMTA) with SMTP id 7E.DA.32368.575F6616; Wed,
 13 Oct 2021 11:04:21 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
 [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
 20211013150421uscas1p297a8bd51cf3f3b68dcef3a1c87da2959~tn1zgmBR71119811198uscas1p2-;
 Wed, 13 Oct 2021 15:04:21 +0000 (GMT)
X-AuditID: cbfec36d-c03ff70000017e70-e9-6166f575264f
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
 ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 79.6E.26904.475F6616; Wed,
 13 Oct 2021 11:04:20 -0400 (EDT)
Received: from SSI-EX1.ssi.samsung.com (105.128.2.226) by
 SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.2242.4; Wed, 13 Oct 2021 08:04:20 -0700
Received: from SSI-EX1.ssi.samsung.com ([fe80::ed94:2e33:daa5:4d68]) by
 SSI-EX1.ssi.samsung.com ([fe80::ed94:2e33:daa5:4d68%13]) with mapi id
 15.01.2242.008; Wed, 13 Oct 2021 08:04:20 -0700
From: Adam Manzanares <a.manzanares@samsung.com>
To: "yi.zhang@redhat.com" <yi.zhang@redhat.com>, "sagi@grimberg.me"
 <sagi@grimberg.me>
CC: Adam Manzanares <a.manzanares@samsung.com>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
 <hch@lst.de>, =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, "open list:NVM EXPRESS DRIVER"
 <linux-nvme@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] nvme: Cleanup per-namespace chardev deletion
Thread-Topic: [PATCH] nvme: Cleanup per-namespace chardev deletion
Thread-Index: AQHXwEOZ9FtF1OBNkkuxqiarQaCvFA==
Date: Wed, 13 Oct 2021 15:04:19 +0000
Message-ID: <20211013150413.320133-1-a.manzanares@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djX87qlX9MSDZ4v4bf4v+cYm8XK1UeZ
 LCYdusZocXnXHDaL+cueslv86uS2WPf6PYvF9XPT2Bw4PCY2v2P32DnrLrvH+XsbWTw2repk
 89i8pN5j980GNo/3+66yeXzeJBfAEcVlk5Kak1mWWqRvl8CVsWPiUsaCHrGK9xMOMTUwXhbq
 YuTkkBAwkVj3bwYjiC0ksJJR4m03M4TdyiSx9msSTM27J8vYuhi5gOJrGSWWPl7OAuF8ZJT4
 fOcOVOYgo8Ti1/fZQFrYBAwkfh/fCDZKRCBCYsakr2AdzAIPmCTebJjMBJIQFrCV6Ju1hx2i
 yEmi88tHqAY9ifmnZoDFWQRUJU7svcICYvMK2EnMX9MM1ssoICbx/dQaMJtZQFzi1pP5TBC3
 Ckosmr2HGcIWk/i36yEbhK0ocf/7S3aIej2JG1OnsEHY2hLLFr5mhpgvKHFy5hMWiHpJiYMr
 bkDZJzgk7u6M6GLkALJdJM5OgQadtMTfu8uYQP6SELjGKLH80RxWCOc+o0Rrz19GiCpriYV/
 1kMdyifx99cjRohBvBIdbUITGJVmIXlhFpLzZiE5bxaS8xYwsqxiFC8tLs5NTy02zEst1ytO
 zC0uzUvXS87P3cQITFWn/x3O3cG449ZHvUOMTByMhxglOJiVRHgNM1IThXhTEiurUovy44tK
 c1KLDzFKc7AoifN+MpwYLySQnliSmp2aWpBaBJNl4uCUamDyPrZfR4B7wre+DhETFZ6ZljNk
 rivzRm4/zsnPpZfU5NuycKKL4taz12YH+X8uv2tfZDr37MbL83gZhYMXZt5OaD47cWrEcl42
 407t+uSLlz5zr1JoW5SuPL9cJ99w8oO1LK/m2P0MZVRyXHAplOWfvft23furfPfe2VJSuy+t
 VNJ3W5Dr0lxuwZDu7Km8aptXKNW2HViZUyK8Ws9GVSFjya6l1QsfmSd7lCW6r9Ys7c0p8XOw
 W7syivlfS0eV0Pp1JrsiD3OXu03em9otdnFxjGhxk11e8+rHi26l2DKXJT+udNq44dpu/6tb
 TLam/Go9kf5KQfvnM91irQ8v8n+8itP/W+Xi7+WneuLeJyWW4oxEQy3mouJEAAj/v0rEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWS2cA0Sbfka1qiwYJrFhb/9xxjs1i5+iiT
 xaRD1xgtLu+aw2Yxf9lTdotfndwW616/Z7G4fm4amwOHx8Tmd+weO2fdZfc4f28ji8emVZ1s
 HpuX1HvsvtnA5vF+31U2j8+b5AI4orhsUlJzMstSi/TtErgydkxcyljQI1bxfsIhpgbGy0Jd
 jJwcEgImEu+eLGPrYuTiEBJYzSix9M86RgjnI6PEtsm/oJyDjBIfJvazgLSwCRhI/D6+kRnE
 FhGIkJgx6SsLSBGzwAMmiTcbJjOBJIQFbCX6Zu1hhyhykuj88hGqQU9i/qkZYHEWAVWJE3uv
 gA3lFbCTmL+mGayXUUBM4vupNWA2s4C4xK0n85kgbhWQWLLnPDOELSrx8vE/VghbUeL+95fs
 EPV6EjemTmGDsLUlli18zQwxX1Di5MwnLBD1khIHV9xgmcAoOgvJillI2mchaZ+FpH0BI8sq
 RvHS4uLc9Ipio7zUcr3ixNzi0rx0veT83E2MwBg9/e9w9A7G27c+6h1iZOJgPMQowcGsJMJr
 mJGaKMSbklhZlVqUH19UmpNafIhRmoNFSZz3ZdTEeCGB9MSS1OzU1ILUIpgsEwenVANT9e6X
 thMYDI06d+YFyK6Zy/zbPlicacvW24WGS84e2uBXbvYvrtCrSPzAebaNJid9vv30COHsaVCP
 9LjZ33x0ExvPTIULKw8e2cf/z6c3qiyWNSCsfYv3oadif+Qs1t1OuX5PtWWB15PDEXzHXS+0
 tWm1vpVv2Nu6pztek+tqyqJ1Hk6TZgdox1Xrzb8ioW8sae/RuC3INlVq6v49t35vFVPUCD3F
 u/2ZYNAhqy/y28I88pMO34tcdTU6POD1xzvKS5nitny+prtNZ+Gy3NW719ubSNS2/3zD/uTP
 rS/Hj07c6m0//2Sef/HVlY/Na/fz8TuoBRryPV4epPNFhzF6v9DSh0802CwuMW+Sy2FQYinO
 SDTUYi4qTgQAzWw6hUADAAA=
X-CMS-MailID: 20211013150421uscas1p297a8bd51cf3f3b68dcef3a1c87da2959
CMS-TYPE: 301P
X-CMS-RootMailID: 20211013150421uscas1p297a8bd51cf3f3b68dcef3a1c87da2959
References: <CGME20211013150421uscas1p297a8bd51cf3f3b68dcef3a1c87da2959@uscas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_080424_382286_AAE40CF0 
X-CRM114-Status: GOOD (  13.90  )
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

Decrease reference count of chardevice during char device deletion in order=
 to
fix a kmemleak. Add relese function for the device associated chardev and m=
oved
ida_simple_remove into the release function.

Fixes: 2637bae (nvme: introduce generic per-namespace chardev)
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>
---
 drivers/nvme/host/core.c      | 21 ++++++++++++---------
 drivers/nvme/host/multipath.c |  2 --
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f9a25c61fb8b..3bc4bb620ab7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3583,10 +3583,15 @@ static int __nvme_check_ids(struct nvme_subsystem *=
subsys,
 	return 0;
 }
=20
+static void nvme_cdev_rel(struct device *dev)
+{
+	ida_simple_remove(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
+}
+
 void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device)
 {
 	cdev_device_del(cdev, cdev_device);
-	ida_simple_remove(&nvme_ns_chr_minor_ida, MINOR(cdev_device->devt));
+	put_device(cdev_device);
 }
=20
 int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
@@ -3599,14 +3604,14 @@ int nvme_cdev_add(struct cdev *cdev, struct device =
*cdev_device,
 		return minor;
 	cdev_device->devt =3D MKDEV(MAJOR(nvme_ns_chr_devt), minor);
 	cdev_device->class =3D nvme_ns_chr_class;
+	cdev_device->release =3D nvme_cdev_rel;
 	device_initialize(cdev_device);
 	cdev_init(cdev, fops);
 	cdev->owner =3D owner;
 	ret =3D cdev_device_add(cdev, cdev_device);
-	if (ret) {
+	if (ret)
 		put_device(cdev_device);
-		ida_simple_remove(&nvme_ns_chr_minor_ida, minor);
-	}
+
 	return ret;
 }
=20
@@ -3638,11 +3643,9 @@ static int nvme_add_ns_cdev(struct nvme_ns *ns)
 			   ns->ctrl->instance, ns->head->instance);
 	if (ret)
 		return ret;
-	ret =3D nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
-			    ns->ctrl->ops->module);
-	if (ret)
-		kfree_const(ns->cdev_device.kobj.name);
-	return ret;
+
+	return nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
+			     ns->ctrl->ops->module);
 }
=20
 static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index fb96e900dd3a..bd490a7c4808 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -434,8 +434,6 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head *h=
ead)
 		return ret;
 	ret =3D nvme_cdev_add(&head->cdev, &head->cdev_device,
 			    &nvme_ns_head_chr_fops, THIS_MODULE);
-	if (ret)
-		kfree_const(head->cdev_device.kobj.name);
 	return ret;
 }
=20
--=20
2.25.1

