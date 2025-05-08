Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BE4C3ABBE
	for <linux-nvme@archiver.kernel.org>; Thu,  8 May 2025 21:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=doCQbc0rewYSB5wxomDYL+KpbRLKLIXpi55re3MHdQs=; b=zw3CyH8T2TzeKovmm4jngW2W3o
	PxuCPhSetZPXAuJITREWejXEZhw+BNl76cX5LyMKU9F97QMJJCVdTamcCq4RXIzYbK47ohP1PI3tQ
	4k1mdO+fyeuc4x6dTK5aNgmhrns9OsxT221BCXJuoYt/Uf1M2yzdUUnkklSxOkEr4J6RV5ZN2kQtC
	iO1leRFbgi5QAl/Twl97IZkRA39ewt66ve76O7ZP7aQjPUr25vYzCGeiK317XtnwIblIZJ1Ro82co
	xQiUV3hbEcYhN99p7BMtmfQaZ4fUyEtNILlkSHtUqcwBE+rkFtXKjDWJHbn71sAmz1wtZuU0OGpDT
	8xo0AHDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD8iu-00000001puB-3eeR;
	Thu, 08 May 2025 21:24:08 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD8ir-00000001ptW-3j1s
	for linux-nvme@lists.infradead.org;
	Thu, 08 May 2025 21:24:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746739445; x=1778275445;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O3gIK9fSUnJe4/D65GpDhJKJgmafQlcFJkfomwbuGRI=;
  b=lyH2vQ8dYZngpcxJ81OkEUQs6llMULeDuql7y7GqgDYTKdDwvuqeNr87
   /Yvu3kIlQOWxC34fnIjyJBBDpWNzxLUrYatbz8UjlZu4S1upw31n0fPGf
   cScvWythO3VxyGPxIcUpHyFmWNg5AFiB5mD8XiH2TUdzj8jps4TzKWuVW
   gHBA5BGA3sEgKav4v4QC6NpE0IKsO82N5veGLdgqvJf65y9Uak5/Jvw4/
   ApOexRI7p0TS18o0ldO/gbFh5npQpMeZ5bV5uz0jWHaxZybK7Nuf4PdBW
   sKC2bVuzeWB6MGtY+j4VWkPGcWghB6IVGEwWHUdnbTOjQYF0FZqa1IdML
   A==;
X-CSE-ConnectionGUID: gsU8V42/SXO2HhIOOvnHLg==
X-CSE-MsgGUID: vNLH8/r8Q6amLktV9NwZgQ==
X-IronPort-AV: E=Sophos;i="6.15,273,1739808000"; 
   d="scan'208";a="79842443"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2025 05:24:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hI+zYicnwbME76/L1VVC+ELqWKgoH35OpGPwyTkUB7hhDPlZ4Sa/xy7bZXdq3iQWy2mP+AwMStN2IEhhMNOWOojgPQsqqLM6VgwLIBc8Y0HxEZzOH52IY0d08bcjgGHEz/efEpcvMSYkAmwO+zIyTyDjSYcxM96zW/yBlS8oy1St86O8Odf2rqE/ZusmwKqJdCNVY6bolZTpfPgghPLala7zSaoDaeDYGd4Eh+wuPkzTrRrXI/nydc48QMTblumx/ve4ucZaERelVCVqxs24jXnN99zrRO93qVwHfOMxZ7Pmi7erJTg1IG6lCAHz2coA/3+Xd21CDl3PR9TAK8hlGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=doCQbc0rewYSB5wxomDYL+KpbRLKLIXpi55re3MHdQs=;
 b=FIS6Q7OQsgjZ4EXe0oqcD/RbAxnvAahujT7mmsbCa0YWl7U8kA1N0dXUaRfMhFArH43tV4ipZZgFtl/rI4njPzYNfrE9k+zZ8tV8V2sxaZeU+qIHzM9/dxNxHM79Z50q3N8Ha0WiXp4Le2LXygI1Do6okYpjKqQWLnzdjndLtDQFppURQig3RdBR93m7nBsMvX9iqFgsuC90LoZxTd0ReXSMtye8Q4pGjEqX25MQ6Z0Jsic4zdc7w9d4bhGCc8ZviWcfBkcFJT5GDvdJwrdj+jTEnG/VRHKCk3vUZTvlKYzeroDwm7prHlEHW0L+66xL1l4yEVkO059MxAe3l6tTGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doCQbc0rewYSB5wxomDYL+KpbRLKLIXpi55re3MHdQs=;
 b=h1qb17DbPKPS80D43SPlFdSZVq7PHwHdmakFkcTd0hq4E9SSldmUSQVfAZAibk7hs2KUFbkSLm+wt6S167AazG0ya2uiB45NQhnVaIB1Vez710UP1Jh0EZ5y6qIRi5JhtDaqp8+NA7ioB9IXH5PbWyfixoL3rcpUrdIOLKTQkA0=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by CH3PR04MB8876.namprd04.prod.outlook.com (2603:10b6:610:179::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 21:23:56 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 21:23:56 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes
 Reinecke <hare@kernel.org>, hch <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Topic: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Index: AQHbpGZdo3Xoo5WOcUmvA6U4U0rVxbOkYTuAgADyiwCAAK1uAIAA7l0AgAvfEACAAkIngIAAA8GAgAAZ552AAkkWAIAOmdwmgAAIp4CAAc92qoABUZQu
Date: Thu, 8 May 2025 21:23:56 +0000
Message-ID: <BY5PR04MB6849CFB39AB3E98605D30C4BBC8BA@BY5PR04MB6849.namprd04.prod.outlook.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
 <eda7a691-037b-442d-bd36-a31f93e95cb1@suse.de>
 <976af4b7-578b-4e47-a2ff-7c74af0b9afa@grimberg.me>
 <30b16579-1a28-4d01-9afd-8ff3996db42d@grimberg.me>
 <BY5PR04MB68490F6DD7F1FDBE6999B54BBC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <6202ffd4-4a32-4f85-ab87-ac5a087c2f1a@grimberg.me>
 <BY5PR04MB6849D4BF87755B82A073BBDABC89A@BY5PR04MB6849.namprd04.prod.outlook.com>
 <4cff2b68-32e8-4593-8a91-345171ae147f@suse.de>
 <BY5PR04MB6849463BE09E64B198950B74BC88A@BY5PR04MB6849.namprd04.prod.outlook.com>
In-Reply-To: <BY5PR04MB6849463BE09E64B198950B74BC88A@BY5PR04MB6849.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|CH3PR04MB8876:EE_
x-ms-office365-filtering-correlation-id: 46784c84-e54a-43ab-c16e-08dd8e76a417
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?cSV4LOSKXTmFIWFdzvoWToFES67MMbrzSv2WpVsyy5UJHiBaHEynb3pV3d?=
 =?iso-8859-1?Q?/eOV+81CxCKveNIPhLPxXjDZb2sdYEz2uPgXO7St64us7ksDl1Fml+MlQ9?=
 =?iso-8859-1?Q?dirn/t147l1zO5WiJ8PqfBrNiIGPWkFKFB0TdLH0Eh9vtcfhebXnJ+9hh0?=
 =?iso-8859-1?Q?mUf6Ex3oYIsX6GDlsiq+yu+NEbXN7JfQ/4Bpa0bLfOdfghrTx3+2Zwtfnx?=
 =?iso-8859-1?Q?kGvEWoBfUyJp9xR27qUjYtWtITvpGFCP9RumRWauxdohFdN/zhY4a8L4Q3?=
 =?iso-8859-1?Q?KP6AQehpG3Lo9u53enK7QpKFuYFKBxNKZZwMff11CdDlWTMlid+N0j5bsu?=
 =?iso-8859-1?Q?HuGp2LW5RP+7EXdadz3Dh+GkrqRreR+tZ1C1oN1lNA0EtTJZAWo30IpmFJ?=
 =?iso-8859-1?Q?+THq7OT/4W3rrclYOUmcbUPQoPv1VEckdBCNgypd07vRWjE+Q/zTynd1IM?=
 =?iso-8859-1?Q?y2sLqYiHvPuAShobZQYwH5dyc4AH8rfhanmReonVAy2PZMpOJqqKK0hsib?=
 =?iso-8859-1?Q?+ZndS1LL1QQeR81kb5XdMnafzKpqYeaS6FP8akfaSzGVKvnRt+n7lzfqBH?=
 =?iso-8859-1?Q?QCZgDCViTceRwwFe3ifvaW5KF7t+CSd9aKJGUtCz4OkzBTjxTXczHGIKTZ?=
 =?iso-8859-1?Q?j9OuJDP85aSzm5F1DZPJ7ZCtvL1bafKRA3016x0az6L2RS3fTZWFkkuKTj?=
 =?iso-8859-1?Q?b9WH2+78NppnJ9fkw3gbnk6ApM3HCqUbd10qsl4UbNX/GixX9rq8nBdK+4?=
 =?iso-8859-1?Q?u+g3JfbuCjdj9EdN6CA5XFuMg+BWo1BBb0zYssKpk+zlmGI2gpo2yAEtcN?=
 =?iso-8859-1?Q?QNc6RypTGxomfvPS/ZfucugO52EhQesOpMoyj+ADfVLtwgmluYSO0D1hWr?=
 =?iso-8859-1?Q?YduTfz7cezoeham1i8KPyOThZ5YNw14DxQj3E2oGZ0r5MEFmWrNLGJb5ZO?=
 =?iso-8859-1?Q?L8mqHM6Qex6T23m3OVq+MkFzkn5/c8nSwGYYBiNyHtI+acj2vsoKHMgdpD?=
 =?iso-8859-1?Q?LX50aBiq8KyaIkrXI56bCC1+bs3uuO7XREljDl4dBBKqJGroH2wxY4Xi2+?=
 =?iso-8859-1?Q?L8fO7AIhKYt1JLYv2VcyXqXqaxqeOZQ15ShHQ0HuLROdgJczXXWoX4wwvR?=
 =?iso-8859-1?Q?xefpjC6E8zsovtDFQXVA+jP3rrklaHoPUN76RKxMiv65zXYHEX03fuf9oA?=
 =?iso-8859-1?Q?pOlmhAOix0BtZzyNb9MG1nwQ1Qoftub4jwfCfBEVOEZRFXvI9K+z4CGbu/?=
 =?iso-8859-1?Q?uiWFVQ+uZCUgNNQvAb1bvix03QaNlRysA2ER2cQTSlh6FytqJFDZCahEy0?=
 =?iso-8859-1?Q?wEYJ3qH7tZ3os0kjFL8ajfDiVk9Z7nfJ0xqhhgbW89YTD8jAlxP5/Gbi9Q?=
 =?iso-8859-1?Q?WZgnNEfjIWDY1FkwD9dATJ319bJnFwcp+e0jLZ865Uofh7iiDCQa0ZebXu?=
 =?iso-8859-1?Q?sv9UHaMZsmd7MZwlLOpnmzSKcm/1qPG0kaMV0rHdm0D2sRtqu+zXMnSxmt?=
 =?iso-8859-1?Q?alxsS0/cEUR89E+58YD1RZCvgkmwIQxS3O6aDC6a2RPQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nlFLynXmO1eC7Vnx8ZKiZF1o/dQJIP18h20jNlzm80NK93begkeKqnvHDi?=
 =?iso-8859-1?Q?UVC0vPk1bzklHKBzdA3aCmTALLxhZDhTIqg68+tyiprgdy/MmxUFZMIt+2?=
 =?iso-8859-1?Q?77OlpoCA53EzS+mV3jb2vxgR5jER2hnocjR/MXpy9kMLk2Fj2trQvys3T9?=
 =?iso-8859-1?Q?T7wuYHUuDgr3bQh2qq5TGNzmNvEWZQQ+GeWGW85y+Sp6mttBWWXxpbIVBs?=
 =?iso-8859-1?Q?ZPsDNDbTudDQ8YMRKAcl/qvuGHYalKMqwIqXOo6+moy1ZEIVx8mgEjI2aV?=
 =?iso-8859-1?Q?+wRItMVdjM97Y8csxDTLPYHUmw52XMY4Ntuf/1XbL29ONYWs4HrNwLBjd1?=
 =?iso-8859-1?Q?Vb6j+r+VnyeRAw5taomhk1kYHNhNJ/GUsgtfMwb6K8DfQfgZbHKKNG8wwi?=
 =?iso-8859-1?Q?Ycu8YIlwHIPOlcNZ0ib+Ra+NSI9Op49Oj457pLFiIutCjmVpjj3psKQpxf?=
 =?iso-8859-1?Q?JWlaEUv6Wi9p+badMb35tHCrTk9cxQH3Ye3TkpaaNVSFb2uu9vQFLAUx+p?=
 =?iso-8859-1?Q?7iimRN7HG51jXF+IulGpCIr16IDLzlWU4JvTrCzHyVvRLidnkGf1wpe/uy?=
 =?iso-8859-1?Q?WM5B4js9P3wfss7xfuav0td/+slm4bv/nGoGr7fvWhfgfNv5CuRJqEkQpE?=
 =?iso-8859-1?Q?APetmnPbrVWdJPuEbhiWOIDjdB3dj1UjxCHT2WT+XWIDL/OzM4HehTPRkz?=
 =?iso-8859-1?Q?Tz1RRvqExd4XYukxKgcuLmPN556Hc/o1Cen0gsjfJ2VaS6g4WxqfCMI4o8?=
 =?iso-8859-1?Q?Pt2aVqVZ2Jdt3DDjMeqytLblBufJtx+WVNth+xGqzyCMLEqIpHXrL1Jozr?=
 =?iso-8859-1?Q?pfej3XgLQE61mWr2f3C9O4rr8hR8dkubBNBPxhluWUiQyJq1n1iBseHWKv?=
 =?iso-8859-1?Q?0A64XdR8ucguXUu4wTB/KWadTaxCtySjWzquKKxK52qKygFj2Lpl1xpsZR?=
 =?iso-8859-1?Q?d6GDrrpD5tPNhkBxoFXotJMYo8a7LaCRzT8/JFsTrgY+LgkRc84S8chFG5?=
 =?iso-8859-1?Q?YCnhpdgcwh7ps2fdl1btCClUNauI6pYiB3ScssyNcF84ACiRMfjm/PkvWV?=
 =?iso-8859-1?Q?NXWYXAx7mw32UvyBF+6zbWmI3ytyAosDxdKlT24Z8Iyz1jJxX3XO5KMKG5?=
 =?iso-8859-1?Q?bMxg4YBKhwW//pdLsTuZzo1P4BJXIa6K0HzvIhtKI/9Nh0edkggbC7yizr?=
 =?iso-8859-1?Q?zU7AxGmI2SzMoywACKI6T3quwfx7AYYvli4f0ccP89TFF2NRiPVNEJUcI8?=
 =?iso-8859-1?Q?o6K3a+P7OxiyATYQBRuFog27CZvVY4zE7P12eapgXPx3LSe1ANFTVt9/T+?=
 =?iso-8859-1?Q?6atOUohVT06dAUCN2+CxN1qo1dT9o3/E7fbTjaun6zdEqBX7B3Sgvz9qAn?=
 =?iso-8859-1?Q?9DuryTIBk0FqpqUo+VO6BZ5uE2cw9TrTSVL2JBD38dsPwbCrz0ub12ZdDB?=
 =?iso-8859-1?Q?NQuAvJ+tzNhmRrtPTHTijDhGU1iZv2Kfgvt6xkrcpjoEDPSqBpRjNk9vz7?=
 =?iso-8859-1?Q?bbpIPl4oBmcjo8FieqtK9P/utDo0gZnkXHgMdBw9U00N0Gs6D4hhkVcacr?=
 =?iso-8859-1?Q?UIbaDPwvOC3H1eXWZjIBaBrLr8Tkzt0dzrV0/nqIR9VYRP1LDtWxKrXVkA?=
 =?iso-8859-1?Q?0UGIsuoXnsxR+0tTwhnFIwwN3Yj3rAYjGw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tR8JfxwCsiCDXzT/SqD1n1P5ho2FEEy1bGfJN8wjDt05kTS2dBYgi238/6yS1V21UvNx8KM1u35k1KKHUe5Rl2wGTm1g7PsPhABo24zIjLC5XwO0w8JP1xg0nPrycP6GRuHM6SP2W478gvJFyo8JQaHUcc6PNCxlaxkpohpU2fuRt3+HMStI8+As5XqB0Km9B1WXHQIqZ9KqQjTS+2cUmk8umsQz/Y1znXE/O7btMI2WeXWkJ/aPS73F51BbGsy7eZzVL90FoC86JjlnhVa3TZCOQZ8fURgLCRhj8ucHzgRHF7sy5NwpLRjn7Cc2kTRHjKW3k4QiN6wOgV/6NzGEbXGuHF+PX0Qkn38vlutB+9AhvlqpJfw1Bf/LCXFwa6qUCM1vW59WijeCDk4RC7HzJbykhpLLMhH4Hyml/ENt2b+mdyz4fpPVXb5zaKu2SMk7nYsNnhE7xpRhv62RykAwCnHdwlyNr3ZqmhsFRVcDcxlk7UjSld0gII3EnM/Yg/6IRhVniQOqnKQT7Yzrn4HWFREdkAfdBhQld5i1kbv1/GV/gXI++YmTmw0EJp26PhORTV7jjkRl/2ZuaMzREqkqINScuRl/vphNOEin3i1gFgcb/SIXnK1zUTzd66XfLEdg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46784c84-e54a-43ab-c16e-08dd8e76a417
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 21:23:56.6432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q7E1gwG8vSedyXwniYqwFvlftDh5LqwVA05ow5vC43ZnWeK7cnExHTLLFD4wMTws7KL1GtosE8Z5IPaSSk+e3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8876
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250508_142405_957532_79CB2A41 
X-CRM114-Status: GOOD (  12.55  )
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

Hi Hannes, Sagi,=0A=
=0A=
On 5/7/25 15:26, Kamaljit Singh wrote:=0A=
>>Can you please retest with the patchset '[PATCHv5 0/2] nvme-tcp: fixup=0A=
>>I/O stall on congested sockets' _only_ ?=0A=
>>(on top of nvme-6.16 latest, of course).=0A=
>>I think I _should_ have included all the suggestions floating here,=0A=
>>but we need to have confirmation.=0A=
>=0A=
>I've built the kernel against the latest of nvme-6.16 branch along with=0A=
>these patches. Its with test now. Will let you know when we get some=0A=
>results back.=0A=
>=0A=
>0. [PATCHv5 0/2] nvme-tcp: fixup I/O stall on congested sockets - Apr 29, =
01:18=0A=
>=A0=A0=A0 Hannes Reinecke (2):=0A=
>=A0=A0=A0=A0=A0 nvme-tcp: sanitize request list handling=0A=
>=A0=A0=A0=A0=A0 nvme-tcp: fix I/O stalls on congested sockets=0A=
>=0A=
>1. [PATCH 1/2] nvme-tcp: sanitize request list handling - Apr 29, 02:31=0A=
>2. [PATCH 2/2] nvme-tcp: fix I/O stalls on congested sockets - Apr 29, 01:=
18=0A=
IO timeouts are still occurring with Writes. The only Read that timed=0A=
out was most likely due to the path error. It takes ~4.5 hours to fail.=0A=
=0A=
However, this test does not fail if either ECN is off or if digests=0A=
are not enabled. These passing combinations were run for 16+ hours=0A=
without any issues. Both ECN and Header+Data Digests need to be turned=0A=
on for it to fail.=0A=
=0A=
Do you have a failing test as well? If so, is it quicker to cause the=0A=
failure? Would you mind sharing any details?=0A=
=0A=
  [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 2 (f002) type 4 opcode 0x1 =
(I/O Cmd) QID 4 timeout=0A=
  [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 1 (2001) type 4 opcode 0x1 =
(I/O Cmd) QID 4 timeout=0A=
  [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 4 (c004) type 4 opcode 0x1 =
(I/O Cmd) QID 4 timeout=0A=
  [2025-05-07 19:57:13.295] nvme nvme1: starting error recovery=0A=
  [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 15 (000f) type 4 opcode 0x1=
 (I/O Cmd) QID 4 timeout=0A=
  [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 6 (5006) type 4 opcode 0x1 =
(I/O Cmd) QID 4 timeout=0A=
  [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 3 (2003) type 4 opcode 0x1 =
(I/O Cmd) QID 4 timeout=0A=
  [2025-05-07 19:57:13.295] block nvme1n3: no usable path - requeuing I/O=
=0A=
  [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 8 (0008) type 4 opcode 0x2 =
(I/O Cmd) QID 4 timeout=0A=
  [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 14 (400e) type 4 opcode 0x1=
 (I/O Cmd) QID 4 timeout=0A=
  [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 13 (100d) type 4 opcode 0x1=
 (I/O Cmd) QID 4 timeout=0A=
  [2025-05-07 19:57:13.295] block nvme1n4: no usable path - requeuing I/O=
=0A=
  [2025-05-07 19:57:13.295] block nvme1n4: no usable path - requeuing I/O=
=0A=
  [2025-05-07 19:57:13.295] block nvme1n4: no usable path - requeuing I/O=
=0A=
  [2025-05-07 19:57:13.295] block nvme1n2: no usable path - requeuing I/O=
=0A=
  [2025-05-07 19:57:13.295] block nvme1n4: no usable path - requeuing I/O=
=0A=
  [2025-05-07 19:57:13.295] block nvme1n2: no usable path - requeuing I/O=
=0A=
  [2025-05-07 19:57:13.295] block nvme1n2: no usable path - requeuing I/O=
=0A=
  [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 5 (5005) type 4 opcode 0x1 =
(I/O Cmd) QID 4 timeout=0A=
  [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 7 (0007) type 4 opcode 0x1 =
(I/O Cmd) QID 4 timeout=0A=
  [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 11 (a00b) type 4 opcode 0x1=
 (I/O Cmd) QID 4 timeout=0A=
  [2025-05-07 19:57:13.295] nvme nvme1: I/O tag 12 (f00c) type 4 opcode 0x1=
 (I/O Cmd) QID 4 timeout=0A=
  [2025-05-07 19:57:13.295] block nvme1n1: no usable path - requeuing I/O=
=0A=
  [2025-05-07 19:57:13.295] block nvme1n1: no usable path - requeuing I/O=
=0A=
  [2025-05-07 19:57:13.295] nvme nvme1: Reconnecting in 10 seconds...=0A=
=0A=
In the current build I had these patches on top of the "nvme-6.16" branch:=
=0A=
  41b2c90a51bd nvme-tcp: sanitize request list handling=0A=
  9260acd6c230 nvme-tcp: fix I/O stalls on congested sockets=0A=
=0A=
Thanks,=0A=
Kamaljit Singh=

