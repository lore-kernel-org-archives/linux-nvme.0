Return-Path: <SRS0=lFsX=ZM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FA8C432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 04:38:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44018206D7
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Nov 2019 04:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PkRfBmTo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PZ2kB8iT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DpRo1PHD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44018206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=+V6iSkNU3Q4AHs4COeBAypKDbsqz9cmL4URU6fYIV10=; b=PkRfBmToyWl95G
	oTAnMp9nzxcFCOaWFZUZT9LzhRM3Exv5phyTn1SVfSoHR1fRs0Plsjg4guJPurrC00tOkzCa+a6b9
	fT5ghzPyguFdIwqpx/KAhnLBMgwmJAbE5j8ub7PF0HtVfnItMh/OhxKI3gUpQHhZtVoN4dA/GQ06f
	sTqDtqvxHbO+VfRbUs3JHNLjatSPWN9ImswoHGX0W73EQ0foM51GqAkkNwACFwEWotI9ybex2NU8y
	v/ZGJk1nlLaEXYZr8aM78/h0UltEJtJWiK8oaq4EWAqvx0htPJuzjC0RPQ6JXAyg721jviTcbXFEN
	nqANNyvcHPA0rUDNqEBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iXHlH-0001tt-Gw; Wed, 20 Nov 2019 04:38:39 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXHlE-0001s8-7n
 for linux-nvme@lists.infradead.org; Wed, 20 Nov 2019 04:38:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1574224716; x=1605760716;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=pfOiwKZLFW02Sh3Z+vANikQvNn0GCL/iTEUl2d+A4WA=;
 b=PZ2kB8iTTkCxwEfa6IYtgAjm8zq/zlnb10dCFY1RPbrC5hxnlj0hFZat
 1jDslQSUp8gxnBJd3Ht3kAVsjRed/WZDebGI8aMss2h07OuX4HEmaU0HK
 OFR8+2ptlE7p/UPfMmmztqWWOyMqv2XRBqI4fZvHerLIcrxBHN+tCFuJU
 e+anFTeBzznF6nxTsX/6bpIxUCc9hHo8Ql3hL1UX8VZAPbguBwDYgogya
 cHNqIdl0lw5r0GcFgljgBSfzrVZV9SWB5DODEhnwpjht7eMcF5XUjrJXx
 o8yi0EkSmtdrYJzJD3jpGEBcpnevLM4oGvr2e/QKKZ4ZDGt0g725bH6Ve A==;
IronPort-SDR: G2aBtNeA4XF5M56H4auKqW3taEdBhRtbEI2mYsoz1PSQWhjj0z+n3XvAvP4ElZR6h5dZU8ZVHJ
 rXY5uDze/OCATCwAyqIrmzeKVxvN/HQ9abf/dETaar5kDXhonHBdGhEfoPomkIf7+AYirq/XvV
 zSfn/W3G1Zv2x0gJFb/1+ox+HEC3+UbWTgQKYrpcyUKdRF/Ly0nR9HTs/2X+BVx+4tH7wF1VT4
 HEyUS7WNLTfMsrc+oU3Q8eBGfHUzTQEfWZq+5SFIJmnlBhjhJKkMZXURd2edCd9G7KTNa6xVmo
 G0s=
X-IronPort-AV: E=Sophos;i="5.69,220,1571673600"; d="scan'208";a="127932418"
Received: from mail-co1nam05lp2052.outbound.protection.outlook.com (HELO
 NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.52])
 by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2019 12:38:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzRAqyIgvcOpwiPAMMvMqEipzuAeerFycxQhx2E8mGbnxC7D+MOMAtAV0NJl1F4B/IBfYOa1/rTa7PNmjqmtugUrj3vszqEkzQg+cB1n+zYB3rEg8deNQ/N0DX1fS48hcgh2I3VtK5F/oZhELbD7RYo1DQYAuiR2OSStSEzuGS+/x4W7J+4h8KvBdF/xGnG9ua7Mw03TNdL83d1svXo2JoGEBSeAEIhHsDVUULhIGY/mE5F7mtf1/Uy1RmnwhsC4HTqYAQlESQZFelEGWT79Al8UGu1JwGqz4U3V0tRNlh4+85xhvfG5JRaiJjOJ/X5ohJWyIKg/oz2zSwNLKDjUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfOiwKZLFW02Sh3Z+vANikQvNn0GCL/iTEUl2d+A4WA=;
 b=FbISZpH8LQ25PaZtuos3tB2CzEfH3sNYvE+t4MExvy/cb4X3sAoVbjhXeItHXrs1SdRvsq3aRfYW1nnqv/QBO0ivm8DpXk9JaR4s2YFI5XQyuU+uHGVYzpzrYHu6z9B0DDLa84EHGvvYxG9PaeoJr3jdrXrY0+zp9a82fhW+4rC2PUCWVEvGLC7YJE9QWvpH+PkAiOJUJrZcHoBXu1OgDcR4jlQ/aCK6/kAAoLY2PLWxLoSJVUx5pf+LOH3pRshUGFCvtCNoyg86Res7xscJEsXY5/e4f2Odn0KTtZLHypH4lByFRrlzRiTPDGu59Xj4wjxmowJiy0Y+6d8Pdnw66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfOiwKZLFW02Sh3Z+vANikQvNn0GCL/iTEUl2d+A4WA=;
 b=DpRo1PHDeqBMCSCpfl6w31Jc3qF/Fhw1yFpZYNCOrwoe2SZoLDVdJ4N9Axr9mCdSLNWkvreg/zpK1BpTMOcSebOlPFVbUmWjAogUpHI46Ti73wadH3IkRv8mSMRSW3pMVuDr7/VEgSvZST1f9RA8jp5K+Yf2woSa+3U2D7gGoUI=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB3862.namprd04.prod.outlook.com (52.135.214.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 04:38:32 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 04:38:32 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmetcli: allow setting of the subsystem model
Thread-Topic: [PATCH] nvmetcli: allow setting of the subsystem model
Thread-Index: AQHVmm2LktnWDoRM2kyjssLnszejkw==
Date: Wed, 20 Nov 2019 04:38:32 +0000
Message-ID: <BYAPR04MB57496600EECD7BDA6639CF30864F0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191113215846.22399-1-chaitanya.kulkarni@wdc.com>
 <20191113215846.22399-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b1513e27-e3cc-4986-9fe1-08d76d737fb8
x-ms-traffictypediagnostic: BYAPR04MB3862:
x-microsoft-antispam-prvs: <BYAPR04MB3862B2F8E4780CD9B0EB5636864F0@BYAPR04MB3862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(199004)(189003)(8936002)(102836004)(99286004)(33656002)(7736002)(2351001)(71190400001)(305945005)(3846002)(71200400001)(74316002)(6116002)(66066001)(6436002)(2906002)(256004)(5640700003)(55016002)(9686003)(66446008)(66946007)(76116006)(6246003)(229853002)(6916009)(86362001)(4326008)(26005)(81166006)(8676002)(81156014)(2501003)(14454004)(54906003)(186003)(316002)(76176011)(64756008)(66556008)(66476007)(7696005)(25786009)(53546011)(6506007)(446003)(486006)(52536014)(5660300002)(476003)(558084003)(478600001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB3862;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mbkf2eXSFAB2e5WDQ40DR+VBNoplIy2/UJ9O2kTbd6rBoe+0iOuE/EYApWOgpX7su5k71vUCw9vYv+nRWO3s2RyYxZufQw8mkEddj6Lpb/XdCaJ7IGjhqoMhaNXwRjLInVkUnNr/Atamsj0G+cEHTVALS7GrPJyapPx2KbRGS6amnPU+YhduHuLY34RzbPvOVZGOTnu9ryauR2I8Jp596/8s1GjuFYfCI+/ueRo6D7Cc7Pk0qyZglydZHpZ9zDPk3HSHmKsIKg9jI0Q23KNTfEZWfdoZVwMjOLRgfn2xL+6tSE47r86BHkJ1tWRyN5UrDd6I1FYg9d6hJ7djMco70kJqoofO/a1sfGc8R35y7czFfUz/y/PvE+PD3sZ8FnOOlyMc2z7Jw9IUKleqrYYp4UfWWLcu8GEcd98IO9iCfLozovXONEVaZyVJ917khIrY
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1513e27-e3cc-4986-9fe1-08d76d737fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 04:38:32.6148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtXaJ5Tm55z85aqTTM3Ic0lTdmRwuF1io9FJv/V/1e9s3rMkaauhwwtwY/YtnVGkIBmSkjkwmwi1vuQ3qtoTL5toFTbw/kF/CA8Vq6Re/Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3862
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191119_203836_306425_2C13C232 
X-CRM114-Status: UNSURE (   7.49  )
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
Cc: "MRuijter@onestopsystems.com" <MRuijter@onestopsystems.com>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ping ?

On 11/13/2019 01:58 PM, Chaitanya Kulkarni wrote:
> From: Mark Ruijter <MRuijter@onestopsystems.com>
>
> This patch allows users to set the subsystem's model.
>
> Signed-off-by: Mark Ruijter <MRuijter@onestopsystems.com>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
