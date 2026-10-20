Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C40E606A327
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pw+pNAqq;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=TLybxXY2;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=qF4p5nPb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vCSA50yyPcM1QetSbUbPJWsrBzOkoYHHfX4ND9QaliE=; b=pw+pNAqq3AR7fDFA4pv+dwa+tV
	WOI/6xecRyHvwwSqB9VmeoWktlkPmGWBqIpxZ+YXXrD2kwHObSpIRHneI6yMhH22We5bpLT85Ft8a
	ve1r3EYE5ySH0jZ2cFOYde61yCR1WpILMT257uhhwTmChVnmbv6KrKE+wnQNPjFMDblvjomVNbpee
	EO0iAc7TwV4nCnpsw0X35d1bioxjkUSon9Kpqk18lkoxPVo8p82omuORPV4XkC3CX1RWfXv9DAc1f
	EePkJhrKA+/lHMF+BCcVPxfkkizLHHhA74fIf0vEGL1vfo4eRIfCQZnQJn6w8Iz26FCOwFwMne3Cd
	YWA07L1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ3X2-00000008wBe-28R9;
	Tue, 20 Oct 2026 06:41:08 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ3Wz-00000008wB5-3511
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 06:41:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792478465; x=1824014465;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xUMYzfVxh23Th3UWPJni2wSGosPycEIPvD7v1CG9Ivc=;
  b=TLybxXY2nKGQxHdE94y21vOWJ4cYfs/JF75E4YJBC4D4bhwaGaIbc7Ep
   qws+c5sSdCSwAo9zkxCvhqFvRMbgL3NiNKAGtW3twnBHOw9uasfuoCAsH
   IEqo5v3O9QRXjk4Ro+EIbgDwvrFr1zlEHXNq0A7T0eBiEEBYicK/Rp2O1
   NCEFWbR5Dt1fLCTGcoaG/W+rtdMseg9ZycS0Y1pg6LDU2YMbJASeLAXbh
   Bc2p9/4FK+GxBGttBpwILkfoJuAMCrBDfEDj2rTyxsxaZFLNYC6TMEKby
   +zd2v+gvjWlr0xzEOOPg6fR79OhyYwbjvz1d2vi7zNObCqYA9NzyOCbDt
   w==;
X-CSE-ConnectionGUID: /+PEtLBmRYCsQFWwXhN/vw==
X-CSE-MsgGUID: ShKWkuoJSsmmouWI55nDzA==
X-IronPort-AV: E=Sophos;i="6.27,168,1786982400"; 
   d="scan'208";a="159474338"
Received: from mail-eastusazon11012029.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.29])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Oct 2026 14:41:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vULJK6VFxJYbUnyOrZUjaVI3knY3WyQNrkY8/q/Rm1U51NMma2unKQ0iXP3yrIUIvUaCuMuPiPsaPHLxKmuuC2VLt0X3DkCzqduNQuRxg9LGuWAz6xyQs7fqZKqor+xSqOzx+luPgCZ4a9YiZPRlH7tt0s7tM1XcXLJRTbfQx9IJMSY7XjRU6iQ1B2MKQcwDVXZoDERUoOr14Eri/QDbT6g4wm82WaySydKmZqvGj10nNVZd/OGYO4BYltg4s3zvpxp6mPGNq5tDoWteVgT9j+UJdjUYn6URTw2DqtUVHkiculuJiJbFZSoppgYvUcb0OfgkTaF1OgOMBZmTfp/LKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCSA50yyPcM1QetSbUbPJWsrBzOkoYHHfX4ND9QaliE=;
 b=MxEdRobhMppBTWNWs1UU6e8JpPkyzb56hi1nMOtzFpcuJjnXLcyXWp5W89MpLS9xpG8TorWKd3Yx0h8KtvmDjuNHv7dOfLv0bt6OHlRm6Ph8sbKIp0+jX8vN7XkChZdu7XZUplWIL4PRFM2Nn6Hua04dv1I5sqVTEqEJVBxpRO3ACAI+gjs8gqFCns1myK7XUa2vcNB2yUyxBA7IvJS6uabL7QP3ZBjryd24AjGboz9T4GD2Ornvz5Po44/4JqrbWIwqH6+PCCpR8UYPkWIOkYjcP2u3yKi4Bk6ewtqWqVrKQXczEID11DlX9ddiixtLEP6BmJkJy2SpAto0+xVqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCSA50yyPcM1QetSbUbPJWsrBzOkoYHHfX4ND9QaliE=;
 b=qF4p5nPbeitdrlrrx5Mr9FH9dTX3+Hpy6NrvEtiLg5amAQZ5SAXyHEl1Ea0gHzD8qZU7xLXJpNlM/8LoP1PqExjbMFgtJj/h4AGezweEcMoIHne1H1S7brBfjRGu5bpJi0PtBjMDrJzcEHJV6Q+sL8IExI8+GKk0DwY7ueTeaQ4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BN0PR04MB7966.namprd04.prod.outlook.com
 (2603:10b6:408:155::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 06:40:59 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0522.017; Tue, 20 Oct 2026
 06:40:58 +0000
Date: Tue, 20 Oct 2026 15:40:53 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH blktests 0/5] nvme: tests for isolated CPUs and fabrics
 queue mapping
Message-ID: <atcLN4XXfNF1YSZa@shinmob>
References: <20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org>
X-ClientProxiedBy: TY6P301CA0022.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::8) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BN0PR04MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c17c301-3ba8-4a5f-044d-08df2e7519bb
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|19092799006|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XCxl6tVoo+4gggKTLhVTZdyjoOIDR7jbO8ig6VXADAM4hctM+8Hj+z0/5yp/aw+7uKpoNcbWp6tbfVcyq71yX1mQcpRC7xTqxtPVkJ8jLD2u/e8H5h4u6EDfuJsbOo2E9M57gDkGSF36vUGIfREDeWYSxp/oUSovPpsCyCDz8GzYuSDOh3begKSeWrtz9vB3Zrtryo/c154qt7CD6bDvzljkmzdqGaAri1HNAQBTF+iQvkoT4Rqb+2AAoJmD9SEads0+YqOMxCBz2jaxyhcY9vCM5P3EzrSCFtXJxwlAsKAJAW2SYmptlT9uKfHr8rBkQkhKlWMSjx//o4IxLKzNfN9FkbDj269xGGbsdutDxpI2a14zsSJQn8/5Asi+ZWQ5M7h6SuwKYCxXlLedQqzxOG4siEAd2oi8PuzUouxBzU49l54u96Q3r9lz2c/xdQeh/Er/lS9O+55FG1mMDdWvmqfR/fu072b142qF4ZJHL/tmVpgGpT0P9qYzSGt9LPoQfhaGHClj01Fq3sDFo8Then1plLS9RInnZeuZWZbrBxFPonWCpiqyThJiIFblM2O1Vqmqsb1aWR0RkgAytC4pxgz1NYpEkM30z//8yv7FKqKYmoyddLex6GenMmIfTPAR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(19092799006)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WEzkvzKkcqNsF+DICmMPEydzUvnJ/gVc+dbePywnmVnNm0KCGqhDYiDK7fmI?=
 =?us-ascii?Q?4hRIQuD8+7MkTFnP7WJc0cFyfk7FwJkyLOSQgI1kJv9XgRvktM3xEXb1vBFd?=
 =?us-ascii?Q?733S5BCYI2ZzcoTe8+gcXfgms6/B0mdktTT4MdkTPQcK3m95UL2HSf57uL5c?=
 =?us-ascii?Q?hgiSWBvos/eqSyi4p+uGE4RwVgrGzNs5zp9Rp/fuj61HohaU14gSgqsGvaa+?=
 =?us-ascii?Q?96h5A4GQO2AlUqwEDO96lbT+U+OCcd2cEhnQ1k+M6b9mommIguccmhibxtEB?=
 =?us-ascii?Q?OpTGpnKOy6N/jMkWiXlztEqdfY10j3Iwvtwtj23hxJqw3z/iObnILF8QOH9Y?=
 =?us-ascii?Q?e5Y8S9oGeZI259KBwLIyh3IVd5muxrpHiODIHAKilTpLWoQshmdyrGAjw2Vk?=
 =?us-ascii?Q?4C9Y6HFMPW+O7ramgAdt/aTeGSldg+jyqqLqXHZQ/NGAHO2coyePqXOWqEUj?=
 =?us-ascii?Q?J4xXc3WEOPPpRpAQSkovjJHyGNW0Rtq9ad8Cch8QTJX4e/JPOHrXoyTHDJRn?=
 =?us-ascii?Q?xr2BJmONyHmgSpTuk660W+dAe5bzuTtS03Ppnj9ouBJvXidDE/O7BDV9VH3f?=
 =?us-ascii?Q?s1esI0k/tUQfJxNC2biX7op0emQII9PlgHxXaUkBl5KcMUSKF28HUIJrt8Ma?=
 =?us-ascii?Q?sdxRLDH9FnYEjAnYSyq0q7w9C1TQ5HHty4CdZEuxTYX3ErlD7v3wUMnJj4tP?=
 =?us-ascii?Q?N96o8p5iDzuQ2SA5wgndNyHwZN9tR1JK0x8jU/Z8txB8EftBdKjl67oUCr2o?=
 =?us-ascii?Q?Le+o2C4lJPrQ0sdzcxh/twM7QLWVTyF+x2XJiWrtKJJcHobxB0bcF0h05MIP?=
 =?us-ascii?Q?bNiBD6GvmSKQIfC5h91mDHVfdIZvQ97OtMHyqFBgGT2KGD+DmUbXQWQeAinw?=
 =?us-ascii?Q?XJioryKfAJCEuGriCtB5EFmHYG3hs0IO06Kjzt3F6/bKxaYogPtUC+7uxzLZ?=
 =?us-ascii?Q?7bDnjAv/sMGgRDU3RRt1hdUFjIDjzPKgx4ET56wh+yPEaDtKGlf4wUV2xCH2?=
 =?us-ascii?Q?iwxDkASN+5Zvb6rdtzlKgIB1T28IrAzpZTXOEfnvcTIlmU6NGTu6OHuyT1YE?=
 =?us-ascii?Q?Sf3xeElsONNVMtofND2/LOS4PsCzYfN5E7jkhh8tLsMpJ4aLGYAvq6YA003G?=
 =?us-ascii?Q?0sorWoTgeJV+EWwzYyq6Q3kGwEVC6FT2xhaScT3memCxgwZZIndLeaBooDVT?=
 =?us-ascii?Q?2ECagzF3n5XDc0o0rgtHPeVJ76g2rlsM10NfEjDSTvunlhW5UR80r9U2G4Qh?=
 =?us-ascii?Q?cU0D7svEqaC8aZtyQm4Zkna/pmvZa2waMjW+ZQRmfxHnlDf6+3ov6HAO8C70?=
 =?us-ascii?Q?R+oNIeUzxwEJxaDVHCDEJft2AGDDf1hAV3RGKzW3WA2W9i4UZw0iqNptxvJr?=
 =?us-ascii?Q?zICpk1qMv/8DbIsSnzNb333OYuzQSFjFnmcZObSxQJRu3PwBlgugxMmMOyLE?=
 =?us-ascii?Q?t5QIrC8JFd3v7ROaPeBAFbRd8yI9yutI89GHhz8Da61j9eNzCursroIrzCrq?=
 =?us-ascii?Q?LOJN33TfZA7pv3UZgLbKzZW7M/PG/yoQmjDjSLWv6QuU/q0EpIpOvLHoKNz7?=
 =?us-ascii?Q?NuUPK56FAoqYU5dmywi3HMB5qhIn2eI6UklLfQpohKNz/UWaCLtBPnW+/ejN?=
 =?us-ascii?Q?KDWjw47lzrbbXYbnB/wRo66VYogJ+Wh/zQyzw+QfQZzIfctJ5u2WVpcwr1OZ?=
 =?us-ascii?Q?ISlXMpQwSLEVDMCArmIbdjKwnQO/XSLr3BtTaq8mVhSkG0oWk3yWup7OuwWF?=
 =?us-ascii?Q?wnWQre6wiLKMDbhjz0UjN6Cuea30Yb4=3D?=
X-Exchange-RoutingPolicyChecked: 4nslIqcM81FpCMedtNdLXumDmVz7vhxe9DfzQCS6KSmFfgb0jwCrKJK7EQMXRpzQo2f3YATWJDNP4bzdhyvT8FPKOLvkqtqu4zyla7qTi8X8uxbxvBkiLwXZ63RHalR/KuOseC0hVIii0HrXpf4dUArCHBlmSpHp61fPPaNNwfR8vjZaVFLQ5gi6yOu+4z36W9ynVn/xzOAAAHxp276xQPFN+wY/Iq/6iSNz6T4xewFK4SVVrHGQKmok+rJv9xdFhmOHu2xdiRoaRq2Jyys6AIBKkT7HHPa4dlAjOKUct9yV0PpPevH4dN22c1TADUT7oJzocfRxNBqotXJiFRIziw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GOqmL4ruU1PnVuF+emmmK6QqbxdYXdHQGN7l9rR1CdwDk494iqq4e+GRVvUAwCdav54VzhZ7W4GjkT9RIDl/iJEmjhhE9hfC2UQJLfWEtX7kmLoucDjx/Elr5c48gMjBCtgI8h2nwU8jVZ2aMeg68/96C3OdrUYl4wdqTglOpdZgAbssxE/Qb8gxaJSV05izEQabDnxuYfFlrpo7FXeXjJ34SejPSJh+dEVt3g+4AVgEWvn+GNxp9hViPVFJJqI6pYnkrCDvNwau3aHb2oc1rgN63xrud8Io29Wi4ckC8DZQzGGwnBcwn46lJrWAz9en6U+f2HPjwkmzXYvkF7ZDdcFMA/WCQdRTZIt/qGGGBestnumNDSeNQeklI7c4S+RMme79pCiXgJpd8MgsGksTES0k6xYVibjMMBK3NWB1ktt+UpmSGgHgqfT4h00bBIK6U11iPJrAZzyekFVR7pxoK9HfyNO2mJ8GsZ+QTfRktaglYnyazpNrgtWwnBAYQTZ6WF5wppaulPYQTPIYc3ny0hZnfVsOWPKbs1l/lOeh0nEwXSEp5aIsz4RmrlSvadCgqUBVwJS1LJmM9zjC6g0d/GEzkQ7DD23C3A3mytpwAc/760RcW44SJoaOOGipvY3d
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c17c301-3ba8-4a5f-044d-08df2e7519bb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 06:40:58.8562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D33WFGFONIz2EvI7ykgee1jNY8UZc6r3+yXAMCq5beK1CwwzKhSrBexZolgQV6n6cMjMYgvWVebpM4QbEAmH3E8btjwmKUW3gO79eClzCQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7966
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261019_234105_821807_0B20BEC1 
X-CRM114-Status: GOOD (  16.90  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Oct 14, 2026 / 09:51, Daniel Wagner wrote:
> New tests for the bugs fixed by the kernel series "nvme-fabrics: fix
> connects with isolated CPUs and queue mapping bugs":
> 
> https://lore.kernel.org/linux-nvme/20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org/
> 
>   nvme/070  connect with an isolated CPU (cpuset partition), verified
>             I/O from a housekeeping and from the isolated CPU, traced on
>             the queue of the isolated CPU
>   nvme/071  more write and poll queues than online CPUs
>   nvme/072  no queues left for polling
>   nvme/073  reconnect with fewer I/O queues
> 
> nvme/071-073 need write and poll queues and only run for tcp and rdma.
> Without the kernel series all four fail and nvme/073 crashes the kernel,
> with the series they pass. Tested with loop and tcp.
> 
> Patch 1 stops _nvme_disconnect_ctrl() and _nvme_disconnect_subsys() from
> truncating $FULL, which dropped everything logged before the disconnect,
> e.g. the fio command lines.

Daniel, thank you for the series. I ran the added test cases, and they work as
expected. With 7.3-rc7 kernel, they failed or hanged. With the kernel fix
series, they all passed.

The first patch in this series is not required because the blktests commit
64cce9a87099 already fixed the problem. Other than that, the patches overall
look good to me. I think left works for this series are as follows:

 1) wait for the kernel side fixes applied,
 2) modify blktests side commit messages and test script comments to reflect
    the kernel side git hashes, and,
 3) renumber the test cases

