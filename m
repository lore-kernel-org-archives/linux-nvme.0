Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1468C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:14:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D8A20734
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AAllXoPn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L9EZ7SWt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d7fMUxj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D8A20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=bkNj09SE6F/TcGe+c++qSvAeVUVt5Ak57oidNUpqxTI=; b=AAllXoPnTqQqc8LIAmOkNTTG8
	VnGwsgtmWPPHdbnvGyV5ZrirfChZVx2dn5goY4HtA33pywN4lyU9MB5GAcqlBKWwnOflBY4TJv6nA
	9rXXH0NQi6vcJsJKuVAevzWdS/FC86Gno8lW7FqNvz0CufJwEhpmnUmSxlN6sblRDqN3P9XlieAtH
	xW59A2CLnkyX0nOSCyMnq+Zmc76sVB6yBQSlKDr8q6uoSCdKH4KEhFdBS4qDuUTGrVzqJfF3PIWl7
	8g/JFJ4xNoI9HydzUiAF9idIcU+vZtrnVlPRnnIQC+0IP4oELvNLsWRa3lPGqrnKB8/HTiU6wV5Z0
	5fBCLeNNg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Gzd-000210-6v; Mon, 10 Aug 2020 23:14:13 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Gza-00020D-Ah
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 23:14:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597101256; x=1628637256;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=lvR4bqAaZ53Yazkw/kqxwlF4LGOIIVKThx0wyLFfhS0=;
 b=L9EZ7SWt9p+itacBOhN8t72kkxIWCy6240nCdX6PxORPeaEDeco+4CJy
 eL8gFDfwicVgfXylyRUt/erKsm0TrCbWNoBA1pXmRaH0xhNQGS11xiU9+
 LY6XxIEnTsDlyr4MQcdasybbufd/6yLtmUmLxzOo9K7Fi5zgmcAuesrOC
 crKyQSNuOC+2xKylPRfrKcnLs3LlIPLoyvALzW+JerrorKxZxZnUurTfq
 YKe3gcXT2U5yGDIAbU2aC+YKj5s/u2YrMwXBesgwj0+kJH4TPzivX8Sa0
 erpQAHEZSu01M9PO8oLnvWtSixEv/5RudDJ5Jo7F2oZwqBU37rusnzuzm w==;
IronPort-SDR: 2fCwI0dOqOaer4VpRHXSkZnHHl9DdWFg/hTYstuJbJLt3/nelLbY3snmztVzhGo1bDcJX1Gp+e
 IXPU+5Bzf2QGGlPjeTjevwGMfteQ2Mkwwm8EmbLYXAbsPaYuGSolvM9Ry7oMaOX/XLzhMQtn+W
 LuofjexpBEVIjn/rLbt1H9tOthf3rsrF2BWs+sW3NyM0gfqB7DRpR7kuQEVU/wDlYM3UFNmcbP
 Gw+vo40yRc9X5I5r+D2UcudGN4A+tZLH5Dpxb8Wwg7lUUg9qg0mHj0Q4DYc5usNxoIGt1M7Bld
 hkM=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="247750962"
Received: from mail-bn1nam07lp2043.outbound.protection.outlook.com (HELO
 NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.43])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 07:14:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fViBrU3GWPFtFq/az2Mk2tUcbkY19xGkUqaG0DtXxQP8P3yVBS2w+HHhDPryxS1UrHmnEg/fXMNBzxrvqAAx0phFpBlJYeTtD0A27dp3ZoPVJ142u+PK9PDmxl8rts8mJYrsTZABDycFN3eFGi/M3jGImsCydaxGKanOg5YC47DNgZlwOIWOTgNqNWduCCHECnARQR/1CRCdr7tCw9k+aC7mJteodGwHBV23dxk9qo6IFr57ZhVlEq6P9lCoMc/mWrgwu+s8WWZ8Jg93TMKAyBZqI0YhSwdMcV0nQdHLKtrIMDuyHk1mwSUnFSPmSKGy04kRACtQfUUFGB0ZretOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnAyLRaLjoBAlwCzCDP4F93es9VcXrEY0Msh/EjReY0=;
 b=JlxO/wtrkyM8X6OqqXO3K9OHJ2afoE/Fo/mZj1S0tkbfc+LdJEY7alCRRK7LbIkhKJu+Gzu/alM/IcuMDf984EWIdrnNEVyk46fMhBYCwLYXomwzcYG05f0j8RclM3+UoR5yOVdiFQBXSxBRFW1oZytS3dyJckKjsaku49fNXjs5kbHzvt/uIIOzXalhexmpowSk8yfeCu2R1iEy899aBQEUiJhT7hZtctFvpm/iRBbJJ06s/Z6Wa9esjX+w38jQW7YsFCfu6R9ma54bXjPpgvIQPqyJjVUHy3ynl2v6LcfDYRLDX8vFER/Lmew0JeCcop3JA2jguxqNx/fiJgW9eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnAyLRaLjoBAlwCzCDP4F93es9VcXrEY0Msh/EjReY0=;
 b=d7fMUxj/ZwN8jhXZvsVO+MArJBiqtWJ/be3YIET/CBulR05W+3zpImERymYg22S+9TRQ8o/fRH31o3xWvsGzkXKs7YduFDvh9Ju1TtbMg7usyGYLmHkPIfs9NCH6mNMwNIrFcyBlAoYs+aUuDExv2p34J7FavmW3GffP4tHcNZQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6549.namprd04.prod.outlook.com (2603:10b6:a03:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Mon, 10 Aug
 2020 23:14:07 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 23:14:07 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 14/14] nvmet: use inline bio for passthru fast path
Thread-Topic: [PATCH 14/14] nvmet: use inline bio for passthru fast path
Thread-Index: AQHWb0gBC+qiWfsFU0SSpJuCbDzn6g==
Date: Mon, 10 Aug 2020 23:14:07 +0000
Message-ID: <BYAPR04MB4965C2D5FE234BCF8BBC983E86440@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-15-chaitanya.kulkarni@wdc.com>
 <30a5a7b1-eb30-8488-850e-7ee5aabde933@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cabc78c4-4b53-48e1-c6d1-08d83d8314cf
x-ms-traffictypediagnostic: BY5PR04MB6549:
x-microsoft-antispam-prvs: <BY5PR04MB65496A583E5D43D146FBBAA386440@BY5PR04MB6549.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vgvble5XfGvJs/AqVJkPvR3797wSqExY852iK22BDqDebG+lf1b56K6GFtomXiyQWA068FkwQrHvOqOvBOmKDuOehJjnzA3X9wAw/6ScpRApGJLrk4+rEVUo4C9kayq84hM0D3TKeqLHwn1nYkWFr7FARnlCFoOXwnLkSgkdZ4V394ZE+ZV2C/opZUqiYFnTSxm35G1YWRCi+2ieuPBdUpGmV4F0kyPakHXtlOztGoWbEOfuIDmt+c/X5W2OEMC6YffgJEbD1UTGBG5ijFUgp+McaLQoq1B1+2n2loe8KvRZeQipUte+TE5D5Pzyn8EZg+c9i+sIVsBN8jkRNP2x8Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(86362001)(2906002)(110136005)(66476007)(9686003)(4326008)(316002)(76116006)(66946007)(53546011)(5660300002)(6506007)(4744005)(55016002)(54906003)(8676002)(33656002)(8936002)(186003)(66446008)(478600001)(64756008)(26005)(7696005)(52536014)(66556008)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: bd4k1sAcvwFJB22uycH2PEzDVPI/muifQL+S5TQLQuGqo7HaqrvvbOeZE94In01epZdKkfZ4RzLVyyv+hzx1XoqEdgTONdua+g1SIjrs/0ET1g7d3xYsY3pkNMeMvL0Lh9vNPsHtNjDYmYTMtCc7ppURTmQcji1jMOn2L8TwwrFecMPaRgi+mYfOHUHdybLwFAyMtv7oumJltGNAwgI4je9GTw8xTvtPM2kmEHHVxa3CxFQ2xJ9uluiiUkK0cCkTIQCN4tfkNDedqC/+MADrrEBGlKBg2bOQP7nLOhYJHtgTwU6/LR0Z8KvcIX9LWiXh2xyVMuKnStTBdPFmAPzCihfxp7/E4aBNthOqjEl6shRiHmWnDkwdUBxYoxCSJFMQCdqeSAZliR1B1iE7mN6TRGiRhD+d5NbRrzokHPfjef0nK4AfH5hUM+3ILuQUpMKmflKfJFiNxkKTOR2Ddsy020kmCVORwzV/XYZ0CMIdzWT0R1kRIzKrRLNNPE9S6UPzLvgC7wUX3/1UWvCfUPZT/GT+DQFKTUqRYaRy6F88HVhcYhkXYoJxDsXLip98HWfRdwPW/tbJ3pDSAFHyIoiza/Jak7z8kq2zKsnbcz2tzrZotjpRHbeEqDY6cBpflSD4n7UZUnSVTV4WvN2COF6TJQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cabc78c4-4b53-48e1-c6d1-08d83d8314cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 23:14:07.1147 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9XFSUq08XHcMjBgBsamP3k9fhATrp0qbMBzzhq9MAM0ubr8dL/uyR35iHeO0hZW5VYZKwZ37EqsdMxPwExepNjEC0iyGojQup0T8HIpH8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6549
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_191410_500561_F0F46B2A 
X-CRM114-Status: GOOD (  11.59  )
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

On 8/10/20 15:47, Logan Gunthorpe wrote:
>> +	}
>> +
>> +	bio->bi_end_io = nvmet_passthru_bio_done;
> Why not just only set bi_end_io to bio_put if it's not an inline bio?
> Then we don't need the extra bio done function and an extra if() on
> every bio_put() call.
> 

It is not a big difference, just keeping the code consistent in target.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
