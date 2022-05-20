Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A973DC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 11:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2fNj6Z+yX4mmId4pqqzlEycP2RXJegN+acbcUI/qHgs=; b=ORag7Ir52NGFVijUUPrlvAeY91
	DKoTeAAMI44jy6VL7Qxp2OBTs9yOBsX20rgNLGPE7Mw/k04sA9B6GD2ZHqSyETZtiN7vgRauPip3D
	RNHpv7nIk3fqtD+YWJ2H40Guhw6LPuDJIU29KW/NXCXB/97rsIlNn9rijR/hH4adc9eKfieCMH0Su
	mhwk1u5mdBalTknHnu4oHKw+4ruMf4fn6cSoWMPsE0l4xbs3Or5GrV0px+ng4f4FqZtxH3hCL2L7l
	Wlgax3opzZDYf2SeLq/9n+P5Idxf1wTWsls2zJtnOZYcBRySVDKYiWgBzgXlU7OrUf+PqirYohogL
	8fQWa8sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ns1Al-00CAk9-SN; Fri, 20 May 2022 11:51:59 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ns1Ah-00CAh8-Fv
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 11:51:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1653047515; x=1684583515;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=2fNj6Z+yX4mmId4pqqzlEycP2RXJegN+acbcUI/qHgs=;
 b=S7GRxBlDZpE2lsQpnaTrYebh9VDyr/7O1iH169lta+49voO6HvIddKrn
 84SjapvOQZYJrWKaM3jouJTKGrcYBo9IY//TA508WVqndfXIy/GDQ+Vpm
 Qn+2FWVunHL3WT7HpocYjrWKadG2sY6HEXwqRsTfkZNNXkALtiQ6tTyER
 YFnL4y3FeXCRQVasysrYR076pFi8d1mKrqHYTBWiTlhaZ8y7AhLVaL6dd
 vmMYnhMvhTE66vT5TUgai9mERYLs1fKscTMexWHjpMfBj4JMwD6sMRnV7
 71vrvpa7YUJdsRtdjeEilTigLlA/rGzKTC+oZW0WLfAiS4lrs+H0S/tLw g==;
X-IronPort-AV: E=Sophos;i="5.91,239,1647273600"; d="scan'208";a="312891014"
Received: from mail-dm3nam07lp2048.outbound.protection.outlook.com (HELO
 NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.48])
 by ob1.hgst.iphmx.com with ESMTP; 20 May 2022 19:51:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5HQ8IK1W58kNYe87GWzD+CBDIKmEmYIPQ5AAb2IQJUAdaWXWOz2Tx0/XaHNTLLHokR8RQnuHpm1In+uNQ+QNijJYj4AUf6ftnmfOOhJ5TvhNVkstlChXueUmzFrORNsIQVASmvwwXSCcvDN2y/C1BjZARmyHanIp8uamhzfMlLdb6ztPWVjYLog57amg/YwmCMEqIuEhmbeCbB1wb9JoqIkZNoDOwxLYK9i2GaQahPrkvG4VNAWOjTT/PybTj3ShyRyyX8EjbXJDACGSKtZ3GFh7Qg8entqEmA6ADb01mTuAKqEsAxD+GMXORb/3EA5fH+Uk4esdlKHtf7YgZrMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fNj6Z+yX4mmId4pqqzlEycP2RXJegN+acbcUI/qHgs=;
 b=RO4JvUQUeZeyyK/4bimzJ/xEU+oUgjzASIEv2O3aP+WkinIU8zLrTiP5kYb6dQaT53mmy7NuhlKIreh69kvVn/K05gAw3iPZU08MN/0QkwbYtA5BW1jLFA8XCzjx8DWIJVsD6bcW3HCuS1Q4wmyXfWCDxyqKQZ0PXVa9o18CqUvyQg7ER4uVB3JVVB3pl7R6F5hHGzFRTmGulYfULyKYhpLbMS+dZLRAS2TcplGW3l4W431lZ8MLnJpaqQXGq9HAdvX7aMAyaSMjoh5xkVS7cbPqSS/oJcxDfMA2ag/G0Wwk545mxyGbzQTMz0ce2+88T8wrTC9qJkDUfkVfRhSaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fNj6Z+yX4mmId4pqqzlEycP2RXJegN+acbcUI/qHgs=;
 b=isFvNnqv97toZ3xZTOMJowb+Et881+dmkt/1zX4EpbSbzO6C6Y+FjmCbn/P8BvUFwFE7k5xaPnFo5MwtwH21rlQT61JZQBoqOkaF9GJ/JWc1QFHxmLisWA/bNO5T3pOCL0MK4hGDeQk7HovDKoR6xG1s3EtowYy2xCwkogcX9U4=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by BY5PR04MB6454.namprd04.prod.outlook.com (2603:10b6:a03:1e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Fri, 20 May
 2022 11:51:49 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3cff:7ee8:c1b5:b4e7]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3cff:7ee8:c1b5:b4e7%4]) with mapi id 15.20.5273.018; Fri, 20 May 2022
 11:51:49 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: add support for TP4084 - Time-to-Ready Enhancements
Thread-Topic: [PATCH] nvme: add support for TP4084 - Time-to-Ready Enhancements
Thread-Index: AQHYbD/9MNxk2Gqn+EqHlnIVT743yQ==
Date: Fri, 20 May 2022 11:51:49 +0000
Message-ID: <YoeA1Lh9oxwyao2S@x1-carbon>
References: <20220518064040.3223894-1-hch@lst.de>
 <YoUEf5nsyhVzeDH/@kbusch-mbp.dhcp.thefacebook.com>
 <20220518150044.GA1359@lst.de>
In-Reply-To: <20220518150044.GA1359@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba225f50-81de-4b43-f31e-08da3a571f9c
x-ms-traffictypediagnostic: BY5PR04MB6454:EE_
x-microsoft-antispam-prvs: <BY5PR04MB64541A72100D6FA58B6D9804F2D39@BY5PR04MB6454.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gnBEryLcG6Bs8pu1UtfpSot4peT2sgXEQHGH74TLizKI5T2vUrgkwrXPmk7crx/C7JEDfUz81dW6llqYXKCVTx9zdI1sb2+2NFseAXz1whpMYezndryqMoSjMHHcQWVMt4Eomr2v90cK4VOR6mdeZk+ux/jnuH6nGUMNKXA1ZUtwdsSsUUSM4PcM6qApnc25y2z3L6u2XsDluFiJJI7U5vvsaOaZahjAhcCTE0bur0CDIP1ke77sa36NGfcHQm0W+0h5Xzc93pRUOlbqSCOG7E/cTWwyerfhkqxuyhw7x0rpKpoZqme+w3L2rB/zIitjsvnw7YR8T+tbu3ciwvFsWhjrnRM/b/7eig6QBdhQezCPTLDmqdX5IpCQ8evr/ApItWoYbcSCvMhX/Qbrj6pYWCtm594C66JkVwnYjPOvu/Qvf4QZQQ8wxj2ZvZyOZ0rh2drIeAU/745eykzJ61YW+mDiuUoOynn74P140YT8lB6njV5qxxAmTaxTRCrL4VBtvGKwxPIw8z0aV7RY/YsTrHde+JsWiCaRy+0AIYe2mmYMZCN7cRggi4RWZhCB5SvloRVlNpN9ZWZ03GfkEw0d1apNySVeHXYnczOnxId3zFe8684iFUoQ3VHGMvOv9mK4v2y7Be75Cq9vBhRN66lQK+hPcP7N8srt5kCo00nioLjqaDOZLB+F3GdQUg3lOCTqrZypOjdLEF76k3TWMwsVVQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR04MB7158.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(7916004)(4636009)(366004)(5660300002)(8936002)(2906002)(86362001)(316002)(82960400001)(186003)(71200400001)(64756008)(91956017)(66476007)(76116006)(66556008)(66446008)(66946007)(83380400001)(4326008)(508600001)(54906003)(6486002)(6512007)(9686003)(26005)(33716001)(38100700002)(38070700005)(122000001)(6506007)(8676002)(6916009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUo2MzdaV2NBYzNFUzNHSC9kSktxM1p5SlVoSEtEcVdKZm8vam9lWHZBbGQ0?=
 =?utf-8?B?VGNrL3VGQmlkZlZneDU0eDA5QmdhV2RMcElFb1lzZHZ3bHNVSXlUUUZLZ2du?=
 =?utf-8?B?YlJ1Y2lpWmt1anZLWG9EZjZVZVNWUG1RZjFzN3ZENzNJME95OUtud055TmRW?=
 =?utf-8?B?SEpIai9qOTdCNDV0NmJiMXhERzZNamxNVWV3RlpXeG12RkJjNXpxMmhnSjdQ?=
 =?utf-8?B?aEJ5cy9QL25ld2V5aTlvdHRjOHo0TzRpcEI0R1Z2ZWNaSVhCY2wxdUlpamha?=
 =?utf-8?B?dE1hUHNUMkYyeU9FTjJMTTZGZFlMZExSMG5EeWp4ckh4RWlBT3dMMmYwZVRJ?=
 =?utf-8?B?eUs5VnFBUGVacFpUaDNDNHRQbi9lVGUrVWJGaWlaRGxRZ0tWcGlRYUUrd0Jz?=
 =?utf-8?B?MkpBK1VpSUFoMTdMYWtHajRVd2c5dTNibVpna0xFMDZXZ1VEejRUTG5wZ1dz?=
 =?utf-8?B?SnJOdWkrcThDbVFpaFFQblJsZVJIQWgyNzU0aXpyWW9mR1pKbDNEaktxa09k?=
 =?utf-8?B?RnBtdUs0cGU0d2hOS0djTW96dGlOWWR2bG9OL3pITmhOb1duTGpIaDhPLzZz?=
 =?utf-8?B?cTFuWGdCc2h2OUVTSXlvZU1OMThXWFBNcnl1ektTTERxT3dkY0dmWDJSWUtU?=
 =?utf-8?B?T0ZTL3pmZEZUeC80c3o4OU0vTWVmUW9lSytLRFMvK1p6aGx1Ty9Uc2hCUi9a?=
 =?utf-8?B?QlJ0alA4aHg4QlhHbmhSSGt6VzRUbXZGdm1lOWRPcFlzNnN2Wm1VcGMzRElD?=
 =?utf-8?B?d1lpWXYrYUVMVWZrdWs1MElZUXNPZUF1aE8vZlEwZjlPdWFkQWtCdnBBaWdp?=
 =?utf-8?B?a1d5NmVTaWcrcktRQnluSXp0bWtrS0p5dXFURXd5MklmTkV5VXdTQzdGRUtV?=
 =?utf-8?B?MlRmUG5YWVQwUDdaamZLY1lMbVg2L2IrbVEwcTlHN1gzK00xM1FqY094UnRJ?=
 =?utf-8?B?aVZScURBUm9MNXhqemNWMzlCY29EcEZ5dlNyTlduOTNlQXBIejZSMTF3WFVu?=
 =?utf-8?B?RUVmR3cwMGpmZWhMMmo4WVF6RkVDcXVpNFM1Q0JUUEpGMUVGcGVqNEwrWjZD?=
 =?utf-8?B?K2ZwSHpYWUwvdmdxeGtFOUFtc2Z0SXBPT3poRER1QzljVktZWktuTGVWaStr?=
 =?utf-8?B?eUdyQzY1TlJadzA2MGRnZXlnOXMrTzFDU0oyM3VZWGxKWHNkRUJFc2J4b2Rr?=
 =?utf-8?B?QkJSNStSNW8wZG9mOFNIemZ3K05xVlRYS3c5aHlkRVVsVXExdGdqVS9HckdP?=
 =?utf-8?B?cnlUaXY2M2pVT0M1MTc2ekIvc1g1SERMaUY1azJzYk9QdTdnNGV6Y0tKWDJL?=
 =?utf-8?B?TzRNbDg2NFdqbFIvWUV5WWRRUWwzZ2wvczBEbkx3MUlrWFVmQ1J1TGdrNCs3?=
 =?utf-8?B?WC91QWNUNzUybUpPYTNJZnNMZUxNL1NscTIyZE12bTgvTlA0YmtrUXlZREdL?=
 =?utf-8?B?VXlFclF4eHJGSzRDUW1GTFluN3BobWVxcUN2WEc4QThWTmUxWkZmU3RtcURH?=
 =?utf-8?B?anpsbisxRHp0ajBrdHUwNXlKOXhvZTJ1elY1RUQwN2Rvc21wRHYzQzQ1QmVJ?=
 =?utf-8?B?WVdpTit3NGhzTGNMT1hKMUhLVW9rM0JwUVZtaFlIUFVtWm9OZlVyNnlsUjRy?=
 =?utf-8?B?UDVJVlJGUmUweDFjNWF6azFOUi8wNU4zT2dSVEp6V1hLYVNiZHFheTdhektX?=
 =?utf-8?B?MEJUVmlIN1U2eG1wSi9YQTlyYmhJR1FpQ0JDd0IwV01CSzlwdHN2WFpLdXRG?=
 =?utf-8?B?dk1QSzRGRzhNVGdRNGZVRDlNSEs3Y0NGWEM2MzFnd25ETndNVGI1VzIwdndX?=
 =?utf-8?B?K1FOeWFVQ0twcGs4TWQvSyszOU9SYjE4WlFqOTNaN3VUK1dYd2I3WW5YZlky?=
 =?utf-8?B?VkF0d3RSMldteXkxK3FvVnV0V1ZRVVdKdUhjU3lucHNKdlF1c040MXRGOUQy?=
 =?utf-8?B?SzFnUXQzTkNNUlk5UzRuY1lRd2d3YmNPWW1DWmdHYVY1WFZqWDM5U1Aza1dZ?=
 =?utf-8?B?Z1RBQXozTWVENE9wU1JFQy9FVm5wSThURll3bzJkTTJ6SEdLT2hNUnJvbXVY?=
 =?utf-8?B?blU5Nnh3ZnBNN0NPTXFXV252M1lMTlR4d1VjejJVSnVmaGRKanE2SVdsS05N?=
 =?utf-8?B?dnowcVZQS1QrcmJnVlk0alprTjlqOHAxckp3Rm5BT3pKa2N3eFVvTzZpd0Rt?=
 =?utf-8?B?c3U4UTlvWGZteEljbkc1UVcyMGFJUFM5d0dKWGNZZVdGT0l0SndEam0yNEwy?=
 =?utf-8?B?WWIvYTNhSTA2dHZCcFNSbnNHMEJZY0JTb250TGRkZ2M3OUl3Z2pabWlmVlli?=
 =?utf-8?B?cnI5UWtESVVUOHhBN29YTGVnbGUzaDF2M3NWSDVvREFmbjVaVzVmV3h6SXFl?=
 =?utf-8?Q?KDCErXgVEiClkLD4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D3D08F97D760D4792264A226E6DD09A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba225f50-81de-4b43-f31e-08da3a571f9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2022 11:51:49.3135 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtQgmBNWMiXo75ys23KSbtRpUREza0JTKkyD2+i0QHwhdPz6ztqeWkpKWZK6DqMZGI0f9VszvWpU1W9cjPXXnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6454
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_045155_861428_0DEB49C4 
X-CRM114-Status: GOOD (  34.48  )
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

T24gV2VkLCBNYXkgMTgsIDIwMjIgYXQgMDU6MDA6NDRQTSArMDIwMCwgQ2hyaXN0b3BoIEhlbGx3
aWcgd3JvdGU6DQo+IE9uIFdlZCwgTWF5IDE4LCAyMDIyIGF0IDA4OjM2OjQ3QU0gLTA2MDAsIEtl
aXRoIEJ1c2NoIHdyb3RlOg0KPiA+IE9uIFdlZCwgTWF5IDE4LCAyMDIyIGF0IDA4OjQwOjQwQU0g
KzAyMDAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiA+ID4gK3N0YXRpYyBpbnQgbnZtZV9p
ZGVudGlmeV9uc19jc19pbmRlcChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCB1bnNpZ25lZCBuc2lk
LA0KPiA+ID4gKwkJCXN0cnVjdCBudm1lX2lkX25zX2NzX2luZGVwICoqaWQpDQo+ID4gPiArew0K
PiA+ID4gKwlzdHJ1Y3QgbnZtZV9jb21tYW5kIGMgPSB7DQo+ID4gPiArCQkuaWRlbnRpZnkub3Bj
b2RlCT0gbnZtZV9hZG1pbl9pZGVudGlmeSwNCj4gPiA+ICsJCS5pZGVudGlmeS5uc2lkCQk9IGNw
dV90b19sZTMyKG5zaWQpLA0KPiA+ID4gKwkJLmlkZW50aWZ5LmNucwkJPSBOVk1FX0lEX0NOU19O
U19DU19JTkRFUCwNCj4gPiA+ICsJfTsNCj4gPiA+ICsJaW50IGVycm9yOw0KPiA+IA0KPiA+IEV2
ZXJ5IG90aGVyIHBsYWNlIGluIHRoaXMgZHJpdmVyIGNhbGxzIHRoaXMgdmFsdWUgJ3JldCcuDQo+
IA0KPiBFeGNlcHQgZm9yIG52bWVfaWRlbnRpZnlfbnMsIHdoZXJlIEkgY29waWVkIGl0IGZyb20g
OikNCj4gDQo+IEJ1dCBJIGNhbiBjaGFuZ2UgaXQgdG8gcmV0Lg0KPiANCj4gPiANCj4gPiA+IC1z
dGF0aWMgaW50IG52bWVfd2FpdF9yZWFkeShzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCB1NjQgY2Fw
LCBib29sIGVuYWJsZWQpDQo+ID4gPiArc3RhdGljIGludCBudm1lX3dhaXRfcmVhZHkoc3RydWN0
IG52bWVfY3RybCAqY3RybCwgYm9vbCBlbmFibGVkKQ0KPiA+ID4gIHsNCj4gPiA+IC0JdW5zaWdu
ZWQgbG9uZyB0aW1lb3V0ID0NCj4gPiA+IC0JCSgoTlZNRV9DQVBfVElNRU9VVChjYXApICsgMSkg
KiBIWiAvIDIpICsgamlmZmllczsNCj4gPiA+ICsJdW5zaWduZWQgbG9uZyB0aW1lb3V0ID0gKChj
dHJsLT5lbmFibGVfdGltZW91dCArIDEpICogSFogLyAyKSArIGppZmZpZXM7DQo+ID4gDQo+ID4g
SSB0aGluayB3ZSBuZWVkIHRvIGNvbnRpbnVlIHVzaW5nIHRoZSBOVk1FX0NBUF9USU1FT1VUKCkg
dmFsdWUgd2hlbiAnZW5hYmxlZCcNCj4gPiBpcyBmYWxzZS4gVGhlIGVuYWJsZV90aW1lb3V0IGlz
IG9ubHkgYXBwbGljYWJsZSBmb3IgdGhlIDAtPjEgdHJhbnNpdGlvbiBhbmQgbWF5DQo+ID4gYmUg
dG9vIHNob3J0IGlmIENSSU1FIGlzIHNldCBvciB0b28gbG9uZyB3aGVuIGl0J3Mgbm90Lg0KDQpG
cm9tIHRoZSBDQy5DUklNRSBkZXNjcmlwdGlvbjoNCkNoYW5naW5nIHRoZSB2YWx1ZSBvZiB0aGlz
IGZpZWxkIG1heSBjYXVzZSBhIGNoYW5nZSBpbiB0aGUgdGltZSByZXBvcnRlZCBpbiB0aGUNCkNB
UC5UTyBmaWVsZC4gUmVmZXIgdG8gdGhlIGRlZmluaXRpb24gb2YgQ0FQLlRPIGZvciBtb3JlIGRl
dGFpbHMuDQoNClRoZSBkZWZpbml0aW9uIGZvciBDQVAuVE86DQpJZiB0aGUgQ29udHJvbGxlciBS
ZWFkeSBJbmRlcGVuZGVudCBvZiBNZWRpYSBFbmFibGUgKENDLkNSSU1FKSBiaXQgaXMgc2V0IHRv
IOKAmDHigJkNCmFuZCB0aGUgd29yc3QtY2FzZSB0aW1lIGZvciBDU1RTLlJEWSB0byBjaGFuZ2Ug
c3RhdGUgaXMgZHVlIHRvIGVuYWJsaW5nIHRoZQ0KY29udHJvbGxlciBhZnRlciBDQy5FTiB0cmFu
c2l0aW9ucyBmcm9tIOKAmDDigJkgdG8g4oCYMeKAmSwgdGhlbiB0aGlzIGZpZWxkIHNoYWxsIGJl
IHNldA0KdG86DQphKSB0aGUgdmFsdWUgaW4gQ29udHJvbGxlciBSZWFkeSBJbmRlcGVuZGVudCBv
ZiBNZWRpYSBUaW1lb3V0IChDUlRPLkNSSU1UKTsgb3INCmIpIEZGaCBpZiBDUlRPLkNSSU1UIGlz
IGdyZWF0ZXIgdGhhbiBGRmguDQoNClRoaXMgcGhyYXNpbmcgaXMgcXVpdGUgY29uZnVzaW5nIElN
Ty4NCg0KSSBpbnRlcnByZXQgdGhpcyBhczoNCklmIENDLkNSSU1FIGlzIHNldCwgYW5kIENDLkVO
IGNoYW5nZXMgdmFsdWUgZnJvbSAwIHRvIDEsDQp0aGVuIHRoZSB0aGUgY29udHJvbGxlciBzaGFs
bCB3cml0ZSB0aGUgdmFsdWUgb2YgQ1JUTy5DUklNVCB0byBDQVAuVE8uDQooSWYgd2Ugd2FudCB0
byBtYWtlIHVzZSBvZiBDQVAuVE8sIHRoZW4gd2Ugd291bGQgbmVlZCB0byByZWFkIHRoZSB2YWx1
ZQ0KYWZ0ZXIgc2V0dGluZyBDQy5FTi4pDQoNCldoZW4gZG9lcyB0aGUgY29udHJvbGxlciBjaGFu
Z2UgQ0FQLlRPIHRvIGNvbnRhaW4gdGhlICJkaXNhYmxlIiB0aW1lb3V0Pw0KQWZ0ZXIgQ1NUUy5S
RFkgaGFzIHRyYW5zaXRpb25lZCB0byAxLi4uPw0KDQpTaW5jZSBDQVAuVE8gcmVnaXN0ZXIgY29u
dGFpbnMgZWl0aGVyIHRoZSBlbmFibGUgb3IgZGlzYWJsZSB0aW1lb3V0LA0KaXQgaXMgcXVpdGUg
aW1wb3J0YW50IHRvIGtub3cgYXQgd2hhdCBwb2ludCBpbiB0aW1lIGl0IHdpbGwgY29udGFpbg0K
b25lIG9yIHRoZSBvdGhlciwgc28gd2UgY2FuIGtub3cgaWYgd2Ugc2hvdWxkIHJlYWQgQ0FQLlRP
IGJlZm9yZSBvcg0KYWZ0ZXIgc2V0dGluZyBhIG5ldyBDQy5FTiB2YWx1ZS4NCg0KSW4gbnZtZV9l
bmFibGVfY3RybCgpLCB3ZSByZWFkIENBUCByZWdpc3RlciBmaXJzdCwgdGhlbiBzZXQgdGhlIGJp
dHMuDQpTaW5jZSB0aGlzIHBhdGNoIG5ldmVyIHVzZXMgQ0FQLlRPIHdoZW4gQ1JJTVMgaXMgc3Vw
cG9ydGVkLCBpdCBzaG91bGQNCm5vdCBtYXR0ZXIgdGhhdCB3ZSByZWFkIHRoZSByZWdpc3RlciBi
ZWZvcmUgc2V0dGluZyBDQy5FTi4NCg0KbnZtZV9kaXNhYmxlX2N0cmwoKSBkb2Vzbid0IHJlLXJl
YWQgdGhlIHJlZ2lzdGVyIGFmdGVyIHNldHRpbmcgQ0MuRU4gPSAwLg0KSXQgcmVsaWVzIG9uIHRo
ZSBjYWNoZWQgcmVnaXN0ZXIgdmFsdWUgdGhhdCB3YXMgcmVhZCBieSBudm1lX2VuYWJsZV9jdHJs
KCkuDQpTaW5jZSBudm1lX2VuYWJsZV9jdHJsKCkgcmVhZHMgdGhlIHZhbHVlIGJlZm9yZSBzZXR0
aW5nIENDLkNSSU1FDQooYW5kIGJlY2F1c2UgdGhlIHJlc2V0IHZhbHVlIG9mIENDLkNSSU1FIGlz
IDApLCB0aGUgY2FjaGVkIHZhbHVlIHNob3VsZA0KYWx3YXlzIGJlIHRoZSBsb25nIHRpbWVvdXQu
DQoNClNvIG52bWVfZW5hYmxlX2N0cmwoKSBhbmQgbnZtZV9kaXNhYmxlX2N0cmwoKSBzaG91bGQg
Ym90aCB1c2UgdGhlIGNvcnJlY3QNCnRpbWVvdXQgdmFsdWUgd2l0aCB0aGlzIHBhdGNoLCBldmVu
IHRob3VnaCBpdCBzZWVtcyBhIGJpdCBmcmFnaWxlLg0KDQpJZiB3ZSBldmVyIHJlYWQgYW5kIHVw
ZGF0ZSBjdHJsLT5jYXBzLCBkZXBlbmRpbmcgb24gdGhlIHN0YXRlIG9mIHRoZQ0KY29udHJvbGxl
ciwgTlZNRV9DQVBfVElNRU9VVChjdHJsLT5jYXApIGNhbiBwb3RlbnRpYWxseSBjb250YWluIHRo
ZQ0KQ1JUTy5DUklNVCB2YWx1ZSwgYW5kIHRoZW4gdXNpbmcgdGhpcyB2YWx1ZSBpbiBudm1lX2Rp
c2FibGVfY3RybCgpDQpjb3VsZCBwb3RlbnRpYWxseSBjYXVzZSB1cyB0byB1c2UgdGhlIChzaG9y
dCkgZW5hYmxlIHRpbWVvdXQgaW5zdGVhZA0Kb2YgdGhlIChsb25nKSBkaXNhYmxlIHRpbWVvdXQu
DQoNCkl0IHdvdWxkIGhhdmUgYmVlbiB3YXkgZWFzaWVyIGlmIGl0IHdhcyBqdXN0IHNlcGFyYXRl
IHJlZ2lzdGVycyBmb3INCmVuYWJsZSBhbmQgZGlzYWJsZSB0aW1lb3V0cy4uLg0KDQpJZiB3ZSB3
YW50IHRoaW5ncyB0byBiZSBtb3JlIHJvYnVzdCwgSSBndWVzcyB3ZSBjb3VsZCByZWFkIHRoZSBD
QVAuVE8NCnJlZ2lzdGVyIGFmdGVyIGEgcmVzZXQsIGFuZCBzYXZlIHRoYXQgdmFsdWUgaW4gYSBj
dHJsLT5kaXNhYmxlX3RpbWVvdXQNCndoaWNoIG52bWVfZGlzYWJsZV9jdHJsKCkgdGhlbiByZXVz
ZXMuIEVuYWJsZSB0aW1lb3V0IGNhbiBiZSBhcyBpdCBpcw0KaW4gVjIsIGl0IGRvZXMgbm90IG5l
ZWQgdG8gYmUgc2F2ZWQuDQoNCg0KS2luZCByZWdhcmRzLA0KTmlrbGFz

