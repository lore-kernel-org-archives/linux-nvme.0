Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C411C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 03:16:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB252073B
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 03:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E6vrc0dF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QGUWf9ah";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RwNEL6q1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB252073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Xnb0xcCMKItSPmo+QybNVZkd/rnUfpHUZaX/hUgrllY=; b=E6vrc0dFEv5A9vKsS3WEpDz6a
	dD0YI0Clku7eNbNUelcWBW/oRMQhc9pY4ETdXbrUc46toizD7b2fjAxDgrBjCnY1xX2zP8bcleLB9
	2bB6fFgEvob6g71FkbFc6zaF2lWD0pIdxJJz14lvJNGgc0cjGzGjwqBirx+6gxdLLNFr7spuBKr4a
	7CEBCTajF4dCAn/PTqBW7VYzw9mMsllKBFL0/HGna55QT2q2nhpkrRg12vgGfS6z1BkvsRISUsHi+
	Phfy0R2eTlR6A/59TBUADDN8Wbgc89lwckdk3WXvChN3NyX44y98jD/x6gYvdxumxm0OcbGhU7Pw4
	klMtrmMfA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3srq-00054j-Rw; Fri, 07 Aug 2020 03:16:26 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3sro-00053z-Oc
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 03:16:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596770185; x=1628306185;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=dTSQe2+Ej/Biz6iE7FCnqUWzWLf2P5z69L3UY+H4zf4=;
 b=QGUWf9ahkdGJiwPqtYapP/nkloQykYUmbO8Tjt1lBE10WhjUamxVXBlT
 EDftUroB1FMDc8REiMmx0DbovBAZOs5d2sFYT1mBMIM5fZDPDKbBnIFRi
 pjBb+ipae2Gmq0h9Pr1jar5fFclfzeD30ADIKlU/Eu2uVyVlLWSsg/KoW
 eKK6FbHqRP1GrvSg9qWDVJMN9kN85YnPJy8OHIDVcp5oaM3VNQ7Frkfmr
 Ta/nBhE6Vh7NDiGckjUc3ftQuB5P79A4fo7ApUoMNPfh3kFGqOztHV3WG
 YRapAolBOSsQWpTEHhRtwUkOb0JcMgEXGNjYo3vIV6waaGcuM38CtS71k w==;
IronPort-SDR: l7S8SNAwPIYljkG6n32G6W81BnUdNuL1XZam0T6cAF+ujo4Z71jt3jc7gQtpkd/WVnUfm+2suE
 jC7bXe7OyQWDTjus+oiSBBANj34/FI9tLia3o4/gpPbY0G2ahb7bnxLre93pbBdRayxtK2/CaD
 hrma5UzW7HpcT9rUOpcGFORVMHZT2e5bgzNjvTKYvF9wigbxjPEKYIhH3Ir3W83zDKxAyC95GC
 /6q6DV19eM0SUtStldyuxANP5O3qSyOWGaObNuAJ+hHs/Rxq5gI/uFeZPFxf+v96jEAoD/toKV
 y3o=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; d="scan'208";a="144420262"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO
 NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
 by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 11:16:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXkHEaRRu3QDcB915pZgOaZn4aqxEeS5tnhzm29T0GGLLGW2AKy5oIjuOlRPr0L0AFPpCwsqAetDa6Ryaiy1PSVJniG76XfANjqkzD10Qmv/97+5Pw76N07AcaeD0wN2ekzUDvwJqw6f1Ytt5f6/z4dPy74VnSG2HzbR645yrtdfBqsCtWkhCVAAre3UxM6bGhj4x7fnTxxWQxe4LW6Ms4kwLZhvFG5oQb0HmBXVNzh4e0z3zDiRGUOvStxfXgadsyHRnZPcjlqrZSTUAFibf/EFRUg2mxv5AwUFVKbO23GlxDUDoSqnAD6XmJX+0TdRr3KWCfYvJiEhnKQ60NpJrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny59ns9BiWtNuOxFqwReDNeiREiNYGG55TWvy2QdAIo=;
 b=din9irVq0z6VOqhaBrzSy6H6AZlwsyDn/vGFmCELy86eYdg1c6LLwHitJYlZM9jCp9FbxnN4P9kzUB12DgSwNNwcsHUJLjVlPUQADqINcVQOr9l6EyZz+AdRX7I8l7S6Et5nLgSTCwbaOgB5ag2YVNXsVOe8w5m8e1w10bttTmVo+evamTmzAhAP6sWd0UNeWexLP+ofY0EVY2Q6fd+CsX8J0XyWdYMKxBKQRP0bh63WiBsM5weonMG4KUeNunN5RUPWN8Inh6WjqYzkLfrN9+1vXU052v4pm1EDO8nYcFP7JX7YYZUoAF7Z9aCNIwPgUeqs7iAtlfxwVxLyGYqzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ny59ns9BiWtNuOxFqwReDNeiREiNYGG55TWvy2QdAIo=;
 b=RwNEL6q1N0GDyJDcvRroAuctCDPzCnAaGhocHkHdsoYReTu68Ian+rpDKDi2OzDHFeu8i+u8GlYOaz/GhODsL8D4WRjJb9w6exjVFT//GV92qO3uoF1RI0WaHi3hz7a3j4nJ4gIndTV5aKjc9A8vCECbzF9V9njc00hsOB0S1o8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4967.namprd04.prod.outlook.com (2603:10b6:a03:4f::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 03:16:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Fri, 7 Aug 2020
 03:16:22 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH v2 5/7] nvme: support nvme-tcp when runinng tests
Thread-Topic: [PATCH v2 5/7] nvme: support nvme-tcp when runinng tests
Thread-Index: AQHWbCXzMCiS9keU9U2ab5EhLdM5pQ==
Date: Fri, 7 Aug 2020 03:16:21 +0000
Message-ID: <BYAPR04MB496517FF9B9E262ACD555A2686490@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-6-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73c96b18-03a7-42a3-850c-08d83a804298
x-ms-traffictypediagnostic: BYAPR04MB4967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4967C1C3DD6C7167E09727F986490@BYAPR04MB4967.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pUAYru42Xn6OEhnHe04OuxGm8blNA8OaXE7GmmD2QQM+Is9L6WbK9/G7w9oifitYYh1tilxqqMML4KymgBv7oIv0K5YGPneKUsk8Dy8W/WkMDp2EiBpLD699+vcRxRFeLKJvQhPIN7VgWq4ULsboWFGgJsh/uXz3Toi5gfydMO3SCQPG77YAmvtcdboHieO/1O2JY69Aw0xFKyKycpqU2738Ea3nUvJHoqd7Vklcs/decDiJY2NBB8AcKwSVGUl281hdMDCdlN36EtPbXPcZitwmyudhh0x2OpG7CdDa6Xep/aunGbuf6dVCy6jYhkVt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(8936002)(316002)(52536014)(2906002)(66476007)(66556008)(64756008)(66946007)(76116006)(5660300002)(55016002)(66446008)(186003)(9686003)(8676002)(71200400001)(54906003)(110136005)(53546011)(26005)(33656002)(6506007)(7696005)(86362001)(558084003)(478600001)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Bh1GlJZhHtLbhrrTXvIV7eSAU2fxrbmNp9ABtrlIdTwGIX1G9/RPMmixc36svaHQOF+1ceO6lKxqLUQ/YFHi5/hhMkK7EfJADTaEpy2g2iNbn1RVFKiI/fcZaHut+2sbquVD9IazL79MW/ClMyany0uutGpOsGX+E45TC8YJqjjdIDYmlMJ9OwAcOKWViRuE3776yGcby0nEEozZP6XaBHZ7fTVgwDGSWgqIRQLOJxWe3LwIAyaarcn2Y8xcwi58qmPIq23EpCsZrTI2qMUeeyggJWY0hOYtTluGa1DCjSpXrvxxFShmRDqg9MkDRw/SlhyViIqcPHlv2GjNTvSseMe16L4nlOxvAwpNsek8Jjz9v1vVuchjg0TIJjTKF4jpCO3ktEdWii+yzDu08ntn489iUFmgPRo4R/W/rXu5DUXtQYa9p4KZ0KpNpQMIFRrHkZzzQLBNATGfok3FNlD6KvcFAgUTJ0F/jzsAUTiaIu4T/aXcp+3204NfigUZmLiixfirLFH+6CNWEHADjd+A5wegU/znNB1AWfSV4VaIBiKRdMXltCoIyG8doHCwy7q5YMIJb+oaTe/43JRXhMca99xouxGV9ATBToGcJ82J4S4qHwTegkHN4n+thLYfxJ39lbEXAXpxkQHiv1p5kggiGw==
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c96b18-03a7-42a3-850c-08d83a804298
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 03:16:21.8512 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Eu/+4DCI0kfmubA4DN0eL4wLWWjwPD/zrs42iM5O3X0T4FaFgoDEZUtwjAXllWS3GclpzB7npwElChNiK16woPrGuOlnapt+5Qr3G9wLhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4967
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_231624_973819_E509101E 
X-CRM114-Status: GOOD (  10.42  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/6/20 12:15, Sagi Grimberg wrote:
> +	tcp)
> +		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
> +		_have_configfs
> +		;;
>   	
Same as previous nvme-core nvmet configfs can use a helper.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
