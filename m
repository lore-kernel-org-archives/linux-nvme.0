Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC54D609AD
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Nov 2024 08:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6YcBg7S3cs9r/xmeOmzP0U1NhvIEbNBDcGVk5dJtfE8=; b=ESZK+hqcn5JkUr0lJMb+Of7O0o
	azBaSY6AF/9UDMA7pHKg68yefj2ftfcdoUisP2EBnU/y71kL46UBhlHgXJ953ghGMfuUPBEGTpMGh
	NAC3u/NrZxffV6RYye0cAlNdn4AYaE3fg7THfZisaZhLI8FNjGeIxvbUuTeRPM4ueaY8TpQYRlkmD
	u9sNJqFEQL2CGoOVbNeGPrr6kLj/hIZE5xp5mlIhZ65sphmJ1hk4rVaCklOlTegz5gsr6iGZ6PlyZ
	v5IDJjDuDXKbA2ACL5Kv1rk1Mp7pW6uaSSPuEjMgULYRQHI4bYtY7zjFuIo0fgHdLUlLrFhNampOx
	Gq9T5m+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGD5I-0000000CXB8-27dr;
	Wed, 27 Nov 2024 08:07:40 +0000
Received: from mail-dm6nam12on20604.outbound.protection.outlook.com ([2a01:111:f403:2417::604] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGD1H-0000000CWSS-0Dqs
	for linux-nvme@lists.infradead.org;
	Wed, 27 Nov 2024 08:03:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+7fgaDvbgGvjsmiK21u2CfbSkLTaEH0pZUetr6Q40Suv/NuuRMljmY9tK+SjlMUM9ISj37bjz1sc3/OPIBXPnkada402bzkVNiS52CidPabyl1jqTMNsSDW/N/4fR7Nv/6nI8to8ACWZ0XTgtWEo50xBihdNXHabjK7n6OaVKUONfv+LctOBwntw/DQX0xXW5RhSP5Qz8MdjQ1I47FwUWgtGcpPGTvjDv0Mx++RIxdRhXSd07Ie5ow294FOf8pgtrUJsaRt0lQkqSywa4ylSp1qjMuz9EBP7MwfyMVGKFXV8GoWkVTlp/J5OEMU1mfZgvfUTksCMoftmM7QwhvyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YcBg7S3cs9r/xmeOmzP0U1NhvIEbNBDcGVk5dJtfE8=;
 b=b7vjUUsX2FfsK0LIb6Au61s77/JX5ofUr/C0xaBp779FPL0D+4ZRv8NH+zrFo+mKNKU+nf/CkS0AmeQd9BjAQlCgHXxK/xJ9kB0+OqEo28Uw5S/A4pqTaYnHXBMJeY1Nt5ptgexNV5GWK3Bbza1S0X/YbixcOkYWPa0Hw6sv6ejBd9nXh1Qi0s4wZJMpbTPStWpu1p83xzimewAGltNt08VRRleXxeDeaITFRagV07/u6kbFZLi2fZDvtQKZyn1fjneTE7gXKlhoGUpDWIabE+SbSxJd0H4Lkn6mgfs+cMZ27sv2EglKg3cXjWj7MhT6Lsqv57K73F6L0YQekCafNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YcBg7S3cs9r/xmeOmzP0U1NhvIEbNBDcGVk5dJtfE8=;
 b=VKzL9Z/y0kbJ11kReSQ0VYmXt+ohVmyT2Ons3Zm6fuo8/EtxoeVTWwOIxpRR/Edvf4iFJLFtdBIb4UoEQDboSu/h5wPCEM2pRuN7wFVw97rgaZuHvb/ZiJ/rYHwuryct2xUZIrvTuB6LIJlEluomzurSwSlyIlE6TrffRyvOxpSbi99jEOkO8eV5TWWPJ3kOEFnQuohQ77gsi96int1YvHBAPhTS4oq2O0OTvMnjhWAjHLlXpGh2rFvvZm/npsNwix+EA0wOEs8lbx3CASxpnVttKju77McbeX4D1eIDcAIKotlPuqyyOKztG0NTi8q+enAuMRIpY71KyqPpaPNj7g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM3PR12MB9325.namprd12.prod.outlook.com (2603:10b6:0:46::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Wed, 27 Nov
 2024 08:03:24 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.8182.018; Wed, 27 Nov 2024
 08:03:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Jens Axboe
	<axboe@kernel.dk>
Subject: Re: [PATCH v4 0/2] Introduce service-time multipath policy and
 document
Thread-Topic: [PATCH v4 0/2] Introduce service-time multipath policy and
 document
Thread-Index: AQHbPyY+LO7bXIaZDEiDufxdxppk77LKx1YA
Date: Wed, 27 Nov 2024 08:03:18 +0000
Message-ID: <f0b1f299-7342-46af-a26a-9488996dad9f@nvidia.com>
References: <20241125103848.67212-1-kanie@linux.alibaba.com>
In-Reply-To: <20241125103848.67212-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM3PR12MB9325:EE_
x-ms-office365-filtering-correlation-id: 9089cc32-6cb5-4fe0-fd2c-08dd0eb9f468
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?enJTaVpkeVNkNE5vZDhISEIwMldodCtoK2tkZFRMb2dLa1NpZy8xY01KMGpv?=
 =?utf-8?B?VkFadGxmbnNWSHhhcklYNmE5U0dzc0RrNmJjZFVkVFhBUHViQW1GRC9SeWN1?=
 =?utf-8?B?MldDaTE2SHNNS2V5K0hnYXJaQVpFTG56V1VINUx2cWd0bU5tUlJ3M2I3L3dS?=
 =?utf-8?B?VzRPU3RSd3o4WElnZlBWMWl1MzQ3OTlnNDJxT3Yvbk1DTTczNjllb2I4bXYv?=
 =?utf-8?B?dlU0M1VoMURzaldrSXpOT09aTGduMURFa0hTTGtYUWxhRUlEc2dXRi84Rmlr?=
 =?utf-8?B?T2ZtU2UveEZOZHp3cVVlWWhGbU9UWVVqYzBxNU5sV1g4OU80TC9BSEtsWmtT?=
 =?utf-8?B?WU1oWHF4bXVsdjNTUUdDVG42OFo5Sk4xaDZKNkRpUTFYN3dhalF3UERQaFRX?=
 =?utf-8?B?RE1yVnRvbkZ2QkY5VFZHQk9ocWg1QlRFQ2VGd291L2FhWmxaYld6bzcvS3lE?=
 =?utf-8?B?SWFEdDdRamgzMEJ6eGNKYlAyUzI3OEp6R0VvMXJaRkdQeEdJQ0wxaTVPU1NX?=
 =?utf-8?B?SEQvcTdMcHRmUVo2NC8rUjFnU1JHcFZsdENhT3ExU09zcWlhQURqalp4V1U0?=
 =?utf-8?B?WE5FY1JoZStueTk0cnA0NGJ3RC9OT01OU25jSy9JQklpS1dSQlJKR09OK2FV?=
 =?utf-8?B?OGlnZm96TkxHeXBHOGlneC9nTjZXaGVSNkRUWDF1THp0MTE0ajVHTUlxUlpu?=
 =?utf-8?B?MHJ0S1EzS3NITWhzRjg3cExZbVNhMzBiY1A5YjRnU2ZxdklsVlE1UXl2UmFt?=
 =?utf-8?B?T1JZWmNaUXBsRXA0MDlLdUJDczBRN2NRSWdHTHpOTDM3Vjh5aE5ZVGZHZDhN?=
 =?utf-8?B?T2czSDZPNDJnZnE0d2RMWVpOWjBOd2ZFd21xdlBDQ0xyV3AxRHJ4a0hrbHRR?=
 =?utf-8?B?ZGlFVlJwcG16VXh2MHJUQ2dnaHFGTXhJNjZVTUhnZkErTkR6UXR2VW4zSGMy?=
 =?utf-8?B?UGJ0dEFNSmZNQlJ2cWpua2ZqZFBKa2ZwRUlIVE5NanpjLzU5aDNxQ3E5TE42?=
 =?utf-8?B?NmpsaTJFMjluOTFrZm1HbzFSYXpsTWNLS0JLMzFWVUR2VmdJaVVPVHlaa3NZ?=
 =?utf-8?B?Skh1VTBUQlJwNjJGWUFSS0lhYXVSYnZvbmsycUpCanhPNXhlVlBFUWp5L05M?=
 =?utf-8?B?dmVadldZL1p6OVRQSzFlempRTnAyNVhIU1F4ZWUzMmRwT2NQQlFlTHVIODhu?=
 =?utf-8?B?ZDAxSEpBbnpRa0VldE9lMlk4QnNoOVo5Y0ErQnUwNy9uQUwzbEMxaEFEM2Nw?=
 =?utf-8?B?QnZvWnZNdFNZNWFNcDJUYzAybTZZNTZPRGZjOUw0QlhIVWhSK3dXTFBOcmZO?=
 =?utf-8?B?K3p1T01xTkFvTElwRDZFbDdPcEVOWW1memZqZlJKMDJydkYxZGw0RE9GWmYw?=
 =?utf-8?B?R2pnSFRwWEVlRHYwOEpRczExekF0SElka0JsNC9zOXJmWW1aTUVMdkZ2ZVpx?=
 =?utf-8?B?eThTeWhKUGZZbi9rN1VSU21GUVpiOFd6dXlGeEIrVllaemJGMW16Q3ZteFNr?=
 =?utf-8?B?MDkwcXFTekhHWVNFMGlOYWpDZm5pd3Avd1QxN3R4clBqdHBZclBYRXcvSEZN?=
 =?utf-8?B?N3JTamtkeU1OVE9oNlQrcUo1NXpGMWliT1k1eDJxRzFKaTlIVHdzZG9Rc2tX?=
 =?utf-8?B?OUY0cjlEYSt6L0o5VUhJcktId0huMDI3bXZnQ2YrYkw0cFppYWQwOURDek1E?=
 =?utf-8?B?QlF2cHdrbnhNdThRa2ZpSXdwejhHOE9jelZJRVB2SnhJQllqMWlSS0tFV0Yy?=
 =?utf-8?B?Vm91NlFteW82dXo5VE1rVWNsbXVDc3hzQjZKTElHUHh5U1c1c1VJM0FwMC8r?=
 =?utf-8?B?aWVYZG9WMmEweGpMb3UxUHFwRHNRaE8vcUJvcXlQVFdxb25udVFteTkzUHJn?=
 =?utf-8?B?QVhZQkFRcHY1QitJVnBEMTN5VG5XZkxBY3hoS3E5VUdpNnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkNwTG95RSt5NmhCUGN0dzhwUFFHbW5NcUlXanpoNFo5dUJHQ1VNRndVK2Fy?=
 =?utf-8?B?bXdCNW14YWFVbkdROEhINFJVUDVNSEdnMVh2TUk1Zml4Ym5CbERqVGJvNThx?=
 =?utf-8?B?bGZMYUVKQit4VWRKVXBnSmV6RkpwWUk3Z2VkNVY0QTlKSUlPN3owT3MrTlho?=
 =?utf-8?B?QmdTZmJabTdSd0F0UklIcm5rUitWRUVMSEtNcUIzTW9mMHhONGE3OHZablA4?=
 =?utf-8?B?Qjg3MXYvTlJtM2l5azN2UEJDeVU4RjZwakJLbzZlTmQ5dHBuSmFaYkhjOVRs?=
 =?utf-8?B?bCtuY1RmQmlyMlk3NFlqdDJsalJlOGNnYzBIb2x3UEVtamNyVUZXREVZdlc1?=
 =?utf-8?B?SERBbkluVDJ5d1hZUHZUeGJEU2s5dU9CZDFGVlBnZXdWaGFFcWtoU0l6TEFN?=
 =?utf-8?B?NUZtenhXYnFIQlRjMVBoTG5lcGEzS1RMa3NTUkRLWlJlQVZWYy9EODFJbE1S?=
 =?utf-8?B?KzZaQ25KMVlIL2VGN29JbDlCN2N0RnJ3WFdUbFNQYkdCa1lQUXVJUGNONGNP?=
 =?utf-8?B?SGN1S0lWcStxZUlBbVZVWXlEUEdVRStUVHdxVVlncEhlODZtZEZ6Q1N1Wnl2?=
 =?utf-8?B?NG9xdXduNmZRNlhoVStQaUF4YU52MGNmZUM1NjFTdEh6QjNEOE5zK1lYL0hw?=
 =?utf-8?B?dkNCY2J4UUhIcWwxNUJHSndNMHU0RGQ2Y09XbHh4WkFBTnFSWHFjM3hRWHI2?=
 =?utf-8?B?S0dRZlZXVm9maldaLzQwcHJtcThXNkQrQ2lvb1A2YUVSaXphLzRMV2h3bTJv?=
 =?utf-8?B?VkRVZGliVnFyVkVhNG1QWWJTdGhIVEFyTkY2Y1A5SE9LQk1rRDNOTUdvU2tw?=
 =?utf-8?B?UmlOa2VTRVZDcnQyaGhORzFZOEdVQmhNK054Y3NsRUp3SGZYM3FZcFJkT0V1?=
 =?utf-8?B?cmM0RWlyUDRMU3dxVHZOVnpzcUkzaXNXNk5lS3oxU0xpR1k4MjF1cDJ4Y01D?=
 =?utf-8?B?U3FYYktuU3UydkExTGZYVHMwSlQ4akJwT3BBZkQ3MFhkbXVnWEZRV0ZoSzVk?=
 =?utf-8?B?aGh3SlM0KytxM1VXd3d3RGZCZWMyRGpRZDRKNS9IQTNPd3FxaTJQQU9sM1NR?=
 =?utf-8?B?cTFwYnVaNFBadURLSU0zMTVWejh3RUluWTNIZVFFc0dacFg3ZkVrTVUzMnha?=
 =?utf-8?B?R2pxZ3gzMVpvdFU3Q2ZFbmkvS0FZR21XeHYzTnJNUW5KU2FOK2o3RXJ0YmNX?=
 =?utf-8?B?Z21FSW1HNldSdVNaem9LRHl5K29aK3UwaElCTjJqT1RxeHdER1FsRFhLbGlY?=
 =?utf-8?B?SS91R1dSUWhaS2ZtMjU3U1BheWtQbEZrUXUwajQ2ekh3Qmh4QlZZMFQ3L0h0?=
 =?utf-8?B?c2xQSXQzd3QxY1FvWHpwc1BKRWFEbzlBOTBqRUJtVFdyQ083Wmx2bVk0Rndj?=
 =?utf-8?B?b0hpVEt5eVY0Z3ZJd1JPbjA2ZXZ1NDJER0pCdGpoTnJKZFg3cFI4QVVXUkxH?=
 =?utf-8?B?N0NtREt5Vmx4VDJLWmhlbTVWOUV2L0NYK20rVWUzaEhEQW9kVjh1dm44dkpD?=
 =?utf-8?B?TkRpbEE3T1JIajRlR3RlN2owekFQZFVvOW03TElpUkdBU1Jsd29zRlRRSEVK?=
 =?utf-8?B?QkFoRGc3MFB1T2lOU2YxRUZ6bXNmaklDMm1hUjg2MWV0aS9YZW10VTJWMDRU?=
 =?utf-8?B?bXJJckhJMG5KMHY0c2ZaOGpRZk1MOU10ZFVQZkRJSGhFQXhWdTdndjdLQkhj?=
 =?utf-8?B?VmNyY2VHblo4L29XaXJzZGJZWWF3czNERkd3anpKaFVNM0VFTTRSekluVnhY?=
 =?utf-8?B?cURDejJVS0xZOENiWkhmLzdSTXV0SGFuOEZ0WVA0eUV0eURZN3ExSmVjd21T?=
 =?utf-8?B?U3pzM0JTQnFIWEoySGRGN2xVNlNsaUpxS2FMVWlPSUhHbWJDU3dNNmNPSFdy?=
 =?utf-8?B?MXViKzJOa0tWaSswSy9VakhrN0NGSDYrQlBzQ3kySFRud1gxNmwwTjcvQkZV?=
 =?utf-8?B?VEM3MEdtQmhxd0ZOc09yV1NLaUZaWTlKbVZ4eEhZZHMvdkc4VFRMemU3NnBv?=
 =?utf-8?B?TG9SYXYwbGJFaTBTOWFmMitIb2ZpWnNpazFtazZ0dTVvKzU0RHpHY21BYlBh?=
 =?utf-8?B?YnA1bUF0c21pM3lNcFlLKzZtUTJ1RDF1NGtKODhBb0RpeGphMEdTREZQSTgr?=
 =?utf-8?B?YzNoK3l6TzcyOXlRY1lYVENrV29XNkFnc0JOK004YzNmMUwyTVBnWnlvQUdo?=
 =?utf-8?Q?FzfLMAPd8qyLSv9G1sED0Pob/b6kxXyXe/vKkb9ZgX07?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3DDED04E287E38468AC7C1A6317F2B81@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9089cc32-6cb5-4fe0-fd2c-08dd0eb9f468
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 08:03:18.8478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8P0/yW2dmTacd6VL6vixI/MxRzUlT1jAiSmjH6CD7nXZ5Or67Xi5WdjyNwVM4mVwfHJihXRskQydcO4O/yJPnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9325
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241127_000331_089182_B8580977 
X-CRM114-Status: GOOD (  10.91  )
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

T24gMTEvMjUvMjQgMDI6MzgsIEd1aXhpbiBMaXUgd3JvdGU6DQo+IEhpLA0KPiAgICBUaGlzIHBh
dGNoc2V0IGludHJvZHVjZSBhIG5ldyBtdWx0aXBhdGggcG9saWN5LCBzZXJ2aWNlLXRpbWUsIGFu
ZCBhbHNvDQo+IGFkZCBhIG5ldyBkb2N1bWVudCB0byBpbnRyb2R1Y2UgbnZtZS1tdWx0aXBhdGgg
YW5kIGFsbCBwb2xpY2llcyBzdXBwb3J0ZWQuDQoNCldoZW4gd2UgYWRkZWQgYSBuZXcgcG9saWN5
IGxhc3QgdGltZSBKb2huIGhhcyBzaGFyZSBoaXMgc2V0dXAgYW5kIA0KcGVyZm9ybWFuY2UgbnVt
YmVycyB0byBqdXN0aWZ5IGhpcyBjaGFuZ2UgOi0gDQpodHRwczovL2xpc3RzLmluZnJhZGVhZC5v
cmcvcGlwZXJtYWlsL2xpbnV4LW52bWUvMjAyNC1KdW5lLzA0ODIwOC5odG1sDQoNCm9uIHRoZSBz
YW1lIGxpbmUsIHNpbmUgeW91IGFyZSBjbGFpbWluZyB0byBhY2hpZXZlIGxvd2VyIGxhdGVuY3kg
YW5kIA0KaGlnaGVyIHRocm91Z2hwdXQgaW4gdGhlIHBhdGNoIGNvbW1pdCBsb2csIGRvIHlvdSBo
YXZlIHBlcmZvcm1hbmNlIA0KbnVtYmVycyB0aGF0IHNob3dzIHRoZSBiZW5lZml0IG9mIHRoaXMg
Y2hhbmdlID8gSSdtIG5vdCBzdXJlIGhvdyBJJ20gSSANCnN1cHBvc2VkIHRvIGV2ZW4gdGVzdCB0
aGlzIHBhdGNoIHBlcmhhcHMgeW91IGNhbiBzaGFyZSB0ZXN0aW5nIA0KbWV0aG9kb2xvZ3kgYW5k
IG51bWJlcnMgeW91IGdvdC4NCg0KLWNrDQoNCg==

