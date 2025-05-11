Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8838BC3ABC3
	for <linux-nvme@archiver.kernel.org>; Sun, 11 May 2025 23:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j0Q2vYLK31KmqZomvEifKF1FoArVfiY4wkOO2L3AAFY=; b=Jb1HSnYClKi4Wh2V/xaUQtZhsY
	n7O2oHF1f1KkA8SItwhTozaU2N6g8U842B7YF9KzqJt361Wxe6Uimb4ALiD3kLrHSyZe5a3oaOXGJ
	UG1+RPcSPO03+bQXoZQrsSIkGiXrUNqQYhgANZtnHTR3EIorsV8qWktMjoFPbv9+3H3nds6dhE5bA
	XPWnnQiZYgqFez4g0avjfGwyS9oaqGt10iNeWbCMmK4w8Eba2Q3/JjyKIzWQFPQ8uGrZfRtpyG9Yj
	6/GrBEbEnysqJe/7wIFgDm8wtokBvS1hFdmRB0dmyFecO5Nkv0R/tzAkGeSDeajE7ao1sh9UHBFYx
	SUiOszLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEFjk-00000007zbi-1eQq;
	Sun, 11 May 2025 23:05:36 +0000
Received: from mail-mw2nam12on2061b.outbound.protection.outlook.com ([2a01:111:f403:200a::61b] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEFjh-00000007zbK-36jo
	for linux-nvme@lists.infradead.org;
	Sun, 11 May 2025 23:05:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOm9ma9AQ7I0jaqgGBuD61sbU5xNA3TVoV/ul2f+a8Xf03Od/U6EuQ+Ftp8P73AjKid8dUx/pYlMfQEjooo81HOSBGk8ufTwqJ4mFGWIRUcEcmYZEZEcq/6sHWw9kFgML9sirukcSiRW2y/j1j+GUCVdJsZOVaQR8DwWcfdD1fWDU9+vXeivYVjvRLJ5rQqR2Yqm9VozwckKc+i7ueo1NZAZ/5H4lpKWC7s8DSxk13pGa3D4MvdRhLQBktM0OO2aHWgnCAsDKWnUYmgEYuYhZo0+k9kN/tdLSExjdfyK/WpK9UEtAgjTpp6gV0NcWiU+jLxmMpEtwkhg0p1w9BBXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0Q2vYLK31KmqZomvEifKF1FoArVfiY4wkOO2L3AAFY=;
 b=KeJ9gOnRQyxYs/P1HrTHA1wQoUXPR27gQ+OUMLS/HF8ddjImhPkEPcq133tACF7cfAi1559xktKr+DGkKNCrhqzdHjr09mTi9ONAqRIHCWVrE8LMlwNemaNKFDqA1C6YQdsUEgd/g5HdPQt9iRHXJFGJrFjecFvzy7ZKTbLOLoVyBZQViMVK9JCSxZ2Yoamp1tQpVVVTU77YdyINSgsBcOYBa54sBgblwNQQjaR+DNl/401dBF68x0OZNC9btKU4sA35Yx+okONxBEjZgy/JO4rAFobF8Wfw3jPjv9rfq2d5k31/PrQup89waVdOaE6x8S9gZAlJ0ScTUtC5ByQMvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0Q2vYLK31KmqZomvEifKF1FoArVfiY4wkOO2L3AAFY=;
 b=XxdMnaNCzuChVGUi71MQh03COJGM+/yeKrKHYNngT+kXHiYxuk06Mt2HmDR2ZAccV3ipUZFYsS6gAtq8FZMupfIU500omddwiZHXxghDxc4ZXHsoIsdCcP5Rs4l/ohtSbk+jK3nkewOdhLYNqM/M97uTuVPCcfSPTPb/Rd+a1zLBsq1FGfyFwGHoBzUvXH7HtnTrlEFMGwaAjrv64Uo8+r0/Oszj4JEhlcUaHnigfrtF5PdsIpwPvBeINDVrLncMzSW4TooOltnTqDKa2Tk4K0xPsLJTXNJYaxbFxrx1Hzl0m5wbaR61LDaaccPkuqG+WRnkZ81pHL50WFpRaBBr7A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Sun, 11 May
 2025 23:05:17 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8699.024; Sun, 11 May 2025
 23:05:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "dlemoal@kernel.org" <dlemoal@kernel.org>, "alistair.francis@wdc.com"
	<alistair.francis@wdc.com>, "cassel@kernel.org" <cassel@kernel.org>, Wilfred
 Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH 0/5] pci: nvmet: support completion queue sharing by
 multiple submission queues
Thread-Topic: [PATCH 0/5] pci: nvmet: support completion queue sharing by
 multiple submission queues
Thread-Index: AQHbtNe/8GX9lbvx/Umc7qgG2BMogrPOKKEA
Date: Sun, 11 May 2025 23:05:17 +0000
Message-ID: <1c0b76bc-87d8-4e56-b17b-beaf37dbadd6@nvidia.com>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
In-Reply-To: <20250424051352.7980-2-wilfred.opensource@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB9517:EE_
x-ms-office365-filtering-correlation-id: 5547b69c-1627-4e4e-d8e0-08dd90e04bb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SE8wSU1Zdk5XZlFYZGpyanpCOFRUT1ZWTUw4d1JYR2RHb3I0TFNuWnV0aUJh?=
 =?utf-8?B?SHgrdkhXZDdLWjI2UFphUUxHcW1ZL0xJYlAvU1o2dFpCMkt6YW1kTDJ1eEU5?=
 =?utf-8?B?S0tsM3AzMzgwSEpCR0xDWTNCWTlpVGNvTjJVWHdueVc1RkU4VVVLRVJGWGJa?=
 =?utf-8?B?UGc0Si9jQjFzN2cvTWFaSlY4S1FpV0pROFZnV3VXNlZKUnk4UmZVMldIM0pO?=
 =?utf-8?B?aG5kTlhzdThqSzQvY3VLMTNKaDYxSUZmRGxrVi9XaUhFM2p2K04yRzZsdTND?=
 =?utf-8?B?ZHFkMllYRUpuNk02bndpVlJzelBCb1VWQ3B4azFtaHBTVStPNkhOODVYTXR0?=
 =?utf-8?B?SGgydmVxelBrVzcxNDhlS0F1ZlpYeXVpdWdHUDJKL2pyK2t0OHF0R1JQbEl4?=
 =?utf-8?B?Qk1EbzBrUzB5Vm04ak1FRkNrN2w3bUQ3T2lHc1RERlpvc2l3dEtXZnNHL0pa?=
 =?utf-8?B?eHNSalMwS3RnbkdEV1J5QzBZd28waDJKOWZKL2ZyandWMWh3ZjVwZnNCcEZT?=
 =?utf-8?B?UVJXUjgwWmVRaHpkOGllTXVDaVRLMVg4V2dJNGxyNWhmdk5QRGRSaDRhd0xB?=
 =?utf-8?B?TmYxbkZUZEFWclpDM04velVzMnlFbXl6NlZXbVRmZ0gwUEorRWRsZ3pzaWND?=
 =?utf-8?B?U2VYY2s2R1RRb0hRcitrb3NzS3lUSDZobmRPbjdoR2EycG9TUkFodlM3NGRP?=
 =?utf-8?B?WkxkaGZOYXVDaHV4WThFSXAxWGJkVU50ZWFJeWJ5THpocW9CWWtoZS8wMCsr?=
 =?utf-8?B?aU9FRDltc0s0WTlDUERuVS9LeSs0d0VOQiswbFpYNGRYSWF2SHNWRTdlK0J1?=
 =?utf-8?B?RUpBNDlDcktLamVybDBMSU90R2JsaHdvZVB2SjZ4Wnd6b25SNi9ML0dmaFBY?=
 =?utf-8?B?VDBaYzl0SnRKQzFKS0JTNENJS0RjczlWOS8zc0ZnRG9rV2duKzNudFJSeEUv?=
 =?utf-8?B?aDVCMkE0eWZaY0NZSEVGYXRTYlhISGNSK2ttcGprVXJ0MFBYdDZHbURlcFA3?=
 =?utf-8?B?b3Z1d0l3bnNtbVdXVm5vWUMrY2pjUmdaWG56cmg0d001U3VRQ280cDhaM0xU?=
 =?utf-8?B?T1FycUo3RDhpUjFpQXNnNDZObWJjSjIzSkhQZ003MVNETkxMVmdJa2xyV2Vm?=
 =?utf-8?B?ZG91RG9Qb1VLUEFSaW5sd2l5ZGdzeVkyTDhYb0ZTZHVwUkZ4Z1Y2RmF5R1Fp?=
 =?utf-8?B?aWwwV1ppeTZ3bUZMeGExclcxVjE2Y2ZrU25Dc3BpOXZPWWhYY3F6eXh0QVhn?=
 =?utf-8?B?MkpYZnlKQm5YMG0zQzA2a1FhUmRvdTlXNVZtV3d1N0ZiRm92N1orWmxyeEx6?=
 =?utf-8?B?Tk5UeDhxaWEwRmxVNmJycDd2WTVEbTBCTE15OUFMQWZ3N0lwRUxHRmRwL0o3?=
 =?utf-8?B?Ni9teWdCUkEyQ1JTZ0VsSlAyK2gySWJkN21MeGlNS2t6a203enFGUmsweW9r?=
 =?utf-8?B?Rkh0VTZ4VHZ5cFQyUExXc1VoanpwckJoY3FodGxvTnlDZ09pSUxxdHhwbjl3?=
 =?utf-8?B?bnc1dEhxWXM0NTkwUmVlSi96Szh0UUp2Smxjb2UwOVBBY01FaHYzdXVJbndL?=
 =?utf-8?B?ZXhGeHdwMTJFeElRQm5mZXRpTWZNZUhNMGNIcm54ZUNPK2IvSTNDeUtEYWRL?=
 =?utf-8?B?cUZIczBvem9lZHg0cEU2ekZBekg3NWIxRlFlZE5seDRSQUhjV2Y1YkhWSCs1?=
 =?utf-8?B?RWhvRVUyMVoyN0QwL2FkU0NXSDBEYURjSy93MWlSM0x5dDQrTk9mbnpJVmJj?=
 =?utf-8?B?SnQ1WnV5T2JCN2FJVUllOFQwQUNreStsQUZLaGkwUmxoMWpUSFYzTVduZ3Fo?=
 =?utf-8?B?Q3dpRE9FK1BrV2x6SlRVRitHMkNBd0t3bWdqR3haNUk3Q0RJZ2xFVmFWM2Zv?=
 =?utf-8?B?dUp1UGVzU3dZVFFWYkN2RFlEcDdWTGp5alI0SFNwd0F2VTlJUjlCMy9KUDMz?=
 =?utf-8?B?L2tQQ1pIVDQ0RHE1enRiOVFCQlBSSDV0NzFia0tpNjhiOGJaSkFmYVJNQUNC?=
 =?utf-8?B?OFpIc3JqdEN3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE5RSW0vZm14cmpLYU84VTNlYzh5WFJGZ0g1czdWRUpLWEZBU3U2Q1VFL2Q2?=
 =?utf-8?B?ajhHbXVCTk54Tmp3R3FmTDIvRzRUWVEwbExZQWNFM0gvSkZneTd4U3pMSWNY?=
 =?utf-8?B?RUtPZVdsM3A5T3hqMXRhdlJhYWNaZDhUWnBoeWw1MWdmWlZMd2MwS0tQNGpl?=
 =?utf-8?B?ZUFpRlhSK3B4MkNBV3dCL1l4N1U4VXhBMG1GWitpWnhIemo1ZjhwY0RraXlO?=
 =?utf-8?B?Y0VidWdBSTlNUnlQNUJSQkUxK0F2U0doVFl5YU1DbFlTb3lNQUVBY1ZQWmJ0?=
 =?utf-8?B?Y2NXRlNKV2JRTVNta2F3L1NvRGpGbWFZR3RTTXgybEJwaUhhOU1IVmQ2d0hm?=
 =?utf-8?B?ak9rNlZCM2pJMFVSMGx0ZTh5dmpOYWJ4ampkL3lTTEV5WU91cDVqYlJjYTZv?=
 =?utf-8?B?NzNzdnhXRW1rTXhuVVJPN21FMGVQL3dZWkNVR3AxV3o2dU9WMEpJQ1daUjJr?=
 =?utf-8?B?b3ZSYzNIdnlLWlFYZ3FmcWJOVFFVN3ZIOEVEbUFGMEg0ZlpEVml5YVB0QVhp?=
 =?utf-8?B?V25pQUtTVWgwcno5Q0FONXJVelhYU2oxV0lYamsyRSt4WFFHZGxaMDJxNndS?=
 =?utf-8?B?NXVwYWM0RERoK1ltQ1hGdnRrQmNQVDZvbTVGOXQ2QWRFUHZuZVlKMGxyMTg1?=
 =?utf-8?B?WUZUN1JtNHlCdW1PdGNPQ0F3a09oT1JGN1F5Rk56ZkljT2dnSmE0WnQzWlBl?=
 =?utf-8?B?SHRpZS9HS1FPMkQ5VERTa2s1ZTBVUFYwL3oyOFREUVNuRms0eklXbkc5b3Zn?=
 =?utf-8?B?Wndzc0x6ZUVHSExzV0JtV1Zwa3ZPWEc0bHZMYk9wcnZ1TmxwOFdYZXNPUFdr?=
 =?utf-8?B?ems2WTdlRUhyemdOQTYzb2RTdG5IczJsdDVUYnNsRVBwMVowbWxCOHFuWW0r?=
 =?utf-8?B?SXo4MmJsMzFEaEJsT2o2YUFNRldwcUVQdTRzWld1aXpzUjBuQnBidkZuZmFP?=
 =?utf-8?B?QjJsVXJHblpxRjVrZWhydzRLT0dWUHArOXpvL0pLKzIxZWhoL2luMCtYcGli?=
 =?utf-8?B?UU96bjVzM1NTK2I3UmtEYVlESVkzU0p2dnd0WUhvUXFQZTlXaW0yOWhveXRL?=
 =?utf-8?B?aDRXZGVZVS9lbFBVYjRyd1k0RzhGY243OGlYM09Rcml1S1RvOXVJYmtpT1Ey?=
 =?utf-8?B?WGlsMHlMcVIzUzJkblhNbWY4VlNjTXZIa3dPUk9ac2t3bExUNWRQMTNuM3ll?=
 =?utf-8?B?RzZ5dTNyQ3ZxS00vRjB1ZDRwYmNGUVJjRXlGbkZ0UHpaRTdOMUMvZFV5SUF5?=
 =?utf-8?B?dHNGbmRSRkIrTXZXRFJYN2c2OUZvMGdFQTlBNHRheFQ1V0pSYXBWTjZTc0ZL?=
 =?utf-8?B?TzdWNWNuWFFsUnQrMFhaY251Vm5LOElVS0pHTGpKWTMrb25idDB0bk5zdzF6?=
 =?utf-8?B?S0x0REtVcWRSZDhUZjZIUEZHaGxYdXlmbFF3QWhXRnBNM01RRkM1a2Z1MUNJ?=
 =?utf-8?B?aVRFeDh5RytTMCtJVWo5eEhrK3krWjVRNjExak9uY0p5eVh4YlFpcjdIdjZv?=
 =?utf-8?B?eFJYYTAxZ3BwaTFYb1pvSmIxK3k2YU1Ca2hWVDZwbjJaeDdjWlo2bWc4WTRa?=
 =?utf-8?B?TFBPSDdmKzlQQTZ5K2p5WlhSQ2JDdHpRbWRRZlVJYStWZ0RGZy9JM3NSS0E2?=
 =?utf-8?B?UUs4ZkVJUDBLZmg4WEM0eGcyOFdLeUhEUjJrWEk3dDhDMUFEeU5Vck9mN213?=
 =?utf-8?B?eEUyVmMvejFjdytnS1FOLytFcElFUEdFYzVHRno0Y2hLdGRXRytKMExiREQz?=
 =?utf-8?B?UVhGNjB4MEI1UzNnTHU1UXRXTEpuQ1pFQU5CaFlyRXpDVnFuZGFpbWwzWndU?=
 =?utf-8?B?V3Q4U3k4R09zUnYrVUFZRHVIcmpCTzhJSXlaUEhBQmV2M2l1NG9TTmhxeW0r?=
 =?utf-8?B?cXA2R3NaSURxYWFhcTJWcjl1WXRONU95aGhJOTIrSENRZWI5a3ZqcnRFWGtR?=
 =?utf-8?B?M1RqYzJlNitEbkliUkNqWDJsaDdYV00wb0xFVmMrbm9MN3F1aHM0N1NPak5B?=
 =?utf-8?B?ZVZ6ZHMyeEJFVFgzTzRIb2YzYXl1RWxpaFk3cWtOSnRGTXlzU3FGRmYrek8y?=
 =?utf-8?B?QjFhUXpYV2FxT292YUpON2VKU3VEcFRtZ3F6amtXYXZ5NVFXOERYMCtmNWcr?=
 =?utf-8?B?emhVa0xGcUNJOHZDc1NEdC9HUVNCU3JnRWNoSkwwUHUwQ3lSVmx5YzB6WlhD?=
 =?utf-8?Q?lM1wwGihnD8b/JIx9kJwDE0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <585EA3E31F52914E8617A66C637460B7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5547b69c-1627-4e4e-d8e0-08dd90e04bb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2025 23:05:17.3587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2eckiq0kcdu2qYY4Sy0HAvd7ZArxcdB90Xzi98all3IS76K7ig49cJ/k75RDNGkxBXqL9lVleqD4S48Oj0v2UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250511_160533_795759_D2C7796C 
X-CRM114-Status: GOOD (  18.50  )
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

T24gNC8yMy8yNSAyMjoxMywgV2lsZnJlZCBNYWxsYXdhIHdyb3RlOg0KPiBGcm9tOiBXaWxmcmVk
IE1hbGxhd2E8d2lsZnJlZC5tYWxsYXdhQHdkYy5jb20+DQo+DQo+IEhpIGFsbCwNCj4NCj4gRm9y
IHRoZSBOVk1lIFBDSSB0cmFuc3BvcnQsIHRoZSBOVk1lIHNwZWNpZmljYXRpb24gYWxsb3dzIGRp
ZmZlcmVudA0KPiBzdWJtaXNzaW9uIHF1ZXVlcyAoU1FzKSB0byBzaGFyZSBjb21wbGV0aW9uIHF1
ZXVlcyAoQ1FzKSwgaG93ZXZlciwNCj4gdGhpcyBpcyBub3Qgc3VwcG9ydGVkIGluIHRoZSBjdXJy
ZW50IE5WTWUgdGFyZ2V0IGltcGxlbWVudGF0aW9uLg0KPiBVbnRpbCBub3csIHRoZSBudm1ldCB0
YXJnZXQgaW1wbGVtZW50YXRpb24gZW5mb3JjZWQgYSAxOjEgcmVsYXRpb25zaGlwDQo+IGJldHdl
ZW4gU1FzIGFuZCBDUXMsIHdoaWNoIGlzIG5vdCBzcGVjaWZpY2F0aW9uIGNvbXBsaWFudCBmb3Ig
dGhlIE5WTWUNCj4gUENJIHRyYW5zcG9ydC4NCj4NCj4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBz
dXBwb3J0IGZvciBDUSBzaGFyaW5nIGJldHdlZW4gbXVsdGlwbGUgU1FzIGluIHRoZQ0KPiBOVk1l
IHRhcmdldCBkcml2ZXIsIGluIGxpbmUgd2l0aCB0aGUgTlZNZSBQQ0kgdHJhbnNwb3J0IHNwZWNp
ZmljYXRpb24uDQo+IFRoaXMgc2VyaWVzIGltcGxlbWVudHMgcmVmZXJlbmNlIGNvdW50aW5nIGZv
ciBjb21wbGV0aW9uIHF1ZXVlcyB0byBlbnN1cmUNCj4gcHJvcGVyIGxpZmVjeWNsZSBtYW5hZ2Vt
ZW50IHdoZW4gc2hhcmVkIGFjcm9zcyBtdWx0aXBsZSBzdWJtaXNzaW9uIHF1ZXVlcy4NCj4gVGhp
cyBlbnN1cmVzIHRoYXQgd2UgcmV0YWluIENRcyB1bnRpbCBhbGwgcmVmZXJlbmNpbmcgU1FzIGFy
ZSBkZWxldGVkDQo+IGZpcnN0LCB0aGVyZWJ5IGF2b2lkaW5nIHByZW1hdHVyZSBDUSBkZWxldGlv
bnMuDQo+DQo+IFNhbXBsZSBjYWxsY2hhaW4gd2l0aCBDUSByZWZjb3VudGluZyBmb3IgdGhlIFBD
SSBlbmRwb2ludCB0YXJnZXQNCj4gKHBjaS1lcGYpDQo+ID09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+DQo+IGkuICAgbnZt
ZXRfZXhlY3V0ZV9jcmVhdGVfY3EgLT4gbnZtZXRfcGNpX2VwZl9jcmVhdGVfY3EgLT4gbnZtZXRf
Y3FfY3JlYXRlDQo+ICAgICAgIC0+IG52bWV0X2NxX2luaXQJCQlbY3EgcmVmY291bnQgPSAxXQ0K
Pg0KPiBpaS4gIG52bWV0X2V4ZWN1dGVfY3JlYXRlX3NxIC0+IG52bWV0X3BjaV9lcGZfY3JlYXRl
X3NxIC0+IG52bWV0X3NxX2NyZWF0ZQ0KPiAgICAgICAtPiBudm1ldF9zcV9pbml0IC0+IG52bWV0
X2NxX2dldAlbY3EgcmVmY291bnQgPSAyXQ0KPg0KPiBpaWkuIG52bWV0X2V4ZWN1dGVfZGVsZXRl
X3NxIC0+IG52bWV0X3BjaV9lcGZfZGVsZXRlX3NxIC0+DQo+ICAgICAgIG52bWV0X3NxX2Rlc3Ry
b3kgLT4gbnZtZXRfY3FfcHV0CVtjcSByZWZjb3VudCA9IDFdDQo+DQo+IGl2LiAgbnZtZXRfZXhl
Y3V0ZV9kZWxldGVfY3EgLT4gbnZtZXRfcGNpX2VwZl9kZWxldGVfY3EgLT4gbnZtZXRfY3FfcHV0
DQo+IAkJCQkJW2NxIHJlZmNvdW50ID0gMF0NCj4NCj4gRm9yIE5WTWUgb3ZlciBmYWJyaWNzLCBD
USBzaGFyaW5nIGlzIG5vdCBzdXBwb3J0ZWQgcGVyIHNwZWNpZmljYXRpb24sDQo+IGhvd2V2ZXIs
IHRoZSBmYWJyaWNzIGRyaXZlcnMgYXJlIHVwZGF0ZWQgdG8gaW50ZWdyYXRlIHRoZSBuZXcNCj4g
QVBJIGNoYW5nZXMuIE5vIGZ1bmN0aW9uYWwgY2hhbmdlIGlzIGludGVuZGVkIGhlcmUuDQo+DQo+
IFRlc3RpbmcNCj4gPT09PT09PQ0KPg0KPiBDb3JlIGZ1bmN0aW9uYWxpdHkgY2hhbmdlcyB3ZXJl
IHRlc3RlZCB3aXRoIGEgUm9ja2NoaXAtYmFzZWQgUm9jazVCIFBDSWUNCj4gZW5kcG9pbnQgc2V0
dXAgdXNpbmcgdGhlIHBjaS1lcGYgZHJpdmVyLiBUaGUgaG9zdCBrZXJuZWwgd2FzIG1vZGlmaWVk
IHRvDQo+IHN1cHBvcnQgcXVldWUgc2hhcmluZy4gSW4gdGhlIHRlc3Qgc2V0dXAsIHRoaXMgcmVz
dWx0ZWQgaW4gSU8gU1FzIDEgJiAyDQo+IHVzaW5nIElPIENRIDEgYW5kIElPIFNRIDMgJiA0IHVz
aW5nIElPIENRIDIuDQo+DQo+IFRlc3RpbmcgbWV0aG9kb2xvZ3kgaW5jbHVkZXM6DQo+DQo+IEZv
ciBQQ0k6DQo+DQo+IDEuIEJvb3QgdXAgaG9zdA0KPiAyLiBBc3NlcnQgdGhhdCB0aGUgZW5kcG9p
bnQgZGV2aWNlIGlzIGRldGVjdGVkIGFzIGFuIE5WTWUgZHJpdmUNCj4gICAgIChJTyBDUXMvU1Fz
IGFyZSBjcmVhdGVkKQ0KPiAzLiBSdW4gRklPcw0KPiA0LiBVbmJpbmQgTlZNZSBkcml2ZXIgKElP
IFNRcyB0aGVuIENRcyBhcmUgZGVsZXRlZCkNCj4gNS4gUmViaW5kIE5WTWUgZHJpdmVyIChJTyBT
UXMgdGhlbiBDUXMgYXJlIGNyZWF0ZWQpDQo+IDYuIFJ1biBGSU9zDQo+DQo+IEZvciBOVk1lIG92
ZXIgZmFicmljczogVXNpbmcgTlZNZSBsb29wIGRyaXZlcjoNCj4NCj4gTm90ZSB0aGF0IHRoZXJl
IGlzIG5vIHF1ZXVlIHNoYXJpbmcgc3VwcG9ydGVkIGZvciBmYWJyaWNzLg0KPg0KPiAxLiBDb25u
ZWN0IGNvbW1hbmQgKElPIHF1ZXVlcyBhcmUgY3JlYXRlZCkNCj4gMi4gUnVuIEZJT3MNCj4gMy4g
RGlzY29ubmVjdCBjb21tYW5kIChJTyBxdWV1ZXMgYXJlIGRlbGV0ZWQpDQo+DQo+IFRoYW5rcyEN
Cg0KRldJVywNCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQoNCi1jaw0KDQoNCg==

