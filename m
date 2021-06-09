Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFC5C48BCD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 19:02:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A7EF613CA
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 19:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7EF613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=222GCiJnEeB0qMMHQ6H0qv2hc2Q5ID54fXlJh9hcJLo=; b=zevgqOx1CLdjU/
	gzS+esbTiiOz3vwLJGxMBnhLV9RahoY42+4kTTuJJsJ6fTAVsgkWEGNFycvvmuVKEsSvppkjh9JRb
	ME27lRqIxn2g0i4d/twBhqtv6F9f5WRyGZnNnRhBnRzDmzs3neBnUrWvyzghDySn8bDhJkvJKypZC
	JQTlxofFhUKbZYKkjYYvTyGOltytprkuGyhrLWJSGkZauao3SZliyg1nRYjXHsxRxET8g/8fO6M49
	7S24jqt3iOV7VCZ4DxM4p+qeJqdB2ZlegeA+WImB9v96RWo99m/7g8frTAx/FpH3VXmkjdopTAIz7
	JfBOGFHv1y8Ugx5XafdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lr3Sl-00Fedd-83; Wed, 09 Jun 2021 19:02:03 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lr3Si-00FedD-6d
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 19:02:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623265319; x=1654801319;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=BSD1pWWTGtdK+eX3g8vjbqWnmhfIHPwMSYZf1iL5JlE=;
 b=Vcv5JEejZk7oWx3sKlToCumCwC4y9mJu1y/LFH3wI2BD3hBU6XMa3hqF
 +jBWnMfMK02VRrRA/kr/JttdpOsGAV2+UBZZd5QG19RAW3eH8Apv4wU+Q
 9LULcHXcL4IXq5eFU4BTBEIhTAUMqY4BuyR4cDfjfKVYWVP9tv6DLnabk
 tjcDRIuSMr5r2o5hqwJxnY4aPI6/qcszY1lJq80FdG2sG7myFpcnOIzLO
 PYUhhiS7YCHYniLvjKTyn0TUA94yznLFRl/e6tW7ZmaD6yeCmz7p5Uj2s
 zO+vKT1JWQWZ22WuBJ2Q41Zob+aYMCiWWSfAvl6+Nl4vh/RqO3Z20ANo+ A==;
IronPort-SDR: j7MZKSmNKpa8w3HyNae4l/2tWgKPCsXHWXxCX7eyBdkxp69zIwjOsTLab5g0QgWWnURIRv6b6F
 Zho5zPUhRL3W3AAR/jLNd2vTYKuRpu3GoxCusYe/jm75+v4sxLaphsuzxYlJ9ZfgcJDfgV8dCo
 n6KRHWbusHJ2agw8n1Eu0V/UWUqHPQUox3Ytfq+AFrgG7qzxNnWHuPnBjP3voJvQF+shEXD5lC
 hvYiwBHfCV+rQmYez+CMpdvGmlvaijHw1xTEhbCH8ILP0ZOBUVeJlyuDfZ5u2JDgJ7aPTjjYRn
 88o=
X-IronPort-AV: E=Sophos;i="5.83,261,1616428800"; d="scan'208";a="171340659"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
 by ob1.hgst.iphmx.com with ESMTP; 10 Jun 2021 03:01:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYbmlKjQ+1324tcl+jdLHKhQH1iqWGMV6RQ4YP3u4ftHdbKOS1EzNZYGx2U0R+QnhGPYp0aeOlfmuPq9Q+tngqlX5N+jjO4/rC36O8tK8z0Y+95qU3FEIbuQdQFSCouqtfdl8wVZWaFisfSOynxp0HKwXFl9YfkkB8rLFGWy3usCUIEeZqDKfwCz2cuAJTU96nNCzaBOqqedRKteCxAyss1oMZeO1OJ6lB52X13Q9aLBtPSpDe3kmvG61jOMAT1qV+ZOpJHQlZTPnlQrbqAe0hQhJEhCOYTjztJkcpiw6tbXcgkcUe1U6leOsRaxinD0VeUaQBm3HGZfS/YUwtcLgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSD1pWWTGtdK+eX3g8vjbqWnmhfIHPwMSYZf1iL5JlE=;
 b=c1627aZUt6C9cN+aKPDs+FWFXesf++Ymz4pY76QZ9tf+ocWB8OrQgPrwvCaJwUCJPIxx9g9Fle+prBz2i0QRbSqfY83qGUdivmSPovp2mkyyai4NKQg99JWacSAio4Xd2ySdMJuHX331kLwyDNwzo0gPZIxpIrH3136ycoRdTjy9jq5s6137nZHEHVu5yKwMDOpMCECJjvAYlYwptQlACyw93qe5WXev0m3Udz+BYpRTBTVwiWsDv/cWd1+AaXMUEHEbYvCRXKxvlP3y7t1li7GeTZY7522xoU80rqCZwmuEKdvCmFA0ynyHeZ2yRGFuD1REXu3GbHFlAG6+ZPCQPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSD1pWWTGtdK+eX3g8vjbqWnmhfIHPwMSYZf1iL5JlE=;
 b=k1kXuQp7aEiMMMLBlzza/xHNZzUZKKE3XhXIzYYyWaCPoopPQMKESE2HPqBK1U7WlkosqNs0fqGsUzlbClP0q4OxCP8LFXLp7wosnclYUnArond5ece5W1sXkFMknKQpuPid+RCzYQ1waNgyX8DKWQS4v/xJ6SRgpJRRCKzZRzg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7678.namprd04.prod.outlook.com (2603:10b6:a03:319::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Wed, 9 Jun
 2021 19:01:32 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.021; Wed, 9 Jun 2021
 19:01:32 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 5/5] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH 5/5] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXXCnCcJsocUqfs0ydfjd9Wh6KbQ==
Date: Wed, 9 Jun 2021 19:01:32 +0000
Message-ID: <BYAPR04MB4965272CA1EA6437BDD4274E86369@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210608054635.5661-1-chaitanya.kulkarni@wdc.com>
 <20210608054635.5661-6-chaitanya.kulkarni@wdc.com>
 <DM6PR04MB7081372FC5AB2D825F3372DAE7369@DM6PR04MB7081.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02c06cd6-b2be-4182-81bc-08d92b78ff02
x-ms-traffictypediagnostic: SJ0PR04MB7678:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7678D037D7B240010988F14586369@SJ0PR04MB7678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8TxDncdFk8HlJqz1dqE0qcMBc4WlS5lRQG1yRgqG6W4+vBnskDJZlXArPZX2jqnV1EDVFUNFAoFwkBOCNm3ajC+1sJDWDK2cSg18/UCXd0BgyTam4hCchA/bX6dCzICfkawABaWYzJI+1w4rcyjW2HttuDQukrYNNQHqqKqJ6ln96PD8bnQ0cc2kzI/BPm/Bn8X1CQhK+i31oQt5Qkmf9uvKz7aC2YrHfabSnWYKGPG8ATDpwCAyzEJj1pN2MVChA5R16FpDViC5tSabJzKaLb3RwwVYl7WiyiS1+Zxc5Z9x6XANQQL9ZYFjx2UL2JCp/atNyGQ58nhY7qqladdXylagR5k+/KSM/KcpCyuyIdRxG8zB6XVeYZtEQjoPraCdGpzirXreTNnBQplYl992HB66d2Y6b+AtrYWdUaRf172ulAmaCv1pv9tLM/Z2vGwc6X5PW1bV0NzhC0IOWZd7VvfQmuBbqqs79VHvF+/3tjs7IgwGG5ha77Fn2yywT6Qc7w9Vdve2pyGM1URTNIEcWIW4ulAQHKYlR8Cts2Uo2xOSPP8WpgcsLutJs/sNmiMf7DAdHnOu2MA01iYO1/uumRDgdw35znSV8sfBETt1hPo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(8676002)(558084003)(66556008)(4326008)(83380400001)(66476007)(38100700002)(53546011)(76116006)(55016002)(498600001)(71200400001)(7696005)(86362001)(2906002)(26005)(6506007)(8936002)(9686003)(66946007)(52536014)(110136005)(66446008)(64756008)(122000001)(5660300002)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j1sgmLnye7IioaFozKsrXp+QeOtfQ8nXNFXLrXo74vYklUWSzU3aMhSUeMak?=
 =?us-ascii?Q?ql7xWhKnzAnTrfwmU0Xxz9VSFR8Xtkpp2jl1gceN57kGiXe1AojUkGMOfRTf?=
 =?us-ascii?Q?hD2O3618XnnqMFT0+3TtZRG/a7plQzfmT6wDAqnBMWpXJY9T3x8xdcxIFrcr?=
 =?us-ascii?Q?8jwvUzvWVYGv/+TAeYy6kDM40sPTZ1lYwhQrAHfdSShTL6n5OCP4vPtJNVbZ?=
 =?us-ascii?Q?J5qUYsN6t3ONzvOXLf0jncGG+nYHwKjz7w/kmfAkW0Lwg0DQg9VQo+xfj/Gl?=
 =?us-ascii?Q?5atO7xzjXDK34yZLR5uyi07hhYo7I1l99cCxXig6Jt+VwVZWhUWrImhRXlqX?=
 =?us-ascii?Q?I/fBVkbs2nbkO9wiz9/xGSpf2hkYby4Xvi0ixGyA+6y5R1lXeMHeG74w1InD?=
 =?us-ascii?Q?fqshKFvbe40qvpBzVhJxq8doQPGOaUf/6d/oEBtJxSnCZV1POrtQ/7GWbinW?=
 =?us-ascii?Q?Pvf0dPuqXtpXr/iY/8iG4+VdNP5P9yErmdApG5vpJZcZ+qXtsOsy0c38SKFv?=
 =?us-ascii?Q?L4OljDzleWsfbIsIFT6WO3qVCcNGtg9F8+R5An0w+RPXV6dYdFdAyepy+PAS?=
 =?us-ascii?Q?o7N4aSFis6t6evc9+culWLyhzwMO3CpYGsiLhtZUsuBJrJ0Tc6q4J2aZD8mi?=
 =?us-ascii?Q?5dvABoOevLXq9p0TXxpxsteXF5uEvy5MAPAxogTQm3dF0GxYwgaCJeR7j52l?=
 =?us-ascii?Q?s4VuF46WL+aLKQ7OnRC8u2UJehz99xi2BgRjkBrQ6JNHZTE7+3pYMkhgMk2R?=
 =?us-ascii?Q?NX89JrSkrz+3iwDtrtWA2Or/1Q1itZtio/Agl6izsYz4EGD9d0qlBZAflcT/?=
 =?us-ascii?Q?QYsUKYmEgW9aX0ZFHZdOibu/j4sNJQJrulSaz3OKHo+4VmN8BGUson1RIAiE?=
 =?us-ascii?Q?xPRVD7YC7Os2EWNKdvimrKypsodYuO1oENRs4jmfq8ZQSYZnXM16kfVFJ8U0?=
 =?us-ascii?Q?yWYYAZJfHzhh0azCvX8Ys7d2KhmnUpIcgiZsl1G3ybZrt2xavKEyN4quYJa2?=
 =?us-ascii?Q?fIz4sDY+WYHkGX8h4WJ3IVLdOkY4Jdi9ckcSiQDVX0JnfFe7mqWRUVsYSsF2?=
 =?us-ascii?Q?iRtxWdj3ge4XTM/iW6VQcyVGXO6r0eX1c/n6yh1sF716+xRNpEy+6NoGmygC?=
 =?us-ascii?Q?AYaJq6nY7ban1S5Xw/0f8iUwtijG3HOuDzwgqGr+d7nRZOsrt4/bqafsbRKd?=
 =?us-ascii?Q?Hn93TOqsAdxmb4PB4cmyaiDYNhSecRzKhihlnozzp7OrtrpzAY1cSZtYtp9J?=
 =?us-ascii?Q?0hqQD/IU3/k4KjcwGUWXCbtdJwKzEU3xVXsszoZhuMtaiqTI/XjjC/Zsd6zU?=
 =?us-ascii?Q?0XagtL8lbaakhR8zY+im5o82?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c06cd6-b2be-4182-81bc-08d92b78ff02
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 19:01:32.1901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gPCTkxmqYn0ERTOJQQtOcIBSSWh+FNYZGEUr2ufONfvJ7Veq1Yg2ZdEaMpTRYop2s5aTnz6lmh4nzFChFCiC+uD9fdujIQVBX43bCBZ5B4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7678
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_120200_338531_2D3C7D68 
X-CRM114-Status: UNSURE (   9.95  )
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

On 6/9/21 02:44, Damien Le Moal wrote:
> With the nit above fixed, feel free to add
>
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
>

Thanks for the reviews, I'll send a next version with nit fix and
updated review tags, also CC Jen's and linux-block.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
