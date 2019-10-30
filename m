Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0F0CA9EC5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 20:10:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DD4B20650
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 20:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aUY3rRXH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S2r3OZzU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G3BY++O1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DD4B20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=v8dfDqxbrrIm5LGAUFNxsjvtXvLFu85gAmkjxXjMnL0=; b=aUY3rRXHkOGW2i
	OtI103mysPyOQ1XG4p038baKdahNIv1f1vJ4BD76zqMhrk1McjX1dwfogRD1s+OqC4x+6PqWV/FxP
	IRPoyla3u1NdazZnsMT0zUjhlipv4KUdaR7LI0cpCf12hfPVMsV1F0aiYOAvF9xB++cHU4XF6dJXP
	lhwEJNt1BSof4EbZyP4gwqbVZv5HRYM5CbsRKZqwPZyoqN9tPAMaepHqfSd7xmlvhZ1zGmhvzwk3F
	XPCBZlpfGGbQtT642er/W6oLkOBVRXnI3V52geAADG2Gzf1jJwX+bJ1P/x8aUeXVOBcf8aGVOuc/f
	ZTynfSwDWJapGq6GLrow==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPuI6-0008Fm-Un; Wed, 30 Oct 2019 20:10:02 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPuI4-00086q-T0
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 20:10:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572466215; x=1604002215;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=OwBjkJTY/yql0seO/JWQPlcSB31v/oPjhKNKgpqbE50=;
 b=S2r3OZzUaSr9Tw5FYrsVT5haNXblm9vtNCuz86cgFX4Tc5PftyUkeYPs
 l0KAm3dTEcFVzdsorzk8Y0Gwhp96Knrk2Rdkl8wmDLl3ZslaFE1ZojVrq
 wjMevSClTPIQ7AF70L+SPRT2z/0dNpoN12ZY3wo4w3Ru45ypsG4mn8YLF
 mNofnzZQ1e/lPzoUE69hWXJSL+oW4i7hrYrJwBCz/lfkYw/LmEHEcu2/g
 IC0bHyU9kSSHLqnpMeR2tPx1c0sSv5zHeCfV4RtZBUhmt0F8pZcvGQ2bI
 6boGXhL90z1j3v9Uu3CwHe6ltneb1NxROPPotm67m7+BUiAOCccXwX3B8 g==;
IronPort-SDR: 7F/STpEVipJTfj/2OAdY1N5l3dKyay8B1YTpHiv+jQJQhD5YnjMxove/dDIki/1uLcMEpUVn3I
 5uWgCj8MzWhi5hKKzwQvCoRsKxNuFmZI90Na9nh4fFNBSMYGpvSb7os3CTPaLq40ApmnPEzbuP
 MnJAqUYcCIHrYAh8Mig+buTFwSyDZ7mXrCnbNTyrCurQZTlyyBl6sLDI2GT4IKpGV2J3V2aq6Z
 ys3RyLgXXmRBH5weler7XV4m8otrbFet9Wuzek5XRzs7759U7jmN6jA+dCd0V39ETORTcE4tjT
 EFY=
X-IronPort-AV: E=Sophos;i="5.68,248,1569254400"; d="scan'208";a="222869283"
Received: from mail-bn3nam01lp2055.outbound.protection.outlook.com (HELO
 NAM01-BN3-obe.outbound.protection.outlook.com) ([104.47.33.55])
 by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2019 04:10:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BajxMDDvoluqH8An+SAv0K2a6kJntGOmkGOVp0BXY8lEwt190q2EPh95TVNAku08aX6nJpEfhV1stc+kZW0Yy7ANk4I1Yq75PiYvCqcoUCTk6JCxAtLzM+XZFtO0kVZB1VtOLUh8tbt2qsHb5kaZnBQxx7RclAerDCN6weIieYwbMiGqJ48LUMEL6PkwzklqhxOESzGE4xrrdWtHt3bw33cWJQEEvbtHBhAWmkF2cOivIfWEErdzePS2bw0h91UT3D5TZ/dao4rnpgoItjLlv+WpWAJujdSbI4mQMLsxdCcM2lULfr9f9uagUw5xXIuBVq6o3DADZSqFk0j23MjTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwBjkJTY/yql0seO/JWQPlcSB31v/oPjhKNKgpqbE50=;
 b=W7QLnhFNmGczfFbRK1qqeRrv5ZL9Xqx2dLeB7jqVpWEHfA+Fodc/F4c7pnYYCwU3sSlcX4AD4/l43MWuNjFLiMcOt2pqhbvD+R31TueyzmZfIXTinIwrXSIUsPCFO2z1sm61bKsdMXI/JRIRcucbVhwZ9A2eAulKiMR5Wxx/vOCq+jZ0snxmH3L6h/SfnB+Ir/YSKmpHU9+6Li3cBTyO0KNeKrVN2NlJdwIE201dgy1UHVYxf/IF1C4ib7MlRai70NnTDVsEUOfnesCvg/zr+FKPpeRDNtOzYLXY3J66jjjJy1821hwT+AzhXyLmcyweov/amWIftEyTyKSBzhjK3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwBjkJTY/yql0seO/JWQPlcSB31v/oPjhKNKgpqbE50=;
 b=G3BY++O1xHZyYfQluBMfAIrspUmKRgPu0FZ0dB2O4VBwgbqGuIGaYXRugl9ikZEgaZkthU8tQivoW0VoqjlQsBBEjd77Vz71eofEW1DHrjMSEi/HncE2B1AHLzWiwNvlfBu1l2IaPS6vtfjo1NQ0zNTj6GWiFQBTDNU2DtXWgf0=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4566.namprd04.prod.outlook.com (52.135.237.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Wed, 30 Oct 2019 20:09:58 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7%6]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 20:09:58 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Mark Ruijter <MRuijter@onestopsystems.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: make ctrl model configurable
Thread-Topic: [PATCH] nvmet: make ctrl model configurable
Thread-Index: AQHVj1sXWigCUD3+A0uHtVCbsaOdWQ==
Date: Wed, 30 Oct 2019 20:09:58 +0000
Message-ID: <BYAPR04MB574913120D3089CB11BBECD986600@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191030194858.30788-1-chaitanya.kulkarni@wdc.com>
 <8B7B7A7F-2519-4BF3-A3BB-4CA758B598DC@onestopsystems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2e948a2c-b9e4-4896-b9c0-08d75d752379
x-ms-traffictypediagnostic: BYAPR04MB4566:
x-microsoft-antispam-prvs: <BYAPR04MB4566F2280B9B1F1884F224FB86600@BYAPR04MB4566.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(189003)(199004)(66066001)(316002)(305945005)(478600001)(2906002)(25786009)(8936002)(33656002)(14454004)(256004)(110136005)(81156014)(74316002)(81166006)(76116006)(8676002)(7736002)(7696005)(99286004)(26005)(86362001)(76176011)(66556008)(66946007)(9686003)(64756008)(71200400001)(71190400001)(6436002)(66446008)(102836004)(446003)(6246003)(6506007)(53546011)(66476007)(3846002)(4744005)(6116002)(486006)(476003)(52536014)(55016002)(5660300002)(2501003)(229853002)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4566;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AYHUXlOWkHIoSObpxpD+s6ndwYduA2mPbz3yX2b9Rs/SGjmOUGoxodLIVEwdHJPEEmfYmqa35bMvqfnm4eSk/4576ryZNjTdXIyji4+z7pJczP0yXL0acIp2HQsOXZitGIDruk2ko8/Ixpu4ofGMOne1z2GMKAURLMbFsPhUMTVBrS8CZlEhJcVXlbYazaENxQ7Wc0IsS19JQ8RoJUC55f4zE4zxM3vfSJmP7lGnNu3qo9iCFAUnN8aspU4BYeRucuO6fTLEZUKPfm+OOWq5p3FVjHzSWY/biH+LFgkWd9HrlSxqnY3gEon9mF/cuCUWthNc85mGdgEMEzgb1jDQW9ejR1ujA5Hu6RJaJRZUaaw9VBdBU3hlKtbl92TZ7nNx8UKTv+KLYFK/WQPJQevjAxN7t5xJ/myWcXZk02ltiDJBlfpXN3OnJQzzGil72A3T
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e948a2c-b9e4-4896-b9c0-08d75d752379
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 20:09:58.2272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mfc+F9wUBjc1464RMSC1f1ecZIQ1lAkSnnlW2CEBst6bm4Xh4z7QYKKRBJPGbn58e7OX+ADCyvhu44mBrpVwvp+AWijmp5UHFrzwJUXgJAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4566
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191030_131000_979090_64DF39FE 
X-CRM114-Status: GOOD (  11.24  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Didn't see your patch, until now. Since you have posted, lets go with 
yours. Meanwhile posted tests for blktests have a look.

On 10/30/2019 01:08 PM, Mark Ruijter wrote:
> Hi Chaitanya,
>
> I assume that this change is based on the patch that I send earlier today.
> You seem to have changed the code that accepts the attr_model input and replaced the input validation with sscanf.
> What happens when you write a string containing a TAB into the model attribute?
>
> The NVM-Express 1.4 document states this on page 13:
> "Some parameters are defined as an ASCII string. ASCII strings shall contain only code values 20h through 7Eh."
>
> As far as I know a TAB is 9h and sscanf(page, "%s\n", subsys->model) allows the TAB.
> This seems wrong to me?
>
> Thanks,
>
> Mark Ruijter


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
