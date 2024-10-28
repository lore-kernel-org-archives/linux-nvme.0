Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1801D1358C
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 06:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rncKJ/oIq6lgf1riYk2RLB7Uy3ckvzsTd2IRPRh3crc=; b=pXURQGMWnMLLMqKJbtL+WU+O8A
	i2RDTSGF4Anr0mXJ8l013TK7DZkaS5jIWLDe9YLBcb+KsknZPwMkbDmvAeWEENQCnn/6jl/lZ13Kh
	SkZWqQciNGtdiF07QMyjUlUoWPcKO7svjmRrLMYOjc/C13I0cBkC3qBx8qgMoFbXra9fPbXQ3qtis
	YX+GFK35HuRMCVTLoLhFHlpJezZGvoXyIdq5gNpETgyAjtElKS2LLLHLw1JJCMu2852z8jKDejsbN
	vA3n2+RPX3/gb6Ah7RcUgbeiVMdT6/t8kmg+1dxLPFyupZpqu91yFlq9L/n7hmNgOBCVfVHJTcj8s
	gsDMhzKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5J6D-00000009i6X-2olN;
	Mon, 28 Oct 2024 06:19:33 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5J69-00000009i5r-4AWq
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 06:19:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730096370; x=1761632370;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FCv4/aoL4pc8+gXdlUCDnpn6GkewTwL5SWAH270NG3k=;
  b=X/kN8UjPUIROREV3kcN18Mwm9vwL7zwiPoygVREH/jhSyjg2qMPka3Nb
   HmOgf74ZZkp6VWbKxPNgUrRo+B05S9Xt8yTR4n9oj/o3IlMEQA1bdun/H
   pIUIMDJJXr/Jf6dXM3D3AB5AFWFRbuFQM7ojgLtEFhoAN8Srna5A0MVMb
   sEzEaAuxCld+njf7x6VSN1dK8r8JCKpbTMV8exyMVPDyM8J+YcJGpfMjY
   dDYG8YsdewlZeQYo4JeLgSmJ9r+U7rWUyd5sxSDBnpetnipTZ43yYezUq
   iLwzUhEmdUAZ6QDbaQZUIX//WtijR6D5uR7+uPhWfWVHex68kJMG/pvn3
   A==;
X-CSE-ConnectionGUID: GE+gcSYpTkaSFmt6J30arw==
X-CSE-MsgGUID: u1nqH29GTJ6uE0geA/Mocw==
X-IronPort-AV: E=Sophos;i="6.11,238,1725292800"; 
   d="scan'208";a="29407447"
Received: from mail-bn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.40])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2024 14:19:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0tHVhjZ7CVXSsYwtphAi+40cJLmfvB8n4B5b1hAG+e9Dfje1/49Y16fR2hJFtjLpizqs1oJkmbkw0D4oc/5vRvAAYB4DeGg8dJHC/wRx479tdUsdHVhyKjo5Fao5Pz/Wc/4ssF2lus03VlGxFMTW3hxQT2XKBgZf14B2U0QvXgfRTZkuV+4ly0a1dnKxA2plmOjq1Gn+Mu1x35w5LMOP8ZNDXBZs+rKhPCDgzW8Eu5oZuHlI51qxmRu+ZMXegIgfqkA8ohAbxWtqit5BLu4G242/cXC+QaKY+UWFigYY7A5ZLicWzUMcsMEEzPxglD44HYV11nnIF3p1CGGhZuIrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rncKJ/oIq6lgf1riYk2RLB7Uy3ckvzsTd2IRPRh3crc=;
 b=hxGIiTEMtrJfIqBOQ+iiIUhRMgrofrygcJVGltYI86rLP8ntebEyrM794iWzzVIZpuUrsrLMfr/L4HTdhng/g55QXUUWXIrkHrwmi8pFVNq+9kV5vEGFyj8SLc+WZ/ti7qU5YjVRmvydYMk8bMhPAi3/4IaMe0La0uqf8gZ+TrWXiT+HOQKjjbbsN6dBUmGk3RYfxXJ1KG1t7nMAsXVLOKs1+hc02jRO+cwGTU3fJcx+MVf1JPSMfn4zvMpkYVvnkX+1O3qHC/BHcwKoiTXkOzvwCVTM/ZGYMWuLZ/lH00SNDaOAeLc5NDp+96aI235KOTzB5pUWTfh49UqDWkfFqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rncKJ/oIq6lgf1riYk2RLB7Uy3ckvzsTd2IRPRh3crc=;
 b=pLTXvCt5tPD/HInb8lmBhQrbMaTYt8wHkwjdgx79X+QwObYG3iPuo+ExmF2fTcDTCg7WhuMP5f+5tA7t8gq2bzhWts9SVpmB+dptdBaAa793sSnV62+J/Pe+09wqEv1W4CEIc5QREI54AsMTDS5nFPoRYvW1MYjB9mRiQaa8Hu8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7283.namprd04.prod.outlook.com (2603:10b6:303:7f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.25; Mon, 28 Oct 2024 06:19:24 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 06:19:24 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 03/15] nvme: sanitize transport parameter in
 _create_nvmet_port()
Thread-Topic: [PATCH blktests 03/15] nvme: sanitize transport parameter in
 _create_nvmet_port()
Thread-Index: AQHbJbAio+vwQFkq50yasA6OjGKHk7KXhBqAgAQzL4A=
Date: Mon, 28 Oct 2024 06:19:24 +0000
Message-ID: <zmeiqm7c53ljymh7sovtaqxf4yqwlenz7z6zpsuqcg6xxjowba@gkq4om32lemk>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-4-shinichiro.kawasaki@wdc.com>
 <427d7965-0a97-4ad8-af46-02ef674357ef@flourine.local>
In-Reply-To: <427d7965-0a97-4ad8-af46-02ef674357ef@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7283:EE_
x-ms-office365-filtering-correlation-id: 78df8e29-2a37-4c8d-b9f0-08dcf71877d6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?bpPXdQL/LykEHTDyyJ1ktOM2KS6+Auy0LEzhSZ8iC0K8a9nOdgc/JoLEWCG7?=
 =?us-ascii?Q?lYJHWr5WnpYaGGMEvj19YxiHv5A75cTcUF+YX+zrwPnXvB+5kubUFCmx0fkM?=
 =?us-ascii?Q?GZmfBt+k6ERg+0Y/JkDlSe3wYdtt3i2upS+kjNzXCJjmTmeS4ciCy1xJqXnL?=
 =?us-ascii?Q?aZnEuIkMwTJiXqn4dFJn6ANFE5gEpCC8Mu444bWeLC8a8rs8fs9NYbbzNCk/?=
 =?us-ascii?Q?G60sifFNI/detbw8NAikler4ANaabb1TKs39vbShUYda1oGKWnvES2N7AwM7?=
 =?us-ascii?Q?6J16EI4EYSZyuQI2SjKZXmWKrKDUlN8ZV8iAc+Mfmb8fa8l6wzcKzx5bp+5c?=
 =?us-ascii?Q?ic9m/pDK66pku0JzSPwF8aqQ4DXbQUYnUAaY8IwElO6+C0FxZG/P8tvsc6Cd?=
 =?us-ascii?Q?zuIXY/9T9wj9TT+tfA3OV6l95LD7yvwbVtDvys6s2Ro5zZmrbNy16EntPMYB?=
 =?us-ascii?Q?AN5rUH/xm/m3NPZV72tPff1FyPSFk1JHPCYQeAc/sc22d87BJXoXGXSb20sd?=
 =?us-ascii?Q?9bEOEsL7bK5Z+LN5kH1fSNF08Qaoo6egG6AesvJaGna4LVYy5Cp5IvTeC+HV?=
 =?us-ascii?Q?kqK0h+U7tG9Bu0Z0Jl0FYdNEJAdcKZEzGyNzB6kaDx2xpaoYib9ZcHzOx7a0?=
 =?us-ascii?Q?9Bq+w+ALZLgR/LhW3cqIsdm5OIaQ4a9LbA4aJo59nFsQK0TLH4Xb10MgaNCm?=
 =?us-ascii?Q?PDmk57hPssFEcnlfkH7VRYjJ+/pubFMFmZInRZxeg9dvZnS6yavNA2pRUYKt?=
 =?us-ascii?Q?Z3sx0FgzG2VYxJCbdwLR3IuM2QVhkFms/On6UX8Xl0i8jq8/tdCAgUAX6dfK?=
 =?us-ascii?Q?OgHYa4eVkRSEI0usUXOrQ6tRv0DO/TgfH5ley0hBxFiVUV3UGI803hGUukeq?=
 =?us-ascii?Q?uNcI0skFoYH/XuW6BMEfrJrn+VVNE73UixC2Ly1X2YBjRJq9rXIK8P1qDsGL?=
 =?us-ascii?Q?pj48y0jKUUZh9+mNFOUAi9dPOWJFraa2d8zUBi31TBcftR4wDekcIE+LdrZ0?=
 =?us-ascii?Q?6+Bb6e7YCiwgYRP8CPG5/gJvt9XnSP622igCl/LA9Va+E9qrDMTSxxNaBrzO?=
 =?us-ascii?Q?DqJuN8T4l3eSMjvCgTdXkef7tGRrwh5M1KGItcZS35quPucQFycXFhw1T4mG?=
 =?us-ascii?Q?6dPhmkIdRtg9U5CWj3dTG4u8E5RwwIilxzlE6w5ayQaGN/UkiLEtqYdMvJ/T?=
 =?us-ascii?Q?BmvQzmZqW1uUVXKuL12xg5JNhsWD7r96N5qBHl6fxlyFrTKyKINY6a5lGr7y?=
 =?us-ascii?Q?wWRSt+y2M6XZYj+L5UW4QrMRTfs8LDKp14xUXzQTdzO3qKmqZqB+/WRJAnPq?=
 =?us-ascii?Q?TO+zP8SjIn1pt+iswAhDje8BudXl4eBYy+N4rv8yHlbRpc3PDCqlM6m097We?=
 =?us-ascii?Q?yIbqkhc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8PMQnY1vRRKxul29exgB417LMTcD4M7ZLIgYiOaIXnNzx5o9NpxQrBWLjaaY?=
 =?us-ascii?Q?+bwJlaA1DVLEERtnZHxFp4EDrvu2BH2UsLQqV2sxhz0mc2Tglhg6picxiJHV?=
 =?us-ascii?Q?exL5Zo08YZpaWPH5so2vyIITHmb1wEZBNyj+Hc4XwkmlJvyh66lE8xlTisYh?=
 =?us-ascii?Q?x02rgqxGr6L2o2t7vQ7JdhWyOWYusGoZCR5lxtFB4nTuWTbzkm7mbqcaqZRj?=
 =?us-ascii?Q?IcNzLJsdeNJs2zsexPrOGuQiuM8FU8tzF05FP8PlJkuyyxqg59htW1PCPSZb?=
 =?us-ascii?Q?hwS+Xnd25EMNbiRk9czzMyU1r7Kdj7B4TduAWG7gmsGI+UCjyWYLdcmAP+Jl?=
 =?us-ascii?Q?H37aeuW3AtleX62tzY1fOr4fEH0PK2jcpaq3BoCI5jrCvzQoP2OnNBTWPiSt?=
 =?us-ascii?Q?qXIph7gAUkUmBCp/wV+jdHucLzUH7nHG1LVOUAruj7xr8pruVYhHtBNKq8Vo?=
 =?us-ascii?Q?NfSuZ7n2xRPko+QFRl5iKvVWbDv07xFtsl0MwWm0XRVionAeEtyRHad7qYgi?=
 =?us-ascii?Q?iUuPXKERpMLZEfj4636IInxdB/PrMdROWRa4xwsFBy6aTE9NZ1bR7tgDFLtz?=
 =?us-ascii?Q?+jqsKrWW3bDag3nSi6iwX6NlsM/TJpJx8FBeIgUYwsMIRk/2aAD+y0teiqmw?=
 =?us-ascii?Q?OXA5XDZ+/IlR9Ef872ozXrk2vuiq3cnv1uHN9cyrK4YmPwM+u6yeXpe0BLd8?=
 =?us-ascii?Q?sdiSrWCyno2AD5uy6KGkYv81UE5tX40U0T6bltZUqk5jMokmzPXwoUMAZVIo?=
 =?us-ascii?Q?6qNpvqqHGlbupOWMIAG3QcRZZhUkqaaI6n3aNVxNMctifI+Ta7pWUw/ke8pp?=
 =?us-ascii?Q?Y2KUai87MhuPzwh9Zoeo8A5pbXXPOJqySlEPpOt8pLHwwnHhjbk7x+Taurog?=
 =?us-ascii?Q?7jxcIZjlnnGurY7qCqiHoal11DWJKaGYmXnXiKHlziUOPij+njpDjvABHuP4?=
 =?us-ascii?Q?FShsduJIuBNUhc07VL1C/byvbjL5Go1chGrEiWBxwk7QejSCpaf1sDXNb5Uh?=
 =?us-ascii?Q?lJYEyVEae3P21LI0sVw5KtmDdc/ttc6zGh6qfC2ZOObg50aQvDPuMDH2IR0c?=
 =?us-ascii?Q?naAS8N0xfjrOMCC8ozP84cxllf2WXcxKSa3bLEBv+5m/V+Nu8SVy1oc20M3P?=
 =?us-ascii?Q?nmk+lkhiCjpr0rrIVW++CTVADY2ZgF0vYYmul+TTzw6biGaW7tfm6G83s/pq?=
 =?us-ascii?Q?iB+1cIzIWbFJTCR0GSxDLSWX19JjtQ8EdDuUcoKmwX6Dsu6OqIjO3Oy1IUfC?=
 =?us-ascii?Q?nvzFsG4mgVZNB05ZWv9Q3H2oxTUy3ntDjraxw44/nNzLRxh2zvPTZuJ5AT4F?=
 =?us-ascii?Q?82bmj7b9eDQvvxmE4VXVwX/vJ/hPEKAE4Hjllv0V4U5cI1fTZpKci8AmwSbB?=
 =?us-ascii?Q?HsOaXDqymuFPmIhYmknqhmoZsW3kBaxCT5LYwjY/P6noi5KAJCup7MY7Fkvk?=
 =?us-ascii?Q?YDrsnM2ZSYo1303XjizYQFtBOuUrqpyeW1XGtFH8K70N+ErY3gcN/78VQCO7?=
 =?us-ascii?Q?H8b9IGgTegdI2531x3RS/cTJOju0Gi1Wmd9+0PZi93KmTVWYR2532+55kGLi?=
 =?us-ascii?Q?L5DN4+l1bwniqLvMvEEuJ2fI3kuRJTu3c4IinTAzWb09TXqEQj4W9+5ITVW8?=
 =?us-ascii?Q?HWPnD5nRfXANsE7K5mq5W1w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38898C1593B1E34295372742D6AC50B4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vjkPvM5zDSsaROV4LVVX7cI1Pn3CEY2uzu6HDt8RovOhdZ+lRwrmlX4gLM1pRvvMxgcjxfSzXb9nofa8JkRAsGQGiK9+/utGVq1y/2Oj8bz6Ly05XagaVdpoRQfDyC6cAwhbADBS3tYFgjBTUa1nFGJoFYejdym8H6iaxemFgfDX1u0MVCZaMr10m7D/VgbRkRtNg1z6yLS67Z/WTjsF+damrC21znbH+RXlU3qHHRfo8l2H5ueymwq+tthE1c3rCUspHyytXucojATL0Ln7ppL98gjO7ADnqEdgWCChe0ki6QUm0LtYNvgQQWe8L1gWYL04xpK48AX/wxLJyk0//iMKrAMELbjhzGJWeHkz3jV+EaEkPnuS0rBePDQHU9/krSDnv8kV6cPy4Eq/E4UK3j3lHVxFAjTHR79lC+R7rqMN50vrztwGyBTfPWOJykXqtPKVEkXMHuVKdnSuOjYEm3qnbfjUhGrLxGxlfos/HjxbkOdJOxcdhsk1mWjfYa63QCebBBJFn9pBeQhurvsYN5wq3Fk5z6hyKL1ElAvcd1hTGiWFZODqkuF3WIvImzwFUql8wbkkD5TFX0Hkdq1qeqrEeSd2ANE7t6SBZz4t+kfaD/L6k4EkfFpk5lDwelm8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78df8e29-2a37-4c8d-b9f0-08dcf71877d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 06:19:24.1365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oxUmOiSYXmzWgRVeqUvPPDhoMvBMwbidrFz/taWdFXkU157msXDYyCn3Gr3PMauDt5N3NfacnhDtbUd52964Wu0M1jqdr/KwddEAGIA9VZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7283
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_231930_858299_92F51466 
X-CRM114-Status: GOOD (  14.66  )
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

On Oct 25, 2024 / 16:11, Daniel Wagner wrote:
> On Thu, Oct 24, 2024 at 10:00:13AM GMT, Shin'ichiro Kawasaki wrote:
> > From: Hannes Reinecke <hare@suse.de>
> >=20
> > We need to sanitize the transport parameters in _create_nvmet_port()
> > to avoid having invalid transport values when selecting a transport
> > type.
>=20
> Hmm, I miss the important point that this change add support for more
> than one connection (ports).

Agreed. I will add a sentence to the commit message, like,

   This change allows the function support more than one port.

>=20
> > Signed-off-by: Hannes Reinecke <hare@suse.de>
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>=20
> Except the commit message nitpick, looks good.
>=20
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> =

