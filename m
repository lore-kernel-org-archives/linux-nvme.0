Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B98D1267D
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d71edLFpVg26DFPPeX41iKmGDT/me3ic9pw4ZT4Uquo=; b=NJWDhPj3MnlIqm3hmyLKCft+c5
	KGsMwCnxZbuCK5EXJpASQ/Y17iYU73tTv8upzUFRCqVcxe5Xj3pp6lD5+U9AIq09pNIyxG6UuGCJs
	hZHxPwqJbK/5x1Il/MVgv7qG7M/9CzqnS1N28Op8+DOP57nuB6t+N//XXGoeIAejsF//D8My3PLTO
	sRAu6J0bYcy5HmJ+EVuE2484hjfJIL9vDj+NuA5HdBJ+/eRuNzQo0/vbFJoVvU4auJP6/0Te4iQEx
	fXhvmYZQzLhX2Yjs4knehvNdG+dXpj5JaEbaNzkQRiBUGe25cE6jP9sQyQ+qTS7j8YEC43HBPgeRy
	anbnP6rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Gp5-0000000GfwB-0QMw;
	Tue, 05 Nov 2024 10:30:07 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Gp2-0000000GfvS-0YAO
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 10:30:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730802603; x=1762338603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d71edLFpVg26DFPPeX41iKmGDT/me3ic9pw4ZT4Uquo=;
  b=XJyg2rHMEISEN3PTwIbICL1st5Jbkngb35tc4MWbFiOtEH242Ec/Zo/j
   68wc27WMM25aQ6XMaUuZdidN8HqYrc9nEEQ7mwh9T1Owwflqima7Ir5R9
   dm78eCzaPp10Og9mab/ImtNMG9nqehBlgov561Pfqafuicg90JOIdEkog
   NVEhUywh/VwbgkrQvEwifYXklkyqYISfmWY+fR404WynV7B6IZI/9NXth
   1o1HNMC71J/gcQDNN/03LqLe/bAB2o22EHfoeCoyJrVoRc7e0OKTGb1TM
   AxeITHOEgYSLAhOO/seInyupVgVnhhETrFrmEORs4NT8jLeAQ1YdHRyXP
   w==;
X-CSE-ConnectionGUID: gfOurCXRTi6GRIESUOZ/5g==
X-CSE-MsgGUID: CMLkJ8f4SKSf+a5xNITG1g==
X-IronPort-AV: E=Sophos;i="6.11,259,1725292800"; 
   d="scan'208";a="31787151"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2024 18:30:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkIAPMg7H8UAnVl4izqIs6NSwu3OalpgU0bkx1gWe78uI9t3vmk7DaG2r6tRtuSsTzcZaFTGxQneKBrgDYYDfLjADyjDHj/qOCc/GfoibXzrLBNiFTVI1meceAOXEbc7MwX5mTVJ/ql2jN1Vu0TahpaRhv69oKEZGlioOKIcsWZOUjEtpxc+Sne01w4PY8PUTRZi2cQLr30+UaaE1xuqFo37ZXZTpo9Cok6UYLngheWL7wcVnS0g9aCPMDXSfGRVZfzYpONbUUft/r5dT0LwG/ufhW2t+cffhLONcW3mn30rWqMQyvT29LYuNaAc2LV1hS3KlvS7Mv0WutUzvHt5Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d71edLFpVg26DFPPeX41iKmGDT/me3ic9pw4ZT4Uquo=;
 b=pS2z7SxKOCIDehrO04xBFkJaGnWHeQYO+dcxuKyBuuoVKUvr3BOsnV0dyyDIPTFb6zgEmRLz9nKnP/S5WZXm8fZ6zQj3hQItU/8GtjHtTk2FCuxFjFgi4nu+imjktkGtSP1yHZNvkRexRVR0TNVsA0m/9q273KBUPysyOHER7UevOA7NmNrdLKNDw/o/zqHxRCvFoVPs/I/JiTVouXVZ54dMpRSmmWPJlIz5vUdmT/FDGNMCM/c6DnCMarCr1Qi+P0R0DB6wjm7L1MwESFd4tZ2yAUtDJ7HzkpIbsOaPAhhsdaB2Qy9+MYnwTT3CPNd1OuObMdp+FFVrrWUsyCdPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d71edLFpVg26DFPPeX41iKmGDT/me3ic9pw4ZT4Uquo=;
 b=S6KmIjlKo0rcawKtNhlBu5Q6Kzr6HjCWRDdfjI4WS7flOXgpkw6Tu8Vh5Z9jnXUHiNAM+FrG55VCeGLIOKM7yyWKoXhXmC+Icx9Q+R/CLK4Gq4m9i4EOtA26muWGcWuYCaai9gnvBmtKSDe15qViPvm3tUV0KCFUCRbAjTxwCo4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB6995.namprd04.prod.outlook.com (2603:10b6:a03:22c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 10:30:01 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8137.018; Tue, 5 Nov 2024
 10:30:01 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "dwagner@suse.de" <dwagner@suse.de>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v3] nvme/{common/nvme, 016, 017, 051, 052}:
 introduce def_nsid
Thread-Topic: [PATCH blktests v3] nvme/{common/nvme, 016, 017, 051, 052}:
 introduce def_nsid
Thread-Index: AQHbK33FEH1+ftMq1ka14MZM/1hY1LKohFkA
Date: Tue, 5 Nov 2024 10:30:01 +0000
Message-ID: <uidk3q376j4rahmw5wnpnoycd7pb4nvgzr723okznlx3pkejln@hssxf773zv4q>
References: <20241031101455.29273-1-kanie@linux.alibaba.com>
In-Reply-To: <20241031101455.29273-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB6995:EE_
x-ms-office365-filtering-correlation-id: 3667944c-1f4f-4c02-294b-08dcfd84cdee
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?t5ufZV1Gq+40FZ+sGFvsgmpPL1mk2fyUNe0HWyFscdb4MPWQsmk8Gge4TQlY?=
 =?us-ascii?Q?YaYXl/iIA+dOgrO/AUS/L6JIsHSOOHpE7Bd3+gy+WHdE8ceV5rqnU6gxR5P+?=
 =?us-ascii?Q?qsskNrPjFpf95N9r2Ozs/U1ot3mmk71v5iP29ziUP5itLXpK1ZDTnFzKcZjK?=
 =?us-ascii?Q?wL8i1epWVTZikZu8vXysn0MSb6nToW6K+dzyZ44dCY7uATGVPTHKJHXlBTjw?=
 =?us-ascii?Q?pffLwXhxytp45WYQiap8gkQkBv/+iIyCQDOpDTZhkUzOBtBsMKB3dchQUaOf?=
 =?us-ascii?Q?8O3ngILvaDdhfNkFcG8h2nHZLy0DOjyBYqgDlsw/EltYxXH8eEfWWRfKNehX?=
 =?us-ascii?Q?CJ5mGTda37wgRccynzymOSkUNk9Yl/CEuOtG/OA0xaNyhyr1OGJlTUcKTJ+w?=
 =?us-ascii?Q?XtduTkTueUeckiF9mhZ5ZHtIh5idIwIodJ36U0D6/IdQIqUD2HfvlcRSeHSj?=
 =?us-ascii?Q?XIhrDZyfJZ2Qm+rD3+22hsTOVrBWZWqrMTX6/Q2dqeIvYNS8qsgNNlitsnze?=
 =?us-ascii?Q?HS0qeH26hrfJ/VKMiCkUR+lrBBHzAtFVuIplo+sCPZBN1FEutoYREHo8CbN4?=
 =?us-ascii?Q?Oac+D57Qmhvn/b7BpmUoRrVcIydt5anWJylxT99JYRDDqRWc6rPQ8rMoZOSs?=
 =?us-ascii?Q?gBqqsHcFj37ivBsIxwya1s0h4vQy8LT6S6xGVmdopj+KbOcdXtVy+9QF1J4l?=
 =?us-ascii?Q?evYly33ZHuEr4SOkGJYASkObgFPQMt5H13kQCMqbBb/7o2YtUfL3k0eQk1oW?=
 =?us-ascii?Q?4Vnc05lWmANr4kIdiByn+TsE868gBnCYycPuLkwZy8Lsyg34wk82Iy6AUXSu?=
 =?us-ascii?Q?W3c6vwKIgsQmmz/+tICh+sY23C38sb0zDkKKC5eo+AWOvOEdTUUl4jYn4Azl?=
 =?us-ascii?Q?VsJHgSwbmU1Pz8L66svSOFSZbeIxyViHQbK0DU5MY5CAQPJkCVLpXTrH7Eq9?=
 =?us-ascii?Q?p4Ak0Cj2kq0Y0KV10LYReuWi7+3R1LhPnsKBxwCl7Voyy+ImBQZnfYxwFQeE?=
 =?us-ascii?Q?xoVUr5xI8x6S09Z0E14jL4EbjPB+DZCjQwU/90s/ABl4EmaJmXt6X4ujkjQn?=
 =?us-ascii?Q?ZlGQj3RTaFhlCFxMjYKeTnnPi7mdokz81uXa8x9yZ+eSgpNPVr+IsM1yMeH5?=
 =?us-ascii?Q?blH9IDwyLYrmLSmIKIvaHO/F7c5EsUI1qyKwA9JPDXdiUHApQHefTZffsZ3j?=
 =?us-ascii?Q?TKPjM0c0S3XQrPZqP+8MGb/qCbFMDhrnDKaEArN9SVh6vTTBnOVqqrl07+7k?=
 =?us-ascii?Q?7n51OUjUhVWDkcWi47xEFfrIBlWGPdiiKpGCpPtv3XZ3SbxlomWvz6vFC1M5?=
 =?us-ascii?Q?cHE7bSFrpZ/qOqygWLu3900M?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tvF8J6Q3F3qvt5aZ0sRvQ9HT9ZcB/8rtEjFqQMozhjfb06IuDjz4cVuwYouH?=
 =?us-ascii?Q?XPXxpYiQctbFJiH6K5oVICGsA3ABSwk+6xL9vrwjQlxwLHtF0s+S35RPeGM5?=
 =?us-ascii?Q?yqSPTMKYcJj7qCnNb/7/pb+zpvGl1Z+3SI6OpmdMvJfvQ5FA2Gko4o9jiI5I?=
 =?us-ascii?Q?gyJeGI8XKnl9YNa+qAJ4esvwOgb8EA6aNbinCwc9l4RVo90NWA3564/wfYoq?=
 =?us-ascii?Q?Bq7fugGevT1cPnkM35pCjzmFjIr/TU0Nbv7i1iFM7taZUx1eLljLBdRPKQ5i?=
 =?us-ascii?Q?frXCvMiFmkTkQoAN1p4DinJm3u+8X6U1MSeFHTXb1ALBDK8SNqPJ7D1mpaCC?=
 =?us-ascii?Q?mCOrkOIQOb4Fi5kMa6HQXKr1seUVQ3ctx8Q4l3v4b0ZQ/j0RNlvEFr+QyTrp?=
 =?us-ascii?Q?b1PZ+LusS7qoz+W4QPR2FoBkNnCpUiy5LjGfgUi3o8Hge//7OBkNBxLHf1YI?=
 =?us-ascii?Q?qE7Hia3cfBlaF1TwTd3/oH4SvfQ1JRJZ57QPF14vZGdjN3imZFe5r2qMVnUY?=
 =?us-ascii?Q?g9wUvR3D/Jaka7QvjkEJ6HHivglpqOvPm9hjajxvqVCAALcWy4LyNpq/GmFs?=
 =?us-ascii?Q?R7ILFf1y6+AgAsgZg/fL1Do6VAiDFP8CX67GafbPBGB+0oHo2xQf6E1oT4kn?=
 =?us-ascii?Q?9bmz+Phr4L55BgONGHYRsJUfuRF2Id7CLAeT6b2iNj0phGp8q+jzAJA7M+I4?=
 =?us-ascii?Q?ojxESlstiyU18D12dxc/51LHKW4unPTLqBg/O+2ulaSO5JuR8DDo9LJbWfFI?=
 =?us-ascii?Q?j39FD4muPjYokAJw2WwQ7sp/nPJlWyd0x2p18QFmB7lfTrwpCbZLA70D7gzs?=
 =?us-ascii?Q?KEuTlzfeeKvM7G8HyBkP93xK/08zjKpyj1t1MUEJBHb/9dvcVsh7EcLo71TE?=
 =?us-ascii?Q?VmnQw247xm6Lv0E/3VsEBdDANrkUw+WMwJ1gO44afW0jjpS2GpdTU1+vYaru?=
 =?us-ascii?Q?tML1Xg9uqN0OeDInFZRrfRwbaihX1yqgTE7OGUGwIZ2iJgwixc99jMwAGnSI?=
 =?us-ascii?Q?BpBOSjHH7MTo33OR+NEprfCMolUkcxhaLX1qcp4r2toVZnBtNvUoDOmDMoEs?=
 =?us-ascii?Q?HYhHeQMPop1hUcIJ2BoNk6GRBCsMqBHOThIx/FoiW6GFJcgVRSZGpFmkZshd?=
 =?us-ascii?Q?Atn2OexJiaUwnWd0GAIz9PDf9ILUAToqSn8NpT2ZPs6UNawB48/77BfpmUgL?=
 =?us-ascii?Q?gwoSpjghhVNmhWdqjm7kVc7OcIMpfn09VnMlI7PrHWPCksfFrKaJYuIjQBtD?=
 =?us-ascii?Q?qJg5VFyXW5WhqMgi797cI/u4cvPvhpaIDc3DTq8vb9fDhBQVOY14yy9aBA4s?=
 =?us-ascii?Q?MS2DNovObA0wBc+uBY9nptn9/kgt+WuqvNxXMEnf/skkeIQUE35lQ7SfXThS?=
 =?us-ascii?Q?FAEkuw3qfZzx/d2RwXfraBRs+NF1Ke4JEiiiSOmBm0oqWG9O+ItpQnHf7R4j?=
 =?us-ascii?Q?p52UGSSp3T4KpAJK8+dM2UCm5KXxHfVinZQt+RegDaeAUx5vr2h/lFOKAUMG?=
 =?us-ascii?Q?MqRxmHclDzuMMnRM9YLYF99DjxGkOYjPqr5ecvJ83tfE1Zesb1RxBql0hCx0?=
 =?us-ascii?Q?Kxw1YZgohhFDXNQBDzbQe1oBosa+mhaNj1nT5HB41961EVdvaMzgISq9nuZ6?=
 =?us-ascii?Q?tb926DYMuPf/plkSxP4wKLA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <77FF146ED2CC004ABA916795E96EFF4C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GAvoUGUKx5NALQyxR+T3Y3hTEPj170S4y4w57c2p+XqXHukp7oUPsUM0ykiJDUNG/s42D07BIya/njNwkyWAPk0e0ZLp40DjPC+10cA/V0CPAf9RDKZFuL1phHWksF92WRG4BlvD3GRDFa7tNYE3A2x5+nb1gcJI5bRZZu2xZ2wg/mk7STXQVLSA+7jyIHFHUCMM/fSFoFNwNDspaJzOPiLE2rDMbPZu5/Gko0bQZpDbJ61jX1cCSeU0ygM05JcKK5Z3oRyqjfrhNRqoghQy4Kz4HDu3lQK4BymnJFJMgsdceAFk2jVhUXfi+S8U8xosiuvnvAJaXzsYTfa/qClOcE1JpDhYjyNRq8l+S8tPE7Q3LbrFS7XpTc9ODRZrlLYlaHkyLnNxCbE1TPZhuLriI2XQq1Kzt5TZAVHPLTW1hb3+xqqqZ8wgwkBlGS+9aj+I5Q/2BMWhuWyzyl34imFt2joW0QmOx+Vm75sX6e9FjT2GehGOX78FsTIrUTfQmJd7hasXIVRoqf6gMEmxMpSMMzrZMw3CmCmw1/+mHPg8ZYkPRwEPKgc0NOR24Pf1uFLlhDGsmDTQp7jHFcLJZWNRUqLEaazxJqstrD34lChp/U6Bq5SEzk7xR7d5rre4nDAe
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3667944c-1f4f-4c02-294b-08dcfd84cdee
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 10:30:01.2077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZmRsbF4yb43w8YDxHOPAWsXrZRWBQxqEjyaa59oVMgIWGHsN5ewlyr2LWbgp6s6EWEhEXbq1GbxmhJMPpzhMuYnojkX8+FRz6q2H9AbP3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6995
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_023004_316794_407F7910 
X-CRM114-Status: GOOD (  14.33  )
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

On Oct 31, 2024 / 18:14, Guixin Liu wrote:
> Use def_nsid instead of hard code, the default of def_nsid is 1.
>=20
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> Changes from v2 to v3:
> - Fix 016, 017, 052 do nothing when the def_nsid is set to
> biger than iterations.(Shinichiro Kawasaki)
> - Fix "make check" error in 052.(Shinichiro Kawasaki)

Guixin, thank you for this v3. I've applied the patch.

Unfortunately, this patch caused some conflicts with the series "nvme: prep=
are
for ANA support", so I took the liberty to modify this change. Please take =
a
look in the commit after the modification [1]. If there is any mistakes, pl=
ease
let me know.

[1] https://github.com/osandov/blktests/commit/87d4c0cb93f32b7d0798b9faaed6=
bb2b39d636a2=

