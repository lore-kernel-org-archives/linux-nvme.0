Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0454D715C6
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Jan 2026 12:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rHUvzi2HqLgbn9P7SbyEIjXHjEwiJF5xqgBV4gaCtP4=; b=BeuKKtjO4BZ/6yLuQSpR1j7EO4
	1lGiEHlDLV50ylrhsaUFsA/so+dVlgQsU48bgbFAAjomNDNyaFXzBJw0npZge5aSs7zY3+SYRxqh1
	/vQjSilBma1b6zgQlxjvZQYm5ZmM3scTk4r+ltR9H+Cha3R4bzI7ksgNi/ekUmpAli8qI7kHNt9ps
	Qv00Tf8vtmmYOXuHaUKghjW17bldyN1Vx2jQVkDbTFevPiwE75gUxfvx4q1GDREPSgljti0gPDq+1
	5MPAnQhD2DtFot3tt5uI8c851aw9OlBP3GJ8JaARGn6ckVUheTo8ANHACyoBE/pIwNIN+yBVCya7S
	fGhnYYUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjcnt-0000000AG0A-3C1l;
	Sat, 24 Jan 2026 12:31:49 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjcnn-0000000AFzk-15Zj
	for linux-nvme@lists.infradead.org;
	Sat, 24 Jan 2026 12:31:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769257901; x=1800793901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rHUvzi2HqLgbn9P7SbyEIjXHjEwiJF5xqgBV4gaCtP4=;
  b=QdjHgom6MFzUpRujSOsiW7u5xd+EzQS2NFqrw+AjoxnVmfB0gXvklHRs
   O2y+nSnK4O7hQWouEX2ldULNynOus/HjIui6Znhqx17QFVJyS7+iFi79Z
   Xrd2O+KVntt4Hmsr4LfLP0rI2oyvxx2lMm8OjXsIxsRdIMc+DMzE/lVR8
   nkTa1DMFeTafqdAS7wnpm1niZMCohQ53ZcKsHCCZVRoVR0mYejQR9YTEG
   hp/0o/Ia5QfPBDU7bBUt1Vbgrx4DPKwAKxPEnVaQs7MmI+4PkkFb/rGDH
   +uDxMTf5LL8q8Km1ZiGiQxOJAh+PoV3v/4NhPApfbRWeMza6+Aw3YTVlS
   g==;
X-CSE-ConnectionGUID: EcNxOHP1R1ibwJqqht38lA==
X-CSE-MsgGUID: aYoHOcmkR6my2uqmWj7u7Q==
X-IronPort-AV: E=Sophos;i="6.21,250,1763395200"; 
   d="scan'208";a="139401025"
Received: from mail-northcentralusazon11013010.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.10])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jan 2026 20:31:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AE3MTzxCROOREbhAzckXuPBMwzfnT9YaMRCTlW23zYFGA1eVrEf0CfI+AWtcqBOxs5VMvJnqh/OLPWfEifogZpl4xOzbli/QA7cwMBg/nXpPPMGDZ6ohwkSDxXBYBdc5MKsk8iyp6/kRslyxNRoWSIO/OH3WomWrq1G0ozTe9AgFv0mfUM9GEj09MdsSYW8sR56qfcsFyfpe4pCBfLfonWC3hWCyL4CWcbU/Ni6brWwylXRfKL9eTeiTXbwAiE2j8YgmHQaTUNko7shPqX1oB3+WiiqYMdKVOWoFy2g1Vr/7edw6rX3iTWR6jNWV1YQNvdiGg4V67jRRT9d48Jn4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHUvzi2HqLgbn9P7SbyEIjXHjEwiJF5xqgBV4gaCtP4=;
 b=oIG0L2Dc4vjIsWrWvUq4/4/MZIkmvphhpRgnmadGF0erowfAd41OgtmdPSoNSRWNgIrHd9KUxUugRpSN1bAIVzUzxulLlxgUmDSjv6gqTQ+p9VqTecPuSVBamcw4K2Qxn8jypfAtm2l+MkcN3EX0GGkMXay6AAcaPMOo4wcrAki93ZX1+VABBC/yavAKN+4OVA484/C+r1IiLTHQpz1CaIz6o6FE/fmFZhrnHUKbeZ3/3kuuad6NtVHZp8fmjb/stReRkDlUOAuTX16qADhu48WIjFNpKdCVKUln8TdBf7q00SZnFQc2bliL9yEFZUWB43kTrOfVWkDkidkE2PZuiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHUvzi2HqLgbn9P7SbyEIjXHjEwiJF5xqgBV4gaCtP4=;
 b=OrIHJjPhdVfSzifr3Sl9fKJNDm9VmrGBv3I6KcVkQuHGqFjhzvu4cilJjXX2QTV5UT8CTQ/g1OeNQCWEgKbxv8i1ZJs7hbhX5Q+zZzjq0BG6yLzp/WS2ZauEI9RZ5LP8d761w7Gx4eHCjqIJcjUpG8xK+filG40vWcRywfaxxxQ=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA6PR04MB9171.namprd04.prod.outlook.com (2603:10b6:806:414::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.4; Sat, 24 Jan
 2026 12:31:37 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9564.001; Sat, 24 Jan 2026
 12:31:37 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH blktests] common/nvme: reset def_adrfam for ipv4 case
Thread-Topic: [PATCH blktests] common/nvme: reset def_adrfam for ipv4 case
Thread-Index: AQHch27XQomdkOULX0SadvQ5DB2VWrVhS+aA
Date: Sat, 24 Jan 2026 12:31:36 +0000
Message-ID: <aXS7iEZDl78iH727@shinmob>
References: <20260117050459.28678-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260117050459.28678-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SA6PR04MB9171:EE_
x-ms-office365-filtering-correlation-id: b4fd13b2-f1e3-41dc-db33-08de5b448478
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?gXBvUeyMLQw5cvnEU4Ha9A9DJopz+BlIlyn/E/4khodvLqQenIUzev3myhXn?=
 =?us-ascii?Q?LwYy7popiW8zQugDXJWKdwQqryQeSPTPg7oJAgkzR0UQwGElANDjl/Z4MyuD?=
 =?us-ascii?Q?+nX4Y+n5iEX7NdhbJRGQVlBI/tJe6cKWhOXV1X3FtAfHSVgiP3Uxh8fVZXAn?=
 =?us-ascii?Q?pvR11796rhtezNExhrPjIZ/mp3b+3FzhJBz72/isa9rsl7103Pl0eSRdUHcu?=
 =?us-ascii?Q?F3askPcptq/lT+bTvInIOOs1lPCySTy7LWPGNcrasb/jGR0HvWC2r1uOb1q/?=
 =?us-ascii?Q?Wt++c7hAX1xcgDE9tI0iWl9nTWz1YzyR1wZIBY2HyaHCzMOeZQf3IVyz99y/?=
 =?us-ascii?Q?uDSYeawNRJHhqizDpD/WRk1b9gnF7e8p0QoEK22wq+8+vzG493LBtOCuCPgG?=
 =?us-ascii?Q?fSzPXfcT2LS6Bq+HvIErqYaHMu9ZXDx1HGsNNjVcqrcNQ5aQrvlJragn9G3B?=
 =?us-ascii?Q?yR3QgomsRUXxgR9SHw04WxGU6edLASG9zWqxOKUUAK4mDl5JNQV0Da8sYM3h?=
 =?us-ascii?Q?aUEmu9u99qvet8tmuNd9U2vlTIpzJJCKlWVUetOD9FjYZF1duEVKP5A85WNr?=
 =?us-ascii?Q?BqUV9B2bqAPzPWhIiW0W9fJXLVawyuLoewNAi1z8/BIHF0aJ4G5QKb0auhMF?=
 =?us-ascii?Q?cLl+2P2EF+SQHHP1KMkc6PBHD3y+IsVPGekrFyoQ/J8UqdGzparvm8obFOnd?=
 =?us-ascii?Q?k+uU0HsGp0JewkF/phzsELbfAmXI8g0T5KAluJafjSmAkGb1hGD/58+jQ0Rz?=
 =?us-ascii?Q?8X10HFzME/LW4V1awlpi3lddnlKWFECYtFmNMPxwKkKnBYpgiMR1Hr4LeEDK?=
 =?us-ascii?Q?sseJZ8P/Cn+w26LVtgcBvWffq9sJB97B36ZExFmZ0pHYF3UmNsK9MvYVsEC/?=
 =?us-ascii?Q?7ND9fraRZtRVGu9kwdTg/LDCOVb25sEuBNuBRQMt7vstwYgX8nFLVCQo+MUo?=
 =?us-ascii?Q?54/FU1WP9jcjSEhaN7+dZxZxcj3mLX8G3UcP/t/+XRwCfuSKFY60iHuajsUB?=
 =?us-ascii?Q?HPapyupuPtbuWy4TzGRJ+G/HRY6naynV5kx5xoOE0sAQCctsa1zenIprCSSN?=
 =?us-ascii?Q?GeMNlPvu7sh46apQLebSVC7lvfJ38Pv+BTBJeM718DarJqY7m47MfG3Pf490?=
 =?us-ascii?Q?rjWOvUlWUirJekyUaMf/D4hsWPxX1SjabZju+/YsTA4X008Ydw1KX8VVH8rN?=
 =?us-ascii?Q?snZ6k42XZry0TSDFw06TjC4zD7azaNRGsbeynDAlj7I7YZIApJ9XE0HASfQs?=
 =?us-ascii?Q?o5cIeQR9Htf3AhlNc+5JTxIf5Azi/bWTbpZcnMnEBkbjmIohEYmvaCh1X+QL?=
 =?us-ascii?Q?v/WMs7b6L0oLwXVfrgRzcYaty+9Vu+4LhHAm+c6+uj5yUv2pCuisrlLG+IQN?=
 =?us-ascii?Q?BHQn2oDLMnU72kyKidHIs2reWoo4XtVq0pltYHfJsPeg7GoIZRQRxCHmwN05?=
 =?us-ascii?Q?6jbsY/k6DZ0BzJAfLEbAIaBTtqN0RzP7h/wcrdL+XO0ayWpSRWwV25gc4rg2?=
 =?us-ascii?Q?lcosiiu0vGTC0CLatPezBYi2PHiQzq8BWnubhoPMhLO2nGkSZEqnSaDzQMlG?=
 =?us-ascii?Q?XZpxhHCcg0srZVOb1tYfLKdjetPbrNWIC96Jjp7GV4DuU5Xz+vJ2YE2mEV/X?=
 =?us-ascii?Q?4fh3QHTAkrtuLxXMUxiqrK0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dc8kLKXBuSJybqxUuEF9Aje4lmdzzSKvZ/P1lU4VeynmKFLWb3fgrhSXmABU?=
 =?us-ascii?Q?5X2oeenUYmYvis+hLhfROEsduZFpRcNayij+LZntEyaZRLRWBRSQfnVoxnI4?=
 =?us-ascii?Q?pPvrf09RQv0lKdBSFGLehv/Yu5qlJdvtFYXodfFSsRYBcE3gAmNYn8jOPbI0?=
 =?us-ascii?Q?FDYwmPCPbdnv3nmlk3JarLOZUcqzNSVz6zipLG/i5fPK/t1T3yQK94tuWsux?=
 =?us-ascii?Q?deDfdiD4fBOyYuPxZYvbruCrc75zc1j2j1Xe2vnRmjpfmfqxD4d9jEWCBbv+?=
 =?us-ascii?Q?3y+p32zL68n1W/KSp2gjzFUsR/hpyExxRTwtkJ/zjSIj7elMueBr/J0dq+pN?=
 =?us-ascii?Q?aNpf+17shKFAYKJ4GCPXflWn2vWYNQdS4pHjV1bTYwgvyj8HDEieue7J9jF4?=
 =?us-ascii?Q?VesTwBevgIQIV9bJiaGqNOgM6BjS3/Rf1U7crn/QUy8+BW6Q7o/z3zhOCZks?=
 =?us-ascii?Q?6giLI+YSJVCKaezAvGMhiErkK/kswSFFwjGww8DB+fEw6rrboEXqfBC/Al4S?=
 =?us-ascii?Q?Xa/jp89rCgq3MK1OtlrvZ4SBSPu1Ull4vb3ylJedlIvCPg+tzopsrgPdRHrh?=
 =?us-ascii?Q?UNzacXWIWhyTWS8ZNd+CpO8iFEygyffINfHUSLGjFHvB7RST3CTrLgiwiIdm?=
 =?us-ascii?Q?DOCC+10cfLUL2QCR9mxg1btoEKkDrt4wOmv/z4nVA0hXUzBECySXFo80cAp2?=
 =?us-ascii?Q?iVIRSVwrwJUk6dTb21wpe8P00v+4NGjP/ckW2MtGrouebLwnY5R6DWnj6UJ8?=
 =?us-ascii?Q?08Q1z1zupu/1W4vlEVsGr/G3sYdkPTsOSr4dMqdo9yH21FLBSGdKKGsWbs43?=
 =?us-ascii?Q?GeooC9Su3B78hsz84s4x5Q4Atlp87e3GaHzuFPjx8P1DZgX+2e38iW8WGGH7?=
 =?us-ascii?Q?fRTmC05zdSfzfZqsmHY0HqZN20QRWCUsj6PCcpTDuAaG8buKgdVGI40P5281?=
 =?us-ascii?Q?bkoTQ4ORRY5Q9FXcXC1HL8t+zfJNSMPN04fIiP0NIit0kxSDzCD3jKqy1sDL?=
 =?us-ascii?Q?wtvhLXnzKa2Emzf16JWRhT9+cvukaHUGkMtUMZlq1FixnYaVmb/LtxURyh6z?=
 =?us-ascii?Q?L9FlmLPG5md7HSbPTOxutp9IV28fKcooLhvk+KoEG++SkKpHPHtHWiyk8mLt?=
 =?us-ascii?Q?DxhVFqpfSbumZ994TTcNj49vpg1ZmFrvLJCdHOZsa3kZaW7ZjSpdOdigK/X8?=
 =?us-ascii?Q?iFQacwoyc5DzMo9Z4UB+rh1Z0WQwqhKPCO5fwAas6UO/UHq7tLJ8u0+aeJGC?=
 =?us-ascii?Q?KtjpYdHWPJhLExNRapaMzT3Nq3t84ys3bCWHM5o+JZUPTXFhZn+d0b3i9Xn2?=
 =?us-ascii?Q?3fJIQCuDZhwIdDClrXwcYkMkHV0yStOO+mTKFu2WmTubUg03m7nmRGHgoD1K?=
 =?us-ascii?Q?1Cv+7Ih8OzF/2SOz4fSSCUirQNvSXfFJgd7t4fwoZYD/JHGDglVGBHGHXQ5w?=
 =?us-ascii?Q?oojSIyX4AShumPBqEEh+fVNekBcOodYtpLKhaq7p5ticp7VQOlKr+wGkpmeA?=
 =?us-ascii?Q?7O1GU+pH64lZvVI7MuBfN1stIhUlx7K4/XWgKMORsN08usFUU+oZ/WIBZPzp?=
 =?us-ascii?Q?pU1iuo9wlcGwkv+qHED81a1moOfCHNyCQm46jy+jQawTk9Q/1Tvppov9aNG/?=
 =?us-ascii?Q?UQf00+s5zYe5JQYhsZu+5HZUHiR/Y/Y/5+QR0nBLbrKKf1jjjTY0iCNilQUX?=
 =?us-ascii?Q?KrGhpSBlgYQ6QiZQCUz3fTzs1ykjVjKoO+idtJV8E/j2l3lha4gExnbMUN5X?=
 =?us-ascii?Q?RFHx95KrtaGegmeT2yww8m14bpUsnRg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E36D3D0AC4D4AE47AEB8E1C9990A4147@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DGYvanrsLrhpZ1yWRsJsEm1jMdYFlxWW+WxeWR9gC+ZsC9bFotr509HqtN2wJIdlEO4YsWehb2V/A4tCrA5htyhcoCeaxsX4dmSkhe4ROpuAp3LFo/urSTWeP0+WWG82wGj6//6c+5oJax/EeMxcQrz0ugkj5u4d03MYzTYjwb4DZlFuAeOSjH/7bAOnXT+CBUkUtSc3eMLl337hXhI5y01CiGyqu+bOuIWcOV1TUpxcOeA8Je+VtunseOyBWyNpNOmKfz/wQFLVA9N4z/YrU1wa05OTqvIjxo6fxMz/KhnJ80pI+iaL5c9AbC7ZnUbCNKFOMIcCdR3JYnFvL3zXFsxtMoKcSMlrHSxOHskxBD0Kg1o5cj9OEf0NxGiycv8c96FkZJ/dSucqs/Ho48Wi1NXD5KDbrpg4n/0YMG5ylvRdj8t8AoB746Ut+R+2eTYB82f9JF2d3bG+ZnoR+Tt9XFpB3WfJXwzuGPVvxXoXsKJ5M/woHfqPYFYU6NE1SHONH134RJe1EyiQzjtW3NpuN1r9ruPNtEXzEv88/pItwxj5Oayzq5QNCqDwy/oGsgxbNNETlA9i0QG8nyu1IEoEYYLKMHTO11KibwOMVp6oIpQvu6fXu70x3T75uI4boz9N
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fd13b2-f1e3-41dc-db33-08de5b448478
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2026 12:31:37.1514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DPCkOaPFM/C00mhhp+llpB3BxKwo2PI3/qJ5WxXHxn6olZG60wqpoi2NfxQu4XWdhBvty/gPIGxqqcxv01y+c0B2+galnKB8myJPOyuzLz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9171
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260124_043143_333273_9063B6D5 
X-CRM114-Status: GOOD (  16.74  )
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

On Jan 17, 2026 / 14:04, Shin'ichiro Kawasaki wrote:
> From: Daniel Wagner <wagi@kernel.org>
>=20
> When NVMET_TRTYPES specifies multiple transport types, blktests runs
> each test case in the nvme group for each of the specified transport
> types. When a test case is run for "fc" transport, it succeeds. However,
> when following transport is "tcp" or "rdma", the test case fails.
>=20
> This failure happens because the run for "fc" transport overrides the
> global variable 'def_adrfam' with the value "fc". 'def_adrfam' is
> initialized with "ipv4" when "common/nvme" is loaded, and it was assumed
> that this value was not reused after the overwrite. However, since the
> commit a16ac8e052d4 ("nvme/{002-031,033-038,040-045,047,048}: support
> NMVET_TRTYPES"), the overwritten 'def_adrfam' is reused for other
> transport types and the value "fc" causes failure for "tcp" or "rdma"
> transports.
>=20
> To ensure that 'def_adrfam' has correct values for "tcp" and "rdma"
> transports even after test case runs for "fc" transport, initialize
> the 'def_adrfam' with the value "ipv4". For the completeness, set "ipv4"
> to 'def_adrfam' also when "nvme_adrfam" is specified.
>=20
> Fixes: a16ac8e052d4 ("nvme/{002-031,033-038,040-045,047,048}: support NMV=
ET_TRTYPES")
> Link: https://github.com/linux-blktests/blktests/issues/217
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, I applied this patch.=

