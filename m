Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BF1C3600C
	for <linux-nvme@archiver.kernel.org>; Sun,  6 Apr 2025 09:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6KmGre3/+O3+6OhE+qIfnNrtxtLNpZxjMcqA8Yft6ek=; b=CG2OdFRINhxOo5FHWAqfT5SY/w
	K/QT7SJ2JGPiTV7fMv134ubPXUQzetoCpntFlRw4Vjmici8Mesew/0865mgoJI/qJykY5pZWIsESL
	/GCVly8AoDefJhmrf0qRZS0o5/fhUAImLOqck8NOyjW6KiupnQ2Tp2wFZqRFHoJXbCAVYyIbysq8e
	EpvENc8Brp6N/cZ27PkTu9Wms9qf2PrSuO3ZqqQBLJtBMnFjaPpyFr32QjEDPx1MhddPDHbE+pe2C
	Ysz0j0KjcMEQPtzmTJ3VaiFngIRfizlGH+cIoeQVyRTHbD0vNg3MSughg1DnxI/bHIMrytcrViIve
	kXvjhdzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1M5D-0000000F6XV-0gnV;
	Sun, 06 Apr 2025 09:14:27 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1M5A-0000000F6Wr-2pUz
	for linux-nvme@lists.infradead.org;
	Sun, 06 Apr 2025 09:14:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkim.sandisk.com; t=1743930863; x=1775466863;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d1TRn1gx5j/Qi9DAu6hJyfR36p89EbbMQP3G4F2N5OM=;
  b=Oc705cHkXKAU1346dImV5a317K7oiD+UewFmk6CJMy/20CP3Wkktcj/l
   YQQ3mIRWS3zKyB04fQw+34kkK8slqAgKorKAxiZ8qtDPqP/hD8mmopny4
   nllteEMHBL6oqGNu1Ux4k9AVUW/tU5vlL5HVlpFosC806vUQgfZWvP019
   EBT4Q13SXUN/G+4kTmXfTggkQFpzXpYBH40hghZ5vqFJyRBMUTMtXLz4v
   DVKQkuCbRBaLFDSr04ZBCdg5/UhIH3P2WMj2DNP0yf76AFVoksFtdlClH
   eG/HLfnq9Wgk7GP3Et2D90a/hOEb8vCxBnqh1GmaMOQD4oUWumHIhGpKZ
   A==;
X-CSE-ConnectionGUID: dhmo24+JRCS/AVMKSfPJWA==
X-CSE-MsgGUID: UZ/qywyDSFOrLfVGcPwoMA==
X-IronPort-AV: E=Sophos;i="6.15,193,1739808000"; 
   d="scan'208";a="71647854"
Received: from mail-sn1nam02lp2045.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.45])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2025 17:14:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3ioQrqommVeaW4LUElGxBDev6xaz1hwjSyO8XnKIJlsocghCoQSvoQLZXIHsL/hxUF5bRriPI75+mL2pKs7ao8Ti/DiMFbKAog0eIjK/nBBGTYz48cYyfP9XwHwFJgIfEaMlWtRvRu49yWsDW5oVN87bSFKjYDFa27U0El2WygLrBY8l008yShjpNIzbsWJ0yP7Pnhzsm5GkOo1Y2Pkns68ofpxc3S3n3RgSwkRMMjCg8OZTbhEHKEh9JcDljX4yTviddCXRK0MzVDgABtYGfCNNEyRw/YI3nkztQV6PIuzlnZkPSExc50bla7gTUOIQdSGXQCK5Tii5BHKb4YQmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KmGre3/+O3+6OhE+qIfnNrtxtLNpZxjMcqA8Yft6ek=;
 b=Pifrl0DaYTwYi1jjD+i6qgvZmUFhQM+5tnMF86/0BAtbHXOa2iknPNqWHEBNgo5Apnomsx7qZnZ+70vUXpZkgnq2QUnsLZ9w0piuZUSp7B5UUSvdcnkIZtr3YHMJWScsNxcNJew7HPwGhfXoK8LuYEobRks8dB+3c+C0xNrVyLYv46II2lI6tmWnT0voM2cA4H5jczvjMtg29b2cyFMi/a5gvrNlBaPTgSqTYwcaHlhN33wLlnnVOJmEASFo4s6rryjKNmRvo+Cyqf6ub1ZSpbeQRt6Eg1r1bsrb58Kb0ZduGcUrZcVRvadMUmf94CxAc+I67uXyT4YxmZxFJQtMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from BY5PR16MB3396.namprd16.prod.outlook.com (2603:10b6:a03:1a8::16)
 by SA0PR16MB3696.namprd16.prod.outlook.com (2603:10b6:806:86::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Sun, 6 Apr
 2025 09:14:18 +0000
Received: from BY5PR16MB3396.namprd16.prod.outlook.com
 ([fe80::c80b:e141:3167:76eb]) by BY5PR16MB3396.namprd16.prod.outlook.com
 ([fe80::c80b:e141:3167:76eb%7]) with mapi id 15.20.8606.029; Sun, 6 Apr 2025
 09:14:18 +0000
From: Alexey Bogoslavsky <Alexey.Bogoslavsky@sandisk.com>
To: Christoph Hellwig <hch@lst.de>, Yaxiong Tian <iambestgod@qq.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yaxiong Tian
	<tianyaxiong@kylinos.cn>, "alexey.bogoslavsky@wdc.com"
	<alexey.bogoslavsky@wdc.com>, Yehuda Hahn <Yehuda.Hahn@sandisk.com>
Subject: RE: [PATCH v3 0/3] nvme: Add sysfs interface for APST configuration
 management
Thread-Topic: [PATCH v3 0/3] nvme: Add sysfs interface for APST configuration
 management
Thread-Index: AQHbou2LoF20kFV8LkSGgJTGUpN36rORWuMAgAAs24CAAandAIADK/3g
Date: Sun, 6 Apr 2025 09:14:18 +0000
Message-ID: <BY5PR16MB33964D444ED2B1E00E94B99792AB2@BY5PR16MB3396.namprd16.prod.outlook.com>
References: <tencent_4612952C8C5109058CD8E688D81276A2FD0A@qq.com>
 <20250403042504.GB22360@lst.de>
 <tencent_D00C9DD2BF00258063B042172328396DB608@qq.com>
 <20250404082950.GA8928@lst.de>
In-Reply-To: <20250404082950.GA8928@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR16MB3396:EE_|SA0PR16MB3696:EE_
x-ms-office365-filtering-correlation-id: c048bc9e-a79d-4c5e-aba0-08dd74eb68cf
wdcipoutbound: EOP-TRUE
wdcip_bypass_spam_filter_specific_domain_inbound: TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?gKp9HpO882PVZW4xZw1SP6ZAb+mGUkFXvaYYcf7Zv7kPeZa1qlyhydFSTtB8?=
 =?us-ascii?Q?p16BeRgQs4p7nnPp8lHSG1vgby6d7/yrftgSF9dCtiIZwJ8fzkj4oNANut7T?=
 =?us-ascii?Q?h8pzw9ES3YKfBZiEiUoLiGkduJijoB7ieM/paWq15A9vByRVj7ZtT35W1PfE?=
 =?us-ascii?Q?j09oyAuMzU8QpISe9RKSnd5IwagS2Q1GUh7D8z+kUtG6HPSfED3Y7c1iVgCX?=
 =?us-ascii?Q?eQUFa+IKI8f5ew+VVfRQXFsbeT4Tnro/De0gQ3T8djigcM3dcmf2hRg3Z12p?=
 =?us-ascii?Q?Ay7tN/aOyZA0pSeztN3KgIHIAUVQPDtIRo6yqtsyLfdKRPEOV8aamDrIczdX?=
 =?us-ascii?Q?EZeU4Jooyy85dki9jm2CVK08oEPlfgJJ/d2SY5dkScUiYLBPniqdQTZcg9ZB?=
 =?us-ascii?Q?dTK0Rm1Ik08q31h+sd3Z8qjQ9NUbjYlISjHEHUISsOd13mzJyzC1mqusZbEq?=
 =?us-ascii?Q?mqqChVrYjiDyz2bLk6bB/S9EClRpirL/2mo0AY/TyVknJQNKcAQMHREuCpBq?=
 =?us-ascii?Q?gWCuPwhJv41NeKlVBxQ9EU1Bln8zfIaF3d9mZxih8lZWwkbTDhjW2pBkPV/F?=
 =?us-ascii?Q?kIjyhYKcRvwxHVoMTXzDNDcasxuyXz4Lx0O0UPKkCogohSya8NhmHpOOtRXB?=
 =?us-ascii?Q?3e88IplAbXdr05IM3IEv5LLgwpPWgkkQR9ZtEFGolmVujxaFaj8O8pjZCXmP?=
 =?us-ascii?Q?EgBDdFxU8TbNoqSI+CKb1X1POxkenYH+AERF2Y0xhxbEEBU+uobgBj0p/TAw?=
 =?us-ascii?Q?MZVytZDV9eDjCP27X/I64N8J6/qOGzxoBD9qRHezAgkpxWwMX5byVF7GrAAO?=
 =?us-ascii?Q?Ma0YGaK9sRMnatVOLIW6jy8Yi6nEFhNtFejnpZ2RDh+CheEuQWiy46BBvBE2?=
 =?us-ascii?Q?V9vcCefy9d+N1u/jC9k4D+4PQdJs2T7LF1FnvsyfXfyRscPNEkJXhb3X/uao?=
 =?us-ascii?Q?b7XKaP1HtIMKvXFE4behSFML9+3m98uenL9Rjo7j9f+4WySw9T2nn568cRgB?=
 =?us-ascii?Q?ymKu8tR+eB/aLa2ulWZtvFXDhI18or5iR3a8rCH2YO0JqkYLUxGvwKO5qZrn?=
 =?us-ascii?Q?dWhcPqg9Wtv2qXx30LjyCgi6IOINEJjFd4fIkh6ga5i0Sy3ZvCuwHILRKffS?=
 =?us-ascii?Q?ESB10b/WcO03+rhS4a6IxWvXTGVOHifkSqYiK85OSoOZxwX9tK4D4JqJNSLV?=
 =?us-ascii?Q?ARPHz2t9gvYOGDHZyqGY4Goerx5N9skdchG8EU2Cws74WKu1NZ4yjL0Sc2ZC?=
 =?us-ascii?Q?S/Lr3qjmrAQcRgAkHfgkhsbDNZtM7Wut7x13t3x4RF/Gqt2Qeb/oE7Hvgess?=
 =?us-ascii?Q?bExwVANoRmO4/IQfJz0CruZhdL1ktJIgwVKEhp8BeapCmiNXApfNCWensTgP?=
 =?us-ascii?Q?/y+FGYG3gmAIAxjSy3GcdIeuDXeNAaFGSKxOVt0J8mJkufGBxTFAIZQYoita?=
 =?us-ascii?Q?haDWZObjrDTnDi/PU/d3k0Qu/8/3dLZr?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR16MB3396.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?swvMeAGSFvHmU+0u/aNB/8djmZFxlHUVBm3UZmtn+aEOZRUyChEcFlq3bGGC?=
 =?us-ascii?Q?ZuJc8IOfZCg8Dh3IZ2QlEBb7fRQDfZ5+rdJT75TJ4iOVw29VG2al1X8yNEcc?=
 =?us-ascii?Q?ici0ZgoYHO4onvTWHAROGr2DIsdQlgJwvK0keSYIEYqVZvdB4Pxfi3hUeb+Q?=
 =?us-ascii?Q?DjpzrARAgBkeXZv+dz2Yn67FVzSDS5yOy2FiorkY7TtKsh0+UElxYPFrpxe5?=
 =?us-ascii?Q?tk4ccW33JyOyiQzZPNCUbKSXzmqD3zXAYLOOS8DNdAjUiZn1kVqgHCUFdHGo?=
 =?us-ascii?Q?ZF1i+eb0VUSS6mrRxmyp1cHFunNZRgbSZZLGCfpFZxJmXBZYl3r6gIrB8HaX?=
 =?us-ascii?Q?fXrKlPfUzawBCp7ikgoGVuoIMwGRk6xKDzRg/d3uHHS1q637ElVngk9sScHN?=
 =?us-ascii?Q?KmabqF2/vApCbC9fblxSdCpjd3mLqwBiOfjWRExDNxBLjzdNbUpvha0I241e?=
 =?us-ascii?Q?FE0257Kx1pyYgCAnSjRGyQOG58Xv84YZNBmXMILdfWIwuErkgoWcYKBnn6Jb?=
 =?us-ascii?Q?lnJbUToenxyUqjMVsnDiQZuMs4iLrOcKIMzkElC1NnHwR/3pfFlIiZ4PrJhM?=
 =?us-ascii?Q?JrvszYK7jo9a7fO/dPY0PN+corRitKXYJVeKKs6WbG829TWhXL4PbWzqasGt?=
 =?us-ascii?Q?t7agzz7x5U2Xqwbx9As/sa1QtXVAJ4iNbHEyP9ft7N7LvfsTMWaoqNHZ2x5S?=
 =?us-ascii?Q?+B684Ea1yAVJnsv1OH8/Arq7ubEOe0p032cd773lAE2+NHkogw01xx40cSfJ?=
 =?us-ascii?Q?/JW9NKqhjxg0ZolI9DxL3V96+k2733hcthtSrElDy6gtK0bVNS4Y8VMMPQ59?=
 =?us-ascii?Q?cq1xT7BX1do6i69Hr1sRNfvZcSsdlB+nw73t3bBKLEj9SZX7qeIH1wrIr44K?=
 =?us-ascii?Q?jFb0RsvpLEbnMmy8cg1fzKuTVLYhDl7Lj2/hzCo1crkJDIB8Xp4zcr/VFpUf?=
 =?us-ascii?Q?zRDEty2+yoIeJARZFTGszmyQaLM9v/eD24ADTMM8Azgtsnv2HpGFz//uDmeC?=
 =?us-ascii?Q?Y0oztInkzSqbXI2AXLsu5U1jJVmOpKppI5SOy8KPHaJw5Cwkb9OzucBf7xYE?=
 =?us-ascii?Q?ycPUqdPs5qJvDTuHBfo/jqbu0kg0vpQtcSZtnokwrmEvKR3o1NCdfBoBOz0R?=
 =?us-ascii?Q?OykIyZ31BeN9HT6qP+/+q66jf1oTu6pgONmbsCPwXWiZPYsnTh3o2hmkG0zd?=
 =?us-ascii?Q?/56MmTADAbElsfmOIJrG0s50ecM+ZdTCw7K9f11lN7HK5UANaGNGanAhmrV5?=
 =?us-ascii?Q?Nqz5BJTTeArKsSnrkGfRARvv1sWhNvHyi7fKbTSBqlYqIUH6/ESD00xidpl+?=
 =?us-ascii?Q?Omee3465aawskk6jhPlZ9Bj8y1SOlsrhcNqrjGSIxawTAQ1ZRdFxkCGC1so5?=
 =?us-ascii?Q?AMRYh2427WjnwA5acvFUqf2air+QtL5Rd9TDt9mW9DK2+xqqVwy1389kGmo3?=
 =?us-ascii?Q?3L/HYly1kSs9JA7dvnvNeOH8VeRfghZN+Dx0QB46DfeqfA3DZ6bCdkV+n98x?=
 =?us-ascii?Q?+rIQ9Jdzc4e/3WWobmjBtXXiZRl5z9vTOzkKMPzN50ppXikItUMC4KNuLuK6?=
 =?us-ascii?Q?QVQ8w4kaDsRFHoISqbwLea3uBKqPDE7npp3YbL4+0ygRbsjdt2WgTjPAnMHc?=
 =?us-ascii?Q?Rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EYAvsLFtxsjC3qRzFoItJZq1w836DSX2Fd1QqZXfQQEAgYi7mYSTDGJsgouhx0tVfl6DJeDfiwsU1mTnuvlYgIqyTBcJQ3NvyckY+LHRrXsfc8X8LuyjJY2SOkCV+ry0fE2x82ocCIJMxGLsv6FwWtWckDMV3bj5WhsZkxifADzbatKXKkeojnKYGawW+oWfSplEhS4PYiw2GzWneKDAVpRvSEsdJ4z78/Pnr5bO0bfXRmyUnKbo+HlSQurdL/DwCxolqYTSp2VZnlfY5SSBZKAX0wXFbZhV1vfMQVHbKH7Vmcy/q57PpiH46OGJVyd0ExB1dhfhsYJAe4cKSeepU/EEFjHbzyB4Fv5vRy+QNnwBvGWR3hsuG8DmY+WCbhlZnZxCbzxLbHIbDdomfpNasL4oW9UAM1+rXpB6LFPlzPJEZlQe3jBKz1ZJFDRtJVngqRzBAjtkoQBu1x34uW1X8hfp9M29AAghzq7gbewAWq7eXWqtmStwzihkOSp9iPmkHrSi+8ngtAabINuYFsob6MGJEHRUJop2ev7a61C1VP8iLqqGELZ6YCyZ9GdjBWaaHNIC7/wIKjQx9/c5SHkwrOztecMP1trzq8LhA9NJqDb0dCI9/xcxRCeCjfCqOtyj
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR16MB3396.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c048bc9e-a79d-4c5e-aba0-08dd74eb68cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2025 09:14:18.0631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: frl/sJ13nRiMHYViSdCzqoEz/RYsW265JCKU33YSMe4SNLpgH3YnBtK68g5TQ+7TfijtTKOA3pf73YhswCtBbQmHZCyQYdeqVNACxzYIUJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR16MB3696
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250406_021424_734916_DD8921D6 
X-CRM114-Status: GOOD (  11.73  )
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

Hi Yaxiong Tian,
The ability to configure the APST-related thresholds is not the essence of =
the commit
you mentioned, but rather an added bonus, which I suppose not many people a=
ctually use.
The actual change is about reducing the number of non-operational states in=
 the APST table to just two,
regardless of the number of non-operational states advertised by the device=
, and, more importantly,
removal of the linear dependency between the ENLAT and EXLAT and the ITPT w=
hich, before the change
was made, caused an unreasonably high ITPT in devices with high latencies, =
which, in turn, prevented
transitions to non-operational states and led to an unjustified waste of po=
wer. The modified code
was tested thoroughly and showed significant improvement for some devices a=
nd only a minor negative effect=20
for others. All results appear in the commit's description.

Thanks,
Alexey

-----Original Message-----
From: Christoph Hellwig <hch@lst.de>=20
Sent: Friday, April 4, 2025 11:30 AM
To: Yaxiong Tian <iambestgod@qq.com>
Cc: Christoph Hellwig <hch@lst.de>; kbusch@kernel.org; axboe@kernel.dk; sag=
i@grimberg.me; chaitanyak@nvidia.com; linux-nvme@lists.infradead.org; linux=
-kernel@vger.kernel.org; Yaxiong Tian <tianyaxiong@kylinos.cn>; alexey.bogo=
slavsky@wdc.com
Subject: Re: [PATCH v3 0/3] nvme: Add sysfs interface for APST configuratio=
n management

On Thu, Apr 03, 2025 at 03:05:37PM +0800, Yaxiong Tian wrote:
> These two patches don't fundamentally change the APST configuration=20
> policy, but rather enable users to configure various APST parameters=20
> in real-time across different devices. As mentioned in commit <ebd8a93aa4=
f5> ("nvme:
> extend and modify the APST configuration algorithm"):

And who are those users?  What tools do they use.  What settings do they se=
t and why?


