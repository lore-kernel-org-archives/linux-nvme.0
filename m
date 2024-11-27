Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EE1D609A7
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 07:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fZcy0sEc3u/4oMTASv1q0P5WF9j3cob+zVyctphBi1w=; b=Bs3qa8xTKJr9Late9i45ZfBvOj
	z6FNMPHoTjcp0ynIexceZib+9AYF6K9i8dUak1kTYj22ozpQXVmdL/RVRv0/o39kGH3A4OLC4clS0
	+8/v7wzuq56AVKuI7bK6sn2eo5Fq0a5FD6KRQ4A1G7GIzTTEP+/bHhMQehA1hZdHv2btJTPKWqQuA
	thOPTgnui5+dIm4lg0N/1dX4OUVW5YgPKblbLN8KiO0jtcNq07R5rS0L5htRGgoxnutWQhLI62B/j
	jSOlevldZ6tY8VFFbtbVM1igBY6VfuvnmYLK/z0eAPwYCaoWg5086TLMJvLeWhoOmw5EwqxARDRph
	8mQf10yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGCnW-0000000CU02-17xj;
	Wed, 27 Nov 2024 07:49:18 +0000
Received: from mail-mw2nam10on20609.outbound.protection.outlook.com ([2a01:111:f403:2412::609] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGCmY-0000000CTr7-2AaC
	for linux-nvme@lists.infradead.org;
	Wed, 27 Nov 2024 07:48:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zkcub2tU3ZWOb858nAeYj9RFh2PJ555RyC4iJM9Le8ekruVLdkbp4FhpmuwPHIhzGGkpG2jB058MotP2DkGytxZwmX2qIj37djMtJqOYDJn8Ptq9JjjUkPb0W/RvUVanxCpz0b08cyNr9SGK8jYMW/fx6W0Ii/AgB8xbFodZ0QmbHUWtrzEURimkDEYn/uh23f2kW7yVRnDf4GiQ2BQuLJlVw5nL+/ZOpQk6CGCCV86w+Y9sxhOyv2xttr8nsvQ5iaw0BokXsTtMtzwcrtzbPMtDj7HUfVYQLjXlist0DgQkVdG87pBS4y6kFxwSgTyy9TK2uopB5SO/PIO9FtxM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZcy0sEc3u/4oMTASv1q0P5WF9j3cob+zVyctphBi1w=;
 b=ktrrQhiSLkHMGAjRutNtNKsb9p9UXsCa4Zh32siAbu7KoFF073lLpMuMGbTOCx0re/kEgWaJ6eEI0muhZVJZfkCE72c1o4epEdXuuh663d9mEBpa2OOmbH0Smd1cTex7lX1YEYYrMFAncUuflQkWTEkSuZ7STLIc9w13gCAQBV9O6iTH9m7RSQkn9/xWT8+5knN+V1R/4pIMiy/4SnPfqVpHOWvo3pEE/Dis4NF0YY5IyyQFPIPFZuViPOG2bd5BgS8IZjVdKICGUG6bh5lZQXJi5yqs1Y/FWBxdgwTperHPKi2HysMjKT9+31kx/blt3yLABWrI9J+qsLZmqbLigw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZcy0sEc3u/4oMTASv1q0P5WF9j3cob+zVyctphBi1w=;
 b=DlFnMGJhrnZSfYCtNXzg+T+l/ys31NawtAPk6v/t6s/vswrA5KGLxjAKnq/2VFjs8ioXJ9GxOBkV4J2ImC6/8x71RwTEi+f3QFA6sjT78i9DBRrKf9qvrKrKwVlMwmZAKpemCzxleRwKCldxVOYXUvI4n6LD83wS8iC0tRPkzhLJ6Zu6YB+fowm58GM9iHwwGEYMAeGaicjaAjJeaPyC2PVU7o74D8O7OdkL8BOHdRYTe2e4910LDCllf2iIls6V7rzeBeXXV0TCau1+gVFFTnz/v6EdkiNkIcuKAVFOC5NquVjiwva6KwhRZMBzGJmwX8fPX0jziCd+r+4qSGEJIA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB8768.namprd12.prod.outlook.com (2603:10b6:8:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 07:48:11 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.8182.018; Wed, 27 Nov 2024
 07:48:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Saeed
 Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Subject: Re: [PATCH] nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES when DSM
 is not supported
Thread-Topic: [PATCH] nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES when DSM
 is not supported
Thread-Index: AQHbQJeVZcHble87s0WFUoQfHpVecbLKwDkA
Date: Wed, 27 Nov 2024 07:48:10 +0000
Message-ID: <47e614f8-e54f-47aa-90f1-77ca73ea9c46@nvidia.com>
References: <20241127064218.42688-1-hch@lst.de>
In-Reply-To: <20241127064218.42688-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB8768:EE_
x-ms-office365-filtering-correlation-id: e7925739-ea34-45b6-f071-08dd0eb7d717
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bnhwMmhBbkR3K3JBckp3aHFCOUtBSHAwcWMwTGpqRWFDclhQaVRzVnBVNUVm?=
 =?utf-8?B?SEgwK2oyVnJzcWhwcEtEYVl0NlZaT2cwQWtpZzRnVENhbkpzMDMrV2ZMZmdt?=
 =?utf-8?B?K3VjS2FDVzZ3VEZYL212QzRFYUs3V3NtZ2JiNlJ5RE9xR1hRKzRuampwYmRy?=
 =?utf-8?B?MENrV21ET1gwRzVRMnh0ZU9iSjBHbUQ0UGJlVVRVeXFRZTUxd2lDZzVBb29r?=
 =?utf-8?B?TlZWbjR0blF5eFFoL2I4clBQTW1rL3lCeWVRSGRVUEpsWGNzRU1ZWk10S01h?=
 =?utf-8?B?SXF5R1dMR3RCMEVvdC9ZUUpBZWF4anN6S2lYSnJHWXZ5d0k5M3ZSRFB1VHZY?=
 =?utf-8?B?QVFFYlI4Q0VCQ29vRDU2SW1EUVVEZ1MyMXplZDZPejZHTS9Ta0FVNGNWWVRx?=
 =?utf-8?B?WDI1VU85eFd5bTJ1TXFYRGtuTkNrSHEwM1ljbEFNa1FtWkI0UlpBQk1MR1B2?=
 =?utf-8?B?Ry9ySjAwRk1pWmlTSnZBWnBVZkdnYmY2eWxwTmZ1V3kydnJVWjFzSjV6Qmsv?=
 =?utf-8?B?MTEvZ3R1SjFyUVpKVTZpUWJHZytNaGgwbnBjb3NjTTJSUjNZdFRGdmU3Q01l?=
 =?utf-8?B?MmtwTC9rNjdJQVl5WEpqbGVOd2RiUWxNUktFZ3EySmhpQ3hpOE5YbjVxNlpn?=
 =?utf-8?B?ZXpORDIvcnpjRzZZenJlSjA5Uk5reWpqbkdyNkxMeTdEOHV5bjMrWlRqREg2?=
 =?utf-8?B?YTVheCtBT2ZwNGVPY0FTUXBPbmFNTlZKYVRLcEw5ZnFlQ0NzalVBQlJldnlU?=
 =?utf-8?B?VEc2NkpYU2tiVUhsSlI3T01Od2RlWVdtSHlGaW5kLy9tM3VhOW9SUjZoV1B0?=
 =?utf-8?B?NkprbjVHcXJRbHcwdVM4L0ZGMFlSRHl0Z0pMOTIyOXBFSk5nNkF3K2lwamlM?=
 =?utf-8?B?S2I5cWRSOG1MeWRqVW44TzF1eWlIemUxdGFYUXpEV0dxU2Q1RTV2eFBxV1FU?=
 =?utf-8?B?NXE4OTZYY0YvZ2R2eC9RNGhVZTZZZ2NuY3poODNGNFFLd3lRczNmSTN4Z1Zv?=
 =?utf-8?B?ai8xRHB6a2V5cHZ2RTlsSndncmFUUzZhU2h4RTB1MUxqNHFocGVtMGx4NDV4?=
 =?utf-8?B?L2NoTnJsRzJRV25ZNEFnZlBEY1hFazFSQUpiMkNseGtOc2lTU0xuc3VuTlhJ?=
 =?utf-8?B?ZEUrU1F2Wi94YmxWa0c5SW8vRlZVaStob3Flc1g1djZCL09RU3lERjZibFZK?=
 =?utf-8?B?ZjV5bFJLdkNEVno0K3o1cXBUQi9zQkZoeWljcWcyQ0FXKzgvQjF6SHlTd3I0?=
 =?utf-8?B?MzVzUVllb0ZYRUZCak8ySU5ra3FLYzIwV1RHQ0tJSkZGMSt5VzFHYjI5YlhO?=
 =?utf-8?B?Y2hNVzVVMzFLL21UK2RQWTVaRUVQdXBnUjZvSFdoV2p2NUVKOS8rSWRvdzEy?=
 =?utf-8?B?eGlDK1ZPQ09KNEdFT1ZILzNJdTJYUWYwRjBWYkRBdGgvSWRGUkdBVzY2ZkVC?=
 =?utf-8?B?NWZpR0VSWTFvYmlobk95cUhoeWRySEZlV0d1cG9wWUFaZXMzUUhCcm1EeFQ4?=
 =?utf-8?B?QlJDckdrYksyTU90ajhiYjN6NXAraE0rQWZ1dEtERDdER1hNRzgrRHl3L0Vi?=
 =?utf-8?B?REhMMWlGcmliQXBzd2lHa0ZKeXd3OHhPMTFBTXYwNndPWkI4cW4rcjA4UndN?=
 =?utf-8?B?dHBraWcrcGhPYllvT3VTR0MycWRXU1c3R3lyanA3bEZpWlhNVlByTDVpa0lt?=
 =?utf-8?B?WEFEMGVDRFF3MlB3M2RXa3poMzFZUGJQaHFmMC9SRnl3bC8zNG4waDVHUEZP?=
 =?utf-8?B?UHk0NnRncjd6ck0xY1ZWMGFiQU50VVhjODIyR1BzNWdLT1VYQXh3d2FmeHRL?=
 =?utf-8?B?T25nUTNySmJvWW9YSUpLNitNV1NPZ2t3L2puN0s5UTVuVWxMWUd0TncvbG5i?=
 =?utf-8?B?TFh6eVpzU0VHQ2tWa2ZCMWRiZVhJRmVpeWZQWnN6R0dSTVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjVuLytCdWJqNWUwMTRYTFlHUUpPSDVYYUJUWEVpQ2VQR3JpYTRRU1AzOUtZ?=
 =?utf-8?B?eGx2MWo3MGpHVEdnMkxLbW1rZ1gxRGVYTzM4bGcwUGs5WmZZUnZYWUZBTzB1?=
 =?utf-8?B?M2RkVzVodDc3ODNoK0hxL0JMNHJWcWwxcUtvbTY2S3U2SUUxVFNCQXNTeXJu?=
 =?utf-8?B?d1E0S3BIMHFMQ1piYlFYVTlqY091Yk0xaklCRjQxSk1UM2F5WG03cHlybVgz?=
 =?utf-8?B?aHhKeWZic1hsMVdnVmtIZnRwQUIrOXVkbnp1dUhpODN0ZkZzMjg0RTBuVEpw?=
 =?utf-8?B?Z3k5ZnMrUmpRbTVjbS9MTXNmcFRiU1plMzFtQ2hZMG44dkRmbm5zb0I4V2Ey?=
 =?utf-8?B?SHBSU0dXT0g5VVROTnRDcVhFNlBKWnJGd1V0N0VQeW52SW1GUHdzaEU3L29u?=
 =?utf-8?B?L1VybmdNOFBzT0FHeDlqVE5oenVQYWNoalpjN3Q3UzlPYnQ5WFFIZTQ2dDFT?=
 =?utf-8?B?d2lRaTNBWEg2SjNmV3pMQThTdFVkN3pVKzN6WDBxRTV1enNEQitPUkgydFJU?=
 =?utf-8?B?a214K3EzTXZhOC9vVlQ0VDNETmRVbHFpN1RxKzhTRGRXVTJnRDNuamQxbGpr?=
 =?utf-8?B?Q3l1T09TU1dwaFJvN2dCcWhDRStvSDl3eWd3SzE4N0RQU2g2NGVySmNoQ2Fk?=
 =?utf-8?B?WVdpZlpSOVhJZzFyYVFROUlXZDNyMFVJaGtCa25acEVQMHdHdjZaSGZVTlNX?=
 =?utf-8?B?dUkzcWVjMk5tY3NBL2s0Z0N1Yzl2MG1JZWdjM29DaWRRRkNWSDhNNklWS3dx?=
 =?utf-8?B?a25iRWp5dzlRRWpwNmtGU1paRjBidlpiK0doanJxVGlwK0V5cS83N085enlo?=
 =?utf-8?B?bGhJTVB3V1lrUHdHU2lsbEhJdUlvTjRIUWpnTnRaWlhhL1VpaFZFY0hGdXNj?=
 =?utf-8?B?Q0dhd3p5V1dnNmdzNHBwMUsvVHJ4T0tycXVBTlJlSFFHS0NlTWh5aGxtVGxi?=
 =?utf-8?B?dm9sYU5sWUxzeUEwU3E4cTZGRk5YdzlZM1psUTcrbEkxVGFjTkMxbXRPUktp?=
 =?utf-8?B?TDJFMVhIQmFYR3VuYVprRVM4VFlOZ0o2b28zd3lUakw0M3ltQ3lSejZJNTlF?=
 =?utf-8?B?ckhiWFN6c2VuYng1WHY1aUtPN0crSEIrWGQxMjR0dkVlNVBEK21kaVBjdXd3?=
 =?utf-8?B?TjljVm1xUzEwb2R2NXNoZEl3ZDdiUkJqSVRUeTVoeld0S0RsWVdDVHpQc3hI?=
 =?utf-8?B?UW00VTBRekRobFNjNEZPQW9taE9oU3FseGYzRnFGM1l0d3ExTGZtL3BNRTY4?=
 =?utf-8?B?OTYwQ2xWZUtkZXR6dXE4OGJTSmxYV3JlMEdGRFZFODN0dlNjV1g3U0J6cEhr?=
 =?utf-8?B?ZXhXVVVjVU1NWmc4ZGphVllpMXlOZ0dnMnZyR0NtMndtVW14VU1OWXF5cWw1?=
 =?utf-8?B?NHhRNGNPR0F0d3FCOGxhNDkvR0FPL1I2a2xNMEYzMHpOdTA2dHFPb2xYQUhM?=
 =?utf-8?B?NFVNZUNiZlM3dk4yRWVmdS84d09sQktHWDdQRWpkUjNlKzVXdk9GMmpFZ1d2?=
 =?utf-8?B?TVNqVFRWdTMzelBpSzV5TTc4LzIrWisxb0pkK2xLeklZdGh3SUo1bkZ0OUxw?=
 =?utf-8?B?bzREMTVlLzExaFd6SXZLZHpscmtPdXNtK1FZa3hiQm5xSXEyb0RYQ0RMZmdT?=
 =?utf-8?B?bTZYY0pYcmYraHZMUlZtVEhjQ1pPN3pnc29oV0E5Q01GNFFWSW1lbHk1ZHFX?=
 =?utf-8?B?dzczZkJmK3lkRURoa2JJb0hIMTRTWU5rYTFqbEU4bFV1aUwwczhpSzZjOVlp?=
 =?utf-8?B?eUxsc3ZUZzRpQjQ2aGtCT1o1TXJuZU9IdnhBOWhwMUFVZ2Y1TEdDYjg4UFJH?=
 =?utf-8?B?bitaejhhODBzV0h6N1RReTBnQ0hWTzlhY0MvcEJ1ajNONTdtZzlCaXJMVGUr?=
 =?utf-8?B?b1ZmZTRNQnB6NEIybVIxUmdKNjB1dDlhTGpNL3dPSm83REkxaFF3allCbmx5?=
 =?utf-8?B?Y1lra0VUNnpHMVlFQ0dCb3diRUl4a1FDVUNKMWRPQ3dNVTY0UGw4VnV0VnZx?=
 =?utf-8?B?QTZTanpHTWJDNTM1QjFoMklmMkZaZUNXM3B0dUNvaVZSRnF2UDNsS0NSYS9M?=
 =?utf-8?B?L2FvcW5nMkJaWVIzSW9Wdkg5Sk1kMnVjODVwcDArUFlFcUpRQnpLKzFqallh?=
 =?utf-8?B?eGdxVnBvbW81bFVCakVad2RMVmhIdnVlN3RPeTlINGdzQjNUU3RLemFsNlI2?=
 =?utf-8?Q?TA8mY61RehhpsZYgpeWmJA7yWdL8z1FqYgzRvW4uHzZo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CEBB7257BA874409A93CB9488E421B7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7925739-ea34-45b6-f071-08dd0eb7d717
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 07:48:10.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/bTyZIPQ16Nol9xWjP7MRwm+1c7Vm4k7zbo96gMl2WLOU1z54q/H+94QfX46Lm9IanXwypb/WYXE0h/iEv7Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8768
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241126_234818_554175_90E832F7 
X-CRM114-Status: GOOD (  11.58  )
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

T24gMTEvMjYvMjQgMjI6NDIsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBDb21taXQgNjNk
ZmExMDA0MzIyICgibnZtZTogbW92ZSBOVk1FX1FVSVJLX0RFQUxMT0NBVEVfWkVST0VTIG91dCBv
Zg0KPiBudm1lX2NvbmZpZ19kaXNjYXJkIikgc3RhcnRlZCBhcHBseWluZyB0aGUgTlZNRV9RVUlS
S19ERUFMTE9DQVRFX1pFUk9FUw0KPiBxdWlyayBldmVuIHRoZW4gdGhlIERhdGFzZXQgTWFuYWdl
bWVudCBpcyBub3Qgc3VwcG9ydGVkLiAgSXQgdHVybnMgb3V0DQo+IHRoYXQgdGhlcmUgdmVyc2lv
bnMgb2YgdGhlc2Ugb2xkIEludGVsIFNTRHMgdGhhdCBoYXZlIERTTSBzdXBwb3J0DQo+IGRpc2Fi
bGVkIGluIHRoZSBmaXJtd2FyZSwgd2hpY2ggd2lsbCBub3cgbGVhZCB0byBlcnJvcnMgZXZlcnl0
aW1lDQo+IGEgV3JpdGUgWmVyb2VzIGNvbW1hbmQgaXMgaXNzdWVkLiAgRml4IHRoaXMgYnkgY2hl
Y2tpbmcgZm9yIERTTSBzdXBwb3J0DQo+IGJlZm9yZSBhcHBseWluZyB0aGUgcXVpcmsuDQo+DQo+
IFJlcG9ydGVkLWJ5OiBTYWVlZCBNaXJ6YW1vaGFtbWFkaTxzYWVlZC5taXJ6YW1vaGFtbWFkaUBv
cmFjbGUuY29tPg0KPiBGaXhlczogNjNkZmExMDA0MzIyICgibnZtZTogbW92ZSBOVk1FX1FVSVJL
X0RFQUxMT0NBVEVfWkVST0VTIG91dCBvZiBudm1lX2NvbmZpZ19kaXNjYXJkIikNCj4gVGVzdGVk
LWJ5OiBTYWVlZCBNaXJ6YW1vaGFtbWFkaTxzYWVlZC5taXJ6YW1vaGFtbWFkaUBvcmFjbGUuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZzxoY2hAbHN0LmRlPg0KDQpMb29r
cyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNv
bT4NCg0KLWNrDQoNCg0K

