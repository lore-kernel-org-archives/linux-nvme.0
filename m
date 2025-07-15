Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983BDC83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 19:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aogeQtbBYbP/7paLs+1mGd69h+sY57d6PwwgtrDR+gY=; b=YPqA2cS/XOQuPx9i2xH3omySAG
	3r1MWs2/EovdUFh5dkedUB7sanoPxhsPi03IeeWezGFcj6xGLg2MCuds5zXbzQMKjpf9IgOFvBesf
	QjPrrdEuMW+5QvPkk0slxEJivVHbcv0HGNZ8QxzFbfjSrNtI2fobv0ya8fQpFWo5FUBrsB4+vvjEA
	RptxLZ/PrgNoJySnQjWCTzkumrbGIsXyyO7pJJviHzDtn4gBYIerYPME0p9tD21Pw03lCxh3qnrDG
	ZQaFJ7Xi7L02VYk5+jR56K6etrtHkqAaOyewXB1oIzIjo4ucblNEGFidpyfMDZQUeomae1UTSOxZh
	BRL2Cb8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ublBi-000000061q2-1kZK;
	Tue, 15 Jul 2025 19:19:38 +0000
Received: from mail-dm6nam10on20605.outbound.protection.outlook.com ([2a01:111:f403:2413::605] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubjMq-00000005p5P-2IfS
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 17:23:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTCiV2f1Gle42mAb27ihRdNHZq6c3Ps+0B9Is21BUzMUmMxME8rgh7Fx6A4piOR+6UaBpFOCzWEDuTgaEkZ2Cfp3u6ZEysUAzGFODTZqMYD3v3oq5mRUOGo0ED9ae5sw19+tiGcGksLS8BoKNYam5XTCc4sKrDnx9zkrLm6oD0dmZoT9/03NeEzm6oY4RUXfGlz1EXcICoIGwNr39CAJjS+NBRlzZxJKvFY6/jUMu/+fRy22kgBl0wkgP1TB9mUYCd8loZofhPVUpTK7FXXEetYysb7eb3tWkNzZTIBf/aUdYKT3ga3ZghV2E5N0L78WmURNyPb5nZwPLacGELLSag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aogeQtbBYbP/7paLs+1mGd69h+sY57d6PwwgtrDR+gY=;
 b=dAon5dnLLwM7ySL2QDNcD9KFbTucMHfitLGs8BSQUX6oX/dmfR0fPn21wm2+B2hTnkTgGglJCTx04mXqaY7QKHpdoKEZKqNJZtKYh+flihUI9zXXOdYkzl1M/xqrXtNCuIGaQX6wzabvWW6PxjAaOVYS+Q1DRM5bu1CTfKfeHqEsYuBF5fgF2OeTVh1t7GI9jvqml4hHgcfLY7Cj+xJbRURXuGt1tM3Y1isGsAElaX+92jSrymc9kKii55+aVN8kJdbwQOuTzKxu2jAmSP26mLhGkpii/NIVVKqU4Ppp0qqReWPtutLosdvGtghot9Hm001CKOGCrrZH+4WoKqUb6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aogeQtbBYbP/7paLs+1mGd69h+sY57d6PwwgtrDR+gY=;
 b=fYNK2STXoGvk5r+NpQ1+5NLdwpn+5oCpOOAAy3GYIVIRr5myHWZgKUzwqXi6+D2C8JXxDjLcWlutRPfvwQvxaJl7mnV1B8RIgQ7iJ/NQ2dWAHPJe5EqlQ2naBoMadAhh+jKNBkGYBeuzr4xNpu6L/fJZyaKfnZ0mrNSDlpl8xivvZ3NQV4cg2ZGkO98UQb+qGo4WQsI/6noYIryAwAhnJp6k2+bUa8Ti38xg4aTZWaWobY9AkqvNYpyb6AbzK2zfpVwnNtqcC5cnR44pBqEjXoTKX82kM2vY0oGRU2bmUJeMZFLOmZF6NxbeMAJoL+OcZpApG4hG0eHtICLsKlY0bQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 17:22:54 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8901.024; Tue, 15 Jul 2025
 17:22:53 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Thomas Glanzmann <thomas@glanzmann.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Number of data and admin queues in use
Thread-Topic: Number of data and admin queues in use
Thread-Index: AQHb9Sv7m2HxWiz4dE6j5fDPlFkImLQzQg8AgAAtyoA=
Date: Tue, 15 Jul 2025 17:22:53 +0000
Message-ID: <8584a963-a482-47cf-9ca2-a9d34e54b200@nvidia.com>
References: <aHW1qUJksE5Okflb@glanzmann.de> <aHZoBO9cPcRGIDwH@kbusch-mbp>
In-Reply-To: <aHZoBO9cPcRGIDwH@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY5PR12MB9053:EE_
x-ms-office365-filtering-correlation-id: f0578f04-9576-42af-c265-08ddc3c43b8e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Tm1rUzZWR2luMEhVdVp4dVZ0emlSbzQ0TXlnbFR4YlJxZ2QycjlTV0VHTXdI?=
 =?utf-8?B?dCtpYmdMSVdFaEJCOUNKZDlyeFJuNG9TQVpyZEYyWE95RUhma3lhRUhHSGl0?=
 =?utf-8?B?aW4vdkluZTJQMm1maDRuUHBQdTIxNmhscVNpcjE2SXVZUDNsRFJIbGlKdXgw?=
 =?utf-8?B?ZEZySDlrSnBtMzJtZzlUNC8vTWVPcFdFaGpvcWtwb2RrYThBVWlhWjBXK1hw?=
 =?utf-8?B?b3o3bmVYUHJHMGxFcTBBWjZ2ZWk1a2V4aFZHSkk1TTdRN09zSjNMcXR2Z1JF?=
 =?utf-8?B?ZFUrQnBsQndOWXNITXR6YWxsL3RhdGw3dnViNnloUmRUbFFPWk44TkxJVjI1?=
 =?utf-8?B?RFhTczNGRzRhNjc4cHY4eXp6Sk9NN1YrZzNBbTBjclNoQWdycnZZMExvWHZo?=
 =?utf-8?B?SW4ycU9QMXc5YTBHTzZkMFhTRXNsdDBUUTlZcWZDeXV6azdNeWZ0K3lJQTVF?=
 =?utf-8?B?MGhwRHJWQXNraU8remFQVmZMNFRSdFYzZjIwQ3IxeVozWWpqYjNKU0twWWlC?=
 =?utf-8?B?YzdocnNjTVh4eXdUVzVtdEMxY2pnSjJ5dGxNcVZpcmJiNC9FVnRHQ3RqR3c5?=
 =?utf-8?B?UC9KTGV5WEd5TEp5bm11SlhTdXdXK0RwcGFpd1VWcEVHV2thSlF1WlZVb3dD?=
 =?utf-8?B?R3JXVEZQUXJ4NzMzYmhZZ1RWeStyeXZtY051eWJVWjRVemlxdFFWMkVsbUFa?=
 =?utf-8?B?NmZrWGNES3lpeGpPcTBnaFJxZ1BXVjNHUEhCYW1nWGN2VWtaMk5sSEdkcSt0?=
 =?utf-8?B?Njlrc3lqbE1Uc3dZNmZxVGg0UWwzVUNYU2RxR2xaMVE4V2F1dEI3MHNQM0N6?=
 =?utf-8?B?azNGQzNRUGtDR0pZK2R2SzhGYk9tK3RYWC9LWWJBS1lKNmhINk95a0gwcVdz?=
 =?utf-8?B?RzgrZkhPOG9kWkpFQ1BXdUFlNzFzN051dXM3Nm1paTFTWVFQZ2hUM1cxRTAv?=
 =?utf-8?B?S0dkenJyNk1Jemh4cEpZNkFTWHgrYU9UWlNMeEhENkM3QU8reU0wWWhRaGox?=
 =?utf-8?B?bVNxZ216dWFZZTMvN1d2SWx3MFFZS1BFbFV6RnQ2M0FpMmFjWnpVTU1pRC9y?=
 =?utf-8?B?UkJsbksyTGVUNEFKZ3hCY1FFcjVrTml3N2Y2UGNSRWNlakphN3Ixb09pY0ZQ?=
 =?utf-8?B?Q0hyaUVnYUZxamE1OHMzbERwUE4rV1hnUjFpU0swVVdXMEZtU3dvWTB6bUhE?=
 =?utf-8?B?NmVIVVA5bk5uQUxZTmtYWXIzWFBCd2xjUlJCUFpWZ0c1dzlLeXBOanNXbDRU?=
 =?utf-8?B?ZDV3ZkFmaWhJNWwrOEQ2TFJIYk96Z2JtUzY5cjBSVmFoSGVXdGlON3VhQkhz?=
 =?utf-8?B?am5jUFI5VWNoYlgzMXBYdjZOelRtU0JPOFIvTXFKaGI5UTRiOUhldkcxRThp?=
 =?utf-8?B?a1NsWW5FWDdoQUE4UVRmMklROENvNy96UitGUmN6L1pwNkFMdEZDVEZ3STVa?=
 =?utf-8?B?dHVkU3h1Z3Jwck1VYjQ1alh2UjJBSHV3NG1uMlhqRm9kTnoyQVk1eWtVU0Y4?=
 =?utf-8?B?Z0dVcFZLYzNvVHJ5dlVHd3ZrNTgrakpwRVgzaE5tUnUwYkx6Vk1IUWRPY0Nw?=
 =?utf-8?B?TzlWdE1JTUFaU2NET1gyVXU4L1JsYVF2TFM1UTErRzM5VkdRM1NueXg5VW9h?=
 =?utf-8?B?OWhIbldwWGJZUllmcEgxelY3ZHplTHhWZEdtb3J2dExPQWZuOU45UW5sQ0Vr?=
 =?utf-8?B?SlgyOUFneWw0dmhpRUFkVzNYcXRXUXY3QTUvZXhsbU5EQjVzNWhReTVDMkw2?=
 =?utf-8?B?VFhMWmp5UFJRekdMWnM1VHdmOU5Md1NPdzZ6UGY1MEtHVEw3ZE5YU2NBaFRU?=
 =?utf-8?B?TFdyeTBXQU5vemNTR3dSb2VpVnF0dTMrK25GMWVXSGRMenU4ck1QTC9pcWFW?=
 =?utf-8?B?ZWduRmxndGp2NmdvK0ZNVVFTS2lnNXFkSlc5dEt5S0thaE1wSDI0VGhxSmlB?=
 =?utf-8?B?T1dpYi9EekxMeXUxWUdpUVgvZjJ4SG1iTGc2N0VzV002alJCcnFwMklKYk52?=
 =?utf-8?B?WEtkYXZ1Y01BPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RG84U2JxTmh5OGlTRDVtMFFBcjZWRGN2MkpWTmk0eXhkMlRKeG9tSUUzZmhH?=
 =?utf-8?B?UW5lY0dkaUxGUnBLSGJESkowbEQzdW5YR1crcll5K0xHQnNnNWFlR0J5ckhB?=
 =?utf-8?B?VjB5QWlVRWlRRkhKU3dPNWwxM0VEL1MzNExtMGJjNWR0ZUFRUEJzRnZ3alBz?=
 =?utf-8?B?UEo2U0g2aFpoM2xSU1ZhYjFuWlJLcy8xdnc1bXJ1b1lwVGZiazVEalJrTEIz?=
 =?utf-8?B?NFpwY2FvMXV3QkxNRGJlRDlFeDBiL3FkSTMzQkp1SUxKR0NCbFhRdlJXWlU4?=
 =?utf-8?B?dmxXeloxRS92dTgzemYwbEJCcElwVTBOclJjbXFCRllTUnNDby9vT3NWVEpI?=
 =?utf-8?B?WWVTQ3FCQVd6TnRjV2RpTitTTTcvUEdDVTRFNTRCU29nK2ZDRkcxaU1UY2h1?=
 =?utf-8?B?SXpaU2ppU04rSEhhNFI2eXAyOXF1T2ovNHlmdXpNNS96M0ZrYVJsMG1ESmx5?=
 =?utf-8?B?RWM2WEtJa1hCcytaRG5udzdoUzBWbmozSEJKSk94TWRMQ1BsZ21DZ2FEdGI0?=
 =?utf-8?B?cjc2MmFYUEhlbGlxT2FmWXNpOHRxNEZNNGFuZWtVeStSaTlibEY3VXllRkRF?=
 =?utf-8?B?NmtqeWkwS1QyUmJRN2h0dzhJTmhiTTQzTVFPM3IwYkRWcTl3QmJMMHIwdjd5?=
 =?utf-8?B?TkJCNlArdTE5cUdaMU4rUlh3YTVzd2szZFA2a0dWNHF1MWhkSEVFVU54c3gr?=
 =?utf-8?B?ZCsxZjNpZEVKQ3Fwd3NPUnJmeUJwMWhEVXlwYUZMMzFQYWd2TTYzdGZiWmQv?=
 =?utf-8?B?YzUvZ0pkWTBOTkc5MjN0cVg1azZqYlVpNGQycjJIZzJYOVp6WEgvUFFPbm94?=
 =?utf-8?B?MUFQK21Ib0lwWFJ0cXhhMTVmbGFuWkFaajI1WDZGcjkxQ1JmalhMczJoaC85?=
 =?utf-8?B?R3A3bncvMXdwYjZrb3JnU0NiSFBBWEVXVnVSNENIaTlub0xPdDkrRUdLT2tO?=
 =?utf-8?B?NEVBcUZkWDhSbG5Ea3JaUGVMM3dvSEdpZGpLVllMMzd5TVRoWmF3c0FBR0lH?=
 =?utf-8?B?aVZnTnhTRGtlRUdJVFFyZENkbWw5UWZzNWJMSXAxYkpkWmt4a2Ztb24vYnpj?=
 =?utf-8?B?bUhxbGV2Qi8vRDZoWG91em1XZjQ0MW56QWwwNHFZUUxLREFaWnB1dGFwSjFq?=
 =?utf-8?B?NmtsT05CU2xJTkxLMnFCc1ZBcDZOUzhveDZoajhzNUg1NFBRNHVZbkc3UlNa?=
 =?utf-8?B?c2g3bmlLSnBrYTFDVlF5cTlETnB0RHBXSmhmMmJsZXMxNGlZVVFERHlKVnJr?=
 =?utf-8?B?SlViRnV0cU1NZUx3akRFZTQyRkFmaEJoU0NHMW9oWDY4U0psQ0k4YmRMTXht?=
 =?utf-8?B?QTlPMVhnSzlqekhpTnd4REdQR3hJMHZQWlZqakovbEh3akZZUzVTTUg4TkxN?=
 =?utf-8?B?RU0xQVJxSk5LUW1QMGNKWnFQSEFNWUprWWgxY3dFUjJGbnIzZThITmQ2UjRo?=
 =?utf-8?B?ZTJJNENxeVZEdFNtZ1JORG5TRkRUdFpickpjYTZiNjV6QW5WemRmOEREclN5?=
 =?utf-8?B?YlhDek1TVTVTNTRRQkI1WVYrTERoQTh4VmdxU0gzS3ZtOWdLaCt5K3RzcWpF?=
 =?utf-8?B?S2h5cjBkY29md0tjNmFXQkJQckw2TnpNNWpZbCtYNVhTRVU0bTRPdEh6aWNH?=
 =?utf-8?B?MUQ0N1BDVlVKNVU3MHNZVG9HMk9zb1JwUEpIamxneFAzTUZ3QkU2NHpTUlMw?=
 =?utf-8?B?OGlXZC9xcHRrTGI2M0xEOHQzWHA2RWpjU1N6YjFBdmUxZ1M0VUQ0L1R6YVln?=
 =?utf-8?B?S0hhMFlJZzJZQzhkNXY5a1d5aGdSUTJGRVRCNUpIa0RmZmVLR2JyNWhrYXlj?=
 =?utf-8?B?L1NhQUovQ2RJSjI3MXQ1ZVl4b1JHQzhIMStUb3VCcXU5N3VnWFFlTDJhbTVY?=
 =?utf-8?B?WEZsdVVGN3g2bk9ackxaRXNGUW5BMHd5bWRIOTNabElHb1hRaWtMQ3ZBRTlC?=
 =?utf-8?B?L1ZnUDRIYU9Cb25SNVBmcjY5UGdEeTVnNjVMbVhiU2tIbWpUYTEyWVR1S2NX?=
 =?utf-8?B?TFd1enZKeEtjb0ltdm0yZUtvNjNtUjlGcUlBMk1jQ1dWaDJobjZ1b3JxWm9S?=
 =?utf-8?B?RmFRL1hmUmMwRm96a054Zlhma0hBNzR6L2IwdWJUT25ldnJ0Znd3eHRDNWdn?=
 =?utf-8?B?UWNKTHo2cXF0WVZwL3F1eG8yMjJ1RmM2QjB6RTlkSjlRTSs1VkNjRU9UTmJ6?=
 =?utf-8?Q?zI6mgCd9MjGMRtcy30IT3lVcSMRonpzxycCpr1yTy99z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41AEA6B825314845AECD1E4C7E9BA540@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0578f04-9576-42af-c265-08ddc3c43b8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 17:22:53.6313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o2VFSDNtaHXFj41V67XI7Z8DxVFMoTnirxCbf/eI9+UmCOGc70o4QsbvAih35vID40Pz8BnUF6gAaEnYWig6lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_102300_590580_278E32C6 
X-CRM114-Status: GOOD (  18.60  )
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

T24gNy8xNS8yNSAwNzozOSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFR1ZSwgSnVsIDE1LCAy
MDI1IGF0IDAzOjU4OjAxQU0gKzAyMDAsIFRob21hcyBHbGFuem1hbm4gd3JvdGU6DQo+PiBJIG9u
ZSBoZWFyZCB0aGF0IHRoZSBMaW51eCBrZXJuZWwgYWxsb2NhdGVzIG9uZSBxdWV1ZSBwZXIgcHJv
Y2Vzc29yIChjb3JlIG9yDQo+PiBoeXBlcnRocmVhZCkuIEkgY2FuIHNlZSB0aGF0IHVzaW5nIC9w
cm9jL2ludGVycnVwdHMgYnV0IG9ubHkgb24gcGh5c2ljYWwNCj4+IGRldmljZXMsIGJ1dCBub3Qg
b24gTlZNRS9UQ1Agc3lzdGVtcy4NCj4gRm9yIFBDSSwgdGhlIGRyaXZlciBhdXRvbWF0aWNhbGx5
IGhhbmRsZXMgdGhlIHF1ZXVlIGFuZCBpbnRlcnJ1cHQgc2V0dXAsDQo+IGFuZCBjcHUgYXNzaWdu
bWVudC4NCj4NCj4gRm9yIFRDUCAoYW5kIGFsbCBmYWJyaWNzIHRyYW5zcG9ydHMpLCB5b3UgaGF2
ZSB0byBzcGVjaWZpY3kgaG93IG1hbnkNCj4gY29ubmVjdGlvbnMgeW91IHdhbnQgdG8gbWFrZSAo
Im5yX2lvX3F1ZXVlcz1YIikgd2hlbiB5b3UncmUgc2V0dGluZyB1cA0KPiB5b3VyIGluaXRpYWwg
ZmFicmljcyBjb25uZWN0aW9uLg0KPg0KPiBJZiB5b3Ugd2FudCB0byBzZWUgd2hhdCB5b3UndmUg
ZW5kZWQgdXAgd2l0aCwgeW91IGNhbiBjb25zdWx0IHRoZQ0KPiBuYW1lc3BhY2VzJyBzeXNmcyBl
bnRyaWVzOg0KPg0KPiBIb3cgbWFueSBJTyBxdWV1ZXMgYXJlIHRoZXJlOg0KPg0KPiAgICAjIGxz
IC0xIC9zeXMvYmxvY2svbnZtZTBuMS9tcS8gfCB3YyAtbA0KPiAgICA2NA0KPg0KPiBIb3cgbGFy
Z2UgaXMgZWFjaCBJTyBxdWV1ZToNCj4NCj4gICAgIyBjYXQgL3N5cy9ibG9jay9udm1lMG4xL3F1
ZXVlL25yX3JlcXVlc3RzDQo+ICAgIDEwMjMNCj4NCg0KRm9yIGJsb2NrIGxheWVyIHF1ZXVlIGFs
bG9jYXRpb24gd2hpY2ggd2lsbCBoYXBwZW4gd2hlbiB5b3UgaXNzdWUgY29ubmVjdA0KY29tbWFu
ZCBmcm9tIGhvc3QgdG8gdGFyZ2V0IHdoaWNoIHdpbGwgY3JlYXRlIGNvbnRyb2xsZXIgYW5kIHBv
cHVsYXRlIGJsb2NrDQphbmQgY2hhciBkZXZpY2VzIHNlZSBiZWxvdyBbMV0uDQoNCiBGcm9tIHdo
YXQgSSBjYW4gc2VlIHlvdSBhcmUgZ2V0dGluZyBudW1iZXIgb2YgcXVldWVzIGZvciBib3RoIHRj
cCBhbmQgcGNpZQ0KTlZNZSBjb250cm9sbGVyLCB3aGF0IGlzIHlvdXIgcXVlc3Rpb24gPw0KDQpB
bm90aGVyIHdheSB0byBkaWcgaW50byBjb250cm9sbGVyIHNpZGUgZmllbGRzIG9yIHF1ZXVlIGRl
cHRoIHlvdSBjYW4NCnJlYWQgdGhlIENBUCBzcGFjZSBzZWUgdGhpcyBmcm9tIHNwZWMNCg0KRmln
dXJlIDM2OiBPZmZzZXQgMGg6IENBUCDigJMgQ29udHJvbGxlciBDYXBhYmlsaXRpZXMgOi0NCg0K
Ik1heGltdW0gUXVldWUgRW50cmllcyBTdXBwb3J0ZWQgKE1RRVMpOiBUaGlzIGZpZWxkIGluZGlj
YXRlcyB0aGUgbWF4aW11bQ0KaW5kaXZpZHVhbCBxdWV1ZSBzaXplIHRoYXQgdGhlIGNvbnRyb2xs
ZXIgc3VwcG9ydHMuIEZvciBOVk1lIG92ZXIgUENJZQ0KaW1wbGVtZW50YXRpb25zLCB0aGlzIHZh
bHVlIGFwcGxpZXMgdG8gdGhlIEkvTyBTdWJtaXNzaW9uIFF1ZXVlcyBhbmQgSS9PDQpDb21wbGV0
aW9uIFF1ZXVlcyB0aGF0IHRoZSBob3N0IGNyZWF0ZXMuIEZvciBOVk1lIG92ZXIgRmFicmljcyAN
CmltcGxlbWVudGF0aW9ucywNCnRoaXMgdmFsdWUgYXBwbGllcyB0byBvbmx5IHRoZSBJL08gU3Vi
bWlzc2lvbiBRdWV1ZXMgdGhhdCB0aGUgaG9zdCANCmNyZWF0ZXMuIFRoaXMgaXMNCmEgMOKAmXMg
YmFzZWQgdmFsdWUuIFRoZSBtaW5pbXVtIHZhbHVlIGlzIDFoLCBpbmRpY2F0aW5nIHR3byBlbnRy
aWVzLiINCg0KLWNrDQoNClsxXQ0KDQpGb3IgZmFicmljcyB0cmFuc3BvcnQgKFRDUCkgbnVtYmVy
IGFyZSBxdWV1ZXMgYXJlIGNhbGN1bGF0ZWQgdXNpbmcNCm52bWZfbnJfaW9fcXVldWUoKSB0byBt
YWtlIHN1cmUgd2UgZG9uJ3QgY3JlYXRlIG1vcmUgcmVhZC9kZWZ1bHQNCnF1ZXVlcyB0aGFuIENQ
VXMgYXZhaWxhYmxlIHNhbWUgY2hlY2sgaXMgYWxzbyBhcHBsaWNhYmxlIGZvciB3cml0ZQ0KYW5k
IHBvbGwgcXVldWVzLg0KbnZtZV9zZXRfcXVldWVfY291bnQgYWRqdXN0cyB0aGUgcXVldWUgY291
bnQgYmFzZWQgb24gY29udHJvbGxlcg0KY2FwYWJpbGl0aWVzIHdoaWNoIGNhbCBhbHNvIGNsYW1w
IHRoZSBxdWV1ZSBjb3VudC4NCg0KbnZtZl9zZXRfaW9fcXVldWVzKCkgc2V0IHF1ZXVlIGNvdW50
IGZvciBlYWNoIHF1ZXVlIHR5cGUgcmVhZCwNCmRlZmF1bHQsIHBvbGwuIHRoZW4gbnZtZl9tYXBf
cXVldWVzKCkgbWFwcyB0aGVtIGludG8gYmxrLW1xDQpzdHJ1Y3R1cmUgc28gdGhhdCBkZWZhdWx0
L3JlYWQvcG9sbCBhbmQgZWFjaCBnZXRzIGF0dGFjaGVkIHRvDQpibGtfbXEgY29udGV4dC4NCg0K
T24gTXkgbWFjaGluZSBJJ3ZlIDQ4IENQVXMgc28gd2hlbiBJIGNyZWF0ZSB0Y3AgdGFyZ2V0IEkg
Z2V0IDotDQoNClsgMTE5Ni4wNTg0NDBdIG52bWUgbnZtZTE6IGNyZWF0aW5nIDQ4IEkvTyBxdWV1
ZXMuDQpbIDExOTYuMDYyMzcwXSBudm1lIG52bWUxOiBtYXBwZWQgNDgvMC8wIGRlZmF1bHQvcmVh
ZC9wb2xsIHF1ZXVlcy4NCg0KeW91IHNob3VsZCBiZSBhYmxlIHRvIHNlZSB0aGlzIGludG8gZGVi
dWcgbWVzc2FnZXMgdGhhdCBpcyBjb21pbmcNCmZyb20gcXVldWUgYWxsb2NhdGlvbiBoZWxwZXJz
IHJlc3BlY3RpdmVseSB0aGF0IGFsc28gaGFzIGNvbnRyb2xsZXINCmRldmljZSBuYW1lICJudm1l
MSIgOi0NCg0KbnZtZV90Y3BfYWxsb2NfaW9fcXVldWVzKCkNCm52bWZfbWFwX3F1ZXVlcygpDQoN
CkhvcGUgdGhpcyBoZWxwcy4NCg0KDQo=

