Return-Path: <SRS0=Pknt=5T=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBBAC43331
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 20:10:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC67206F5
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2020 20:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mhx94G//";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RFOXq18V";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mhBXRFdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC67206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=xxRCPdBIGhD8rUdJTkx6zyWiZH7ZaA/BneDG8XnjRcM=; b=Mhx94G//wP2yN6
	eb5r5oJyDo9TKNwkTgrSd22Lfyg5dcy1gAQMrHi8hIgo62oW3NsHPlteyi8vS2twIvApz/St29/Ui
	FxwTTt0mg8kDs/bja9fYjnicwOO5GC52WSGPBeJfe02Bt4vNQpIzATiZyeo+Le2VLokuudDU22XdC
	xoKNlyPY2PzMfirIDEzLHaO8OIsSQFgUCyPBXiw+vtV+ZLmv37Q+H4Y6IWdr0l2tqBGCpAhlIGIGU
	RsX/9wMMzvbvNt4YHBtWcwfRpMp3oQQDhyURAgnI8ZBBAVgjIfehGuBPY+3QQc/ASHJw26sqDsvj8
	5mmsOtOIzZYnX2pTBxLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jKSeF-0002tU-KS; Fri, 03 Apr 2020 20:10:39 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jKSeD-0002tD-66
 for linux-nvme@lists.infradead.org; Fri, 03 Apr 2020 20:10:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1585944638; x=1617480638;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=G+61oNwT2wSFU9lVBy7bwQLRyVzzerT9NxzgoZnNb+U=;
 b=RFOXq18VegRxNunWh5zLZSDZlmYg5LFKy8HIakyA7No10sRpv4GGDaNC
 Dc0vZyxQjT7haGTNM9IO6sr4U9NUCZI2DXSYyj920pCslnX55YMjZSxOi
 W/gZy7xlSu5omQyqrtNCLLsCKuEZmMTIBcTANFEGasNn48shkMXOzQemx
 Ef7QRhxM0/v8eFxeeuSDQjUneG5IEjNzkwVKZAG/FbT/qgPspN/idrtHv
 j7/u+GXP/y6OgYE/gsO0bqQCkbOYMoXb+SWkhpcYyzpidpeOPz3JLnu5l
 98fDYLfNrmFzOzpuWkOOy7BqqQ0PQwJTFo/49O2d7y1neNqNFdeAmr8YE w==;
IronPort-SDR: SQ9MJIB1T5LE0vjFJDtiFt7BhgIUi8KfezjTnKMgCgfchMopYWp+XurFNaOmkvIWd/+EphafJw
 53YsjNOzzYXPja+2ZftROh/xgHoy5qP2nT0irsIyFqGqZ5VKB4E75xCNhzx22VHAD0fOpMqPux
 ZiVpkS1MvM+2TwEs1Sux6TWt8TiYX28iJaJ6vId1QVf6BQgDjpJ5VOCywZXWefKjy0ZjJSvY14
 gmB16FGaeXOrRUYGZMGlEFxEmNUyj1M10Brwr7sV6lpGBcY+S3Mav2uz3W7iZkytkO2VYPYbSk
 nts=
X-IronPort-AV: E=Sophos;i="5.72,341,1580745600"; d="scan'208";a="138828441"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
 by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2020 04:10:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMERNRXeFbJWu6+eUnwMc/WvA9lriQw2T7PD7S2uRfz/OI2jYwVcOUCkjcrQIkyiZsILQat83yjdZwsLD4TY3ORF4QGMEj5O+IdsA3DFv8LjKqgtnYw/MuBvmtgG5VuFPPpJZFAjasqsUY1u2zayhFz5ddXWEK45NjAkDuCLcDcOIsP424T88N5uR4B7+8lQ8T1c7ZSidVexLAyI9PgL6+oh9+en/dkn0TTluLxlRceJRjxoC+4y3Z0Dg9pkT3jjKZHOV80EWZDFj5i6Eh+Ic+14pCbBAXT3Fjc5D+pr7onSy7cZ4z3vRRbJADk7EMwfXGHSg3Oo2MLLv4eTVjQU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+61oNwT2wSFU9lVBy7bwQLRyVzzerT9NxzgoZnNb+U=;
 b=T6DXPMStQdOGfTrQZalCHO9xM+oXw1Qqe1zsADFn7Oymq8635ZFcZmFmUC4aYah9iXMF04s84+ZdUVeozpMZsvx4a+4tZVouQISF1aLMa0HF3qAw4onY9/vHhnRKXqm97Z4or3vTyMobsUQ7HxqQvvs5VlNvrPRN4XVVCy77FvJqtq9W+YF7IkVLYjLvnLobv6bT9cjcqNVqXFBxEjqNUk4qL0bkCM8vJPvw21Qho4f8J+j5zc+YW42a6zdYbLsHLN4itB8mSRUpOZc3B9gVd6tZ+adYU6aSYypfAzmIivEioTymVH9TrWXgwDY8B7U6iPk0snB+h4X80gHtgILr8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+61oNwT2wSFU9lVBy7bwQLRyVzzerT9NxzgoZnNb+U=;
 b=mhBXRFdE1rNyhHMS5LijsM51gvAq9F5NRFKy3XDFQJFevOd66lJcrcNX1wfqxtRNaXKUo5doy7DL2abDMBFZEK1C9vHK0q5DswRQiyrDhdHgJ/DMtU4Q+ROSNAQUQQo6FpqoYg711Jo/pKzLBqmNaerxgtZp46JfhUG8+Nf9DXs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3877.namprd04.prod.outlook.com (2603:10b6:a02:ac::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Fri, 3 Apr
 2020 20:10:32 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 20:10:32 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: provide num dword helper
Thread-Topic: [PATCH] nvme: provide num dword helper
Thread-Index: AQHWCdRVNnbg7JFCwE2X9vzEoZ2ydQ==
Date: Fri, 3 Apr 2020 20:10:32 +0000
Message-ID: <BYAPR04MB49659FDD671855FF9A66025586C70@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200403162401.1323982-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3bf9d1f5-be63-4746-dfe2-08d7d80b1083
x-ms-traffictypediagnostic: BYAPR04MB3877:
x-microsoft-antispam-prvs: <BYAPR04MB38770D8714EE42FECBB4B65986C70@BYAPR04MB3877.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:224;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(8676002)(6506007)(76116006)(53546011)(110136005)(81166006)(55016002)(9686003)(7696005)(8936002)(5660300002)(558084003)(33656002)(26005)(86362001)(316002)(81156014)(71200400001)(64756008)(2906002)(52536014)(66946007)(478600001)(66476007)(66556008)(186003)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BcLYPCg9r+fj+BzP5sXORrj8kBnA7oOMx+PxJDYtL82GgZD71S0jeTFIEQJxZyhzNagjWWNu8GxpWL01WhDWga99Evc/czVQedPhg+Cugc2DssPi10jZ7ewEsKkb6wTysJI+u5tbimsLSlScvl+wJuLGsAbv3N1lYvTDtCqBrtPBNuY2HTGum6st+YBC3SdeFl49LYL6Ulqz3peKInAE0T8vFn/817MOlfzWeqT4auwc1emi6JQd7HkPakAK92H8G/mAzI4UFLuvDN4qiRbouciF145qOwPo1FqutpvReYQraBaCJpkabIVXKWW7MDBfyeKCo1t7t6Qsx23YN2iyGRhLgd0+zKxplIjS0zjaQ0PqTTCY8lX3b1Rbnhu93bHAUNjcrmaMFgeZQ1T+sxJiW5P/Gj9eRnX/JLQWVgULu859HGSrBdTjpaXBl/LW+Go1
x-ms-exchange-antispam-messagedata: mKGbbL3TP+9k5uL9maXgZ1UmVuYUYDyDPTuqkSCL3C6qOb8kdZ7iH9y0tt8ffBHBfzfnansUmUySY7jdPKrFEM2Q3j6nM2trKGZCo92tfZd7s0BYJjytm727+k3/zzkS35MnDUbgnl4aXDvIUfawrw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf9d1f5-be63-4746-dfe2-08d7d80b1083
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 20:10:32.8113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eaErwgPKpTEXkZ/EQ65F+snacb8D2TzTCLbCdHirtZA+RKlOMigWBeB9Mh6xzAnkBVIz/S32Q7B4Qa7yeHqBeEWhnoLWQkB5UjumcEQOGKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3877
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200403_131037_233225_5010093B 
X-CRM114-Status: UNSURE (   7.34  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 04/03/2020 09:24 AM, Keith Busch wrote:
> Various nvme commands use a zeroes based number of dwords field. Create
> a helper function to convert byte lengths to this format.
>
> Signed-off-by: Keith Busch<kbusch@kernel.org>

Nice cleanup.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
