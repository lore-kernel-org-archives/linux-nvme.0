Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419ECCAC587
	for <linux-nvme@archiver.kernel.org>; Sat, 13 Sep 2025 06:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xhCb6A5jV3NLgPYPVuk04YbqhoxcOhDf2HEbhTOCMNM=; b=1kithtrIA2G3QUpcNx15DZDU2h
	+j316I/oZE/fb7/GqEgaQrV9kfNLXL1Xfdg1awgoL/OgZTAZkiZZCQG0lEiyx4SUtsJzSi5vsKSo1
	vO5tDZJ2orLm6I8vsgOhPywL4hQ9LZCRnTgs6cxGTMzfR3xHpD5qnaDAsr0jKERrrHUTlpn+Hchnz
	RysIcQYVrnZRbBoayhYJgxLCtoU62vMB8ieDZ3t9wIZb//NJxAprauqneagwbhCwus/f6RQxysEjM
	HSkI1AIRLqCG6R/UxUGHu2hBfHxA1l5PvaXtQy9sCjaPHd0BZzmp3hWqNeWRxVom8RjPvOmhODMUx
	AQ8KgSOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxJoa-0000000DY9X-1rze;
	Sat, 13 Sep 2025 06:32:52 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxJoX-0000000DY89-2rVa
	for linux-nvme@lists.infradead.org;
	Sat, 13 Sep 2025 06:32:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757745169; x=1789281169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=giJctKFWkefNjj2wm4WDT0oTNVNPesmqCYO1NTCYLDQ=;
  b=GPlkfSLCu70B6HwvBlAN+Ur0Vvaq+zwFNF7YJcrO1MqffzAFydSD//VP
   Yw7/R/3W6BY4BaFybpMX9QSXGC7x2Tlq2lwd2MHERZaP5NVc/3d1eU+lL
   QTvZPnZFtzh+rCpOpv8YIVaaAegtqKsUsrVKbtPmRiEyz9H2GI8XDyiWt
   C0QigtyjIQWRsHz13HBQCOxLdintsD6sV9NBI50TTAVTcnbgb1E7Zmp8k
   6dhaTVXTnakmBMjrBfN1/+Xc9J6meOkUaXsDnvIzasHb7VBrQVdtjWmbY
   r0yp8hO1ST73g6DKFP0Xk3xgEyq8hACMoUt0qFoW8o9hQ0ecuSB9h3W5Z
   Q==;
X-CSE-ConnectionGUID: rAcW1jD1Q7qH2STmHmNsQQ==
X-CSE-MsgGUID: 5/4HWCUaTzy42v+kSbJ+gg==
X-IronPort-AV: E=Sophos;i="6.18,261,1751212800"; 
   d="scan'208";a="118990566"
Received: from mail-northcentralusazon11013007.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.7])
  by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2025 14:32:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7Yw6bf38SS5p6+A+wtuCnYjl1FCN7yYFsz9H3OzOb/31UWnV//n/azh0tWVrkEg58OnJmUTXJvMH1DSoRKLEvBrcQv+n/glCuQ4fEX4GWd+BKnpitRxAvJz/krXvtqh+KdjHKRTfoOT3Vugh/W5ZFMxYfO8CSXzg6Vp3bK/3OvoSIqKGlRR9Olgv4aWQGnXa7oPngyde8k17GzSF7Vvn7iFaYkRKelhu0LkoElgQN2izHS7/5eS6rX4HLjy4fisbQJi0rXZKvf1D8INOBiVWXrmc71aPwrooLlEONjkbErJh2RH9rL+vZ70H65vBpL0VYFkEEFUXuB9k9EPJlOB6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhCb6A5jV3NLgPYPVuk04YbqhoxcOhDf2HEbhTOCMNM=;
 b=Y1EkSX9/ZK8Ny1SjvyNbBQodjQKLXSKwfrEfi+fO+F1zIAfi8gxTfZrKV0lwWad5wTtX8NXb1oYAbYTIobkWTVC9OWqegvWP0shAc2GvDKH9k6TtLDSjRAZlUMyt/v+oXKQirWBoZZWu1AIBjOVPPUVAsSSNvJgP2+bSfucu9WMHaeV/wAIszovYUPqaZOJXtv4XYCxNZ+1+raUAOw+Q74hsOJP5m5LMkSyrBTF5QZc2b7SOjUzSMzm+InfzVNZ/eaGrff1Y4RZ0wSljjhn76cvNZC//VzIBfJ7jTKj+Rl+65Sf28kVUG8PvgNRsPb0QT4v3IQjN6xj+SBSRO/S9xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhCb6A5jV3NLgPYPVuk04YbqhoxcOhDf2HEbhTOCMNM=;
 b=Z7JkEGmbdCzzADug8rRtTxRhGm/SyGyWnxnLsp3IOZ6WmBYly/7sseW8bHjhQFEqUN+tYVvbZI5uUMBRxWzNxyA5kXn8AFsgo3cM5Gm4BMVYUrSpcjLGnIiOKWRbD2sZi1VeEj9tduKuunghSFkxtbb1VrkzNeaCQYgd9aipVDw=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SN7PR04MB8720.namprd04.prod.outlook.com (2603:10b6:806:2e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Sat, 13 Sep
 2025 06:32:44 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9094.021; Sat, 13 Sep 2025
 06:32:43 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>, "hch@infradead.org" <hch@infradead.org>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Niklas
 Cassel <cassel@kernel.org>
Subject: Re: [PATCH] nvmet: pci-epf: fix DMA channel debug print
Thread-Topic: [PATCH] nvmet: pci-epf: fix DMA channel debug print
Thread-Index: AQHcI9bLzMJ3Pmbix0+kvCts/z5JNbSPdeAAgAEy3AA=
Date: Sat, 13 Sep 2025 06:32:43 +0000
Message-ID: <ogwks5msrtiyjmmhkjqrevdzrnyiuuv4mvpxwitm4mnkwynrh3@bxoqqljwid5r>
References: <20250912111703.676993-1-shinichiro.kawasaki@wdc.com>
 <f7ee6332-60e9-4a1d-b1f1-296066ccdf55@kernel.org>
In-Reply-To: <f7ee6332-60e9-4a1d-b1f1-296066ccdf55@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SN7PR04MB8720:EE_
x-ms-office365-filtering-correlation-id: d330371d-b7c3-4967-54bc-08ddf28f5878
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?Za4z42+aVY9Z3ijKdekJ8n4/gHmmCYgf/oKQzw4Do6hI3YfVqP05yDl3+2vZ?=
 =?us-ascii?Q?KtYyGIRVYgl897TmO6fzyH5SqKQ+irS16xaXjrh4dgDb4+c+917RJSgEfdxV?=
 =?us-ascii?Q?rpkAzspRXyabzd64HzcLMsnQ1HZ4ppWQ7SvUk1M/oLx8ws+Jop2fhNW8a7cr?=
 =?us-ascii?Q?Yvu7egmhqCicLBUWTMpmPKpjpdVuZxRCU1E+ZlXD+sn7OXgUNBfzi4Y8m9uL?=
 =?us-ascii?Q?4JmFy4QW6n4Zmm5ruFsKqGJohZY3F6EvV4UKbOU2WVxyOtD8BbM3YFpJZJEN?=
 =?us-ascii?Q?mskjno++uSSAtXWCyFE1GoO0JH1rnufyPYFFTtr6nDqIeSbrRczSlP49ubFS?=
 =?us-ascii?Q?77Cpx86TNorGBF02Ow6FYc1IquwQwhIXrCyRpTewT82m/xfAaqL7V7gG9FqV?=
 =?us-ascii?Q?+pJsRUm88zhGi+eXBnxt16QmJJOrr0N9AB8G+81eGCGCt/EOsQmA6DpPCWTN?=
 =?us-ascii?Q?wl6NtExMwTZtCmYFxa+53JBnFRs61Ep6R3SanaDQ+rWww1zzuQ4AiPxkrNQO?=
 =?us-ascii?Q?Hp9/Iq8m6b5nMlwOivtxdEzI7lrF15qgdmU5HxhMNF0XGe7QIgp84ENTpEE6?=
 =?us-ascii?Q?OGGJ8QCbbycEU2Gmk8c+E91DxnKbkuz55XsR93LJkU13sOAClBz3wsF0ag9x?=
 =?us-ascii?Q?aFvIF34w2/Dje81p6Iqyhb3DBo8h6L/1PaB0C/4p9tuBvV4UTZ1ta4Yb05a4?=
 =?us-ascii?Q?7CkeEMy8OnlvqLHaGuIBMs+o8pa0odo5JEDRKxqcYYwkML7IWZ19vcmKGkuc?=
 =?us-ascii?Q?337V+alafwH05XMUnOg7hpg7/pbU8qI2AuMXx9Veaa0AQQceK2zagpdfm7ca?=
 =?us-ascii?Q?uu8icicUrAeHlxiOyT5gV7jnzHk/IT2lv8njO7+bZfD/Woo2b9UgFCReIsrN?=
 =?us-ascii?Q?T4H9jPC2cUlv7GbIJ2zho/BhNof7TlLsCtl92ABb1cv4/f57CrnIui5Q2PDi?=
 =?us-ascii?Q?z7VE/wPNaKH2MRqvOZ3NdlC/zGEinQymeRuCkvYVlM3aVb3yiCPR9g8jalK4?=
 =?us-ascii?Q?oEoo5nJWl4/tQswBESpgVoAjpPtA9bn3Oo2o0XrQEqbXai/5WxrC5I3vu+SF?=
 =?us-ascii?Q?WtRmwinVSMQhM21IqsarlzFiSgKZdHKBZadXBOdxHrAjdJrwA753Z9NrP/BG?=
 =?us-ascii?Q?o8bSkEyJikHMtChW/mxR8DJNwrALGauaZziwRJfAestRUGYUkQkOpLmuVhAf?=
 =?us-ascii?Q?gZx+sCDEKOf2mQDDrG6gFUoqy/POvQ96+7fmBSy5eiS5nFzANlf0cZ4B3IyK?=
 =?us-ascii?Q?hG4Hip8qwiIjo7W54fc+pCTlNGvQGZn+Tw9Ue7cLyA6W17UNmml68hH77sqx?=
 =?us-ascii?Q?4oAOIAgci832TyXSaJDF3WSlqi4IJF7ZzhYsHcfXcQL2Ld5pgmK0NAWod5yc?=
 =?us-ascii?Q?eh8aXBuhXg2rGGwyLhoo5dyvQlAYw4Cavx+uZAce+jTNqlJYIU1e/tLCP/2K?=
 =?us-ascii?Q?ObdU55ZJJ5qUE3mUWrWFclPUOilrEYUIQ2cJEgi0acQSEzJxrfIB6ugNMMl5?=
 =?us-ascii?Q?LUF4rrdzW4sIEZk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nwmRLH19uxwWfj63lyNPFrgh4CZLBKT82GeV6JKpV2wiIgcUTEDtMBPhgghz?=
 =?us-ascii?Q?bOEQ8luJH3ittvbpdrN3Q+RYJgFNP/3v1a0E1Ex+APtHmZfgvr0Te4k2W5OT?=
 =?us-ascii?Q?kHAm8ZWywyhvyp/zOXnoqcpBYJl6JBYWIO3/prwY4os4ylsAOjIPSOgl1QsU?=
 =?us-ascii?Q?9UA45zLH0QC1LJcDUYezMYk7hkmLWNtjcEObMWglfDMXEvavGAXH5afsKZeo?=
 =?us-ascii?Q?K09goMy8hLP14peRz9fRaq32attzw2t4bE/YYl3BVo4Jyu0/Dfueuk9eYi7g?=
 =?us-ascii?Q?vXC4uQvUqrqTcd/A+HaABNRnhrLLA6t6PSD9moobevDy0/1C7FqZsxAnaLJk?=
 =?us-ascii?Q?0if9l6mzAzryy/xrrxPjDY2P/w6XecoF59M02mWJirS7WXSBoa6f+0zkd0Qk?=
 =?us-ascii?Q?Cy9uJ6RHmyt8X+gQA6r8CEj25j88VL7bUhTT4r41WOI5eSx834o+Te0gpbaA?=
 =?us-ascii?Q?e9rwJE0zWMcsB398c7VAp78RZFOHmGDg62WXBUCIorGAL0EV9NOXIUYzcT6O?=
 =?us-ascii?Q?WhkGtRwj7AFEl8CaR9O8/COdfZtKuYt8O+04YlEoSPVFgf84vKSL65TaoUUN?=
 =?us-ascii?Q?0b2GbdOmLiHHmdcA+wnuREJFu44Uu7DcJUnYaU5yF72h1agDBFJuzZqt641f?=
 =?us-ascii?Q?9zf5s0wgvXSzp9tetLxLWsa4YQg+B9n6MJvv90J6r8h8JyLL7tetDFltbVuQ?=
 =?us-ascii?Q?rUYGpgt2tBbMveWrWq9sHNkoWWzGA85EMKviuVOpNyrJXkPbcXEACcUMxXw5?=
 =?us-ascii?Q?ysWCk53bz88a1jTvdITSpQVB/W6Kp6+RktuFM8OvQ6VSzimiNDL5f6K7+5QJ?=
 =?us-ascii?Q?suOKUMeeHj/rVAVAQdOmpoJDd7Tx0V6TOlPUDxJSLgkWJ2eCU7hPY4TKujcD?=
 =?us-ascii?Q?pbjA3k+Dbb8VB2s+4Gg126kc5Oi+lUTRk6Kemb8LgrYCcwUiyVepdmiolg34?=
 =?us-ascii?Q?qB4/0Tq4GK6xzVG/GPGEcE2IqZaSVjC4b2g1QPWetWr1TiGBSi2vzDfONf1v?=
 =?us-ascii?Q?/Mi0IST7kHXk9zSOVEf8f0bTpIStkwHB2MW1WjrH87GKIvjzptxrDkETYVGC?=
 =?us-ascii?Q?rF9hxcAfrDiaNDGDdnKTKQBAKUEzRhSgGgk1BPZMWCU6EYcyqIaRMeWasp3r?=
 =?us-ascii?Q?mTstmMdLOxtNdbeqCq9tmtZcnWcnDeZaZ7AsUW35PFfzHS5eCYBBMkq7ieYy?=
 =?us-ascii?Q?narSfXCwrfXe78Kv6E4Oj3ObHtdRZeno4CgL6eE4SXigZdBwcBsBceLy61OG?=
 =?us-ascii?Q?mdPcJJYkB8GetsxLz9G5zi1jpULg2NRak/MmHXXd6cIJdymKPvAhbhMiELDj?=
 =?us-ascii?Q?ANm1euRRQCQ1XVFxz4zHuLwAG4nI33FCEBy64a/DTGjLwICWSwJWinCGZhdU?=
 =?us-ascii?Q?qejhE/3y8zoJBVi9BnuxbaVWgo8LswCi+qstJpS1EHeN0HoBmD+NVLLWlN0d?=
 =?us-ascii?Q?YKaEJ1p/mYFV4A6N9qUFy2P0yR1pYdCD3nHK9KiRXwN+5TN+x7CVmeFIzoGs?=
 =?us-ascii?Q?vojzYmVJ1y6G4kcBpPGUIpufQb9V4X382LExA1HvqpdvpEzyFpa0wBIWpQ+/?=
 =?us-ascii?Q?DXjKHhleHWxlSZYfqn9UdZ7rekIe095iO3iiUGoQGnxYFWQB/1F/yu+ZRjk3?=
 =?us-ascii?Q?8PXkrfsS2urSSsg7QIFVcmg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <749CC44563D80542870C0B471170DA39@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i2rMPu+92HvYIwTat2R+ADfspgemP/43mQ41onDIIROkqC9+CsG2QwA23hR5uGxN8z/YP3PgBtoCY8K6HyqeU3zbTuI7avtn3YDqig1Wn2J5YlLD6ZKcjGjYq/ATuCRSfSWVsDUX6P/dYprxmNazOxpBy0pyKj35eD7f2krWd9K+oG5GPm6zyqvTv2V0Qbi8Tf/wGWpuTfyP85e1Sm98t/L0oAKWggKvYZHliJL0p3sIIniGiNKQN27vcoI1xhR4pk1y9kkHBNoV3mNjIxBtVORMDD6R+tO5LZINNIrWqNCX5rHDMX2rU3QJlBCollATLo8Cc3dQ78U7JKTAf1pjlf5e5/cicNDT3TU5J2F8oEnrD7GHocQ6z9ej1u7SDMgx+7lEvxz8X5AoY3ezlA6AEwGqCZ/rmVe2D1HNBjiUkjwCGUkV2ZmNgiKF1rfwuhbVuQlzI3ZgCnQBmVrinTgU+4HuXR+kuxakfajjDhrmk1RcE/dREDqadXXdh4i2dUM1ROVY6eKl+e/ykYDgyXHaIc4x4A2llSxByrk0RuKsaP8KsFJe9Cm6E1zMJNZE8u/qhFbrZlcsLo0wLeljOmj9qHWzJUE3evb6rihK2YsBk7mGm7C8tQKbtBk3gV+Kl1tL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d330371d-b7c3-4967-54bc-08ddf28f5878
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2025 06:32:43.4591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5CnU3uKctPSRarNNmNc91VM/Ca/e2BJk3YUqj2h+YHGtp4bGp9xH4f0JFLLQR7WhZzcOsddlWFuzetZJCzKzy9TfRaS05mSEKT2sYw8QJtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8720
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_233249_801194_C109C2E0 
X-CRM114-Status: GOOD (  21.71  )
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

On Sep 12, 2025 / 21:14, Damien Le Moal wrote:
> On 9/12/25 20:17, Shin'ichiro Kawasaki wrote:
> > Currently, nvmet_pci_epf_init_dma() has two dev_dbg() calls intended to
> > print debug information about the DMA channels for RX and TX. However,
> > both calls mistakenly are made for the TX channel. Fix it so that one
> > call prints the RX channel as intended.
> >=20
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >  drivers/nvme/target/pci-epf.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-ep=
f.c
> > index 2e78397a7373..cee3ae6f5be7 100644
> > --- a/drivers/nvme/target/pci-epf.c
> > +++ b/drivers/nvme/target/pci-epf.c
> > @@ -310,6 +310,10 @@ static void nvmet_pci_epf_init_dma(struct nvmet_pc=
i_epf *nvme_epf)
> > =20
> >  	nvme_epf->dma_rx_chan =3D chan;
> > =20
> > +	dev_dbg(dev, "Using DMA RX channel %s, maximum segment size %u B\n",
> > +		dma_chan_name(chan),
> > +		dma_get_max_seg_size(dmaengine_get_dma_device(chan)));
> > +
>=20
> It would be better to keep this message after "nvme_epf->dma_enabled =3D =
true" so
> that it is not misleading.

I see, it sounds reasonable.

> So I think you need to have 2 channel variables (e.g.
> rxchan and txchan).

We have 'nvme_epf->rx_chan' and 'nvme_epf->tx_chan', so I think we can refe=
r to
them instead of the two variables. Will send out v2 with the change.=

