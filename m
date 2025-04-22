Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134BEC369CB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 06:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vAWnEg6tHXvjhI4TKc4cFLFbjwy23HczQxMrzVJsZvE=; b=s61zTQpeYYRHWjolHjobQ7L9QE
	itSzmuCiGFzLyvHN9n1Q25okmANgLrvAH+YBuujXamWI9KPne7CTyI+TdiKgOp7QcEry/6MLFuFCR
	LPTl9Gv+qp96/KqPxcPpmQzWipbtKhJaEq5B137M7cPCHG8TlPmf84I2gHDVB+qLFAarrfin5MVi8
	TDaDJAzSgmmanbPa/r/fb9lGnKcCtllCYG1z8/mczji+EHaLvlYiUQ7Y/QphWuRIqJFv+K9dBbCll
	2WNUrXcitUsDG85gbGMX5ej8xjjt6X9oGrcFhC4gbVHKNJWxoqlGDXMzmA84Ub0pnqDdlnhOagViG
	w5NWjumA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u77Fs-00000005zSb-3OqH;
	Tue, 22 Apr 2025 06:37:16 +0000
Received: from mail-co1nam11on20610.outbound.protection.outlook.com ([2a01:111:f403:2416::610] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u77F6-00000005zG7-1gq0
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 06:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQthumxG5cOkkVbLiKg6B9fTIticz10BO+kxhGLtWIflw0EAF/BU9eTLF9jqtBSasmdUte9H/EnztfqwawyHTaOIxN2xgttyjIjS7qNQQvA8MteJhQsOBM9nJ8s0OxkBVVm3YwZmu35LBkaToVzt7169VJ3otAazdrB9Z4F2zjndnjHMvawOGkGwZwMKaofd9WzMGNDSUb7mWsMdbJu1uyBag5RuycC/aoSiMF3R8L8PhNgOTkyTdKlQek+qxADvU8I5AlhhEGSfsH4sk1Skkl4skuuo78/dKCfy7jbS7Tb6apYwOseuShZBKpKXD5zKG83HgMoKsq8QJLmXsuXl9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAWnEg6tHXvjhI4TKc4cFLFbjwy23HczQxMrzVJsZvE=;
 b=tC95ZADAYHHAcPajKUszKcLi7lw7/yyR3Gu6KD3y4FQQFdYUu7tsvIPVdXwsMyJW98VGaXkDjCx2oeYUmdYRakxOqR110RdlcAdBdU8HjFXgTBLUPt8D+S/HsOdYb0q51C8rkRNCktd0obS4DdR3aylaN7bIVBFLFojAM6oez6/nSOugNetCR0sIK8TnVG/FkYzn2UAfrPvYyavr9Cc8eIZEqIsZ2xRAPGEgX6/7Mlsj/q9fOuzElYjVLVal+Xg8AZopcUr72VVWK/GwsMUDxix4yFUISg5dmLRJCh/cgNjD5JqnrXHnLtaipMl/ObHZaFg0LfCBpB16imLW/d7d9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAWnEg6tHXvjhI4TKc4cFLFbjwy23HczQxMrzVJsZvE=;
 b=RAftWerXR3/2oxsMq2K+u7ZvSLweO/OlPSLs0EvPwFXERum/OCgGBIfbNP3f1jwEK2qGWmCFQsG3lbTl+HbHjWa6o6ks5Cjz1AHMQ83u7VowzRkvsrQrCoueSWYqMIMI4KqI6jKSNVDMQp+65Dn3tedvlubTF1/48QDZwOt4dPLj8JLKerJBI19Iejiz1RpgJvZ1fjEMQEOdArS/cnSdquzpwD7t2DissoILWPk5/4yPkHeWTh4fbYiJEn+YkB+k1/gumQ0c2ocgGrpSu97rmptRPGe5DD4RbDalBT96HAaJgzBFnDxAkHrMl00iWIXnaq1XEUmD/UMUMxD82nc2mQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL3PR12MB6473.namprd12.prod.outlook.com (2603:10b6:208:3b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 06:36:24 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8632.025; Tue, 22 Apr 2025
 06:36:24 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Dan
 Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] nvme-tcp: remove redundant check to ctrl->opts
Thread-Topic: [PATCH] nvme-tcp: remove redundant check to ctrl->opts
Thread-Index: AQHbrcv9d+jpQs88DE6ANoKex1uL7LOvRiKA
Date: Tue, 22 Apr 2025 06:36:24 +0000
Message-ID: <0a0a8709-cf60-41e7-bfc9-d9aef39c782a@nvidia.com>
References: <20250415060021.16472-1-hare@kernel.org>
In-Reply-To: <20250415060021.16472-1-hare@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL3PR12MB6473:EE_
x-ms-office365-filtering-correlation-id: 78cbbe7a-76cb-4959-de04-08dd81680098
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TExsQnRlZWl6cjNmQkZvdS9xRzZ5VDhLbmdxYTBScTBKUG8rU3plYVI2QThY?=
 =?utf-8?B?MFl6cGdJVlNpQWNDQ09EdEVLeS9RMUxYK3ZjNkVOaUtUVWh6ZWVpODR4dkZm?=
 =?utf-8?B?QUpKYTJkQ0Q5SlJuRmYrcDQ3a1k2MTVWT21yQUwwWllsRGlQNThkajBOajRG?=
 =?utf-8?B?djNCamZXQ3NDTGc4WjJIUTFQbjJxWUpoWEtwL1dWYXZaVk1ORzZOUCtrZU0r?=
 =?utf-8?B?RzJycG1pbjlBNWJmeWtxSnNVeHE5cWJ0WmpxMkhqbXVDR2NrYVV5UStXYm5K?=
 =?utf-8?B?RUc2M1Z2MDY1SS9lWEJ0cmpXMkhjcCswZTBVdXEwc1Z5aTd2dVF3VnR0U3hw?=
 =?utf-8?B?a05wcm83UHlzUGVBWnB4cG5aNFltaEtadTlvZFJVaFVDb2NSejRneDlNOUVO?=
 =?utf-8?B?ODcrS1h4NllLRHlGRXlCam05RUhjZWpCS0RKcE5PeFFtUk84TzhBeWFaQWtq?=
 =?utf-8?B?QU01U3g4SVpPREljUjNNRmRzZFliQkd5UmFvTDF2emZJN1BlWnN0Lzk1SEhC?=
 =?utf-8?B?ekxtMlF1a0FUQ2xNWFl0Zkc3Y3J1THpNa05JT0ZLcUk1UHN6ditONUluUE0z?=
 =?utf-8?B?UUljRjdJRjIzMDBrNSt6eGhyaHhHWHNsNkowODBIVkQvMVg2bWN0cktSYUtJ?=
 =?utf-8?B?dTZBOWVBbldTUjVpV2hkUUhndERiaVRFZVE4ZjNXR21FMXVJNUIyZG11UEt2?=
 =?utf-8?B?L2pPZmM5djVvMHZZUEpCTURoNG56OStHWUN3Qmdib2Ric1dPMnVLcHJsQmpx?=
 =?utf-8?B?bWtNMlFyYXd5Szh5ZkdoWThiSjl3L0tKN0tFUTJWT2hMbG1pZzZmbWRmb1hu?=
 =?utf-8?B?RGcySXo2bjcvclZCL25mbWpFby82M2FEMENCMGhPU2k0Rm10dUJlQnpGdFNt?=
 =?utf-8?B?R0tnUVZkNUlyR0RCWFBpVWYrWERPZVFIR01xQlBMMitDMVpBQVZJRE0xVmph?=
 =?utf-8?B?TElKTEJWSE1RaWpoSHQ5amc1MXh2ZXBvdXFhQmV2d1dHQTQvRmR1WUVSRHRH?=
 =?utf-8?B?a2lYR1JzcG5SRG0wRkFWNy9lTWVLU25Ub2x3RXgxQWlVQVhQNEowTXZDeTE5?=
 =?utf-8?B?NDV5S2F1amdaQkxOcUs5OXNzOUlRb2NCVUR2a0EzVjM5VzdJcW95WHhvbzBC?=
 =?utf-8?B?dDhaWi8vWi9ENE1ZZm1rdUxxVldJaFJ5cTQrM0lrTmR4Z2hhQU1qdTBINUtw?=
 =?utf-8?B?RXh3b2dzdFpyRkRoaTliWi9ibFRQOWkxU0JKNXFGd1hFS0N2ckFUdG9KVFlM?=
 =?utf-8?B?RFQwQ3BoYVFYcnc5RUtKTGtxaGtOM0lGR1RaNU92RTkvbXJCL1J6encxV3Qv?=
 =?utf-8?B?UWNWcDJXbXd0czNnaDV2NlBFZDhYaTNEVy9jc0lBWUVOc3hGb1oxY2dBN0sr?=
 =?utf-8?B?RkYvMmVMYWdoTGcrTzk4TEhRSlhhTDdQalk1ekVlMlBpNXZndWFIY2lPTlRV?=
 =?utf-8?B?dFdPT2xCNGtvMHE1N1liU3ZQRm5PRnFsQWE0aUVrZjdja3ZmaStxUm9LODlB?=
 =?utf-8?B?TkZiWG1vSGhadktwMDJYYTgxekpJOU5LaFhjaDZ2M3p1RlpHUHArT1QvcU5K?=
 =?utf-8?B?eWUzeXY5SU03QW1Dd2JYM0RhQmE5dG45Z01DalBxbGNzOU1YRURVRExpMnY4?=
 =?utf-8?B?VTdDUTZqZExFT2VxOFpieWY1S1JZR3N4RkpQenczYk42MWFHcGJIbE9RRlVx?=
 =?utf-8?B?MGVlV0Q2WUZlamVjbzdwelhiRkdLMU9hL21uN0hlVVF2NnhFNGVDamxSYkRa?=
 =?utf-8?B?d212MVZMWXVuU3hZcFp2QXV1SE85WmM2SXlReEN0RDBVdEVOVGFxWnE4cXpz?=
 =?utf-8?B?UEIyOU5DelUrVXVRZzJENm5laUozMWFBTTM3SmZXeklkQWJNK0hTR0g5OHN0?=
 =?utf-8?B?RVAwTzREMDEwd2U4NTk3U3JiVGFJOTVDOHFiem85VFNqZTB2aUptdUgyUitO?=
 =?utf-8?B?UTdFTUdLRDR4eTRNR3RsUU5zM3JhU2dPNUtSOXIrK1hBM0wxMSsrWHNWMzR3?=
 =?utf-8?Q?mkbwwdODr7RD/PUrU8S7dCTvdn0sgk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHNOSXdwYmY2UjdUZ3pGREcwRFhUQTdsZ0NJRXJoMHpvMTdpU1BtZlJrdVJ1?=
 =?utf-8?B?R1lDb0Y2cGc4ZmdLT3RlUTAvdncxT1h4cHZsSWt2MEF3VDR0YzJaK3NQU0pq?=
 =?utf-8?B?STFtaUtsNFV5UHZ6c2c5Q0ZyWkVXR21FT3lYczZIOWt6NDdVRFAvTGxNam1R?=
 =?utf-8?B?VVdpcFRYeXJxRzNwT3Bsei94eWsvUHljRHRwUC9VV3JYalAzenFQRFMyYW9k?=
 =?utf-8?B?aWltWTRPUmUzSERkN0tYNmxObHhOWFhCOXpmOHRvQmo0SXBrOEVzdDFjWGhS?=
 =?utf-8?B?TDFMVDlYWFUrV1J4b3h4RitIMFBNRlk5SmlORThkNnVzcThyQ3JoaTVVd0NP?=
 =?utf-8?B?NmlTOCtZLzFaL25mWXY1QzNmVzN1OWFBTHBTOE80T3kwRDZCd1kyZVVmSStB?=
 =?utf-8?B?MDFCbkNJaXdkbGlSVHlxbldocVBjelp3TTVKNjFHTC9QZ0ZMREJEbllrMUEr?=
 =?utf-8?B?STdIZW9EWFJxVFFVMk1yOC9RaDZvd1IzRFlSYUcybkJJQTA5bmFOdENPUi9q?=
 =?utf-8?B?VEhoeGJISHQrSTltdGdkWVZseXAxeGNhc08wWGp6amhyb01EWi9WcHdYUnQw?=
 =?utf-8?B?NFFRVldiSit6MkJLOFlvSDhiMkhsTXRxRW1GM2lkdngxbzd6TGhQVG9tK09I?=
 =?utf-8?B?a1A3UjhybzNLSGdaTUhCTG1OMmdONTk3UVplSkI0S0ZuSDR1QkQraEhxMi9R?=
 =?utf-8?B?Nk9rblhuNEFVYkxKaExobGZJMzh5TFJDMy9zRi9QUFNlNWdOakxYaG5iQ25S?=
 =?utf-8?B?UTkwbGc0Vlp0T2F0Z3NVWEl4NVByMUUvZ0ltcXpBSlY0UHdvOElwajlsU01t?=
 =?utf-8?B?LzZpRlViNTBneXJIb0xBOHNaZnB0V055cUNPSU9icW4wL2FBUTloTmxPZ1V4?=
 =?utf-8?B?b01vWTlVWmlJcjBSTUl4K1h3bTN1a3lDcmVqNkRWclVwOU1SUFBoclpJSGJi?=
 =?utf-8?B?Y04zbXZYYWpVc2laL1FrUmVYdTFIdHNPK1UzL2x4cUxpeW5SQnV2djI2amdC?=
 =?utf-8?B?LytUdGpjMFlxcjZBSWNVRUNmZzFjZUpGOUs4aHZ6eHkrVjJPZWRVb1g5eXFh?=
 =?utf-8?B?aklWU1V3ZDkrRHViRWxtcklEb0t0U3gveC9TL090djBWYUM1Z0JKNGJNWjAy?=
 =?utf-8?B?dFVIZHdtcDVMaEt5T01kVmlBWDhncEdoTnFYWnQxYWdsdDM2bitTYWVCeExx?=
 =?utf-8?B?eEZzeW5zWWxlbkREdC9STW01TFhLZS81NHJYNEFtaFpXaTdMWmFhU2xYSmU4?=
 =?utf-8?B?ZUlBNmRKNEJyYlJtVDIrQjl5UW80QnprR0RQd25NZlE1N0dXRWdSSTZxeVdC?=
 =?utf-8?B?UlZ0TkNQdGptWjgyQ29DR21EbGNNSmp1MmNtYk15VTYrYktLN3Aya05saEU0?=
 =?utf-8?B?azFtZC83dFRyYzhHZ2trZTF3LzRmNGEyNzRHMW1jY2RpM3VWb2xQdjEwSEtM?=
 =?utf-8?B?SHdLWHFaMkJzenZUT0cyWmZ5aWNFK0k0TjJudm1DQzVhRExJcGowMXdweXRn?=
 =?utf-8?B?SmpCSFlsRWRkcVVpRTFvbUNDRlJSTHRwY1ZCZ0lmOGVDZG5nN2tObGFLVUdx?=
 =?utf-8?B?ZUF0U09XOExQUmlOdy8raUdRMElxUnhjTzJrdUNKc3llclZ2Skl5R0hYTkRT?=
 =?utf-8?B?UUw5RU1talFuSVlWNUVEWHBKY1NXY0dyelhZVVQzd3BJSVE1c0tIeElyQVN3?=
 =?utf-8?B?Z1p6N3kwZGdoeEZJTlphcnBhVGxSdFBMcUtUQXFIQkZBUUI0dDdqeXNNaGVy?=
 =?utf-8?B?TWltd20rOU5xTC9DNEx3TzZXdnh1MWM0K3c4SzRxZmIwNWt3eGFGdncwcFZ3?=
 =?utf-8?B?L0E0aXdCQkladCtRL2UzQXhwTU5uR3llZkxGSDc2aXp3eUlndWZlRGF3UGtS?=
 =?utf-8?B?dmt4aDU3c21VeHJoQk1kREwwenI5S1pCMHdzWWdnc1FXVDZFOWFEanRJamV2?=
 =?utf-8?B?elorRnZDSlFhRmgzRUwyeDhJTkRwZis5UERhK0d0aEUvVm5yWUxuU2swVEhK?=
 =?utf-8?B?aExOdTNkdzBwMWRjSGJETW01MU5qRm03M2duUmlqK1pOT09PbkxTRzFhZnFm?=
 =?utf-8?B?YTFKTFdKenZ5bjJvNzkvMStkVTViYzFVckRydTB2QkV6RU41ZW56eVUrRFpR?=
 =?utf-8?B?QjJ0RmRaUm81S3UvTS9qaGorNEJZdWs4YUI2b0IvVTNjQ0prT2hPTzkwUWVL?=
 =?utf-8?Q?H1mfsB7g4XEXNqSss/Uv/uWycuC97v2/4oDdM3wT6oCM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE1883B97155B741B74FEE66E272B4C1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cbbe7a-76cb-4959-de04-08dd81680098
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 06:36:24.2748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mv9gujUEaOdM8Rv8gZEWHNegW8NuvGXUK0C6x+yy06tx3PY3h9Getc86ON0I12CJDT2W0uuUDjdGzqbFq5rpcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6473
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250421_233628_450993_D434626A 
X-CRM114-Status: UNSURE (   9.07  )
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

T24gNC8xNC8yNSAyMzowMCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPiBXaGVuIGNoZWNraW5n
IGZvciBzZWN1cmUgY29uY2F0ZW5hdGlvbiB3ZSBoYXZlIGFscmVhZHkgdmFsaWRhdGVkDQo+IHRo
YXQgJ2N0cmwtPm9wdHMnIGlzIHNldCwgc28gd2UgY2FuIHJlbW92ZSB0aGlzIGNoZWNrLg0KPg0K
PiBSZXBvcnRlZC1ieTogRGFuIENhcnBlbnRlcjxkYW4uY2FycGVudGVyQGxpbmFyby5vcmc+DQo+
IFNpZ25lZC1vZmYtYnk6IEhhbm5lcyBSZWluZWNrZTxoYXJlQGtlcm5lbC5vcmc+DQoNCg0KTG9v
a3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQoNCi1jaw0KDQoNCg==

