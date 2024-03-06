Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA947C5475B
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Mar 2024 06:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SvB0h/3kSiv4QupPNnnmzC1YdcLdu3lpLZ5sA9nhM6M=; b=Eri3O/Ah3Hlbbm+WuT9ibYf0QO
	AeBizAg2h6hWUB2xmZqLQ7KemDlXmwSkaKBXxuUNI1bT+dlGlxWOVx521gzkWC7KhWbIBTQ2oP7bO
	1G4+PfSYlw0N7WU28vYWv16FwUXTYv+f2R72I+J7dxisLrkfdjqhS4LY4DMsnSfj3gFtRL/6bTupk
	IKQ3tNZkvaLGdckZPyAPQmAS/0bj8WlUc2kGhtChj8WN2+q+G3zZUClRH1JA0vLtHz68EEOKfOK7/
	BChIyx47qmEutQhyKWsyv4KpgwgssKHeqaLRbc8akxTdDyppBKdRxDiFbwIlT+0B3yK238RPnlmkF
	JyKEoY+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhkt3-0000000GZaL-25JE;
	Wed, 06 Mar 2024 06:36:21 +0000
Received: from mail-bn8nam04on20601.outbound.protection.outlook.com ([2a01:111:f403:2408::601] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhjlN-0000000GNZ0-2HKq
	for linux-nvme@lists.infradead.org;
	Wed, 06 Mar 2024 05:24:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LehUERMi92qnKdAbL6kbDiZIrin3FqSKDGAIg6KXMbCOxcS+J/0/PIwPoJHZ52rZkqy69UCEcCDEA+YovD5eZp200ZV/6V3y7JTPB3pcLsbPSylOQx/BMPcwY9v7G4NpRHZlsOS4Y4hvg1XFKS4Z3/4fFeDPADv7lu0IsTrniCzogGFXhNqHmMhnFJF+IS8IuH0yASu1j4B1viLXTI1k5U3Fnetib/cjtrohD/Dw4T0KKYQLC6is92pz+yGFoUOVabVEZBYAUlVNEs7JPr71/QQWvw4kjoaQ3BiyCQACEpJmAPnXUpgLcCIw9bykBEHoJaerq8DHErL6qIPF/1IVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvB0h/3kSiv4QupPNnnmzC1YdcLdu3lpLZ5sA9nhM6M=;
 b=OX3d31v+6AY92AfozzXfCg0kcxpI+N+VxTXjJ/AlslnNU/Yz+wzQo5pnlnZu7dvqefGxR1edkAsguF/o1jz3nOnOiKySrCDrEVB0m6ODnb63GbM1l2t+qOVIRxJd06wl+54/bdctMWtpd1jL79eOHNW+igDXsamS8mNwvoyhdTzXql+bgg2qYvMO9xFgyrvxIEV8oYLL4TAE0w0D6ZzLmJvZ0hjqJiFVskLW1QxkMbLCWvYGy00bcXaog/7Sgv33BGPYjaTzmHbDyiUqfKLiYbBBO3vqSMjUexkxWukaBHlN6xnjFihagwxUyy1LIzm7uqXpCaJqZAJEBl2NRzdKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvB0h/3kSiv4QupPNnnmzC1YdcLdu3lpLZ5sA9nhM6M=;
 b=rvBYVAKMyrJJK+VtFs5IfsfMVUS5YdVcYNefE0IE2Ke9NXI2KTgKCEHosoVX/G6sA5jDjbnJ0GuWKIG3XCjfUxOVm8s2f+4VEsb0klLeTTEKZIjUxcjGKVxvX45MDm3ULK+QWYkf86GgcufPcOgtVcYRP/y8fr3rFFo1ea2fAgRjClYJ/IixP73sgydof2dwXZxyzw4mNOrFG5W1Lhpsk2vCf3a5UxdHcTM1Mk5OZsGaQPElH8Y4xmt+PsLQNWjS+8OCuyhpU37009UvM4SAQZ6vtN/NO7cRzvvh9uAmQc6SSA1Enou7CgPGD0mv634Xk770xVlIgdyEatiNyh9rkg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 05:24:16 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 05:24:16 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, James Smart
	<james.smart@broadcom.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] nvme: fcloop: make fcloop_class constant
Thread-Topic: [PATCH 3/3] nvme: fcloop: make fcloop_class constant
Thread-Index: AQHabv9QM5elmmjzN0Sp18o2kL4HQLEqLxEA
Date: Wed, 6 Mar 2024 05:24:16 +0000
Message-ID: <fa1cc224-d2f5-4eec-9473-e673e8cc5b9d@nvidia.com>
References: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
 <20240305-class_cleanup-nvme-v1-3-c707fc997774@marliere.net>
In-Reply-To: <20240305-class_cleanup-nvme-v1-3-c707fc997774@marliere.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB4431:EE_
x-ms-office365-filtering-correlation-id: f8fdf668-532d-441e-7b95-08dc3d9daaf4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F9qrABA2k9Ll7qrRkiVsyY3/eG9rhFVqeZqT1m/a5++mBFl8McksQXtZSCIzYyJDQmU6Le0dyhmmajDdzjy0iPBLImZcUEGLoLleQdKJJn5E0KkjGI6dRdcgphlKvlAWI0NSm2x/cSxNfhhrwnmZiBEDObbcEkHNW8BLPocYOdlTzh+3I1L/mrVE2kIegvXYUM+gwox3iK7LiJN0BngdOuyzubv4gU6GJcDH+3otmYPIlSrI3e03a6e3WeV0IyR14gmQ86HJYr2XNvIPsZsUu2aLLVIEjM6glvmb4SWg+FOqxrCp5t5JYGWvLgABf1r8gAXUcZNZ2xrDd9mXM6nA2s0FBeOA0wCNX579BCBMiHa8uuFLjQtFhPfBWEe5FrMzBs6ZjzYN8QGni8WFhJ879Kfhdc8HS7LolrfVn5JDYRmNIx5kAcu5/34TTL140onhs6UtFpbYXAyhJ13lRyQcADPDF7EQiplGQ3qxkdQH/osgj0gWd6bNCxGxJKKbil3Hhp5LG51D/9j+BtYTqpe1Ip2pPNG8OrWg3TWGFz25rB6v5Whpn/tbZ2/DO8NGr20nqa6YDDKIyYXlkgYZSBwa+7ejYOaui3NVRBM13qVs79VtPDtwiuwwifByX+At9SHeBnInP4BVfb8Iem3stQcy+M3rl1iu1P71cg46+IocV1sM9D2l7JQD3VUPh9PwBijaQprn+Z5GfHGwtI7ic8f4JLnyvxotQ1C7hPt76QL9K9Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXRWM3V2U0wrU0xPMU54WTRqSzd3ZEpvQnV1NmpQK1JqaExLSmJlNGoyV2hr?=
 =?utf-8?B?RGkrbTM4Q2QxWi9HV09iZS9EcHRZTEpZejltazE3cnJxN3JYdUM2WWhkTEpC?=
 =?utf-8?B?VFk3VVhveGNpVDlpeWdzbG1EL3d6UmsyS1dWNlFvYVdhSXdERVpOQkVFN1Fm?=
 =?utf-8?B?cThzdmY4cnVaL2lsR3pxRXNOK0tsUDk0RzFmNWRUa1JYRWpNMGdlL3dhandH?=
 =?utf-8?B?dzBVN1A1cTZjZ3pxdTlIQ21EV3hEcURXNkVaZXVBZk93Y0swdE1veWhIenRo?=
 =?utf-8?B?VS9lTEFFaFRmaFFKVkNINENic29MeHZWRERnUllIN3RSaWNsbU54U0xMckdj?=
 =?utf-8?B?NjkvN1pGRER2OGY4aitnWkFQY280Y3VmYXJSc2Z0NTJqT3hXZWh0czF1NkVh?=
 =?utf-8?B?aTFCdWtiV0RVaiswV3BmMnA1U3k1ek1nQmM3VlJoRm5lZFZ4T0Y3bEVDTjli?=
 =?utf-8?B?R3V5L1hvYjErYkQyUnBZVXEvQWtaQ3ZRbmlvM0FvTE1TOXpCVnl1RzAwVU5E?=
 =?utf-8?B?M0syZ1c5Mk0vbVN1QlM1UWsrWXlHSDM0aTlJNkhmeVI5YzFnTFV4Vm5GL3p2?=
 =?utf-8?B?Ky8wREdXdzIyWkFGekFMdWlENEZPcTRPVWFMSDkyajRGV01kYVV6aXF5b1VY?=
 =?utf-8?B?ckJ3QSt3RnFtdDNuZlJBTEFzQkN5RVRsKzRpUWVIRngxbWV4cjlaNHhkVnRE?=
 =?utf-8?B?cURPb1duejF5UnBneFUyRExoVm1UL25jQkg3NmV3UTRmRG5KeXpxRDA1T0Vk?=
 =?utf-8?B?MlRmTXRacWVjK0ViY3pQTk9tc2ZzeVMxQWlZVzBnTjJITGNDSUtPZkdBSTc2?=
 =?utf-8?B?TnFDczVKVWdhN0phZFZYalRtT29Xd3c3U1JzRW5LaEorTUEwVFFaSnRvZ3No?=
 =?utf-8?B?VFFhQk5MT2VmUVk0SzJRcklIOHhlYStVbVhKL0xOYVhZN3dGVHRsNmpNWGRy?=
 =?utf-8?B?ZmNINVNSaDFMd204cE9oVERnSWR6WitCMXRFbXhsZm5pTDhWV3ZlUGFWYzV6?=
 =?utf-8?B?clNYUlhlK0pMUjRzcko5U3NxMmNKTnhYYVhSbkZ2R0VHS3JlU003UGFlaDFT?=
 =?utf-8?B?Y1JXcFdYTmNGOE9VU3I0amZXQ2V2NmtGMjRRTmpLb3dmQXAxbExnMlVmcmdo?=
 =?utf-8?B?cHZjREZsdSs2QjVNQlFSWk51T0VaZG9yTnlGNVQwNy9BYVpUdmF0QTcxeGQw?=
 =?utf-8?B?Sm42NWhyTk4wMXlpYjUvZXJYaHdWMnRURTZlSmp2NUdDeW1ibGc3T2lKSnVv?=
 =?utf-8?B?YU9QWnZhVFROSHpaU2dPNHcreFlwZmczZEZTakVXdmlXVk5XTUxaOThjSTE0?=
 =?utf-8?B?VFl4M1ZoWE0zS1FtazFCZU84TTZ2Zkp3YmJtOXQrTjVxaG1qeFNraTNvbk5h?=
 =?utf-8?B?SHF4bXhNRHVKQ0k2YnhNQUswemRORndqR2c5OEFqTHpGU0dXN0lkeFRaLzQ3?=
 =?utf-8?B?bXEvZG80T3d6dzh4RnBtbGdwWDdES0x5RXIwMDMrcXhKMlU3ZHdjQ1U5NE1j?=
 =?utf-8?B?K01EWnZ5UDMrWlRCbkZ6dm1EN0c5MlZwWWZnUEk3Y3FRYXRDWVZaMFdtbmgw?=
 =?utf-8?B?VzJzK1NldnptL0t3VVk4MmswOXZ1V1ZGRHB4Z0pGaHhRTWtBYzZkQ1FMY21t?=
 =?utf-8?B?WjVXRXhDVUU5eXJrMWN4SHpVYlBzWlJXMzlETkkvRGMzelN3YnE0c1dLNW5Q?=
 =?utf-8?B?YTJOdlhMYmZrTWxDb1EyUXBEMlpjOVR2bXRsQXdCM0RMSzNtbmJNd0JHUjIz?=
 =?utf-8?B?bjB0Vis1QXVQdnFIazVkZW1IdVlqVm5XcEZpRU10RXNGRG5ZYnBGRThadFZE?=
 =?utf-8?B?RUhXV2lpQU4rY3l6Q0xkQ3BGeW1OMnB4WHowdlhhNS94Q3hFM0d0YmhwYjl3?=
 =?utf-8?B?Qndubnhwa3FhWmQzNGZ2Wm54c2RwOHpCZUlialN1NXpTZ0pzUGJKZ3Nianhh?=
 =?utf-8?B?aC8vZUhLa3FpVjFUZ2crNG94YVh2NmRkd1g4VkpIayt2OFYyZVRGSlcvdlJD?=
 =?utf-8?B?eHkzSmt5Y2huWldqczdkSXlqQm1zcmlSdGkyTnpjMEZKZWdGM3J5STFJYjBX?=
 =?utf-8?B?QjJsdHo5V3hUYzZWbFBRRUlWaDJZNHpJR09YaTV4Z2tEYSsxNXZxREZneXVL?=
 =?utf-8?B?Ynp3aEJPZ0dwRk5ZWFJRSUNKWUlXM0dzWHZKai9iRzBRRWpnSDk4Z0M4WVpu?=
 =?utf-8?Q?FpUQ5BYMFCILjmiKCgdh/+vQ+Q2c6tDlPjAe9NqYV0Vs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <09D935114323CB4C82F9D3F3CC6E02E2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fdf668-532d-441e-7b95-08dc3d9daaf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 05:24:16.6557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSevipmAvEN8iVctx1nYoVETUfrv0/zYoAzvLgc+rCYaKiVQuSDqtT5A4yTpBmASaZmUtmJL97vmJUxrZ03f0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_212421_767586_CA052E72 
X-CRM114-Status: GOOD (  11.01  )
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

T24gMy81LzI0IDA1OjE1LCBSaWNhcmRvIEIuIE1hcmxpZXJlIHdyb3RlOg0KPiBTaW5jZSBjb21t
aXQgNDNhNzIwNmIwOTYzICgiZHJpdmVyIGNvcmU6IGNsYXNzOiBtYWtlIGNsYXNzX3JlZ2lzdGVy
KCkgdGFrZQ0KPiBhIGNvbnN0ICoiKSwgdGhlIGRyaXZlciBjb3JlIGFsbG93cyBmb3Igc3RydWN0
IGNsYXNzIHRvIGJlIGluIHJlYWQtb25seQ0KPiBtZW1vcnksIHNvIG1vdmUgdGhlIGZjbG9vcF9j
bGFzcyBzdHJ1Y3R1cmUgdG8gYmUgZGVjbGFyZWQgYXQgYnVpbGQgdGltZQ0KPiBwbGFjaW5nIGl0
IGludG8gcmVhZC1vbmx5IG1lbW9yeSwgaW5zdGVhZCBvZiBoYXZpbmcgdG8gYmUgZHluYW1pY2Fs
bHkNCj4gYWxsb2NhdGVkIGF0IGJvb3QgdGltZS4NCj4NCj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1h
biA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFN1Z2dlc3RlZC1ieTogR3JlZyBLcm9h
aC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTog
UmljYXJkbyBCLiBNYXJsaWVyZSA8cmljYXJkb0BtYXJsaWVyZS5uZXQ+DQo+IC0tLQ0KPiAgIA0K
DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K

