Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F5FC02198
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2025 06:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hjKFCQeT/3jINB8GzD3Q6z7yMAQIHDgBa6IXzUWA2y8=; b=R1B564cN7XLYyEO3CoX6UxtVQK
	Vfc7mGIEU/04It/QbLTAoKxFlpOLuSnJ865Sq1CexDbYzV2lGst3TYGpc5888pqyQwUFWFkFHPoEu
	0ubvmQELnGm+06U1WUxv9YQ9WkCIF1aSGLRO4i7DdLN1tVrV+pqakMnqSCnpAldgG6NskIBIIWPpQ
	w0pek/9IeYPmrjrk9zNfgk9QqvulfwCm6aTPFQw84BOgwdluivM0M7hJ1/blp7r/N3+XeCnKkUThU
	EinfmEy7T2TaQnR6tCwPieEsgPWiVmspw49UukXY11QpgsAFYfpHNCcJeSfSozGTWqbIXtbBRlNr8
	kGpRZYBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thN3z-0000000GLVR-2ZnS;
	Mon, 10 Feb 2025 06:14:35 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thN3w-0000000GLV5-2TDb
	for linux-nvme@lists.infradead.org;
	Mon, 10 Feb 2025 06:14:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739168072; x=1770704072;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tRwVxSVyqsiAGCLg6otRTI0fCosTUmBF6IpY+kIKWQY=;
  b=Yggspj7HWUw4G5KH0YbTK/D+8gqNc+S93bBW1SENiytySi9tzREEE0YU
   zNfa3PdBAMbJdjmR+UfwGMrPSYquZXYEsMw0TC9TSn2DnQSVkx66+I600
   7eDpBxYEAFX1GSFSaj56UoWNEvA9r7UKfIZTd2pmsFQTf9GPZArA5FsX4
   uD9dJQEEOEvveOE4VVhSxmqfCUhWkR2LujctZgP1Kv+5rnpesigIjXZlf
   WYrxKbgcXS1YJwbYMGk84I2GN6lM1xeXVbVI6TcFIhNuGuOUR5wCwE5sg
   90Y0oVYlvkLTHfHW8o7TxLu07sBTMhyNLBLYH3pY4yhlLSefMsfS19For
   A==;
X-CSE-ConnectionGUID: JoqXCFBeSVaGLJb7q69V0g==
X-CSE-MsgGUID: 0k8CF3//Taqz39TfG8/ToA==
X-IronPort-AV: E=Sophos;i="6.13,273,1732550400"; 
   d="scan'208";a="38613424"
Received: from mail-northcentralusazlp17012054.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.54])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2025 14:14:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JvM7wxXclmwwh6HG1EFKu1LmrzYn0hsA7TMI8bW4PIN97vDed54xIX18CVPOY/az0F6nUQZUg8p4wkP9WiziTIJg4nEWlmBO0eBLAh0hN7p+CrlE9yk9YVzrqGP67Y3su0pa4yq+XEo51K8u2VY+eqv4irtmHr8ks+mmw2A1ZJ5zyueSwCZb1iATA67JYawakHkmjzKlgw2MKXXUEoGypgKBbdC296ajwcJWpd0yIhkvu8PBpVPr2YzBZhljwFVFWqn28Inati3ZSxWoIcgPrBIhW6nfdH72yzyQSneKzuNsmVj4aiv/Hr/J3g0OE+smrP/Vvw3fYrDYCAaLKRqqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjKFCQeT/3jINB8GzD3Q6z7yMAQIHDgBa6IXzUWA2y8=;
 b=VUA0tKw1aaCVHYK9cdRZUFhk/hNkBryssVp+TPykz2wMj4VC18L6BA44IRxgmBMifF1iGb2ihb9YzRCSkTxcM9jFNA1CZO5eKUzdIoBVhtL78pp45m3RYu0fUSy8cz6ZejaSKPHre2YdgKcZGC9X9s5EXGxkIeM7U8dSntBR3l1Cyzl7cDCAiAuuKQlIKfg5BxVTEUuANemOvhbbWER9kk38EbrYRSyB9JcjCBuFpWBzmeKp7W7zhBy9xJVY11usMQfvQcby6IBeOXxZKazsKo+dwii4xKSd8m2qZPPlio4pDcWSmeyk6gOlQf42RgvXqUUNscFzLe1X5ejd6+i2BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjKFCQeT/3jINB8GzD3Q6z7yMAQIHDgBa6IXzUWA2y8=;
 b=AJ8FGgZeKUPcnl+Yz+rA45FlmEfMQy8iqTmnKrwZjzYi1U3Hq87aO9nxVuTPVCWMroEZytqtVZ5pP409e/0KNkKXUWLW+A991ol33ZAwVLYauXEAKqK15/4MpnrXAV9OMeSwKOMu4oYYw9hg2jrtVq6ulXa1rxy5YBrOIo1p9TM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH4PR04MB9106.namprd04.prod.outlook.com (2603:10b6:610:222::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 06:14:27 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 06:14:27 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@kernel.org>
CC: hch <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCHv2] nvmet: Fix crash when a namespace is disabled
Thread-Topic: [PATCHv2] nvmet: Fix crash when a namespace is disabled
Thread-Index: AQHbe4MJg6RecYUUF0iWjl+t7a5//w==
Date: Mon, 10 Feb 2025 06:14:27 +0000
Message-ID: <mgwrdzxze2acmxjscmorptkkrehos74iuommxgzvqxsqxhnm7b@bavc4fu4t6e6>
References: <20250207124134.114622-1-hare@kernel.org>
In-Reply-To: <20250207124134.114622-1-hare@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH4PR04MB9106:EE_
x-ms-office365-filtering-correlation-id: d2647899-e5c3-4bce-7de7-08dd499a2c7a
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hU3WMJG513Yp7/CtwI2xLdLov3Sq+Q80MBIYkQpwl3pzNieWaRPcGrAD6Ced?=
 =?us-ascii?Q?ZqCo48La85n1T4uew16K0Ln+Wu+xff71LoEKcFZE47Rg813IfBUu1Y3F59iB?=
 =?us-ascii?Q?z3VH7gtCj37Y2fMyj1rTjBx4HlUiwQZMNAvpyptN81ljNuvMhR8tN+kMTcAo?=
 =?us-ascii?Q?i31mF8iX1Q6YXoaYwaCkuCCzCLcsLDwaFU8T5pDCu1IwZw3AX5wVlqtxo9YT?=
 =?us-ascii?Q?EQbuyAcBVn6j5YKoNJLI5FZ1TF6zkrKgtrlQmKV37AtXjRP0UeLWxwAmTjuA?=
 =?us-ascii?Q?7fQohQ4NI4XH2ul/MUUv0NCNCFwYvURWK7FnrNKxTbKzrOtjP2MEcsqOT/5z?=
 =?us-ascii?Q?RdglPf49GBofaUlQ/uy3lzgyBhqXIWagYS9UbU4olnq6hqNZONkNV8jTI9MU?=
 =?us-ascii?Q?iRzRZMo4/knKw2QY4lXlpfCl9uJ303deKCpJPJOaWUNzjkEl/RR+VZYt/LXb?=
 =?us-ascii?Q?9fA4oA4lhu5BA2Iy9gunycnWK2Oiw62b4PMfiA00ACR1C4TV4pFcCDXiPIFm?=
 =?us-ascii?Q?WnmfprR1m9H91oF3zHkQe7Clc8dtjNLRv55duu42L11ExpPnK8MaITkRGfeM?=
 =?us-ascii?Q?wolHyS1RLSQnMUyUgQ02w2n1XfaNJzwYVCfrubRpx/ZX9XCuuGPHRGIdNPJ2?=
 =?us-ascii?Q?z5ZbEHmsNP7K4VctJFgTHVN+K00LOOT5mNJWPNY3lc4QV2DidWo36CNlslvb?=
 =?us-ascii?Q?ZK+psmEXT0/J92NKgefDEXzCFY0tr+dXkLcxYkw+Pqp3Ww9ZzDL+zdVz3LaP?=
 =?us-ascii?Q?80BQTNgVlKqdYOJVxFjzAfi9zuwTnzfnP92za3luqwh1RWQ5C6BM3ygsSui2?=
 =?us-ascii?Q?sI+afLMf9OQCcqFZ1+gxdF95FOkWtD696YWRQ7VdbFY0Jyn1rhPgIv+wXu2Y?=
 =?us-ascii?Q?tvUEgTYqqjBx9PNXHzLAsNG+kW1QuNT929lQf9i96BBTO65m5oU9hpC5XJ2Q?=
 =?us-ascii?Q?Of3/CTnieWXhuSjSMrE+rPVQNN2KnKPSfUUQHjtJVHsWy8zl51YEgTOPlX86?=
 =?us-ascii?Q?Do6RdHg2rORheHN8OkxTl915Gd1BEXjCNvduMElpPmVL361fjS3onLOjmVHt?=
 =?us-ascii?Q?84UiXU3/Thl8EI3jdGsiUrjyNOrmZSozPcKuJ9uGPmgSI1i0L9RBb5aiRu5M?=
 =?us-ascii?Q?GerG8vDdrqxrKGHb8N4J6qmXpk5yD8QIX8ZUXVPD2ZqiFdQMEikxPXVOPn7C?=
 =?us-ascii?Q?9z1X6FPGxXLr5tIGZnmKGwUwtQTphr85xg4KxOUmfP3FBqhEg6uDxqkp/kTn?=
 =?us-ascii?Q?dQhDhWssh7c/kZM26kFFLnAwcCJ+VOdJS1HIWyaJAcI7RjwvaovKaL0iLOwD?=
 =?us-ascii?Q?IffxwXj0RKbQMMu6LgYhUzOZf6s15rMHvAHlQJrmKuxvErXWPg408URWkhyH?=
 =?us-ascii?Q?yVN831COtZKAR2eocwZuLSxJDeiF9FtFySGmB+oO4YWrpM53U9qMe4oSpwt9?=
 =?us-ascii?Q?QxIM3RTpA94XRMSZ9eOWOKiZ9rMxF7XM?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aGNFl44RGHcQLUywo8rFpWTsakWVkxlRSyS15C8fpDM2+rlusCoiZ/+UWlaR?=
 =?us-ascii?Q?nnA5Ku84cQR7vOgRVFgpahUerI1RfCdjALo6zKkiuKU6gMaof/OmOccbNRFp?=
 =?us-ascii?Q?aDmk5p25f7TZ4y0W2pM8qFNOBH/bSVORw2cueRk5qnVvEYdjqqUredJ72YLv?=
 =?us-ascii?Q?t5B3m4xsE5D4eZE3mppHYlwCKj8KT2HF+KJs19RqkFXHUlz4k/8KnKclmNUQ?=
 =?us-ascii?Q?O22bheieKlvMWTemR+aIPOEHsaGCGytfa8UWCrm7pdopjycU0k1fhGmy0cti?=
 =?us-ascii?Q?VcjEgGQkn99n8XhARnh6v0JWUA9W2zpnJ87wHbCIi6C8tEsgwe385jtNcJHX?=
 =?us-ascii?Q?jojO+0Huud0pNR1VxNXC/1a7mYWEuROtvQbVJhld4lL807EvwVJk9Bx4jIYN?=
 =?us-ascii?Q?avD3mA0vkhUoImOsekOkrz9OccOQqsZTP2Adwg8Pl8cMZ9+aIt6kORteYgLL?=
 =?us-ascii?Q?aNrR+4/tZKZ5NqTr4qbVwMurd7BTouPvRYUb4XEzANHOmMbf6FW/xeiUp3gk?=
 =?us-ascii?Q?z6WZSt+QmdXxzAA/Zf4cv9970O9k6B32bU7NZrMu8vVdyH0OCoJj/D5yJ9Rj?=
 =?us-ascii?Q?PzCM35+t7o8IBD4rGwQxv02CmojSaGZdWwOur24kFHDmJ+mwQNHFfqqIg4ae?=
 =?us-ascii?Q?HZVuxXtxEpeELmPWOiwd8hDToH7h4KkImthWIhLvKiGfgJOrvRIO06lPx7xc?=
 =?us-ascii?Q?IzZCwt9Uv0vRJIqKj44Smesy3jTjdb7/2XNbyXm0urLIBf/t5JX2bvlQZW4P?=
 =?us-ascii?Q?5EYhWQWHLJnXti/sHAO00bX7JtZ4GMNTcjQarVQErkk8yfXWYQVoxosk5PEG?=
 =?us-ascii?Q?BZqInowuhGSSCITheQH7OBJy29KRG1AC8HuPQUEvyT5uSWViDuiEoUpCa9A8?=
 =?us-ascii?Q?m7X7eI4j9yDaOKRn4vXZCX4I8qb9GR5W7CrmStabTjgwb066nHHPispf28Ke?=
 =?us-ascii?Q?0j4L3bPki2TDu5Uyjfe5BabU+SO4aPLSmzwX73+ldrz6K0iJoMf0AWF/vXQn?=
 =?us-ascii?Q?7sRlia7ZVQIhH7EiciJJdsWm2serZuhqr5ln0ZGQFam/RjwGn61aw7iHa+5X?=
 =?us-ascii?Q?aFHV7vaareiIX3KRLvRUaAoXBCAOanvTFao8s+oFt69am+PmZB32qMhK6KtG?=
 =?us-ascii?Q?O8HTdXgzdKnucMJHhqtVNCDTm8nqOj56OBMcHCiEV13IlAYDKgPqVK6M6xSt?=
 =?us-ascii?Q?tDw/hmsh4jOpBi9VcfOtO5+wOIVAQ15oGxjHLEAZTQKcBtD0KHyTDqozEvWl?=
 =?us-ascii?Q?91JXaaUNZ8EzJu5v1NhWWcpkPgS9WhiDD7C4XoQnWtF9jc8wcT78iBj7kwfm?=
 =?us-ascii?Q?6GBSPDNssahEsX+4aGEYbKRbvHl02m7kunqpdamEVin6VC9fFvroUDp+DTtg?=
 =?us-ascii?Q?PndbhVpyiEgVsIw8vgbJYRXsYEW2ZkNPEZygu2bevfiDgAya9UItCSuKBijX?=
 =?us-ascii?Q?KJheyUi4cEbSLsNBTsGlt5Z+SiRYsQVBg8jqnL3OB+nBkMYYLd0jezynfFQA?=
 =?us-ascii?Q?Yc/E5Bc8TdsC38HkTLXKiA/IHSufRIa9NUaQNWCnswluk0YsNzOh6Yo0mCcU?=
 =?us-ascii?Q?snBrBzrf7QrxmY6wXWiA+XI4JeQLjWuns79dNBGH6qLDs5ykQY1pTqtz5qwT?=
 =?us-ascii?Q?UR20ZueZCbUXaVSNCHGClr0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5B60F50893A2A14099B2551A9BBC59E0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mYcAZ4RLpmTGhK/044kV/dN2/K/mriQO+bK9FAvs+u6EgUH2VBLJfOCdjk+nSvr8cEsHNjLC9Fe1qw1Yp8YmH2+2KGhkUJYf0tFYWWz0CuHkxXe3IaMJYWQ+iYuCckQY+mcqYcoEeVLVf6okTwQ4C4Mfoyl/7PBFdasErs/8QDF20GjTnqwbZchJO+3iP5qyAQU0HcMgigMz/JbuHiLPg5kHd8UnKSfiYNzCXSKvR/TIugcnqeZB0AZrOq7CSKUcZCZ56rHXPUyelWt5ON6HPDmCF3fbhYgbcQBk47ndhybFg0uqJXyYij1RFKKT5QegEdTppa3kMDElTc5v94vRcbs0EbHll9AYkw+fVJ1xBYeNLhbhzs0nYzvCf+J9JWAclXReMsLD7+NZQomDU3kxnr2ysXECyOmr3DOKwdcgL0eCR6+eYnVI6wD1c2cVxKTfZ2C+0QqL9kKE1gVqidoj/x8swn0zrLv9+0/vJGQoJnViCMVopGBKNfVnzrZnVEwATTyq4n2cGB/hXsYX1o8CmiO4KWjkJgMquNimxm5tslhukDZF6Rp83oLcpRAyu2wHx6M2CyLYjKInfuNrvN+2FczSaGEsAKaJ4KFdNasuhhlVRwQ2yKZColOTQC5fNl3u
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2647899-e5c3-4bce-7de7-08dd499a2c7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 06:14:27.6427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/H9KYUJbD5qYc+bc/E9cGfUHgtMxrlAoTyRtkEDfzKbRkFMtml/95IbmO3StvQtcfkB6HThe22BPNFz2/LmFIuyUSz5eV/LO0T0ZJ3Qo+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250209_221432_716759_DAF54E66 
X-CRM114-Status: GOOD (  13.41  )
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

On Feb 07, 2025 / 13:41, Hannes Reinecke wrote:
> The namespace percpu counter protects pending I/O, and we can
> only safely diable the namespace once the counter drop to zero.
> Otherwise we end up with a crash when running blktests/nvme/058
> (eg for loop transport):
>=20
> [ 2352.930426] [  T53909] Oops: general protection fault, probably for no=
n-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
> [ 2352.930431] [  T53909] KASAN: null-ptr-deref in range [0x0000000000000=
028-0x000000000000002f]
> [ 2352.930434] [  T53909] CPU: 3 UID: 0 PID: 53909 Comm: kworker/u16:5 Ta=
inted: G        W          6.13.0-rc6 #232
> [ 2352.930438] [  T53909] Tainted: [W]=3DWARN
> [ 2352.930440] [  T53909] Hardware name: QEMU Standard PC (i440FX + PIIX,=
 1996), BIOS 1.16.3-3.fc41 04/01/2014
> [ 2352.930443] [  T53909] Workqueue: nvmet-wq nvme_loop_execute_work [nvm=
e_loop]
> [ 2352.930449] [  T53909] RIP: 0010:blkcg_set_ioprio+0x44/0x180
>=20
> as the queue is already torn down when calling submit_bio();
>=20
> So we need to init the percpu counter in nvmet_ns_enable(), and
> wait for it to drop to zero in nvmet_ns_disable() to avoid having
> I/O pending after the namespace has been disabled.
>=20
> Fixes: 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")
>=20
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

I confirmed that this fix avoids the blktests failure at nvme/058. I also
run all blktests test cases and observed no regression. Thanks!

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=

