Return-Path: <SRS0=CmHT=BM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D75C433DF
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Aug 2020 22:45:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257B6206D7
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Aug 2020 22:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qkwmWYEk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Zg6QdN9S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B+Hfaj7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257B6206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=iMmZNygTPB9n5xfvaGEyaNVzJgTLoHmw+Rx3e625OLA=; b=qkwmWYEkmCyrXSKIUSZJRLSnZQ
	dc+ztMjasRtFwzeyxr/7Avw1juF29HDGumxSPZx24FaN3834RBQ2F+rHkPALn/uJF8AOV2Bxc60AS
	7a6BkZO/KCyiPQD1vZnC5r8gHRUY52VUB1eTCFtLiOW6cbEcGHZFrdj+eT2grdNOh8lkM2eF7/EUG
	gbBnQY/k2prIhtpQ/AerD6nk7V7MePjTD4RL8EOjHLI1s1aqWFB4eXtOsgm5Q5gldtxa22duwOoFN
	Q2e3zKY1f8a1XoBjemiJEMnURAEY2k3iv3ZXBn+AZ2MkZg0ZyLY2POqQ5G7cYzPiHUuBjBUVDx6Gc
	9tkVzNgA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2Miv-0000bY-JW; Sun, 02 Aug 2020 22:44:57 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2Miq-0000ay-1J
 for linux-nvme@lists.infradead.org; Sun, 02 Aug 2020 22:44:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596408291; x=1627944291;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=aSM/gggN8NE3Rtv+1frbD0uT6KvsbcMM82GIbPJRdO4=;
 b=Zg6QdN9S92AuFybGH8/72foOJKWCwscM0BfFFlQjWUwl8AL+NPyoionz
 vl+AL2mvMAfpgtHDED1Wx6qZ3SmMQo/KFzgdNf54e1YC9l338SvzoqBco
 wzvmKdJWellbcY66+0pf+AO6DjONCYL0bIF04IawenP2bU5TFy6wUkqkl
 7SNg+h6PxW7tI+mSvbJbqunrnNDG2a4bSltkJwyLk2sWrHz+qikrjbHwE
 eJbBVno+aj4a1cq8EHLqNbFqS9FTpMewaLFTM90sL6JsqoOiMagoZNqPy
 6QBebOh2aQ7a+4kemJEjQ/eLJuonAKUVhvr7TuaCkf1x8Kpd37XdV429U A==;
IronPort-SDR: h5dzcCG3s9Biq0ABG+wZhe7xRd6yJVHBFujW7zVyvHNXsBF2QcCFiM3mWfwjphdgQXNEKBdpnU
 2aXn18BupuhtaFZRsF+eAIbZT15TWtpwhhxU6cM5YbsEpCi4ZnfshmuGEQyXOteHtT8bLLLLtJ
 lDOWm1V3D62HngOtRq/mukQ2r134w+p7bTajgihMPakveP25PAhthwhu5Frl9nMGHfT4aH1Wi5
 TtsLvR8YtEx0n3zLe06txBOexaY7gboa1coXVsVcB8kh7M3rM3CBMu3N7Xltr/QkuQCjHoifZd
 qaM=
X-IronPort-AV: E=Sophos;i="5.75,427,1589212800"; d="scan'208";a="253315063"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
 by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2020 06:44:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vjgz+f2xN4nILx1ecRhOa5KBBrzwgozRKiDyl8/iD0e/BAyJ5LTLHg0BzYJ1MzBBozoAfuZWcrqIPh7mIQc4rt0ClAMQV38TDNClEEGfP/xTDfjFlLVtN/6sxEFiLKzBH/HACL2VOoPFNd3kZ6iH+s7gtZScY98zt31CDAXlD8u76nDLbyooTpyUYK4sVsnt4xgsOwf7uI72/kh27QhDTDdif8hIjj3xKSbwiLCHiMkQEi8kMj+xnF39pOAJnAFk4U+Xim9EwFIXL/v5QWRNbdqChKWVckN8QDSyVPseC0cpyILR8f/ArkuX5l+6VzyRvMSD07Vnjq/ICakrjtSRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSM/gggN8NE3Rtv+1frbD0uT6KvsbcMM82GIbPJRdO4=;
 b=mO/NG5WjEdaGUsWSBE7IwNh5ZDOw6x6HbaYrGFEh1lkhv9RcMQNZcPaSdb4Cf3TUzxCk0UCCUozEMyLyZFvy1MMCWRzmfzJGy3pzrrpmqTn/16MgNnDNYA5RwIjeDjbvQX426Xg4XPUEnJSmFlfD8AJG9/C/+WMB15L0NuLVPijuPPVnNGNQl4m/Arhkok+th14b98smiiYSCNhi19gIE0XYwyzVONHGSmxH03nWm42KjpaxNKRATyLrlhs6m8MSAlaMB7P4jsGWTd6xAFsCaz4nsHAmPj4D3/hSH49+C7Z0wvZ/J6gCkH1dnx8qRWf/jpu2ZE4uzj8dooav2D5ETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSM/gggN8NE3Rtv+1frbD0uT6KvsbcMM82GIbPJRdO4=;
 b=B+Hfaj7eUAhmUXWxC3NwGh90VknebK6P4OtC1Y7hi0l3ZcZSdoCfIUjpSuRNcVw+GRZoW+w3MXK8FfOVra3g6p8zQK2Pxi6naCaIdPIzsFnKw2yNvW27s306EV0xMX/nx7Psmjwic+ZNb5OMsF5KYGqyTwzsiQgb7LY3K9zFfZs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4325.namprd04.prod.outlook.com (2603:10b6:a02:fe::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Sun, 2 Aug
 2020 22:44:46 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3239.021; Sun, 2 Aug 2020
 22:44:45 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCH] nvmet: fix a memory leak
Thread-Topic: [PATCH] nvmet: fix a memory leak
Thread-Index: AQHWZrTGdAYPdnp6RUy2cgG1g2CEZw==
Date: Sun, 2 Aug 2020 22:44:45 +0000
Message-ID: <BYAPR04MB4965358A9C1B9BB044A3513A864C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200730205516.20954-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a05df79-23f6-414d-826f-08d83735a78b
x-ms-traffictypediagnostic: BYAPR04MB4325:
x-microsoft-antispam-prvs: <BYAPR04MB432515B1D2ABF1CD097305A3864C0@BYAPR04MB4325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: afhkVxIV5bM8RQu3nEShs2IaU9GnhKcjghe3JWDcPphpFr9FKuM4BwyZ0XfaIgNAcXWdE70E+zZxcrQ56ulm1SVSKElUxRwbV7vSlNAsmj7B4mlV7T9TB9I+BZc//LwskTUjHv1SLr9r9z/Xjctfo71DM/QFPuib5iYgxyR34nlQWos3l5H/Xvg0xgTJF/ScgBxA1Z9wsjx70Xe0g5pmZ4aHrRzPIO3TLhkxdemcQX/H6HUMVtY6jPpN+vty0dYs+CvnL+72ij8wO9jFPw6WdGiRdHRsGABzEaHPbSDOn5xCfU2RDpQzhDzRlFBxGfM+vC6dY376hvgtaLUuMFchOA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39850400004)(396003)(376002)(346002)(136003)(33656002)(316002)(7696005)(86362001)(66446008)(8676002)(76116006)(64756008)(66556008)(110136005)(186003)(26005)(66476007)(66946007)(8936002)(71200400001)(478600001)(52536014)(5660300002)(2906002)(53546011)(6506007)(558084003)(55016002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: uDHNHyhrFxaBQFpK8IZD2gjM1ntnTTbPowUGH0vL62eAxqij1HFTLV2GFUpyqE11z0yTVKyoXF3Bjyx4Md56ifX0cgZk4vHRSh9gkA/xjglK/HywtIOcEKOJZcY4UQIGGJcteOu2XLfvaTXR7CCELxg5KOVLRhvgFJLSDl90hM5TlDDfdsR/LWJIgPkV/qj07sf9GacldmSZF9SkSoD91ePgLHyAjDUXQu3dBM50HnvGX+pUmWh0FEktWTid87NXUS1rGI+kzovNKtZwaZzYjvS23JvWPJh7bycWhDHKJbUFDlVPRU/xO2OvAGilHny+uCMr/3SA8i+tQfIRg94cKB+lL1TkMO2Ta4X/jPw7tK2MS3M3DsvnPOqJpL0CdzGTey5f4kHiK9+wNcplSpaM6nQeGenuhOHJZLZLyDy6tnMPQLRvBfvceCkZvZH+FSX7FoTMHreIX/9RILlDdcw6qXo/rMipnpP2P7Zu7Tw1ZeLrG8K0hx/yWKYUNQCnb3AqBquw433x0Ael0kYmzvkiSj67eZIUDLW5gcVouU0yGdUrEleun2y68aJ/rjBs2vHGqQEQsBesunF1lj/fe9fOKKvevnFxr0vuSQrXel8ta1NTnRiiTXwDhS/4L5fUx4uIXzm/5idkwzZChRWRezrh2A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a05df79-23f6-414d-826f-08d83735a78b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2020 22:44:45.5095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9PNMK8eOk2U9lQHlGOHE++UqZ8EryvCQI6TdiRKcN7TgMFx1evSIuEYXUJEQ19c+ZwXQJ4GxNScoBzmFHb9lYDUosqQ77SQZRkwCXldDGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4325
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200802_184452_405130_8EF4BCF0 
X-CRM114-Status: GOOD (  11.19  )
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

On 7/30/20 14:02, Sagi Grimberg wrote:
> We forgot to free new_model_number
> 
> Fixes: 013b7ebe5a0d ("nvmet: make ctrl model configurable")
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>


Thanks for the fix, looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
