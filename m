Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1DAD5B166
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 08:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sQ7EVirB17AjfAakMtmszJAh32+9t5iBjmgCn1PRRU8=; b=o4pvgBoXjr0oRexMlvK6otds2k
	IpS9xj85lxUo29PpN6FQdMgWuYh3vhAFAUwNzMsVJxN5CRmSJkeLSnSuDCjUfB7CkFO8Gqf3/zwkL
	w6CoRQ4+TPuQdXvGxMnHS8sTbeLEraVOqTChOkpQss6q8hivQIz36tuoyOirl1U8F7T0aFqNflhEY
	jllWvZ/Pa6+SudSSn1WuSG33RF9gm+c1RAcPFFAAqoOC15UwM/GTGJgVePigKFG82VKoNQGZ+14um
	QMuIhyLtRXH1Q0Ao3ebmnHgnN5BdsAG7stE4wlf/CmLzEuyCsrAzBN5wI6W3Xn1YdWsznQooP/YeU
	rnBHZJoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5hV0-0000000Df4f-3Fh8;
	Tue, 29 Oct 2024 08:22:46 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5hT9-0000000DepG-0wEB
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 08:20:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730190051; x=1761726051;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sQ7EVirB17AjfAakMtmszJAh32+9t5iBjmgCn1PRRU8=;
  b=WVE42SwqtXoDWQXc/2jRKlDFIlQzsmlwktjAUWpdMvqOJeVyXnSWowPL
   gbh3ZcfhxY7TajV3fNa7AppFpHwD4f49zKENAbjmCpIA+1kpiJVVfchSD
   dmg75riJEScW8/jqOziZmtZVYETAOWeJRkF8yNqWEdUG7aD/8a5if1kZy
   mY9vpAs3EsqtBZxlivwXZj6/FtynkEU3VwLptfDpU4zwh58gOVyZZQt9R
   sIDiw9kYchmS7ufUdf3fzQtlxLJf7tg6dbnrxXrstt7p0qiJjh3LnrwrG
   bJ7GwN6CUvgiB9yBFICcZK0n/tbsV2jik1uRfj7w0L9GCa9WbbVW8E1Pf
   g==;
X-CSE-ConnectionGUID: MoTTxmhyTSmYH01KgZP4+Q==
X-CSE-MsgGUID: FGXnxma4RR6wcq4jxD8RcA==
X-IronPort-AV: E=Sophos;i="6.11,241,1725292800"; 
   d="scan'208";a="30106773"
Received: from mail-mw2nam10lp2044.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.44])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2024 16:20:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdBGAbnUINF3vlFGquAJ694Sq3QJcNieGZw7+PaL4hjrS/JHSJ/LWUnHh5RRuJ7x98P1eiSl7VDWM9LUh/ydeGPzic0jYCE7kMkyY9K5L87qA8EPCWlvCBr2JRSE1Z77BS0b74hjjqyUXx9znIEIGIbwEdvWJQTrATeTlGAqQCSSwO+GR9mFbKRZmCWrxYB68GDg7aauZU7e6u3mKmXvgHgN7il249LerevVP+sPa1leqxuyEwxQE+H/0hFFB/844EMC9iX6QxxZonWwW+9EAZUHvbJIJgxGf4iPGtG6tThurVdGxyEogERsMoP3bQpqaG8IOslyHVP0UCsJ7zFvkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQ7EVirB17AjfAakMtmszJAh32+9t5iBjmgCn1PRRU8=;
 b=cBG8nA2p6EVpaRGpIfwMHstIAwiIyQcJ4JZkKflUazwxUqed6vGox5UhXIK+TtJalAT4CV6n4xIf0nG1/YSSC04WmD4J+BgdKpkdc87sx7GsMbn48jpoGQz7S3WTxQz+WA4rOJxNdVKDvL26m9rlfz6fDHZIfGCT3SHaVjKPaIc1AvRQYccAnKqMj72jiP3QpuoZSJYL+TCK0q7Pe0WYheei3JnyIo8sO8kTUEcd3ytvzEG9XRZow9psd/50txCU8MQ3wtrKKylGEEiZ3KPtU0srApbEi6e8tCY3dSMjGbBHznDAU3cFOPrCdhghEvvNDS/h1mi3xM6D9AIjYDgExw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ7EVirB17AjfAakMtmszJAh32+9t5iBjmgCn1PRRU8=;
 b=pFQpSOKP/x65cGQieyeMDpaosJ2g3MlDrkawLxtJy0eWy7pQkZwTzCqsNYiGhlzmKyAiv/mKs2kEqWR2ZMUIftyZo3I0GNvjEEQhIJHVRf8wneQGqWI4hCTGjkCYyQTyV8eCK4Y39l3fRzUeuMdi1pGA/cUutQvU1Ekk/Ny9r+c=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA2PR04MB7532.namprd04.prod.outlook.com (2603:10b6:806:144::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 08:20:47 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 08:20:47 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 12/15] nvme: remove "local -n" from
 _get_nvmet_ports()
Thread-Topic: [PATCH blktests 12/15] nvme: remove "local -n" from
 _get_nvmet_ports()
Thread-Index: AQHbJbAnnWLi4b9F/UiHZ8pM4mz2GbKXkMmAgAXavgA=
Date: Tue, 29 Oct 2024 08:20:46 +0000
Message-ID: <d5t5ciodvkler3d33e5ny4nbbcbiqwfki6eq43ppunffef6tqp@ryowolioman5>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-13-shinichiro.kawasaki@wdc.com>
 <7b1faf69-fb1a-42c2-8629-90d00de86b8e@flourine.local>
In-Reply-To: <7b1faf69-fb1a-42c2-8629-90d00de86b8e@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA2PR04MB7532:EE_
x-ms-office365-filtering-correlation-id: c43d7439-c546-47e2-256c-08dcf7f29738
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?n5qgsOfS5cKuGWx6jhfPQ86PsoM5hI3aMY5Exmo6r+RoAPzMvmLtZwOC4cZb?=
 =?us-ascii?Q?FkcM4CjeNldPHplK8XP7VrM2siKCVV1nlh94aW0XJb+65vknA21sFuCtAzRd?=
 =?us-ascii?Q?LrMJPeUuJ1mZB/rHGYpDSvhEmpRz8KZSWqX4O7ndfDVgA68Qbc5HRCPtQKHA?=
 =?us-ascii?Q?BTk62I9/y+2dbl169WUid6N/ayBnAWOFm6JpSu7o/RbLQN31iyD9d/1/zfCy?=
 =?us-ascii?Q?ET/Sq6ESLsV59Qy8R0V6bYSoZqq7YnTVOUx7XUL/cZ4LeOgU0rskt6gJc8IV?=
 =?us-ascii?Q?jutYw73Aj5uc8jBM8Stmy9+OW8f5G3pnji+AOnCYAWurjwaDK0nfmrj5PeCG?=
 =?us-ascii?Q?b1jdcYLkVcHDe1Kj0MCtc9q3ijha3zLyg3AEN0LoFUaHRgMP+rBPvoWbVBma?=
 =?us-ascii?Q?wRsQBU9odZsgfdthDkREEec8rBVU8xIXN+uQjISCuHP5hw0CKczLemTxtdBM?=
 =?us-ascii?Q?jxfBXPBikrWNI1frNHMtc+JXJwFstWiDX5F2J1axCLJkgaAKQmoPaZ49zdhU?=
 =?us-ascii?Q?CC8cS0NYdVjOhJmNEpK+sScEBZ75+QjWFAQEbxbt/9NxX7T9qIKXD+MZkSrS?=
 =?us-ascii?Q?d+/jSqWIRdCOsBLnFwosmt1w+6/f2FLxg8xvRnJ4fAbKHbo5auYjvptRl+r5?=
 =?us-ascii?Q?sA9QJ9GDiprceS9ISvOw7v4JfpUSP6/VYu3BmnNAJy0jomoaZe23OnomHj+L?=
 =?us-ascii?Q?BIzN+PtMbXAqh8Zla390LMjZJpvhpBVLGwOg6iK2ihfCAN/CP2LDZ09CYVz9?=
 =?us-ascii?Q?S4CjX9MKUB0gAUrC4DczXUOMhOByvVjDYlDaa/EmPJzB1IPchUOLNKcdpmtm?=
 =?us-ascii?Q?Hs7VqIottijuIl62tsXd3FkIWl93aGWI7VtJ/iKSuJ5J1Lyml4gZ+y/tGzJd?=
 =?us-ascii?Q?VBdXXX1xXP39H4Ec8w17xDMp7PsM7//ufggwwCz797QUcWZas1OIW4dqRmb2?=
 =?us-ascii?Q?dGcHty6h9VXcQ4Pr/OESrDdbqR7cqOcGwRrXLO9gIGx3BJFdJby5a1BaiFD3?=
 =?us-ascii?Q?ffYn1AWTUleL3WkZUx3o3fJPNYzB2vajDYSWQtEs32b5InQ/FyQer1HYJBTh?=
 =?us-ascii?Q?5UDhsweHKGok+KcaXutX2/BLcwi377iWUT6dibtd+Rulertcyzneus/c6DCl?=
 =?us-ascii?Q?y84gnUY5iRzK+J0S5vhrUwoNeg7dUfnW14CFr4G3e+x+ZAP3WUHMXGnLRRXk?=
 =?us-ascii?Q?Xa0fgY3K9G/hbXBjAmz8zwchrOtCw0ZKOexkyXIWMWYQjWLlwZnDsicxkeZW?=
 =?us-ascii?Q?/K2Id9B5P2XAmg4qtO963Bp0QTQKQd0JOiruQwnuLErhrJQHmZmTuADU8VJP?=
 =?us-ascii?Q?AAXoYhS3mx+lXnGJ4gtgdCWF5zwXJuJMhNqkvNeFrvwBKqH0P9MOlgEciCaG?=
 =?us-ascii?Q?ASWYTBs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?60j/48BxmvGptbPz5I11z4kWgAZfwvN4dAqrCmsMZ2CkuHNaWUUWP51R+1y2?=
 =?us-ascii?Q?BfcCGP+zDPnL3mntVsTuvAMTjpk4SUB+UERQ0BuPNG1/Dkf8FsY87aN5AwuP?=
 =?us-ascii?Q?vG9bLVxppCrULHIgbBzJex3juOdHVBjJhm3uQtHulRamBRd7E9A7DQW8E1/P?=
 =?us-ascii?Q?RP2KLKRp/N7N5BVrwcwr5Hq6AMrQZ8lYj66KO1ZeDBbj3Efi2g4YSutGFJlG?=
 =?us-ascii?Q?/hJ7Kaq2MK60U9X7tcsOzH3vX1vjrE3RovsIYNBZW/FJDfReuWHdyQtws2rg?=
 =?us-ascii?Q?dG+nDSXlYc4tiKzy5vHwGiQL8/xexTQg24jGH5rjms+4ZlFLntxdoKn1loMJ?=
 =?us-ascii?Q?w60CUH9qirF3pDJYAJHzqb2cNMHIeWgAeDSMIwP2B24BtHh2uhBXaX0yUPEB?=
 =?us-ascii?Q?YFGoD4qIoMfEaCYglYhjIYLmHjp74+EdB6dwmr+JZvmtZQ/QPF35H0DQGuhP?=
 =?us-ascii?Q?3YUNMM8rwXqu4Awt9RH2NX99yjDu01p9nwnJa/Xw/8Btm8vDhzOqEk+n1F2H?=
 =?us-ascii?Q?K3zVuQk5QC9j96vVt+PzC7408XIcgGmOdgJOFW34Eu+ICY1/JwbBAfbTm46A?=
 =?us-ascii?Q?W0fpNA3eRPW9sZqiYT8DGBQkXl+WLbDrtjI77jpX09+rUlIQXh6zURpPxtfC?=
 =?us-ascii?Q?fwDSV7RZ4W+tZZ6ZT7ssSJ1KQRlhUG6BjIXIeApf38FjZqzUiqFrRSZGgl2q?=
 =?us-ascii?Q?5rPv68d8WIFQCmNdpjwlf1WYWUY9hctEK2ueBq4NlizRED9gBEYs/woXGFOW?=
 =?us-ascii?Q?j79f4kFSo4mRYFY5OUu3/Bm6iGmk19zeuhpPV52cakx2efhOpefeqSpSEObp?=
 =?us-ascii?Q?7ehGMYUIm983WndOefFg86e/pALzGkBal09/t0+M8W2W10Ozmj2CGAtxp5pj?=
 =?us-ascii?Q?Ss+fC8BXAg/HiZeY/aAFphPoxuhtE+zGWiRE6pD2U8wSPrR03e9LCHZIY/D5?=
 =?us-ascii?Q?c8WLjfPZ/J9BhhEDrbM3ELaMu2TYZ37wbWZy2nZ8mEpEAsNowt6YJKz7zO0s?=
 =?us-ascii?Q?8oe1nzv3AR+UXoA0ZyHq227rXDAetEuDZED2vJO+MvhJU+qyQCJxta1Jsrww?=
 =?us-ascii?Q?6IbljVNHc/mw4h8tx5rw+sLAedxXFWSvbIlxHONL7zJFykAdHHamMKFX2KSN?=
 =?us-ascii?Q?xzlYe83hxyMOfKCcsH5HugWto2IG2VZr77J3AvTDaZAzHlLk7YeiEkFSUgGG?=
 =?us-ascii?Q?qGH6nLnFkMMA/nMShamBNbJ4ZRElGdA7K3urscfJTOSxfh/8bYQUPjzPcPxi?=
 =?us-ascii?Q?kqGlaBP9ZLO5mMzLn2rOhGOSKUiVbA3wuUfWfw1n+4UqMiEj9LnTqQZAYtLh?=
 =?us-ascii?Q?LvMFsrRNqIhIvLe5lJrlsYXTUXsyk7U/tJ7y1nTX2aTyM5fl+J4xuCbd4Kpv?=
 =?us-ascii?Q?OebvYFCwBXczJlLnDKsU/srqmXuL8s8pK34JAVX8x+8cwC5onVZJdGqrtJfN?=
 =?us-ascii?Q?qOzf4YhhDFZarmqfAwtSXpe+p3ZeWMCfoouJTTqRpi996++IyeAeaWFyjtQk?=
 =?us-ascii?Q?kgsdNA81pbUWM6NB5LmGJFlppH3QcLZGRQiTBeI/R+yikZ2CEcHMxeUYYce1?=
 =?us-ascii?Q?SFKEJiVIAwSbYP0Ug90UYt/3KprUmcq1uC3nIdjcLerYtJs9SswygII+vB9X?=
 =?us-ascii?Q?px5rb2FbHhGTZJBT0nmPEd0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B0257596F243F148BD9F8F33B2BED0D0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YpVJZTarDazAvLWVHnbtOVA3ztJuZS5PYvj5oE2QZqNzdH3E/SZiHzsA6mHLwbtWDPsnv7/xK5CYB2jmcWDZLlZUzpfq74z8C3MIgN7Sk5T/sHN5Qs2KfskMu+QfMlcwbM0svV/JX8fHBZX2mZH/WPpAuvFPGfW05rWTTPgMlS+ESrKFx+ALiSXmCPMk3xGFPjbj609HVh9xEo0BYGyP08P7c2Bw8BKgJEVEEjA5viL+4e+Lxuz7YUgxe+ZnUOVPZ6lBrFZh/6i2aQDtyM4skLKu8+9SMF0szaEnz8INbHaCayGg2n3nCtdsFFPko16Cno0lMfijQ+/64QVjFy9/S4jUe5qBqik1C6W3+HyCxfaviLETHX7qvE0Ff1bYiOwrs5V8rLv87x6jI7cm+JN6CXdlKFLxsgmsIf8JESpimzy/3gsngnQTRbWueF1GoihmxyQdMRIsW/YabxZ8LPrg8bQd5ehA6vN/fPtGUaQm4HuYESqfDuEy/jgzVbinG+he3rH5sLW1FTBz/WQ3vN2ePZlEKgcgW+GqME1jBjTBz3YIl1XYxRClm7/3EPCiR7MtYlkNQEm11+cq4R4DovJN2rYO4ltONxq6XSMykxlUupxvPywzOSMV4v+c/MMDEnYU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43d7439-c546-47e2-256c-08dcf7f29738
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 08:20:47.0814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zfv/17l1dvAV/PWMe0ZRiIaqb9XJ7ziPuWBaqpsNh2T2zuvIj+rRsO7yzrHPFjPqeuWXhETVvTA1GOHcfOzb+Yy0MWGEc24W6lJ2UIdjK9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7532
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_012051_372627_8B53711A 
X-CRM114-Status: GOOD (  16.33  )
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

On Oct 25, 2024 / 16:56, Daniel Wagner wrote:
> On Thu, Oct 24, 2024 at 10:00:22AM GMT, Shin'ichiro Kawasaki wrote:
> > The -n option of the bash local variable declaration means that the
> > variable is used as nameref. However, this nameref feature was
> > introduced to bash at its version 4.3. On the other hand, blktests
> > requires bash version 4.2. To not rely on the bash version 4.3, replace
> > the nameref feature with the "read -ra" command to parse arguments.
>=20
> I'd rather update the min requirement here. bash 4.3 was released 10
> years ago.

I agree that is an option, but I would like to have a wider discussion for =
it.
Let's have separated discussion for bash version bump up at linux-block lis=
t
later on. I will drop this patch from this series, and keep "local -n" in t=
his
ANA support work.=

