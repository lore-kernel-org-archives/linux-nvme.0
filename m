Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0631C43461
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:20:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A32F02075D
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 00:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d7xYvemp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AjVfl6lZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xar8EHS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A32F02075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ufK90XMur7HhfwrL2TrE64z9iZGOG+RlqRYWBWoPlNw=; b=d7xYvempPiGAvpFCfJrlmn4cV
	b0+9Slmc5jGwjzovEHZ34avcL5zRA2cSzNWbwrzCTcdVQWnADczaAwlS1LdNd8E27kSzzg2+HYmu/
	9KBgk6KwtwTCOJJYez1hO/iuZM3btTuKX1r6VEBoTSGtU7VYhfDfHG2ZC1l9/9YK+CXSVK2fO8jYv
	UtTsykhSj7MMYjA0iGFkmTXeICyoZninekc4firmTsjPq8db2lmcGTy6pTSMdsYE+34HgzteU1ILx
	QmLuxlysH6IC++WLrlYIZ9p5LyXNwhY3u3/WOFfG2mz/DT9repoTSXYfAttN+gs3W3N9wHsMSXgeU
	XhW0lRd7g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDzSd-0004jT-PW; Fri, 04 Sep 2020 00:20:11 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDzSb-0004iW-E2
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 00:20:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599178809; x=1630714809;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=HeDPkGlOlZLbsl8YbxRo+kIQwUt0cucuYscOJB8vun8=;
 b=AjVfl6lZbV1FzAVIoOAySGuNM7BX8rXHtiUrHXDH7ATAdfbgp1LpvLXG
 uLJyl1UEbfkJx9WcoVP/tvizkNqng7JpFst0lLf/bJxiuXOWLGahCY7f0
 bqv3HcAUxrfT4kd3h+vzX9QXw9zCwKjE2qV9gAsEu2GR6DEIRlXkaCWns
 wLCIppUOOriu8AP+zsuVOMuvSybfJu/7p2dBbd4zg3ihY/GNkq/vc/lZL
 EWV4uwqZQRtppcLwqlLHOjPC2xYijEL9zSFhy8KxNGdjoWqqxvHmztE4K
 t/wpUorHVm1qq7DFc8EYDCKmNS93HYsiXlhYWUEBjriYcfsRnWR7lny55 Q==;
IronPort-SDR: sxnM+8MxWMMk2cTPYfGGukH+JCaeqdUcCfBHpfmv2/C3eRY4P91Bq7A6Xx3Ze4cV5N78iFq54p
 8wYQQuKbtW7KVBbS917mgmFPA/C6Zzs5ZSNxMsgIircPf8+MYGAwf1R0YBqopaDNSmV0R2xvmh
 l7glODoxv3FePZ2me2xulw+bwreGztiqqL+PFFpUr8XjtPXLvZLmK3qstcoSGfexeUstw7KL4E
 Jq6mrZ09nlxj86cScPsnCduPy5TICocBeOOaEo+CB7Ic+UoOy+LLy9S4l+mWzzK3UF5fx0+KJV
 Xf4=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="256090112"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 08:20:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBoi4MDoZc+APnpiSHJfPRmPOxbODlIqAE+IVHmIvlrpquMtznSvcBoP5noePbtJI127C4taPLrmm54t7CNAaFUxtSz0qVzenHeJh5pAheuXxQU0Q0uEcSJcMe5ScIYUat/JaWNRemYopbnM4Rn8GGiG26c9seV+XyYK85sTYP4CM3j6W1p+LjrvOuADQyuRxtxkIqjSwR4yMGMQgm4AIXM10uG9zUmKzMdR7XhQVGcNEMpaYets8N3drXMWeWMVOt1q+GKyn1kyE0LMVkO4xJIQ7lPhL9TUGyI2yTWUpKhyzGDmUtfSWlUNPcMr/P44CIqwkE9dYAwuOULqdUEVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeDPkGlOlZLbsl8YbxRo+kIQwUt0cucuYscOJB8vun8=;
 b=kMA4QFuO1VwUg0MtU/+UMh1bAI3TdCAJAdu3poclyRDqmPOE0GsmQs+yAmBVqazk7zNqPBbmA7Sk2pFu+IKulsOv7+aHk1miAY/b3ORQaMG1nECePQ9VMy/+550Hh8amZpwp76lPN61kzVrNr6KeOo7tVZFbgV7R98P0rtgX//dpidRGuH3P7M8ohvN34s4cC3RVmiw8BUL+3JeR4Q+ZOJZ/WALLROCrzqwXYDMzkSXbQTgxuV6YR3Yob4tObD1czVxNF9zIBr7VxxacfqH/rX+Q76q/ZROzPGZX+WPswuUgYR94ASCV5pGvjrKyTBUGLwMIPSkUXV4LqeVWMdOaVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HeDPkGlOlZLbsl8YbxRo+kIQwUt0cucuYscOJB8vun8=;
 b=xar8EHS27/jCvwPOAyaCCsYwg1+EiW1xGNY6xFRxPfoJj8QYUuslJkh3SV7QtTUo00BLBGtg5YcN5/vpRI2wIRojVqQ4VM8btx2Zs2jVO8Ctql0lkIlRzaCm9r1q75Idh1EqnOLPEgJoEWI59obhR/DC2ejGT+ibhAobCpLPw5U=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4424.namprd04.prod.outlook.com (2603:10b6:a02:f6::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 00:20:06 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 00:20:05 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH v7 3/7] nvme: make tests transport type agnostic
Thread-Topic: [PATCH v7 3/7] nvme: make tests transport type agnostic
Thread-Index: AQHWgk1+3jLHIFMt60WTnwWwPsjNug==
Date: Fri, 4 Sep 2020 00:20:05 +0000
Message-ID: <BYAPR04MB496569035FC23608CDE09B00862D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-4-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09235a0b-cf3d-4fe2-7f28-08d850684655
x-ms-traffictypediagnostic: BYAPR04MB4424:
x-microsoft-antispam-prvs: <BYAPR04MB442452AEFE89C043D89312C9862D0@BYAPR04MB4424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: akyDEoA6SH9tWSZm1Y2LWJFxwDlwyrE4m1/OhWx2cfe6JT41fWozMQrrwmUReTlDQtUbVHw/so28d0qvbcIf532htMIdAz8/JL2yJTCPePT738IcMgzvBV44orWtxhfFBd4uUkqJfRWoYzpI377V7rqV4v3WcIXQG5AlWx5clEwVKeo7rRcO2+5Xfqu8S9VehbpVpmdQt6dKfPG96bw2tdMm6h6aLkJ3uEQxSnYs0I/bhXT2UK6fX1lafYb3ju5udQm35axsCeVGoCSkwDjzijzv1x8U6IQLHJM2BkjCVuuWLGgRqRsgmo4x++EHtxXMiqg+kgyK8V8E3kQTWpJJOQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(39860400002)(376002)(136003)(64756008)(66446008)(54906003)(55016002)(478600001)(5660300002)(66556008)(558084003)(66476007)(26005)(33656002)(52536014)(66946007)(6506007)(53546011)(76116006)(9686003)(110136005)(4326008)(316002)(8936002)(7696005)(8676002)(86362001)(71200400001)(2906002)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 11t+Sn5drQuG70LjKrthXEtrLsNHtmuchoLofhxdr1uMWCI0OHRulK+P05VkJeFVSn3tJYTWFIX3uMxsHbpvtNMK+9DIYfu68lGoUHHGLncVyKc5k7f/3eHzKkNWFe8OSANF1QVLFJagO0cAFXnFR0gisYpqobOqYk2cXamUEUAzRz2d8kf96Ib7mI0Z8b+3lUO5VmyBAvhzvcm41TtKzJc0pzkhmocPHPSwRx0NwVnt6FLWhoqPYaI2AEb9qe9O4627s8wvbQHzXiv+9wWMK5GI53ULvvuzT+xRQ5WQj3GmSzKS5kSAcsl2cRRDyb90bONFXUKUkOBj1T1t8U78YdbGUDEHv5cjeXniRuSz9dZUg78KZDIziESeZBxlH5XneRR3gzn3IP9c6SgIisLqZE7LHuZPGHU3q+a9LbUE9m3/gAKdfpLBLbP0yU9RcZoa0NqJi2AWp9ILyfZXTuV1ie9HX8/3JAQ+Vaj1WTH0aMb6KUmUH3uVXup5D7CA/FyU08733N2irmfHaSoOz4VFa5rTttugIxOX8u7w5SrYOtLtrXnpdnOOhha265jamRWnHZ3INQ2nl2bkzyO1HjY2xj9NNVhIspvyaIno6mVbVPEUZqUrz72ae8jT/BAhr1D6vQl6ilF0TwDZN1V7DVthSQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09235a0b-cf3d-4fe2-7f28-08d850684655
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 00:20:05.8335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXKKxkw565iRNvWvUcaazFYKGmDsHF4mmuWJz/HHr8jXUoCtB1XIvfZ9P3HxdFlqF5aGWfDt7/8O9vwU2BQIXhh6lNuAgI6kG4FkUAQyWG0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4424
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_202009_731240_E93C2DA6 
X-CRM114-Status: GOOD (  10.01  )
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
Cc: Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/3/20 16:54, Sagi Grimberg wrote:
> Pass in nvme_trtype to common routines that can
> support multiple transport types.
> 
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>

Looks good.
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
