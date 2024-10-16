Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36DBD1AD23
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2024 08:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dJwTOZuH9T5QLCfrnrbOwRkMXthHYamYctff0X5jsqg=; b=MMB9KyKVi1MpDpOzPGawBe7Nc1
	qRlpXW4N2ud6/8PP2cdtcUokgNRDDryTeJ4+ZEKHw0NJvKjMpbWcjZezDtE49eXi7quQfAIpaScOH
	56NfpLnbgZJm/ed65n+n6Vdq2bK9tH0fQi1OwCxu3sR5ugvrj1oOu9LnbRJAxw/bkmRTt8WIghJEV
	lUfruVFhgt1Xcc8OsGCK052xxdNRYgDY4TW7RITdNGhTElw5UpNqKSfjDWn0mYAKpRet4cPSJhLC6
	67124cpvYWM2V7yRbA6UQaaB33amKAhyMRcTEj+6Z7e3F4l8Vx03edJuhfxRT1fNF1LgVnzY7LkMp
	t22xR5rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0zC2-0000000Ayfz-1iEk;
	Wed, 16 Oct 2024 08:15:42 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0y0p-0000000AlKZ-2Xfm
	for linux-nvme@lists.infradead.org;
	Wed, 16 Oct 2024 07:00:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729062003; x=1760598003;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p/hDB0bpsp92XSjBPj6jtGsqunaSR1GNq5pyAAZ8oLE=;
  b=pYPK+WxZDnzimoO/gl1P8UkqBaNuOIaaCLSd/w69uV4pfoGso1OjRFr3
   8obKYdjEbTNvE95seFbsDZO6bwoklqE0Fj9QOw00hoixH8XpXzNAGDUpr
   FbbeodrXRUcVo6feegYzzcLLG5dCOt1onrL+YOR1zzxR/zyUicqfrpkrG
   eZ4tSIvP8EaeLRXr0QC3A45fv1K6BxWuFcOODnFph7vVXWFprZpwsH4mO
   p/lrHe6akIoNSAZEW3MeAlT6a+Z5WNy6b6OSXpPmBSJrklxcSPko1xFAO
   5kES0CI8kBZmKxXB58rMa89WCv+babmeJRkgY2r/pR3nwlCwlrGCyUQHY
   Q==;
X-CSE-ConnectionGUID: Tc6S2yHMSi+Sl03hjqDqLw==
X-CSE-MsgGUID: +tq2VzvtSv2uh3DGvnpgkw==
X-IronPort-AV: E=Sophos;i="6.11,207,1725292800"; 
   d="scan'208";a="29072050"
Received: from mail-northcentralusazlp17012051.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.51])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2024 14:59:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtIVJxSRdIZmsISR84h7Ym9WKIBY8dHHrIvBAyVE9legpBva1nuGDVQF3SywE0UR3Nv3FB34DUiNy9AUbQfTtkZYspufAgE9/RKNFQVC1pJM7doxNZr8ofXnSQRaKEMZBT9CiXc4aGx2U9y0VmMCJDvD99+I0oSkXNC2ZnVKeik30vAGfWKQpmxUOLtTR29y78piOwtJWw5mYeR2ICeYt0AIru8brK3BlsaPYmSN3OF8qLEpDmOKeSWkofY1EyxsVKegUJY5QhhAjRtsMcwelVh8GbSSepfvNAqUGk5Xefh5d6pd6t4VFPTRzMSeTTxg3GZqjO/Q9GIbs5uWlY5zEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJwTOZuH9T5QLCfrnrbOwRkMXthHYamYctff0X5jsqg=;
 b=l3dkARqHxaFX+ZigEqFOd8bcI5tgkG/LwyBhNqNq6tvDoMiG24YkWGGsAuVS3et0MjW56gkf1yMTevSaDX2avjMxzrRt8eMCgJtdgUyky0LepSQXV/ude83rtIbhlsYGwQ4sf631wSWt0pbDI6H2EzuQnyNHT2xRetNLJ2vl6x4N2mekxPfIWGd1nSvS/1cLMBwsw46PkU5Sfz3IY6UdimQEYPwOxkFb2ab/Y2CWn5yRmgLrB1j1PnM9LSlXno/AHN2qr/k/yb73nVONbc341Z3OC60H/XFGyQklSQjYDkV8x4+tVKbiFlERV4bZw+VOdKbD4OcJ5zUBt4wUFxkm4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJwTOZuH9T5QLCfrnrbOwRkMXthHYamYctff0X5jsqg=;
 b=TR9EmiubX977rAnawK8vWHW7e9Kl+X8RdFt7bu9cj2sRUpeZQDqvAKAds/t4/dHZ5FZDe90yQ42A/VM9/3bzz4oHHfB39b5uTQ2mQbl5gTi0NLqyo+lZyKZ8+HKPr5ddLT4OzisGFYzQCNb+jlM5KyTFh6FZbZubVM9XrrkLRes=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 IA3PR04MB9306.namprd04.prod.outlook.com (2603:10b6:208:506::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17; Wed, 16 Oct 2024 06:59:54 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 06:59:54 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: hch <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, "kch@nvidia.com"
	<kch@nvidia.com>, "d.bogdanov@yadro.com" <d.bogdanov@yadro.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v15 2/2] nvmet: support reservation feature
Thread-Topic: [PATCH v15 2/2] nvmet: support reservation feature
Thread-Index: AQHbH5kAbkH1Ev9uUkmKaSG9+wdIyw==
Date: Wed, 16 Oct 2024 06:59:54 +0000
Message-ID: <4l5bcjto47t7zb7ztnhyw2p4l6ygo3rcefgthgnformc6dofkw@j6j7w5vwazve>
References: <20241014061045.62436-1-kanie@linux.alibaba.com>
 <20241014061045.62436-3-kanie@linux.alibaba.com>
In-Reply-To: <20241014061045.62436-3-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|IA3PR04MB9306:EE_
x-ms-office365-filtering-correlation-id: f7a71733-a9fc-4469-9549-08dcedb02382
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?EZ0lGvGpeBPTZ1Vi3enbfawkQNLay01rAPpiXDBNlkPKJAEcdjS6UJmyyUs0?=
 =?us-ascii?Q?XcwWCV44Q5knhW/HdK5aXLV/YEQCNWYxqSZusuAp7z5KEC9T3SAkhjGke+1m?=
 =?us-ascii?Q?0tzYOxebSKpZIUqA69sNILA6ZEV7ZKLoWOB1EsJtbZ3vTUrjQuo5fTIYpPbq?=
 =?us-ascii?Q?Q3iM4U+GiS8j8BY7ju5Xv1IPW99O7/dabyT4IbdoghzGeqdoYlPxRK8rOQKj?=
 =?us-ascii?Q?ibypciaf2lbK+ym5wfaZ2EdN28KkamB8rFLy5O4+izTQzLiA9hvFsM/GNY9F?=
 =?us-ascii?Q?EdHIrE6A1uEoahIbvAMUswzeqkeoBNt1YUDepMrs1+6r/ieHPl9EUnqUavNJ?=
 =?us-ascii?Q?Ccx8X9RIh5/T7gRQY+7SCUTD4eZXVRLAms+Vl4zqL/KwdE44n5lZVWpajGxg?=
 =?us-ascii?Q?MtBcMSaqIgmrBCl5hEj+9V7VcR7U03/s8eeiUT+XosGEae2MKIjtNdHrXF3k?=
 =?us-ascii?Q?pnvKt5rpyKAng1/B0CMgeivESdk4kkUDHKL4YMSJO0BAoGai1mslxiHonyvp?=
 =?us-ascii?Q?dAfEHn2DS27JkGlj7+bxTVT+q7AphZsjnzSNg8sJ3egRejGp0E2w4frO0YAo?=
 =?us-ascii?Q?9LGAQMrLkpEg9vdO3sYadWfkfx/7921HTtTe5Imyr3Nx2i4K6RrxaDd7wI/Y?=
 =?us-ascii?Q?MN+xVy/ady1YpX8VfmwQzPJDI2usfVA+rhWMOcRfVn0HMRybT77kxWwES5pP?=
 =?us-ascii?Q?a9ArXfGQMzfdOXzQvgf76nszhNv5GlGYpDrpRh6YUv1Rn9/ewHw8Yq9HtadB?=
 =?us-ascii?Q?U85n0+F7w1or14/7U9b0mqIpVJxK1FVPBwtE11rmHbIKrh5wXnH3PjFEQYTL?=
 =?us-ascii?Q?QRqCF48cFGP8fJxXuWGTOJCtQ5EG4S3cHXQMSh/3ZhFBhY/4WFr1INWps0CU?=
 =?us-ascii?Q?jUGYM+gDm0fK4sG7Nz1L5Al+rctacUkZZvTNbPQnzBTVglVPI4663q6YNFeE?=
 =?us-ascii?Q?zmIy8ygHaSqayTQfpw6f3l9MBCOXMgv8HjtuLWgrXXloAcxkue2KNaA4w58u?=
 =?us-ascii?Q?zqF+4PYNTpZ69ZqZjKFu2rWQADqs4gHYL2XPmMAFRJbXecuooKL1HRkv6r8t?=
 =?us-ascii?Q?ji8BJxrmXpy5JdDpLVAhdsVRE8Xn5gLRNFPmv5PDspvBAu0TyjqCNhjKW1KL?=
 =?us-ascii?Q?J7plSNXwP0JLFmsbihR1ULiQ8HsKixx5FswxzhAPOMf9YJDsJW9nWDijv04O?=
 =?us-ascii?Q?NaJl6XLp9G+XDZkJjTIL1oqPaGK9ykjQ4UsTB6i0/AboxR9SteqNn5dRx+DQ?=
 =?us-ascii?Q?8dX9s14vJgVVMHmB5v8U2FOkYLOXaRfrWI6+BXyA1Q/0hZynzy782gDenVOF?=
 =?us-ascii?Q?Tth1zKEhJXpTsYiL4/7HFCZNqW/UgbH3iSJxDTZwCGOHNg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nz7CcqAb36Abz6MIlEnHbiKKUKvUvWUzoQ9O5QVEILnQArZcCsh6o5sJg3ZF?=
 =?us-ascii?Q?9YVrabzlTErr2SL1gBG1KGpAic3RJNuRZT3AKceKCwN+3ReAsv5cio5EDQ6l?=
 =?us-ascii?Q?R+7qfsqAMKuNs8G8DxAissTQw6XYox4RlDs8gSOEY3Y/nEpYIrsTBta7djcp?=
 =?us-ascii?Q?Bxs91G5iPvvZ2OLWBJNEN6GSX6Iq0vkvqbUGesDdeHStv/J5kGRghDb57h0W?=
 =?us-ascii?Q?6P7bQ4BE+wqfAzIP0e7FIwxVCUNuZ/tx0m+fAjgd6e8kSLFLuDbW8jXUxa8Y?=
 =?us-ascii?Q?DizODgSqCLaOIh9Gm24ML29VskWjjCbiC2yGGemJunz2MKOt00g6edi4t3ct?=
 =?us-ascii?Q?odD9e5sjUgIqlLtjmdtyPY3YsZhsVh/Aa4U0sGnrrquZWhX8UX7RBx94v8rD?=
 =?us-ascii?Q?ayH9g6G79xWaU4ij/CkhXK9SlL1Rlr4ztBiKfZIECR1sOMGR/Pxa/l5cxZC5?=
 =?us-ascii?Q?VGMnUnjN+m9Kzcg4Ph+KJVTd+1UxPC29GqJ2+2Tl+GSEReeU5qAJTCVqrJi1?=
 =?us-ascii?Q?w1/wrQ68C905E9sMSWsz6wDCI0uvdOjO/AMzpzlCzVU2x5Tdi5ilvO/veOxw?=
 =?us-ascii?Q?ELQemUJ7JmU2G38uyS8mO+k+tb8oez4lrurc2flaAwewJvMNx6V1TtlF3CbC?=
 =?us-ascii?Q?mlZg3MyXRdH6GRu8oGQ2NVLtJlyTAi8G+JU0RBAwpxuZNqLxmvfRAbc2lyhD?=
 =?us-ascii?Q?hd2uHIULzGCkNTXL6BiCyEM0oW3qrKSJTl+jdnI3k9Ac4cJcSUlsZTetclxY?=
 =?us-ascii?Q?+btg2Z2kq+LOIzJHuXpMSxk3jwaN93CFBim6q03CxcwXgHsYxEY1YRv+rp7S?=
 =?us-ascii?Q?eUNmRdvjT5PaLwo61o8QmmuB9bcoWrvq+UVSYYLqTIPNk/J2z3NpinNmVMZz?=
 =?us-ascii?Q?qHW53UoK+jRIuNXiNSdoac5YVygQR7Ef508PlS6xZSEmFhDWZYhW5M3WG+Ll?=
 =?us-ascii?Q?LbzrwlcyUb/pvSRH0zTvLE5oiirN+HYX6YsCwG1bk5oOO8lPEC2oxQ7bHQd6?=
 =?us-ascii?Q?TAqxN8fbyNU7o0n9LPzE4uwzdkkGEv2pC4I68KQWY6DHXtTkilGBuGcoBLMd?=
 =?us-ascii?Q?VlGIEloTsTBjtpeMBIOXr+dOb0cefabOOBa7SAja22gChYpS8+iO51lW/AlA?=
 =?us-ascii?Q?3KiJtcsgVNjNwsDbirdFg0kjrQ3IatclJpLCf6IlRLUtIqQ6ddFTfrcpsdRZ?=
 =?us-ascii?Q?XFs0cqNRgRzati1I/ZkxAvQFQ7pEWYa+oPW+Fjv910QE0c77H2xxNKYAKTWF?=
 =?us-ascii?Q?uCwJbxGn7DX6UnF6FnWlHfGTMamgnA3I6M776IXKPRmdbOsE287qC6o541Tc?=
 =?us-ascii?Q?0IPK/LFKp4hWHGYrt+4e2MQ98gMpjmlzud6Id/BeuyLMOx7viRbgaYSXAYX+?=
 =?us-ascii?Q?Wxwc9IqwEiQTHz0SIXnDx8mnEH5dK0px6/cHWLisZBtpr/vmv+farI+K77nh?=
 =?us-ascii?Q?4xT+ybySfB+5/mbIg9hLQV2rNvOuyiZNqbZTfo87R2BbRxRrZ9wyrpqeFSmA?=
 =?us-ascii?Q?Vt179+elv1zejZwfLZ6k0WoeepH+wd54sHXvaiMAsjomp59VMkbq3NYtspze?=
 =?us-ascii?Q?47QncJFiIqPF+AmYEl8CHUS1EPTH7MmKDay9mDkrLQetrw4SvkIKRoIjpSQW?=
 =?us-ascii?Q?CR80cU6vnjehEDYwJSFQk4s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <08AC868809436D4B99895DDDDA416B11@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y+ru+/n4wBM0cC3DN72sAkrbkjCyNvCVNB7CdxAwuLyIbgd4cYw4EgtU8w9KUbyoPf4gKBmkue+Rzk5WIhzO0QxjoFmQM5t1KIydRPw3wirGPlxxY6OSEyTA59NYiuvbE3a2Je0yg/ZmbsTISxNa32RO8aCnF5VCSqYyySHwsSeciQWWIgN2kTWTZp5UQeUI+9w0AhE5xkEatIg4VqExfeiwMyEho5b531XQCg7aeXGyHvPn8y/QN+7rkJSuPzc3p99TjiUIbwWHB8ilD+UQQmWHfQSuxL8Aaxc9+1oDtF/xO+YkGnO6w/muUaN710KqjgWgpCVguUOVjGweKaj+hHLZv2MRwrGwk907dux8z6LSRzJcWbc3U8bM6jbgjQbS+QUY/bC/vRaH6ZJo0Nmmh4vt441lHaRvnR2fT27qM1lzmoKvl+hu/FU/gkA6ovcsTjJhBTw9pTWM32mBSONGi51c7Sx1LVZhiBXf1BgzzjXcmAm/CDzn9uRQxkLk79R7G6WKDjlqBI4iz+lae11cn6H2qs/v9FteZ/gK7N3Qz2yqSqZiaNjEaCi442EQ3nY+1Xi9yhUMY6VZZBtD1PthNWe1QrqOIN7yK6eOlGEM05dlyNg4R4HF049m2gJsuuoQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a71733-a9fc-4469-9549-08dcedb02382
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 06:59:54.5187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lHKxdizWXc662SufcSSkIHROR49NP+8rHVjVyt7YDTtQUi8Mhv9slCJk3e8ZwjG+/VW17vAN2SEWo3XE02m7JSIERgc/95SuhivWwHQr6Ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9306
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_000003_798495_6151F04D 
X-CRM114-Status: GOOD (  22.67  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Oct 14, 2024 / 14:10, Guixin Liu wrote:
> This patch implements the reservation feature, including:
>   1. reservation register(register, unregister and replace).
>   2. reservation acquire(acquire, preempt, preempt and abort).
>   3. reservation release(release and clear).
>   4. reservation report.
>   5. set feature and get feature of reservation notify mask.
>   6. get log page of reservation event.
>=20
> Not supported:
>   1. persistent reservation through power loss.
>=20
> Test cases:
>   Use nvme-cli and fio to test all implemented sub features:
>   1. use nvme resv-register to register host a registrant or
>      unregister or replace a new key.
>   2. use nvme resv-acquire to set host to the holder, and use fio
>      to send read and write io in all reservation type. And also
>      test preempt and "preempt and abort".
>   3. use nvme resv-report to show all registrants and reservation
>      status.
>   4. use nvme resv-release to release all registrants.
>   5. use nvme get-log to get events generated by the preceding
>      operations.
>=20
> In addition, make reservation configurable, one can set ns to
> support reservation before enable ns. The default of resv_enable
> is false.

Hello Guixin. To test the blktests patches for the reservation feature, I
applied this patch series on top of v6.1-rc3 kernel with lockdep enabled. W=
hen I
ran the blktests test case nvme/004, I observed the kernel message "INFO: t=
rying
to register non-static key" [1]. I think the call trace indicates that the
nvmet_ctrl_destroy_pr() calls xa_erase() for uninitialized ns->pr_per_ctrl_=
refs.

[...]

> +void nvmet_ctrl_destroy_pr(struct nvmet_ctrl *ctrl)
> +{
> +	struct nvmet_pr_per_ctrl_ref *pc_ref;
> +	struct nvmet_ns *ns;
> +	unsigned long idx;
> +
> +	kfifo_free(&ctrl->pr_log_mgr.log_queue);
> +	mutex_destroy(&ctrl->pr_log_mgr.lock);
> +
> +	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {

               if (!ns->pr.enable)
                       continue;

I added the two lines above here, and the INFO message disappeared. Please
check if this change makes sense.

> +		pc_ref =3D xa_erase(&ns->pr_per_ctrl_refs, ctrl->cntlid);
> +		if (pc_ref)
> +			percpu_ref_exit(&pc_ref->ref);
> +		kfree(pc_ref);
> +	}
> +}


[1]

[   39.842700] [   T1002] run blktests nvme/004 at 2024-10-16 15:24:52
[   39.901831] [   T1046] loop0: detected capacity change from 0 to 2097152
[   39.920817] [   T1049] nvmet: adding nsid 1 to subsystem blktests-subsys=
tem-1
[   40.001028] [    T107] nvmet: creating nvm controller 1 for subsystem bl=
ktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-48=
56-b0b3-51e60b8de349.
[   40.005448] [   T1056] nvme nvme1: Please enable CONFIG_NVME_MULTIPATH f=
or full support of multi-port devices.
[   40.007399] [   T1056] nvme nvme1: creating 4 I/O queues.
[   40.009800] [   T1056] nvme nvme1: new ctrl: "blktests-subsystem-1"
[   40.178428] [   T1078] nvme nvme1: Removing ctrl: NQN "blktests-subsyste=
m-1"
[   40.286197] [   T1078] INFO: trying to register non-static key.
[   40.287630] [   T1078] The code is fine but needs lockdep annotation, or=
 maybe
[   40.288482] [   T1078] you didn't initialize this object before use?
[   40.288930] [   T1078] turning off the locking correctness validator.
[   40.289382] [   T1078] CPU: 3 UID: 0 PID: 1078 Comm: nvme Not tainted 6.=
12.0-rc3+ #338
[   40.289942] [   T1078] Hardware name: QEMU Standard PC (i440FX + PIIX, 1=
996), BIOS 1.16.3-2.fc40 04/01/2014
[   40.290624] [   T1078] Call Trace:
[   40.290866] [   T1078]  <TASK>
[   40.291078] [   T1078]  dump_stack_lvl+0x6a/0x90
[   40.291414] [   T1078]  register_lock_class+0xe2a/0x10a0
[   40.291790] [   T1078]  ? __lock_acquire+0xd1b/0x5f20
[   40.292212] [   T1078]  ? __pfx_register_lock_class+0x10/0x10
[   40.292619] [   T1078]  __lock_acquire+0x81e/0x5f20
[   40.292970] [   T1078]  ? lock_is_held_type+0xd5/0x130
[   40.293331] [   T1078]  ? find_held_lock+0x2d/0x110
[   40.293679] [   T1078]  ? __pfx___lock_acquire+0x10/0x10
[   40.294053] [   T1078]  ? lock_release+0x460/0x7a0
[   40.294389] [   T1078]  ? __pfx_lock_release+0x10/0x10
[   40.294752] [   T1078]  lock_acquire.part.0+0x12d/0x360
[   40.295118] [   T1078]  ? xa_erase+0xd/0x30
[   40.295412] [   T1078]  ? __pfx_lock_acquire.part.0+0x10/0x10
[   40.295818] [   T1078]  ? rcu_is_watching+0x11/0xb0
[   40.296161] [   T1078]  ? trace_lock_acquire+0x12f/0x1a0
[   40.296531] [   T1078]  ? __pfx___flush_work+0x10/0x10
[   40.296895] [   T1078]  ? xa_erase+0xd/0x30
[   40.297187] [   T1078]  ? lock_acquire+0x2d/0xc0
[   40.297509] [   T1078]  ? xa_erase+0xd/0x30
[   40.297805] [   T1078]  _raw_spin_lock+0x2f/0x40
[   40.298130] [   T1078]  ? xa_erase+0xd/0x30
[   40.298421] [   T1078]  xa_erase+0xd/0x30
[   40.298705] [   T1078]  nvmet_ctrl_destroy_pr+0x10e/0x1c0 [nvmet]
[   40.299148] [   T1078]  ? rcu_is_watching+0x11/0xb0
[   40.299492] [   T1078]  ? __pfx_nvmet_ctrl_destroy_pr+0x10/0x10 [nvmet]
[   40.300676] [   T1078]  ? __pfx___might_resched+0x10/0x10
[   40.301908] [   T1078]  nvmet_ctrl_free+0x2f0/0x830 [nvmet]
[   40.303178] [   T1078]  ? lockdep_hardirqs_on+0x78/0x100
[   40.304462] [   T1078]  ? __pfx_nvmet_ctrl_free+0x10/0x10 [nvmet]
[   40.305771] [   T1078]  ? __pfx___cancel_work+0x10/0x10
[   40.306974] [   T1078]  ? kfree+0x13e/0x4a0
[   40.308051] [   T1078]  nvmet_sq_destroy+0x1f2/0x3a0 [nvmet]
[   40.309248] [   T1078]  ? __pfx_sysfs_kf_write+0x10/0x10
[   40.310396] [   T1078]  nvme_loop_destroy_admin_queue+0x6b/0x90 [nvme_lo=
op]
[   40.311701] [   T1078]  nvme_do_delete_ctrl+0x149/0x160 [nvme_core]
[   40.312949] [   T1078]  nvme_delete_ctrl_sync.cold+0x8/0xd [nvme_core]
[   40.314194] [   T1078]  nvme_sysfs_delete+0x92/0xb0 [nvme_core]
[   40.315355] [   T1078]  kernfs_fop_write_iter+0x39e/0x5a0
[   40.316466] [   T1078]  vfs_write+0x5e1/0xe70
[   40.317475] [   T1078]  ? __pfx_vfs_write+0x10/0x10
[   40.318497] [   T1078]  ? lockdep_hardirqs_on+0x78/0x100
[   40.319550] [   T1078]  ? __call_rcu_common.constprop.0+0x345/0xed0
[   40.320697] [   T1078]  ? __pfx___call_rcu_common.constprop.0+0x10/0x10
[   40.321870] [   T1078]  ksys_write+0xf7/0x1d0
[   40.322828] [   T1078]  ? __pfx_ksys_write+0x10/0x10
[   40.323842] [   T1078]  do_syscall_64+0x93/0x180
[   40.324814] [   T1078]  ? do_syscall_64+0x9f/0x180
[   40.325788] [   T1078]  ? lockdep_hardirqs_on_prepare+0x16d/0x400
[   40.326875] [   T1078]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   40.327958] [   T1078] RIP: 0033:0x7fdf35a1d984
[   40.328906] [   T1078] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0=
f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d c5 06 0e 00 00 74 13 b8 01 00 00 0=
0 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
[   40.331891] [   T1078] RSP: 002b:00007ffce23c3ed8 EFLAGS: 00000202 ORIG_=
RAX: 0000000000000001
[   40.333291] [   T1078] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: =
00007fdf35a1d984
[   40.334651] [   T1078] RDX: 0000000000000001 RSI: 00007fdf35b40ed1 RDI: =
0000000000000003
[   40.336058] [   T1078] RBP: 00007fdf35b40ed1 R08: 0000000000000200 R09: =
00000000ffffffff
[   40.337426] [   T1078] R10: 0000000000000000 R11: 0000000000000202 R12: =
0000000037510610
[   40.338802] [   T1078] R13: 00007ffce23c56c5 R14: 0000000037510610 R15: =
0000000037510eb0
[   40.340178] [   T1078]  </TASK>

