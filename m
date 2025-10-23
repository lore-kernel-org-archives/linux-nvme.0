Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D30CCD1BC
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Oct 2025 05:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+7Mh6n88tb5BdTZh5J9d731zAl0+AUx5oPS2MTp58vQ=; b=ehXF8lsJP4k2O9gbdgPiSlxg5q
	O9p8OdU1sdNb4v/eBReig9mieh7yx7PKtua5V5U1M/cNp9X7uDp5ewUxeKJSThN1mdJnZe0WsNaVt
	VXAQMRFfZ/7ACpmD+Y039DWsI5u+MgiohaeBapmscNYjkOBRks3/qrxCZn6pmyY3IkXHgkKaZzRMN
	tvuO6+79M/zid1hHpO+L/U3Ap3aFqZOJtfuFd1P9Jlv/YIDKoyhnR1kOlPzrUaqhfhmmmYS7N4vIu
	dPSpn5QITVDQL6szvPNWg9agyYVsCJc9/v2NPqXDINAFgndP8U/+ZkHET2C7qaglZnqr2Kvt4XbqM
	mnfIi3ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBnei-000000057xq-2gTx;
	Thu, 23 Oct 2025 05:14:32 +0000
Received: from mail-centralusazon11011050.outbound.protection.outlook.com ([52.101.62.50] helo=DM5PR21CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBneg-000000057xD-2abW
	for linux-nvme@lists.infradead.org;
	Thu, 23 Oct 2025 05:14:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAgi4yarj1WMaN5wNTVn7C4wM+Oe959dEx8AeJLZVYelfUmRNT0JidAorzxHt9yrCXKR3wsTupG4vAcyGqFQFco9d5hBlNwhYJWxwjjxLgdJGs1BMCSl8Q9wxRaH9pzBHtOQShERz/o2I7bwTAQ3bgyLTnU2N0BWAycLiyWN4mu8jrKxLg9rk5HiFvo7M4uSNXPMkuW0rhC+p7eQJZX0rJzI6S9TnA7gMhyOKQz8QMjIy9RDP9jpGYs+TSKdTCBztySdG8VWUnklYYPwOU7So945zSsH3KUtruztlfdHH3Hfrvy7z7EJwP3zsA4KQCTylDyTwTtO2MS6rJB9yrasRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7Mh6n88tb5BdTZh5J9d731zAl0+AUx5oPS2MTp58vQ=;
 b=w9QqX+Qsnlc0d9GB3ZXDA098kgfwRr/1y0suwHDl1DPrdjkoT6rXtpl4ntGnvQXVuubApYAtcbekr0cu9owt5ajWAC38umzXIwDpDkZpxviJiRGt2S5ymXGtAqBKeNsy8ZGLh/22TFS5IBzKztb9HlSxWIOisQu+ai3OAAKjRVMTPOOZSK/qIpB7RRRGHkq6zvuMH7wyfpoIDeHTFwuIvzAIwXYopJtCWZsSw4XVhY0ne0FEbyAX7BGyhbtM/ACd3fzZYh61t1RAS0V8xlJkTZZGKsSjJspEaq0DYCa4+RMX/1B2yGW1guw40TFpXVNk4iOaA0M5RaHceR8r66m0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7Mh6n88tb5BdTZh5J9d731zAl0+AUx5oPS2MTp58vQ=;
 b=AFvXJvci4ifMmTU0CwJvbE5GZSPtZ7kAa8m/r43RfFKxgSDe0lSKRvW1jv8p/y6scfBYghjvIyAEz2Cu3C/HoDFRYQxV2sLb3OyCfGlsFDrkx3EDiVekNGuUNVvX6dETDKBgV43IXOfDOw+eDtcMxwRc6R5Z22kTBcWgpM9Jof1jVaNkWQUxLssbM2DXhfI07hehwsOwuvSb8s5rRG8IezwyWQRfJDPG8MfpGUSP5BO1N5lwknO9IyQ0H2BfoA0bpjZcwocYSjv7PnfW+RIz9EJ2ulgdYehnm0iEoplR7/uxw0JfM7YIDYhrHpfP31abtKTN7doO+jOtv3eBWfRDQw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 05:14:18 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 05:14:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: introduce panic_on_double_cqe param
Thread-Topic: [PATCH] nvme: introduce panic_on_double_cqe param
Thread-Index: AQHcQ1uPZ/XVoVOMEkSObv1C0WAkpbTPMQwA
Date: Thu, 23 Oct 2025 05:14:18 +0000
Message-ID: <6dc4c33e-8183-481c-a101-8a2b6596d2b1@nvidia.com>
References: <20251022135454.75767-1-kanie@linux.alibaba.com>
In-Reply-To: <20251022135454.75767-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY5PR12MB6527:EE_
x-ms-office365-filtering-correlation-id: 4f11c5ed-ce91-4849-cf37-08de11f304a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?VzRFOExyVXZsNm9nSTlZU2ZjV3ZjYjMvZGVSSTBCdFViZk5heFlDVGhaTUJR?=
 =?utf-8?B?Y1lSVEttRnl5bExmVzFmQklIM3hHT1hpU3hWQW9XUzVwakUrMk9hR2Z4SlhO?=
 =?utf-8?B?SXp5QWViMmUrOTZ6YTJVVGVIR2FsbTRrQnRmb0xZTDdXenE1aGhGeWp2STJH?=
 =?utf-8?B?Y0pXWXN6amhNdHZwb01ZblhBYVFhMktHTzFwVk5GN1RybVphbktZcXBxdUNB?=
 =?utf-8?B?SDREM0JtSVY3cEQvMHdEQllaMVRzMFF3MzlnY1habGJSQ215M3Q1WEZxZ0lp?=
 =?utf-8?B?cHVLRnh1TjhXMzdaZG5Yd24rWkR2M2lwTTFiR1UzVXpSQ0R4SXBiRUowcW55?=
 =?utf-8?B?bmpMcXl1SnltVEFHZ1NkN1FkVGVERjZicTNQRWhuamVISkNJbzYyUTR2MG0x?=
 =?utf-8?B?eU9mVE42c1cyZkV6K1Z4U0Q5SFFqZ3I0WWFxR04zRWFZeElOZStpdFI5QUdn?=
 =?utf-8?B?UGpmNGRvUDNFWStSVzJyeFNXdWkvSnppS0JUS3drZ0FWK3l6dU0zUzFoampw?=
 =?utf-8?B?SHpSdCtBajlySUY2d1JtVHo3cmZySEFXS3VnR1cwVHNwVjBEc0xkazdaMFJp?=
 =?utf-8?B?U0ZpZjJjam1vLzVDWkJvM2ttRmNldTFycThPeDVjQVp0UkZoRDNRQVFVUXNF?=
 =?utf-8?B?bnRIZ3Q2QUJsZEhmOEhXU0FLSzZGU3MrMkoyUE5JOWhpNDhQd3J4dDY4NVlQ?=
 =?utf-8?B?dG8rMm5BVjR0MXVTdHdLRTdIVlFXZjZTVUx5eEdaZ3BYbWgxVmpWWktTYktq?=
 =?utf-8?B?amdaMVZXYlZjVm8xWmtHc0ljK2pSZHlPVGtZa3hpS3pTTUJ4MzNNazlrLzNY?=
 =?utf-8?B?Y2ZKcjdYVzBOQlErSFlVN3U3SzNReDJoNHYxck0vNlF0ekJ0UjdQTmxZTmV2?=
 =?utf-8?B?ZDVEdmM1eWNqcWN3a2UyUjBWTHJpck83MklXWDlGaXB1KzNWWXZDYUVNUXNt?=
 =?utf-8?B?d2NuVThzbW5aYjdaZUwrRWZhejNwQXNNdS9hT1pOTVg0cE1KVjlvNG9RL0Ny?=
 =?utf-8?B?N1ZkcVc4ZWxUYWRCWWVUYUZLSGd1dDZEMzNNeVRIazdoYnR0M2hIaDBHdmNi?=
 =?utf-8?B?STgrWEZxUFRyMUNDN0xBYUFaTU5pcU5RN2hMOWxTUVRVMHhqcnp4VUpNUHF5?=
 =?utf-8?B?djFmeHNVT2lMeGFDQkJLalEyMDFFNFlmZjVHZjNyQTJZTll5bkpSbzZoN0lV?=
 =?utf-8?B?OHNHcnNuV1I4blhvOHVEOXRnc1oxVkdMdEN0LzRKRTUrM1UwK0pZUHlWR2Rh?=
 =?utf-8?B?STRUNjRLOHNTUTdFNVRaMmQ0M08wdzlndjhIOHpFSFI1TFZBWVJwbG1UYXN4?=
 =?utf-8?B?UUQvWVROSHZSZDNJZm5hYTZwNDNtRlZFRWdmcGg4cXBJaVVTcE8xd1ZkanJp?=
 =?utf-8?B?S1VPWU9yWVBRMFdtSWN0RmhRSTlWNEo5eHMzaEJUZGpFeE9sRUhqbURSdFRy?=
 =?utf-8?B?SHRYaUtFMmtwWDNSY3BVQkN0OUhNS0kwNENkR2Q2SlZMQUVzUzY0Mmh1SVA1?=
 =?utf-8?B?VXRWSEdXOGV2ZkNSWVNPZmRWVUZKZW5nVFJHOERyT3pzVlZocC9TcHZCVzJw?=
 =?utf-8?B?WExFS2lQQmRyQTNQK25FdTl2ZHBpNStwWk5rb2dta2laNTIxOW8xc285ZTk3?=
 =?utf-8?B?ZDJ3bnVXTWJ6VjNrbWRvcFd5RHBWNldXTGJsdEZkMDcyMU9lbWJBVmFKQisz?=
 =?utf-8?B?Z3lRazBLSythdkNkKzdibHRQYnRzcDFBSFRNZERpc3FuR2JXUFNINGZjc0Rh?=
 =?utf-8?B?QjcwWm9IbUhuWUNXMHZsc1lFRWlwUkRiUHNnaGxHSXAwRWgyR0pSM2RGMmVH?=
 =?utf-8?B?Tmx2STRpRHJybjl0QVJMWWdRV2NsMGF0bURWUm13eEpPd2NCSE05UGhTZ0ZQ?=
 =?utf-8?B?Mk15Rkhwc1hma3hzYzhHRWdaSGQ4SGM0RVZkNWZHclpRZ2E4ZXlLQVBxZGE0?=
 =?utf-8?B?VmVIQzN4Q0xDS0prSHlwb0IxeU0zMUdhQURma0tVNlVYRkFBQWJjZTJ0RExP?=
 =?utf-8?B?bkdsNDZlVVVFYnI2YVZzb3JYaWhCUzI3TU8xeVozVTZBMnhKTkJBRHJmSWx4?=
 =?utf-8?Q?3LP9kj?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmRDTDhNMnVndVBPbC9zcVQ3MHNPaGVyc1g0T3Erc0JyYjFNY0kyeWFrcmhB?=
 =?utf-8?B?Ry9oaTU4RUhVZk1DQTVlV0xaWS82Zjc3c2M3VFpQOWQ1dDN0MkpFRW9LK3RO?=
 =?utf-8?B?Vm9TRGRjWGFMekVGRTQ0TEU1L01LL2g0ZWRDMXNHaDNEN0I0TEZjMmN0MlRV?=
 =?utf-8?B?c3hzbXBzUytWRjFjRlVKaFNlSmZpNlozTHdvZlluRXdPUVl5OXY1V005Rm5H?=
 =?utf-8?B?MTk2MXFwNEFtSGsvWGYxb0ErT25DckExa3QzdjQ1UzUrT2NGdmozZFdONWVS?=
 =?utf-8?B?TDZyeEkvc0p5S0VCUzZGd0JWZ1k4bFEwSUlwQTJZR0N6dFJqd3BNK2o1YUxz?=
 =?utf-8?B?Zk9TeFM3YUdKV1pseDVXbGREZisxQ09ISmFtRlVDdG5mbzdTcEtYTndjcWZ2?=
 =?utf-8?B?VnVIZGsxQlVzUjhGekpGaWZaTUpiOXpkR2FZTnVYc1JObSs1cWpDOEhlM1RC?=
 =?utf-8?B?SXJOSE0vUTZncVlmbzkxU1QwNVlRR0Qwcjc0WGxZcUtraENQT2ExRnduWTNO?=
 =?utf-8?B?UHlOb0tibUZSbm4yY2xwMG83aDJxaE5DSStDTXI5aC9LVXlIdUh0NlNpK3JQ?=
 =?utf-8?B?SWVQOUhKV2RhSW1QWHJBcDdTUEFSaGVBWkFuUWxRQVc2cFo1dUNsMm1aSW1T?=
 =?utf-8?B?RHA0Y3F1Z0xMRWN0b1JrdUQ3MURyQm1pVGI3Qy9ZMmFyOUx3bEpBZEs5NHMw?=
 =?utf-8?B?ZThUUGkwaHE1SExVVkg5aHpHNzlWZUJyUWVzTm5sR0ZJNjRuK2g2SEs1TEIz?=
 =?utf-8?B?TkNGS3B1WGNhNWhwWG1XcnpGa3lVc28yMUxDUkI3d0REb2wwZ2RtNTlCamxa?=
 =?utf-8?B?V3Frakh5ZSsrYWdLOGd5WG5hZ2hXS0NQUXZKUDFia0xYaVozUGFTaEh2SG0v?=
 =?utf-8?B?aEthdGgxL0xOUm1hcnE3NTJRWkc1Z0Ixc1hpdlQzQm11cUpxdTR3WUM2Z21T?=
 =?utf-8?B?eVlyYi9nUXlaQ25KZWtqTTNFVFhBaWxHY3B4enUxdTZiQzh2WUVZclJHYyty?=
 =?utf-8?B?RW1lalFNWGlJdFRXcUtpTVZsYXNaVE42MFBEVnhSbGFzSVlsb1ZUZDdZUCtu?=
 =?utf-8?B?ME9JY2NwNEVuUlVTdTFiTzkrQmJUVmUvS3VPcHpaK1FLWmFQZlFIeXQwZDJD?=
 =?utf-8?B?cENsQmVtQXRjeVFUSmhzWlI3WTVNRE5rVnpPbHJkYTFVTi9YOUxSTjFjNFZJ?=
 =?utf-8?B?RktpWkI2WnZsM0dZYUtNOURNVWdJODZBZXR2cVNLNXBmVFl0b2FOY3RIRk00?=
 =?utf-8?B?UWxoUFIxeldvZUFWdndHaU5TekR2d1JYZTI3L1FOMjZaR2J5aTQ0RFBLVnlH?=
 =?utf-8?B?cDdEeFdrYVZqWlNQcXpOYzVwbGVSeGpmdCtjeTA4dm1Edm5zRm5TUDcwR0Nz?=
 =?utf-8?B?NkZuRS9tZE9Na3FaRjR4UHcyVldTK2RiZTRqcE5VSU9wNklMQS9UUGhoT1Qx?=
 =?utf-8?B?UXBRZTA4ajl0cU4wenRzcXEzTFFIZUUzajV5SXRkaUVJME5jOWVCT3l3NzVk?=
 =?utf-8?B?TVpOK29NVXF6aitZRFlaSXR4bmRmYmpwZmtCK2xEamhZRkpYMXZuVjNYS0hs?=
 =?utf-8?B?NDU0S2hjaW9XUTlhMEFtLzhsSXE2aTVhT3BNRkRDTEIrSllPcXRTZ3dFS2o3?=
 =?utf-8?B?dHpWWUhUbUxQSEdIdzlmamFERnBlZkNVbDhNekcvYlQzV2U4bkxUckFETWcv?=
 =?utf-8?B?STBmUituU2tTV2ZjSklzMFBGOEU5VS9XaGxVanV3NlNtQnJWWFpsYmMvaXZ0?=
 =?utf-8?B?alA0Q1NwdUE4aWw3ZGxUTlBEdHVMQ0RqaWpJVUdBaHhSWjZxMkhEUWNseW5z?=
 =?utf-8?B?NG50MmFUend5TmIzeUNmbjV1ZWhWYmVHcGJtZmVEMkhQbjR4L1hIYXc5L1I2?=
 =?utf-8?B?UXJPZWdPdlFmV3VwaVloOUdwTFpJVUtZMHlxbWpVSkY1cnhhaFhGUWFJSExU?=
 =?utf-8?B?ZjdzVUtaVWh4cXIwb0VqZEluWElkNFdVL3VqUzZPZTVsVFB3bUwxRkZaM2lj?=
 =?utf-8?B?U0NQMmJjU1RKbmQwTjFVdk1jc1F0MVVDZ2xROEJHdjF1eDlVNlV3RjNISERw?=
 =?utf-8?B?VzZjcm1xb01Ydm9oWUMyV3p6czQxQk1YRG9ZT3JxQ0U4NUw0Z29lNmxVMWdw?=
 =?utf-8?B?KzR4L001NWVtN0lrcmsxTFRNSlFxSGVOZ1kyUFJ1bVpNcU81MHJrR3I5ZEVO?=
 =?utf-8?Q?W6TGbpaXkAKz7b+FolqqudHLiipuD5QdkijFohpSkuhs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8A28EC73A03E941BF9F09EBD6809188@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f11c5ed-ce91-4849-cf37-08de11f304a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 05:14:18.4999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CMH0cS18BhKlk3uKSqJ3AioKmD+wlbzINISDsHlNOr4edW4l+s68umemnhBVyFfJ1JpB34D+RAs119RvvbgaaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_221430_658934_C02E8BCA 
X-CRM114-Status: GOOD (  17.55  )
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

T24gMTAvMjIvMjUgNjo1NCBBTSwgR3VpeGluIExpdSB3cm90ZToNCj4gQWRkIGEgbmV3IGRlYnVn
IHN3aXRjaCB0byBjb250cm9sIHdoZXRoZXIgdG8gdHJpZ2dlciBhIGtlcm5lbCBjcmFzaA0KPiB3
aGVuIGR1cGxpY2F0ZSBDUUVzIGFyZSBkZXRlY3RlZCwgaW4gb3JkZXIgdG8gcHJlc2VydmUgdGhl
IGtlcm5lbA0KPiBjb250ZXh0LCBzdWNoIGFzIHNxLCBjcSwgYW5kIHNvIG9uLCBmb3Igc3Vic2Vx
dWVudCBkZWJ1Z2dpbmcgYW5kDQo+IGFuYWx5c2lzLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBHdWl4
aW4gTGl1IDxrYW5pZUBsaW51eC5hbGliYWJhLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jIHwgNSArKysrKw0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L252bWUuaCB8IDMg
KysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0K
PiBpbmRleCBmYTQxODFkN2RlNzMuLjdhM2Y5MTI5YTM5YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPiBA
QCAtOTUsNiArOTUsMTEgQEAgbW9kdWxlX3BhcmFtKGFwc3Rfc2Vjb25kYXJ5X2xhdGVuY3lfdG9s
X3VzLCB1bG9uZywgMDY0NCk7DQo+ICAgTU9EVUxFX1BBUk1fREVTQyhhcHN0X3NlY29uZGFyeV9s
YXRlbmN5X3RvbF91cywNCj4gICAJInNlY29uZGFyeSBBUFNUIGxhdGVuY3kgdG9sZXJhbmNlIGlu
IHVzIik7DQo+ICAgDQo+ICtib29sIHBhbmljX29uX2RvdWJsZV9jcWU7DQo+ICtFWFBPUlRfU1lN
Qk9MX0dQTChwYW5pY19vbl9kb3VibGVfY3FlKTsNCj4gK21vZHVsZV9wYXJhbShwYW5pY19vbl9k
b3VibGVfY3FlLCBib29sLCAwNjQ0KTsNCj4gK01PRFVMRV9QQVJNX0RFU0MocGFuaWNfb25fZG91
YmxlX2NxZSwgImNyYXNoIHRoZSBrZXJuZWwgdG8gc2F2ZSB0aGUgc2NlbmUiKTsNCj4gKw0KPiAg
IC8qDQo+ICAgICogT2xkZXIga2VybmVscyBkaWRuJ3QgZW5hYmxlIHByb3RlY3Rpb24gaW5mb3Jt
YXRpb24gaWYgaXQgd2FzIGF0IGFuIG9mZnNldC4NCj4gICAgKiBOZXdlciBrZXJuZWxzIGRvLCBz
byBpdCBicmVha3MgcmVhZHMgb24gdGhlIHVwZ3JhZGUgaWYgc3VjaCBmb3JtYXRzIHdlcmUNCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L252bWUuaCBiL2RyaXZlcnMvbnZtZS9ob3N0
L252bWUuaA0KPiBpbmRleCAxMDJmYWU2YTIzMWMuLjI0MDEwZDVkMTVjZSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L252
bWUuaA0KPiBAQCAtNTk1LDYgKzU5NSw4IEBAIHN0YXRpYyBpbmxpbmUgdTE2IG52bWVfY2lkKHN0
cnVjdCByZXF1ZXN0ICpycSkNCj4gICAJcmV0dXJuIG52bWVfY2lkX2luc3RhbGxfZ2VuY3RyKG52
bWVfcmVxKHJxKS0+Z2VuY3RyKSB8IHJxLT50YWc7DQo+ICAgfQ0KPiAgIA0KPiArZXh0ZXJuIGJv
b2wgcGFuaWNfb25fZG91YmxlX2NxZTsNCj4gKw0KPiAgIHN0YXRpYyBpbmxpbmUgc3RydWN0IHJl
cXVlc3QgKm52bWVfZmluZF9ycShzdHJ1Y3QgYmxrX21xX3RhZ3MgKnRhZ3MsDQo+ICAgCQl1MTYg
Y29tbWFuZF9pZCkNCj4gICB7DQo+IEBAIC02MTIsNiArNjE0LDcgQEAgc3RhdGljIGlubGluZSBz
dHJ1Y3QgcmVxdWVzdCAqbnZtZV9maW5kX3JxKHN0cnVjdCBibGtfbXFfdGFncyAqdGFncywNCj4g
ICAJCWRldl9lcnIobnZtZV9yZXEocnEpLT5jdHJsLT5kZXZpY2UsDQo+ICAgCQkJInJlcXVlc3Qg
JSN4IGdlbmN0ciBtaXNtYXRjaCAoZ290ICUjeCBleHBlY3RlZCAlI3gpXG4iLA0KPiAgIAkJCXRh
ZywgZ2VuY3RyLCBudm1lX2dlbmN0cl9tYXNrKG52bWVfcmVxKHJxKS0+Z2VuY3RyKSk7DQo+ICsJ
CUJVR19PTihwYW5pY19vbl9kb3VibGVfY3FlKTsNCj4gICAJCXJldHVybiBOVUxMOw0KPiAgIAl9
DQo+ICAgCXJldHVybiBycTsNCg0KDQpJJ20gcmVhbGx5IG5vdCBzdXJlIHRoaXMgaXMgYSBnb29k
IGlkZWEsIEknbGwgbGVhdmUgdG8gb3RoZXJzLg0KDQoNCi1jaw0KDQo=

