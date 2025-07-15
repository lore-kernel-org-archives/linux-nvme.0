Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54676C83F27
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 23:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QTiMSww00WBryAetvzZPWXUtqDMAvyLJh+5JjGgQP08=; b=oAuoWZBcDurfbYJfVod95GR5Pi
	UaynVrKztxExFE0+96b4KLm4OimBg1BRXlKJVzj6oLXXiXoFW5n7TpOGxfa7PBv1ird7vUTAJPHm8
	iNRTvV7IikJN3rNlocwHQceBpPnJiRr9MZRFleI6L01ODBOM1ovHeD7r1e3cl4r6eSwmqnOD8MHWr
	L6obKBNj7MumRzfvjXo3lFWR4FdVkvnT0FkWHG+pXD9zbuN+bP1lsKN8SnL1Gsv+JPR9R0+i6vWJK
	vNJjVXf8Css7QtBF/2Df4CZDDfM7jp3aandzPoJSK0CuMh7UjoKBe/SmUpnvcamRcW+8CDOqMgwiY
	KUjbfFtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubowQ-00000006OFW-0kQU;
	Tue, 15 Jul 2025 23:20:06 +0000
Received: from mail-dm6nam12on2062b.outbound.protection.outlook.com ([2a01:111:f403:2417::62b] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubohT-00000006NBA-1awA
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 23:04:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngqkn35MV2h8gep4wsy/4kdqgb/G1W2rk09L7u+YckUtIyky38gE0t4s6g4KSqHRDxwKQ4PwgvfqZIT/vasaNxgD2pKyXaW8jl7jeAdUvzgo3M/GRXPDubykoOrIiFrXaM491v/5waWQ0e+OcXcMnxFVT/roifRdbz2JCcqCQRCXXcCRZ5aHVNpcIEBvQCUhgKIiRVZod6SfyIVUmmh3t9Tdys4dVJYNhZ5QuUmIK3UzKpfXojq5YbkvxKWH/h835Je/K76dx5GEUWZHcV0BwjylQpsMwx/+VcHuiRssaE7AfWCxV+tcLAV1hfp4jfDgknGrGOmfzWE9CGSNw+BKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTiMSww00WBryAetvzZPWXUtqDMAvyLJh+5JjGgQP08=;
 b=S7ZU0h3JfABk7ttRmVlEFj298s2aCIqMbUbeRwVcH/u6RQiw3hjzMFmV2+gU1ZbxtkLUqT7eNvmaucNj3w3Vj463Xca7i3D8R0l8IXAWHy2vjBYgZaXYa1+mDI2lcdVuZdQk0IeiAKE6aXpZ+t2FlNklD1bEp5iUR2/O2Ti3P5LDmTc3H/U6tMQwLRnsfivodJme9aYpdo6r+QC0wjG7eoKN+dxarUfSQsZUs7x9Ko4TjEN1+QCjiZIj511ao8Wb+NaGq1fGtl4YvwXBFJRh7x7g2BV9agjoiahT/VUxl9Jxh+2SX0ZjFxJJVVCtymzEg5SEW6kncvXwNrDyRqyvMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTiMSww00WBryAetvzZPWXUtqDMAvyLJh+5JjGgQP08=;
 b=Lh6U1QR7Py4O0McbrtUQo1gYwUx3rsj85+1OfiYvzPAVFxI6jixlDb+1ST2hqsNUsFEKTDeXq5/82GpAckCfG7zyDS/LR7bDzwwWy7HPwKJ7tV1MPHStspSuKKjXw22t7t3Dug9cODCfGbQRaoXNq+qj85tmLvWp2OtG519ysoo/upeSNfaFOLvuRTMZ/a1x3z2z27UVwV8fFtuPAUm5SyFQ+/+BchU/mB8U1SW92RMxPp+1mEsbjGCLXBytjw0YPnMm7Fnd020knzbc6eSGScQJnp7vWpmEHEax3qCCMnR80CJkPBM4Dsyl3rW4s0viVOd+rqh41X+WZovtT917fw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7439.namprd12.prod.outlook.com (2603:10b6:303:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 23:04:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8901.024; Tue, 15 Jul 2025
 23:04:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme-pci: try function level reset on init failure
Thread-Topic: [PATCHv2] nvme-pci: try function level reset on init failure
Thread-Index: AQHb9b0DNLhfeDkQT0iiPQkRXlVTGbQzzikA
Date: Tue, 15 Jul 2025 23:04:30 +0000
Message-ID: <6e7c48ab-0604-44e8-9f5f-09af7dc0e0ee@nvidia.com>
References: <20250715191627.3690017-1-kbusch@meta.com>
In-Reply-To: <20250715191627.3690017-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7439:EE_
x-ms-office365-filtering-correlation-id: 6b528299-9f73-4952-3cb4-08ddc3f3f4a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V3hDTFVRbFpNcjdraFludUdIemYrOXpubmxSNDRMSkV4ZWIwd0JhUDdmZk0r?=
 =?utf-8?B?U3AzakwzSjVqOUMwbmFFMEhBaU0rV01QRWZkWTN0d3YwMDZNR2FnQXlEUGIv?=
 =?utf-8?B?VmcxMWMwSlNuajBjL0FlVWk4aWxiT0xBekNTMzRDUHBJREVBTGhhM0h5d1FN?=
 =?utf-8?B?aEQxV3c4VGQ4MVhGSTliemZOT05xWnZOeEd0NHJLcEZXd3B3NktaQ3JUMUE5?=
 =?utf-8?B?OVJKUGRudjBUbjNlY3ZaZ2trc1J2MmNuUERJMmtrYytibGJMaHlqNVJXUmFp?=
 =?utf-8?B?QndFVmdVODdGWmtCeDlBVDBkY09Vc3FMWXh0VjBrZjlZeGk1dC9nb0NjZzg5?=
 =?utf-8?B?WmNmalZVemI2VzUwS2tzWDNpc1MxL2VabjBiOU1WbTJ3by9GM3VDNDhvRk1R?=
 =?utf-8?B?NE5qSEZQWGJLTTdmTU5MS2RKZDUxcFJXQURYc2NiMmFJZitYWEUvM0FIbTlE?=
 =?utf-8?B?Nm9zYlY0RXIvY29EYXJ0ZEdtbkdpMzBuaFU2VC9WUTl0cDdyTGFqNWFhM04v?=
 =?utf-8?B?L0YvNk80RE1FVkphSW5BUDY2K2RqRmY1dXphdFp0QkFXSVFKL05yMU5nUkNS?=
 =?utf-8?B?MFNndUdkYkZFMUpJbWM5ckMxNmc2a0hHTDlLdHRKbmErY2dZVEt5bHVNVUdI?=
 =?utf-8?B?WTR4bmFMcm42WCtueXQrT2paUEh5Y2p4bWpwRFdCSllBZVBqMHBROGZUbDhU?=
 =?utf-8?B?aXYwUGEvOUlkemNENTlHb0gvU0pWZlF6MzBmc3Jqb29WK3pkTW9XZUNaZEhQ?=
 =?utf-8?B?SE81cFBla0xaVzhpaFIxNjJQV1QzdVZDVjRzYU5JRjBaTkpWekpGT1ZlejRr?=
 =?utf-8?B?K0lIZWdrQ1FUQUtMcWNOLzJ6bnNGbGFIZ1RWRG1sRWkwT0FoRnJJVjVlNE4z?=
 =?utf-8?B?S08xMjRRT3JTbmpmeVZITCtyRjVuV1k1ZVVOQU9RWGFlSGxMVDJxY1E3cVV0?=
 =?utf-8?B?VzVzbW1FOFdHU2FYNU0zcExHOWVSUVkyVkphYUd6RkE3OXM0TDEvdUliaVo2?=
 =?utf-8?B?OGVkL1FodTVORjdQbUQ2S0htNmNCaUUvZlF2VlpENDhSY3k4d2NLZEdLNXA4?=
 =?utf-8?B?MnU5YXI2UzdxYXN4QTZ1YWV5R0J4MWR5K1R0Q2xuYThmK2VpSzFFdEVmL2wy?=
 =?utf-8?B?SUZiaDZqUXdzMXNkMjg0b1dmSTJERTB4enBLRG9tMlBmemFXUHBVbHFQcnBW?=
 =?utf-8?B?UEE0TjJIWXJzMXJsWTRBUGlibDAxbnhRU2xmUVNQNnNOWkFvaCtmQno5WTBN?=
 =?utf-8?B?dVZRMlNnVlVvMWZkRnNTV003a1pNSG1tNk1DYkVKQWY3b1FjSUcwT3gwRFo5?=
 =?utf-8?B?MHlDZVJpK0tTQkViNm0rdjVHM1lNQzYzcUl3dnNRWEVpTlZlcExDbVFJOGlx?=
 =?utf-8?B?Q1dXSHc2N08wWjlSWjlvZEhyK2ZNVHJIVlZTL3YyaFVlbERBeDdRbytJWVR3?=
 =?utf-8?B?QnpYRTI5dFpvci9WK3dlQWNxVEM1V2NQV2tvZ3d0MFhQZlVPU0lFRVBWeklh?=
 =?utf-8?B?dFM3a3lTMVM4bHpWM0lzaDRsOWdDSXJHSjVwdkRNQWF3YUpCb0FQLzE4U2lY?=
 =?utf-8?B?bi9qcmdQaElyK0ljOG5OREdHRkdkYk1KVWlWVHcrdWR0NmJBSzlabTQ4MC9Z?=
 =?utf-8?B?cURGUWFFM0xkK0hzbktUckN1ZEJibFE1ZGF4ajZCNGhZSWtqbUlkcUwrOFVv?=
 =?utf-8?B?Z1RZemxyUmFHT2s1UEI1alR4bmQrQmF6NExpYUxOa1h3QTdlTWlxRTVyRXpZ?=
 =?utf-8?B?YkRxM0RYNVRLTmZMTGlaNGtiSzNaY0RJam9xV05VVnRBb3AyV2tqTXhLQ3pj?=
 =?utf-8?B?cXVVRmFTR0VSTXBQZ3FkWDZ3SHBkL1drWGtJN3VsRWlRQ1R6SHI2bklXeHRx?=
 =?utf-8?B?bTVYSmdKVEw5TlFSNEVFVlJiaWZLWGE2djN6U1BCUGpCT0lpM09pcUcyVjZa?=
 =?utf-8?B?NjV6dS9LTWlxQVZPaTA0b001d2tTOVJpTXRYYUVpa2lDMVJlTXZqSG9NbTY5?=
 =?utf-8?B?Qlo3SWZjdS9nPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWpMeCsxNzhyaGJaMjlkemRIaFdjQTE0NWZPMUZLVTNIdGErYTk2YWZwUW02?=
 =?utf-8?B?VHN1ckxFYmNvUFJBaXNwWVcxREZqamtLaERPSmU5Z2owVnROWEc4dHUyL21G?=
 =?utf-8?B?THpvRFRxSHNhWlRmWVlZcXAwUFF4cHJBak1zemROaU9xUWgxb2Z3RitxclJU?=
 =?utf-8?B?N1plOHk2eFNzVmd1aExPUXdHMDIxQ1U5Y0xyTThjMmVtSzduUytQUUwxTGtO?=
 =?utf-8?B?Q0ErYXQzTDZBZGZ4dE8yT0graW9uNnB2RkdqMDU4YlZzL1BHOFNzcTFHMjVW?=
 =?utf-8?B?YThmRzUvOC9TTVNOUENNUnUxOUErOUxUMld4SGhieUU2RkRhRU8xOFdmVDlW?=
 =?utf-8?B?TktIenBPeUdlendxS1MzeExndTd2RHFhekd0YjhYNE90ZXN5K1VjN205SFdE?=
 =?utf-8?B?T3BPY3VJeVBEWm52dnhpR1FoSTU3WEhmckJXV1FzanNjQnBOVm1CK0J5dWth?=
 =?utf-8?B?aHpIc1RjSW8yT1ZnTGZkVWhySEYvUVhEZXVXbEYwSkN0OGp5MHpubDkwbGxP?=
 =?utf-8?B?NmJ4QmJtOVFNWlU2cFptQmNUY0pZb0pTQVduT1VvSDZzSUVPRkpTOGJmS2ZP?=
 =?utf-8?B?VFRhbWp0WHlROFlMeTNhWmhKREQrY29EenJyZXFScmdhWnYxZXk5amhSQ1V6?=
 =?utf-8?B?R1JYbFRrUTRLQW9HRkhFVE9paTkzV2FXWW9JYmFTYmplRjhhTTZYQ1dJQVNx?=
 =?utf-8?B?ZGZCQmVpTTdURjdvSDdhVjdaYUJpVkRVZ3hHbEpma2wzczI3UEZqTy9LeG83?=
 =?utf-8?B?Ny9DZVhkZjkxSmk1NGoreDJlOU15aW9KcnYyZG5PSlpMbzVCNUdFK3BNK3Ur?=
 =?utf-8?B?enNMMU1FYVdXMGFoSkNNSzd1eDhTTnRXTmJyUG82VzNzMWJ1dGdhM0kzdzVS?=
 =?utf-8?B?S0RrNWFYSGpsejZ1RHgzcGY1ZWVGbm14YlVnQ2JtQmwyVkZLTTd1K1BWNVo4?=
 =?utf-8?B?dW1PM3pMTkx4ZDREZi84eXZHYzF1S0NpbDRQcWNUWjFqYlQydFVxWjRRUysv?=
 =?utf-8?B?QmM0SS9Id0kra2FYL2F6aTFjTmFmbS9pMDRDcG1GZ1J0aHFjRlBKOFRIaC9x?=
 =?utf-8?B?bEhGOWJBamozdUpCY3NWc0VwZGVubUhmK3hyV0xoV1RqZXpZbGlPWmxneFhK?=
 =?utf-8?B?eS9vVEd4UEliTnJjUnlUZmlseDFwOW5pbHkzaUpWMW51NGdhVlQ0V3hzQ1Bl?=
 =?utf-8?B?NWppejRZSWNuQmYxcVVaMzFscXE0bnJGUjF0cEI3bjhJRkdzbFRqZGZudlhO?=
 =?utf-8?B?dlNGVzl1SVUyTUN4V0tYNTBhOHJKZ0hFWTNuY01WQ2oyeHVmWnNFMW50QlRP?=
 =?utf-8?B?bHl4Z1JCcGNxZyt4QWhMU0pGUENlY091MUJsNEJNTTgxd2ZpMUpkc0lNSmNW?=
 =?utf-8?B?MExySUhEeVg3OVYzUkd4VGVmQXBMV3pMRFJ6OWl6NlFtK0ZISmtyZFowRnFq?=
 =?utf-8?B?NTJKN2xOQy9BS2U4UkIzbkw3NEkwV0NOQldxNzkvNC8vaEZoNTlveXl1cWFv?=
 =?utf-8?B?SDNHbUtvWGdiZG9PcU5RTVEzeEhHL1E4OGFySFlmU3RsakFKeEZGR1FhQnVF?=
 =?utf-8?B?WDM2TGhCZW55YXZmL29iVDVSdHorNittdUg3WGtwYTh6K2RleS9DVGRWWjVC?=
 =?utf-8?B?SEJ6VVBYS1lWU2JFWW5LNTR2ZU5RWE5qUm1hbWZ0WDJaZmV0cWFCZnZmNzYy?=
 =?utf-8?B?aW5oZDg2TTZ6RVNMVTg0MkZodUFPRHE1Z2Jab3ZlUUxobDZ1Y1M4ZDcrWXRS?=
 =?utf-8?B?R0d4elZNaDBUdW1hTHd4cHl1dWFjYTBrRnVXVklTY0trTDNpclh5YVBSVFlT?=
 =?utf-8?B?WHZrQlNHeHRCQVVCTTVHV1MxdDFtc09ObTIvNUVSSHBtV1dGMFZaQ2JUaVNG?=
 =?utf-8?B?SkVhNWgyL2JsejUzeWd2WUZOaWVDUGtQOTJaZXZtSmJaNzZqTXcvUk16K3Zr?=
 =?utf-8?B?TEd2Rk5oa2phaWpSUXVWbDlObUVOVHFwTStxUjJ3NGFsUEFBWEZ0aktndEQr?=
 =?utf-8?B?UXI3UFZISlFRdXk2bkRhV2ZqRHpRVHVlcEFLNnhOT3RsbUp1RkJzN3NSZHRN?=
 =?utf-8?B?RG5hbGhyYlI4T2E5dkFoTGoxaG9VN1RDTDlIaWhZbklOcjErMVJES2x5VFRH?=
 =?utf-8?B?NXJjWjc0ZXpYRERhU3kzcTA5bXNuVFFkSzN0VzhVQkE5czRzR1V0VmZvQnhy?=
 =?utf-8?Q?OnxWKqJdQvR4ve8iFaj7OqOdOUOVbTmN1N9rUV3YyIPG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FA668D079BAD6428045BDEDCD0DEDF7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b528299-9f73-4952-3cb4-08ddc3f3f4a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 23:04:30.4807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k6RVrmMKgO6eBjYbrT69NJoPrHfHU7JYdNx9Z9OLFD9elhmr2YgrWuKHMTmFo4wxkZEQl1Zldhvo743uYDSJMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_160439_607307_C55E2838 
X-CRM114-Status: UNSURE (   9.36  )
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

T24gNy8xNS8yNSAxMjoxNiwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBOVk1lIGRldmljZXMgZnJvbSBtdWx0aXBsZSB2ZW5k
b3JzIGFwcGVhciB0byBnZXQgc3R1Y2sgaW4gYSByZXNldCBzdGF0ZQ0KPiB0aGF0IHdlIGNhbid0
IGdldCBvdXQgb2Ygd2l0aCBhbiBOVk1lIGxldmVsIENvbnRyb2xsZXIgUmVzZXQuIFRoZSBrZXJu
ZWwNCj4gd291bGQgcmVwb3J0IHRoZXNlIHdpdGggbWVzc2FnZXMgdGhhdCBsb29rIGxpa2U6DQo+
DQo+ICAgIERldmljZSBub3QgcmVhZHk7IGFib3J0aW5nIHJlc2V0LCBDU1RTPTB4MQ0KPg0KPiBU
aGVzZSBoYXZlIGhpc3RvcmljYWxseSByZXF1aXJlZCBhIHBvd2VyIGN5Y2xlIHRvIG1ha2UgdGhl
bSB1c2FibGUNCj4gYWdhaW4sIGJ1dCBpbiBtYW55IGNhc2VzLCBhIFBDSWUgRkxSIGlzIHN1ZmZp
Y2llbnQgdG8gcmVzdGFydCBvcGVyYXRpb24NCj4gd2l0aG91dCBhIHBvd2VyIGN5Y2xlLiBUcnkg
aXQgaWYgdGhlIGluaXRpYWwgY29udHJvbGxlciByZXNldCBmYWlscw0KPiBkdXJpbmcgYW55IG52
bWUgcmVzZXQgYXR0ZW1wdC4NCj4NCj4gQ2M6IENoYWl0YW55YSBLdWxrYXJuaTxjaGFpdGFueWFr
QG52aWRpYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoPGtidXNjaEBrZXJuZWwu
b3JnPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0KDQo=

