Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252ABC4363D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:44:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977782087E
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ciEXQjCm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FWVugNLq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RuplAx7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977782087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=qs9IRLZGNsb470r5JYffrAPwIVtB4bFk4WPb7a6Wxrw=; b=ciEXQjCm2UEmrk4rfQKd5DyWJ
	CdeiVqsXqNWnWVQSlnOGSiLcxU1IS6dUul9XlGahuaPe3QxVETzd/SFaeyyJ0A0mGHGJH7kPSXlyQ
	KsrkzITEfByCI11U2wws8cHMvAXAgWXLHm4fsB66XZYFq2X9rZ/d7r1MNaD1tJGrgyHPT/VywkefP
	6Lx6PFHm7eyQq7PNPZDIonDlRnueHdUE1sIUjiirVHQFRMkdW309ypp/3YFIS89CpLnjVSHLMY4cj
	ri7oLWc+J1Tt1uaXUJeaXa4DA4OwecPIF0CPWJlIxfsAusEItdJ+TT0LZTRsc9vCIO9pqMOt2PsRj
	okBOk6+Ow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPwd8-00087b-TV; Tue, 06 Oct 2020 23:44:26 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPwd6-000872-5f
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 23:44:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602027864; x=1633563864;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=azUc6zCPKUxBs7wESsBO0mvUWsHfExYQvwdbnS0+dts=;
 b=FWVugNLq5c5l+lc/Q6vOL0o/rbjITx0R1x1LH4pc5Z4/LpnhgLCexmgJ
 gHpTGIXUN5tBbfkXPI+BbNkBGO2Eub+t3M+9Xq0DTMBuPyU5dw3Ayruon
 LoD1BgCNwDEihLVjxj6Zeskerq3088MYehlbfGCYWRjN4UOqpso19pMd4
 X42hXzG394p73CTa6CTvsDBnCZou/XSGXzkWfpwgOFvK4WT3t0YpOolGO
 WlxroH/8PR17a2w6SxYqoJeKvmR2pAPMUbVk4a9nvniPDgjwkUla6pwPq
 U7PJUaYo0KjKPphK1vSd1SOoSm5sMeKZNUA+TFcaFZ/ibAI1EbH7wTirH A==;
IronPort-SDR: gJqeKioDrCC+Xz76fLNpo8ajiVzjv9D0CKSmjLpGEPS2494IOlnLRnvIvTWS2ezUghRgJTtryL
 YrADVDc8l0zvoXvSVaSBVvtFAYSn5gC0CYQ3dTEKwj9AM0QbnnpLT5qqqFVEmXhjwLiJ26sP53
 p3c6WRgsL3aIWQW5EHGn0GcD6Xo1qdEU1W4rwXbfDCrliV4fELe8anOSYl3WGIqbNfJpGj81VC
 ljC8JLiBqenMbOX0/MxLimTgMwBCGu5+FhHykCaWVbjFn4lAphapUk6Bo+0uNyBMas06oZSvo+
 Kac=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; d="scan'208";a="259009219"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
 by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 07:44:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdmOjYiGmVNSvAT2bZtLvU5mWdtsdkChvNVQJ3zoavNzdV5xJzmbLUwRZq79nyDH9aOUna0XsfiMRRfIZDtHEhsMmuwJd++c4AxDaLzgyvPJV9hv4amseC50JtuJxmDUC8VVevUQHlUzeA4OCXCgAZP7URtyqiolSMRoBQMIHw+SItd//MHMPQcsj1UayR515BY/a3QCctr/FWEZaXEvloodizyvVqxwFG8n4YYSyPZxOyefHmj13Wcdrs3HsNdxiWdw9eSWnZQ92/8ZRMB6BgxWWIeGzv/rVaw0YDQtXLMA1Tc7b4kk10mCC0y9R76A78ttcrPDWhjqw7Ssy6t56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlBoIPcJGSJCd7kntsajkKusjQcmLRECox1GtfrE4q0=;
 b=HakbkFxGfs8aKP1OBkMK0Qjy9s/I/yZN73BY8QeCFgGVsomvXmErTBwz+v09ioieQsRxIwxJyfrGk0XLRRitDztrls8LzK8HeqPonQRW30dV0qQiPDoCoXIr5lR8a44j1LaQ4Id09L3TRmi/EDBvx1qut8N7xU5lkkSBonLTFhaz252KhqA4jkdZKg/39j/0qMDukC3EIKp65cRUmkqyIomX9GoPb3OLlCd9rfXw8cEh7SoOr5QtMZO1C96Xv4xVwkfODVPmaaGaSBqhq4M1QvvsqtRvp+Wxsir2QPxgTwvboKFN2qAMzr4H0MZm4SeekmVQsOpFoGcbczO53ixUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlBoIPcJGSJCd7kntsajkKusjQcmLRECox1GtfrE4q0=;
 b=RuplAx7+EQOVQkvEU0tc79vxUox1A0NkPKyHvoERYWiVgs4Un9mtOI2OuqAP7x6gahDIpLK6CJKCCNH5XyMsFJ7U0elZ+D8mnhRNDG5ci3s/xH08iQFDo7wygQo/HKEU61rgau1T2/5yfDV8qLz5IumlG5Ap8wqj8h7fpe1yr34=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4325.namprd04.prod.outlook.com (2603:10b6:a02:fe::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Tue, 6 Oct
 2020 23:44:21 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::3974:3107:df66:7698%7]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 23:44:21 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH blktests v2 02/11] common/xfs: Create common helper to
 check for XFS support
Thread-Topic: [PATCH blktests v2 02/11] common/xfs: Create common helper to
 check for XFS support
Thread-Index: AQHWl1sou8OL2CxeA0mV1a+SBBjD2A==
Date: Tue, 6 Oct 2020 23:44:20 +0000
Message-ID: <BYAPR04MB4965388F1D0E70EDCEDD57E2860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-3-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b2946aa9-cd3e-4279-2021-08d86a51bf8c
x-ms-traffictypediagnostic: BYAPR04MB4325:
x-microsoft-antispam-prvs: <BYAPR04MB4325204860729529A7DBAF1C860D0@BYAPR04MB4325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7xyCKWu1t+Zs4olYyDogqNJM7sB78FM3zzsTdPk+mJONKH/1o4QY1DFY8eDbXLWcnDqOecQNRBPdLYRVmLdstX78aU9RmOxYdvb5IYZqg+G9kRBm9/1XGFOvfcsdR8+94typE+XHnsHig7kCVS0awBolfKBC0okZh2FVtvtR8/369yjw7tV7448gtYE1eHhzR/ei2Yr8VumJOZKBM9rev9x1UjDrkgPul3SvQtYofcAUe7GSd/tX24ej91hbjcyGQ4IiEEEuokO69o2pww73yuABgTTUdG9Z31hPL9G1LOpsSutFRpS3aATx/nwqEHME
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(66446008)(2906002)(66476007)(66946007)(64756008)(66556008)(76116006)(8676002)(6506007)(53546011)(186003)(26005)(558084003)(498600001)(7696005)(52536014)(4326008)(54906003)(8936002)(110136005)(5660300002)(55016002)(9686003)(33656002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: OeUB8vQwtUf+7UtUnE5MuHCjrtfGccztnki6zJRxrx84TjOJa7j8OiK3Jq7I4hgZNn/uw9xK6/fxUssYxKDAX8NmD2fEAa3Gun3j3QUkRSLOSPyiUpq1bMHF13j9boMcYpjGAmN208gUpbO+ldXxSu+BrvuieXS490kSx8UnniBt9aJe/SF3pyR4Ddxq6Wx+z7j7/gkVvuvnQOic8iZyx8M2+BTGEtcsmZv348Sg0TgERKrSQsXmREiCf//hG7VMjTbfrKrb/itONeH65Rt97fckKlnQH0vOS70igM6kTFcKSDkQw6ME39JxA5FGgbfDXwlNH+ihpsetvykwb58RwuGpo5CvuYaF+DuNGSdphJhSUk/6ejf2TULKAk2Bgb/DpTeMuh+yc4W+sq/TLs0dKC4P6/XDxyu+bKw8yE3CrwQY6CpV5yNg3iRayCM4VcNXTzB5IoUJX5vPUt5WzlUGry9sGQjCytn7zRaTSM9HeUX2MmOufWA16Sa3j225hBtQAcUhuMBGt+IanVMkbRRHkD1i5v3uS8QYjSCDH/u6AZBC1m5sCUrSmaQFIh96M6rzO1VqxtqhcqkrmaKbctC+zp29n6qvYscRqqEP+UgR9sDSbJ1XNvMgAskv1euCLmcTm3gEFSP4H21W2+LzBAX89A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2946aa9-cd3e-4279-2021-08d86a51bf8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 23:44:20.9842 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MaTniBC/tTLy7RwpurfJrubVTcRfRJJCawNAUvMZTsPMSkv4Ds/5ppxJ1XcuiHcPzi23NFsgDVcxIHopeh9ODkMWYueVEvKV8FeArK2NdYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4325
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_194425_089610_7080A625 
X-CRM114-Status: GOOD (  10.45  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/30/20 11:54, Logan Gunthorpe wrote:
>  
>  requires() {
>  	_nvme_requires
> -	_have_program mkfs.xfs && _have_fio
> +	_have_xfs
> +	_have_fio
Can you make _have_xfs return true false ? so it can be used with && ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
