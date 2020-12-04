Return-Path: <SRS0=dg6g=FI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A478BC433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 03:20:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4130822513
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 03:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4130822513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=hGY5+StOVL3/iSaTbdacJqhD+gJ8gxriRiPUy7ow9Ak=; b=sCgIqcpMcdwMbRxz1uVR4F3wa
	ujAIH3D6jZc4x72AnFkdwdfJBSS+vMOYWJWC5ZTstPd4m2CDnYsBFcGnSr4oqkX/U0aycBBVeqZwY
	rGz57BnXyIvGNqwAwp/3KcytawXYLBTSSXbmJvKXE3cQclu5jbiiEsK5/vWvE4si24SOUit2L/zQe
	QX7E/+raULJGlj6Zhgfsv5edQCRWgtbzU2k/BQ741x4nVOAB0SgDlL6G2pxukNLgE9/LRnMVLdBYe
	JzuRPwMKGmED7253U3rkcY8lQVBsXSr8uMWRLqBlMU0zxQ1q/T9SnXoNU0ECgFjJ6RNUR47yXCWOd
	6Zkle6kkA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kl1eK-0003K9-Tn; Fri, 04 Dec 2020 03:20:49 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kl1eI-0003JE-0P
 for linux-nvme@lists.infradead.org; Fri, 04 Dec 2020 03:20:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607052046; x=1638588046;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=OhNqDDLf3+RRG1JcNXqN7NHnwEPZ0oU0ZearOVqFXgI=;
 b=CBeJdhhW6CYnCVjesQsaZu9mi4v4EMqaDyyeBbPmkX2qMlI/XC4fPsrD
 JKsXrg3Q2FdYM9iFRFrIwxL4X74JgeJPK46q0kRYSw9AxP8idL8BA46Mm
 0d7pkY46Bo1wE3LFk7TY4ryfYWbA5oR1GLf3vQIxLrMf8KvB/eOhcIAvu
 h9WYZ8/nmG6R8iXiBPTzEyYeXiODFTigZdZ+o7gS7+eGQtdsiLzTrwnNR
 tRRN0UbJsGthBaYlbquoMiW70ZOxHOKoG62syhGfep5tFo8Hm8a3nSpkp
 B2hIFWSwxKnrtqDzj/0gDr3oKxwO8cbxORl11TdyNM6CGL/mgvwWyl1RH w==;
IronPort-SDR: oZiojuzW8PE/65kwjwJBwO/t2t/igC+5gjhhkpKhfcWtvc0Hm4KXCAM5gLovhY0TxG2FV6nHD1
 8ksDRDDVQ2EDyyMVZO7EiAZPB3LcN4MLiiuwPEqMUexkvmX6qnf+GNqLEvSGGXRigrnQi671Nz
 Sh/mLgLOJbW81JqsO25UZ65nrwNxtkuJkbjoSt/uESjFTVJO7OoBX1mklLxzQ91J523hB60en7
 oXPSPh9pgEMMOJmLVjL4tr5Fwv/XP4Ungu62tG2gaMpLkSGln2CM/ACQB29DYf22BMik52gt9H
 g8A=
X-IronPort-AV: E=Sophos;i="5.78,391,1599494400"; d="scan'208";a="155613407"
Received: from mail-bn8nam08lp2040.outbound.protection.outlook.com (HELO
 NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
 by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 11:20:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3qs+eyCeiRstJlyooTMRmnL35heDQlPb+8xRmkJY4wYq2O6yKnGyLu5Ogqe671cuMh1Fum1jgStubLm27DVaPpuNFahrRfVZyfXlyOZ15dctgQpfwIIAAnHsLt1hx0pNJgcyino4xtxwGTM1oBGfOX8fnHU+bM4GKVoqtRhhbh6cg2AK655+FpC3xI9evRfM/1P+bBXPcaIQBAWOz/e75bj9VpgM4nT3pQkxu5b+yree6KKd6I7TKsKiJZ2Nidv0t5WMxcJeTHJCFi11EF8YNenTn7ARCETKG8t4qbg2tO+V5gqzxKrLr+56iaBewqZl+BwmuXJS1NYYzNt10rtNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhNqDDLf3+RRG1JcNXqN7NHnwEPZ0oU0ZearOVqFXgI=;
 b=g2tL7XwKIh4ONprk3KGklZj5PcCHJH/VV9fSh8x1jI91Xl9XHwbGv+mOOLVmofZvZFA/SBit4N8U3/4zdzU6CgLFue0c95tsuZkk1PrB8eb4STKWw9sSfMtX86850eYIebC1qHG0Psr3fRREALT3eLao4Sw5qrNv67V9CqNHspB/4xY/UH+TPHmKdXQHS9CpeCoyeEIHrmblOyTu0cuxRYEvBtsOvpYciEeJrkZ/3nxjqn0Bdh5SiThr8vRbGqpdImMTRnEaa4RMKTma8scRkP3OThw0FcXgd1R0sz1RFZgCkylTaWXoGrqYPrYu5kBJ9X9cq1z1bEEsCVeHYZzSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhNqDDLf3+RRG1JcNXqN7NHnwEPZ0oU0ZearOVqFXgI=;
 b=J0LKl43FUzZTPa8TQk07iGGS7nFvasg1zEK5uCgLC9bkeVDZDwLyUqku5Omw55KAwhIHvxo7HuAc/TyxbM9tggB4z4cJnv6RHpGdPMatrKsHhbM+lBY+1Id0MECAqXj/iKC7yRx0mVAoeykc7p70ocMY7HqqtDzUuQMCV3CiArE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7501.namprd04.prod.outlook.com (2603:10b6:a03:321::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Fri, 4 Dec
 2020 03:20:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Fri, 4 Dec 2020
 03:20:40 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 5/9] nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
Thread-Topic: [PATCH V4 5/9] nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
Thread-Index: AQHWyHOq9iPpg1Z8ikysV3+jvL0kGA==
Date: Fri, 4 Dec 2020 03:20:40 +0000
Message-ID: <BYAPR04MB49654267EFD18AF2A65BECB486F10@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202062227.9826-6-chaitanya.kulkarni@wdc.com>
 <20201202091018.GD2952@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 147febf4-6c10-41c0-aff4-08d898039408
x-ms-traffictypediagnostic: SJ0PR04MB7501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB75018BE5E3CD5B1FA509276686F10@SJ0PR04MB7501.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CkoF9VVzAX0vmlvpk0vjsaOHzp/iNpIr/t2RN6y84Q//qssq313msrryvTShHXK+g2RsWN0ukSs4TR1VIGxokzzxs7gRrAfR1Z8+UrryVSbHvjvm2KLizzIAALwyioJPE3m/dNL0EdRsJOyI9UkPRGZ2keZvPfkGum1pcvCE27WxMDyntyHMeL3jgd8CUS/3Sd82zxZg09VL3F3KVaf1keAtgCvRAZzd4d9ui90y6hRVMA4UJPo5tsfaJN+jdvTEFT5mlOdfGSF5q99wmVr7xO8rjOHoVT5mQO+VVpBja7GdEl6N2tHITpbCCLuU2NH7C/sEV/c1VcdNUmz5piWTGA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(52536014)(2906002)(8936002)(86362001)(186003)(8676002)(478600001)(55016002)(33656002)(6916009)(5660300002)(26005)(66446008)(66946007)(66476007)(7696005)(66556008)(64756008)(9686003)(316002)(4744005)(76116006)(4326008)(83380400001)(6506007)(71200400001)(53546011)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YmutPGQ4Of/GC7qNeWJufeDdkh9aC8YWoHVs1u5reFXiTf8QZQYS9VrzF3ZP?=
 =?us-ascii?Q?UEU9g23mszAJjm0RdOqPHMb0CLcf8t91C0FPzODtZijNPPoLVX9U5Cyh/0tu?=
 =?us-ascii?Q?gvKa0A3qQXRdHTLa761UiNf7mqOGN+oOxCcPdQY907DuJD3pqjTqEpL0NkkZ?=
 =?us-ascii?Q?qVDc2h4wIbT87y/ksSUoY5fGeaeuggjgddgHF6WWH0jkWal5g8AnEcJSgZ/9?=
 =?us-ascii?Q?TwIu95ep9ToHyGM6P0w0cT1yrxV2Geygo3VEpE5NPDfXKgEIdwySffHcNa02?=
 =?us-ascii?Q?o41ojQnL7ZeZjvAU2YhP0Wu1/1Br4JG8g4J3sAYuWJJ7SvTtaYG1dl+tcQJU?=
 =?us-ascii?Q?QkPXxMLfCwH5RtV0+iGwYcW/C9IWWWqBL/yxiABPbrdbSigc0n5fWJwTqGsm?=
 =?us-ascii?Q?faCtOpdJkIHy7qTERYFnW5n1NwM+5LngvvP5Y/ezCaPRjT+2bx04ZYScR1oK?=
 =?us-ascii?Q?MlK6ves/ad0ANRjBQyauASxPbCdjPb183+C4ZelOgYVomDg/nOyW4b0TjN4i?=
 =?us-ascii?Q?yt7HK7N5aHKuKQ0GLZZ6DPCrdbDQrYLSf71DeKZhphL2AQ7sHbMcHpYP6boh?=
 =?us-ascii?Q?22G7jmLGnXk7C7dWJ/0+9hkOzE18475ictS52M+RHcklnKOCmNCrUOYf5N5l?=
 =?us-ascii?Q?shb44ybT8j10YoiS9SJ9ZfVC6J8WG7rxQbjp1OziX+ipOc02gXph1eYw6j1x?=
 =?us-ascii?Q?un2d1i2qqn4ksOdPwbaUhvjdtrtznnwK3fO2KHxyvl+qbcWzk/jB8fOkHZHS?=
 =?us-ascii?Q?HqcQ0U7/JLaCGzZRh0aEbfA0SF4dcqRVu7EtedW+4OAnzOgouqNIjE1fksZ6?=
 =?us-ascii?Q?MW6L5lne/Bq5k+A3gy8OLoZwgCaQcvp84IP/xmM6CgMefxU06FYrEb+56JVX?=
 =?us-ascii?Q?btzPubfOwJG7HWX/AQXmXwJiZjPyVhMtKCirUpckbjNwqNYRVxrtcKf+fP6A?=
 =?us-ascii?Q?fkzC0ajBDgMyoc4n1kDLpqBilIoOjkw9Wzs/cYGbCZQaYCL0kDuBjxa36MUe?=
 =?us-ascii?Q?/xqL?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 147febf4-6c10-41c0-aff4-08d898039408
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 03:20:40.7946 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWqqEdo45hLImUTAN8Sw+CPyH9e/x107ZzRvpVFPpClDessQetzHZnrW11xRejJuYbknbpuG/Lb64h20Ad0MLjD77d5bPr6hmPZm1FMKcgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7501
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201203_222046_174650_7DB98C25 
X-CRM114-Status: GOOD (  14.43  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/2/20 01:10, Christoph Hellwig wrote:
> On Tue, Dec 01, 2020 at 10:22:23PM -0800, Chaitanya Kulkarni wrote:
>> Update the nvmet_execute_identify() such that it can now handle
>> NVME_ID_CNS_CS_CTRL when identify.cis is set to ZNS. This allows
>> host to identify the support for ZNS.
> The changs in this and all following patches really belong into the current
> patch 2.
>

This and each following patch doing one specific thing for which host

side component is responsible, with one patch for backend handlers and

wiring up of the same on for admin-cmd.c and io-cmd-bdev.c seems

we are packing too much into one, unlike what we have has a nice

bottom-up flow for the implementation, why not we keep that nice flow ?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
