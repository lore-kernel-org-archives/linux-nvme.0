Return-Path: <SRS0=HRbs=ZT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F967C432C0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 06:13:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFCDC206F0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2019 06:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jg4eYqSB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ICvQ5BHG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OhuODXrX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCDC206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=d+FZlFmUhX9VWtCvwWEDMb2dmdiUmNb0Sge5edSNIAE=; b=jg4eYqSBwkvRFX
	10D+shXtPk9QVnmuItzEdWH1u9eH7euM+AkwQIA+KZZpzfWEf5r7lfTvMNt97Bs30Cjs2+yTP/JOX
	cbW2PbwaB/TgDPNIEWtBozOPHG4+fbFK7LZ4Km1OGYnwA3bilpgy44YUwEnjYg9rLnunm2yv2THZb
	K6CcTwfC8gI+vNDYjcREqJ3YZI3/7gtXswmHs2vgShKAMelFVxikfnLIf2nBZqJVyPpxmpQE967uy
	4SlqKMQ/B2bLGqHYW1dsLUI8gplJF+VE6ASInxzE/aimzYqh7Y0nbryfdc5+KJcN95tYQDWgm6/TE
	iZCYNNhTXTY7Ue/STyeg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZqZh-0001Jj-DR; Wed, 27 Nov 2019 06:13:17 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZqZe-0001It-L8
 for linux-nvme@lists.infradead.org; Wed, 27 Nov 2019 06:13:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1574835195; x=1606371195;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=i5/3Lp9PnYtKs6dSBsMoNlPiWtUzdpAQUjQFmcM5IO4=;
 b=ICvQ5BHG5RlEIIjtHBHyeBEZx2PBYRiAC6hGIMuY49sQ48e/fMpCGEup
 mtTOt0oS3sSaRY7HBlQK4OHtqlkxtc1+vPHfCtQCZEM+UeDotbMg9Rllp
 VW0Nzyd5abw83sPDK3x1RGUufNC5qIYwpBmFD4qGhBAuM9YUrHP5exEts
 gRhTIgRYbF550omcUr2hOcdlpw85j1bqNh+OiEyOuGXyWZpthtEIaBPr9
 jsXmHrZL4lHvI6MI2yZg3VKF000vXfEOOY0pmPhHu21w4swmtMC1GgjlM
 l+U1P42a4ui09HZVkIl/Fz2+HfIODdOvNiUT3C/SfNDSeW4KIe8tEnhmS w==;
IronPort-SDR: /muAJc/gJHWRJYeJdHD4MI2hSeUrbjQ/j542gnX/AyaNBz6OO8DpaJ50uCFAQvrd9mPTZvQ9AD
 I07WFoZm7vsx/KYjKcWZvOMRBL9cxzEZpdn743FHZ95ZCGj2WnlR+P909U0Z1NHY50zNtZTkIl
 rqDaGPWU0tCQvAUNEeXbwG+/vk3t5pipMhPJ1rCG0zCDk5t/kGO1Fcc++q46c0+6ODmfsJ1dmG
 gWfZiqKvBV/wlalZ6EvOI0TKpJfl07kOqCDa1z/DC9UaBiqHSY+Qr3lnERgmaXJEAPTJSIOAEW
 VBE=
X-IronPort-AV: E=Sophos;i="5.69,248,1571673600"; d="scan'208";a="124859204"
Received: from mail-dm3nam03lp2057.outbound.protection.outlook.com (HELO
 NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.57])
 by ob1.hgst.iphmx.com with ESMTP; 27 Nov 2019 14:13:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZjm7e9TpVhS2PGMd+1nPJ9u1LIFjWxkCzdqsGT09Bs7TY0wjz1xGMPDxreRoh4pNi1wDA7qomOEXmCO0/gfBWvrGW7VXUfIVXB6sqinEHKgTF6kyqFeAVX9aAjhrqunFDZ4ZqMQ7EEbO1ChQDEq1/X4R1fHubTomvZD8H1AymVnx0chLXJEsfpi2sDjVIT4JvZCqq5mYBEi6EC0aR8VmpXaRbYZx/s4JQaj1hIIA0zfCloLCMrbUJqs6/ahwWmynrQYdyMULFFwyA5gpBWDgVWGXoQmrZThFSRQtNjW+LPOo6JaovwmIt3I6M55CB1VhJJ5bcB+6LuEuSb4VWwfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpCFtI2Dku6y2FQ+aJorORZAKky5Kh6GYz3quHv82PU=;
 b=dMW6gTPa4Bw/DbSZEe34CkvCmlPfYmTk/3do5945c+KP+/LhGa8bGUpE8F1beXq+Z0ZW08AmVgn4g90mdKfh5UoK/m3BIgn0VgV3w7wANozxwR4hc5rTg/6w+XWh5BdpQ9Dm5vJKA4nl56yaHW20jB6VPZ7vwzTk8/1/mfCUk+O3jAikNnCbCxXh2Zon6yT32+W21TebS/WRy1WNcu1c/Vb0TE67XTXqL5YtaPmrqOLUZbQO0EvwLc+btKEbrVve5AYksNWzRpG2NHcewctEHdpvKWgjAk88AxB9K1us/f4dk1WlkHFNfR/1LK37szHJhbxRW8y7AyaJf7KQ/sh8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpCFtI2Dku6y2FQ+aJorORZAKky5Kh6GYz3quHv82PU=;
 b=OhuODXrXcIRwZmichwXbuQnq5116U4MF9O/fM6h+JKQpH9WGygnUNpRcOA2hMBzjiJQuxCZ58Yta5BSP/oUOoCeEoQ4spombg2egEweMcmR/LVGlOqJ9a3DZQIiuv91KYX1bxL68B6r/2GqBx42lCKn2d5E5SbJP7t2SFaiGarc=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4774.namprd04.prod.outlook.com (52.135.237.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Wed, 27 Nov 2019 06:13:11 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2495.014; Wed, 27 Nov 2019
 06:13:11 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] nvmet: check sscanf value for subsys serial attr
Thread-Topic: [PATCH] nvmet: check sscanf value for subsys serial attr
Thread-Index: AQHVoKqzg+Zm9Pe/tEGZgS5EbE5Rfw==
Date: Wed, 27 Nov 2019 06:13:11 +0000
Message-ID: <BYAPR04MB57493EB7C243759A688F985B86440@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191121203142.537-1-chaitanya.kulkarni@wdc.com>
 <20191126165011.GC10487@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6403280f-fffb-4a02-2c05-08d77300e16f
x-ms-traffictypediagnostic: BYAPR04MB4774:
x-microsoft-antispam-prvs: <BYAPR04MB47740F858CCB4EE7F281F88986440@BYAPR04MB4774.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(199004)(189003)(71190400001)(478600001)(14454004)(66446008)(446003)(99286004)(6916009)(86362001)(66066001)(316002)(33656002)(66476007)(8936002)(5660300002)(186003)(26005)(25786009)(7736002)(71200400001)(66946007)(81166006)(9686003)(74316002)(4326008)(66556008)(6116002)(8676002)(52536014)(76116006)(76176011)(6246003)(81156014)(14444005)(2906002)(6506007)(7696005)(102836004)(305945005)(229853002)(256004)(55016002)(6436002)(64756008)(558084003)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4774;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bm0OZLonA94lo4GbRXnYZE5g3Bf94uQ4wCKNZiZq9yVamGagXkPmUWG9PSLimM0EOzkRTEj5orptgsMBU43vYwuaD64UGBLLyrUYlzPyBVi1RAlCfwt2FwN84zw7UpdCUgqgr5KCZWyK0AOS3y+z7ZXrE4HVPe0WQuqwufNLo2cdeT1bKwMGtnqcScDPVPy/4nn+Yqm10lBbyaa+7R+NVg+84mttufpzphuIz8ZOcyr48fL5SLYihThVGKMMoput9nWMDkHpAfIVu3dvFnffZ2+0DUjGCNNcV420fbcHULLN88fk72yZB6jU7wlDyqqPCYYMN6S7pVhrcydTQstWh3zwRzxp6Tcwhq9erjMTG4Om3EX8NzBLTCYShzw7XZV0O/UYELvZNXXRyAOYS67TPE1x5CxJUyUgH+QANQIxnChZEu4alDaUSEQi7MPmRuh6
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6403280f-fffb-4a02-2c05-08d77300e16f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 06:13:11.3669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nwt9bRrOjNWrV8lNz5EMcOyIuw+T9jfbjdtSXZ/o58FfLM7YGZakh80b33fNg5eWF+yO/1U9f/rRijCzbiO/LOoMAa0XCKhVc2sbAxf1pAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4774
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191126_221314_851651_7ADE677D 
X-CRM114-Status: GOOD (  10.83  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> So the problem is that we've already possible corrupted subsys->serial
> when an error occurs.  So I think we need a local variable to sscan
> in, return an error if that fails and only if it succeeds take the lock
> and assign it to subsys->serial.
>
Okay, I'll send the V2.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
