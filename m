Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1727CC433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 16:58:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC34120738
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 16:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eEmakOAx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PrJGSIJP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EshlFUKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC34120738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MeDH68ZaUh5b8mnVeIsmEA+iRjnRXrv8o6c3+mAuzeg=; b=eEmakOAxkEmGnZU2vqU3Kmnn6
	FtBdv9dE5X+L67oeEDOjsXdadUCkN9QK26mk5rsaIe/Q5zvI0HhBzBWw3dU3pP/0Uh6do5WCTgCCt
	ur64qYFlijBBGHl3vvyb6bR0u2zyF2FPk5rVhuWsXDnxMse5Wdanv3hYezbP0OhMxR/Km3Hc8iojz
	wy2n3BamBylqkGvdRkD7/2HKjPhEiP1Yzt//jdh99GrUUxmJA0REudYwEdOjqdC3o92dFnps6+RmV
	oiJ4fiSYqxSIMqS+6gbjEDSCxzZnGLp+Obo0AElSq0fS2NSgU0qsJ+yy/r+9VxIUs+qXtA3fwYvra
	W/HTL5mcQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo8ih-0005LC-Eb; Wed, 24 Jun 2020 16:57:55 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo8ie-0005JS-Fw
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 16:57:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593017872; x=1624553872;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=vbOnvdKZdwqF+lV5ROUvnpHaozPwcjbKIv9muW+Hti0=;
 b=PrJGSIJPBokjtjReM+Y7t6mJ9wui83IATw3BjhVSykW2KPD8da2dUky6
 UIJZ3qYGL1HapcMlkJwOSFMZBUCnFKuM13AC4BgDq6PlEQZK2c8fAQDII
 e5mac+6HfxKTSTf8TiJQVlzb2kxPWZ0yB7+BdbxGcv7fOPMocqoaBFQ4U
 yjFXj8GC9UtgjHuw0v/q7cypVqBsk8lRar8fXuz6QpdH4rNcvcNJHHVjv
 zqbHuX/0dmOX3u+ukCFMSyun7rlho0kUbM4xzM6rp+ENXkFs+UEUCKH2V
 sE3WKxTo8Gp1s90VJC6zxeX3JQk3vw0TnYOO+zx/C2zk1cjrobnkBcJLt w==;
IronPort-SDR: sxXxlg5ZjvmTT+l093OlBga6DC3VgbZDVm3QdvRvx2d02suBlEW9M6BrJkdgrOGr/qUxATrFfy
 K5J60ZUFK7AXcu4nTJzcVECh/mvpztRaVmnEqJNMgQNb1QuZlKXexqV0y0otJ9f6f4gvxweh8P
 JiC4vKr2ggf20Mhcdd5j1iLz3c5SmQLshVQLohY2kDM/3GYguxrJL1hX+v3bpTlzeoYsa+ZF2z
 O89N/1Ky9uBkiickaXj+F/sIG3R5Vg4wc4lkPAm15P9i074IwIK/5SM8QMAYGhRXqSU8WVbtPb
 70E=
X-IronPort-AV: E=Sophos;i="5.75,276,1589212800"; d="scan'208";a="142189675"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2020 00:57:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/roMZneJgxbmSIcwVypCtkbSe32OE0TFWdwRG2JlboBBrjkeuQycTluJqAX6lAZkEDUbaqM1MNhzEC5+65Xczd96FRZwNKSAVpPmOfTxHLdIyzh6+e5ThAcqYykjO72U9O3d7YO00RucR4PumkY56z9gf8gFiVbfnWdVPMoinYZqLvc132PDnL/Hbyq7QHni7zuvu9RPldghD5CcuNMnp+tWKEFXcACSWbq286Z2JoCkqX6yUfoxIhXCRm+LZwqGB0y5+T6f1KYszDwnSEe9o7IYRUVypBBb7w9OK2XQlzqC5wlc/auGGQ0q9aQM4eWTp9rNV6oCiYIVON/zdPiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbOnvdKZdwqF+lV5ROUvnpHaozPwcjbKIv9muW+Hti0=;
 b=OBxlOwndiGcaK7BvKtWJHN2XfNkvSLkrtoWWkgUBtHyDvX+AEiQvtIGCwVhkYoRCuWn0Yrw7w+92JgQwwVYzuN1zx/mO5iynaYb22R2rDQBL780L5DChNsrg3lQn13vHndANsF1jdDF6Hw5l+iOQXfK7hQlRRMCxpdo4ySdjeNo4lH56X+pN3b4KuRKOYbmgqds0hhmL1pTwwHuCZeJ/9VLPGkmgaKWiCKON3c42tkRnmNSeUQ7y4wvqnO2v932wxp40kBcp8kb1crnnG+OmAv0FMM5PU37I6BobTW5zAa+gUin6YmQlcf9lY0n+PAwUgxeyaAbiyIcyF6wXgie2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbOnvdKZdwqF+lV5ROUvnpHaozPwcjbKIv9muW+Hti0=;
 b=EshlFUKt4pSab94BEkO/UhkZKZxKAwX/Xrlt2O8JZ8Gn48feED81DTElO7Ff14PXyuZcIJB380H4XjKBxcOSIl95t4ovQWsuu7/OYRTAwgnswrNIPzyyqamdx+PjFbQiZyXxPI1bxAR7vlBq6MQvegkSgEGif8HZgjruuNjVq/8=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BYAPR04MB4072.namprd04.prod.outlook.com (2603:10b6:a02:b3::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Wed, 24 Jun
 2020 16:57:49 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 16:57:49 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/2] remove workarounds for gcc bug wrt unnamed fields
 in initializers
Thread-Topic: [PATCH v2 0/2] remove workarounds for gcc bug wrt unnamed fields
 in initializers
Thread-Index: AQHWRatsK9pqpN/HlEmT0NtnEgioaqjoAiyAgAADqAA=
Date: Wed, 24 Jun 2020 16:57:48 +0000
Message-ID: <20200624165746.GA394355@localhost.localdomain>
References: <20200618200235.1104587-1-niklas.cassel@wdc.com>
 <20200624164441.GA24816@lst.de>
In-Reply-To: <20200624164441.GA24816@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 40bf9e77-3c2b-46c7-813f-08d8185fb9c1
x-ms-traffictypediagnostic: BYAPR04MB4072:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4072EEDEF0AB703BDC5928D5F2950@BYAPR04MB4072.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Eucfr+w8S8LxklxH1lZbutABYDUXPaKzBGu3SmvobU1UJmiMp1h7RXyqqaYiWJ8skiXPOtWD3pU8CxlqKUiHnI++m5XIC9tSFP13C+sbnE959I6QStlYEmP5aq68QwUCCrMFv++lEBCUdypLP9ffPpGljmpwCCns67sljCA6dqSnHkSrNWQvJHqDxZkI+7RNmiGtDdafPnQkxvDHuf69k7CrQeAMJrWOLzjmzyryEIJaQazS1x9FU8lBARdNFbJJFBO7xHXCnwppeZjOh2zLMpAri5L1qK1dBAwji/9aSpZ8J+vH5d/eeaBJIasQSB8lxVufGsqWt1MypKa4azY5w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB5112.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(66446008)(66476007)(66556008)(64756008)(66946007)(4744005)(86362001)(5660300002)(2906002)(71200400001)(91956017)(1076003)(54906003)(76116006)(4326008)(316002)(26005)(6506007)(186003)(6486002)(8676002)(8936002)(6512007)(6916009)(478600001)(33656002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: f7a39Ge5AfDlTP7mdkEurh2xFT1zZOJrJNfd8r342Cg8891fwmWlvqlK14F1UMFa/smnPpKHr5C6SeXkchHJ/0h2DwW3n7SvlOp0AmIPaNlJlIDJdwoY5GHOO/3kzPmnevRKAlRtPya0vBaKXIXOJDGt9bJqiX8a8cBxfXcsvpic7IjfSQ8ttcGi+mkPkO6WAH42gE29RdzYdxK5EGke6ZuIwm0GTLhiS+R6hoA3kzg0YvFqzUUYiBAKpbmH7T5h/gQGPr8n+oExHrr9Cu0OqT4nqpyUxR8dH4pq809gLbhIxFhwNRavth4jTjgGktF72ft6pl03jUx6vHLhZDMdcPnNwuzqqp1IDFUKycCV61EeBzku8WGq695E90UJ4OSHVyBpD4KKfbzvE9AlJ7Y2mZDJ2p1lALudeCxp51xaJE5VpjwW5rW7OiwGa3bIHnDC7PGrOiiX1fQeaj3Llyff+DmTNSuTJtQ7tIbrtl4ahYq7cXi72hO7cvm4blkSQZ0o
Content-ID: <5C75A69D9D59AE4EA4D39151D77F3FAD@namprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bf9e77-3c2b-46c7-813f-08d8185fb9c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 16:57:48.8272 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iMF1qhQ0zlr66JpKXOVLpPeje8LWVff5fz80Kw0ci4QBCiC1fTB0MCVQ00+n+y88tgd07S6VGhG8/Wvg/zji3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4072
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 24, 2020 at 06:44:41PM +0200, Christoph Hellwig wrote:
> This looks good to me, but I'd rather wait a few releases to
> avoid too mush backporting pain.

Chaitanya made me realize that about half of the nvme functions
are using "struct nvme_command c" on the stack, and then memsets
it, and half of the nvme functions are using an initializer.

IMHO, using an initializer is more clear.

memset has to be used if the function needs to reset an
existing struct, but in none of the functions that I've seen,
are we given an existing nvme_command that we need to reset.
All the functions that I've seen declares a new nvme_command
on the stack (so an initializer makes more sense).

What do you think about me unifying this later on?


Kind regards,
Niklas
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
