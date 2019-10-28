Return-Path: <SRS0=TJkX=YV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD594CA9EA0
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 08:05:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D9C20862
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2019 08:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XdXgmNcx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A+yV3In8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="diDqkc8H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D9C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=7CFOP2lLjfgPouYFKB336u4t1wvcmsqulhhD/2x/CEg=; b=XdXgmNcxsRLhlT
	OsJt5AiDSMQ/j0dIAHOp7xwOA/cLu3mvjFtZeSu9WPXOIZrKUNztqfO1m8qbvzsOQmekbMU2qlEMZ
	rtJKLANmPL1reJNMHrlMqM01/RgEHtyj0vhqwXT0EhFnBtMXqMHRJ5b3cPA103nRNNCyKZQ5mYA6T
	jmCU4dTTkSBIQaqHKx4J1vgr8z9nQ5YNi5NIGWB67nxk8qG9KHBuGkjEAW+ufDg4Jj5dZ0XcsVYpp
	Z61OkUPo/2nd7V+QEGu+tOnnZg7ACA2+Bq+Ho+s2HBZc2hv9prW4tNbRDr9psgGd17NYhYKfCJMQ3
	h/ukRo0JOFfBM6BM8xYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iP01Q-0008Ti-2g; Mon, 28 Oct 2019 08:05:04 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iP01N-0008Gd-Mn
 for linux-nvme@lists.infradead.org; Mon, 28 Oct 2019 08:05:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1572249901; x=1603785901;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=6ZVP2BqfR7gsdEVPut4ZSbRXFZB0tL92pG7MIfQeOHY=;
 b=A+yV3In8p+RZm7S6+YL7RdU81vDxWHWA9DnDeDhVRvc6thV7WJx5u8Sg
 IqWdP/VEO90iM0mognLL4oJBCdMiAqw6/maj4MbCRIwozHGxSlPAuNiu/
 HnWLKSjuFMTeauu9B1UPRM9/fj5Sj71JIuJ+uTokicDIMyK8/JjHHszMb
 NOjhUvEw8VoAt1nRGHiSZR4beIt/JcMhT+c6J2PFUyRj8JPnkcY27OrCT
 lkGr1YMPun8RlzOuhxOgjq4npMQYfxDIzqVPILsYwVCi1t2O2Kvn97Ryf
 IO+B5iX5kX62clWBaa7uMCwR9KrjOHiaY60K+i3go0rXRPN3bvLUG6RCl A==;
IronPort-SDR: 0Pp5U2ILHuMNvA0YOveC41xfD5xU4AjUReiOQ3LkLcYaBCYCQcFPG4o1yb4XUm2fajmEl2eERn
 xaUE6jkBy6drkEh1HhXyNaZ4wOIDIPf2+6xN4R+Mj0ZfLMV93Otckmxz7kfS4gKOXKjHGYjGyi
 SFZRgXxiqrdFwdKLHH9WXHDi51y4r/yr2oQrSOUf0Tr4Dn03ILd+54B3/3osTtgTh+LXWHDlYv
 GKoHek0i44O6CidNXIwJNXmH8NGzY6pfYpXTH9m+ZCplUY6UHS3teDjsDa9CAp8fp3+YWjeqF/
 T6U=
X-IronPort-AV: E=Sophos;i="5.68,239,1569254400"; d="scan'208";a="121474213"
Received: from mail-co1nam03lp2053.outbound.protection.outlook.com (HELO
 NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.53])
 by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2019 16:04:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWZ2T2CnodghOmrUCNBntmDgOsHqX9iTBpZa36Uh9BEivAVHPwExZZ0CwA090U9aVrrC1eqkDOVJtrOCPFXmYS2VTDEyRGBtAhH5TKMaJ9QAAHZMpaoC/xRHL5fimx/0kyz1sZf9Y3mqxlthAHv9wRptyv52AnaqDqEcI7mhNOkLucAocXShl4bjc6UMVahA3LyT+SXTUYy/x2thvZndN67YBtZV5vFIWD58Qu0fLsqsI6TrBK1SaPUdfOufNc5Z/g+ak9kn7a4fg0bP7z+wwq9TR6vG2+kAgkpRQeid2ICcLnwpyRJPSnQMgP4DvjSOl0CRVB7gZWolnhjuNDUlQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52MTL6LPZi9UkbmM5ER965kcZ3vHtO2Ukg9WMpTj1mU=;
 b=etkiueBBKZoqKa9R++UMMQBeAoc0ys7E7Vx7/W8nGVeDC/oqu3u+6/uQ7hmd99NMNkzFjx+dvsAiO2sQ1IpCVEBJRIbeeKku5FASB9cO2Yp1q0vzlFUqzPPq2Mzq5aScZitMI4rl1tPZB50E9IGdsbBjbvpMz6eMr7G/iLBfHLV3uoldU6SfqU0E8oH5/tQmqGvet199bMZzUD5CO9tL3QzlgT+644qWUOl2V9XHamA4okMx6d/NsiunofO6j/jQh26gSWymOjHWZZlSzcxds/iYmr5Pv83oimfqOXko04QKNc01enTyEroTnIl5WrPiR7Qc58bOF01R44XTb5IpDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52MTL6LPZi9UkbmM5ER965kcZ3vHtO2Ukg9WMpTj1mU=;
 b=diDqkc8HIKB+3e8+DH4irbQVvXg2HZBb/x3h7yjBo4wTB0uL1cHKyOwc5oKstLVVfhFkEkneEhfUUqP0VNZ4xLw6Bc1PVHhb5kx5qIqmr7tlLaSt7SBR9LYDhh/BK8YpVZBVLykgguXNd6ez2okW4JzcBEj0kGccYnWQXvSpwBo=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4088.namprd04.prod.outlook.com (52.135.215.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Mon, 28 Oct 2019 08:04:55 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::34a1:afd2:e5c1:77c7%6]) with mapi id 15.20.2387.023; Mon, 28 Oct 2019
 08:04:55 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvmet: introduce use_vfs ns-attr
Thread-Topic: [PATCH] nvmet: introduce use_vfs ns-attr
Thread-Index: AQHVid7kgFRDrsrFkkeJqDNfcuN3xQ==
Date: Mon, 28 Oct 2019 08:04:55 +0000
Message-ID: <BYAPR04MB574931CCA16C8E4A96FEA26C86660@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191024020003.GA2148@redsun51.ssa.fujisawa.hgst.com>
 <FA6B6A9F-649B-4B58-99D0-2D09076E2482@onestopsystems.com>
 <20191025040540.GA19941@redsun51.ssa.fujisawa.hgst.com>
 <20191025042658.GB19941@redsun51.ssa.fujisawa.hgst.com>
 <109617B2-CC73-4CDE-B97A-FDDB12CD22BD@onestopsystems.com>
 <20191027150330.GA5843@lst.de>
 <20191028005517.GA6693@redsun51.ssa.fujisawa.hgst.com>
 <BYAPR04MB57491F5ED34EEE047D86C2D186660@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20191028073545.GA20427@lst.de>
 <BYAPR04MB5749A6D339572EFC0C9C401686660@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20191028074300.GA20523@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02942c08-c314-4afd-a530-08d75b7d84b7
x-ms-traffictypediagnostic: BYAPR04MB4088:
x-microsoft-antispam-prvs: <BYAPR04MB4088ECEAC73716579E05407E86660@BYAPR04MB4088.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:370;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(189003)(199004)(256004)(186003)(3846002)(9686003)(4326008)(476003)(6116002)(2351001)(6916009)(14454004)(86362001)(76176011)(446003)(55016002)(558084003)(5640700003)(8676002)(7696005)(6436002)(74316002)(229853002)(7736002)(305945005)(486006)(66066001)(6246003)(81166006)(8936002)(102836004)(1730700003)(81156014)(2501003)(54906003)(316002)(25786009)(52536014)(26005)(64756008)(66556008)(66446008)(66476007)(66946007)(71190400001)(76116006)(6506007)(5660300002)(53546011)(71200400001)(478600001)(99286004)(33656002)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4088;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 87JBCoRjZ5H+sn9alQwm4ck+AHZ9Lr+5OUhOENkYoARn1a7VomxKHUvYfw0IWOV2MJLaOWvj+8bzr60BzUQrkqbyB42VeGur470bAP2GXKrBOXc7YaP1Y1Qt0zs2W3d14K4BbYR9w3fGpOHg0WkEbuwauzVZNWD44IJoElvv7wIty3oyg+Xzf43/snJW2LbCRirAHKf9O9BOGSvk3eAsB7pWzsOS+78wPgtx+zjgNE5Cl2UhgL8xjG3Lft1TBf3CT+Dt1Zd5rX7t6qeyG5hp6TdEV6Vk5Fc1hzaVP3yCrzTEwZYRFN1IUlQ5VGWv0sj30/Zil7bADNX3xAIkb7a7EYhdqbykjndkITybeR8LrcziDobChgTeaZmPmSdTuFI6FZdexqC+w4h0RyUCMlMis81nVm4c1MmnfWWD1glzwnd9OLnpctgy6sa33fKSnanm
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02942c08-c314-4afd-a530-08d75b7d84b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 08:04:55.0622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4zSjVdGZ7pkvH1xOlHlihdI2g6jU5tBn9m56W2WxI2ehZdyn1l/3UEHA8tfxMEQY2bmt6mGwettkRT8RHNz8JIEJP3BVwGy6IlKZFMDKXnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191028_010501_789446_BB4AE49B 
X-CRM114-Status: UNSURE (   7.07  )
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
Cc: Keith Busch <kbusch@kernel.org>, Mark Ruijter <MRuijter@onestopsystems.com>,
 Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/28/19 12:43 AM, hch@lst.de wrote:
> Fine me me.  Or take the authorship for you, after all you changed 2
> line a 3 line patch;-)
> 

;), thanks Christoph.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
