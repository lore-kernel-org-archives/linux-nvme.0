Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E0AE77180
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 11:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iJax0DU5hItLcGGksjfzwNUkqSDrzt8kQ1CnijMi9NE=; b=k5fuW5lG1Tw9BIyXsT9/q++i8w
	mtg1eb3afVm+o49XZrf0kMOkCW9uBLhI1goblSvrdY3GyampGh3UaKuAWeVu0+e9eEUexVTx9qgtl
	O0vwghUiWq46DI2SGCvuUfTw51HvOSokMg6NOsvcuVlpy09FVRmQMxobAwTyO96qv5o4eYx+L2Zxd
	kvxyPg1a2KRuWb92W1oXHNuR3bkZMiStUH+yHFs1JqT9vizCRIio7yJ/D4B7dGzS7XMp1if4n5vK+
	ydXpk9V0qMGccXou6Km9IcSbFhziEztumf9oAevNsuEHZr3+1OY61CpUdYRyMJU6ZDiBsjyLn1Z+d
	hoGS7Z8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKcIm-00000007YyN-0Nem;
	Mon, 09 Dec 2024 11:51:48 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKcHv-00000007YrO-0hmO
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 11:50:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733745055; x=1765281055;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iJax0DU5hItLcGGksjfzwNUkqSDrzt8kQ1CnijMi9NE=;
  b=eS8eK/tSZBtAH1vL8K5Bcu/oBxeQ83Zs6SujU37SPAzJ16lGn7gVtWid
   dhpsAK38T4QAZLLTvRt8zlqpntY+DUQYbNtejJBSq4MWcc7cb8sVpzVnB
   Jk26Ys1v2uCMyx6lbuEZqO3UxfErVMA27xsjey+8iBjA16hK7/JKkHFMa
   d3xiPAlCxfRouNNmEs2hzs4eCqOwj2v2fRSnwbY2+AuEh3DrlqA9/mgeI
   8GbgF4MOvSjC8UuyHdSCa+knUHW3REoj+7QTqf/MGyc7rAKctOnPKyMXD
   2Ud7pi87/gMHtRID4a7z8nD3Jnupk/XqbgPV//mpTDn+ToQHLFMD6BdDy
   A==;
X-CSE-ConnectionGUID: 0NfjegqsS0y0gnYeFdl8Hw==
X-CSE-MsgGUID: Wbt0fupvQJ2Q49v+B1BIvQ==
X-IronPort-AV: E=Sophos;i="6.12,219,1728921600"; 
   d="scan'208";a="32718617"
Received: from mail-eastusazlp17010001.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.1])
  by ob1.hgst.iphmx.com with ESMTP; 09 Dec 2024 19:50:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRG0ACyYYdcOkDmONWGwSqAOdTpAetwNRaQ8FlCSbjo0GmRtfjGGFu9n3trnLxS8CCZKIEW3nLGGxX076VOB+GTh2reQ3QrHROZCFXeFpWBnMxkgTYbOB6QQFq0cT96QqQDBPZnx63zok7T8Xk4LRUQAes42jDNDm8X05214ejwVOUF+/w9pC9Our+4HmKufxphsLtS1ZnFZflOu1mVCloKyMmK9V31g/+9w5S1cI4X8Af8C9Y7Zlbcg/lvozO7Jpv5YhsdUST7p8vEl6JbgftMZx4mfVDcnoceIBm11KenX9eYOk34mBcYBtepAz4j8AMMWAeZ3/DublivID67ExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJax0DU5hItLcGGksjfzwNUkqSDrzt8kQ1CnijMi9NE=;
 b=irYsh3SoezaH6b6J3Pm2RoJHpD6L9KUo+O0Cl5fALkbc3sd8mCvCoJ8N2+0nrH/hfxzl6aMbhNl+mciI4O19UsUycjmxkTCRN2zx81a9LhocOvH5k07qFx3kvxfy61HazzjVt6sLeA3NxXSR0KXnqOpsi3pTP0PW26Hhy3pv8dzO0iA5+L69Sr9a24daWDPsTkNIE/AlS6AnYSWT93SvfbrBCmfG2ZepSAhrGR8mklEZv7ElzrWq7twK2VJu2+xjmmtgKM2SZs3rwhYN5fmFTuW4+ixFGxJuWNWoTKXmpHyJpHc51IRyPlieta6Za0m1uRqHZgLJMhr/pa+to2U9+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJax0DU5hItLcGGksjfzwNUkqSDrzt8kQ1CnijMi9NE=;
 b=cKaFw7l8Nx4KM0PtlGTULHMLERO897cl2I7JgX4hyUAACDsDPonwh1NAx8qn/OWsGA4ReKR8fc4w69DTqf7O65bEaI9eSeKdoFFi+4xFNMX06nKM9sMSPWyouvzBBU7d0aokUb9wDO3455MAULnjWmJk2ahPDZx2oTVxl5Wzmw8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY1PR04MB8725.namprd04.prod.outlook.com (2603:10b6:a03:52a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 11:50:48 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 11:50:48 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, "dwagner@suse.de"
	<dwagner@suse.de>, hch <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCHv3 0/2] add nvme test for creating sleep while atomic
 kernel BUG
Thread-Topic: [PATCHv3 0/2] add nvme test for creating sleep while atomic
 kernel BUG
Thread-Index: AQHbR9CdPWYQ2WkxsEOwSoOKSWienrLd0YqA
Date: Mon, 9 Dec 2024 11:50:48 +0000
Message-ID: <tsn2a5blstgoaak7vrlpyypreykvody7ewjg4dnhxwrpbghtlu@vmyi7lwwnxxi>
References: <20241206111812.489140-1-nilay@linux.ibm.com>
In-Reply-To: <20241206111812.489140-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY1PR04MB8725:EE_
x-ms-office365-filtering-correlation-id: c18141f8-eedc-4994-89eb-08dd1847b931
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2QkDMkUt4xxLRuddCoPAWue3/V5nM/lguRUM0l25dxskPhveqOtra4pMObDe?=
 =?us-ascii?Q?9gr9hzSRv5Bkadf7d/oZq5w9MA9QNiD0gZuncG1boRVxBVpj91kanLEUZs6v?=
 =?us-ascii?Q?61ZpDQpj5+X1dVZddSLTt9KFfrfYSF3IdZQuETMC2y8BVdySM+bmGb+RXD4W?=
 =?us-ascii?Q?hPpZJAzznrQrvCBY0T77CxTDDEXgqxNyitXW0peYzYX4/QsNzTmpFz8d9LFT?=
 =?us-ascii?Q?WcLqtGQPbpw5ZxZI3ZAhPFscYNsUa5ZivGWlVSXaWu6aYT2xbcFEQ6DPzSia?=
 =?us-ascii?Q?k3q40+YcIozzcPJBn4X3TBDDaNWb49QZ/PIz3osfMGVIJTHangZoANza995h?=
 =?us-ascii?Q?+P3UoPoahUlo3iWYHY2tO90+CXJ2HO6tBq3ZVY/+STGier75yTAYIp1MPnBN?=
 =?us-ascii?Q?9fRCyJfnfgrUssf91nQHsK/qg9nKpqQourqLgfQQBzna9td//dTgDLGedBCE?=
 =?us-ascii?Q?b1fP7pvLq6iZTlZsjDvnqji2TLeR/6PQE0aAA/WoQ00n6KFkNrqy5IfdZjbq?=
 =?us-ascii?Q?F/u7tfTfQTyDOMkpvAa0+tbsdsxC8+ziRy6yyq6l8VtEbSvx6sMs6okaDams?=
 =?us-ascii?Q?i3o3BgnAYojauAQxlzNowa6U1+BqyBZuFyh4IL1ersqjb+b5yO656PPKOtq9?=
 =?us-ascii?Q?MhItgbglwCvNkQq2XXlC44C3yINs1YEJDWhcTMU8Fy0AeC46PPHTm1vgkUE7?=
 =?us-ascii?Q?NYvcNLzeDRJP4Zt7gUTKM/XXgZQfPGn/nNjSHuKLEmUK7t1SJ0SExjF7UgeY?=
 =?us-ascii?Q?IntLfZ6zSf/ufQS2BqIV/QIRu8fuFNkvTpXvj32Syjx+82xykvfgw++gje5O?=
 =?us-ascii?Q?1oBgWOY5266dQ9WRzd9HO5wmQfkLKhhh/dsog84Ve6AdTT93DYIUQsNdljGz?=
 =?us-ascii?Q?s6FUFjJFzACo5LGgEIIF9bjF//ukxcjw5+ADho2c/MaBoqR5KbRLTm52P4yY?=
 =?us-ascii?Q?3JtgJnoVcAKviPcZyXDhKumH1gc4rAjDbtLMuqiO3c5fKDk7VNQILb3KU67A?=
 =?us-ascii?Q?iHazoZnuNUYMUbUPZ28oFa5HUKwBS4g8Sy1TadmZcyks4SRU5poLrVNE4M22?=
 =?us-ascii?Q?IlYP1KfZkHoumh2uoywkI3ocSMudsiHZivZVTiec0l/GWsJupj75DGtFddqv?=
 =?us-ascii?Q?JTlogiFtHKacbkDYPsDYEgBa956tItjOZpq905G84IJ3AzlfNQGmLhVTpNtf?=
 =?us-ascii?Q?xMxJP1rPEt6cq4UNu2BX7InowWrQZkZLLhz2xDXiMc2HuLmA2sHTgdrxSpCL?=
 =?us-ascii?Q?YgqtDQhFN92s6SaU7TMLytxKqI9FX8XTwfadJULpgQxw240Sy45OAx3UDs/c?=
 =?us-ascii?Q?D+nA9JzyYbchKQXLydOObw5zv4QNEJErN8WmVxv5bhB7PfBXLONViRO1QdAj?=
 =?us-ascii?Q?3r1J3OW8RWUo/fVIfSuUCVxTHfaVWgVt4s/tDPVpU57WqMQ0yg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kQiROtthsUnTz3t3Oxo7KIlwl1I+iJsb4vrdWawz4jCKwANJ8oLDcG4tAeNw?=
 =?us-ascii?Q?fg6k/2vq5Jm7WzOLu6QFI8E16xUq4sNOE1pJeBya63wZ7EJEnS7FBYTQ7+rK?=
 =?us-ascii?Q?9wWiDtEFmj7tWMyrkhQmCyhBIh9770QVu1zhQagRkRq+lKd6JRnokBNm3ZbY?=
 =?us-ascii?Q?lU7AWd62sqlUDtTyXIGUS7PKIJhRfPhDEgG/QxNyFT3kWR4Xl9oGcNbdlCls?=
 =?us-ascii?Q?konJWluJSPNu6IrxUxXQCO3Cf16cgbbIsG/NHIf+pHwlj2Thzbz+X1pINYaQ?=
 =?us-ascii?Q?MYIKJnb1HGXzcSmzTL3DlyZBMnz/i2Htyfk5yGjl/Ux445RgWM52dK966O4S?=
 =?us-ascii?Q?DUsLP+7ZoHAj5KfL/lAh7cKkl9MGXtmSu8p+150j/a+iQAy+91Yq4pDSMDHb?=
 =?us-ascii?Q?977IBpT5wyIhFHx2jRx/PqQzN5udqXlY73mSRrHf08GmQ+yJaPOKta4/xP77?=
 =?us-ascii?Q?0eNS9qp384YqTY2lhNASiX9c1Slw+VUJEPaLy/LI3uUz6UlavG1IFJIRTTqc?=
 =?us-ascii?Q?VJZ/URXwC8Lnj6x4AIE8pu8hwbsF+nG6jCa5vDBHZZOtiHWJXrb1yKtpBPg1?=
 =?us-ascii?Q?YrJHytxygyxM6x6q+5gmG+dgCV+4XJxMjp33sSXOdnnhSDYbI0/42YDdMMXa?=
 =?us-ascii?Q?WmE4k0zJbnZgbSa2toqCH2X2tGDykvTdaqytCblcCKjYlaiu1rPgI3XFOBZc?=
 =?us-ascii?Q?1c+vHOP67jifDGGyNnIiyON/aPfBsfKcOLMrNIrxtUlHfQHlyvkOSyOXEXUS?=
 =?us-ascii?Q?G/vkYocJbgzeGFTJmwwtQhePZO+QO6ICFcbtBqmqh1z/GDCgvxkbkCZ4BdjP?=
 =?us-ascii?Q?f/TLSw4nLaDZe0Fma6W2frGulmZMO6bn2Z6/8Cm4FaPVHrtFYIUBYjNektgs?=
 =?us-ascii?Q?Ya+oqT0mIq7vsW3kspKeCm5K+TyLB4i4yZaN5Aq/wCUBuKl6dqRnN8tMdMBf?=
 =?us-ascii?Q?EjeNArMaEyY2xtHRZroVbWxCsZebthoUFkAOBzMRFbGX3DhdlShzrbRV0ThH?=
 =?us-ascii?Q?jOf6LLBSbricCsp3YSZCmWAoxucfYnm5rqh81Bm0t00Cxf+Cnv3uwKXhjCU/?=
 =?us-ascii?Q?vqXcTz8MUU/VxqBdQr42g/Ruo9/9/9Rvbi1kqo00nJFFBraxdPOfWxDhS0mq?=
 =?us-ascii?Q?DTdYlsRsjKAhY3djlCUJegfccdOF0ptRahDgAFB0aB5DViPHNIEs3zwcwN3A?=
 =?us-ascii?Q?zRD8P8wF9lZdmaLWO0vFpiv4r9z5V9pXc3zWQoSNbb7GgmNAZJLrcso8/cdr?=
 =?us-ascii?Q?U0w2QWSXJpZYAQAEnllNqMdkeN+3VV3S1Iu++F4SVm+CLIkTwg5/v/PKK18m?=
 =?us-ascii?Q?845YNAv8R8fHv7ErRxBeuefcx3gjG/eCZ5p0mWIHCs7raUkT/R3Zi421pNce?=
 =?us-ascii?Q?UHwL+wmODVoVpByeOj2kTr3ecMidD2M6sbIKiL0Mlna+EAGMWvB9TwVCgKsc?=
 =?us-ascii?Q?vQ3FLfetrlYz/wj5jgdJEsZBzP46lGcgqTRZK38iLTzXcnbHY7g6arkrQ0+U?=
 =?us-ascii?Q?TWS5zThhYJUTBcaAhDyH+00XK60qNRthBAdN/r6r1CNUUEZDPu9Y4ph/5Xp2?=
 =?us-ascii?Q?N9BJM6dqUd5oDnCE2htMg+3+uYJac0qS2fJLRRewMirWCVRO059b213/8ewl?=
 =?us-ascii?Q?8qqsVqhMiaZN0XSdnfiyZlo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3856FB1A6A85CA489695451448EA4CD2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: W6fAd8Poa/LesimL0UEpfOflioMcLjBDwxnOyDuCkAdrDXlcBcycy80KL5Us/xHRtPVvVdKCxIPt1+C740zP/ZoKCudok5e/it7rmnxO1LTyD40Nlm4BbzN2d/lBNB+JZTACzZzLX8ZDI2b8Czj1vcOEfRW5jTd2Y+v1TyRRnExxVCw3NdWgqYgMVe1ZAy6V784dI0NpS1KJcWPR7wvRS8AwW1aef4r883hsFvhl+tUu7UBh5tD+/aRlfdLdsS5NoJWN74rJTF4FZmncf2w5sCBRUseOmI3/zgA6egu2L4A4CyLQ1Z0/oiY73Oxxkuu+vjjDaKPFF+ouqtc8+z1k8YM4DW1cZx9ZLjjjjunvz0mW3E5EKrBai12NTZ72ot2cq506v2SEg25ODod/RxGloKOGxKtTHRPEzGBluqMIKUaAkzY3qxnu/DUkdYkKIRpyf2eZ7A63YkFmBQB8V5dohQX7zgjy5fv0ShXWh6ILoQRR5rnTZw3+SwDqWzzZgQgNFzlGwNlaAzMHjT5Z7fCsLCb7huZdSVtfzL96rx05BqAGkzGtcpz20SIE+BBxXrbCtIfNXOApkWjPKEIHFDIRklwEQdjys8rTJP4O5EkYojbZrK0lVXJlUA0D7nUSgIG/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c18141f8-eedc-4994-89eb-08dd1847b931
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 11:50:48.5037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erTvVOaz6+kcAD9ROkQzIG2+J2GGMlfJLPryNyerWcS5Pblr7/MvK0JmIlhbAN7PgzxyCDzpvb73agSwb27QGkvrDWMWQUw4cYiuTJtZYjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8725
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_035055_287765_3B672807 
X-CRM114-Status: GOOD (  11.05  )
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

On Dec 06, 2024 / 16:48, Nilay Shroff wrote:
> Hi,
>=20
> There're two patches in this series. The first patch is a preparation pat=
ch
> for reusing a common function nvmf_wait_for_ns from multiple nvme test sc=
ripts.
> The second patch adds a new nvme regression[1] test for commit 505363957f=
ad
> ("nvmet: fix nvme status code when namespace is disabled").

I have applied them with a couple of minor amendments: fixed indents in the=
 1st
patch, and added local variable declarations to the 2nd patch. Thanks!

