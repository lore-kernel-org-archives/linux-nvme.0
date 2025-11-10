Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EC7CCF9E3
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Nov 2025 03:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qZtdhGsT3qpVYCKKdYP5rlq5zSwJQvMWfYIEhLVvsi0=; b=2aGBktpQSHZp3iwG1ynRRcmblJ
	qg9eywv/iZnDFT28V7qCQkLnXHvpvSZ6HtFg5UuCu1bP3AK0+fe9mCsFgvQd27lG0s5paT4CeaG39
	ouiZxF2PhkFkVX9cm/YvRNjAMjF2Gtly6qElrdT3N6PGON0m9I0Wmseaw3cwquoummBxVbTPapOgZ
	XiCVKxnua/wSe+GKxRjP5RlKksdAZDtPMxtBJNEw7QAch5kj46Yyqg6McVD5ar84Wy7YJZLUYHg7h
	d9qf8az0hru/8cyrsigCkr/hok9CHVXkjuaN/2V9fdNUWRHSkwYai78gStpCZBPOTEHE3BLOLLpiw
	kAMGCXpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIJ4E-00000004gPx-0LrA;
	Mon, 10 Nov 2025 03:59:46 +0000
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIJ4A-00000004gPJ-40MS
	for linux-nvme@lists.infradead.org;
	Mon, 10 Nov 2025 03:59:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8qrr00dImvMcIoVXQIbSqmX8kv5T/kLyiht84BCVQk89GWbheEMKaTecftBB7WdoYSpnpVHXj1ZGvUaUCjW/QyVdnDfAlbss/fHo6In54AjwnnP+VwzUGGevr7z4yu8FXZbIe7Ng7rWHggMGEUdYK9Kk6dxuHOzaB0HAQhhHGzdjeXsfYbbXszbyS4EzgJar0ytIYxu9ozsPfnjseXmXTFrcS/sEV1bufMrKNIdFHXWpRWhSNu1B5Ff8sAAeRmHBb+7WYTsnlnQk6c253TBnaI9EIHp520gfZ5aQBXTHChdcx8SlyV1O2Suyx2sDI2ktlPMWlqUhaDYYJGz6osv5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZtdhGsT3qpVYCKKdYP5rlq5zSwJQvMWfYIEhLVvsi0=;
 b=QMHm3NTiKzfUEzj5g7d7gylvuusEgLbYNFFq57+g0Ry7fLU52oxBPKamj/ZWtZhiEGUBAWFtfsnmkGjQMi/tZsriAuz50n2iteBh36uwr2fd0rvTqthvxEd01BrrE/943/GE0hvXfJZg1AsrPpVsh9Y8lj2uzoZKwjz3kkZ9djr3RQbfflP3RxVo+ow+rESPcVhBaizGuRjD8gRTKeJTSzqmGnTItIDKelxe2AgeMkftgS32a0yyviGOfOtpIDjZqpX72VMLjDz6mnjmrWQC+lWY74EE9MEXhzRGyetFEle5R4fLfxqfO6toMqIPyEgSlFFzIa8PNiHnqy6Pmii9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZtdhGsT3qpVYCKKdYP5rlq5zSwJQvMWfYIEhLVvsi0=;
 b=ltAS7wiI8/4eIy9TGQmjrOWuj5LR25BHDoc8EnnBLoQYyP6pzYd8UZgOfYSfyXKRy7UWrDZayqTNw0a4ztMavz26GnbGUnQMeSukNEpI7RjvF7acnrNtsJLl2g3wn/mYMIiMrIDk8luUFEwls/vj6nEj807gnn9I1toPLlIk40MwAYnJHxnQiIMaiuZXqnSXNHXEtx4+d6of3Izd+ACd+WQRxn3i6Rq+/7WyjSiw9Jf7aIPf0gYQ54frnJSLcPk3YYb4GBJfEyu5r6v/CjzeOzEiMCnnEp1HqRxL75w5m3dGUV48yhgxAULg1nQDhJO1kJPiEEIlk2RsyzrQ+0iK8Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB6859.namprd12.prod.outlook.com (2603:10b6:510:1b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 03:59:36 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 03:59:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "hch@lst.de" <hch@lst.de>
CC: Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni
	<ckulkarnilinux@gmail.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvmet: add basic in-memory backend support
Thread-Topic: [PATCH 0/1] nvmet: add basic in-memory backend support
Thread-Index: AQHcTWHrDheTX3CfYEy0GSlVBKKEm7TiUwYAgADjKoCAANs2AIAAyveAgACwDgCABcWrgA==
Date: Mon, 10 Nov 2025 03:59:36 +0000
Message-ID: <d9624413-9275-4318-8921-5ce2fa71caa4@nvidia.com>
References: <20251104080610.183707-1-ckulkarnilinux@gmail.com>
 <c705eebf-bb76-4bcb-8630-99907b1b6ac6@suse.de>
 <0c299f77-e93d-4c96-af71-9e1ea387c9d9@nvidia.com>
 <20251105131414.GA19044@lst.de>
 <dd3a31e0-a170-4d52-8e11-c7229b955a76@nvidia.com>
 <20251106115048.GA1916@lst.de>
In-Reply-To: <20251106115048.GA1916@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB6859:EE_
x-ms-office365-filtering-correlation-id: d7cfaa2f-6396-4d5d-a476-08de200d9055
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|38070700021|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?S2hVbDRpcTJQRExOVndBSHhpYjlFKy9yOUxSdFNyTno3akdlUnEzczBCVTM0?=
 =?utf-8?B?cHFvbUx5czRkWUdVMFpJbjNRSWMzZmgzMmt2ekY1cVpSUjlRdkI5N3NSSVp0?=
 =?utf-8?B?YlBIaWhhNzNqM0tTMHFUdTdvV3Q2Vk9uMFhCazdWS0o4a3ZYM0pQZ3FReURl?=
 =?utf-8?B?Z3RJYXhCWGVHRElOTk8vdnl3K1NLR3hxayt2czlHNjFDcmpmZ0pOYVpiU2tR?=
 =?utf-8?B?RTQ1SENuMGdueE9heWMxbncra2J1anJReXN5Tll3Mkw2bHlhSlNQZ2ptZXlB?=
 =?utf-8?B?UU1BVlZBS0pvb0MzRUcwSnd5ZlJiTTVNZXdEZnE1QVRWck1UYWdzVGlnajdH?=
 =?utf-8?B?cDdJY0ZGMFdtUG9yTnBGZWZydEV4QkJNQTFZWnBicXFBa0xOb3pyMWJWV2VZ?=
 =?utf-8?B?aWpOazMxNjhDVWlZUWM0NjBwcnpiZUxsWTF2M3lwU3ROYXdHeTZRK1pSNWVn?=
 =?utf-8?B?Ykxod1dIZ3A5Zk9kU2N5U05XeTJTc2NMWEJaUVNzU2kyc0JnTndQWWcwNU1D?=
 =?utf-8?B?T2xsbkN5UkZIcXUydlg0WHpuSzNFY2dIOVJoaUp5QlFIQjQrQXZrWmlXczBx?=
 =?utf-8?B?UW1GMGJFMVh0c25nd0MyQXlBNnNVT3ZQUVFlRUZIY0ZnZGdFL1R6OVY0cFVM?=
 =?utf-8?B?T0pxUzQ3U3MxRXJSZWdzMC8ydGp4cU5BWlkveFJraDFhNFRjcjFBWE9POHFr?=
 =?utf-8?B?eGRmMXNMVUZNSjRNOVByRENnQ004eHlYMFZnQWh6Vkp1b0pMOHU5ZmlHSjhM?=
 =?utf-8?B?R2NIWkVEN3AvbGF4R2ZCNS9sNGgzZWNGdDZMbWNHMzAvRk5CMlZXbCtKeXJJ?=
 =?utf-8?B?aUt6UG5VcGZSK3RyYW9tNmxxNDVZNnBIY0FFNzFZdCtPZ3JMZEkrZmNUTVY5?=
 =?utf-8?B?cUZnb0RrazZEcVVDdDZBQUR1TnU1VXlKQzBUaUFKd0xNWENOU2VXU3oxclRN?=
 =?utf-8?B?WVUzM0pWUUs0QUpoTWVoeEVGbmtGNnFrYldHays3Y01nN3JJTGpDTkZEdE1V?=
 =?utf-8?B?MHR6dHQwR2ZFbi9VcUpVUDlObVBtR0pqUUpTRVBpcFNWaEJJWTNwOVNsRm95?=
 =?utf-8?B?OXpJK09OcUZUQWtXWjZMUEtZUXFvZzlnRnlvdkhzc0FXblh2eHc5RERvT2VS?=
 =?utf-8?B?L0V1SXhyVkkzcjRRWlZkVW1kSFNwU2tiSGJOT1kvQU9RRDVBeWtjSkQrOFBQ?=
 =?utf-8?B?dW93SEZycURIZEIvVDdSeTRMOHUvdnN4Rko2ZElVVUNFYmFwM0JyNHNtaU5r?=
 =?utf-8?B?ZWtFUGVZMGZQWUo3VTlzWTgyV3RmR1dseGwrSWdyU0g0K3E4QlBYZ3BoZUdU?=
 =?utf-8?B?ODBWaGxPYkd5UXBFcEpES0V6MWNXTitmVUVGV00xWWxmOE5VRWpWdTVzV2ds?=
 =?utf-8?B?UVhFVmViOFJRYlMvWkZYWUdFdzhwakNBZ0xlVks5VVBGVUhDNFlUNHhtSVcw?=
 =?utf-8?B?N1ZXZnlVR3FXZjlwNCtHR1h3dHZlcjZqZlpNY2NEY2p1VEErRjNqVndmNjQ4?=
 =?utf-8?B?RlkyNnoyRjh4QzJYRFUvSitQQ2d4YzBxMUhuZDFkOFZ2NW5zVUJ4WFVnbHJL?=
 =?utf-8?B?QVNUcHk3WDRiM2pucTE1ZTQzZ053elZLdTN3cFZBWXVRVUtmNVkrOHJTWk5E?=
 =?utf-8?B?TzV1TU9MdWZQYU9NNUh3SDh1MjVkVjQ5U09rcGp5N2QyWGxha084aUZHNWlJ?=
 =?utf-8?B?UVVUUE4rWUw2bEhQMGtCMFBmbE5IR1BYUzJGMjRpaGk0UE5ncHpUS3NQcnZq?=
 =?utf-8?B?Nk5VWlQvb2tLMlBnNmd0VTBXS0FhUjhIdzdvdnJnZHVkbzZBSTd5K1B2eHAw?=
 =?utf-8?B?M2thMERoZ29vSUluMkdrUklZUEZjSnlsS3l0cnBWTFVBeFVXN091dGx0Rjlx?=
 =?utf-8?B?WVFpcHdoeDRscEVEc0VXd3dVbGZRaE14SUFRQzF4T21lRFJsZEQxNlhBd3VU?=
 =?utf-8?B?cE53MGtMVUVFNndFU0NkdDdEMElwbXJyS043d0dWeWhNYXJCc1U4QWtSRlBw?=
 =?utf-8?B?OUFMM1JjL090c3ZwVXZ1M2xudS9NaGNtZnJqYURkM2QrQ3FieU43c211S3Uz?=
 =?utf-8?Q?lcY8JC?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sy9CTnk1b1hMQWk4Z3FQODJVeU5vTnRxRmlvczRycVdCRndjRDMvSG1oUkU5?=
 =?utf-8?B?U1grTVl2L0pkT1kwSEpQdzFGbGd1NGZJa2FYeVgzWlVEbEtISk8xeGUwZ0w3?=
 =?utf-8?B?cW43NWhkZGd6TTNOZk9GRW12WEVJb29NSTBweTM5djF5Qy9LK0xLS3BOU0g0?=
 =?utf-8?B?eFR2aDUvN2hzbFBtbWk5VzJ0VVd5MU9Yb0crWTllS1lZUGVYUnUvaDBYYkVV?=
 =?utf-8?B?ZWI5UVdCbmNvL2VzNDIzdUpmYTh3ajJRYVRFc1JGSUpoeW5IY0srUUFGazBB?=
 =?utf-8?B?a2dHSjk2T1AvQkQ3Ky9wb0NwMDlPQ3NvNWtRL1pSYmVvUW5qZzJ5UlBUaU56?=
 =?utf-8?B?ckVqUWVqb1ZsOWIyNlZDQWxOejFML043cmJ2UktpZUxDR2tla3hjNjErYmpM?=
 =?utf-8?B?YTJ0bEhybnEzTTFlMFNvclkzVXVMLzhDbnFqK1NMTmVwVVpuSkI5d0F5VzBl?=
 =?utf-8?B?RUFFNVhXVkg1NWZtbGNkODBralQ2NzlGUytkTnJMeW5JUkZrNUowRFdZQnhy?=
 =?utf-8?B?V3RVSFp3Tzkvd0Rod1A3cWMrL0wrUHR4azN1THppazVzaklPY3lnSUFlTEZI?=
 =?utf-8?B?aWV5WGJkendtN0UxT29mZ0VLL3FUQUdaMjBVMUh4RUtOd0N3dEoyQkdwa2Q1?=
 =?utf-8?B?Ykt2Tkl0cldnVEs3QVRRNVR2ZndKYi8xUTZoYU1EUU1PT3ZxcHkzWG1JUGJ4?=
 =?utf-8?B?YTJmMVpndTlZY0VJVm9LL2crQzEweTR6aGVPQndHelJ4b3FBT3ZjWFl0ZWFs?=
 =?utf-8?B?Y1ozMWVvSXBqdmRXb1k4TG1OcjVGc3pvWlVXTlRHWEw1RzlBSlA2akNXZ2FM?=
 =?utf-8?B?Q0NwSWFpcHo2WE9Fa2NnTjBzQUxNbXlXT3VORnhsaGg1UzhCNXYwbzE0WHU2?=
 =?utf-8?B?VjE2V1EzUk5GakZHRDhkQ2FoQzZFQUJQLzVNRUpYcXovVjIxUXZBa2xob2Rr?=
 =?utf-8?B?dWZRcEROSEhOR1FMQ3NWY083OWpxSk5mM2c5ZEpXcDcxVmNqN3hOaHlPM0lE?=
 =?utf-8?B?bVA4a0t5WklkdXdnQmVRaEtYNDhXampQWi9wL3JiOVo4ZnYwczZEWStwcENn?=
 =?utf-8?B?dERCTmQxVVNQY3FxV1JLVWdzZTFyKzFPekYzaEd1eHJMYk1TTVhxUlRYWkRP?=
 =?utf-8?B?YWhlaVRKL2RZYkxITHBraEJZTHFxeXJTTVdtMjhRMVZGcWU5cVVYQkwyTjYy?=
 =?utf-8?B?OTB2dVBrU3VmZU8wNnNBYWdYYXNpSmRGdHFQd3JXWEpCOEl0TFI0OUt2SElT?=
 =?utf-8?B?RTZ6NTZNMmZndUxwV0NLQmFxL3UvQk1SUmlGaFFKMDFvVGdwTk9NZ3JwN2JF?=
 =?utf-8?B?Q3RUc0w2ZzBWeXUwaTdzUENMM1hiQnRHODE4KzVNMkJqdWZROGw2aWpMRlQ3?=
 =?utf-8?B?VGZzQ3g5d2Nwd0g4T3I5Q25TWlpGbXJEdWhqZXVQTEQrS1hJY3g1U0U4eEF4?=
 =?utf-8?B?c2lSY2g5SmJRZk96d3ZZNnBrd0NpeklFNHhWbVpCSTFqTGx0M2Nwa3ZsdVZn?=
 =?utf-8?B?K3lwVldFOCtrbDkvNTRzajJjL1J4SGJHTENMeWxHOGdKSnhrTXBab2pIbDFo?=
 =?utf-8?B?R2FvWXh5V2JnVFFCcnp1YzNFcHF3M3p2Zk5FY1dleDYxK1dyb29uaFlrY0pa?=
 =?utf-8?B?YUFXOWR3ZEhIZjl5dU80RG9wL0NkZjNlaDdoc0NYZzg4ZmhIa0JHRjh2ZnJp?=
 =?utf-8?B?OVFDZmgvdjRucG9USTFkdjRsSUxSeTJnVEl6Y08zREhVMENldURHdXJ0QUc5?=
 =?utf-8?B?UmtUYWtPUlhFTExKQUlVUUx2Slo3RGhTUkdyN1JBK3ArYWQ4RTN2Slk5NlJO?=
 =?utf-8?B?TzNVT1VzbEpxTDlrZDEvNDcrcEZnYTA4Nm5LRm85Z1pvbVZwNzZON01Mc3lT?=
 =?utf-8?B?ZXJNTTJtdEdPMWxRT1hSN1YzN1ZGd25wUm01Uk5XM0tLYi8rT0swMXNzbkpz?=
 =?utf-8?B?WWYyT3lYQ3V4S3hrazZUUDFlcGgzVVBjRDBCZnIxK0xRNW1aSDJaYnppNUpp?=
 =?utf-8?B?enlvdWlCa2xnYnVnUTR2aFdZL3ZlN1FDbkZTM0QvUnIxMUtLbVZwOWl4akkx?=
 =?utf-8?B?bmt0Sm1VY05USkJOb21xYzFQVXB2SjlUZGk3NzFBSTZkM25rNGNiaWxlUE8z?=
 =?utf-8?B?NDBySFJJa2tXVGc1TnZHUVROZGlhZGc5ZFo2UkNtZENkRHM1RmdGcmZtb1du?=
 =?utf-8?Q?Tduwteq+yb9fQuvNq2DSv2SmhoRSJkcyuN7sYqOEHUPd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3AC7E91AFAA844CBFDB8EB19D934B52@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7cfaa2f-6396-4d5d-a476-08de200d9055
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 03:59:36.0779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2eTDIfDKd8ntrqftF+3O5HiEGJv+aKwfCz8w/vODDVEoGwrLZ3CK9fMV/reuymKsDtz/pqq8zDXybi3TXJo0uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251109_195943_177476_FB0E3318 
X-CRM114-Status: GOOD (  14.29  )
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

Q2hyaXN0b3BoLA0KDQoNCk9uIDExLzYvMjUgMDM6NTAsIGhjaEBsc3QuZGUgd3JvdGU6DQo+IE9u
IFRodSwgTm92IDA2LCAyMDI1IGF0IDAxOjIwOjQxQU0gKzAwMDAsIENoYWl0YW55YSBLdWxrYXJu
aSB3cm90ZToNCj4+IEhpIEhhbm5lcyBhbmQgQ2hyaXN0b3BoLA0KPj4NCj4+DQo+PiBPbiAxMS81
LzI1IDA1OjE0LCBoY2hAbHN0LmRlIHdyb3RlOg0KPj4+IEJ1dCB3aGF0IGlzIHRoZSB1c2UgdGhh
dCByZXF1aXJlcyByZW1vdmluZyBhbGwgdGhhdCBvdmVyaGVhZCAvIGluZGlyZWN0aW9uPw0KPj4+
DQo+Pj4gSSB0aGluayB5b3UgbmVlZCB0byBkZXNjcmliZSB0aGF0IHZlcnkgY2xlYXJseSB0byBt
YWtlIGEgY2FzZS4gIEFuZA0KPj4+IG1heWJlIGRyb3AgYSBsb3Qgb2YgdGhlIG1hcmtldGluZyBz
b3VuZGluZyBvdmVybHkgZHJhbWF0YXRpYyBsYW5ndWFnZQ0KPj4+IHRoYXQgcmVhbGx5IGRvZXMg
bm90IGhlbHAgdGhlIGNhc2UuDQo+PiB0aGUgcXVhbnRpdGF0aXZlIGRhdGEgdGhhdCBwcm92ZXMg
cmVtb3ZpbmcgYWxsIG92ZXJoZWFkL2luZGlyZWN0aW9uDQo+PiBnaXZlcyBiZXR0ZXIgcGVyZm9y
bWFuY2UgZm9yIG52bWV0LW1lbS1iYWNrZW5kIGFnYWluc3QgbnVsbF9ibGsNCj4+IG1lbWJhY2tl
ZCBhbmQgYnJkLiBIZXJlIGlzIHRoZSBsaW5rIGZvciB0aGUgY29tcGFyYXRpdmUgZGF0YSA6LQ0K
PiBCdXQgd2hhdCBpcyB0aGUgdXNlIGNhc2U/ICBXaHkgZG8geW91IGNhcmUgYWJvdXQgcGVyZm9y
bWFuY2Ugb2YgYQ0KPiBub24tcGVyc2lzdGVudCBEUkFNLWJvdW5kIGJhY2tlbmQ/DQo+DQoxLiBG
cm9tIGNvdmVyIGxldHRlcjoNCiAgICBXb3JrbG9hZHMgcmVxdWlyaW5nIGR5bmFtaWMgYWxsb2Nh
dGlvbiBvZiBoaWdoLXBlcmZvcm1hbmNlIHRlbXBvcmFyeQ0KICAgIHN0b3JhZ2U6DQogICAgLSBB
SS9NTCB0cmFpbmluZyBzY3JhdGNoIHNwYWNlIGZvciBjaGVja3BvaW50aW5nIGFuZCBpbnRlcm1l
ZGlhdGUgZGF0YQ0KICAgIC0gRGF0YSBhbmFseXRpY3Mgc2h1ZmZsZSBzdG9yYWdlDQogICAgLSBJ
bi1tZW1vcnkgZGF0YWJhc2Ugb3ZlcmZsb3cNCiAgICAtIFRhcmdldCByZXNvdXJjZXMgYXJlIGV4
cG9ydGVkIGFuZCBhc3NpZ25lZCB0byBIb3N0IFZNcyBhcyBiYWNrZW5kDQogICAgICBzdG9yYWdl
LiBGYXN0IGVwaGVtZXJhbCBzdG9yYWdlIGFsbG93cyBWTXMgdG8gYWNjZXNzIHJlbW90ZSBEUkFN
DQogICAgICB2aWEgTlZNZU9GIGJ1aWxkaW5nIHJlbW90ZSBiYWNrZW5kIHN0b3JhZ2UgYW5kIGFz
c29jaWF0ZWQgc2NyYXRjaA0KICAgICAgc3BhY2UgdW5kZXIgb25lIFN1YnN5c3RlbSB3aXRoIGEg
Y29udHJvbGxlciBpbiBpdC4NCg0KICAgIFRoZXNlIG5lZWQgc3ViLW1pbGxpc2Vjb25kIG5hbWVz
cGFjZSBjcmVhdGlvbiB2aWEgTlZNZS1vRiB3aXRob3V0DQogICAgdHJhZGl0aW9uYWwgc3RvcmFn
ZSBwcm92aXNpb25pbmcgb3IgaW5mcmEuDQoNCjIuIE1pZ3JhdGlvbiBmcm9tIExJTyB0YXJnZXQ6
DQogICAgRGVwbG95bWVudHMgbWlncmF0aW5nIGZyb20gTElPIHRvIE5WTWUtb0YgbmVlZCBlcXVp
dmFsZW50IGZ1bmN0aW9uYWxpdHkuDQogICAgTElPIGhhcyBzdXBwb3J0ZWQgbWVtb3J5IGJhY2tl
bmQgKHRhcmdldF9jb3JlX3JkKSBzaW5jZSBpbmNlcHRpb24gZm9yDQogICAgZWZmaWNpZW50IGhv
c3QgYWNjZXNzIHRvIHRhcmdldCBEUkFNIHJlc291cmNlcy4gQXBwbGljYXRpb25zIHVzaW5nIExJ
Tw0KICAgIHJlcXVpcmUgdGhpcyB3aGVuIG1vdmluZyB0byBOVk1lLW9GIHRhcmdldC4NCg0KICAg
IExJTyB0YXJnZXRfY29yZV9yZCBoYXMgbmV2ZXIgYmVlbiByZW1vdmVkIC0+IGFjdGl2ZSBwcm9k
dWN0aW9uIHVzZS4NCg0KMy4gUGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgaW1wYWN0IG9uIFRDTyBj
YWxjdWxhdGlvbnM6DQogICAgSGFubmVzJ3MgY29tbWVudCB0aGF0IGJyZCBhbmQgbnVsbF9ibGsg
d2lsbCBjb250aW51ZSB0byB3b3JrIGlzIG9ubHkNCiAgICBwYXJ0aWFsbHkgY29ycmVjdCwgYnV0
IGF0IG1lYXN1cmFibHkgbG93ZXIgcGVyZm9ybWFuY2UuDQoNCiAgICBJdCBhbHNvIGNyZWF0ZXMg
YSBtaXNsZWFkaW5nIGltcHJlc3Npb24gb2YgdGhlIG1heGltdW0gcGVyZm9ybWFuY2UNCiAgICBh
Y2hpZXZhYmxlICh3cm9uZyBUQ08gY2FsY3VsYXRpb25zKSB3aGVuIHVzaW5nIE5WTWUtb0YgdGFy
Z2V0cyB3aXRoDQogICAgRFJBTToNCg0KICAgIGJyZDogICAgICAgICByYW5kcmVhZCAgNi0xMSUg
ZGVncmFkYXRpb24gdnMgbnZtZXQtbWVtIChhdmcgMykNCiAgICAgICAgICAgICAgICAgcmFuZHdy
aXRlIDQtOCUgIGRlZ3JhZGF0aW9uIHZzIG52bWV0LW1lbSAoYXZnIDMpDQoNCiAgICBudWxsX2Js
azogICAgcmFuZHJlYWQgIDEwLTE0JSBkZWdyYWRhdGlvbiB2cyBudm1ldC1tZW0gKGF2ZyAzKQ0K
ICAgICAgICAgICAgICAgICByYW5kd3JpdGUgOSUgICAgIGRlZ3JhZGF0aW9uIHZzIG52bWV0LW1l
bSAoYXZnIDMpDQoNCiAgICBJIGRvbid0IGhhdmUgYWNjZXNzIHRvIGFsbCBicmQvbnVsbF9ibGsg
d2l0aCBOVk1lLW9GIGRlcGxveW1lbnRzLA0KICAgIGJ1dCBzaWduaWZpY2FudCBpbXByb3ZlbWVu
dCB3aXRoIHJlZHVjZWQgb3ZlcmhlYWQgd2lsbCBnZXQNCiAgICBpbXByb3ZlZCBhbmQgcmlnaHQg
VENPIG51bWJlcnMuDQoNCjQuIFdoeSB3ZSBzaG91bGQgY2FyZSA/DQogICAgS2VybmVsIGltcGxl
bWVudGF0aW9ucyBzaG91bGQgYmUgaGlnaGx5IG9wdGltaXplZCAtIHNvbWV0aGluZw0KICAgIGV2
aWRlbnQgZnJvbSBhbGwgbWljcm8tb3B0aW1pemF0aW9uIHBhdGNoZXMgSSd2ZSByZXZpZXdlZC4g
QXMgY29tcGFyZQ0KICAgIHRvIHRoYXQgdGhpcyBpcyAxMHggcGVyZiBpbXByb3ZlbWVudC4gSGVu
Y2Ugd2Ugc2hvdWxkIG1vdmUgYWxsIGV4aXN0aW5nDQogICAgTlZNZU9GIGJyZC9udWxsX2JsayB1
c2VycyB0byBuYXRpdmUgbnZtZS1tZW0gYmFja2VuZC4NCg0KUGxlYXNlIGxldCBtZSBrbm93IHdo
YXQgZWxzZSBJIGNhbiBwcm92aWRlIHRvIGhlbHAgdGhpcy4NCg0KLWNrDQoNCg0K

