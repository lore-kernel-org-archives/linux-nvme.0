Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0201D13570
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 07:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+05+vrblZzuAttubkhIaA4c0sVdl0l9q2ZEdt2HoOb8=; b=ZxZPkowMtItDllIyKN9X16/Ubn
	jhq0Adg2OqQ0ij0zMbNAnBc9sPF+H45cXL/QFFuFxX600OQw3C48b9xHozFjrRHCzi2QqdcMi+DA3
	HOsFPXvkrYSxsIGi+m4K4tHcOnb0QT4IoKdL6VrvGmeDniLa9e/XfBXb5eYQeCBHVxXBdZ8t+e7Z3
	Y1uDOH7nm7dWK1xqcHleq/LuX37VVTdhaBWdK2xYnI4psODCMQTzlJfyWKVVa1Htm5oqh58sUz3RN
	uBTzDmxbkwGbP/bqPmdyV2kOSqmctUP5igq9+9Z9JPaH0UG6BgGtmWXXylmPTfqz2n53leEUsUVI+
	yH1GGTfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5JrO-00000009oEo-1YxD;
	Mon, 28 Oct 2024 07:08:18 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5JqR-00000009oB8-19sE
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 07:07:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730099239; x=1761635239;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EKxkH4mfRC7ow7HD2hUrHilbQjSsyY4+7J1NvY7aO0E=;
  b=IW8EOtB4ZwJXcK8KxUu1n6nz47Xm8aaQtvi7VXTKidGmn2l3sdql9Ad1
   W7Td5iOo1V3Ga+PS6r+WBBlLNANI9/nks6oLk2A1R+0NtUynUEiry3ETC
   IEp4Qx998Az4ED/i1J9CPrlTPHdyjdMSQkV13wIUfRAWNQtl8JU3+IEBR
   RTWKTMxq8gv1dciGQzUUhYVD+scEscvk+Bi5hxaGcXWv/CR/YLFhuyYn8
   r1YB2lSZIH0dclCwT5mjMwam07AT9GVoMA4qUQfRzJjsIsLACL23PVffZ
   9eSIDBEgUrhSQrDdyfm3gGdAoNB1TW/kwjrk7XEPRET9xOTig1kmwvhov
   Q==;
X-CSE-ConnectionGUID: I0qBdWeMRU2W7gsx+ujzVw==
X-CSE-MsgGUID: 9ag1vdXhSDuIoWejurR12Q==
X-IronPort-AV: E=Sophos;i="6.11,238,1725292800"; 
   d="scan'208";a="31122487"
Received: from mail-westus2azlp17010005.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([40.93.10.5])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2024 15:07:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFhRevdTvrRlrLNCCRLGfPiaZbL1B3cDmrQ8RWD/LRYhyrvDhJxNyOYNn3xVeQghTRJYSZBmvSLUOc31DMTNTBca7YnAMmtCWPfAxPslFJjHqZMDgfAYzrX6uM/gXq5mJJpE5iDEiBhUvBU/fTER10HHifMu6J5CnW6DgYG3AqNHAO20sbVFZcF7l/0i6pNSQDQyXeBojn31enHuD8ZgNBmocsGWGkiXwQLbcilryiLAZ/07BVa76SFPtvQVIIe/t3T61HMwsQiwIZHHgQVbd4mS57esLF/h+IWj3Wps2lSNWzbgrwF/GCOGGqWaSTHCl/jc3MehJX8LS7IuAxeHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+05+vrblZzuAttubkhIaA4c0sVdl0l9q2ZEdt2HoOb8=;
 b=S1AJcl/6f5PMDT0YzBA0/wWiGYFUwuV5/UmqIYt5wHGbAQAxkpIyba6z6kZ0d3RQg87fuZoEQZEu0IW+FYZPRq+vuRcKVt4KJGUenSsA02P49TnWTF3b8Y/PyLED3Mcxd/+K0XpSgXGpnzkrs71tijL2Xmb9e603pv+MkuF1dAptg9repl7ZPq9Tc+EaKwcTucYQtQQT3xTsuLe1stAxwZl/YP4yuo+UJr1luSFMaRRIvHgOGguz4auZn97sD6UE/J3qU1eVQQKkNgV5o2PYKod5UuD7rStn4sapJwts1EBtWwn4STRh6gceWYeEC0fZBh6LFWJKY/S7nrO9SuJj3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+05+vrblZzuAttubkhIaA4c0sVdl0l9q2ZEdt2HoOb8=;
 b=tOljrrW7fHAuzA5ovoepsNmXS7dOTmAMytXycfq62buVaHfFUY1+ADO69A0hNeQY5BbqU0yr8/A+PvN5hSAy+yuXY6jPQ20uTgfnwmI51To4S/CKuoLtTMM4eIWoQxKsBPJq879cnANPox/6Via3NyrvtIwO24xdMtZo/CLHMRs=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB7015.namprd04.prod.outlook.com (2603:10b6:610:95::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.23; Mon, 28 Oct 2024 07:07:15 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 07:07:15 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 11/15] common/nvme, nvme/003: add --no_port
 option to _nvme_connect_subsys
Thread-Topic: [PATCH blktests 11/15] common/nvme, nvme/003: add --no_port
 option to _nvme_connect_subsys
Thread-Index: AQHbJbAlHxkCODarl0GL5hjS089NS7KXkB4AgAQ0iQA=
Date: Mon, 28 Oct 2024 07:07:15 +0000
Message-ID: <nfnhajw3njwoyitpsltx2p2blif4js5s7zwqmd22hxt4tx3ptm@6x6rz4pfqjlk>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-12-shinichiro.kawasaki@wdc.com>
 <80050767-185a-42b0-b4af-3f6e2c921b1d@flourine.local>
In-Reply-To: <80050767-185a-42b0-b4af-3f6e2c921b1d@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB7015:EE_
x-ms-office365-filtering-correlation-id: a2a7ac1f-385f-4f25-d521-08dcf71f271e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?pHs1GnwPYuvH7MK3s2Yi77tMu9GdaAfUAZ3xZbmWTMY09Caco52/rvTa8aXh?=
 =?us-ascii?Q?JEBkURjo/rs/pKsHppc3x6MaYp24aDM7obc7QfyFuaRlpiGsD8JH3v7TSpWp?=
 =?us-ascii?Q?vasiD15VjLgvPFmrwpyTd0Ba2xQTGyl5rUN0N9Vedpjv/HzfKsrl1VMtKl9P?=
 =?us-ascii?Q?8iOCIgtqBG8rn9DNxxWSylPP3dTvvOzBb/0vEZ67GkTNm3w//BuxopOPAw7P?=
 =?us-ascii?Q?66K+vW0TMVZfHox/M8NLKvnrIqaVLXv0IiGLuW8L5fV9/orXDfIcXXdIcnlh?=
 =?us-ascii?Q?zZNzfp36iW830kpEXZfOeszyz11VKN4RZfIelS31fHq9QtdVCgRkr12gy+QJ?=
 =?us-ascii?Q?tubeQUDBnUqa4irRhToWS45LSk+5V2sxElr9hEyGiHG665034JIyozF/rod0?=
 =?us-ascii?Q?sDq6i0SItl+/pVN5gwvNR9ZQkyNAj/fYUZnT5f62WJz0fXfxfdY4l4QRTpBu?=
 =?us-ascii?Q?W7c1oFfEq0ncWHvf3+dnhWfPMCnLIlfYusKJ+DX0OBsfbzzTKZuXeaJc0PZJ?=
 =?us-ascii?Q?YyjhNpIn4sW//4oCO0gVSwpFrNl1Ls4WgYVzVwrHvOZ5/iT18ojzGz8jvMzw?=
 =?us-ascii?Q?IKE/vaF9So/rtUGGKt/hcPGSksyp07m1UicGr1h4SDTt6mx6HM/oh/FaUgv/?=
 =?us-ascii?Q?zjlVefG2ZwT6c32V1v1Nd7HBDKOlTZ6D3a620mnGfLaceSLS0RTdJrH9F3mm?=
 =?us-ascii?Q?PqxUNLyqGIYLIc+rRZZIO87w0SUzTRpNvsMqvmZcsQ0EnuTRim3jFENHT2n3?=
 =?us-ascii?Q?7/W7x7z/l5iV3ZN+I8XFVj+eOUhpaCn/imJFcq/ikSPBmY3IVIPccL5A0eQH?=
 =?us-ascii?Q?txwVGOyzRRAhOOd/fNg1Kq77V18cxdx4wzexyZY5sXh789Uwep9apMDXi3z/?=
 =?us-ascii?Q?6H+hhGxZmJSD5ut2IB6Qi+lYh+svaT5MdP0jK+ZRrsO1I3pwKsZXzBHfkLxX?=
 =?us-ascii?Q?wIzi3r6/o7zRcIXSkMmmgwycx3tTu+Q1qpHl1xScEALCY4j44BKg55g0TlFq?=
 =?us-ascii?Q?pcuG4atRs0h708Ltoe7OosJLEMLt6lkrFYlysTJ5wJHU3DlnLgoRAXcPSoA3?=
 =?us-ascii?Q?ta2HyZNgEL202/adPkDKN9HGz9yao+66rzj7ZcDScV9LdIrlDpjgrostpSg0?=
 =?us-ascii?Q?sU4eR1cfL1XoXKR2LwOSJ34Hm65YtAld8Q0LUaXpMQoPE9oAjLW3/yqcgXQ5?=
 =?us-ascii?Q?E1F91UEA/2ahPbCjlAVLgv8jgiGb3nn2JRRInPiQHGCChKA4+dmxa0FiAMVE?=
 =?us-ascii?Q?LnrnXwiJKvSzglidxjWh3xxLBwVq2nIK05+5mb8kxxVYd6Y+oNbTQB7kRWNJ?=
 =?us-ascii?Q?PNb50JEjm9ZKxndcZSiYT2pbDfYRv9nIuGG3rvL6fuGiS0a3RHVw+OYDaKIW?=
 =?us-ascii?Q?syy/bC8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Oj9+OF0XTwK4WcKy4XfjWwaTo+OBrmYkB5VfLFfS1PUPO2Z5r3+dtoRChYBk?=
 =?us-ascii?Q?Lf2Y40PK+ZPztarAAGT2E0wwgvdynA5KG0Qj/BRUhCXUBX5YHl6fPHPPtPza?=
 =?us-ascii?Q?Gkqnyw6NodSQjC9xeVOdF2x6h8dFNyP/y3BGAsuVOXwEU/Qn/Y9Z2rJfLbHJ?=
 =?us-ascii?Q?H+Q0t5uZCbhhBltR2Dx5s8nRHb+QrMAbmXueMeT8aMrb/4zxEkYTvWyvxsOL?=
 =?us-ascii?Q?iN9i6RdzlFAOIPyKNdxoDiJ8HdCkrhSDgJj+k3lhEcLXanRJtyteXW87i0mW?=
 =?us-ascii?Q?GAOKB2CcJhvx+EJx5JdG36DrBdBwbUgrVptzFqOkMotSBXJJl6gN93rKci6p?=
 =?us-ascii?Q?w6KLSAmFch5oapGm6gHI/2tB9ae+TVCZBJlEJUncMnbnMZm8axVI97jiC1Du?=
 =?us-ascii?Q?U7GFtGCfRG9FAAj91NI0r25alZtxhHBS+GLMXbrgAKxfBVB18MnHDf+0ymFJ?=
 =?us-ascii?Q?kJQf2QgI3T3dmBQF5BHCOm+xl+qCySCn2U8QjRYuXAa9QIQ3SmJb2+IvSrDe?=
 =?us-ascii?Q?LgQWZZXIjPLKEmrCHDJA7gmFKnM6GvfWT8m1qC2q9a3PfaQg6GljWyqdhs9a?=
 =?us-ascii?Q?W/FNOG0+XaMpR6bW8o1ovFS48n5jDpFHaQx8ENS+WmhJx9bqjo6Yif8neEB4?=
 =?us-ascii?Q?oFZ8IrjkREGmO9OZq401lj4JssYWZZd4PmlisFdvm8av456bVr1yDWHFvh0N?=
 =?us-ascii?Q?Bb/O+A/9wx2VCfOaxqorcCce+1Kxj79iE/tJe12JTMYvuaGjdBg6FEfOEQ/C?=
 =?us-ascii?Q?9jsofw+JtuL001LlmN2CEMIAnErW4cOitMFwYlLbhA/4f5cI4MI7lQcOOCpe?=
 =?us-ascii?Q?4qNaiEdmL9yekdzEBD+hcD7iJwNSU17CerK2zF/YNiplD87KY8weqb+g4LDe?=
 =?us-ascii?Q?Fx3bFriUfW8VxGJHKscaI1SWuy46l5mtB+iH0piPcLjRO77iXxXHpLVniIGq?=
 =?us-ascii?Q?6eE00GFjVE2nt9L1VEl9ltZu5/LH9oThLsYiuOutCtcepgBaUKd6bGIoj19d?=
 =?us-ascii?Q?B+zAMjxxI3n1euBtWGd9EYpNdRiceWqej843znTE30uVr4tdGYelX4TabWGe?=
 =?us-ascii?Q?HZQCJsk+jbdScU3CbuQ8aQkYa1cX2Q6SEmnqmkhMOrNbo16jYCtbkBlqQ9BH?=
 =?us-ascii?Q?pwPFZzvo4f8H864U/d0zX+doVVNOec3WeGKmr+RPGX8ze8j58ww1u8DTzddd?=
 =?us-ascii?Q?1xJzfRJo0I4QnBv5qVfrJZco3xC1gviFzI3OBV/v/6koxnpqBBiQG0HO3Kyn?=
 =?us-ascii?Q?kxm6hI/T/tbbQjESwt8NhrpnDw2Y13LPYbmeodmbKo771o535YvtxDSDof9Y?=
 =?us-ascii?Q?m2p80uOsQFlxQKD4hsuGXX0HTz3X+02wGfWYPhSpeVwbc5FVCAFLsHoQF9QR?=
 =?us-ascii?Q?hXLrRFJHf8In8EChnXxztAYPZ8rmlQxUSGUuzE26mQ8HJmsMbWzyWCz46+XY?=
 =?us-ascii?Q?yYU6r+fBAXopZqIqnXjOS2tUqnZG+RLdyGIKvAPo+/an3QUKuwqwN9UqIsbH?=
 =?us-ascii?Q?yN0m72kCAXJ4/4DCdEo6jOSIr/bcFJucsrTVTJ/fE01d2VMrxozdc7NN/BZ3?=
 =?us-ascii?Q?/oyCJcqRZEyMD498/gZlcW+xHpDxveRWRAiWRltg4rrDBwsbiGC+5zioA6sM?=
 =?us-ascii?Q?fMKB2Ggs1GafAa4Avu/2YXg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A54F942CBA83B1458AD6EBE941050F92@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jt7t8jql8cyiOsNlLwJAt99xDOq6HFvAFHT87+H8KYTu92IXp3b4bfu7Ji3hT6IXBooC9u6AT65x4bYXq+hooTFSKkC3Ot5LrKrozcmOF1e0GQWS8FFLp7bs2krJKjhncTqXWZ1XhOqzd1GelS36xIXoGxdgBU+fo+EU173avgKQDda2T9HI9XSGzeqifiQTYRrdIkPrtiVBF5/iwyqHtk+JYCJ8CdfltiaWfpQxtwjOKT9REh2EkcdQy+CDFC8iARWyAugNUqsBk6FLP883iRkaoojETdLY7Yl31da9FxVzlfrtyXHDy4Z8/a3xx8ZLOMbWBJVDIMRyOGeLOB0rLXJB6HD3MVFvPo/0ByFafWKyewqOLY8ysU/AyGeHEDGKx+cO9Lbb5iyiA9wUnWJLl0vx+t9koVm24coR2DbfD1S5ueCYGQdvVH+xxLOXZFl98sN42R9JPRK4036YqwHEEaeApfm/ymZF+3ewAkm8T1C4xkD7VECooT/fj5AabzwNhyftjNB4LHjgzwFgfCATY4sokNqlPVLMg/PxDq3rBMHFtzXZAVSGBWcYYWZ6zrOJcaPuGrdZwna+0jSmXVStrlBFpq9eGq5Ef3vdjFLtMq+EfIetaC62PwZXu7jxO1ml
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a7ac1f-385f-4f25-d521-08dcf71f271e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 07:07:15.1998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9AXTXtbennXgsm3Fi1QIigQEyWca2OqCfGBgVecGcZ89D0x++OlZULM0ptee+iEdii0DMBvtLUMhA3d6z3ZhJkzaJeBErN7LqJMiZXw1RfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7015
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_000719_365286_B2ED0DE4 
X-CRM114-Status: GOOD (  21.61  )
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

On Oct 25, 2024 / 16:54, Daniel Wagner wrote:
> On Thu, Oct 24, 2024 at 10:00:21AM GMT, Shin'ichiro Kawasaki wrote:
> > Commit "nvme: pass in port parameter to _nvme_connect_subsys()"
> > introduced the --port argument to _nvme_connect_subsys(). If the option
> > is not specified, _nvme_connect_subsys() automatically finds the port
> > for the specified subsysnqn. However, this does not work for the test
> > case nvme/003, since the test case connects to the subsys for discovery=
,
> > then, the port of the created subsysnqn is not to be used. This causes
> > the failure of the test case.
> >
> > To avoid the failure, introduce --no_port option. When this is option i=
s
> > specified, _nvme_connect_subsys() skips the port finding step.
>=20
> Can't we just figure out from the subsys name if we need to use the
> default ports directly?

I think we can do it. Instead of --no_port option, _nvme_connect_subsys() c=
an
check if the subsys name matches "nvmexpress.dicovery", and make
_get_nvmet_port_params() skip port dependent parameters.

Having said that, I'm not sure if this is the best, because this will hide =
the
nvme/003 unique operation within _nvme_connect_subsys(). See some more
explanation below.

> I am not so sure about the --no_port argument
> is a good idea. And if a test wants to use a specific port, we have the
> port option, no?

AFAIU, there will be three kinds of _nvme_connect_subsys() calls from port
parameter point of view:

1) Default port(s)

   No port related option is specified to _nvme_connect_subsys().
   _nvme_connect_subsys() gets the ports prepared, and refer to them.

2) Specific multiple ports

   --port option is specified to _nvme_connect_subsys().
   Following series will add tests for them.

3) No port

   nvme/003 creates a nvmet subsystem with default port. The test case
   also connects to another subsys "nqn.2014-08.org.nvmexpress.discovery"
   by calling _nvmet_connect_subsys(). In this case, port related parameter=
s
   should not be specified.

To clarify that the _nvmet_connect_subsys() call in nvme/003 is the 3) case=
, I
suggest to introduce --no_port option. It will explicitly show that
_nvmet_connect_subsys() does the exceptional parameter preparation.=

