Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEF7C433E7
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 22:02:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9876320767
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 22:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jVYzRuz0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Bl87LYKd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G7/7Ffp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9876320767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=r9cA0paAixRsDfEdWD1kA5VXpePVKMFn0mn1jtsib3o=; b=jVYzRuz0kV3pygCFZf11UeV0R
	Gm+0b0gHszxcLBo4dziGu40OPVBVcy5J8MAkci4hrMuwnxJWgz7dXrkQCFI/epNjZcRRwJWJMltB+
	T8Pqwaevu9x7Z31JpA8wZM8FAO7TCWuhmKKHna+dXVtIrS8R0/Q4MouQK1L7d3ZwmhUvOE1U6f8mN
	DesOxp8exn89lkosURXel1EeoExqrNP3zFT9B+c2+QHHl7mh8sR5abxTidXPJbiGNn1Se4tsVPnVf
	j7m6LmZGsh7Tax5R7q5DBoV7KA10rVsyPsyh0WYfr/xkVTXSAn1lCpizGj1YohQ10kr9em7UqawFO
	SHTOxHJhQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDaph-0004jG-Cq; Wed, 02 Sep 2020 22:02:21 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDapc-0004il-W5
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 22:02:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599084138; x=1630620138;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=qDVbifQmbL8/updS0DbvCHIt7elwqO7zHIDZeNr4X9o=;
 b=Bl87LYKdC4KG/1r39/QHHUWCOtDasJda9V6vTAZXdhQEwp6cMk+H5AtD
 YFAygQfUs/rC7oISbyCgR7qQ1biR2e7CZBfnHe/GSF6faMkOf5SX74E4T
 0KPk7ONMTLpAW/XBd8sb+5Ygg8biO6xJs0AUTODlgERgIBgO3owOl7PYw
 is6z/rJzFDQTnvpv3yHYowa2UXB5HZpueW0ssA2t2x2ayffWtLHdRrWBl
 DaAxNxG4jCySSXc4QyUdl4IecKz4lkl4e82JIDo5JSy1QmOldh4xAIOJF
 r5I++h18VZyZ50deNHM27+CXtPGOTBF3R46rVpHmH8pRx4tGszrhZQgyU w==;
IronPort-SDR: kCzjI8tBqYiB95wPY3S8kN63Tdr3V19Rjfj8IAjOOM5ud1MJewDROgfLJApLxv11/DfQLAjSBd
 en3GKob/b1xESf36tSyS1qA5gHxSkNdG9viJTFl8Vw01f7tctYEmJXB26touQvi+547VCMrzLc
 w6QU92iHAgMAWAZ5e9ulynK3vOuw9a0tZBdFed4eiIhW1i88f3JgAXb5uGBRE0uomG83WxW4FI
 9cwU4TIlx+haicatoYueX1o/wxt1v3sCofS9Y8NA05VDQIxI2NECvDwycV3GL+BY6ZjEdzLy/L
 2Ww=
X-IronPort-AV: E=Sophos;i="5.76,384,1592841600"; d="scan'208";a="150789313"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
 by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2020 06:02:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLnmKanfFBqBhviKCXdH6J/2Pbvx13ueznL4gt1p/ToNqb7WltYtvpJywh8Rbxjm3ynFrXWqGIrKyQfOGFFcBy9qyKUIao0GG5C84q1gwlqP39RCoWwgjU+qduPfenmCQAdDVsjOUaOlBQIKAxnp65YTZNnny5BOES8Mo9sDo5yyW74MECg8RCKEHhFWrAxlZVapOipA5Wx97p+TgJjomV+g4hxmyuLiZih05Uy+VeXy+UiGyEMmEjxQsAh/64gfIMDIK3rRlCI6TbYxj2/OSGjdAEBrW3g9XBWNPHFb+QzFDEUKEiVQC6sYafHK3DcBmY1JqouneqIa9NfLbH7jow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1RChu6NwxbMkszhXqHqwjEskR9SVvjzNgq4Y6plZAM=;
 b=NP55oV2yILhxaEXlSULeUZs4IJXTaHX/6eKpg1+dI/4s6DI08FqITmJsYp3nPiPxGfDpcXAc0+YdquGet0wHVbWT7ZsmNKbsqnLbdEoxqWbh7z4q7KFOrCIXsGXwxTEYqy1qt/5AkvsQyPPugOikA2b6s69BQ5a8A5PLEfIVTplC/GzC0u9mZD22a2T0Nb1mxeeqt59G9Mjg3CngyWK3Aft9k+O6+pFBFY6d2AFFjE4fptdIwUgjaQ1wVM+we5pN877hX8oHe+1zBjgjb7SWYzenq7c5/mdljucI5A3VPibjZ2ByZ2qjcCBWToOPvI5d23elixx1avfy/oDSvoeCzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1RChu6NwxbMkszhXqHqwjEskR9SVvjzNgq4Y6plZAM=;
 b=G7/7Ffp4225mYgzmQuCRJSSL9pPc/iFA6k/Aj1K0SxhBvj8TYuRB2rovqhWR3zcZ6dtTq3BgnuBe1LprTy5+wULu3hZYzw7vonYBhCKueRwYfzHFSONGGW2pOyMZqR2LDS93Y/u6O2r2UJht6tkIa+flVUayMfe5ACdAwGsfvf8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4136.namprd04.prod.outlook.com (2603:10b6:a02:f3::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Wed, 2 Sep
 2020 22:02:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 22:02:10 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Baolin Wang
 <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH V2 01/12] nvme-core: annotate nvme_alloc_request()
Thread-Topic: [PATCH V2 01/12] nvme-core: annotate nvme_alloc_request()
Thread-Index: AQHWf+XlK4Ms7t96TEedzmnzF2kEwA==
Date: Wed, 2 Sep 2020 22:02:09 +0000
Message-ID: <BYAPR04MB496556BD6CD450BCDA919C80862F0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
 <20200831222707.35611-2-chaitanya.kulkarni@wdc.com>
 <20200901015659.GA4398@VM20190228-100.tbsite.net>
 <74008ef5-f54f-ab08-011e-0ff271b1f33a@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5040c02-a71c-4d9b-0c14-08d84f8bd789
x-ms-traffictypediagnostic: BYAPR04MB4136:
x-microsoft-antispam-prvs: <BYAPR04MB4136D159F6B5B278A21BB447862F0@BYAPR04MB4136.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:549;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YhVwlm5aRnnv1/mkSGChbCnTEa/8pjeIYvNI0WtmHGqUGs3e7/bWa75r6e6QS01KhyvdLYImC5LrXnI5o87bTgVYEzWu26Ysjl6SswXVA8Oz3sl7hwTRK/YqGE5jJQaT3UVRI0Z9A6riAOXW9iR2snMYSKuV16qSgG1tsENXILOCT+3z5OIhfJgpGhty6Iyb0hAmqvqVWt8NwLnFJeHQqdexocqyYPW/y/jPm2+lOK6q9zg4kk07Wr6hdTHiZrAg6YIcGUUHVSX9zHc9rInA/ul/FttJbSJ82Yz4trlE4Fxw8UfGXGzUuh5YrxvPh4wmMgGHOQC2YeOnySRKH1LJCA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(6506007)(8676002)(7696005)(76116006)(9686003)(55016002)(53546011)(66946007)(8936002)(71200400001)(186003)(66556008)(66476007)(4326008)(110136005)(33656002)(5660300002)(54906003)(2906002)(86362001)(66446008)(52536014)(478600001)(316002)(64756008)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: eT8Tiliusz4Eg5rAgd6MRj77nPHXdWl/ODn9LPx2YbjoswMTSRAWjYYMtV3spNVKtEl/xGv6qWHfuT6c6WTdjl8R1p+3FmwF4zL6HwDvQ8WrIMP5ddFDEyRyUsVvFGyK7catkMSKyu7/+RgnLAFUuq1oWKIT+pZs7Y2y5+wCAYeCN9PCzFkF8Km+TbzU+P2CimPNjzOPgf37RPI/Ea+u5fqnNSQQs5he4yQm6f1yl8uHXBDbO+fTfRxa2dWej+75Y23gvqR5Ky3qaKMm5vWgavQE4QpFdmioVtqTd9Y7jt8cex8GoApBkwnXvzbnbJ2v0PRG9ZF3YpH87CHqyt3+UYMst5OseDI0H3fY8gdjfkCLJVTH3LBc6fEuqEnZd79CfM9LKGPvjKFE96970XGgmXr0wiLJONj1aSK+r7xarJ/XwTMALDxCJRXCHDTKjaVeyM8MUAmgkbYh6sONzFX/+MpXqVKnX3zoWIC4ptgxwHBujx9wCs8t0xUPaQ6RDZWGbVd17IY5silKZwxYZYYGoonXgECicm2je0l92RWr66A3JaxicpKiCoVYbuNJtEUe3YFHernbt19x3i+IIBhl/ltD0W49TCAjeWfT5KdkbRtmjVBCrODkuT8aioZkrMQ/pvm4fm+qnRkbePbb90yANQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5040c02-a71c-4d9b-0c14-08d84f8bd789
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 22:02:10.6507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWQj97lHm7u0AvW8rYLO5LfIKoy7yF0RCCKMhwnfF4KjZVlQUBKRujCrvNT5w41CccqMgnXd4ZhtX8YJajnX3usAW/W8HFhFKOR5zjW4AHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4136
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200902_180218_031506_42A734C8 
X-CRM114-Status: GOOD (  12.08  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "logang@deltatee.com" <logang@deltatee.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/1/20 10:21, Sagi Grimberg wrote:
> Chaitanya, can you check the objdump that the change actually
> resulted in a different machine code, I've seen patches of this
> sort lately where this annotation didn't change anything at all.
> 

I again took the numbers with and without this patch :-

# grep BW nvme-alloc*log
nvme-alloc-default10.fio.log:   read: IOPS=66.6k, BW=260MiB/s (273MB/s)
nvme-alloc-default1.fio.log:   read: IOPS=64.9k, BW=254MiB/s (266MB/s)
nvme-alloc-default2.fio.log:   read: IOPS=65.4k, BW=256MiB/s (268MB/s)
nvme-alloc-default3.fio.log:   read: IOPS=65.1k, BW=254MiB/s (267MB/s)
nvme-alloc-default4.fio.log:   read: IOPS=67.2k, BW=263MiB/s (275MB/s)
nvme-alloc-default5.fio.log:   read: IOPS=66.3k, BW=259MiB/s (272MB/s)
nvme-alloc-default6.fio.log:   read: IOPS=64.6k, BW=252MiB/s (264MB/s)
nvme-alloc-default7.fio.log:   read: IOPS=66.0k, BW=258MiB/s (270MB/s)
nvme-alloc-default8.fio.log:   read: IOPS=64.5k, BW=252MiB/s (264MB/s)
nvme-alloc-default9.fio.log:   read: IOPS=65.4k, BW=256MiB/s (268MB/s)
nvme-alloc-likely10.fio.log:   read: IOPS=65.5k, BW=256MiB/s (268MB/s)
nvme-alloc-likely1.fio.log:   read: IOPS=65.6k, BW=256MiB/s (269MB/s)
nvme-alloc-likely2.fio.log:   read: IOPS=65.9k, BW=257MiB/s (270MB/s)
nvme-alloc-likely3.fio.log:   read: IOPS=65.4k, BW=255MiB/s (268MB/s)
nvme-alloc-likely4.fio.log:   read: IOPS=66.2k, BW=259MiB/s (271MB/s)
nvme-alloc-likely5.fio.log:   read: IOPS=66.7k, BW=261MiB/s (273MB/s)
nvme-alloc-likely6.fio.log:   read: IOPS=66.7k, BW=261MiB/s (273MB/s)
nvme-alloc-likely7.fio.log:   read: IOPS=67.8k, BW=265MiB/s (278MB/s)
nvme-alloc-likely8.fio.log:   read: IOPS=66.5k, BW=260MiB/s (273MB/s)
nvme-alloc-likely9.fio.log:   read: IOPS=65.6k, BW=256MiB/s (269MB/s)
# ./get_fio_avg.sh

Average Bandwidth nvme-alloc-default 256.40000
Average Bandwidth nvme-alloc-likely 258.60000

Average lat util nvme-alloc-default 974.25900
Average lat util nvme-alloc-likely 965.78000

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
