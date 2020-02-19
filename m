Return-Path: <SRS0=nRQ2=4H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD65C34047
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 15:49:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B982B2465D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 15:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eJnFoiDh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lc+ctfAf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qlUOF+1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B982B2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=N4cjRscO0BXfCXRifQZ9aPEg3LxVtkNh6kZjH1vXNRI=; b=eJnFoiDhAsYXeo
	w6l2rKHRBegHGDbJDknx2y6kkusFbNDX1wr/F47xLBZV6NCq1Qz1j+uSt5kqjw6OSq//VYyxZP1Q+
	L6vytTzXwaW9jKEbCZaBHufZ2iSIRRwUbXXfszcwDW8v+8JTzE1/frDWwyQy7N3QXq3BNynV2p+R8
	jpQjwiLB03ChTP2ooCXZSs/OftKnE+6E/O0QVKAeBci3XkvmRADkGKCrXI7vCqWmQbBMabNgEKhc0
	bdTh9ZFJjvTwc/J+pRgDZw6dJBY/VZ1w86TZjy9cRTiNse8o7yrrzEZKh/P7xvRrjYuFqehocTGbL
	6bg5WHklHvY9sKSTqk5Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4Rbp-0002LD-Sd; Wed, 19 Feb 2020 15:49:57 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4Rbn-0002Ke-QW
 for linux-nvme@lists.infradead.org; Wed, 19 Feb 2020 15:49:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1582127395; x=1613663395;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=4oXBXlz1PXhUrT/gIqbcF3JJEAWDQ0MIGQikaAT7xn4=;
 b=lc+ctfAfjiGZe+2BszPjIR0lgRSN8MKFvW4INBg9OFibEFI1QUAeWsaE
 x2j6Vf0oJc70egzyEvY7bhvboxhmg3HYjXCHBVwGJmexA+r1qAD7YIRZ+
 cVeJD5w5E464hJ8+/oYOS388V2/l5I3KgPd/GCaaReB5cFuOQ9Y7p+D/+
 AhobNxlz3CclcUrnqjczr5JP9vMgv+Tg5zUgcJKN3RwgIpJT3gC2K72gT
 oYYmjm+VO6YglUwicHCGOy3ZDErxIDSl41j+uUTtkBDvzRY/fdAXkLFdC
 BLrBAiEKqUTGYyT2GQKgLOUpNM8J0AR6B4a+Vg1JfMjMvmis0HAj9NYYQ Q==;
IronPort-SDR: ZwFZ7fdbg8xlCnJIBA8sM/5MOJ9DtUGCKDeMK+Eb9VvGm3j9FziH73TqIxqtYcIRfc8TiYxCa0
 Gm5bfX5SCoXNbzkP8kYc2355UItbLBWwzBQp0ivIgTPu65ZesqVxfguPAqXQSbmCvn40gTFbFb
 7uQc/NEyvRRTOxCUXg9l238Qg3CX0kJknN+2yqEq3nLsm3yzDnK3XWjsSDUv04frWIEVf25qcE
 SquAGgYYB+J8JRKFv7IVHEJbKuOp/JpHTejhzTNtVsAt215dlmPhfQEHvl7s4jbe5dvtuGdkEF
 60k=
X-IronPort-AV: E=Sophos;i="5.70,461,1574092800"; d="scan'208";a="130183925"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
 by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2020 23:49:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDFQ1hE7M/6FDZ3zP5PVSy9vF5YAbe5CH/wFOfE70q5lA3c9pDJ7GbwxhLfAB0kojbmY0dwuug+wrBhP0S4zUflSpdAfaOAg46Qag9iCDsOAjS7mAk60O7J+zIwe9ZmhUu8kqu84W1PFDumwp5ewMzRYQpICYqUEql2TC/AT3S4tVy6lApHqSLpTFe2FhdjgdR/BHlGaV+9E6czL8zCMpDymVoQcVGR06ZTPkYiG7RlaoGFTRF4S9uD4eIVc8SEmw25H1f58SmjskOBQQksxXs4tYHXYZlLXeBCayXZoO/FR+xv0rztI+aHgPiqq1T09UXLOCq46HwA6VLdOhJPoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oXBXlz1PXhUrT/gIqbcF3JJEAWDQ0MIGQikaAT7xn4=;
 b=kkwEXJOR19slDOX5thoP9AB8lPsi3Rp8ZL1vceUI/+FshxRORP3Hyw7wL1dLB/zQa/hCQTAHUP6RHTwi0FM/pIaz4QNz7Q1PpaCThxfPoCPFbSE+fJCEXMpD8yg7fjYx4zAmMNIStPrazR0bTSTftWkKCiEBx2Sv0l9Um+VrXZ7FZawcSno/KE3011mT7r3BmKhiC4oXwx8vjjNiCrUFkIKzCzwE3Od3Y4RjAEPr2ACZURX6BcNdAOAXslR6xawrj+EgYHXyYUfc+nCkNtvjjLoZJ0TpLeZgaU2XhlKv/CW8aCR0xSAb7xdrnrvciUoWHuj0LBvayhvCeV2vTIuiBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oXBXlz1PXhUrT/gIqbcF3JJEAWDQ0MIGQikaAT7xn4=;
 b=qlUOF+1AgmsEhSlO5pLofQJVSzK94czI1ySdXnVRH/YpaMOuoMZXAzbTVT1AZXboG4mLRsMVOlUTkHtZt1xF/JRftjN+OODlzCUDZSrmU/UYEVFijpitntYMHuwXTPDVrRCAhbIHUroO3aSklA12EvbZ7pXNLTltWWhb8HMHqDQ=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5032.namprd04.prod.outlook.com (52.135.235.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 15:49:48 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2750.016; Wed, 19 Feb 2020
 15:49:48 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/4] nvmet: add set feature based timestamp support
Thread-Topic: [PATCH 0/4] nvmet: add set feature based timestamp support
Thread-Index: AQHV5qSDrr+fJYkaUU+d9tLCNoqMIA==
Date: Wed, 19 Feb 2020 15:49:47 +0000
Message-ID: <BYAPR04MB57497EB1A77974AF57769AEB86100@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200218214338.25088-1-chaitanya.kulkarni@wdc.com>
 <20200218231007.GA18306@redsun51.ssa.fujisawa.hgst.com>
 <20200219145907.GA17748@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3be8e8bb-8882-4bad-619b-08d7b5535948
x-ms-traffictypediagnostic: BYAPR04MB5032:
x-microsoft-antispam-prvs: <BYAPR04MB5032158E5AF7EC05DB102F6E86100@BYAPR04MB5032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(199004)(189003)(478600001)(55016002)(5660300002)(71200400001)(9686003)(86362001)(76116006)(7696005)(64756008)(66446008)(66556008)(66476007)(66946007)(186003)(53546011)(316002)(4326008)(6506007)(52536014)(81156014)(8676002)(4744005)(81166006)(26005)(2906002)(33656002)(8936002)(110136005)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5032;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JgirwsukpioeK+FhFcV85CsJr4tJTPPSWHfAxOUiM2DMRt2fuVIe+X3/smXBxX31F6OXABdu2hcJmQlkCoYk10iZgfJcdkLttcyQK8SQcyyXPmStBhdaDWWYzVkixcbtFAY5AcJsZiUZvCVOiC9ooelzGee4XGJpF+4gUvBYnQ7UpKLjSQbaXvdBGQ94si4wnL6KfybLcAavmtIf4h3ySqvz9WhqGW1th3tG8uEUJBUQBlxgyAiX+K0nobypeVE4aLyOOfBb4A1X05Pqf3a0orJhnt1izTVMe42/W0E7XWx9k6WsO3NRIatW3G5F3EjFDVXGlUCuc+ymgK69NrJs3KbhCJJYQ468KqX7elRD6HJv6k9+2iXuSqWHdCtGiPNZu+iekdyMEV5f3dMqgemp7AO+mwA56a5oayJAJ+gZ1JjVw8V6UJIOdOYXTwydqWaR
x-ms-exchange-antispam-messagedata: BuIcrkP9DCsakJyjEg6KAtu7ta2F/B/rnmAGPJLLnEBFvPm5dYmNgqFC98KqdVRP/iehsMOcFuglx/+uqakZ15OlwChrvPScxuPJPSaLANVU2eV+n/cxxSul89fPtdxwsysbq45QkDPh5dvKZfxC4Q==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be8e8bb-8882-4bad-619b-08d7b5535948
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 15:49:47.8654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gyGtiskUOtxfFvz6KhxbJ1HVygbtcCRqJPq9f63qEWf0ueH0wEw8ILIegcSozqXrR/NkCQCghDBGzejnHdHUiGMZELPudakyPXWTwbP+n5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200219_074956_006235_0F5C8B03 
X-CRM114-Status: GOOD (  12.87  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 02/19/2020 06:59 AM, Christoph Hellwig wrote:
> On Wed, Feb 19, 2020 at 08:10:07AM +0900, Keith Busch wrote:
>> The last three ought to be a single patch IMO since those should really
>> from an inseparable package deal for this feature.
>
> Agreed.
>
Agree, just made series into small chunks so that it will be easier
for a reviewer to go through changes in a botttom up manner.
>> As to why we'd support this feature, the spec says "The use of the
>> Timestamp is outside the scope of this specification". Is there anything
>> interesting we can do with this?
>
> I can't really think of why this is useful either..
>
If a host is dealing with different controllers which are on a different
machines it will be easier to sync timestamp and read it's value.

Although spec doesn't specify the right use, having this feature will
allow application(s) (if any) to use it if needed.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
