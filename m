Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B4EC43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 00:39:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E3DE2063A
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 00:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D6TI3UAV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q3z6zxOg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vFeDzp6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3DE2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=X0x6mtIgrNN1Zu9SLT0OJysOszO128kNX3WDWGERHy8=; b=D6TI3UAV/eUt07
	kowFVc1sq6c8Iw58purJJWmF4f3PDHkaGQDsj5ftuqDzVxn57NQfyBJ97U/h0DdLS/hjWIxmca8eI
	5d7q3h6FI6hNBnRIkRp626NM5cJHndyjPF1w8OIvwMah1nsVJF9e/CIsmie9pvgmd48gltcKPdofN
	7sJRGmGIaC2IQhqAhBqll6j2R3cmORj6t/1Rexar0ynbOlilSDnPEcOdyrN5H4EqEwONLlUq+rSyW
	jhoJeAsyunSlTuRpSMjoRZpqkY1kqmmdUtcTk6u/3ykPd0LMmc9LxyfKrIACW4t69tUfXYdoH1rOV
	6mvZQQKwdgOgKUvetn2g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJntL-0006Zh-TZ; Thu, 02 Apr 2020 00:39:31 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJntI-0006ZI-HQ
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 00:39:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1585787969; x=1617323969;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=DnY1E/tp1uDYuGRdgTuILa9R4bdYY38uim4GCd82cEM=;
 b=q3z6zxOgwZoEbdin/Gk3qYb3PKKi3OpWqufFxmPn+g2auldDIjzWzGFo
 MSLliYvSg7GZbQKlFuHD2F0j8zhIcO9IJ8dIn61+z6TPlXw6NBzDrRheU
 9wo4TRYlzs8M3Csla7o+wSsz3VjrdpGjVq0SAOKVD2Qu9fZLIlV9Djdyh
 urAbLpIPiFGYJRuZ5fFn6RxDj+0jQabKW9idrG6uggwkFl0iOgj8/23cD
 WCaBIPOZxlZiPTSaSjzDgxyTXikvcNF6SVnprQOBIXBwKemqsXGOHOGEm
 WTjjnTxDHiP8Ya6EewbBVueVCYU6Nxf1j/iXfNeHjPq45qNbmbEDvzPG8 Q==;
IronPort-SDR: Q7H1olXV/QQ5xCVPiL0GBS0QAbx+5towaFBCDA2Usbnuz3IdFdlydwUdmFbMk5PBagidOsKbG+
 LQHb5wsUnm7KYiXFBmdKLAMARO9pBq8wi3i0mtLHEzKUpwGvk84br2x1Gcvj/RL+/jRhw2hPYJ
 f8MupHdsKYR+QRbV5TrO7dcE6OlYpdjj625UEH+327YDlExYXwtycPkX/QIpzTgJEeukBV91iK
 1fANpDMjd3pL7rmzKimBowEZyqQ04h+x1TlymZ84qBIz+IcJUEO+t0p2mLvEWj3Rwm5J0eNXaS
 yZY=
X-IronPort-AV: E=Sophos;i="5.72,333,1580745600"; d="scan'208";a="134684145"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
 by ob1.hgst.iphmx.com with ESMTP; 02 Apr 2020 08:39:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdgx5oj4K+UzqZIjaQf61or+S2+QR57JJEKaecicmErdBW2fwmJWRCg5QXsog+iT0YYZGZMVp9/ywWTNhN72JiIVMXjW+dbUBf4Zz9TAjYq7f9khOF3mPoM+XLuD2EyKZ73hVS+3OHtP9fotZqOOtSmqOx3G47sUbEWz5cuDWhU7Yl4TIjWxaB9UMfZ3oA0f6gdS6xBxgNkNPdop6TFgLedU16B5TF0kj5uBJo8weydfnbaoG0tJf1LPESEongr8oT0SJq0yM5g4UpDcMzpju7CWpIozbgtDGdWIeWQmCkusz4TvEduMDX4p7beUjpdo7cVfWddTFXv+lMjLtDIGQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnY1E/tp1uDYuGRdgTuILa9R4bdYY38uim4GCd82cEM=;
 b=RFQnrbKfmpmdzTlH4syfgH618y7GiG9darP+3YqQ/OlLedxEoiEr7ujH+K/rnIeRXRyANL22CdCecMcQZMsbHZMvR+NK9AC6lHvLBTql7qxVRb0F+P5++a5v9Nvil3DbLlQOXFFBF5fFTdOcdmS9KfT0U8yPZx7TjD8IpMAIMTM9hXu0uwY5EMbsh4GRQtBmCl9XqT1cU+wsnB3cyCv4YgXLNs7vUxHV7zzmiSdC66UlORlYMiUA/BkMM5IPmeJPyaYo+HzJlYBqZJTo4mlodT5hWersYZOgbsr2ETQRNyq7ujrbnFngPRGOTzROEPIoGMUFVtVTZy5fWruIJwBIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnY1E/tp1uDYuGRdgTuILa9R4bdYY38uim4GCd82cEM=;
 b=vFeDzp6/LxCZIOuDjNGHEdDlXUchkIjePhsWMZN5zuGGh8AdQTgQESMn+cFHP70msYiXU32KFzfIZDaCuCQ8pyY5Ai6YGaAW/fOaUQu+AQOET8aYiPUJ8edb5dCCa+HuSAd8Zqne3MKCB8X1sj0VGDCsFOXNlqI9XYoOVkMl6QY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5191.namprd04.prod.outlook.com (2603:10b6:a03:c2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 2 Apr
 2020 00:39:26 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 00:39:26 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: fix NULL dereference when removing a referral
Thread-Topic: [PATCH] nvmet: fix NULL dereference when removing a referral
Thread-Index: AQHWCHuYD43SeHbTHECV1auIWc0riQ==
Date: Thu, 2 Apr 2020 00:39:26 +0000
Message-ID: <BYAPR04MB49659E5E7A701C15128CC59386C60@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200401231627.23553-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2beb2371-1473-4908-df4e-08d7d69e4c06
x-ms-traffictypediagnostic: BYAPR04MB5191:
x-microsoft-antispam-prvs: <BYAPR04MB5191C55255C079CE5AAE13CB86C60@BYAPR04MB5191.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(81166006)(8936002)(186003)(52536014)(26005)(316002)(2906002)(53546011)(4326008)(33656002)(6506007)(7696005)(4744005)(76116006)(478600001)(66476007)(66556008)(66946007)(64756008)(66446008)(8676002)(86362001)(71200400001)(55016002)(110136005)(5660300002)(9686003)(81156014)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: edcJH31pmJBpjfWPAk8EDp8LLRBv2+IafQfOiRMOVVScpjI57GLxQ/Nbe5HHLRn+BLLQqTLIQEXedWB3/1tScLRfTPS76R5XL0++EgHw/eS8V3kF1KptnQTsjXF6rPPOySY2VvTQCp2/Wk51qiIACjHip7LUdD2SRcqlmRLpDmXaFlOjZ9qdVHXyaH89cavIWsZ4eN/LDmCD9i0de3YCOa6VrliG0pTMQSOccZSXmwZSSvbI8u/k/qZ/OF3VYht06mui7D63wVcYCM30OrxinOn2vVJDcMyV8khk6qLQOmxW3o0bzamoYKRyyfeSngAxOCJVGFS6Z8wK4votvYytIWPA2KUu3xu0eFjP/goT1feEgFJZmCnDJTd0HpglFXOzrACtaHzjPTmOxe3vAWf2AhP9sPz9gYxHF7xWpBtc2e/KkA6xYdzr//dmRxMQ93Q8
x-ms-exchange-antispam-messagedata: x3FztGHCpWAIJj31DVNbac0hAt5rTvKpFLRzTYOvmaVe6OkkkLZq37jcDN1eGk2O0Isfp4uWEpidZE8REQc5I1l+DS82bS3JZ0kdQFCjH/+4I8mvqip5vFxviXRImBRMc5Xz6dVNdIogjz16x1i3EQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2beb2371-1473-4908-df4e-08d7d69e4c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 00:39:26.3660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jg6t246k37YNeuLQQ5xoUx0MZAZQ9uWaN2rlLkaEmpT/tHHMDFP8K3JP0Y/O3djyT6iyayxqu9hp1qtGk/dv5Rs7vcQVrh6PLKS/rCpempw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5191
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200401_173928_590403_AC91C6CF 
X-CRM114-Status: GOOD (  10.03  )
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
 "tasleson@redhat.com" <tasleson@redhat.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 04/01/2020 04:16 PM, Sagi Grimberg wrote:
> When item release is called, the parent is already null.
> We need the parent to pass to nvmet_referral_disable so
> hook it in .disconnect_notify.
>
> Reported-by: Tony Asleson<tasleson@redhat.com>
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>

This patch seems to fix the problem, Tony please confirm.

Looks good to me for this issue.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
