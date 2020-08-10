Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8B6C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:20:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6496B206C3
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1TITbBLC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FnJzvt3v";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dyesuxNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6496B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=OAP1f3YobxuLXNNvvOH6wHno/SLDWN0MOzAIq9PYYjk=; b=1TITbBLCx8L2FdFaFocQYO4MV
	uckG1d2k5g48xf0KlEaRGBeTFjMJQqFvvTLlIBr2ludP5xhJluBswMUMH65vJvqEZzXoI44rRCGr9
	+DamaKZocG3VtZrQmm9cJTZfsWq7piFqzFOpfGwZx7sUhc3QJtZ7KQ8Rm8EI5WfDvBPR95AhszDFj
	JW08b9aWzB86iLFpug3Rq9q8xU1DhNwOpJ6MJhiyuDlGOAJIyBEEt8sRsaYLBKTSFTb8mO4iIgmtG
	FfwKeNhzc8ewA/KdxX1mKaiWyqVziAC5q2YHGbuFPhvhUriB2wM081PMgziE7cmuLLgHIpWbDGqF5
	gI0HPqmSA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5H61-0003CG-FY; Mon, 10 Aug 2020 23:20:49 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5H5z-0003Bh-Dl
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 23:20:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597101647; x=1628637647;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=EFfefyp4mkxD0uMoWmPPi2oDbSO47bfY4o4ClkfInig=;
 b=FnJzvt3vrKYGDbp+vvBigt63r8kEZ4K8/5358zMSNWDGTml1sxEkJeXS
 JLA4HwNYyzz4tTWcdvbnhX/LdqRuWYHv/n82WLDQ+7Dr/jYOAFSxoGrfW
 wEUFfyGzUNRF5Ckx06Qn/h7iluP3zJ45ngCcBhcLTvlJ2gjXsBe1Fd2H0
 tSfrbRvBP5axuOwsNdw9pIkpWdV84OkAvFD/VS9vZ56VULu2Mb9+I2VDY
 CJnY/wu2inWqlR65IEh0kvS83eB1NrjIAEgIV3TgqLd/rvFfR43/Mj2jg
 KmbBQQ2hfGt30Sx7KK4GOUOZfBbljrMs+pto0GlQwy950g24cX8vY475j w==;
IronPort-SDR: Z/DHxvIpGAyzyfXR/fRCelE82blNJPGVbAZMR0GlxwKABN3mbPT8CNq0mnBveBZBBVQDAokzhN
 08T++ST0VRXJfymBTdduIy/uJIB9ggCuVTqBljDH1v/mooBj8ytjmOgJyi0aiFJghtf9AYGfaJ
 KaV0UYPIzPHFrzzhLRKfWa/R8C3Bry6gz2H4Q5sqsxaVkz7XjZlWj5ggnyJi3e9TVsI/P3dxoa
 DD32wcGV5x18SwtGhY6NEwUhH2b5REQsPxbr0+mF+eL/2paiVOO0JlZh2u5rMIsElUZTnQJiY4
 YWk=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144616806"
Received: from mail-cys01nam02lp2056.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.56])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 07:20:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ay1m8u7fj4gdFCXxe8pzgerBmaLc69VcmlvsJT57CZX28iIHN+sefmRtCgYddls8ySqynRmNxk6NjQcuO8eCt062ohPZzkg2NOFxtXp01JzWTASBRuEjq3QLfDFrzbNObiMiVxLI5gvtLlWjCqrDZ/+H4a+o9Z8fHvdwMs9mTo6sNh9v1ltLbBIXySdv5OQ/4Tv0uPHcv6efdymcwwOtGmyXLgAdMnj/5lqFyFJFWPAErQzJQq8Cr6tE/PmNPt11HmPJzAV9RktF6zImH25fL1Qy5qa+en/qmUtuOnD4E0fGyRJeldELzkgYxn/jm/upmEaAOBRpu600QO0IDd5uCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFfefyp4mkxD0uMoWmPPi2oDbSO47bfY4o4ClkfInig=;
 b=mC7+xhKRmpUV9OIhV2qrCNv/QcJH+WtQ1keeQ8S/kXPH2YYdzsSTsaEm1W6RJgl41Teiicf3Xk+5i5DSzlvIxi4ukost29uryz2/zyygM8tlwtZmnCzHkNx5pX603w4QL+85CXtGPofoNK1V/o33+OG3naNda6oRtO47nIahxdL4quqBNM27hy57fCs2j5VJsIqsfzlDr6Q7bMJUwIr3z1EU/EQHFnzKTKq08oPVhEAKq/45ho43tR9o9EoN/bAJ3H0dz2I2zP0co/xiwn6pIsD0uOXUAy0C//FFpwkqGRhC7xEgukFXVELjGy/by7353JPj9uOgW39ZfZ5M6zSaqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFfefyp4mkxD0uMoWmPPi2oDbSO47bfY4o4ClkfInig=;
 b=dyesuxNNE4fIv2F4zDkaYlbHzXF7r3PaZOVTLszOHdRfFUh/FNLNXvKeQjcvlFWhKQ8FKkQFLJv8MIAQQxsEI9M9wOVBz4E4avU0gc7B8slI3Igx/uq6Ow2h3AETQL9sdacLwBM4FQTjspB7f/SficzGYK/caf3U+hOEMTC8Qg8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3959.namprd04.prod.outlook.com (2603:10b6:a02:b2::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 23:20:44 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 23:20:44 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 03/14] nvmet: use consistent type with id->nlbaf
Thread-Topic: [PATCH 03/14] nvmet: use consistent type with id->nlbaf
Thread-Index: AQHWb0fOeY8vefgEbUuTM9pu6XCb1A==
Date: Mon, 10 Aug 2020 23:20:44 +0000
Message-ID: <BYAPR04MB4965063474E04939E248D55D86440@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-4-chaitanya.kulkarni@wdc.com>
 <31ec987e-edf7-0f02-4edf-de33c9c6d533@deltatee.com>
 <BYAPR04MB4965062CCACF7B2DF5F144D586440@BYAPR04MB4965.namprd04.prod.outlook.com>
 <f6f1ef01-952e-6caa-27c8-1f51e705637c@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27fbad64-8bea-4f78-6e65-08d83d8401af
x-ms-traffictypediagnostic: BYAPR04MB3959:
x-microsoft-antispam-prvs: <BYAPR04MB395955E0A410CD27987E3D6686440@BYAPR04MB3959.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3sOC5GtoMwDgtGnlr2S87Yr7d5JSXuGFPWeNypsg48EafjHVj/0X5M3cn7eJiAYz3b+7aLVRNELwBzCKnmZCixdvbOzJp24V6sL5kSxHbGvr6PFXZPXPbqZ90rg8dAMbi6GvUbA8qXAqnCM4DrlCzl2Lo6XOmlIdFvmvoD461h1WgFE2wxvmcf/r+UdG88Hj6SevYV1m6aN2rn0f3tHVAlqIwlm4hcDGf1RCzOk0DTowjcO1Kj0xfWGMrNaWtIyBWRBNaR7LUmUGNUafb72sr0HArSm657FR23UDjElbnrabRGYo3f/QtAlLQeKZMLe3CpCuC1UW3LX10lJzNJ4pfw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(186003)(71200400001)(4744005)(316002)(66446008)(52536014)(66476007)(5660300002)(8936002)(478600001)(66946007)(64756008)(2906002)(66556008)(76116006)(54906003)(110136005)(83380400001)(55016002)(26005)(33656002)(6506007)(8676002)(86362001)(53546011)(9686003)(4326008)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 4IIIpHpPB1roLvaHAeSx795F7S+bIcPxDUwoXrnptxcAMIkWos+OA7EDbkZVBsTXGNhyId6KachKb5rRQwuT7WLGR4cwmfuZ/Q8vQNzAmLTdcAqFi9AL3HZ11ZingHqmWXhXWcLFbE6NbK6K2ga+ikMbfGOvB3VzYOd95L7TXfumq2UBUa4I/L2AYsMvQbR9RXzspIER9cesJqcoCNxYJRhnZ0eFeB5+GVcjSzAh1PHpHFVXffr/YXB+OVofrlV0Odm2wmwUb8NHi0yZQZ7PWzwIjqRT39YNq2RCrK6Sr3/LO7UeWJXoKTzP4O3VUCgz0W8y4DYFOKmisT19xj1RQVmmOIm6LpawKhLcLz/x59375uix8pjPG4/67AzPgVZgCsvxWdv/b5bndI7nj0s+QsAH6PoO7FxIX6We5Qvaviw/BB/EKuQW5xscBRf8h6K7kOCc6ATfAVHi/imjVVMfZjDf3n87fQSaXQWtKKkYI8KS9eNcFYVLB9D+sXlefgiOaN3PSpnCX48Vz3hm0kC2MwTkWGyJYnCRP7YIC0TS2gtLMg84xjFxbPmH50jTsiVMLv4TYlW7kvhjDPKUn3zgYy1nErpQBgpWcwKF1+PRWTI97NgtqOvydnRLPNvHRHyR8vcVE/M/uDrJZaSuGiNctA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27fbad64-8bea-4f78-6e65-08d83d8401af
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 23:20:44.4827 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rRg2mfa2lizo8HOuscSnvT/czdmyIgaDpTsyaFhN9L3+QGffldVKu+VYUuwAoJpqx7vOIxUBvt2NxAAQOWiOna/CUO5TttvlS4sfH/UpQbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3959
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_192047_611811_4768CF88 
X-CRM114-Status: GOOD (  12.16  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/10/20 15:57, Logan Gunthorpe wrote:
>> It is a type miss-match, why we need fast type ? its not in fast path.
> It's just normal to use an int for a loop variable instead of something
> specific like a u8. The type mismatch isn't really an issue here...
> 
> Logan
> 
> 
> 

Just because it is norm that doesn't mean we should have type missmatch.

Also, what is it we are getting out of having type missmatch?

This may lead to some remote static analyzer generating type missmatch
warnings when someone tries to run proprietary code analysis tools.
This patch pro-actively avoids that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
