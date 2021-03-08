Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67C8C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 20:47:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB8364DF5
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 20:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB8364DF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=nR2tRyUGXt8yM5agQXn+XbuK5yItwKuw0+bjydlI6vI=; b=qM/WI0JjnsedRPG2bGPfEImZe
	hANrTMtKvb9m+AlB/S/lT/euQNMAQNPVrhDTfn85BsuX/Top5bwgsMguEMQbNuFa8UoMXdIQhf7cw
	4Iox+6RqEvjlNRBDhP3vPViZtUatQ46WlhwhVXYUhBHRLbU3ttryrj2jYq8DPJhZfM3aX//qc6fBs
	tzCqjo0SWoTnPdT3j0i+NHnQ5ylzET94JVRsnF2Pzr3TH7u9utDKniJWlPAN9Z4x8q7tj8dku1Z8i
	cMj9DPVyEyH9QjhmH8YINwTaXiJO2Zqv3+DmVo1oSChnrDK+QsssOMzMihIgV+ZyMdgdk74JdYdd/
	YYWRlj0bg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJMmA-002oyw-Rx; Mon, 08 Mar 2021 20:46:51 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJMm4-002otW-2G
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 20:46:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615236404; x=1646772404;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Eycb/8I/vuLAqib8WfEymcTGmC3Xfmt1ioJhzMAK2Vc=;
 b=lIOK79678pOZETC6wrZiwcshnFec3R0KDbsGP3Y7HiDBtXVTuTOnmEow
 zS0jmMbexW6MKgNP9qkT3Ls3wcAGcjz2qlTJ16/Mp9aLKir3w7k02l992
 ghr9jxrNRek8+DdQh7VlPXDsq4qWJ1FT2AU9tD8cXFxTc0uzVPP+zvMdh
 e9wic0/gPjHKXuDCB5uiEMbfmVYFEE/ueAN24KSf4c/yMcWnIhUeUsgMu
 8AU/h+fT7bnHiVDMiQcScDEN5IkBNVSra5ywoPdP4wNM3152pPBNw188F
 OOnwAc2+K8Fas2pSME51+b0+hol+Ctt1MFpYNbI1d5vtvoANa/wrHx/0U w==;
IronPort-SDR: b9BIJLYA2gbvCU6LweSlx3ErGxmRRKMYehEbd9pwnDyPVYt1X/OLz9BOkpZV5kTQnK3OGgQfeh
 gRLqnXqUhbZwI8FPubVfvV7Gry0mpzDKQLLvuMcyvnIpJzGwTpSsIBQqxKnz+06cbFeUAqOCVF
 sQPHSVVcp38wFUYaLCcddOB+5+kEFuoZDhjMHHmwI01S7aJ8gHZIAzxV53ngrQFnRtScoffBS0
 U4v0k4AH1gP/Nnh+wIvFvGYTMd8EI/g95xUM7rWVs2DsHusY4853xFhDkZj9h6/7+0VookLSX6
 gSg=
X-IronPort-AV: E=Sophos;i="5.81,233,1610380800"; d="scan'208";a="265977612"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
 by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2021 04:46:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fs92Nht6ceoOCOFncVPY1c7nNHrgO3QEhcsj9vjo6vfolN+wCQbLN92cWAN5nw2a2mxtjaiPlMggYAvl5u/bgY2aIu/Pc8UWMfb6lAWxIaMNBciTwNG6+OKsTozYS9KJsl4jV3z6kt8wn0TeM3WXSt2LJ3KlMD8G8sb0J6PjZYTzQv3ryxmz5s9ZnXs+MUTkBEpLJ7vrjLEkdJsQa0UhO92Lf90KtWq6LZfQcw5joj5lruOrBpS/GipIYUds6/6RWCBJgntUCZJcjDPi1pige+fIW78cxaub37M1A9ZWh/zQ+XeX/G0pk7caDD6lI4vUm++EItdDFqqPITRyUDEkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eycb/8I/vuLAqib8WfEymcTGmC3Xfmt1ioJhzMAK2Vc=;
 b=OTjIOCNaIqAcYI0h0DfLalCN8cU75kveAhnvlq2nqy2GryoWmAsf9RFyKdJXgfzHD549HNhRxcz0squQTyXRmRUiZIxXxDZjF+8SuNK0FuOAMo5i6sVuq+ctIUl1pinbfH+edT78i0DZl4meOSeAW1U/h94l+cKom5yOgKYLSLlR15UqjiC2FQ7hiW5EwkUtpghAznso1T9vTFNwpjsAVKC7+8u/yWC0SZGQMMLkcA0o+iGgTUqzxuOY0ADI/JVEazXBMftXC6vzIrFhKo3ybPZrNACBZkdV+eA4uVlpGxUMggxaHyUlxOSqjs3zfISOHUlS5fwxt5zc8/kA06NuJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eycb/8I/vuLAqib8WfEymcTGmC3Xfmt1ioJhzMAK2Vc=;
 b=ZZ2AqGMoZYZjNoAYkXQKHIxzFz07U7sYzz4TMXHG9mwlj/7HtDe4+na4qiCxRJ0TP+pDWy9wtO4+PIwGeBxPn5bJtNR1dMfu9Va/cdpVZfH6QQVRxpDI4QqgFfGky7U2I1M2JzO9w9I0nH5xBzl77Gtfob5zYqE73rLpmzTJeT4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4104.namprd04.prod.outlook.com (2603:10b6:a02:b0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Mon, 8 Mar
 2021 20:46:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 20:46:40 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH 1/2] nvme: use NVME_CTRL_CMIC_ANA macro
Thread-Topic: [PATCH 1/2] nvme: use NVME_CTRL_CMIC_ANA macro
Thread-Index: AQHXFFEPFR1wwDHKHkqcosmqhqIYag==
Date: Mon, 8 Mar 2021 20:46:40 +0000
Message-ID: <BYAPR04MB4965BC0890723E666D2EE39B86939@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210308191804.8582-1-joshi.k@samsung.com>
 <CGME20210308191846epcas5p38986c0cecce3eb3530cdbd4c66b9ed06@epcas5p3.samsung.com>
 <20210308191804.8582-2-joshi.k@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 058a99e9-c796-4ec7-a83c-08d8e2734681
x-ms-traffictypediagnostic: BYAPR04MB4104:
x-microsoft-antispam-prvs: <BYAPR04MB4104E3A15415D84ED5021E7186939@BYAPR04MB4104.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ot91zz8YEJn+2y8FcdGce6Jm9xoFQqwq9hoVmvUcaZVztMWSdrNv7GZMIan8VitM1rD5RB3MtGQ0AesxX5I98rSLZXYsErBrebCiSi6RaGi7gv7vLsLUXB54dteNZ2uoGX7G2pMh8OaIzc8PZGmNxSxzExc9FwxBk2JPORSGVYYgGBLp6RmtrldT2/bSGuUVXSSjGmRsxlXYEEYxQcVqesCkwhwtV6x8GbUdr7omEdownkWZqm1DoPeH+DZZQjNPZEC1nbwcMq7aghU9E99ML2W+E3+brLhigvc1H8u6xzmK7pzhLUkCreFpU8vM1dH+YTp8O1h9cDoabS1kdOuGmi94qyF7p9pxZOvi/5aj5D6xsn1clA2nG7H1xX4h1JZb8AzoCz/6/vV1nLX5Y6e9N9AG6BA3I7aQqkR9ppRcaCIeToRY09OBlGyMsy7IBaS4KSNM6vXfritDuAPDEk2JWnVAAS91tE9JgD8rG8/qLbLM1JCecUIVMovuQIStvY4CUiVVBVZKyHV2prcmKDjDgQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(54906003)(55016002)(478600001)(186003)(110136005)(4326008)(316002)(66476007)(26005)(66946007)(9686003)(71200400001)(8676002)(66556008)(64756008)(76116006)(86362001)(6506007)(53546011)(66446008)(2906002)(5660300002)(558084003)(52536014)(7696005)(8936002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FeF9kWiGrtU6hnTqDvQk2Q3ECfaIGeitK/yvKc4ZYsuFAmMPyCPrucMCa1I+?=
 =?us-ascii?Q?V6mp7/gdb+Okrn4E8OYYmoaYXLBosRetI4nPR285Za9tyMelQqM6sC2yxbT6?=
 =?us-ascii?Q?GbchzsRLqjku7jRWg9t8w2w2OzkxVRLBbgA7DpJAv1QlEG7MqIgaMRDVW1BS?=
 =?us-ascii?Q?afStGIvMRCeujtrOEcHlUUNXOiYOTSC2hLgOcBguk1zK8JbUu4pKJiHcFfmb?=
 =?us-ascii?Q?aAD3GOJcGXEqxjvQwJ0/b1wVlId2rrYD5pjfVx5/+D0YRPJE+orOMdXLcW/a?=
 =?us-ascii?Q?/3wk8f3osTQ6/jq5eDqBkX1tEAYzfrg2IOi9ALzjaRD2IFJMvvdXbyXO3Zve?=
 =?us-ascii?Q?rGoL0rZSi4FqrVvdgjVj2zZ1Ndi/p5H+ld7PzSX1GC0tugSsV9ivhYCKCa5o?=
 =?us-ascii?Q?ZQ92ZQElu8xen9ogC0QiSUh+NI6QdwIfbIRCu2vCRg4WMYvDULcSLRTrjWiB?=
 =?us-ascii?Q?GFD0h1ox5jyAKQvaZkWlBESfOBm3IU4icZ1RrYC6CoMsPAX72a5wxGDWEwDy?=
 =?us-ascii?Q?12/CVwMb51KIJVfhKsFtqTihEtr6OEA0GSOAsGzRJ/RmpDnj0n4i//+8FHbs?=
 =?us-ascii?Q?Cyqm9WglJq1JatKo/0bGbOaZ21QeIg1ReTrnPLDdP+hBeuAY4VdwkmkadoOb?=
 =?us-ascii?Q?nx57Cgj2U8H5TUorSd6M26t6ZqMeAoqd2FJD/oLYNz4QuUVwq3KkbJkTrtTn?=
 =?us-ascii?Q?4uqBjUyQD0VidBWlS1fCPErYLA6jqizYqWK8VV4SLXAIFzUYL4cZq9jbTArM?=
 =?us-ascii?Q?x9dh3qRWJpwT7/xpR4JwKmnlMzY9dLH5RNCoUZry6QQCpTqvqrMMJnHkokXc?=
 =?us-ascii?Q?/8nOUi0xiymrtHv9isWl4fty4brPkaXunctXRH2iYeC9F0ZmNO84SZyZYMcY?=
 =?us-ascii?Q?73dXTdDoM3rf4YUdJP0h4VSDa60DMlkKbbV/CEslAk334tVyXcsj1ye6Kg9K?=
 =?us-ascii?Q?br2UIttr/Ii5woz98NrxxSwtojmu15aTfFIuNSEC6poZD8XqNwkjAAhxJs/f?=
 =?us-ascii?Q?3nJdU/6BTjxQYo68oSVnOZip3hENJ2wt9tr4DSCCLZ/0FGTK/7BzrjXfyCzy?=
 =?us-ascii?Q?lePGr820vOKLz96QgO2Iuio3p1sGf4nANOEMrvqz5kNTVyKm8zMs6hXNWVnI?=
 =?us-ascii?Q?mpopxdCu+BInMfV8evwWDUfMgq08l8DMcIoHKSdSBrPOOT852Rxdl7UOhQTY?=
 =?us-ascii?Q?IIJplDqDiWHeAsD3L6UCnSuMWeNVJPz3NQeK1T47UVPQpwJ3LMON1tcUSy1e?=
 =?us-ascii?Q?UJeKUTZ47adHkZCtIse/f1jtUsIMRz+gGR0LabQeGwlHhcahg10QWNJzLK4R?=
 =?us-ascii?Q?wPqg8h4CC7cHocgBF4vX4t2+?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 058a99e9-c796-4ec7-a83c-08d8e2734681
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 20:46:40.3924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GTrnms/qtTlyTt4/PG3Jsuzlr9mnSLqFL1tbqFbqGMJxljVL6a/w9keguxL5kgIZjFtAUDhuL0f3zAGQEul6DVFo+/LA1qBD7j4k+orl6+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_204645_460478_64E095F9 
X-CRM114-Status: UNSURE (   9.61  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/8/21 11:27, Kanchan Joshi wrote:
> use the macro instead of hard-coded value.
>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Since the macro is used in nvme_mpath_init() it makes sense to keep it
uniform.

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
