Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B0AC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 21:11:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FCA64F0F
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 21:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FCA64F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=uFYhG897vnub3X+psU990WINWocwuiMVOcsfd+mokEY=; b=XBdaOUy/Ij5GmQDBp8ZZmznov
	PQa2gshreCsTFzST7vjEsI37CsD8FoEuHldbXKXXXza6hAHb1T7m9Lv9Phj7ysGWIr7Aan7Vt5V/1
	fpzBQss8GbCR7eJJKLyrpfs3aP7V4z1dwp2owZQ88pfVb4avs3WYcKNTUmakmIENAs3lZnmpv+ZDu
	IxLyQxmGa5n4JXSr5+qz+Y3Vs5QR+wGVzS7KgzvAr6Ty51XnORxjUzqyp4154PSVd7rIdYm6cfDxl
	LR3RNQEIdGHPP9THk2+VlVbUY1p8zr7nHgefs16UMm9TqExCbVvGLjJofcYq+HCgxe3vnn7pY2o4a
	MJOHe5Fag==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLuUH-00GuMx-0x; Mon, 15 Mar 2021 21:10:53 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLuU9-00GuLk-3U
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 21:10:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615842644; x=1647378644;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=WXm5TakyDVms91u0i0FREf7DMjXQYzoCZMW6mxvu5Pg=;
 b=gkA+Th3dDhb1sCdkJGj0jk2Jr8SofmAqpz7gy3FOHlJ39rmhZnOeSh6x
 xF6iGYZyQSy5rAyoxPW6vLCtKeOvqZ3p4958inFFAJYVE2KwBwZc6Vgcj
 WVj6y4C4CrFtMQLX0gFQFukF69F1DjL0uMA93n8+oAH5y1sHuRgAN9fdl
 1Ki1a0ovZMYP8b1OLxlqNjMYIQtSpGdwgABBCc7Hl5H3sJ+JzDNLtpNge
 qk5jQ95pB2uuNGwyt8EZgs2udliugXGhqkBCqfSaDaKx7fTQUMiGO1fx2
 OdmPnFd3OQ0eSFewrdYQEEaTPKaH8sd0xFHp/wT3FsJjg2YXiWC8qL7L9 g==;
IronPort-SDR: zN9ZVcwtfbfjInI1QXYgcAohezXDPFp08rHX11Qe2KURetOoq3hraql13me6PnccTcmI3Jqc6b
 XT492ZRV3sywUJbJnykKKOYVISTvu1njgBK3b8SiTXwffD34OTuSCCdnVBix61hvvoI5cKoE5M
 2RpQw88VImX2CKu8CnGWQhjs0NXwpL1CHWV0dAAo0T4evU4pDGNu//9QtxfNhUCprBEh8kWcY4
 6wJo4N8i46/o4oRFmz403EYRfc6a0T7QPPSQwc7y+MKvye4TPcT/m5iIH0e8sADrh4dezfKx1F
 Lo0=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; d="scan'208";a="272914882"
Received: from mail-dm3nam07lp2047.outbound.protection.outlook.com (HELO
 NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
 by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 05:10:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgI6ymzCIFTnt5Wwln5ZXGw7xczXLBfoG5bMTczDKxkvvZ6zD1mZ6O7HaV7aqejkZnjwLdgkCHGnKKRllwdSIQbJ1vmUZU9/7R8dqXBwaw+I9opLQybsmTOv71Bf+2f7pw0Bf5ZY6zwsnHQDvOs6Ck1LkE0vD2OwcgFKsfBgK7giLgQWTcu4jB9TcEUbZxqewVVf84s4grIygRtKaloXVbIFTcpCbdUM5EweaywAis+AoZPiSk32ZEyYmkAcwP3+TFRK3lX4aeNz38pjfWHHY4MvvNE4P/l36DEbyu+s6TTUI7VUIKxZbeXQZ9jl0lxJAS+09rSTuIX6kDfBL0beiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xU1cvtDllYJWQn/rc9zxRc1L6qjukHur1Ra3HAprDRs=;
 b=OYEmXu+O9xXmJU1Bl2Qv/rPr3dNBkLokI2tgfcge8i87x1let/G0/N5kU/jtoqKwuhaJk8WRs5z7P28Dg+TxKIfYdD9UBBJWR2VFRCHiLhghNkIWz9efkSI622EshD4NcCTPjH02a3DB3hxRBNciDHiigEAjypdT3WE3akKxTzCSWxZhjmnD6VN2pqWXNaNXlg6ZuyfwkyQfxdQ4NpyxfQvcheZ4ByrDdYmTzU0le+ny9ecvVsEA52ukChlVkdfDkuNq84WZKtkz5Iog84BKoM6JKP7DMcnhiJgvP4YJat+SM5AdofqP1rcquF8EW4nji8OkfnfwmUlGeOf9Gnhu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xU1cvtDllYJWQn/rc9zxRc1L6qjukHur1Ra3HAprDRs=;
 b=bLEnr78L14okLZdQceVzufn1+5lv53zT0+wxptC1qtR9HHqCa2meIfVmfC08ht23SraGuvUoWHZTwtld3lrO3b6rK/c+3r3/HcP43JDHqU6yV8rjyrto2lwjLrgd1NyT3BHGeVQvOl8hUFndxyrqBb8m86Q8W32dGeO2k6Wbf/g=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3958.namprd04.prod.outlook.com (2603:10b6:a02:ae::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 15 Mar
 2021 21:10:41 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 21:10:41 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "ngottlieb@nvidia.com" <ngottlieb@nvidia.com>, "mgurtovoy@nvidia.com"
 <mgurtovoy@nvidia.com>, "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de"
 <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/1] nvmet: do not allow model_number exceed 40 bytes
Thread-Topic: [PATCH 1/1] nvmet: do not allow model_number exceed 40 bytes
Thread-Index: AQHXGateohYAPQtrLEmKz9nIE6WnAQ==
Date: Mon, 15 Mar 2021 21:10:41 +0000
Message-ID: <BYAPR04MB49657B5E84CDE72510A5AB77866C9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210315145611.155972-1-ngottlieb@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 202af174-a941-4b2b-0dfd-08d8e7f6ca3e
x-ms-traffictypediagnostic: BYAPR04MB3958:
x-microsoft-antispam-prvs: <BYAPR04MB39582C50BF240DAE13FCF38F866C9@BYAPR04MB3958.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1shf81RJ5jTjP0HiFOFkRN8mG7R2gnCZhwT1zyhmgMceZtGToidNx0EMzYkIWkCtOSc9sLXqCKj/H+6J9PxeT6Xl1Xn0Sanec95RJzPVVVWcHoxzJt6jE3WhRVu023IvBiEhzPb7TcjSB1kny4tuYBHVYJ7CA4fovFliTj4zQAoVeJWhOMRlIsiiE/sULvUeypW9DfA/BzU+mnZ3gOWQV5bM1m1eHVJWdaDn7OTXta0piWX+QyswW7P8UlhpQFNHXu8rCEjxGBBQLYC8UFxbABxWjYMown2fWwB3U6WP14A9Wbx7/0Bhb9RK7qLKrF2LZ9Nd/a812NNY3kjmuGx154qDSrclvYiGdmebnTfj4PA//I6M460NtSdjMCT1Rp5SWm+hFxM3LezjHkRDBiqWZ0I4bHNerIwi8xxwg6xyr9wo0oXUGDGhQkB2ziYsps5NjMdsLhcDV/ufeK0V2DgFn84ljIvl4jhWg7cD9TRdGxxS1ulcsLx9uiF0vrIwDSqFy8+veQ1QMjQQnHeI7L6Ggg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(64756008)(66446008)(53546011)(4744005)(83380400001)(5660300002)(86362001)(110136005)(316002)(71200400001)(55016002)(186003)(66946007)(76116006)(8936002)(33656002)(478600001)(2906002)(8676002)(52536014)(9686003)(6506007)(26005)(66476007)(66556008)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FV0kKZnsXI6RnwF6KC9IGYDnfBiLfNrUN/NXyeuA3nzIAIFpmMuYnMQXll2S?=
 =?us-ascii?Q?AWxdU+JAYCscunSPXiQI856BzAO3ST86mDLVbizFMIkd7GKzGpODeN2kdUn0?=
 =?us-ascii?Q?89sZEOY7rZp3UnW4x0gPmm9NnQAzwhw0GZoFzE2Meo9fyH0+IqoP9Aupoj3g?=
 =?us-ascii?Q?KMy4gIAlc2ajoT/lm7huapgJB98nWQjdKzwNj5nSaiIL0g/V7v//u9l61BxW?=
 =?us-ascii?Q?P7L5CcGmookI9p9svNPPvV4aGUqtPn4msip0VWaXnzvdMyTou/vwrz4eNEAD?=
 =?us-ascii?Q?paldesruP+h+t+v4GZBEs4vSs0zgQRwjbGWoQE1U7hBd3YNdX8L4SKlEqprO?=
 =?us-ascii?Q?tM4KTFiLTCSF7TKOCsriiVAUvPqTDSkJdFcB0I6KM7scLoHzfCbeyf/V5fUn?=
 =?us-ascii?Q?lhVJhbJ74XVCoksKzIIMiUgQS4gTeLwcsyj9M0dh8jSj3kEq+5AdfWDV+NlB?=
 =?us-ascii?Q?ZYFiHGEp7+LMp5FdGD6Y9NBnf1Rl+Orpy2SI/mGLF4dJR489ykQfJshHejBO?=
 =?us-ascii?Q?wLf5PoUmIZSUo7YwzsEJ5iNd9xbf14g/kF0s6th57yQM1iofq9ffLdnuu0vN?=
 =?us-ascii?Q?9dwIf6AB7jyDS4M6ZfDWzR50zEZRZCyiTaIc5M7xx0IwXbirWO2p88RYrpFT?=
 =?us-ascii?Q?7s/5RUKOcfTuN5G77Kcyo/in57Js3IF/T7qUWHuaQiFQM2ymDIZwcID2NFbV?=
 =?us-ascii?Q?k7c0CNXQ15f9veVVwbQnsQHpRt2TpjGL1ODCtgkQSBEfsbOkiJBpRUu3AhF2?=
 =?us-ascii?Q?wqg5/8BkpoE65U3B8TIKzntEKkjdBXhPmlooUmkagvapYLVMx/v+Nzt6yxBH?=
 =?us-ascii?Q?YB5j6qNYu/yoiboC2cBapMfYT6PB5OchV1VYvxDNwOXxD2ENKXaLQpZ3qg1b?=
 =?us-ascii?Q?zTHjC4pLUOxLEJlmKubAl1+ocj5xKHorNXJZEjXN75277pzZebrRTRec4sqU?=
 =?us-ascii?Q?lOb/b+Y9mLAmwKPTqtm0g9Cpwi7fowKrf8xINJDJktie74xFtbFxT6Z3j3k1?=
 =?us-ascii?Q?OCW0asU+9nQZ+ULm+b+qkfU+FQURj2BgKARph0xtM+wxgv1/DsrVgYQbGa1b?=
 =?us-ascii?Q?8LjF+Z95CVl+HIHF49DKqmRqWkKP64hN2PcqSxAOHQP1bcfBtEEpiNbBHZYw?=
 =?us-ascii?Q?zBzW8PM0kiKA11O330Fm3i/U4U6oYtvtK02e8CvP9gjAe2NI6OouT4YKwJm/?=
 =?us-ascii?Q?9qCr2+yGbPckpdl7aQyt+bzsE/a4uJV+oDgjs9uIMnxp748aGJnDwVIyBSKZ?=
 =?us-ascii?Q?bu8aZS1cXiyL6JwUR6DCW/FFY5gcRktZy66JA7cVoOghkAoj8jYUeOTO5gfG?=
 =?us-ascii?Q?tNJZqr8AdGB14iEqV14EqMVe?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 202af174-a941-4b2b-0dfd-08d8e7f6ca3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 21:10:41.2079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdIvroL+tSPpbTO1D+YoPMUGMJCGfklSwNE9L0io8KwBPh9yE1nWvl5mIXMy1DYDyXVYGlJqF/Xmlvkoqvo73GKuHZT61eFWAVI0RgY34Is=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3958
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_211047_814869_46F936CE 
X-CRM114-Status: GOOD (  12.33  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
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

On 3/15/21 07:56, ngottlieb@nvidia.com wrote:
> From: Noam Gottlieb <ngottlieb@nvidia.com>
>
> According to the NVM specifications, the model number size should be
> 40 bytes (bytes 63:24 of the Identify Controller data structure).
> Therefore, any attempt to store a value into model_number which
> exceeds 40 bytes should return an error.
>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>

The patch looks good to me, but is this patch not intended for 5.13 ?

Since for 5.13 we have nvmet_subsys_attr_model_store_locked(), this
patch uses nvmet_subsys_attr_model_store().

Is this a fix for 5.12-rc  ?



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
