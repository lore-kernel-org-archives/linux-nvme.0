Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB99C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 02:42:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7DB205CB
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 02:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qWaotexg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="je8XLtob";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dEMm59g/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7DB205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=T+8WdKHy7zFytHamlx8kCqRX2KO3Zel3OMTudO4oSXU=; b=qWaotexgRBVE3VQi2I6SFmGVB
	cukUupIrAQuYuCdX9qMXjJUM10CtsPxqNeGSATdbIVFfn7L3Dp/3X7OW+f6QPROwcuOig4Lntbe/M
	D7FJepICjURVdVyhKdYX6cHLL25eUDoHJYx2koUTGDErKVHEf6RNV5KYxeKmkBy5RXIYOu+kcXS9Z
	757e4yJEONbFItrYj6DwrRary7ZIrD2Lkh+KGF6AYqKkeOcANZBjhdzOekBVEIUubNA5dH+hmU0NX
	4SwGg25rgUQr32sZ2NW1LC/7xyQGsv9y+P52RYOHrPayyuhOL7Jc0Lg5lvQwTwTHBJ2XvtyEn3xi6
	FfqnN+tQg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k63C9-0005bq-5X; Thu, 13 Aug 2020 02:42:21 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k63C6-0005bJ-6E
 for linux-nvme@lists.infradead.org; Thu, 13 Aug 2020 02:42:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597286538; x=1628822538;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=N2phDUSM8soiazk574RXj5H2N1XNS7RlQoKjO8cyKWw=;
 b=je8XLtobBDfwT23GsFgd8ISgQ7CZerkRQJOhQeTiQUtxk0vjfEqWWUIx
 Te6+kTLMkghcGXv/SB5PfRYJxd8J6gldNVt9nC4WIsUlzb2QnONKELvla
 6J1X1y5G/EszdyJds8lKaAllndbzqXcOPJsJZzVdp3+82VP4A9+1K5PNu
 LjvqFMEFF39CL/6X/TJMaWbgkl99pKgwr5l+hKRFduCFfCKeiPRfw2F/S
 1hSyIehquvA0NZh0/kHjPpTv+5C0S2B/WX01fgdJIeV2P12W9gMvsnCCb
 2lwCUlj2ytY66PmEctM/sFWg6ah0AnPshkIxhfZ2cb1VCxBsS1jsKtIuW Q==;
IronPort-SDR: 1j5PDpmXlp8hYzMv3bIw9KjMQ3YSjERz9YDNw6LhFWe4dVepVYnQUwmjVXUFgeSn9gl08yt7Zl
 bJJKEcR0F5MHC6c57E5vakFogUq9cFozrf861DOYKONSbnGXoNYmSxYzgwKyGJpBGR6AeGfpsx
 gqQonH3rV1AdRVPSTx1DhtigPr6majbDSuHJpudyLJQ/O+ReuSQUIZAuI83HO5SnJe/H9krunZ
 s1S+rtzYLUD/Ji+z63jVnk+m+YYebkcf4tzoxOZGlT+BvOKL0oqhxpgPDUvszP3LbI4lP1Wcfp
 Xm0=
X-IronPort-AV: E=Sophos;i="5.76,306,1592841600"; d="scan'208";a="144867261"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 10:42:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iv1iiSe3MWOfUVDN1Dl8kxnLPPVfvzHkEx6kUZrPMDne6A3anpyrMbu+fVNGJcJWZyWOEgCiVAicEsls6VznZiPC88I9o1YJwc077iLD99P7xwBSxVYHB9bhmxNe362S6j17U18E638O8Chk7y/iCQG0StYmNDALzVCk6MnmZJ4LWxHhP3eH8qvgnsiWQ7iqkdhu8hBWdLRbK4AHpX4orc3dE0HEkRtoFBQ6OojKyQAwd9lFf5nZsjwwhAnMd2TOy/eQ23OmKdNnCGEViBgLP0axwZhRzVfrbUr+Ycyc4vX7G/SvsvC3nzbiNKUqrRiyrItPRFPBzhZagDkYsBPAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2phDUSM8soiazk574RXj5H2N1XNS7RlQoKjO8cyKWw=;
 b=YV09I8JG3xLEc5tQmlBhthdV/pzEaauXflDmxOtiaMu5XYZKY+yeOsQz0IXPPTp6ExqIx6n6injIOpeWdIaf59Kynh/9TKPc1mm1lpMtdMnVc7UwQLHMzeucCvAU+wBStLG3rdEIbBqRfOhYz9xKKgr1K3AMHhELCYL0Ss/8fQFetRwIZZP+FpT2TU3NIpDa/2iqhpi/QYOxjyr6Hbn3HI3/Bq6YAX5865u/iZpzWnyRFg7K7R13+8tHGAAPufV9DjQ62kHdi+6Saty13ghEPY0+zOlmN8RWF3HHIzQZHm8IvGfqjg9YbEGiIgY//Oxcm+gj5EwL59O5yVSFSASXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2phDUSM8soiazk574RXj5H2N1XNS7RlQoKjO8cyKWw=;
 b=dEMm59g/n7b8AMhF6VjzNVqXUm0LaFSaQNzht6JwBSe+0kGOHvlMEI+g5WXydSsFLELhHBFDBpGyuiJgb+eVuvvbK7ujGSsG5e+HyQV1yXoZJQvgcLJpq/6zyuGf4qNISs3CPBN1MWTPvaYOB0otxcpDDZt+U/1z4WX99GkXP7U=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4871.namprd04.prod.outlook.com (2603:10b6:a03:4e::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 13 Aug
 2020 02:42:14 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.025; Thu, 13 Aug 2020
 02:42:14 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH v3 5/7] nvme: support nvme-tcp when runinng tests
Thread-Topic: [PATCH v3 5/7] nvme: support nvme-tcp when runinng tests
Thread-Index: AQHWcCKPtGpmPEht4UKtjYODWQU5Nw==
Date: Thu, 13 Aug 2020 02:42:13 +0000
Message-ID: <BYAPR04MB496539E26CFCC0A17C55B4FE86430@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200811210102.194287-1-sagi@grimberg.me>
 <20200811210102.194287-6-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f082823b-8a58-4ffe-a96c-08d83f327c5f
x-ms-traffictypediagnostic: BYAPR04MB4871:
x-microsoft-antispam-prvs: <BYAPR04MB4871FA87AAC03BFB34E8493686430@BYAPR04MB4871.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G23d+o+5MfqSAfuKPuvqCaqov9pRSI2P26Kk3vgSdMsr1gLBsxHaV7p3sA8cILryPpcdPD6DfNO37hSjxsy4rde8JIqtyQ4Bi/LSM9vMQtNDecPLF3payJ6jX9DZ5hxLE/7fFDyABbfCPsDuKQtvl3jI/ZnfahOCk/XmqgBZyWpBl3vA49Pa9ZOU9pp30qyRONtspKhvtbDnSqd1xPv3Z4LGPa9Al5SNDBfRPKL+7dXiBNVcPz/DatjQTKcx1fbwB1NrXlm10yEgvDOTUpPAPzHjIrUv+/CGb6IJ68nkthKC3iQcPDa3GEnrA7Pm8/kQCEEP1nkfIm108Xjg0WegJQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(8676002)(8936002)(558084003)(110136005)(54906003)(66446008)(66556008)(9686003)(5660300002)(26005)(33656002)(64756008)(52536014)(2906002)(66946007)(66476007)(316002)(478600001)(55016002)(76116006)(4326008)(6506007)(86362001)(53546011)(186003)(71200400001)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: z3+AjiWmnxm/tXSHOCou70RL0uZq9pAw7628vP+V2faaXFffYrfbEDeFP5Zp/t61kvZUBBG3z7qCC1Zo9rteS4UdOlYKO+xHmXR9wBPJZUQgbPQFcpEbawmsmckNWHdhcv884k0mAgq5KgT/w4/Dz55CCUrwRBgnmlTwt7GqRPwgVzV8obOP6PjmRL/Qd16AOhEEuIq4LabwtWvp3eUTENIIoCKCdmc9Wn5FZr/AB1W8X6SNfjxVrYJFMmFy67XxqSiLvMzJzonzUK+c7kXqH1J7X1W6DzBN1fu+8W2z1qv7WbZm8Opei4mSmK9pQKDVjXL0jR9Ydp+aMmfenBETqcMXJ5u3XtKDZyY67A8MHCb+cULf7bciE+jD9+n6SW4oEzC8a8a6/xRugsdvCwEAmwcPnoFxwl0789oZBzG/1mydqwAic5Xz6td+sP/vX8Hq/5MjI9WsTBr6uLDIdErXUJ5pw07vL3gJe8ui7JsL4KkvQYTeP2S7etGoGNbI48X6PN6x4fmBGTzYgitClT6EGHf1P/xnz8BOf8Osm08Obe82fhA2RlD5AJOjncIYpnc3pnaL/0WUFtv6plsJ8Ah6KZVfplsiJKTfJ5rhiv8Wiz6XKAxC01ERgGOxbnGnbKQOQa/RuklCSefLeBZftEBlWA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f082823b-8a58-4ffe-a96c-08d83f327c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 02:42:13.9594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fm7trZ/yv5ItUQnSQhnnAg75DfnCtj+oiY8JWzPNcQzEvwrbAOjIhzb9uzT9yJbHkUiEYg93B1NXcnSmGJS7qMXXeaNWrdbZ1CmHQSJMdLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4871
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_224218_447000_55A76D12 
X-CRM114-Status: GOOD (  11.96  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/11/20 14:01, Sagi Grimberg wrote:
> run with: nvme_trtype=tcp ./check test/nvme
> 
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>
This patch looks good to me.

Reviwed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
