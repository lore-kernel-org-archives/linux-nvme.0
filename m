Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB79EC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 20:49:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D16E64E02
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 20:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D16E64E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=zH1fIFNbKGVF49XxLyv7y3WNlesy060MdP5kdGbz3Kg=; b=dUJAfuuCHtQyJss3XMS/IOh3W
	WtvS5szbGiSyTBoZKLngmZJlvvx80oAzF/T2TS42qjfL/UI2bQlIGt22rSLDX3b0HH40gzy/hjTUy
	xhoh3GNhhwWgyoq+WX/aFb8WfdPoXNBANA5+kS9WlDaNFYwgkhTQzQ01U5yuhMJeEIVXfu0tCmKpa
	MD9Uzg9mVeg/uyv68tOty+xi4okCYJ2kinoLRxM5MBpsK5fSjbXE3XWzE9aHW7Lk0e/e5vl7GWzi3
	0T6AvFmORS/h8JR+2RfQECXtwSexUPsSLA5+Z4V7Alfkre8zCYEh5uRDzhc44IbkNygjBybJFrIrS
	6NrvC25Qw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEeca-0004rD-In; Tue, 23 Feb 2021 20:49:28 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEecX-0004qR-HM
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 20:49:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614113365; x=1645649365;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=btBDoGfGCrMYiBlPKOlhzPibhcHxK3a7hMBhAXAhtTs=;
 b=bo03Fz8P3Xf67pFcumr8AOUFf8ohFrV3T7XQw0MK4qZfizekbLdEh0KI
 hVAB5BJctpL6WY3Jg9AYzZvB2SVK+6nCsdBeas7SFqEtHy2uIPiCYj5Pc
 zvOLJOYB2ic7r4y+KswLLKT63LuHUkGPj3LqS0lH7mGT0UbWDEAqCfeXo
 ScgPmo5jferfLO0rXgl5k61F7TG/JVvTZ3pXvVjVZc2VcPOLFQeDfXTfF
 BSOO3nrVe3OW/76X7KKZq2G9I4SdxZokylU8xBGSYEcxCQULUS4Mqia3P
 0BmyfGvDx9XHF+KcOwmWVRtA44FxOMAWeBjLQ9SFQH1Yjn5gwYlHDjWzg Q==;
IronPort-SDR: 2jJVrr04L4jFyMJTesdyine5VFcyEaJh5uBXaEQ+gL2htI1D/qGD7oNoykgvFK3oONLwUs8ygU
 DqKTz2Gl48BiUZyBngf6FfWudYyVqB7lNJuEweOjl1kXf/KodWlUjR4nTry50rPjSD8n0Yswzv
 i8twF2IJ4Ezv6X+f7IEhCcBxLULaxkXaKobhtCbgfXPa6/FOSueUiz18jvjcp/fLvM2Pw0mDA6
 iMQ8MRC/JmdnY55LtNOCtSG7d/hubnTAw7czAre5kBQYEkcmBUc8YgC+GOYci4cT1fiee43eKQ
 nII=
X-IronPort-AV: E=Sophos;i="5.81,200,1610380800"; d="scan'208";a="165112250"
Received: from mail-bn3nam04lp2051.outbound.protection.outlook.com (HELO
 NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.51])
 by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2021 04:49:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKpoPVniiDc0zuZTpQUlFxa2T0uyGltE524BhfhONplGivJYBwQr/BiHN5/URsgEUGXqnPzMxUks4bGD7EbS7AbmAFQRxMpOJ+HjBTOR/vV/ulnnRIPdGl1k3MYlq828kDachu7bq5FKA2KFHMbk9M+r2OLG5u6dzMn0DNBd4ogvgj7X6MlvtN2MASEQJSBYuVnXMBPls+vP9xjAElGxdqKaPuifQJ5jgWeKBJ01RuDp2PWt2u5xchlhIZfkcD981XhFV8kUvL2H6RV5GM03od6tvl6Xk9pgnluUVOr3ARnnzpPs6UF7s9VDs6sBDvNtngyeHEl5MbhHaOpPlfO3Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btBDoGfGCrMYiBlPKOlhzPibhcHxK3a7hMBhAXAhtTs=;
 b=Cw2LrvFsoUCM1coRB9lI6SottXAbNh9xEchUGtCYYt5Kna0VwhWzyeS5DPKmI/Vzb4HjeLuFdTGeFN4p7zNzKJfs9u3+DXd7YJWOnm0Ovta8FbV3/a7IQpULMbN1NV2/Yu0m/uTODApXDtb7vNICeGTqLJzLVQ3wB86WR3CRSkxebcXg4z3WUtCUaYawOERgKC2wLtlwg2KXkX0tqQgEC6y9ILIirG27TcnunSqA+8xzdY2RYxZ38uWjGA1vaOT/Bh90HIKbZ92xbnkoQaxTHICTRAdUQOkq0P8wM+9W/qN94RQJ3O5YjnxNn4jJmFb1rxMAFjD/1Gpl/skTq7Gcaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btBDoGfGCrMYiBlPKOlhzPibhcHxK3a7hMBhAXAhtTs=;
 b=bcqxXvJOpcf9I2TNqI7PlJHZ1TC45WJydvDrUWnWcXjvPaHdSvL7oGommEJMoRxi0Cgedb+deM0w4UL67KdtEJvC/OLcUDbcQ30fk+n9QZrQ8IIr2zMVOGtOq538ZRitSVF6gbTVsOxgji+/ZsQjFbQBhxlAYVC3diXB1D0vkSQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5525.namprd04.prod.outlook.com (2603:10b6:a03:f1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Tue, 23 Feb
 2021 20:49:15 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 20:49:15 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 1/2] nvme-pci; remove the barriers nvme_irq()
Thread-Topic: [PATCH 1/2] nvme-pci; remove the barriers nvme_irq()
Thread-Index: AQHXBomyHP5k+19jV0Gr3sfDsICftQ==
Date: Tue, 23 Feb 2021 20:49:15 +0000
Message-ID: <BYAPR04MB49657DA30241D7497D9981B586809@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210219063726.63728-1-chaitanya.kulkarni@wdc.com>
 <80fc53d2-4f35-7c72-5cc5-3ec13c5ee51a@kernel.dk>
 <BYAPR04MB496513669571FA6541E58B8686809@BYAPR04MB4965.namprd04.prod.outlook.com>
 <f2d9cd44-8f24-a4ee-ca26-a1d2b8c74c3d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ce8106ef-ceaa-4681-68ac-08d8d83c7b97
x-ms-traffictypediagnostic: BYAPR04MB5525:
x-microsoft-antispam-prvs: <BYAPR04MB552519184860D00AF024E2A786809@BYAPR04MB5525.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jzNu4oZFKa1DFRsKRAIxjIw+Oze+zVnqgr2LmWoKS1aaMYwk/Ni/OVDymKpImDCrg9Bx20mCwzkjvPWjkX/sTStTcggMTw/Bp42EHZRwZgvNfJ0UUptQnPjpwgf7f5d2bxNWm5K3K0gSM4HuDEvJjjnC3bHqqNGRfEyIZZ/4QbBU9Omd7BPPSU04nk7vND+MWws7lQIYwWnTvNEi5kwLAepwwSKqExWbqi+PmhEqIppCXkeSkO/b+eccrwXboYEvqaBuSenbvF3L5ESNvlY6lK5tRghf8JO9z2Phut2at1B6QsjjWZCzVcXAW/D48wffxqeLRBOmdoFNbATgpy7GTpfO5qzIjPjla6HYOi1UKn32lm3VbTxPESPhNPwNWIfYPuMsm9HpyCU4e90kknGX97H2J5Ji8g4kcO/i0fAA2eJes3S4/8abl7yBV8jSWLcipb12lM9x1ozqzLUng/0GI/zP2yzhLehs3mzLCnTuE9aEg9w8ym4jC7rGrrT/0r4BEA/aBTrZVZHCZA7ReIrFPA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(53546011)(54906003)(26005)(6506007)(2906002)(66946007)(64756008)(186003)(558084003)(7696005)(55016002)(9686003)(4326008)(86362001)(76116006)(66476007)(66446008)(52536014)(5660300002)(6916009)(66556008)(33656002)(91956017)(316002)(8936002)(71200400001)(8676002)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?lFAS3fJT6v0uiQGszp1UHU3jBHXK50BVMQ7ZcYmYoSWmZerOnoF2Wv17XUG0?=
 =?us-ascii?Q?uNxnOiwA2ZFXOa0fjnO/+uXC+124YvR0PeThEWEpAGtRAfodP5iLOmt9rJby?=
 =?us-ascii?Q?OPiAPUmnGMGc7Buv3oMlirNAIzsdl+/7D9xedDhiAxn84Mt5g00cHQeGSvv/?=
 =?us-ascii?Q?GxN1xar6VH6nPE5BfIggmt3lTit2l24VKVLtTzePmDoUkkkKKGT5vNJulCr6?=
 =?us-ascii?Q?0eKsbhaeIqwBks4wYA06XaiUKMR/02AznKGFR+sa+tXz2IbwlI75K2z1JHm6?=
 =?us-ascii?Q?W7HUGoPT2XAPg1xoA8CPArmVolEtWpejQRGbv0RnJa+HQ84hWaQdepEhbAGG?=
 =?us-ascii?Q?k5ge9ZSXtaE02Co6B3N3Vx8FnsWYjrfp5ysSpRWSXo9j23NspEHbaHB99NVR?=
 =?us-ascii?Q?m/9UtwWFCenP8uTa7o5IyY+r7bbmJPLIY8+psEaeC5dJq1/eN0xkAt0gVrGr?=
 =?us-ascii?Q?kE4GxWXFKUZjj+XXyxVNkrxYEfrsjaGk4lYcEqdkfX3JwQeKOs6YLB+WyVS9?=
 =?us-ascii?Q?7P0IXtgTSWchcnVZiLabCF2Cky30fWKZr5MNQ42zvq62x3dO+H6TSAtRDGQb?=
 =?us-ascii?Q?fG1/j6eaMUYfPD4TvOxuSSgMV+Ixr9/+j87hmiU34opTubMuejvkonqHHR5k?=
 =?us-ascii?Q?MYL2topfMPNA5sp+ykXRROHtWa4JqCKAMaQOtPhDgGS1BM7wdkaa6u4K814Z?=
 =?us-ascii?Q?/SLrBoJC1N2b/bAvUPLYWgS6cJQ5f1RB62yZW3GlYoRDyk4g9sXnaAOJVZwl?=
 =?us-ascii?Q?JBX8ayrJwhhMqVevfGonHeMwMteyhlNM3jXmjFn1MyuujFK6qX/GHYsCISrc?=
 =?us-ascii?Q?K/4uc5SDzmX1LtKHL1fHLCaham0mdJLLb1xZZUOtiU0JIdNc612dA/5HDafH?=
 =?us-ascii?Q?chfKID4FHCLm9fV0WFC10JnFDR8AGqFyhHERQTwcpJvnJVzkwcLjtAfcSm8V?=
 =?us-ascii?Q?29hutEDXvb9N7QlQHf1+D3Vj9xe2xYzxVFS3HVwNt+au1OVSq3yAvCpAED1D?=
 =?us-ascii?Q?kBlBkyLFOXPQYodlI1tkq5S31NZbq0Z2SbzMjY1ydRp2YvUIvnJ/PT9WIkiu?=
 =?us-ascii?Q?FDQ71ryLmIWrmILS5kXam/CupSTGUFBPUb9TwkxTfiDyA+MlzkaOM4NsycHX?=
 =?us-ascii?Q?DOgLOYrHqiSeAMUOBZU9K7U1/AlALutoRn+QDgyYi0WeUTJkmYGIPik5K66R?=
 =?us-ascii?Q?bgI1dhKTytzMPJxu/A52xGFdhL8OpJ/uYuxktkwW36CAgE5ODoky15a96LJE?=
 =?us-ascii?Q?JXUYO88kcRSM4lKu0zjqgyd8d9zPbs6CuvzXKjVS2iKMpbCi3ZACKj5tyAMm?=
 =?us-ascii?Q?ya+NcYnN2iYtO7ytOE4ceJRq8Pgvyvk6VmUQPtgZrvPMmg=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8106ef-ceaa-4681-68ac-08d8d83c7b97
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 20:49:15.5333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 922Pd1W+dcC+SaLIA6XVuh8c1xyuATF4l9K0vQZpEJrOVWQU7AcqQPWjicYzq+7IYXDXfiqtiy6oARemttPiGiCqdm+MN2WA5JokuSWSZns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5525
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_154925_849771_35E28883 
X-CRM114-Status: UNSURE (   9.62  )
X-CRM114-Notice: Please train this message.
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
Cc: Jens Axboe <axboe@kernel.dk>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/23/21 06:36, Heiner Kallweit wrote:
>> Please let me know if you want to send V2 otherwise please ack this series.
>>
> Fine with me if you send the patch. You could just add a Reported-by
>
> Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>
>
Done, please let know if you find any issue with V2.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
