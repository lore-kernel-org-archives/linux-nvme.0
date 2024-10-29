Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF810D5B16B
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 08:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EVqrkcA32PbpITS5WfhgAql87oEmnTk4sQSzG51jM+Q=; b=M+UtXiUEcaxcXgAgNH+qr6ByNO
	qUNdPkw+3qD43eXRHLBMn2ZihHpqtJpGBKpEa6rQhzxFDfpxymNqVP0+DcrV0wDlJaWogtytOxe1+
	BkNg8TszAkz6oNXDcVtk1IO9IQmpxIMh/Ja6DrwcP0eOPn/V8Zbj3ONTdLKwEK71ed7mFzYkDTwJt
	GM+SQ/EEF/WCCl3eDYE8wdR+amb5z2AajfxCU03ppwKq8n6kPF6Wz1uMKIa0mosvdBE/gxD7XH83K
	PwWpffQbmQBHuXZtorLLZ5eOogRRrciNorny0Xo+AfqxvWhmcnGXNwPJpMxtpy6nc0vJh5boOzJy9
	BZpo6Qew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5hpa-0000000DjDw-2gGc;
	Tue, 29 Oct 2024 08:44:02 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5hd7-0000000Dh5p-0lyv
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 08:31:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730190669; x=1761726669;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rYKlzmLEgKMioFfhFpNrPs8wKAJGbB73mMGtcfbqtcQ=;
  b=As6eZXC3FBzt+i3cunPqnMQu53wgz3L09ZQP5/5BJZzIC4z8DprZNuTT
   oWHE2rpYlnUnIGuA/5rlONT9AotGI6BWhBac48LrEcQ8VcHH+nIbjY6CE
   FgXDoSaZ1R6+CZKZDvmk7+J3vB2Dz03v2AbmOZkdJCd7QooXISaen6rfn
   Fj6E9qWF+L7FMfyBs6fXXH4+XirkVZVdJAf8RIFgXXz60vs9oVNBzwn6X
   +lmC/ZSNJQSCX/2C7+2JE6TtZk8LFmRHUUmfOkUXrZZgpb7o/519HmvkT
   McclE5U5TUFvIiCxKE2iPcVD86dBIdbdc7dz3xVrbd3L9dtw8oDR3s00x
   w==;
X-CSE-ConnectionGUID: VDA20jRPRkeeyIpDh7nLRQ==
X-CSE-MsgGUID: B2BVsjb9T0mQeKNJqVwFNw==
X-IronPort-AV: E=Sophos;i="6.11,241,1725292800"; 
   d="scan'208";a="29509855"
Received: from mail-northcentralusazlp17012053.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.53])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2024 16:31:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHrbmgLvSGE3FuKWOhAEHcVBFX0olxq77xOzsxULgdRwRrnntHoY4aXGX9n1GzUnNEUp5ZCI/3T+Rn85y/ITLzAYWjdQTqlshBeZZODEtWzD+wgDPv5ROMisl7wf3xfbKOhrPRm7pmtiTAYWxaKeggPBtIUYnavpA/Op8T3h60Rkum9/LsaymUuve/MGCMN9cQU4V6Ah2fhIgF+aM/d+KDjd8oY8h6YujLyoNtYjEdrpJmAawkm3zR/u5PFApHq0pDmGwiDbwhjpryN/RYhT1bxMOlxKQr6gKWAv01rw3Oyc4DuVpKm0IxJQJWDeOlyFtPIpL3gAs2oitYa5Jqm9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVqrkcA32PbpITS5WfhgAql87oEmnTk4sQSzG51jM+Q=;
 b=Gi/p2EbRAlDtmZPCWtVJlFjsX+SQJjCdN+iiAFRyjq4XXCiUDsfL7FGDI7ly8JOYtQIpJzQuIQWpYIiHdj+h5vgqgcNFhkLTKtK64IR2EynBISoWzU+FwfKklGsGyEiFMc5AaGf3eUKnhFdxRJwY2MrWWNt7vo85YiRvBKBfIuyFYrrho5qhDY6VfalewfEv97703WNj/19trdZwgJEBhtme08N6JmhUxcYdTRPF/5Sd1AHwkuTWtoVr7+qUaHB7aAiZTdRWvGbJXSLSAVUpUa4/0NRpqFkXKfRrOO0ca6mj0oCk6gJaQBA+WVfzy7kEq3nGam3cPBTEF7ks+jlbpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVqrkcA32PbpITS5WfhgAql87oEmnTk4sQSzG51jM+Q=;
 b=W32m5Dk96VIB0NHenNKJi0blOpVz9wK8BinxatjuhC1/Jh6PCxwrnps+W47Z7h0ybcE1C/qfw6QP9+x6Jjzku3IQglbzKUUr8rkvgETuKtQHaEaw1irRhhjtgCOxXKqQLfNo3fSZeA1MkXyhaax5msBNMJgvJuFWZYWudsmd/L8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH3PR04MB8969.namprd04.prod.outlook.com (2603:10b6:610:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 08:31:05 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 08:31:04 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 11/15] common/nvme, nvme/003: add --no_port
 option to _nvme_connect_subsys
Thread-Topic: [PATCH blktests 11/15] common/nvme, nvme/003: add --no_port
 option to _nvme_connect_subsys
Thread-Index: AQHbJbAlHxkCODarl0GL5hjS089NS7KXkB4AgAQ0iQCAAEODAIABZj4A
Date: Tue, 29 Oct 2024 08:31:04 +0000
Message-ID: <jbt7fzbqrbquxy3th5nmgdcxfmnusqyskwzijez3zep23sqh6m@ihfhdumicaqm>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-12-shinichiro.kawasaki@wdc.com>
 <80050767-185a-42b0-b4af-3f6e2c921b1d@flourine.local>
 <nfnhajw3njwoyitpsltx2p2blif4js5s7zwqmd22hxt4tx3ptm@6x6rz4pfqjlk>
 <0e57af1b-5eec-44ee-bba3-9ebecd317287@flourine.local>
In-Reply-To: <0e57af1b-5eec-44ee-bba3-9ebecd317287@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH3PR04MB8969:EE_
x-ms-office365-filtering-correlation-id: 22d801f3-0b83-49f4-36e8-08dcf7f40777
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|27256017;
x-microsoft-antispam-message-info: =?us-ascii?Q?IodlBuuL6Y1qTFujFlq4xh9NrG/zeQHGVnQg0KKASLpP9SwT/iBtseFjInis?=
 =?us-ascii?Q?06tePKQuQeyyeZoTRZFV0GET541k0CQkp2BxzuC8CLQN6ed++aQwWGY68Wf0?=
 =?us-ascii?Q?4F3EwX7NBNRJjAd5BSpmfbCRDKaiHjFxVvuIwbghZ8YN1te33E47CqZ7Fhfx?=
 =?us-ascii?Q?T9IXa7mkWTJNxyOSLbVJgaVNu2FqaMG4HN5ANB3vxzaglfzCpWX57i1+zHuc?=
 =?us-ascii?Q?A7j8ZRsdlHmmPamFlUQegEaVIVbdJWRwr7GoVSoLOgFXnpJqghVm+C7+cHa7?=
 =?us-ascii?Q?NBIQgWBsJwC84wrmFqfV11Gpeg5bJzPhZWPPcKjsckYZ63iFw4o2jyQA2SdQ?=
 =?us-ascii?Q?jxfCVR7ZKoip2VWtzt+oBOKTYlS4k0dk3OWcvWKKdvNpGHPQG1wz3drAKb64?=
 =?us-ascii?Q?40sq6osaePbUMg6mtEPY26HC+gxepgag9F1rMAYZc1Jdcb7n12p/Ou2sn8rH?=
 =?us-ascii?Q?SshfD2HZUP6tsYO3CeBtykg6XK/vu8PzjYjseSVP+589R28lyVx93lr12n5z?=
 =?us-ascii?Q?B8+JytX1zvXqr592/ySzBTbHwlmH4P9R5dPpftQk+EC6/HSyuORCJwP2ZpHq?=
 =?us-ascii?Q?NUVgPO9fHX1BdE+24x1p9x/aHTYyLgC9FXVYApPG8pOitJBYhzykB5Y2wm8x?=
 =?us-ascii?Q?6Lci5bpjr//+/9KsQd71lJG8Igon0R1eDKJHShccwQybF+bnJCAhDZHxWJ/V?=
 =?us-ascii?Q?T749+jl5fEhKFr7+CBK5VUMY8EZJvf86z8++LnoWyex5sc9rKM0hfd+qtgou?=
 =?us-ascii?Q?dEm75fcoEwH5epzjlGTL40aa7I7TKGCOGTgrlC7e89MK6ZU8B9fPzbRLQhdy?=
 =?us-ascii?Q?d/qLgufv0twJajlg37XAF/Mihb/HfPcQWrN5ggi7StE302sRkhA5re1TskHF?=
 =?us-ascii?Q?0u+U4DIAuaAnoJrEr29aABPTFhQWbNaloS9QQ9BWdCFBgkWKQK/75sfgAmxl?=
 =?us-ascii?Q?dz/kXewyINZclmjVb1yXFwvFZWaBkbIh4x23cR4ISKcAW013+0xqOQH6VHlr?=
 =?us-ascii?Q?9xtracQNFSPGlC7Kgwiz5qCHqmVmC+OZG+jsZKHUp8mpVWOxpgAvfgHNx5Fn?=
 =?us-ascii?Q?mdS2d/DiUu/8M/Tq38ik90//ILDvTE0xfy5A8V67H0zD7Zf4xEABM6Gx/hrf?=
 =?us-ascii?Q?PrTI9mg3toRIfONVTI7MFuUH/Z20EzTOcNfkYWWbXbwiztM7pOCsh8EEIQiS?=
 =?us-ascii?Q?42wzSR8j/3HU1S+stYGsCaSvQa2lRDfJZnmnelclG4XG/Mx70OuZtOH4A8BS?=
 =?us-ascii?Q?kpwrzMfWZPkNB070eol4Jyv0nFYMXemUssyg57cnGPWyA37ff5k82uikM18w?=
 =?us-ascii?Q?qnhBIPFrMevMp5ma+QE1+MxlkwW9tZlY0T54MM+cABNkq9VNClLu0mmCC/21?=
 =?us-ascii?Q?1ho5ynrnyLVyMtF2EegOOIHJhlAB+rcAAgPQOq0A7etUQ+zFDw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YAH5zh7rurH+VPR7zBDJpva9/EujO5ydEmH44SUp1EeF1HrqIVabNNEoazXL?=
 =?us-ascii?Q?m6UmWgaU1f20KDEggT9+icySdAVETyMy2IFkByT544uZeI0iS3DJng6M6scP?=
 =?us-ascii?Q?gbvAFb+pcc84WhVuQf8WIPr1uAASmTbMxuHGvsmgohZgL8IQLsGtKl8ZMJbt?=
 =?us-ascii?Q?sBpg7TJEKQtAFLEOy6l/5xGHWXKiVxV2TTLz3+2j5s1Pvs3vWMZcyBWPenr5?=
 =?us-ascii?Q?zMYP6+jx2xJd/KnBezA05a1Enxslra10Ca/19zctt9HkKNoMopks5YY3jWu5?=
 =?us-ascii?Q?cqUKSPAuNsu04TC3YvXWmBzPHskc6OyQ0iYFwLxR2J1m6YgRw6YQwXP4OOO/?=
 =?us-ascii?Q?FnRh1+XsbD6xvZBiVcY/A9WdEN6cKeiElE/bhfyrnMDccSX7fiwxzxxJRut7?=
 =?us-ascii?Q?tjTx++/lGIo+qzuRPReRiQLgvWRs2UgEIA7c/alHjHsZ7724E708DjmvUUlT?=
 =?us-ascii?Q?a2ahe2weuf4v5TsLBKSFlObwF5kLIoR4kZ3xspBjULahk7iRptrQ06vKw3ap?=
 =?us-ascii?Q?q0Mk4MrgYeFDikDE+kXgB/5lfBxi7MsLL9UiE5p7+WeGxM1PTkxajyXMpCn1?=
 =?us-ascii?Q?OWmq36cWqYrwptkxWPT+/zR7fydT/7xGg37E1c1w4MTPNQzezuR/a/wo9Njg?=
 =?us-ascii?Q?uPr9jp/o1x7iv6tF5VIIBTHVzERJO31xK6p77bzs10UMlvJF1cU+wMZEUF8p?=
 =?us-ascii?Q?hjCn5OrRohNGT1D1lmrZ8IpmxAXuZjwft09nNa3QJzqDq6hYsB4nsL5WCeJv?=
 =?us-ascii?Q?5EDcKNkB53inIx1PNUbb+FdCduXauEDe0r5bnIP5z4tFcdbXX1w8jg6rhoIQ?=
 =?us-ascii?Q?k268GTyJbbeElam0SAaqO0a2huPeHxxQjoUXbYTuEnCWTCNPEa/ZvjnbOQMm?=
 =?us-ascii?Q?OoTzxr1VQSVU1Wno+WxzQ5zWgb8/tZvyg6HC7DJPyuEMiZ+Bo2SgzYC8A4K5?=
 =?us-ascii?Q?uhRJYDyKB1Pi5/4FmUU2gxGCr5OcDmmvjgfz7W6HRHHwRl+N92xaGBaqMw0j?=
 =?us-ascii?Q?r6EJg9XUUWinH/PTQZn/933jV9edChCJILNVZJjHJ5UzfU6dc839XZAhuRX/?=
 =?us-ascii?Q?wWaradZkbw9ILY3KcUjcG53tMDJWCySG1IzOfbw5IxKvk0N3fwXYINCNrKlG?=
 =?us-ascii?Q?1luEGcHF8LKZhcyjlfjSebOajNKszLTlxPqWgV0S//e99w44OTtdEpMzta9B?=
 =?us-ascii?Q?yPJhR+s5SmwO5nmVLMDX/SQ5PCCEF5kPS/lP1hQBZmjhNi19ZyxDhninWORH?=
 =?us-ascii?Q?RmWdzLAR65nJCnasalNoxJhYkFgTfoEvxrL5ZdmNAww7iV/t/BMhYap9hE6D?=
 =?us-ascii?Q?I3U5KITIDyD8/J97YefgNjeWQR467iqGBfuHChmX2IooGIBgRlJjdPowx3ph?=
 =?us-ascii?Q?9EXN56xHLeUVt79v1ESHWPCtsW+CWSLDmc8IQ/e+qNYv2pVnXv/gLFa/RCJ5?=
 =?us-ascii?Q?pzXa9LdmSJuFyDxrgKw54GQZM0twmDACB7UHXA1VwIAnKS/ZBMMZgWN2QvMp?=
 =?us-ascii?Q?Hwh792SnK3W8El3HLejq6KPJ+OIdgswcuwFwny2qLdo2OYM5HFwI21JLFgrO?=
 =?us-ascii?Q?skUrOBBO2+8MebXKaTSz81FwlEVGSYYJMcpzdssjfPRLLPk0WxRSjta4+N3Q?=
 =?us-ascii?Q?w1ni3PBxS/D8vQDOtZF4Icc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <38025577011B4D4D958099D99B24BBE5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: y5k4O6ZyvbIjcrB/VwkJLnfFOdTV2cGlX4XOQtxrzxHBjgUIL4OzPRbvtk9HUQWS2u+0IarjFdeUouODZ6PCxzjz+NMl/KE0npA1vmZNRQtzHGdK2soMzuPsUXNO1GY/f4XVf7+DKteN8vQNCqDMUzOZ1S2dystEfjrI8c23btIbNE58hg5ot+UNjozfKsFjTFQejIi0YLzlj88TQBK9wuLyw3QH/4dTac4XBq3YF5Ho02F0W4Yc9XAlu2ra+8/MKlFmUyNhta2NfMMqWkTNU2OP+uNTpQ13goAbeQCf77BkzP1qgWpGkflocTRtVXKTSnp53ornS8WBai6Tikikr3fCqgfeX5VuUZFQlctI+SgXEmii2KRCkfTng1tDcQkbR00XEcaIV624fHhpVg1q2Hdv55WK88ckKTOPZhomq3sQBXKYYQPPuPBuOf+ptO2K8YNPD4azAfgZrb7uyQDKn8uo8OkRT4bUf9YeDqr634Oe5AmgiHbpARKaqKW4FnUxJdUx0jUGV/kWgWKShxNVAszgbeVMvwimBiV8RQoLSt2SSpy54JTmRSAbSoyIuwYWPx8/TROyN2ycLW3UpOpeCxaXFAVjIxgB/GiFiamzLSeKTtg/5AhyrZVjXj2zEm0D
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d801f3-0b83-49f4-36e8-08dcf7f40777
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 08:31:04.8719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a23QkSMPm5cW2s2YjOdUMfZExj/QuGDxW0C9MWkEipoNMSbGio4oFw4DPW+ckY8ASCZUFibfeS3ZTIYzBO33FaRN8T3Uu3W7PfvGF20in8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8969
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_013109_349821_67B9FF58 
X-CRM114-Status: GOOD (  37.96  )
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

On Oct 28, 2024 / 12:08, Daniel Wagner wrote:
> On Mon, Oct 28, 2024 at 07:07:15AM GMT, Shinichiro Kawasaki wrote:
> > > I am not so sure about the --no_port argument
> > > is a good idea. And if a test wants to use a specific port, we have t=
he
> > > port option, no?
> >=20
> > AFAIU, there will be three kinds of _nvme_connect_subsys() calls from p=
ort
> > parameter point of view:
> >=20
> > 1) Default port(s)
> >=20
> >    No port related option is specified to _nvme_connect_subsys().
> >    _nvme_connect_subsys() gets the ports prepared, and refer to them.
> >=20
> > 2) Specific multiple ports
> >=20
> >    --port option is specified to _nvme_connect_subsys().
> >    Following series will add tests for them.
> >=20
> > 3) No port
> >=20
> >    nvme/003 creates a nvmet subsystem with default port. The test case
> >    also connects to another subsys "nqn.2014-08.org.nvmexpress.discover=
y"
> >    by calling _nvmet_connect_subsys(). In this case, port related param=
eters
> >    should not be specified.
> >=20
> > To clarify that the _nvmet_connect_subsys() call in nvme/003 is the 3) =
case, I
> > suggest to introduce --no_port option. It will explicitly show that
> > _nvmet_connect_subsys() does the exceptional parameter preparation.
>=20
> After looking this and previous patch, I think we should aim to make
> this a bit more readable.

Thanks for these constructive comments :)
I agree that this part can be improved.

> I would suggest to move the whole port
> handling code inside _get_nvmet_port_params(), this is
>=20
> -       ARGS=3D(--transport "${nvme_trtype}" --nqn "${subsysnqn}")
> -       if [[ "${nvme_trtype}" =3D=3D "fc" ]] ; then
> +       if [[ -z "${port}" ]]; then
>                 local ports
> +
>                 _get_nvmet_ports "${subsysnqn}" ports
> -               if ((${#ports[@]} !=3D 1)); then
> -                       echo only one port is supported at this moment...
> -                       exit 1
> +               port=3D"${ports[0]##*/}"
> +               if [[ -z "${port}" ]]; then
> +                       echo "WARNING: no port found"
> +                       return 1
>                 fi
> -               local port=3D${ports[0]}
> -               ARGS+=3D(--traddr "$(_fc_traddr "$port")")
> -               ARGS+=3D(--host-traddr "$(_fc_host_traddr "$port")")
> -       elif [[ "${nvme_trtype}" !=3D "loop" ]]; then
> -               ARGS+=3D(--traddr "${def_traddr}" --trsvcid "${def_trsvci=
d}")
>         fi
>=20
> and just pass the --port argument to _get_nvmet_port_params().
>=20

I tried to move this code block inside _get_nvmet_port_params(), but it wil=
l add
one more argument to _get_nvmet_port_params() to pass subsysnqn. So, I thin=
k
it's a bit better to keep this part in _nvme_connect_subsys().

> Instead adding a new --no_port, just allow '--port none', '--port
> discovery' or something similar. I would like to avoid to have a --port
> and --no_port argument, because this is very confusing IMO, e.g. I'd ask
> myself "If I don't use --port is that not the same as --no_port?"

Agreed, I will drop --no_port option, and will use '--port none' instead.

>=20
> And also this next block should be splitted somehow:
>=20
> +       if [[ $port !=3D none ]]; then
> +               [[ -d "${cfs_path}" ]] || exit 1
> +               trtype=3D$(cat "${cfs_path}/addr_trtype")
> +               traddr=3D$(cat "${cfs_path}/addr_traddr")
> +               args+=3D(--traddr "${traddr}")
> +               if [[ "${trtype}" =3D=3D "tcp" ]] || [[ "${trtype}" =3D=
=3D "rdma" ]]; then
> +                       trsvcid=3D$(cat "${cfs_path}/addr_trsvcid")
> +               fi
> +       elif [[ "${trtype}" !=3D "loop" ]]; then
> +               args+=3D(--traddr "${traddr}")
> +       fi
>=20
> The first block is guarded by the port argument and the second with
> trtype. It's not obvious how these things belong together. Maybe make a
> big switch at the beginning of the function on the trtype and add the
> arguments accordingly. I think being explicit here and having some
> redundancy/repetition is better to maintain.

Agreed. I will try to improve this part. The first if block does parameter
preparation, and the second elif block args set up. These two have differen=
t
meanings, and I should not have combined them. Will try to improve in v2.

Also, the original patch from Hannes used "local -n" nameref for
_get_nvmet_port_params(), but I dropped it. I will reintroduce the nameref
for _get_nvmet_port_params() in v2.=

