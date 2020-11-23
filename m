Return-Path: <SRS0=38m3=E5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52743C388F9
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 22:42:47 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCFE1206B7
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 22:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GoM7O/h9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZVmSvTqY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QR+hNaQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFE1206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=UYjbexd+RGj3REaYnUCApit48qpKYODlri5DsxqsPKk=; b=GoM7O/h9xW0V2LVDH10bLjP/8
	bQ+LAgrZoTULDmAXRmUMLeGYEbzyZ/ZORAs6EEQtJCIuRbxWnCkVeWt64YMHVt/ZhyBF266eCGajq
	D/B+hXBN6cKXfT0Y4G1SWZCegec6GeTBgW7uJcMQSw94UvtKy3DVdmqSlnUvEUUtH1cU9iIwmmRbk
	RA0CekPw1zM8aMuV8gojXOymbptaAKAtRmG2t2V10wnGKysci18dnn9pa/MnFqatDUMpb4NYawny1
	R8vgMU0C6+MHBEfT53lBwbpvyir1ejipvDraoAcnkzw7RZ0gBuRTd1NZGs4SUQBtXf2a8Sl89zUQu
	CEZWB2p9g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khKXg-00051S-IC; Mon, 23 Nov 2020 22:42:40 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khKXe-00050z-0H
 for linux-nvme@lists.infradead.org; Mon, 23 Nov 2020 22:42:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606171357; x=1637707357;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=4gSAk9EbuynSrFZfFA4dRYA+9fD5xF8JbAsMmivuLyw=;
 b=ZVmSvTqYHL60YfsTed74NnYkqdUnUNKWVZpOZclFHioVE6ydLdjw6K0w
 c7zRPiiu8rK60Jrei9J7b2gTwY20GslTb4barQ7wCeaMSYPimHlYQQYDD
 ZVu9ts5fHGms+3YsjRmDnYCsrsG8X4SpsugK7TuRrGQ+IlCbv1i/IK5zr
 QkPMvfzPQpS/oUSieQHUoBH2E6Ubbk79tfLLSPBB2S9al4Lallb/IiFDT
 4lpzm6iGECzaUoDVXKk2slnq2DWzyggSi4G1USq7rU5JmHIntrEKMywmD
 7wdNnL8AKpMnpLnXat0R3hJ2J+0Oeg9rNpfRmw7kC2bRXOe+yS0XtWo9n w==;
IronPort-SDR: r7Mm5lD0OYWHUzDj4bYnbK2GO4BVeSdZA0TJsaVIpvZO+KPhbaA0YkO71j107HXqLsqMAUQheG
 44h8fC1YZN/WCR1+UQhRXxDOZJnmoZmckAre2BUXY7ZUw0Eqxh0OrNphv6J+rcrk7eAeY3dq3p
 1ig9HFIaIE03xjq9tBNTfWupwsfrrj7acRflfA4mxefPCqrc+v+ZeiO4A3CZqxXGY7wL2Lt8cG
 H0tpGzNhDlMC6Ce3iX5rrScEGVloyRYkOmHhR2kPsxrFdjY7jKpqTluCnPK3YJsakjoONWLA9I
 vGM=
X-IronPort-AV: E=Sophos;i="5.78,364,1599494400"; d="scan'208";a="263341630"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
 by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2020 06:42:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZKN4IVdPO5Xdc5ymMCgK30N4/oRZvCoPaxNjYcCBSzIFhybUXiq4hLarY4gsShT84S2U4wSKsBRp19qgCwHIl2L6PYzggihGIUKxJUE7O3kvoPXaVsO+4XAevUmQayXT0uINhtcE+NbxyMvk+zGMDMZZcZsQH7jDHfxT+QYwpM/E48WdwQiXgsmG6K1i11B9tKVohyDiGyecDn8KmVjVedHwxl0fEyoDSgg+zG0ejDBr9S0XsxR/t+hyUakYmuMc0hut5tGeeSE7f7w1anAY3tJ9KRShEaLsjGd8tjJaf2BvDas6/wRn36PA882ATKXlHi3XTcEFN51Z2Zr4SWJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj8Msxjc3zmEbs1b7Y1TvA63wQS5EIXVUzNt1VyzW7Q=;
 b=DNKblU27E8G+p8/o9b9CpJKU2qVMSOTYUdGQW5qDs0XlmWjBFTLqOuyBUmsJEb2RLOL0Lc5CkNDhH+9FDhoqLciOSgYrRE6+S9uaENX/tMDYLvcISEzD19s5NH6nOnMtoQ3xBJ6IW6Va6Bf3Ey84P4vEkQN3y0lpNysci/PVvt9+UFInGVbnbBn0zQsKHhqae3KEgOafm2y62jcvdJBDxgolr+RlM9McqltRpPKPC4A4gKDbg8qg400Loi25QZWEVWBKURqhf0Ug1gRdPuyv1ztHSkqN2VHlWAKBLjC3+xl0VxpqnlaZoTAVpEN0ZC+mGvsui0oW3QAVThuhdH17qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zj8Msxjc3zmEbs1b7Y1TvA63wQS5EIXVUzNt1VyzW7Q=;
 b=QR+hNaQ7KYXfz/rGOH12YJVQV5KYTShmxbaeNeOKMkRWidZlyH4of+hsNZP5rNcPc13z/WB3dI7oX4Hz326HiA8X9Bso3ibpwQ7rFLZ/wTr4PYVbRNzkKIL9qbfDhsYHwNZ/kVQ9UQR/o/TmmRdEW1UERbuf923rbYNXGmhwm9s=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7124.namprd04.prod.outlook.com (2603:10b6:a03:22f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Mon, 23 Nov
 2020 22:42:33 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3589.021; Mon, 23 Nov 2020
 22:42:33 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-core: get rid of the extra space
Thread-Topic: [PATCH] nvme-core: get rid of the extra space
Thread-Index: AQHWvHH+g6nXmOW4EkaI7brwD7NBHg==
Date: Mon, 23 Nov 2020 22:42:33 +0000
Message-ID: <BYAPR04MB4965A603CD73595F0A3A820486FC0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201116234112.38788-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d60728e-d4a7-4f11-d62c-08d89001114f
x-ms-traffictypediagnostic: BY5PR04MB7124:
x-microsoft-antispam-prvs: <BY5PR04MB7124349042D260A2C2F20D4986FC0@BY5PR04MB7124.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wc3QQMTph0w+2CSodaOYDFjpiHUNRYEZMaKRamoaPchb6CZ6a1A1tMK8laVFIxZM+OcQDM8QG6/IToy7Pt4qgtlbiG/ZB0+nSlyo2QNuSn96x3w0y5uQXi9Ok9LBKbrXvOjj5+gOH84rCJfYHBqr3RjiLebev/qygseLhFllrZpNFsA2k3MZ4fnpKWTQZXJ1JqCd1GsxYLCNbsLMPOkfK3/tSluBqsROwRTg1lg/CXV3+x9RLXcYJzzNUTppjQk4PZ/kSuM1/BIBovi9nAGSHWxyk8NV/CLPCIYcAjmwx5puFZZcEh8fztfigf0qajGOL5HS/izdH5Ax1l+n1dqNV5McGVHg1dofgkQKvB4yw9juxTYvEy2SRZ02Lys31NVD
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(4326008)(316002)(4744005)(54906003)(52536014)(478600001)(186003)(8936002)(7696005)(5660300002)(66946007)(6916009)(66556008)(64756008)(66476007)(26005)(66446008)(53546011)(2906002)(8676002)(76116006)(83380400001)(6506007)(33656002)(9686003)(55016002)(86362001)(71200400001)(26583001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: UYAtGH2lL6jcj4kB4TzQ5VsCENVQbOqfrz0OalfAnHno1/vr/M5J6C0BRUh4VV7SsoiCZQ3+Z+22BvsL5M0bovZebyE84I+jEWLt6qEYaCzepz7RmaFESzcHcCOXdh3E49mu0tRNzJJ/zKwCE+XNIKUlSycE0mDCkB7MYzu6cmWOpyVRp0iwHdHt+9BRLgkFy0RdfTttSAgt1BXNozpXEYLcsl7fw5I1VAYaDple4w963Gsc6WWvyNUoPThF7k8Zee3w3IgpJBCBN/N8kWRwNuuCh7pFfj9MLguAuTKjE6tcMbGYFin5grFawVznGK2M7hU/Wq6+7Qb7/KrJ1tAM3rMlG/xxec3kzHgppjaVJEmnjPDxcfIi1/93bvsqtxsDnV+8NBuEhAeSkGP2MWS3MTmcjaLq54BJyP1ruHKcOPxBDCw05rpSGeewb3AiPWgF3GzVIiQAw0+MA64aYpEDtkpJWP2NhZJHL9dQ6Yjj9g0BLG+9LlW2FYjblS2X5Jm2ulYzAjnSBaEE+uu3lH/NSJBzqXI/tWNQ2jBKmfU8QDn8Jp2zDmqJKpOAd8q8Ua8hvN2G/UZoNMeBSLbrW3noZLotPYGLQu40Pt/BqJRxSJP1lUh+qLNiowJ+hWq8YPpl2IJbTowT7tIpya5bUVMaxT30tEJ+liRwk7zgvGj3jiY+ZyZ9btZc+v9/Ss2kzF60ZMtTYLKjxmcpjFuV2CGOGFTeiUNn3fmXk6EBlTZHd6cdh//O+5ZwM5ZassIyefWvmAWyAFXoZlUyxR8lAV24ojUA+ggMl36GqXtavvukqXmU3EzVzgTBBi0Mt8jqe4L2ZFlVQHg7K8S/kM6ANMIled9gL5p9C4afCyrp5jLmBVApD+bPMG95T4uoW65n6jneUaiogfmqk29B+F7ObeUQ0A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d60728e-d4a7-4f11-d62c-08d89001114f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 22:42:33.1457 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pJW5mz923v9mmILcYww5aKjxbTiCi5fe/KX2DKO6sOpZiMrjzFQDpQWt2OKyjuP0oR2Se4PFKqq36XN0uQWB+0Lcz2gqanxiXFynUe87Wts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201123_174238_354969_571C5E59 
X-CRM114-Status: GOOD (  16.03  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/16/20 15:41, Chaitanya Kulkarni wrote:
> Remove the extra space in the nvme_free_cels() when calling
> xa_for_each loop which is not a common practice
> (except drivers/infiniband/core/ not sure why).
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9a270e49df17..1fb35d3d6f7d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4378,7 +4378,7 @@ static void nvme_free_cels(struct nvme_ctrl *ctrl)
>  	struct nvme_effects_log	*cel;
>  	unsigned long i;
>  
> -	xa_for_each (&ctrl->cels, i, cel) {
> +	xa_for_each(&ctrl->cels, i, cel) {
>  		xa_erase(&ctrl->cels, i);
>  		kfree(cel);
>  	}

Ping.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
