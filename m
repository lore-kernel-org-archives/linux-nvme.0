Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 256BAEB64D9
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jul 2023 07:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=rL3Th8OJ0pBgXUIAArKa42l1kbJw4No0Kk6ERN3Cas8=; b=nhaNuOSOTs43pwBi5tu75oCuoS
	nvmlDQ5nf96C2O90awv3rLHdwTzg6rZR88IEbIemGP9dSbT9zM2Dtfv5xCJ6zwWn7J3UyMVj9gZUP
	mPKIXooja+7MAOs/acYCUodsGUbUJLEzZMku0NN4PZDR2H8uyMdwHF5SGehgabMM09khU6oDEcXTW
	TvP0gTthxfCt/guT/gC4bWlw8AUVeKoSfaSovIss8enuVWzPfY5GUPcctmul6zUUl8la61e2UoSsI
	QV+MFkk6ymoGjMYvLNavmiqC32ZKfg+vIwfGM6XairWJznBlzdG9tUzUL2z9krifHu2xOtMg/62Ie
	6uaKg9vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGaaw-00CRoh-2S;
	Tue, 04 Jul 2023 07:37:06 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGaat-00CRnV-0m
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jul 2023 07:37:05 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230704073659euoutp01bd6f9edfc16da4226935d2e6706f992c~umfxPmklA1177611776euoutp018
	for <linux-nvme@lists.infradead.org>; Tue,  4 Jul 2023 07:36:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230704073659euoutp01bd6f9edfc16da4226935d2e6706f992c~umfxPmklA1177611776euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1688456219;
	bh=rL3Th8OJ0pBgXUIAArKa42l1kbJw4No0Kk6ERN3Cas8=;
	h=From:To:CC:Subject:Date:References:From;
	b=J2DLhUO7tQ+4AvgGpa6bTW/nh5h/XOx1FUD1sfDldoN55x96xxR8uDvijun3HF/dH
	 q3VNPXxqUAJmOR9HznD+GwP0kkzYqu/NYfh+74fr5OtttGQ29CI+wseGdhlJq8qKXo
	 +LhLoGu1yzZcT2ZeHSH4x6nmT+xKNpabTTI08wMQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230704073659eucas1p28c6014e420111da9ce08e51d38233f84~umfxEOl3f0360403604eucas1p20;
	Tue,  4 Jul 2023 07:36:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 05.97.11320.A1CC3A46; Tue,  4
	Jul 2023 08:36:58 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230704073658eucas1p1f977a725486b9cc7e0bfe70b29286280~umfwxZJpW1176311763eucas1p1D;
	Tue,  4 Jul 2023 07:36:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230704073658eusmtrp2a8e7dbe145258ca17546efd08a7fffc6~umfww0buB2696026960eusmtrp2R;
	Tue,  4 Jul 2023 07:36:58 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-2c-64a3cc1a4506
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C8.B7.10549.A1CC3A46; Tue,  4
	Jul 2023 08:36:58 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230704073658eusmtip2d72cf81eb9ea54a2efc96af245ca4643~umfwkNUmk2671026710eusmtip2Z;
	Tue,  4 Jul 2023 07:36:58 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 4 Jul 2023 08:36:56 +0100
From: Pankaj Raghav <p.raghav@samsung.com>
To: <kbusch@kernel.org>
CC: <jh.i.park@samsung.com>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <javier.gonz@samsung.com>, Pankaj Raghav
	<p.raghav@samsung.com>, Clemens Springsguth <cspringsguth@gmail.com>
Subject: [PATCH] nvme: add BOGUS_NID quirk for Samsung SM953
Date: Tue, 4 Jul 2023 09:36:56 +0200
Message-ID: <20230704073656.378760-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01SaUwTQRjN7G63S2PrtqB8ooakqEEMFRS1It4aa6KRXySgQatdEC1F2+IB
	EaogQk28kKAlgBeHYOS+1Ggo2lJA8UClRBEVCApaEUIqIkhZNPx7+4558zZD4aJkjhsVodIy
	apVcKSZ5RKXpV7O3W9NNhU99h7+0r+YeV3q78AkmvWR8g6TZuV1c6d1eG7GOI6sxvOfKmttL
	CFlpQQopK7sVL7tv1ZGBnBBegIJRRhxh1IvX7OHtH/r5kjyU4HSsurMD6ZCJq0dOFNB+cOpP
	IceBRXQ+gu47QXrEG8eDCEYKW0n2YwCBLcNO/kt0tJ0kWCEPweu0C/h/l6k/ZfKsMgSW1nl6
	RFEk7QUnUybqXGhXuNvQgjn8OP0SQVJvLeEQnOkAGEyyIAcm6HnwemhoIsCn/aF4pBqxze5g
	1T/CWV4IlqudE1l8nE+oyMBZDFDb04OzfjHoypoIFp+AhvK2iWKg6ynIMT/EWGETnC6unyxw
	hq/m8skfMwfGarInPbHQ1fobZ8OJCM7XFJGOZUCvgnNNStazHlK7rFyWFkDrNyF7HwFcqkzH
	WZoPyUki1r0ACtv7iAvIwzBljWHKGsOUNdcQXoBcmWhNZDijWaJijko08khNtCpcsi8qshSN
	P5bGUfNgNcr72i8xIoxCRgQULnbhJ3zMVoj4CvnxGEYdtVsdrWQ0RjSbIsSu/EWrLftEdLhc
	yxxkmEOM+p+KUU5uOixx/tmnmw4LBNAdOHD5i0ybb+RwD/jMzN01xgGwjDSSmUl1xi+GHR32
	9NTQRGVqKApvCv7gkeW9sqGlSjwcNLdirz1m88JreJWqHFst1Ob8eDFHUtlbXPTKW/mzwmx4
	u0xgTu4r8bSFuWvjecdKdbwNBa7vvlu2jn7yqoydFnlGmfZYlRnh90zBs6+xaHfyAx4GhrRv
	2VWUHtHYuB2bEc298mBMerHHGlos/Kxa+3y5xwZcW+ZfsPQmNzbZvR19mrn8YtY3S8mNOBsx
	4BnF76rTv/I12fo745ZKtl8X3jtj1bXl2oOXbVvgh7XMmhu28Up11nTTo+FTOd0neld4xogJ
	zX65rxeu1sj/AgTlWsGbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xe7pSZxanGKxsUbd4s3MXu8XK1UeZ
	LCYdusZoMX/ZU3aLda/fsziweuycdZfd4/y9jSwem1Z1snlsXlLvsftmA1sAa5SeTVF+aUmq
	QkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexrdPl9gKmjkrdjx5
	wNjAeIy9i5GTQ0LAROLBrUaWLkYuDiGBpYwSk/bsZYJIyEhs/HKVFcIWlvhzrYsNxBYS+Mgo
	sfmCM0TDZkaJq51HgSZxcLAJaEk0doINFREQl1h36goTSA2zwCVGibbXB1lAEsICNhJf2k4y
	gtgsAioSV799A2vgFbCS2PBnByPEMnmJm137mSHighInZz4B62UGijdvnc0MYUtIHHzxghmi
	XkmiYfMZFgi7VuLz32eMExiFZiFpn4WkfRaS9gWMzKsYRVJLi3PTc4sN9YoTc4tL89L1kvNz
	NzECI2nbsZ+bdzDOe/VR7xAjEwfjIUYJDmYlEd7mh/NThHhTEiurUovy44tKc1KLDzGaAv0z
	kVlKNDkfGMt5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1Mxgda
	XY2PHuo+4MB58onbPu0YzS9xD6viTNmX12Ua9Tb9uyvyTeFvRNCVK6flNnqeSf9jc//z0q+z
	75Ycv7jpwXWH36Fcm43tRCfWXH8Rxed6cLPepuOcx6XvGq4y4pUyrFXKik/K8u7ju56a4Hu2
	N4XjOdu3CoErjsaf33y4uZFz0cEFGYd+JjfPENj61jpML/ZWw+TbUX7V/mteuqtzFcY35Qc3
	6mRdnlE1a+fTtuZfUWrP+GRLm4u5/Xofyx9KNTxUVXBW/d49byFm36KVgov4BbaYbayyXc+6
	KHefOGMHY9+UZq3/f6OE+H7kzV5v4XJh/5TG1WXRy09UzH16+eJriQs3hFJvxFyymjtTiaU4
	I9FQi7moOBEAVL9JPS0DAAA=
X-CMS-MailID: 20230704073658eucas1p1f977a725486b9cc7e0bfe70b29286280
X-Msg-Generator: CA
X-RootMTR: 20230704073658eucas1p1f977a725486b9cc7e0bfe70b29286280
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230704073658eucas1p1f977a725486b9cc7e0bfe70b29286280
References: <CGME20230704073658eucas1p1f977a725486b9cc7e0bfe70b29286280@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230704_003703_665764_4254BDAC 
X-CRM114-Status: GOOD (  13.83  )
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

Add the quirk as SM953 is reporting bogus namespace ID.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217593
Reported-by: Clemens Springsguth <cspringsguth@gmail.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
Hi Keith,
  I haven't tested this patch on a real device. Could you wait for
  Clemens to test this patch before applying?

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 72725729cb6c..8754b4a5c684 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3396,6 +3396,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x144d, 0xa809),   /* Samsung MZALQ256HBJD 256G */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x144d, 0xa802),   /* Samsung SM953 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc4, 0x6303),   /* UMIS RPJTJ512MGE1QDY 512G */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1cc4, 0x6302),   /* UMIS RPJTJ256MGE1QDY 256G */
-- 
2.40.1


