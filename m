Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A568DC25B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 12:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LzE9gsPWQoxjApxR2WiaWvDJm4H2dNJ5Tzr28mwWC48=; b=k4H0HVulgnWMidUlC8BDmqsyup
	5QKpgQLg/CL1bi9OhK0pPcZNZu0zTjdVy+ypK65wUZngokiP1+6tB2ETELFCDlCrPRgLyx3O1IQde
	bnRUBdjz+5VptfRvadpj5eqqInmAmPU7NRwcJHMH10DQ4Ob3D4sb6JWLF/J0q5VsTwhhJC+CowLl0
	WGgR+16L+jBBFBCJ4AUK+8ey67PjdCTWiZNguo3z7mQ9t7ZZo0KmPx/tyknySJYVpNZbvF/JyNITR
	Px1+WpJUfFSQZ7JDwkrONdRlOT+HX4bYjt9K8/FVBu/Fj4kn7tDUKDp1BNtfWQwRoxq/yuW7VJ1jI
	XNdkz2Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9kw6-00000002tHR-08cM;
	Wed, 22 May 2024 12:19:14 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9kw2-00000002tGi-0Y9k
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 12:19:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716380350; x=1747916350;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LzE9gsPWQoxjApxR2WiaWvDJm4H2dNJ5Tzr28mwWC48=;
  b=cGebSbFo+mbc6TOe0ftPtqtkglE0b8wJhKr+axi1/FeGNymuHWI77o2S
   fq2rK7SxBYJ5LFwCX5VLqETBHC9BHSBKn8tqlKGMhH6RW+xIkcYcgC1cG
   gyEN5Ei6vREmSa1QQBVU30dVd07RuAfB3j6m8VdEc8G48mgZVQgauNQRX
   8L0FaLhPiynqTR72erCPVP9GK6jVe/YtABnmFcRtE6aSMqIql8O47UnCz
   va5orhIMINwwLpq/lSFNQR/fCiX1trFbZJDuy2FlX82ssSZQNOrzff2D0
   bJagX3ESFBF1sjc1bJZ7yrXlVBRXlaMsb/mBpfjjlWOVjPkRKGnRLPjC/
   w==;
X-CSE-ConnectionGUID: x9hOCGfjTi+gqX/HYFDbZQ==
X-CSE-MsgGUID: XF4tV/giSme9aO8wt/oV6g==
X-IronPort-AV: E=Sophos;i="6.08,179,1712592000"; 
   d="scan'208";a="17012795"
Received: from mail-northcentralusazlp17010000.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.0])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2024 20:19:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFSbamMI/T9Uqibcv/VjNUghYFWQVhfpYLK81bgSX15SV2UHejq1z8nwNfA+Q1epaucUHzlB236wLWfpXYLIno8yxgkROgu1SbQxKoni1yILFEHI2TOHU9lC5IZAi5s7oANjN8kQ6aiY3C8zR0cWlmx00YVr3R7cYkoqoU1k5etKRYBwGs+4ry8UwLScD/M3fwco/C94UTL3RU5CUPWM2aFHZY8wdcpsawQwITF5gA/Fxe98zR+iSjs7e5+q6kUSc1yRetvcol1PtGM2XVB4DPdRsjGRQ3m4gqovR2UYYJe/qbLUkba0UHRlRq+NbGr7YbJ/bL+KIXbUvpMddNttWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzE9gsPWQoxjApxR2WiaWvDJm4H2dNJ5Tzr28mwWC48=;
 b=S+8lSYhjAagPesGUZ4rKM4tQL0D+yre6raWHahtx/dOextaplu7FnVBe89L4XbnRag1zzoG9P/Y78iMHHpiZKYThTeB4+k/7u40YvSVC6vwqqkC+nDsoqXxHGNu9ZIX/UOcRs0ARPbCsPt4KDIn97QCz5eEphlvP7nkHGrMzbaTZ48YTkNlYdhp3aIZxss93gIww7ZuzPXnIX7dw9civ32FLgg/q5rWgZeUhTf3uqMi0U1b9k1IPUkDdWH0xZyRfqqCAZ6EQxHZ1R1aECQcSLxQf2/H4RY2HhmxN3WaXTriGK35As+Ssy68lDfSFI+9DGPN5QOlHx/ybe5mpsWOPXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzE9gsPWQoxjApxR2WiaWvDJm4H2dNJ5Tzr28mwWC48=;
 b=OirgAF54TMn2QPwiMrrFMpnYlnkaNOrLrEALylDfkQdQtQkcs61kM0zOJ0oTg5rkW7iqGrJj8EzUasal0FFQvxk2kYEqZTa5THi/lZ40j6nFIVj95Z92NiEbL3RUl1OVDS/048o27jrYeznuzyZ2G3kqjXoOxi5tpbsxiRYE6dE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7278.namprd04.prod.outlook.com (2603:10b6:a03:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 12:18:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 12:18:57 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-pci: silence a lockdep complaint
Thread-Topic: [PATCH] nvme-pci: silence a lockdep complaint
Thread-Index: AQHarCihVS5pn1m/NEazt6Jv2BdFkbGjLB6A
Date: Wed, 22 May 2024 12:18:57 +0000
Message-ID: <vjurqn5g6k5fkzqo6iz2rzkxlljrjfna3efgub3o24ol2yv55u@lx77me5f47gm>
References: <20240522091534.472449-1-sagi@grimberg.me>
In-Reply-To: <20240522091534.472449-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7278:EE_
x-ms-office365-filtering-correlation-id: 104aace9-0a14-4483-bdd4-08dc7a595b25
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?bSEOnD8OnFZwLbl+Mw1uzto4iLlyo0cdgtBILYaaeb1t+le4ArFFr7caq5eo?=
 =?us-ascii?Q?r5v34Zwy6rWxrWvTKI5kw96v1m6pK3YSVllIBRRwKuZO1W8qwYgZOm30Nv9I?=
 =?us-ascii?Q?thWHSzh7UBQezVins8AEbbHZVsIV9y9ZBrXmaBUJ10vsiJf/dE8WZuRwlH6T?=
 =?us-ascii?Q?WgcC106h2wk6JL05ANswweTGu3QvCdguqVj+QmzmMZYMRFFAc1snswsmkfB3?=
 =?us-ascii?Q?15YHNTaur63zOIydhkpFw9HWb9s3l7vz0zHG6QsG8mtSTrjtXWZdIzaXT/zk?=
 =?us-ascii?Q?L8y9XsWS59w6e7GyS7BNOYpvLpfMYftb5mQXm1+Q7jmzeA98cOcpdbalSRst?=
 =?us-ascii?Q?is/rW3JjPOkPe6E2LDrHEQuF+kZEY3RRHPcuGN/6/aJER21R6boa3tYD7BsU?=
 =?us-ascii?Q?oyuu/QCDLn97C+JE7OTMBFaS6xl3XMs61E0CHuvqtcDqBCQRGYFpFJmXXvjZ?=
 =?us-ascii?Q?Az6pU0Tn/6gb1A4unzTf57mbzTqaxvl9/Y2zlG7qBbNuTiO15Fy1OnH6QzxF?=
 =?us-ascii?Q?C7xhc+hnPLQ/p5WfYql+NKO2HoBX5a8dWlk7QYOZi0aMB1G42hjbHVqPfvS0?=
 =?us-ascii?Q?b48YNmuY0FNejjvnSTAO3164bm81POL+qaA8lwWVEniTbCY82E9NhvASYWA9?=
 =?us-ascii?Q?tmDqz3Az9e5Q6kYgCIN0cPiva0eJucG7zPlqrGRSZ3gB9rYrlZ0+xOl2lHT4?=
 =?us-ascii?Q?D6h7c7blOeLmMigQipbbMEsPZkhl3Vfc3hmzALJX2tY94WKFkT8p6o5dOKqi?=
 =?us-ascii?Q?DEz/gcuqm6hDDGm3NMp9mnQhCRJIoqw9Mfkal23Bk7TT4tjR6rV1CUVk1pEC?=
 =?us-ascii?Q?lYSVnGRuuajUxXEiiBey5isd7IpwgFWk+WBk2yTeTtHaYHmL0VPg2/PPHQL0?=
 =?us-ascii?Q?C+C7FStprZxc9iyOiujL+5OTObsEaOxAwd4RGWeqlG9DZSqQQ0ymE3H8Yzqw?=
 =?us-ascii?Q?hwBFZyejAtAHmc5kAKWftPTI8fgt5VmTRBQJqCitCqe0lVSTZp+byCukcMJB?=
 =?us-ascii?Q?LcBXH1nFH/KSZDPnNRqVadfjMNwAmBcSnVu5XhyUtf2KSZ51KyZ4ZwxhnnUP?=
 =?us-ascii?Q?koNaybLGOZBpTpFMS4Aw3FW8Df/kd5Dkb3DGGJZTjCZ6YTbRD/+Jp7PQCSgu?=
 =?us-ascii?Q?+Mqs/TgyoUAoK0wUz5maEwXX99hJ3h0bzeP7FDz/AIMk4EOkt4DMP3xnuBVl?=
 =?us-ascii?Q?ppUP4cOfAtyZk7Tu1nZfPExfIeMd6UIpD0mW5QbZ1a5WRSr78c6ywL6WssID?=
 =?us-ascii?Q?adPRR9CaELbfSKMW9ko9x9GHk+oyKiIDhzAi1imlTw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E66yjkm/2X7B+bcG5Huwp1ivvZbuPq00timC5mbKxTCL2N5hc1trn1jVbGjm?=
 =?us-ascii?Q?BGqf7TATNpElRTZX4d42ugUwpHkPJwUcr9PLDyvtzLs7srQMC2q+HKGoeaLX?=
 =?us-ascii?Q?5vuhrjnC998teUurj0CCXINuuAF4zviojoxa4pWo1jIrUHdmdCqafQgRATTj?=
 =?us-ascii?Q?gNJ0rEFcKGnYkPKqIiyhAWfwRios8WCwx/gGBHpp6QUm+zm0wNqByXBWhRzh?=
 =?us-ascii?Q?jwlqjB6XNOwiX8s4us66YlPSweOVlldQ0swBMTg/7szxqW8sFnpe7OMjGgUh?=
 =?us-ascii?Q?UGWIls7FNneLWgcq8oJAQZLyOfMyPxo+Pc1QH6zSn2DzdyX4WScHbpilFMpx?=
 =?us-ascii?Q?AEWA8lsDa4k6oVIjETFGBaIAQbYwqp9F28cINcQF5T+rd/zVIIqteuj0gtAa?=
 =?us-ascii?Q?prpyRqLescME76X2OQvoVkbArdBuRFWe4u+0ZLr29QHor0ueI4pksd0Of4IM?=
 =?us-ascii?Q?wrCMI4OCZCwjUQhXMJMqd6EYd3+IwFYGbdc9rGPqd1d4fe89rsOD9n5lojKL?=
 =?us-ascii?Q?gH7BLySz1lAqT40X5i5AjRWOkxP/lz3YZQyXG96FUQPLNZ5f0YmITc4vmeB7?=
 =?us-ascii?Q?mOaP7S4rXR0NfZWPaKfyG7vnh5/ZtEuSUCMT6LUJ5+2i/BRL3olLyHmc34Nx?=
 =?us-ascii?Q?VCAyPScL+x63yyoEriM8/hI0qzpzmDG4wYzZ3S9b6F5jhWLj6ndxS/TxPqPX?=
 =?us-ascii?Q?1D/IgtzL2nduHSIxo24r7PYwY5g6UAdQmg3pvR4Wi2omJjMty+pHwf9u+/b5?=
 =?us-ascii?Q?/vH0IOKzw5yADnJ9xB+mrpl6OyFXF1+yTjv3hsj81XFkTE3tyNPc3bl/cy/f?=
 =?us-ascii?Q?4R2nlGt+EmmJlIGxSLZmnadiSTWar8FSBKMa6ppBDQdmcM/IaTZq2VttKF5l?=
 =?us-ascii?Q?uLfzQMzgFyO+FstbAIS9xCHzqwfCIPmH1qVW+WZPiGYkdEaji4VTwZqHf3gO?=
 =?us-ascii?Q?JhFmZuqF3mjWD4OxoBqAWbbnizQxn1i3khSL1fThy1sYwfGBTZxyXTDLNVPr?=
 =?us-ascii?Q?z6i+1Oi8/Aicwu4A3oWNMFnxJnlevOa3B02SO0TLFbXf3YfDLajEmJPgnosd?=
 =?us-ascii?Q?j6DmwexFlABzDtfOT7dNKKpnk9MNKuH4Zw6DeR5/6K9j2sE6JevIhyhySsvL?=
 =?us-ascii?Q?eUBV70MZYDMoczV7ke4dptfcycn/mhHgYkyC4JUnbpjSc7vvsANRuAgSCPTQ?=
 =?us-ascii?Q?ueWEUuwnjdLkpmcb641sixSv2GvDqD8OpqkxppMFCjZEdNLmze2YMSmst8eW?=
 =?us-ascii?Q?50Z19A7LHZijpq83QVh0au6JZcjNvlAnVlhN1xYSzcmXjOb6q0M38Ew2uJUt?=
 =?us-ascii?Q?L9AsOgkj+9b5H60kzcSThtNUyuhQji1ZB2evbw92w4biwowA0bVE4F602cRO?=
 =?us-ascii?Q?fL2BupNpDJUvoAPLUD636hNaqcNMQQByD6xxc9aEvLLC5mYUhfy9Zm7n6JKr?=
 =?us-ascii?Q?jPJu4Xc8IsGmrP1zOQO3QkhAou3YwJzcfHv2yUdduMHi6FfD2lyxfVsRCl6O?=
 =?us-ascii?Q?AC0JvVtlbUlKeHowaTHvxWWfTjCm0lLs5zqZLrFPh9vQ+kVDxpyXdDNZp7uA?=
 =?us-ascii?Q?JETbgg23FUa3FPHWRri/kE9smAh+2usPsVvcZ13bHshdVE436q1UY+0+iFKJ?=
 =?us-ascii?Q?Tk+ydqXb7JYvy1S9PzzEXQk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CFFB0ED99D623B43A9548D06E93B376A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E4/1AO0WdyHKUg9Upj6fc9hjPy3KA29UOWtMn08GI/cC0S9h4UyM1+3WFGx2dFxD5isWxSJILpaGPYnTDdQJoOw+0PJSPMH6ZboOpBsBQp0CozaW3h1YojahwYJjrro6BrZSWVfOyDBP2SiZIohSCxXtWj8CWWM6eD+UBvK8/gQf75z4kiLwx3ZvkNbJpx7L6Fz4OCpSsTW89rdJUEF9Je4wZ9KuTwz/TgE69Jo11pLd01cTFnQOlAflxgwjYl+ICdGi7WaNx2+MhQkw0qMFoHL4Tp/hKu/iuvKozywAe05tKzLxc/reaKoBcybQuZ7Ajr48StBUYecwDxzWZUfUBqdRPIja3ozF/z8FWf1a1MHKHLDNWv5kJxET+Ncg2vdrAnm19CxksbODz1cLA5+w/fDk8ZbQEZxizZAQC/OxR1Pw7mQI7VAvHTucdUC3OXr2ByFdPCeoVO60kGT+Sj7QfHSAiil8h0N5ghO+vd6Bsyn23aOXQDCCXsq+ERBYfSSSED+RH1MGpinULiIN6asyq/wQEthB8zaxdvVo1ggZxIotZPalbGw17+mQRoSgkKVEuhTsx98R7cceZBaUarHF+cBGNO6Rob0Ie48wpzV9vDgvrveWr4WJXzVrVECaBQdk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104aace9-0a14-4483-bdd4-08dc7a595b25
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 12:18:57.9625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1LF4QxuHV5aD+lKnh0yxtKu4lypG3v0MY7eb1ydDgEzx0Z19X2fZnLYiXMwrCcAQSm9CTngMMDdiIr89lROHRlMDvMqdMaWeEx8YMh+4FY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7278
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_051910_332314_3574FE48 
X-CRM114-Status: GOOD (  16.42  )
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

On May 22, 2024 / 12:15, Sagi Grimberg wrote:
> lockdep complains about the timeout handler running concurrently with
> the reset work which is syncing the IO request queues (which in turn
> flushes the timeout work).
>=20
> We know it cannot be the case because the ctrl state machine prevents
> the timeout handler from disabling the ctrl when the reset work is
> running (changing ctrl state to RESETTING will fail, and the state is not
> terminal). If this assumption happens to break in the future, we won't
> have lockdep to assist, but for the time being we are simply seeing
> false-positive complaints from it...
>=20
> Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Sagi, thank you very much. I confirmed this patch avoids the lockdep WARN
observed with the blktests test case nvme/050 [1]. When I repeated the test=
 case
around 10 times on v6.9 kernel without this patch, the lockdep WARN was
recreated in stable manner. After applying this patch, the WARN was not
observed even when the test case is repeated 100 times.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[1] https://lore.kernel.org/linux-block/m6a437jvfwzq2jfytvvk62zpgu7e4bjvegr=
7x73pihhkp5me5c@sh6vs3s7w754/=

