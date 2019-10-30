Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0548CA9EC7
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 21:43:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B56F2067D
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 21:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="n54/OPxp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UxOYnFjL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="HAZQRDHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B56F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=rNJx5XZfJkwJcTgYgWml65omfpQY6faHFDkMfyNyZOA=; b=n54/OPxp3dvW/G
	2UArkXqnUzrAoBtiWz2gqx4P9y8j+2dDzlyw96NtLFMo3Sp+R/UUnZUrIccEHT9rNAUOLzVoMNrG0
	x8eTYCOz/ZshfXHQfs6imvxphsRHbm+fPc9ObbUXQM+uOD91aR4ZJGQ9/6ldafUnZdcNJYwaHcQSx
	y0b0gQ7NCk5W57TSBSDuCl96UP3AOv6dhQhZJHZpx78rIiVMgM1RyoZdDCTxva3+9t/1qH5zOhiks
	qJolLz6r1W7YlnxB42mbyAG1gBAvy3eX+FKbAyueSkhv7H42E2j5BludwgIFLetgnsFIMtgdzP3/d
	s6R8DKhJCv1GF555C5Lg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPvka-00028N-IP; Wed, 30 Oct 2019 21:43:32 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPvkX-00027r-VQ
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 21:43:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572471810; x=1604007810;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=5BMo3y89mX3MZHY/7zin327GJjmtAQrYlXjKsVAF5i8=;
 b=UxOYnFjLXSwld0o9XyjbdArWzYRbpjqk5/hcSJivhcs4qwL/ixiSim7f
 qjoPom2D+lit7+7HMVIWgCD/ZGRHM6vBQSXpUJ9DjSc1ZFPB/uB8o7Tcm
 8IfZxe+UCW4qvZGJEjP/4QRc9E42YmMUuXp+f1HO44b/CJbnIH19P5wZ9
 YkJI2DxgdeOyBtLEdghfOXcRiVcTI4arMYdY+3MsishYi4+Y6fzaab2Jz
 uEsNBgCcLYvHbnE7H2xkRhhy/22qWhymAk10EyUFoa+wLa2U7DbzNYLnz
 xsXC0K70BDB2NiHzvNzyxCL8btBXl3/TBDwV+dUcyZE31jIzZEkUpgz46 Q==;
IronPort-SDR: 88vZXzdHj14mybnRu27VYGL4HGwG7Wo9gp5vZXpN8gGnzeMMHYhNijohFCk1t/Qr33U4pvONJ7
 K+tqi6f8hqRKHA9sy7W1uqG2XqGCc+RMGML9Lk9i9xoJGV5SXbNNjRoILyCo8WZETmHkisgIJP
 Bi5Ecy45mWTXRrwPZy8FU4AFOckthbRyRLmPeoCjlZYCex2FviES/Vy15ZD0SbQzY8sWA9wh6w
 9nxjcLU+S0qrmGsLUP5cZx6yvP7OvTXWuy4fWuPX7OWWQzFdaN1v8OFHTsQFd2NbDjoPSgBRwV
 UOc=
X-IronPort-AV: E=Sophos;i="5.68,248,1569254400"; d="scan'208";a="126152060"
Received: from mail-sn1nam04lp2052.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.52])
 by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2019 05:43:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnEsT/kLy90VWhq1egz5cMUH4c2SxoYHV09a4Ih0JIiic52jo2eTVyjgExxtXf1n/D6hwZtKSRzX89t+pOnwGRbD6q3+mUgbnxT0PPdVtkRWX8zJJjvhC6NYv50RqCBZr5KGGfvHxAiI6EjmEgG6SSCicKNq5RhWNlsKSvqD+0zM5vQFaEN3+Q1p3ooBKS8dpSr68wk1YNG+BMHHzSNtrT5quo7YNE9W/X38/9cd9eZkat5vY1Xz83xI7wpk3J2m8bTh4BW6CX3Q6cbuc2vW6x+Seyi1az7QD+niOYrJgYd/lkf/g5erG8pNTD/TL8+4nVHW1Sef/6gT+hWSvIWH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BMo3y89mX3MZHY/7zin327GJjmtAQrYlXjKsVAF5i8=;
 b=i+yy3XWsqOto5xEiXYyo9GEQMe6lf4RIOLYXAmYfD7/NM7Y2uy7apoZ2MDECx4aPka5vH4D1bnv8SXv1ux/hZju0V6F/DOiS7tiU6Me6gUZ5vxuBRg0/GvLWk7Mdmlr114mEGa2vcKA7Pt2EqQXwv/gBZC/bx16SwcPC9ZxtlHDFyYbygGRz79X0mLw75NKd0srbTRc2ssWWfpwDbkI0agwmPFnN4kxooB8snlGR/TBA2AS7tnfrZbeX/vEUMaI7yp3yDF0CjHQHkuE+4jdFmV8rlljiPwOtJtMs7v5LcaeafR62cLK1+g6wLUUrJBTyyL3zK6dNKi16HGld5gpE7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BMo3y89mX3MZHY/7zin327GJjmtAQrYlXjKsVAF5i8=;
 b=HAZQRDHjrrtSKg2ew3XwwmQMeAr1HYkdmAZbL38pRe+7FaOXd+ZCgqhDJyXsjRrbVVEbTUUgtq3xPXcSPrdbekeJCbE2GyrtFRM0oLJEUlJgWhIuupjW+Wfde9TOpctSuF2Ryx93Qjbznthm6M7JPpZAdQJoF//jY3Gps2ND0/8=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4023.namprd04.prod.outlook.com (52.135.215.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.17; Wed, 30 Oct 2019 21:43:24 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7%6]) with mapi id 15.20.2387.028; Wed, 30 Oct 2019
 21:43:24 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Mark Ruijter <MRuijter@onestopsystems.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: make ctrl model configurable
Thread-Topic: [PATCH] nvmet: make ctrl model configurable
Thread-Index: AQHVj1sXWigCUD3+A0uHtVCbsaOdWQ==
Date: Wed, 30 Oct 2019 21:43:23 +0000
Message-ID: <BYAPR04MB57490404FB7E6377E107122386600@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191030194858.30788-1-chaitanya.kulkarni@wdc.com>
 <8B7B7A7F-2519-4BF3-A3BB-4CA758B598DC@onestopsystems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5643ec0-3e87-49b5-b643-08d75d8230ae
x-ms-traffictypediagnostic: BYAPR04MB4023:
x-microsoft-antispam-prvs: <BYAPR04MB4023756136045F31105E0E9886600@BYAPR04MB4023.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(199004)(64756008)(76116006)(66446008)(7736002)(256004)(6116002)(3846002)(52536014)(6436002)(19618925003)(74316002)(486006)(186003)(5660300002)(476003)(6246003)(558084003)(229853002)(305945005)(9686003)(55016002)(446003)(66476007)(66946007)(66556008)(25786009)(7696005)(76176011)(81166006)(81156014)(102836004)(6506007)(110136005)(8936002)(478600001)(14454004)(26005)(4270600006)(316002)(33656002)(2501003)(2906002)(86362001)(71200400001)(71190400001)(66066001)(8676002)(99286004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4023;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Se/y1LQFB78pZ0i6ZBBzhkswq/Q/2E1QCu5dRKV139IftSl/ZaaNTKxCf/88S2enTxMZR/hYqMQBFW0fqI1Mee80AEMYxAxGZWgsgeFX7lnFT8L5BLt7DDQXh4C2lykb/O8reh/Gry/xsAnRcNJsfETCOKa4nqhETLXmM5Sjv+ePrxsY2V6gSHRZEDjcSjXKGgY7x8wF7fOTdg/aQ755m4VSAdCwDYsah7CMS3ZpM15Vae7G2O2sNAxcd99bbYeGb5X9fb0YprlxBW2/K65Ror4W9JPVyn/IHZteeeChyrjrjp+X+2jEOlodTbZ0MktOp2H40W2f9F1+URvS29OmxL4aXxDu13MMZ2bWVG6pGyBFI1QBAdiQ50S+Jb2uCUfcMx315GCN8VpuVFc9ScQm1Oa55dHQWe9eT20zQiaVMuWyA2UGsFwW9HSUNYzUo9m
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5643ec0-3e87-49b5-b643-08d75d8230ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 21:43:23.8293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: baqvXfHzqpiu2SzYZyAh1c1JjyccnPcqOmm0iiuaD35KoZFcSzV/j5coW9ZexzNUd69438LC2cB2nKOA6iXq+uqG4fQAxYGV+5QzCWXPbE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4023
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191030_144330_071727_DF005D6F 
X-CRM114-Status: UNSURE (   6.66  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I'll merge these two patches and send a new one.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
