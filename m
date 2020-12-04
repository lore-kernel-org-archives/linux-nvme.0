Return-Path: <SRS0=dg6g=FI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE7AC433FE
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 03:14:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F8422513
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Dec 2020 03:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F8422513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=IkUaDwE7M2xRmguUPAbhMlTbxRY6D8FMB8FxxNhv78U=; b=135y9TPu6WBI+mp3HhEO1o6vR
	QRG7Ccz6MTjph4MikBxHOZSpWc+YTcBOS5CJWveEAOmJnudhUy8YHq4bW3f2OI/kTdzKAmUBuhIOG
	/CrlkZtV8zzGJh1ndfjoVhRbrIY1oP0mg59Hc57G1Ha7pSNnD+zEDoJ+8FD4855ang07H3HiqcPFo
	UWK8QNemMGU18jq9bf5LBU0+akZg3gXVYtTwBTyk98diGLtGjKL/9S3vjqCX+LebD/hGHGAb4UqBo
	UMPZ4Jn+9iSg8uTU3xjkpfCbyJqEiD4/APkv2VOBQAohDhj3zFig54KcK+Ih6uAjdl7LlJBZTV7hP
	uTAfBCfiA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kl1YG-0002gJ-RP; Fri, 04 Dec 2020 03:14:32 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kl1YA-0002fX-Sf
 for linux-nvme@lists.infradead.org; Fri, 04 Dec 2020 03:14:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607052015; x=1638588015;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Y9QiQngOR8kZRufODE5nFNoX8dEwjY12gXLYXZxv+ok=;
 b=lt4T92wNdXybJHGSG5Jn9oA2OT6xNUPRfS1nFWSJWix8IXby+JyJOBFQ
 rDKAu4kBrakGlO4xlHDV9cCWuPv3AKe1+piOLb73r08zlS0b09ZBi1lYO
 dI8BuybbVJ3KMYlErWhdSQY+k10cV9SN1NVLEiELlKq0g2/r6Dg9VTvt2
 IUVxIRf/LAU+g0kj/O0h9BFT/zmBpOBxd6WXQkYH/K7RsNMpb6sd6RFku
 5TffZYx1lAmaFjMjjdW399Rh7XETM+wbzmjIKKAFH7TotLOfci3FZ0QvD
 f+v6x+PHTUwOQIyyprJi/AHbgDP6ZjhTJ53VAhT/x5sU3ZK9wRvNqPaEP g==;
IronPort-SDR: 0JAU/DtBLueN++XOU2xXSTppye/hHvCWx8xbslBZMcaPwN43gBtvFMwqH1zsvrLmT79L3hDjkF
 YFi5yf6h/W3tZh7TZWveWnSo/KixX4iGGBBSU7ozpM6TpiQ2D7FJTtDoX6kEOf++yjL8uCp+Dn
 ggFd9t8yqUoxGaiYzKLM9ZhPqlrPiNbEWr3FTElOI2aWFS8rPuoYLIg9cWQFWVFI/sHPyQgENe
 FMZv6BmllHcZKx7JiJstakdc6cOrdNUJUtOG956WkEUK4yUh+JqZNZptgeGWJ4UTrpFSNBlOYV
 UoM=
X-IronPort-AV: E=Sophos;i="5.78,391,1599494400"; d="scan'208";a="258108086"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
 by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2020 11:20:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsC5XaXYAjREeM7I68ff61qKqoze74vrBGJ0uLkA8cNYEjZN4MitOkIxia7HA4rsGTOjDkePdfkLIGsw5M64wApffxQmitLM1T8KixXLoIAbaKAsreUq9OllvNwRSfQ1tOBQ3LNh6T4nygpE2P0YKSNnpX6fa4dY3MFl7fbUXTXYW5p3p/nXj4qKuF2mHOEG5vW4CDm2yPeuNi1LHsK3hmazOpG4W88f5ranKk1ZkVVjc89Ju50AvrcYF8wKGpUcU67PYv0ZmRzYjZvAKnhqRxRiV2LnBnibbVqk4fwiR2KdQ1fehCS51JwMLnLYo3nsEBmCKgck//YSXh156/sVwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9QiQngOR8kZRufODE5nFNoX8dEwjY12gXLYXZxv+ok=;
 b=BdHey/Gpv6kHlRP7X09peD+8eFHq0QA1sQfyVVzV+I2pQcRlfV3c5KhjJkmK1imYRgzU/GDm6t98eUyrq3GOeUzBRe9MMCexXmFiPLvEx1JJVWV+xF4Pw5xUxlx3M6FutisU2FaQ5Wc7lTdBwD92HOf2PdLssbc9H72EbYDkoH4IkDyF1hCVnaO/MvFwQC043Q5m4AG90s/tNlandEUQuWXzPQiM2AWXIXymve0NRigxd9XPe4a9WlPz7ZkH88pt7rncqP+L3PQrjzgMc1IzqPqdG2RtPOeIuvAd7Dr58DXeFht6/SnJwF77LLyMlt99rFj27EyNHgpMUQhALlg0Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9QiQngOR8kZRufODE5nFNoX8dEwjY12gXLYXZxv+ok=;
 b=MAS3Qyn/MkZ97AVzkSni0/oi0pIW6JMTtYPGTWaQzAKJpB+NWLnyRHGeZJeBkIXB/o4Ojhf8xNQbpO0nWMaQPr1TCYNpZ5MBbo1H/jwnoPRpZs7gKnWcMcDfsRmxB7p5QgnlxGso1w6M0FCWqJ4stK2QHXgdzNOvor+9Ds0X8bA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5030.namprd04.prod.outlook.com (2603:10b6:a03:47::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Fri, 4 Dec
 2020 03:14:20 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Fri, 4 Dec 2020
 03:14:20 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 4/9] nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
Thread-Topic: [PATCH V4 4/9] nvmet: add NVME_CSI_ZNS in ns-desc for zbdev
Thread-Index: AQHWyHOl/uqfdSVM2kqpYnXGo7vd7Q==
Date: Fri, 4 Dec 2020 03:14:20 +0000
Message-ID: <BYAPR04MB49652C7A660E27E2943F27F086F10@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201202062227.9826-1-chaitanya.kulkarni@wdc.com>
 <20201202062227.9826-5-chaitanya.kulkarni@wdc.com>
 <20201202090926.GC2952@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 269a07f5-0a8d-4b8c-67cd-08d89802b158
x-ms-traffictypediagnostic: BYAPR04MB5030:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5030CE98623877FF02F0CD4786F10@BYAPR04MB5030.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NbsVygKeTzwNySbSHw4cSNxegRQtYVKALjPFlyOTgI1LLN+Hr58mlowj9JDwMo25GtTYRCx3e6gdbuxQ9LWGDLc3v4VD+01BRrZ13qG52RXQSEF2smL+UCGbwgYTs3G9O+jbkSEiydDrS/cY9tNBqw8jtcsQb3zIGNE0n0BK+3l/teUoSldp2Pn9y1xsLwk724lfq/WhJJ90ZiK4seBLgbzRzaj1D+8Lj94H3ouFUuQq93zGfuapnYYE6N83kfoYVoOu4UB9G5ZaZjVwVd4TJA0G+VJZqfUkyYUDMjea7hRyBzW8ElGcLKH5g6yP/j9NFo0cCv4Jk6Nclcyc/uWhpw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(76116006)(4326008)(53546011)(86362001)(9686003)(52536014)(7696005)(5660300002)(66946007)(54906003)(6506007)(316002)(26005)(66446008)(8936002)(55016002)(71200400001)(66556008)(64756008)(66476007)(558084003)(6916009)(2906002)(186003)(478600001)(33656002)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?P42aMbiozceP6L20i+zrEiTtlHOWh+j4Pz4FUkaaalClUaLMBax63DwOrPuS?=
 =?us-ascii?Q?Ii1q7ZnoXzMsiYEfWG7dXAoK7m7qo4572GLeTldiK34URiubJ8OwGmIEirwW?=
 =?us-ascii?Q?QFlL5Bzq0ld4nLGxmWFVdyHdLfPCxtf7y6WgTgzGxvgHQq0aVHVErylgL/EY?=
 =?us-ascii?Q?MpzumtN9SY+/la/5sAhswywrr2nmlUhdLqjenG81n72Pth3Qui//Um6uzOJa?=
 =?us-ascii?Q?jPbm0F16GxYEYUg+q9HUy0/YyfAfqVwQFujW8wg4QliziwV1eXTH/dcS1ClF?=
 =?us-ascii?Q?JFT4O1b4W7p400cv1iApKAoOktiCn8YjYNrGkJvqYNwdy2gaf8K+7yeeDzKa?=
 =?us-ascii?Q?dPiCFaM7wvH1gZowIR5154dlECBuQiaxOyhxFQw1UqOeSfp9o7MhyrQtax/X?=
 =?us-ascii?Q?05Uu/DwI8Sds46Oo/pKvxoUTV/78+QsWcqm9NrgQQ8UKm8UklPINbqor1e5p?=
 =?us-ascii?Q?5oe/D0bz9jQ6hODMbVcwYyjSY5zymOcLNJ8y0YUNnRCEPF4wU9JcV0a71gNj?=
 =?us-ascii?Q?dCQTQS6noofkk4dmt9rwg79ga0/HcVQ5twjubVS7sLkAsOLTMOeenBb0umNN?=
 =?us-ascii?Q?N/W5SVtWy9fA8IET5E17CqOdef8gyda0Y/NJtHYzsB2Tvw79Sr4fdZX5PNBX?=
 =?us-ascii?Q?4GIr1iD2sUQ+Xm5MGRPK+keuzLrKGQVsLKwlJlSCTlO9mP//KtRMl6YKJvNW?=
 =?us-ascii?Q?3bVsLTsss3IOVUAfjCsRwBXjw3v4eY+jzVRKRN+yiQ1LqWXoxESHlV8InS9R?=
 =?us-ascii?Q?6jJLAMPmeJidNOUt0sfXQmq7nwoQFUMQjXfYu1Yq6KSfX5Grbz0Yg3A0OpPD?=
 =?us-ascii?Q?m1D9i5YhmpRBITEKPWGx7eVT3P7druA4mSrn49fKM73kBUrXTvBXqIvGDQga?=
 =?us-ascii?Q?SWLPLZHqEkxxbyIqsnMHLe/9gdAhti65lE57/BnW5idH1sth72pC6tS7A4xa?=
 =?us-ascii?Q?DGleBh/CH4mk3WSOd/rjIU5ZSThthy7NjRh6KaxaRYS55yAg25kUc6RItlxP?=
 =?us-ascii?Q?QXKr?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 269a07f5-0a8d-4b8c-67cd-08d89802b158
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 03:14:20.4133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQfFm0GGhcPq/TmkRadWii11LYltEHR9y1IGccZlcFBHvgzgPAf0xih3otWK52wtflEQV9z5I0iw4xDQ+YD86eNQDOKQCUnDUDYIb6qpkoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201203_221427_050785_3B7A3F48 
X-CRM114-Status: GOOD (  10.53  )
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

On 12/2/20 01:09, Christoph Hellwig wrote:
> As mentioned before CSI support is a feature independen of ZNS and should
> be supported on all controllers, and in a separate prep patch.
>
Okay.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
