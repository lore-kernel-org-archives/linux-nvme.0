Return-Path: <SRS0=rLKq=CO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAD1C433E2
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2020 22:03:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0B8D20760
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2020 22:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ebLYH4zv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BtLw24aw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gDDGpoLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B8D20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=cybTx16dJ0TOMsF4naWdp9pCBs1CyXAgV2c79sz7Io8=; b=ebLYH4zvOFs99tktg46W4grx+
	etQa8IVS6sqfMv2IjinKpsHBiDl8auIrkiOF1BDMZKsH7RfFQY8BUn5L/ifCl7XUSen70uh3s/wuU
	Wd/B+8c+vNx0xi8oaFurcvhnoQbPBU1iep157kl79TsvawrDvrdNtgjEVNM44bUFi7LzEAfVC4w4Z
	DcuvRKwbgJujcPv73jqK/N6pxs5nNZhx1swPcaj2VUlSbHVHtH0Qhh4vWYg7yZAH9B4qm3RTpiZX/
	rqcWew5JOmQRcAZUVM3av1G+nwzqfbneYlxmBsIrxiYVUhdKDAt8Xzp0CYub7OcIBwpmrkdRsH0mX
	3FRmGhfqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kEgHD-0006NK-LI; Sat, 05 Sep 2020 22:03:15 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kEgHB-0006Mt-Dd
 for linux-nvme@lists.infradead.org; Sat, 05 Sep 2020 22:03:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599343397; x=1630879397;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=/aG40/9I95N9jn6JsOnjcUBmBCWgl3OvgqT38s+14wU=;
 b=BtLw24awWimmU6V+kLUAvVzfUE7fQD8mtkgN6v369kgG4DBaL0pr4OTl
 D/P2tfXIljMjXLrki+ntrD/FTQjEhvH8KdXf20n33Bl28uXCmkqWbAlyK
 W5TcFLkVLsPyrBVcPKtCZ2nmA6rxWsSUh9T/Em6yzN1CEgvQnIwYv96uR
 5x+DHKhDyx6JvGJzoJv+rzZX/SnJ5Rf7S9ygp+mRBRp8fhhIeKjbZPS0Z
 BorB+b4r415/4efKyc1S/cBD1xTpDsmbqSZfCuk9NCV169nrmUHBLCLEJ
 5UryFZAb5/UL8BiqQxRhtJX4akH/6bNwTHp/VvUzSZJOScYCeFrxVo8CF A==;
IronPort-SDR: MOhKkWem79cGhhizUB9XlIRikCtDskvWj/46Ccm0mqhpnoZuHLHQBOtzdnlqgrobq2gKCND/YV
 GkD08EGQgRB3kxWCOl4kmvS/wKbiboCSK4kf0Tj3rSSz9aCa6ov1tIXGPiNm8cDHlGc4jSZ8AX
 8u4idXw8XYBbc4wFac1pARA5RuXzmOdo1ZER6ny7nw56CL64PLdaPTMtKC1sa4FtQXAAx/WRVE
 VQeVdEF8CIa+r0Joa44szwRu0ls56HDt/caEXqZ/TnoAqRQ2KUqw2/nUd7cZacEg2ColIZ9mfI
 ccA=
X-IronPort-AV: E=Sophos;i="5.76,395,1592841600"; d="scan'208";a="249932953"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
 by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2020 06:03:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZKap4ZCVSG5z8RU0Y6FFp52qdq3Eb31r1049egXBrwgWxKJ2sgVQG1UXF819V5N8oPG3av4iyw99RfeK/u2v4XoCHl0uSNHd/rGSQQTaDC1JZB3DKHef5KVSPgDF+E9Hya/xHW4cFPtkFDOq9qUyr/1gNZhkUCtYSyH1YkvM3ssynedZZNXzXmPc70l2Bh70HzvgHMMbZYYWIXaHJAYd9enCZUxhSPxXPkrn9jd/OUSDHPjv7AkXu/5FQkdaVXICzb1mRcGySBKTKhlkxx4WExPdfsgEJz4LvLUQnTFBy2yoq0apN8ObcJGzrywbfcytHwBWaPN6HbBVEa0NIlX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aG40/9I95N9jn6JsOnjcUBmBCWgl3OvgqT38s+14wU=;
 b=ZGSAdWogh7sYmMkq1cgnsq9G/qVTmiLt7KiRi9i+voftuTfXfW2vo1RaBmIWKEpOIcTOdeHtNE9Mh6lAom3teEZW8TKr+Vw550ZAS6T7+eGlTuqBpUr4bn4KzrJDrsWhFB+zLbmYCTebY9QljLBrT0oFCP2wR38oR8cnqn0HzSu5tAJ22VPvG3bAw9X6yfusfPuikpobHQqndwc2+z2v5noK5IOL/4T7HO3b3VJUjhfHLeKvlrdMd5mjhNiU/W/Xp9Vg0QibnVCqo/zlPoH7bj2EsIsg/he1DySxT3TcS3OLasKF17mB3l5+rUmwIsffialjVFGvJPmRR0JoyLeJxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aG40/9I95N9jn6JsOnjcUBmBCWgl3OvgqT38s+14wU=;
 b=gDDGpoLYwmmtI4+WBhiuhewJTDn7UoeWNcO6alHzf38TW/yBr+V5zyYZOSo2eUepHV6kXXyB3k1ToA6+hPzjarFk0O5hqzWXVJST2MOYz2GG0RFklBCmnwd9Zl0+jT3OfHHlkATpEtk46BNsRXwLjbYdiCqNnoISDh4AF7Oqcuk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6278.namprd04.prod.outlook.com (2603:10b6:a03:1eb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Sat, 5 Sep
 2020 22:03:08 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::a499:4101:5ba8:828f%5]) with mapi id 15.20.3348.019; Sat, 5 Sep 2020
 22:03:08 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/3] nvme-core: fix nvme module ref count Oops
Thread-Topic: [PATCH 3/3] nvme-core: fix nvme module ref count Oops
Thread-Index: AQHWgmTCtMLwOMsrwU6Y6zgq881SxA==
Date: Sat, 5 Sep 2020 22:03:08 +0000
Message-ID: <BYAPR04MB4965A6C54007234812735F52862A0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
 <20200904023929.5320-4-chaitanya.kulkarni@wdc.com>
 <8c075e3a-d461-7d58-7c02-5ce81cfff6b9@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0fe75a8b-aca0-4be8-48f8-08d851e77935
x-ms-traffictypediagnostic: BY5PR04MB6278:
x-microsoft-antispam-prvs: <BY5PR04MB62781FA96C1415B722207653862A0@BY5PR04MB6278.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMWe3z7ujPR0SHtMr0CGAN8hwQHtZqnJyxfJ5EHKhypZ0sJfjR8gR+4mHdkay7ib6V23L2uh4L4Dv+kx5c1g+YrICAre41v5K5Spi5sZojIUdprw0v3v8PQlEP2rUhq40Rx1hvxBOs9ucF47v8qngVzH1AO6OCUbJ1mE9LKqVU/zsRvAHWTd+TMYFZUZMs2naxldNCMmKFn382HJso9c1QW9E7gKzFbtW2cJdg/nNUC5/sww5WQ5xItHxbnyDLeg8h0WdrG8MK/pANjMFk5nmoHqHhkL9Yff2tIR1Uns9x/lsXO/+/vmw3mYdYVr7FqFcNgmCW/f4uyHBSQ9I3VC8Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39850400004)(7696005)(5660300002)(110136005)(316002)(55016002)(9686003)(8936002)(8676002)(54906003)(4326008)(53546011)(52536014)(64756008)(86362001)(6506007)(66556008)(66476007)(76116006)(71200400001)(186003)(4744005)(2906002)(478600001)(66946007)(33656002)(26005)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: zIClrvvzTy4T+RrYI7JupHP6+AQjG40mIEiyA9vdplPDfXDXU3JKXzkJNqm1qWEaY8i6cBwjiNfbHLRek692AJiwh44ygANiJ+qE40TjU/h6aH1H9j55ZJhJbdWVwQp8N4OQRg5WCljYeDJ0o8DzV6spJpKmINYEz2q7ztzUPc2iUp6jBSLbWIEKqHEjwr0RTX9qSrtBRtYon6IZ4fYENgIuoh1q2aDuu8iHKsrvRFFxBaq0OF2xuitxIYGsaWxn6ZWscJRNAkJuCriMJwWUidiVLdLdllQ03B07BEEXcPyUuoeQ/DlusZmzBbHkj0VBXmHGF7r+l+Rs+tBjXduP26RLuZsmDkgymW7exT9lnz4jT8BB/eIyZpvZWFczfjT0l7xSft4AsTGRPsbmiDQhyX24cO/D+/jr2X/N3hT72Xa7u8rlKGKEnGod7/Y31HvKjQpFGAsQOcEHDHZTwMl/jff4HiksLNi1wuwbMbNm0uiRiV5eopIJ4WmGB3IU02RGrv3piT1tgQSbPB6OEL+IHhGD7lySljH+dxICzxmC6IbcUboujKD892ipVcvxPpdWU79c4aespds5j/zF81UAyqssulpwCS85f0Sp5C5IjEmUF6AeSzHP3X6tRH2EPQEpc2I9XIGsIxnjC/SbFuepjA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe75a8b-aca0-4be8-48f8-08d851e77935
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2020 22:03:08.3756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RbsXtnVzlUX2xSREX0VIhCvzvvp2YioatrsCz/rrXj3TztK3gW4TJBSaQZsDMCfuPvmYAZKw8nusIqeCr9XbAV7ttXhzPh9q6mrJb9LH3Sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6278
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200905_180313_742727_7E77C414 
X-CRM114-Status: GOOD (  10.94  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/4/20 08:57, Logan Gunthorpe wrote:
> I'd probably just fold these changes into the previous patch. When we
> get a reference to the controller we must also get a reference to the
> transport module. So no sense getting the different references in
> different patches.
> 
> Logan
> 

That is a preparation needed to actually fix the bug.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
