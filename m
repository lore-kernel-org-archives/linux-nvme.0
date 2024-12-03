Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41DFE6C5FF
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 04:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jaQzJA4l4rBRPzGTB9kqVc4RMO8JwPyVlxepScsVlCc=; b=xw8zROzS1SM1CRYeBrQ8WtPL3H
	CH3P3jk3kPCgLGBg4QW1rpaRm0wzWgW+fxZLHzI4ATxIlNluRBd6CI3mhYSpIYvpcF02NT3c30T+g
	6kh4poy+ZvtxmBpwvwdnVJm25RZcH3/peXcCAeKelCvd6f98OkAuKQX6lF71LLbtJa30HbukT4wJ0
	16WCDUR25EIigePf+lDVGVAT19TujIlJ1WpdXmg44Fxf/8dNOFXtZOGifw488C+gXEvh5WOHu+IC9
	Wo29pRBE1pN8AQ5WWRsq73AtqDKaoC0VqNQY0vaVmsQRARDnqhNLBmLpKnGyjREqwTSq7biHuwEIy
	IZXqC1pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKwv-00000008FlN-2BWT;
	Tue, 03 Dec 2024 04:55:49 +0000
Received: from mail-mw2nam12on2061e.outbound.protection.outlook.com ([2a01:111:f403:200a::61e] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKws-00000008Fkw-0xPb
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 04:55:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8VFsmpVVs7n47AjdZ0bR905V6XCCuSb1f6C/hRCQ4v1s+lliCXM7zEBLwOrxJ6PcRyPNYKq+lEruPk1mHsLDV0R5eakjsFhOIAdsGQ4fi5mnOVx9y5ZPJ0RgJfzfw56UygQzrvqRs6jnF2mHSsWCwbHgCbD7hhhsme8MDcU30m3slYyrFvdfNxWU2Fd/vvuIALz3Oyo6dbY0v8me2AEWqYoca9diwz5Uwi0ojRCM77WOQlwClbth7MtnNz2gzh3De4ni2aKQGjGXpCyLsko/mRpmUl+i2Mim/m0Z2Iuq6ELxbi+vmZpnKziLI88oFd41MHjFfMKHD/MlUqlpjGIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaQzJA4l4rBRPzGTB9kqVc4RMO8JwPyVlxepScsVlCc=;
 b=k0vxI/4CF/kFnAzq7vviMC8zm/t8byQkF7x7NQfMNJpfVzqeJCHYRQXwJ3UDhoByUBuDeD88+NCCTfw7wMCNV0OrdJElvHE0Ejund+7huSGfJjX3h3FTIiA84S0LUgRUpHcJgJCSC+luHPB8udI+8Tv1NLqOP0s4/yeeQWSclHdzyIKRsbyGnip92yXRrjxfaJdpYSntCsHY2m/O916GGOyZbIF1oz2hpHqlUmRez+PROCCgm7+pVHeeu8g7Lllrmgg9cc2nBeLzxK0ZpmsF3z1nPacLIPszC7w/M+eB0Nk8aAbI4mxoldkp2qXfePeF0i8wAzgnTMCZZZczhJGdgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaQzJA4l4rBRPzGTB9kqVc4RMO8JwPyVlxepScsVlCc=;
 b=jM9vpNk4Xx/xz+CsYbZbmFZtQKQGIVdR9e5k2NbQleBBAlkLD/GjzJLeCN8twU7WwMbzQNk3EAIzfJ2d/RW22YS+vVDAwVNo86z8zoWJT0Y+BQS7xOJLknTOZDX2Y0aOrlbc9V1+Zb/UKpAYhrCjmgwACKTrGR5zPgL3gKwXC7JJVT8ZV0KuS86Oyapdzyyz3xX3krthLZEf5LF8Rd/vJPnw385gi+oIxpwjvnc4MhI67GKVM9bTJP8qui/pf1jSExQwbifKubkbGrd8U2olK4HhJiPf0vffu2W6QsS+knasudpNU9DrNSYl2X4XchQFN/ziXrJNu4AsJjCzG76/mA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 04:55:35 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 04:55:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 1/7] nvme/031: open-code helper functions
Thread-Topic: [PATCH blktests 1/7] nvme/031: open-code helper functions
Thread-Index: AQHbQmJY1DKqsSgwwkumxR5xX9Wp8LLT+miA
Date: Tue, 3 Dec 2024 04:55:35 +0000
Message-ID: <f765bbfe-392d-430b-9125-0aed4819b51d@nvidia.com>
References: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
 <20241129132617.400429-2-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20241129132617.400429-2-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB8553:EE_
x-ms-office365-filtering-correlation-id: 1a4c2d4e-e732-4523-2641-08dd1356b970
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bW1JcndQTDMxSGdod2JtZ2lrRTFIckFCcHc1V0hodjlJbm4xbitucDZZVjRX?=
 =?utf-8?B?VWNlZFhoUkQ5MFlmNWcvZWNqM3YzTW9kRVhpWWZCdDhVeWlyMHozZVlWaEE0?=
 =?utf-8?B?akFUQjV1aUV1eHRvWGxRSnpvNEtpMExRUHpjVU9tUitybWZDeEQzbWQ3M04x?=
 =?utf-8?B?MHpVakxua1pEVThtdVRLNnpxci93Y2VQcTloNFJhWUlZcXZxQlN0OHhBRFNC?=
 =?utf-8?B?N3BITkVYRWJ6Z1lwVjZxNngybE5TNGYwalJ2WG8vdU5vSVIxNmF3T0lkMm1l?=
 =?utf-8?B?b0EvbHVXblVXaFAvTjlwTFArQnNuN0xzNXRxMzR5ZmJ0bzN5MFdLelVZVTQy?=
 =?utf-8?B?VjMyakVubTd2aVdNWWNRL3hSSTdTcFk0eE1pTlBHaDNQSVRBL0ROeGQ0YS9W?=
 =?utf-8?B?cDVPRUNtazhSL2JUUXBNTTl0aDlnZE5DYk1zTy9aZ2ZsRmRBeFV0blFTVWly?=
 =?utf-8?B?UXlRRWxybGFPUEFHWFNHZk5udFQzRVdsc2FaS1FGVjN5RkFiTnBsd0RNWFRC?=
 =?utf-8?B?YWx0dDFPYjFaVzh2V3pzNEdXTjJZTTBiZWlLYURYdEdnaTRKSERHVXhmSDRM?=
 =?utf-8?B?cXkvc3c4NUIzZU1mc1loYkZRSjAyMXppVUMxbitjNElPT3Bab01hNGZtMFZI?=
 =?utf-8?B?bjBTSTdGZGJ2ZXIvd2plZTdnbnJxSnp2YitxYU1iV2YzNU5BUm9kaHZtZ2lM?=
 =?utf-8?B?MUpNRlRtaFNZeXlvaGVaQ3dud0hjcUZYM3hPTGdTeHFSSEkwQ1U2ei9UZ0NY?=
 =?utf-8?B?ZHZKZXB3Uk9IczN4ZkVWcGdWUFVvRWJmak50bU1zWlpRN0tadDlEOVdIeWxy?=
 =?utf-8?B?cjlHQ2Iva2Eydk9tWTJnQVBUOVRUTmMveFNUbEUyL3RGdjREZTF3SUtmMERq?=
 =?utf-8?B?NVJZTzFYcVVCV3I4V1lKWUpvc0tIMkVuRGdiYTBYb1dxcnM2QjVGbk82TzF6?=
 =?utf-8?B?ai9sVzFkYTVtRzdkL2IydGRPRGtROUdLMEI4L0NPdThZTFRFVDRFU0ZKUTk1?=
 =?utf-8?B?TjhvSnBsN1hhSnlkUTNGREdSdXZGWjZ2SkVnTFBaS05lQkFkaytBRk0xUFdD?=
 =?utf-8?B?ajF3TVZRWk43djYwUmRXYzNsL1NLYWMwZUJGU2d4c2dLRmdJUFdTbHU3dEtP?=
 =?utf-8?B?OHFpNWlDQzQ4RzVmMnJTK2NiRElEeElNK29YR1NCRGNwQUJQVEswRU92S3hF?=
 =?utf-8?B?ZDA3RVBQdXJWZVplSzYwNWtBRDE3dllWN24rSHhvMFJyQ1hzblRyVEJtU3kw?=
 =?utf-8?B?TVRJdXpJVyswdXE1RXp6ZnlYOFZOYVBCY3ZTUlM3Um9PT1h2WUV2ZGRyR2VB?=
 =?utf-8?B?MkZLOVczdDNBUENMSlBVZzJjNThuVWxZWGhBZjhzU0l5UGFZSmoweWxxK2M5?=
 =?utf-8?B?ZHEyQlJYTmRuMWhKdkVaR1dHcFpUNWRhVVkrUzZ2cWJxYTBScFdCVGdiNG5S?=
 =?utf-8?B?eHo3OEdvaHF4L1ZScExOOTNRaWQ2YjJ1eFRMaGJ1VGJiSytlcmVlaHpxZXBJ?=
 =?utf-8?B?UXhVS21LZzNlUDBLU1BYQ0szTExHWENHb0FCeDJMelg3K0UvU1ZNUmhzeDJH?=
 =?utf-8?B?aXpLb0tjREd2dmZFUG5GQWxwVzBocVZMcDZsR0QwSTZ1Qmg4UUFrYlpsVFAw?=
 =?utf-8?B?aXpXU1pIeDFpa0hSUm9sT0VYdFFkdklFbDloT1ViRnlSR28vclRuMm9xNEo2?=
 =?utf-8?B?QS8wUjVVMFdOMW5lQlB0UG9NYnY2QWE3OGNoL3RZTHdCVUppWjhTS2k1SFIx?=
 =?utf-8?B?OXl4b1dGdVI2bVZqTHB2UW1rNXNaZFVGVGFDUnJpeGtJdXg2UU10M290eG1Z?=
 =?utf-8?B?bGdBQ3QxYWswOEtESXd2ZWpNdnphY1B2Tmc2UDNLRThvcFowclkySU1Uamxu?=
 =?utf-8?B?c1FMTlR6aExGUlErSTFUMXlGdkljbEtlcjJPNW1zU0VBT2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YzVLOGVqeEVFNnRGUDR6RWhIWk9DWmJ6Sk5JVHFySHhkSDJTVFVaak9Tc2NO?=
 =?utf-8?B?cjJFN3pZbUxONnVvVmF5eGtsV3k3SHFITTJPNDNUbU1maTN5bE1ScllHTEhS?=
 =?utf-8?B?SE45Z2cveTgrWThVRW9rSkp6TGxxQm41STBCSnJaT01SUmVHb2RudHRQSjRN?=
 =?utf-8?B?L3IrUHA2VUliMER6dkRYMHpyMVRYU3dCU1oyMnRGQzJoNkQxREY4MVRFRVl0?=
 =?utf-8?B?TzlENkE2SFJYU3JVOVk0bGZPaE5QajFacnRtWkRwejJlTC9ETUJsNGRYTWw1?=
 =?utf-8?B?cnRNZ0s4TFRjcW5pb285RWZQVVJNRjQ4Um5OVHJHeUJkdFJQRzhCZ2ZFOHdw?=
 =?utf-8?B?cGVXK0pZZUR5cCtZbVNuWUpQQ3Fpb21VdWsvRXhNekJZVSs4RWJmUXd5ejlt?=
 =?utf-8?B?NmNVYStENnF1QXluanNjcGU0L2RlcjRxbkNxamlBemlaUlAzemVQQW15Nlhv?=
 =?utf-8?B?R001QStPbnNEdlpncW95cTdjRXJwZE8wUWhJTVVSNUF3WUVlN3BEdUMyc0dW?=
 =?utf-8?B?WG5qZ2VpUkMvY3dOUUlNMHgzdVdzZjRBbDV1NE5CQTh0ckg2TXhxSnh6TjEy?=
 =?utf-8?B?U3hCSmVsTGtMUmpuUFZhOTlCcXpJOUwvK0grcTlic3VkZDNwRnM0TkgvQkJU?=
 =?utf-8?B?WnhBVDZDZitMT0wxY0lMSFJxSHBXVzkxamR5UjJqT0VOa1ZFT3EvUXdqSWdY?=
 =?utf-8?B?eDdrK2YzbjQ2dGUwalVBcHNyOWYveFFTVUYzRUhuTlc0SThDOG5RVmUwUlVF?=
 =?utf-8?B?Z0M3VS9DWkZKVnN4YWlqN0ZmVGx6dGhaYkFIbTd4VzdmWlVHSWh0aGVnTmNM?=
 =?utf-8?B?OFdPdkUxRmNXc1Qyd2JEQnhkQ2Z0SkZqdkRERGhsUzZTNjhNTEdGMGlQYkNH?=
 =?utf-8?B?WnNVT0ZmRFR4UDdKUnVPRGlOdnZOMkh5cHlqOFdFUXlqNjhMaHBPOEtNU2kr?=
 =?utf-8?B?a2dibEFsUlNHRlNQSzhVbkVEZ081UmxtK0h3OTYwaEsvSWM3KytzYjJVSk9Q?=
 =?utf-8?B?UXlTbVc3SXA2Wi82RW04ZEF1cVlPTzM5Zzk5RjVFL1c1NC94ZThlaUxNcEFI?=
 =?utf-8?B?QzNXM0Zvc3dPUlhpOUJRUUxhRWx1VzBBTCtxL3k4UjFlZXVxRkhTQ2JwUlJV?=
 =?utf-8?B?VGp0Q0VoZjhWSFJlNzI1d0h1K0U2dzV5NmN4ajJjMjJYZFlFZTdsRFltZmU0?=
 =?utf-8?B?UXNjamhvSnlGS2piVWZRRnpPZXBLRzYvbE95MFdWYzR4Y0hOSmEvNlFWZG8y?=
 =?utf-8?B?VDZhaXMzQXlGUjM5YVYzN2R2d0FEWG1aMW9ObTlIWTVVUnVPNk1ldkZwNHJt?=
 =?utf-8?B?dDh3andNTE1meSs5SktXbldVWTRjbStIa1M2TUUvMWNsM0pIUFIvVmw1VE1q?=
 =?utf-8?B?K0s0QjR1NnhTc2lwUFkwbWc2WnhyNmd4WFJuRmcxaktBUisxQmhUZTJtZlJz?=
 =?utf-8?B?K3hzNHBvbDI1WnRtVWg4VSs1eHhYQ3UvTmZpdlBiZlI0dnZLR3prS0kxZ0sv?=
 =?utf-8?B?MWgrNTB1SC9vQWFiSEZ3MG1vcDF6QisxZktDR21RME9DQUo5OGIwMFkzUXJx?=
 =?utf-8?B?MVQvWEFhaU5FOXlPREpWUUh5R0FiTWJwTUkrVFRaRzJQNUIrTnhOQVJ6SVRm?=
 =?utf-8?B?K0YralBlWFJWWk9XajY4NGJFOXRtekdWdEhGREUzZ0k0OUtCNU1kaHIwTWhv?=
 =?utf-8?B?eksrMlNEcFlNMnVNN01PMi9XSDN0akt3WnpUQlI0VEZ1L2ZyU0JBeTZGUlVJ?=
 =?utf-8?B?ZDI5TEdZQ1BwbDFzTnFRTHA3QjZOWE40YmI3NE0vanRVS2pTV1BFNUJURURo?=
 =?utf-8?B?c2FieE9QRG9RblF5RFBMSW82aHE1TnlKc1ZaRkI1M0QvU2xpSndHaldpQ1Nn?=
 =?utf-8?B?MCtsVmVmU0RxVEFZclFkbmY2YXdyTklrb09VdjJXY28wdEE4a3l5dEhlU2Jq?=
 =?utf-8?B?TWhORWh4UG92VzUvRVhjczFSb2pHVVh1QmNQbFdHaFQvZjhjd0x5dTJLRzR6?=
 =?utf-8?B?QXRyTlBMRDM4cCtNcFJFVU5Kcis5aTdQK2JCMlh3c283QmovalJJRjNLWHVl?=
 =?utf-8?B?cEF1eDNNRzE3d0ZVQThsNVA0QWZnNGRaWVBKY295aUJ4Sk0vTjhqaSswbTBr?=
 =?utf-8?B?TFRCTHlSeVBtN3FFUjJSc0VtcEVONzdUMExCcmNtL0pLZHlvNFZTNkMzUFlo?=
 =?utf-8?Q?s28S5ei1pxgFBQXqfqsirHozI9ZvcDqRTOe0x35V37gh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2B0FE23ACCC744088490F1FC201E59B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4c2d4e-e732-4523-2641-08dd1356b970
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 04:55:35.5220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wmmXUCt0LwDDxE0Crnh02VRbuRudbf1nVdB2kYSkGo92wQgr1X3P/W9TCgY9Kjy1eI6tkC3BUQiZReBgH4kBpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_205546_285438_664C206B 
X-CRM114-Status: UNSURE (   7.13  )
X-CRM114-Notice: Please train this message.
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

T24gMTEvMjkvMjQgMDU6MjYsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBUaGUgZGVm
YXVsdCBoZWxwZXIgZnVuY3Rpb25zIGFyZSBkb2luZyBxdWl0ZSBzb21lIHRoaW5ncyB3aGljaCBh
cmUgdW5uZWNjZXNhcnkgZm9yDQo+IHRoaXMgdGVzdCwgc28gb3Blbi1jb2RlIHRoZW0gdG8gY2Fs
bCBqdXN0IHRoZSByZXF1aXJlZCBmdW5jdGlvbnMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEhhbm5l
cyBSZWluZWNrZTxoYXJlQHN1c2UuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IFNoaW4naWNoaXJvIEth
d2FzYWtpPHNoaW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbT4NCg0KTG9va3MgZ29vZC4NCg0KUmV2
aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoN
Cg==

