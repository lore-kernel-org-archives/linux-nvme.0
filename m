Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FEFCA0FE7
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Aug 2025 14:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sDBrdL/14BKmIKt0jHU/A3ImkxGGduBvk81FSiNhql8=; b=saj0YSUFeiDL3PxoGR8E5w2BKQ
	PF0ucVbFOMwJWs04RmzsD7Mx9BGJMmYqaC/bLT/1FkPaAKF1Ie86KqJ9Yn4TC47OqBlEhprZBTydV
	9BOfV3G4crd25eXgv8ZtCjtWxm4GDBjYS9y0nP62EAAm/P+acnZSoxCOuZtjtMBBJklcWWfumCwiy
	bGtbBMoIgG9ULEqHEwD0sEo0+A9fMESbwzlk1zarcPiDTGzuBX7CFch2kEOjdaZ6W2Uf15clMEilW
	5tp8I9rsFvsvHrSxd9bfOWfZitdj3vEMVog7P7BqBiHmDQfRLcfvpmgs2LHsFzQUZzQ3GkOXlI8mV
	znymxeAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uquaR-0000000CFXh-1ZTL;
	Tue, 26 Aug 2025 14:23:47 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqu6R-0000000C9bR-1SC2
	for linux-nvme@lists.infradead.org;
	Tue, 26 Aug 2025 13:52:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756216367; x=1787752367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OLRqkCvcihMnvc1vn3jKYz9u76r+/M/8a3oYGl3LjI0=;
  b=lGPs9mmdsratfs6mdmN6SvFu1QW1uOhmj+zHli8lv5FeQiTO4Da6XjLO
   FZm1MTVfWH/7j7iBBkrlXP782vTAZya4ITyhN0ezAScYH+psADtQMx56Q
   nPotmG6ag5i94JdWhEWvtkkddfwuUFZmpJbDPQcDLe+71qPyUHCnaINkg
   QOGl9HkovqrzOvL+kZAPk22aGJ2m6FwykzWqXSJQ/8S1qVUgS08GX9VJS
   wjZZxGCoipoLWqH73BwSBt6/OmkUVoXS02fsBMbywg+m6lghVR+piHsEM
   thdt6dUeyaGqrYgHhCkJ4iE4asXSTn2ckva1C90Dq3GXSw07RlJeDaL1c
   w==;
X-CSE-ConnectionGUID: z75wRA3JRBerDHcjWv5fGQ==
X-CSE-MsgGUID: gPc31ctsSFunrwgG8+nGZQ==
X-IronPort-AV: E=Sophos;i="6.18,214,1751212800"; 
   d="scan'208";a="105857413"
Received: from mail-bn8nam04on2077.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([40.107.100.77])
  by ob1.hgst.iphmx.com with ESMTP; 26 Aug 2025 21:52:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bH/Q96pjn9qQ8A7aiWipLeTNvjJchpNdXtuQDOxZK9GWsIU0BCjfmiN67Y0PlwjSAU5HhEZXkb0OCEKfnyP03xmykMgpW/LyTkJ3crBeUx4KJDh0GNCF7Z6WVT6nxskztHpj53H5G2rx/NVpLXeuqmXNxNUp+PZEwo65xZuW6MuDAWNgLGjmOcGQt9aNT0W2v3L1gZAdikxthVupAFovqhuGAd0wbbwgt04/ZdHNNjyqEJs+EesoOMeFUgF9U2vciQFVKdGtw4xgdcAW6Gr8d4Z1f95hQjR9cdbUUoyfd4193017hrg1uhpHpFQG7EjTeObhwsBNVoT/uRh6Y8SpJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDBrdL/14BKmIKt0jHU/A3ImkxGGduBvk81FSiNhql8=;
 b=sQJPPpiT2T9aTkiz8fTdLfeq/rV7te6H+UkczK+z33SfV/gtnRaZNJuMd0oCNkMjCrNlJuTd3noneSep6p9pp/4SiNBy6UoozIhQul44UDlmQDzF5Bo/lVoyGgmk2TvmWYuh7UzQWvxbwfhKtWI2OLV8lmFyzxWSSILoLPj1M9UMQAJx7ir5u/62sxVBh+WdrT/297XgH9RD4nniaFxBFPk01bQz3vJD3yZOQeECjZmhg7JtAYNA8V2A0/S15urtiEigxvQXwmNsPoO7SbJxaUFcIhrZI8nnLIo9P49WRkhuhQfK2PYFo0UvW8BImRgKiv4b8h7yqIdEQ5UnktPfAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDBrdL/14BKmIKt0jHU/A3ImkxGGduBvk81FSiNhql8=;
 b=FGfog8u+rol1JPfxXi672D+M4z/zkq5KpAhWw3TpPvERWNEG42Q5FMi7WTIXpx7x/U4wQGYamjytaX5NTeYUrvjvqv0uUzGgfTt/g0EFbcfXL+EfchC2r7FBbja2IlLd10qZPpdhi64W9oQVAZdyZGkQ0tz4ozqFH82VIYpPKjo=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH0PR04MB7589.namprd04.prod.outlook.com (2603:10b6:510:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 13:52:44 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 13:52:44 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kanie@linux.alibaba.com" <kanie@linux.alibaba.com>, "kch@nvidia.com"
	<kch@nvidia.com>, "dwagner@suse.de" <dwagner@suse.de>
Subject: Re: [PATCH blktests] nvme/054: fix nvme reservation preempt and clear
 operations
Thread-Topic: [PATCH blktests] nvme/054: fix nvme reservation preempt and
 clear operations
Thread-Index: AQHcE3l75mbheLbWfESYGkFKz3/5VbR0+nCA
Date: Tue, 26 Aug 2025 13:52:44 +0000
Message-ID: <4ps6jvixlt6pch5zsjx5i2tncrldutej47wcma7ym3c7napahk@ibxfuyh35g5r>
References: <20250822150006.3248193-1-yi.zhang@redhat.com>
In-Reply-To: <20250822150006.3248193-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH0PR04MB7589:EE_
x-ms-office365-filtering-correlation-id: 5b2b19de-7742-4ecf-bf9b-08dde4a7d51f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Y6eSiT08NDWDV3NtZUsMXst8Bgjckl6kZWsJiX7Be7jE91PrqNmUGcHXnOgy?=
 =?us-ascii?Q?EDHIXlmgjl++8zvNDXu/rH04DIB6bQ/McyowCkNIcikNu0A8BAMHOovCotpY?=
 =?us-ascii?Q?m96FSBELoorhemsvsEN0KKOu4oxv9RSHfQM7TFLe9JDKZHCFKLFFSRbtUoMN?=
 =?us-ascii?Q?MGmITJUCI4NdfSaOav+Xawvdne+guUN+FSZMgsKBEQm6mFmyc9LgUOqjMmEW?=
 =?us-ascii?Q?qQw9vR+apa2bWl2ZDkKI+ayA98NTwIUMgRzW78JGbl8c8etg4vDrRxj1qiov?=
 =?us-ascii?Q?/k1CbI0Zf0c9VQEc55GEi94wr4P6bHHQtgyHLLjf/iKxIMQBtoFCQlgVxM7w?=
 =?us-ascii?Q?zRjhYMpFFd6feJvUejrtJkLP/Usn2LMIjs1184hYcKOqEbS9f8fgzAhAkZPF?=
 =?us-ascii?Q?/7OCKQGTkCduU8C77aV0QgI8ox0sBAiycfOziijf7+qxNgJD1rjuHjsBqjK6?=
 =?us-ascii?Q?6mklpaghVnfnbVviBhbtY/A1XNvqb0/9Jt8j/QvxD5/11Xlur4eDNAOVddLd?=
 =?us-ascii?Q?Fpz8/rU8hAKVWAsCzSltzRQIHcMgYpSR+qsMRyxcocaEElAfRmtmgjXbAhHt?=
 =?us-ascii?Q?E3oIwuvtRWgs3g9TnQi/stYUzbo8DvxNYWdhT/gWG5s9L7Ze8DE2FB5Wl3H3?=
 =?us-ascii?Q?u6DSanjEOMU9ztvIVyXs3+qYVbP5FWeWiVdi2G1sCu6NsjcC1P9ktOxvbr6W?=
 =?us-ascii?Q?B45KrGldHX0O7COpN1jDgBbaAXcPlCDQ3nqg03bLj8yTbGjXkwAn9KQeGCDs?=
 =?us-ascii?Q?ldXDvXUvQFiR6f+c8Jwsj1XZMriLnU1GtPPlw9VGL6qjGM9Yv6ryWlT2sn4y?=
 =?us-ascii?Q?UhvlvSjLvTv3XuNtZvLzUb7aLdYO7hCmSAI71dgDE2Qdlxc/5L+WDfD4rYdc?=
 =?us-ascii?Q?FmORHwwD13sGeD+48XQUzoLB6kcpdhHJF9ohvt8mO1FbbemmKmHXsfhbSy/F?=
 =?us-ascii?Q?Rrdc1fKUSTXocMNZQXvPeFoDbbRynO5wdrqun6p8IB0bJbf2dEwZDTrq4qY2?=
 =?us-ascii?Q?9wlGf4xYhofo41lQgojH1IQZpBUXinN9PbNFJuYx99XoLC+vEg0/GS1bwlsH?=
 =?us-ascii?Q?JvwWNHoA4Jk+LcgwRgIzoVsHeqLl5uapR8DvYbOzt0vi3OkG+GTSLxsPr+NZ?=
 =?us-ascii?Q?yhonEaRw+/0zCkXaCuQ/Da5uJm8VcPP9uhZK65kv878c2OD3g3LjFOr5a4p4?=
 =?us-ascii?Q?09rdBJTd0A6DmdUt2zLLs2NszLfZvZLsLTB1/Quhn56A/A/yO652WNzk2NIc?=
 =?us-ascii?Q?f/heNlt2IIoIJZbEldbqiML1079e/Vo04rJZJTh3916++t2wSEnPx6Z5kVgK?=
 =?us-ascii?Q?6np+vMntJMlRCA+GljUENAmNmZBYsZmODwAzJiEVhxhLgBaKBCPGO6mV2KjK?=
 =?us-ascii?Q?DZFRWU7jGn5nWQE1IcXJQ5S+S/6spnZ0oxwoIVRKzKVrgfAU6bWzVxUcNMxq?=
 =?us-ascii?Q?Rznbh/VDSeQL+Zr2JBWJq34vdDj7eDtt4mYnM+G8R/fSohITg2kYwdVRNmc6?=
 =?us-ascii?Q?E2s4fnUEed++vFg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HHsEt8cYQrzHMxZj3D+e7KKhbg9Fg0DkMixANLH3wtQHVLKeao5PKVxgfd0B?=
 =?us-ascii?Q?E11A1glzu1+KEtAZK7NTAfezAEeDeRHV2Gu/3uReKs3pksKi7zMTLqW+bLzY?=
 =?us-ascii?Q?R7F3QhEGgkIY2HO/qDoAwz0kmOblBPXxRprBOLHTJ87OUBkFIJ8ao890nlXT?=
 =?us-ascii?Q?Q5dytDQ2jKNtbQC4p7XKW8C4mFwELZWBvxu0OZtMqsyOAc0ob8VhgWwIfJeC?=
 =?us-ascii?Q?FooMHBtufIx+kZnWXAMzm9JiFlPXkGoJdUI20L6cGJfHeL7YL1m7WFQFTS+a?=
 =?us-ascii?Q?s97JxTJLCvXqGfeDFJvLtfAViaW52n2ZSP6kSd/yeJX2UIA7Ct0dgMGNlykX?=
 =?us-ascii?Q?vBsxIn0VQiFPBEe2fZwTUh0Yv1Lg1wAdVTFHxgPPHj1mdlsYjDedWMS40DSe?=
 =?us-ascii?Q?ziJiMdBbBpGCj2IFtM8sWhANbSTe9GW1+2HbD7SjsJZ5JMrPYj4Nxhc6gal9?=
 =?us-ascii?Q?bOAgw2Hxxw61qu8BCRG01h3TvRHvCuY3Ic5NUnCHhy/DHCmOfjtL1f9b+ZJf?=
 =?us-ascii?Q?mfA4Wg7zfhEUR75/g3HJRoWc+XgByoHZIfvn0pevUF+ExnywaeY7k2JVVLlY?=
 =?us-ascii?Q?J7s/L74U2XAyryOIV/UZiZES5aH2xfptPwcq3WZH1oEjwMX84Cowscl/ZIE5?=
 =?us-ascii?Q?kdhqagSxkgHYo6GS0Nt7vY/a3ZBtArCNGT8vqRAFhI7eyL+8UfcC1bTz0NwB?=
 =?us-ascii?Q?f4gaSXrMXvT8t7U8HoA+CCS/ZhYSmZkpKolLI/dg0FqxJvTg6PpFWnfkKKdq?=
 =?us-ascii?Q?RcSgrE6e8gwdpnX6qOrCS+OZ0G9ZoYPnGoZhGjKKSTKMscN6GINKSQFjkPjS?=
 =?us-ascii?Q?BqSQxrQ4TxcQ7wog1LNT6+R1tHRyKrgfNoheAR5TmeS+iD4BhmyQnyZuiuEi?=
 =?us-ascii?Q?d4xRg+1mXUkRBO1ip9Rv5iNzkghy3Azhnyzwb4klVfoAa3HWWdJem/YFEZhE?=
 =?us-ascii?Q?IuQc6++PRxFO5wEQv79skb8M1HIiCfvfSqvtwAFdn2DziMY0v1lNCDJ/W5xz?=
 =?us-ascii?Q?yvlJmQ8sWhuKOUk4nTvp25dCHuwMPjKZT+4dQuEedgdsfLL4dlSz8LJ4AyUK?=
 =?us-ascii?Q?kzK68/ybBm3LC4cd6Bl9lEutXsaMMTDc/4M/TMt2OvMxM/axIJdJiKA+r3Pb?=
 =?us-ascii?Q?Sf+5alwlzAJ0wDvRM7bbR8eO0MgKpx3UnvZaHkVoJ9N66ufXrEVJoXh8PGRe?=
 =?us-ascii?Q?000ZS3PgWLCoFrnDjDm9672x0U2Tt3N1DUHCV7/SB5IdqW7EVj826JjqROY0?=
 =?us-ascii?Q?JAfUMiej5ioqlUVbPX1USYazN2twZXPNtGlfhgAMOA5ASfF3SnVVy0nUjqfA?=
 =?us-ascii?Q?5eP5wDX4GxhOJ37y3YWPYb9PkY9UKP+CRCMCBac83O49UiyAOYSyRzGlZoi1?=
 =?us-ascii?Q?+hpsUvDg0PVYvSKgVUe3MXDH4cYwep7ixnwUXIWvsYSo0CekrpIAIzkwAUIf?=
 =?us-ascii?Q?h+2cXee32jmg5+tXA3yWBBNJmxY/V6tMkWVKDK2nWuozk8aYrgv3homaDOKQ?=
 =?us-ascii?Q?i0YvnhEvAEVE8iD9PPYdbaZi4RdgoCquhWipxDe2d2vFJiXss51rYFRkLcKP?=
 =?us-ascii?Q?3iZV6v3SycOyCXSeRIsHix52lQmG5WMBimwhgjGjm67qiW0Tu+E/XHkA1UXY?=
 =?us-ascii?Q?ww=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1142FA6BA31D1247BD8AD218D40978E1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zg4rdkVSGWDCxyVl/Y/XwpwcPaBLV7v2ihaEO8L2OvR9n2R1z1VEeTlZhxtgwVK4yh8wYjDEV/OBStSyrYYlg421A5JaCnp5Py1/ghQrwoglTY43cdEpQWcy2XSaltqodsoUwwESxBKyXV6iGXKkPvUjic8VuQqrniPUZkRBPTgPlV7UziK/Ck2s5wAbxhVWJ0j2dF+TibBbMVzlzx0LGcNCEMs/LeiL5AYiySaLzY8w+1a3YB4n+iK5bbP7BzoANqxwBBdQeFPVjwkgLrudUcv8gNMGUki3I+JGfzgzYONJqsEcazqwTKGhmMWgmyW3TEyCVJBACvIBxb/FMMkiol0/gtHXTkU0YEUqEZnk/IeyDV1tyhM4IMm8TNBF5AXS7QXjRbjD5PCXmcoxBTUuOYg1ZEsfP1ETmyxPjUNVGvm1pnjqURXIPIl7lHmPqlu3VdfdqyBFCRtd4tZtx6yEXipCgEf9vC5Hofdkhhp/wq9OWKBCMqB7ETaNoC2BOhgNRRl0sBIKbuqFUX9kzU6TqRk7faQbaSL81Pc2Lph3M3U5DYzWgzbpR8elZV80OMRKqb6U6QEN8hDh38g2E+Udgx4GFfAlIMjIFNs3pZEPqfrT0SiYQri1XtodxoQl+TwW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2b19de-7742-4ecf-bf9b-08dde4a7d51f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2025 13:52:44.2685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IK9tc7wEUEUbn21fNdHWLJfQjs0jjjtLEempy9JAnbduOjX/AigzmJbmPR68VGXNWSf99JbsTNB4tQvvRbd/GwmUD+OWS8UJ7V5h0dV4Xkk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7589
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_065247_455900_CAE689C0 
X-CRM114-Status: GOOD (  14.90  )
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

On Aug 22, 2025 / 11:00, Yi Zhang wrote:
> This patch fixes two issues in the NVMe reservation test:
> 1. Missing --prkey parameter for Preempt operation:
>    According to the nvme-cli documentation, when using resv-acquire
>    with --racqa=3D1 (Preempt), the --prkey parameter is required to
>    specify which reservation key to preempt. Without this parameter,
>    the command fails with "Invalid Field in Command" error on some
>    NVMe controllers.
>=20
> 2. Redundant registration in Clear operation:
>    After a reservation release with --rrela=3D0, the registration
>    remains valid. The subsequent resv-register command attempts
>    to register with the same key, causing a "Reservation Conflict"
>    error. This redundant registration is unnecessary and should
>    be removed.
>=20
> These issues were discovered during my nvme reservation test with
> the same steps on NetApp storage connected via NVMe/RDMA.
>=20
> Link: https://github.com/linux-blktests/blktests/issues/190
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

FYI, I applied this patch. Thanks!=

