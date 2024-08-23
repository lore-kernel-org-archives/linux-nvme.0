Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133C6C52D7C
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 06:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qzllsCcdrHzWcL85smuiIlBFuUxzr2b3muxUj0z63DE=; b=njdXJ62uqKzGKkM8mzcTkABonO
	7/lnmF3yFwWGkgduwLAU9nX9Ez/V5pWm1FQwc+zMYL/F7iFDb6egku+MkVPDEswa71zbksiowrLXj
	HMX3nmX9QU57XInE9+g0y5vlivPldefW3dWEzHWQfssWkXFL2rg6kRSS0SOYyJKRCD/NUssc7QfoC
	Kbhyi8UZgUbFZuqNGcR+3EA6LUpTgX1OFkQPo9dZK54jzmCXUTvG/CPmOk3Y4Xta1+yQXf3x8lldX
	LpdT9C9eA96rnzsCmDY2GdiBuueiIhegPupRclewMgTItTolbkEWaoy+4WaV9aAWnIgvmaL4lQVr1
	dEDpWW8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shNyy-0000000FUVY-0UlN;
	Fri, 23 Aug 2024 06:41:12 +0000
Received: from mail-mw2nam10on2062d.outbound.protection.outlook.com ([2a01:111:f403:2412::62d] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shNyu-0000000FUUC-09C2
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 06:41:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUpeDQ7wZ3VGzG50XQr9GUrLVLn4jH8lfvtoUtKn15RibTvu48Ye8jtyrK4kvu3LchnGdNgncWX04NZhU+k5N+6Mmp8Z6BU/oyd6FXEdnfAyhNfcEOCn2raSHU7a4S8RNRQpzRc6XgFiSFMk36/2XBwTUnCfdXhhp2D8dlHh3Ffok2k1NMbhVeLBKTALbaRuoBh2XLBW6z8Fmefx7RkPd8oydpVsfcu+1aX3hhpgzenWB1MFmJqz0qDw2ghFATSWYxeuLkknNACw6iXtLjWmpKckG0oVxXbbRpoAGL4qKFXDx4c3wH5RHjjyPkzJevInpl2/ptP/ostm5n5X2brTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzllsCcdrHzWcL85smuiIlBFuUxzr2b3muxUj0z63DE=;
 b=QKj9wkq13YXDjPVsabb0I7aY0C25GCmFiKT9MkOINWgTy7JryaJ1GDJxsAMlCFEW6036NDpMG9agWplHNxjMrWse6ZrzZ+LB6JDo+Ap3fae2oVGHojUm9pN52AjlB8SkHYzp5hGcfRZpdyqenZsxRO7OcRAFi8OOk2589TEXu32uW15eLKAnR017gu22CCsWaedz2aP6Sx4uf90BDlZhVKOnDdsZuP/OCMFBUGQbvDwqbY1ItU+6mdeQhfBcwCe7MrMo7l+HsVzvFR1oFcbZ0rTsR3VtuThsP8R70ZSPU4PHD00/HYv8opYv4zefGi9Aot5zQ0qrROPlo6UIORDiow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzllsCcdrHzWcL85smuiIlBFuUxzr2b3muxUj0z63DE=;
 b=NasnSeHLSPCfEHbuJyJfLhB2876UD/FwPDi/5GGO5L4iIHgruGEerzBOoMr7sepgOlaVIWzi24qnK/2oN2aFtqCpRDBgZLU2R8njJGxPYZ7L17EUP+FU9EOAOTFFl187WrBX3MG4joBLH0deNyhZlbCw8z4R0I5IppdhwzdIKtP4+S4X7nTchJwW2gj+IL3BgNH95dtWaQA4mz9qp5FbfhpW3msw38KtqmulLRKFQmu1/+vl7TqGjAvOzo1E+E4Fci7/HoFAVZ1H/iPHx6PFOTMcqrKKdOt6S47d841nrUE56ApAoKvA+mb7FbmiauOP650ewVQep3mtf4In9/otqg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 06:41:04 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 06:41:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next RESEND] nvmet: Make nvmet_debugfs static
Thread-Topic: [PATCH -next RESEND] nvmet: Make nvmet_debugfs static
Thread-Index: AQHa9GKQSA/r5RlGxUmmWIo9F3RKPLI0ZhOA
Date: Fri, 23 Aug 2024 06:41:03 +0000
Message-ID: <f2ce9842-5361-423c-b281-812cb19fc2ed@nvidia.com>
References: <20240822071916.3547318-1-ruanjinjie@huawei.com>
In-Reply-To: <20240822071916.3547318-1-ruanjinjie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH0PR12MB8580:EE_
x-ms-office365-filtering-correlation-id: 01c54a05-9d31-405b-dc71-08dcc33e8f4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dHdqNkt3dS8wOVgvbkw0b0JUUmJIb0dJM29HVXk4UlNBNGw4UWx3Y3lGNTBF?=
 =?utf-8?B?Rm54dk9VZDV3OUFDQlFBRTN1M3AybWtkZGlVNGRCME01NHdwMENTaDUxVWxx?=
 =?utf-8?B?MUEzeGNKSzBiWUNuT2UvZ0djeE9VdmxWKzN0QTBGdUJLektRa0dFTmRuSGtT?=
 =?utf-8?B?QXRuM0YzYmVmWVlHeXppcmE2NHRxLzlEWmdFUkpYUGdpVVdSV0NaRVdudUh2?=
 =?utf-8?B?VjJFa0JYMmlGaW9SbjhSc20xdFFLd3l6eDNROVNDOWkwelZBK2xpc3V5Q0Z6?=
 =?utf-8?B?UkZJN041UkxodnhvMWsvcWNlYktDaDk1OFgzMkNBUUZkU3A1bmhsUXd0eHBG?=
 =?utf-8?B?OHZMT01GTlVsRFg3d2pZdWs5blk4MHpEbkdoaFM2ZWNGSEhtQWtnbElFZTdp?=
 =?utf-8?B?VVFzN3FwaUFESmlkb3MyQ00rVW42N1VOdUVVK2hKZVk4ZzZ3R2d5YXI2QUFB?=
 =?utf-8?B?OXdwVDFsYXRyWVVrMGVIVmE4NGNCWjdiYkNWRnY3ZThrTHhYbjE5RFhZMVFj?=
 =?utf-8?B?SzFsc2dsQkY4VktXL1JIM2Y1SkxDWForU1RzMEVGQXNWL3JEaUFTMGVucTNX?=
 =?utf-8?B?ams1ekJISEZxUjNkWllZQWt3Z2xtaW84SjAxSkVEUXF0RE1zNWREcFBnUE14?=
 =?utf-8?B?S1NOd0llbDk2SGMxaXp1ZUJ2ZUxoTnVQNkZlQlFoVzdjc3FrV3FpVlhnc0lm?=
 =?utf-8?B?eGxORWJNRXRoMmhTUDRVaW1vd1dJcjdpRFZYQXRPOCtWQWs2UnNqSWM5OHox?=
 =?utf-8?B?bHZXaldIWUl4SmM5enFWbFM2OTRMZVRURkFkaFZxekk3dVVwWTVBKzl6Tkxk?=
 =?utf-8?B?c25Ndlg1WEhDVklyWVlMSDVLbUxDMEVwbXljRFg5SzE2TC9sYWRrRlcyOGpq?=
 =?utf-8?B?RkZKSHZqRXRIVmlDZWt4bmdIK1JnVnEzbnFvUEZWVmdlRGdDdEl2bm5EbzlS?=
 =?utf-8?B?eWV4Mm8yLzJySXMwUE1KWGtraU5ObU80cllET0VwSmN5d1llV2JRR21kRWly?=
 =?utf-8?B?dWMxajNESVhEMTRvSHNRNjdyVVU0S1haMXZpRUlpZHZCOUhuVHZNai81S1Y5?=
 =?utf-8?B?TjA2MUlzQkFZTjZPc2l3SjYxU010OVROUlZEV0dTNWNQN2g4c1FWdEU3dUZF?=
 =?utf-8?B?aEJRWTNscHRUaEVoRVhBUERocEVIR2d4Z1d0TlNzWG9ERnRUaDNwOXpPZXFV?=
 =?utf-8?B?emxnS0JqM2lJdldLYWdCZjluNG5DdHBLMHBoNDc1NWZnRzl2Y2VKY0JrdjF1?=
 =?utf-8?B?NHhvbGxQbWhBcWJCY2pXNW0xRUhtSGJsYlhJNDN0OXA2U2RoUCtDTVl2d3U3?=
 =?utf-8?B?d0Z3NXFYSERjZDVuMXA4dU1PWElxbVU2TGVXYTZIK3UySGRsTk1SbEwrZytH?=
 =?utf-8?B?MDRSSUM3Sk5BMG1vOUUyV1hYTS9jZi9UeGpIaG0rK08xSFRyVVZuQkxiT1dw?=
 =?utf-8?B?VjU3cGdRLzhoclBheG0zTmFpUU1nNTVVM2hUQXNheFpheVlHWHpGOUFPMGNR?=
 =?utf-8?B?eGMxZ0Q0UlFpVHJWRGJOZHJUTXFoRkxjbDFnaTNEb240eG42eWFaL2dLVWdO?=
 =?utf-8?B?UitzREJHVndJTTdtMGpXcnhQODRuK2Rkekc0a3BHeWFaTm5CR2ZVdExOUjJ1?=
 =?utf-8?B?VzhrZFJuZ3d3dDZKQUZQd3U2V0FXOXNNNTlrclpMcnBpcGE5UTh1NWdkOGRz?=
 =?utf-8?B?U2NrL29ndkZHeHZmMHdDM1hFZHpmenpFeWMxd1NSNGJGTFQxZzQya20xei9v?=
 =?utf-8?B?Mm5uQUpTVHFEcVdxVEZvNnN0dTE3ZnYySUxEOFFTL0dzRVVVc0hBbHE2Ykhv?=
 =?utf-8?B?ZHFDWGVjejNGejQ5eHY2dFR3ZzY0OFZDenJTdVAvR1gxVWd1dzNSQ3I4ZDJQ?=
 =?utf-8?B?YXIvREZKOFN3dmxLdkduNzVkazdMS216eDZPb0dicGR5eGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkxhOUl6RzZvZWdZanczcjNLbzZXcndiZVlUYnYzT3B5bUd2TGZhbGtvKzZ6?=
 =?utf-8?B?TE1iclBLOGM0NFNOdTJSL3lJd3FibDB5Wm9ZVk8wMnBoTkluSzhUTkNKeTNF?=
 =?utf-8?B?WU9zLzMrSHdBMzRlSWViYlc2SHozWGd1OTBRM3ZKVG9kdm1NWStRMmJZTklC?=
 =?utf-8?B?bnd6T0w0UUxNK25najlmZUJRcXVsMHN2bTRLb2NWS3ZlMFVmYmVHTnBFRkFK?=
 =?utf-8?B?REpERm1icU9JdUNQYXJNQVNUVGx1ais0cldseC9LTk4xcWVpbXB3VDBnNElj?=
 =?utf-8?B?dTVHWHNOVkl6TzFOamwyM29VdnNrdlJ5TEkzNFBmVXlRbTBKbHdmcUJQUHZk?=
 =?utf-8?B?Y3lVUDY2UStiVExMallYM1N1ekhaaFlGZkV3eENDZjhpcUxQL1d6Z3RYb2hG?=
 =?utf-8?B?ZjZOYTZyc0pGWVdLNEJBd3F5NnR6ZVM2MXJQb0xTKzh6d1hqSkp4UlZodVIx?=
 =?utf-8?B?VUJ1OVpmdmRPS0RqUjNxTzEvSnczYmozc1pNRzhaT0pQV3J3R1FLQVVZUGM1?=
 =?utf-8?B?OHFGZ2dvL3lnQzhSVTVTSDVZdXo1RUlQdm94elNCNW1QN2dDeXY4d0lzTHpN?=
 =?utf-8?B?L0VYRTZSQkFLN2xFL1Fkd0p0VG1kRi9TZndSL3FRVVFEcGhma2dKOVpPVGRX?=
 =?utf-8?B?RTRZeTBEazM3RnEwSXRZL3EwV2xCNVRQTzRRd1BDVUFyZVJLMTVocGozazVs?=
 =?utf-8?B?SmU4T0x5M0h5Tyt5cUFleUlya2c5eEp1YzhmQ1ROakhnWUFxRFVZaW8zcnZN?=
 =?utf-8?B?L2NsWmtvdkJSYmZsWkRiV1BNUWZ0MmVLczFabHBFZVp4SGlBK0ZFSnh3WkNk?=
 =?utf-8?B?RERrMkU3UWVtRUlOVE55Qyt6NVhxbDNubTd3QkkxVmVaOG8rbVJCYU40SXJo?=
 =?utf-8?B?b292UldsbVlGRlFwcjVQd1RQaW42RTFuS1Qzc1dqaTVTb1NPNFUwb2YxTkwz?=
 =?utf-8?B?MUVjdHJlWmlYT2JKQmVIZ3Q0amR4Z0dxQXBrb1NMOVEydE9VL29CQXA5d05q?=
 =?utf-8?B?WGZESVMyTCtScFh0ZUt6ckdFc1JCemF2S1ltcXJNcHlTc0lDMzhTVmVsZUdI?=
 =?utf-8?B?TXNVNlN0ZEVYUTIvVzJmQ0F1bHlZSFZhL2pBT2xXRGhSMTBSTFp5WlljWVoz?=
 =?utf-8?B?UG9WYzAvUzF1aUUvbzVLSnVYK0hhMzRJUTNmcTg0MVYzdVlaeE9veTNoamJi?=
 =?utf-8?B?cFJzNS9KdjBQVlpSeVdaKzVZNURBWjNDL2EybDZ3U2ZCTlJFWEc5d0x3YzFI?=
 =?utf-8?B?a0JJM0hMR2VEYjNSeFNGVmE4M0s0c0xZMEtnalBMclBKcjgvbUczeFg0dC9O?=
 =?utf-8?B?YTBTUkVvQ1FHTWNpMEZnVU5pZElzUnozd0lNWCt1eWtvSXlFZEdSbk56K2FU?=
 =?utf-8?B?dzR5ZVNOcUF5dHgxaTIzQmFMV2dQRmM0UjV4SGFqWjJid2NGUXlDclBvQVBY?=
 =?utf-8?B?U1lRcDBJSjZkem51Tk4xVmVqMW84dG54cXdVUHhGZlpmaitPaEsyZUZMcGhm?=
 =?utf-8?B?d1ZIUFo1alFsK05tdUNkMkgxcE1RcVhtSXFTRENiM2VqSFRyclNxQ0RVT2Rx?=
 =?utf-8?B?V2thR2hhdTNKQjVwbHMvYzRXaURLa3l5R2V5QkRwRFUvc1lvODNHSXd3OTh1?=
 =?utf-8?B?UkJSRjBqRTRvUEZkWEU5b29Sam5KNU5HT3RwS0RxU05OOHdEZW04N2pEdGp1?=
 =?utf-8?B?YWVrcEZ5S0RBV2U3clZCMU4wUi9LRGlncGtudk9yaUJUQU9Jc3FoRURpeGxs?=
 =?utf-8?B?dTl2d3BUdk1zZ2xRankxTDhMTlpEMVUrdW4vUVhreC85ZThxWmNMeUpJVzM2?=
 =?utf-8?B?MzI4ZjhvZGl4Wm9qczJoeGlGUU1XdTEvVTFKYWJUMUdsZkkrMHhRSDJPd3Q1?=
 =?utf-8?B?L0RFcERzUzM4RmdtRkFQaDF2eFhzZ0dHWGxLbXNhR2pzSEN2cGxRUjdrVG9k?=
 =?utf-8?B?d00xdmJQeWlYTmthZEtsdEVnZUZjYTl1MitQRGtkdW1SS0hSMDVYM1Nma01Z?=
 =?utf-8?B?R1ZoNnJkbWV6ZXViaGt2VXBVZ20rZ0RQT1ZIaW42Vnc0VFR1aUZsd2h3SCto?=
 =?utf-8?B?MFVZSDJKVEVqbzdCS3VCUm5PVjF5RHhsS2Q4ejlPVHl4c09xNDdZRXBKajhX?=
 =?utf-8?B?SE9yWEwvdG9wUkZTSndlR1F1dUwvbi9PZ1BZYXlzcUE3ZzJkYVlQVXhnWnJn?=
 =?utf-8?Q?2YC357CIVq2fQbhxKjmojosSQNTMEL3Hwt/ci11sZTh8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C342DCCE2C1A24DB0A57FFD02050476@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c54a05-9d31-405b-dc71-08dcc33e8f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 06:41:03.8801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9GifwrXBz5OHws4klKhXpMBKoqH0pbypTqppwVnAo+JcGmZGY4QPKmX695fSk7ykT45R4SMuLdftlKPNJ9+EEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_234108_144611_58DA3394 
X-CRM114-Status: GOOD (  17.06  )
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

T24gOC8yMi8yNCAwMDoxOSwgSmluamllIFJ1YW4gd3JvdGU6DQo+IFRoZSBzcGFyc2UgdG9vbCBj
b21wbGFpbnMgYXMgZm9sbG93czoNCj4NCj4gZHJpdmVycy9udm1lL3RhcmdldC9kZWJ1Z2ZzLmM6
MTY6MTU6IHdhcm5pbmc6DQo+IAlzeW1ib2wgJ252bWV0X2RlYnVnZnMnIHdhcyBub3QgZGVjbGFy
ZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQo+DQo+IFRoaXMgc3ltYm9sIGlzIG5vdCB1c2VkIG91
dHNpZGUgZGVidWdmcy5jLCBzbyBtYXJrcyBpdCBzdGF0aWMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IEppbmppZSBSdWFuPHJ1YW5qaW5qaWVAaHVhd2VpLmNvbT4NCg0KSSBoYWQgcGF0Y2ggd3JpdHRl
biBmb3IgdGhpcyBkaWRuJ3QgZ2V0IGEgY2hhbmNlIHRvIHNlbmQgWzFdLg0KDQpSZXZpZXdlZC1i
eTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCiBGcm9tIDE1
ZmMyZWQ0ZDk1MDhkODQ4OWNlOTlhODc5NGY4Y2JmNDVmMmIzZDIgTW9uIFNlcCAxNyAwMDowMDow
MCAyMDAxDQpGcm9tOiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KRGF0ZTog
TW9uLCAyNCBKdW4gMjAyNCAyMjoyODo1NiAtMDcwMA0KU3ViamVjdDogW1BBVENIXSBudm1ldDog
bWFyayBudm1ldF9kZWJ1Z2ZzIHN0YXRpYw0KDQpNYXJrIHN0cnVjdCBkZW50cnkgKm52bWV0X2Rl
YnVnZnMgc3RhdGljIGluIGRlYnVnZnMuYyBhcyBpdCBpcyBvbmx5IHVzZWQNCmluIGRlYnVnZnMu
YyB0byByZW1vdmUgdGhlIGZvbGxvd2luZyBzcGFyc2Ugd2FybmluZyByZXBvcnRlZCBieSBrZXJu
ZWwNCmJvdDotDQoNCmRyaXZlcnMvbnZtZS90YXJnZXQvZGVidWdmcy5jOjE2OjE1OiBzcGFyc2U6
IHNwYXJzZTogc3ltYm9sIA0KJ252bWV0X2RlYnVnZnMnIHdhcyBub3QgZGVjbGFyZWQuIFNob3Vs
ZCBpdCBiZSBzdGF0aWM/DQoNClJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGlu
dGVsLmNvbT4NCkNsb3NlczogDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1rYnVpbGQtYWxs
LzIwMjQwNjIwMDUwMS41RHJGdThGdS1sa3BAaW50ZWwuY29tLw0KU2lnbmVkLW9mZi1ieTogQ2hh
aXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCi0tLQ0KIMKgZHJpdmVycy9udm1lL3Rh
cmdldC9kZWJ1Z2ZzLmMgfCAyICstDQogwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQvZGVidWdm
cy5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9kZWJ1Z2ZzLmMNCmluZGV4IGNiMmJlZmM4NjE5ZS4u
MjIwYzczOTFmYzE5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9kZWJ1Z2ZzLmMN
CisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvZGVidWdmcy5jDQpAQCAtMTMsNyArMTMsNyBAQA0K
IMKgI2luY2x1ZGUgIm52bWV0LmgiDQogwqAjaW5jbHVkZSAiZGVidWdmcy5oIg0KDQotc3RydWN0
IGRlbnRyeSAqbnZtZXRfZGVidWdmczsNCitzdGF0aWMgc3RydWN0IGRlbnRyeSAqbnZtZXRfZGVi
dWdmczsNCg0KIMKgI2RlZmluZSBOVk1FVF9ERUJVR0ZTX0FUVFIoZmllbGQpIFwNCiDCoMKgwqDC
oCBzdGF0aWMgaW50IGZpZWxkIyNfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmls
ZSAqZmlsZSkgXA0KLS0gDQoyLjQwLjANCg0KDQo=

