Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7411C369A1
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 21:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XqoNabV2rpY0mROU0Cxdz1yQ5GXyJWXAscGZoS1mk+s=; b=0C/vnHzdwGQnrY4DIbCN2A3dq7
	8ZvVP2rfd4jsdMxlrK4+6zzHBf5gKES7zvDZu9bxoOM+YWYkBn8CTOzw+TjG24FDDnu3P6FhwY6E4
	xTGH99oVsA5bcH8NXzojexnDKitivbUr4J617OIZXEvQRJ+gVt7TOLSlfa4RsUwlZSzFCUdm6/9ki
	+d3nmxSE1hOh0gCr21wNtqw7bwluOVbvlt4T+h9HfnoDvm0JpHNtEhBVS7a0ZoRT26fk5KkPd80Us
	9Wutq933x1UoHYmKtR9xhW7xf9Z6ZB2igZQlB2I2Kc6r2XCas+4oVFeXF45iqBRO1j7g0ZYXrcs+X
	08YzpV/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2GCy-00000005Pgc-3ddF;
	Tue, 08 Apr 2025 21:10:12 +0000
Received: from mail-dm3nam02on20628.outbound.protection.outlook.com ([2a01:111:f403:2405::628] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2GBO-00000005PTz-0ug1
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 21:08:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RVgaklDfEVJOq+TNptDmjG597OjvEM7j4O3VAgAi1Gx66Dw17uzK536tPPkDLgrpVxwn0yUSMWZNI7N3Vp2B0PK3h9aM89n6SSQEzwvRQKK+sRScoMRZOgZJmysoUcNRAm9D53NLVj0GHDShP0z+JMV8vjbnKjaNvLml2cbPKL6/fievzX5jI1c+HhjbVRq0+kaj8eae6+svdqRdQxMOVZm7ChCu2wfFq37UrhkaMn/wwgy0alFG64QuOXEAKEA3HJH/Thzn3ouRne5SkslkVN7NmoGqrE/OTUEDEtLoOB9vl3S93rhE9uSWyH5DoGktR4DySFxAjOBGT+Vuq5dPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqoNabV2rpY0mROU0Cxdz1yQ5GXyJWXAscGZoS1mk+s=;
 b=Se4OAO1Xem7tI1fR6feU53C5EiaqPqgV6xAEf3kkkzZWjoLOn+r11thH+AZTxRVacQL5cuCqkFBNml+VlQ2Ws2+qdSJkfZdFtuk8BJt7c7gLZm4WZ0IQLk+mrJAUi7QClEvHvMkZv+x3ozjMhc0mLBl6Mt+8FsoNIXVipCVTgSH3AzWocRgAGuL8aMtl56ygsvEUrDnj+4XndtUIFLRW9StidigYYXpfva57mNHB4zZFawCcHAPUyS6lVXcdld6O0spoHbJ1LlYOBKwKCYWZlE+WT4jZDQCWire9K9uViL3P8Uixou1WvVXFaz7LiDd2+NTFy30xcXmifNiVFPjHFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqoNabV2rpY0mROU0Cxdz1yQ5GXyJWXAscGZoS1mk+s=;
 b=qcyHZqHuumEIxldnI7xZezb4k3IG/NUhOGrA9t5F/UJ+/LqQfhcMVKUdK0M5rsS0uzN5ccMg4usO7MHBKgl7sU3OOTVsXfizEB6yFiQDIRApPIE1IvT32s3Ao2i0r1aH+hY5Y6muaQu79HpawMvG8wJWxnzHwX/Gel36vPaIMapPTYURL+i2cndoq0+UFJhoAMSgR0p6mk45k5WuayFZwQ6blouQp77ucfOv5ekEeKcxPk1tIQvzj8FSfW9/hN3NOZ+XOT3mOqGCdNgxzKrYQIBT3ZjuQwYjm1AwpFn5Sx2psAEZu1GJfEe0C0IhkurtCxyciGyPkWxbq6KWiiyROA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 21:08:29 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 21:08:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Issue with AWUPF when using multiple controllers in a subsystem
Thread-Topic: Issue with AWUPF when using multiple controllers in a subsystem
Thread-Index: AQHbpbL7Y6xDvP39E0WZWwk4rCeLz7OaSVqA
Date: Tue, 8 Apr 2025 21:08:29 +0000
Message-ID: <757a0795-6829-40fd-a658-c97506d89c92@nvidia.com>
References: <4a2e4561-9311-40c9-aa65-87e7a2e5b041@oracle.com>
In-Reply-To: <4a2e4561-9311-40c9-aa65-87e7a2e5b041@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7144:EE_
x-ms-office365-filtering-correlation-id: bc970646-b03a-4f0f-b650-08dd76e18337
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TE9pa2ZBM2N1OFg2Mm9LTnZBRlFDNlZEK2hveC9zVFoxTnFvN1RSTGJUQzBj?=
 =?utf-8?B?VlhSek1yQ0xJT2FBcW14NlFCazZvYThIV2pIcmZzL2lZQUdyQ0dNeUk0VE9m?=
 =?utf-8?B?OVNpSjEwTVZqWkFpck9uVm4wOVVGZ0NnUVIxdFQ2U2M1OEwxdW1MMUFzRlpS?=
 =?utf-8?B?N1dneUNvdjdadzhZKy9CWUx5Q0lvUFY1SUlzaThsZXh2aGVud1pOUGlERUV2?=
 =?utf-8?B?UENZU3FhRGdsV1Ntd3RxL1gzRjBTYUdyVlZGV2hsQUlkdFF0STd5WVoyVFhN?=
 =?utf-8?B?amJ2S0tKcHp3MGRvY0FLV240ZCt1dFFPaGEwVTBId01RbDBZOVdvTS81cmI5?=
 =?utf-8?B?YjhFTU9CbGR0WXFLTGFoeXVhL0ZxSHAwVmZXWkJwMjNaWE1IS0c2N3JPencx?=
 =?utf-8?B?MER5ZlN3b1NPdGJ0bnJFdGNlOU9iL1pYT0hZNkZFZXoyd01Rc2pUVTlHUTBj?=
 =?utf-8?B?ZjZTQ0RzcnRkeFkxOWJkbFpBdXhzMEhRUVVqVDRWVUpGaDlEQjBGY3hONGJ0?=
 =?utf-8?B?aXRiQ3dydTZZTGk2TWJlQ2MzWjdYOGJWdXhBWWRnZGFPcEJ6cE5XZFExT29q?=
 =?utf-8?B?eVErODFqK1ZibG1SSnU1d2xqZUhiLzcrdnkrdERQeG9IcGc1TGthL3ZDV2VB?=
 =?utf-8?B?dndWdUYwb2pBbG1UZGc5U3RYN0trdXdCcjFGTjZhcFNvN2c0cGlPNEwrTUw1?=
 =?utf-8?B?aVhoZEZDSVB2QWk5YVpQV1NnOXlHNzJyVitZQzUvc2VGdy9ESHd0amlGWW5P?=
 =?utf-8?B?SGNKSVZqRGQ1bnZIUjlndGhkSVd5ZUVBSVQzaU92WHhEem9IWVBHY2RGZkpO?=
 =?utf-8?B?Q2NtdEhJdWZrdG85UlhnNWxzbDBOTkVyRkRySHNtYk5tVW41SGxJQ1FkVXdJ?=
 =?utf-8?B?Ry91WGdoZGtQQkRBUWs4eEw2YUh1SFZJOTFvcWNpZVkwOFBPK3FkM29Hd1Q1?=
 =?utf-8?B?QXIxZnk1aUIrNHFZMnV0ZEx5VW1tQVBESzNGd1dpL0lHR0IyRHJMYjdJRU1o?=
 =?utf-8?B?ZTJIWlN5cmFUcE1NcHhIYWd4M0NkUENkRGZkNjg2RnowN1hEbFFyT2pRYmdk?=
 =?utf-8?B?RTl4MXVFU21oRXROVm5ybGtwQ3RuRkJ3ZjMwbXpVYzcwY3V0SmhGQjQxZS9k?=
 =?utf-8?B?QkxNT1VKL1g1ZTNmeFFMNjJsRDZGRm9rUUtwWVl4QjJHNDZtaGljWW5OQ1V3?=
 =?utf-8?B?dkNRNStzNUJZeTlqZmdxSlF0NS9yQkNJQ2MwUzRFUit5aThZcWkvTE5hcE45?=
 =?utf-8?B?em9CRzE4OEo4cHEwZVN1MW4reTI3L3duaW1qQUFCc2FRam5tWVdLYTdXdWw4?=
 =?utf-8?B?TjduUlVLZjU1QkgvMXV2c3ZsdE9OdFY3NUJQbU5sWTREQ2ZjN0lDdkFKbEpM?=
 =?utf-8?B?NVlNYjlhOVcyOGZkcHlHVE93bkdCcGtEOUN1WkM4bmI5Ulh2K0hWQ2RwaG5p?=
 =?utf-8?B?eUJ5RkhRa09QVnhmWm1NNmIxazB4SXJpaXpOOUZ2TGQ0WW94anovc3ZKZXhE?=
 =?utf-8?B?WlVmZ0Fva2MvMUk5a2VmZHl3WWd1bWNGUk1rNllaUkxkMk1iMHJDY095YWkr?=
 =?utf-8?B?dUl0MUlPQ0NRUmVYK0xpZDVJdUdFYzVESFVwVVBFeGlnbVNYWlg4dVMwQlow?=
 =?utf-8?B?K0tWYXN4dkdIVmF6VGpWMUZ5UHc0NnBSK2t1SVEvWDJmL1RrQVRlekQzVUlS?=
 =?utf-8?B?TlBvZlhNbGswNzgyNzdwNmFtT1grK1JSb2luOStia0JaemorMzBRV0FqNlBq?=
 =?utf-8?B?ZzlSVEt1OG5nd2E0enFUMTFIL0pMWE9CMzJFVitoUUc1aXFsREdHc29CZkts?=
 =?utf-8?B?SnpBRTh0aGdQcm1lQ3ArWnkyZVhONnZYMU9jMkhtNktkSVBraGk5Q1JUZnNL?=
 =?utf-8?B?d29heXhMZjgvUjl5QXVUTkxYbndZN0lESEQra3lkWm1hM21Pa2J3NG5FNlFi?=
 =?utf-8?Q?aS4TNHqU+a17ZbwhjsOZ2nYV+HoV/JLp?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWw2M0N0akxNUXpUOFNUZTFjTWxBTUloemFyMnFibnFuMUMveDArK1ptNFdn?=
 =?utf-8?B?RTk0N1cxSHFVWVhVWVQ0SDNrcS95Z3l4Tnc3MzNqZm8vR2V2bFkwVGM3YVFQ?=
 =?utf-8?B?c0FMdlRMQWJzT1g3b3FUWm13TUVxM3hkK3VOUVJlNSs2aEtVb2RXeEdyTXpW?=
 =?utf-8?B?dkkzOC81dGt6aFRQU25ndUk5MmlYcTZ6Z1FoTmk2b0laRU5qbHVVZmN5cGtr?=
 =?utf-8?B?YURvWDd0cnFTcEdYcGV0Q3R0MnJwcE1rRjVHMVgxQktEYUlqQVY3MTZYaldC?=
 =?utf-8?B?ZjZtZXJRemlVUExjZ3BleGE0Vzk5aUFjR09iUmR1SVRsMUkvS3JXdkJUemly?=
 =?utf-8?B?eHhiLytMVnRONkpEMTJNK3hSYlBGSy9JYWNnUWs1aHdxKzRNODhkRjRWUHds?=
 =?utf-8?B?M2h6S1ZRb1ZBMTg5Y3ZHdWg2TXVCSTViZXBrak9CVTJrQmVGbHRILzhkLzk5?=
 =?utf-8?B?bFdaSEVOUHQrMHhLa3d0elNIc3V3U1ZuOGlPR2ZndTE0cXlqY25ML24zSUVo?=
 =?utf-8?B?WVRqM2hSUUFLNEZjdE4yd0p1aUhsdnRNNml6OVNieXhnSlJMVm9VN2UwOXNC?=
 =?utf-8?B?MDB1empPTm5TcjNmNTQwempGZFpiV1VISjRWMzVSRFVpSERKbE9KWHlPRXU3?=
 =?utf-8?B?UDBoeFVIUTBTVWU1Ni85YmVPVVZMQW9NZGdudU04Sm11QmNjcFE5bmo2ZGts?=
 =?utf-8?B?eDFXLzVjaXc3WnFIYU8vQk12U3pKUWRDbFZneC85MklKL2xqMmhNZ3M0QXZK?=
 =?utf-8?B?VTh6RDdpNHczVkQySXErTENUUUJBa1EyV2NMb3Z2dnNKVUVsV1AwNDN5S1BU?=
 =?utf-8?B?RUp1eHJvRmI0bkNBOXFDQXI1U25vNTdvOWJ6REcrTjh4bkhONXFsY3o2d0Nq?=
 =?utf-8?B?UzZJNTg3TTROaWFjaVRiakFCUUZOMllWQ1p5ZmtZeSttL3ROMlBQeTNqKzhY?=
 =?utf-8?B?OXRFYUl0aW5XeEZuWDdYRjc0dms0cCtRYVJWRUFyeTdzRDZkbXFiQk1WYWtw?=
 =?utf-8?B?cGR4Y01veVJxdFQ3QzN1VFhUcVhHYkdiZ2NnS0tYbC8xNGp0S0JJVmJzaGxZ?=
 =?utf-8?B?OXhZRGQ0Y2JHZlZVNE1mSnJDR1k3aXhpNVpJbnB4VC85Q2tEekdIWWdIRnJX?=
 =?utf-8?B?dk9lQm41dStJNVBGaER5OTZ2RXpFR1J0RmFIR05ESDhUZUhhRWo1dFk1QWMz?=
 =?utf-8?B?dnEreVZOeE1SRXk4UExnS3M4cGFxSnY4YW9Yc2tzSWhXNDhTcHV0bE5GVGlQ?=
 =?utf-8?B?SFRWcTdUakh2WnEvYS9RaHQ1c2ZFemR3R2ltcWV5NkVGcXhuVW9uelo0Y3BS?=
 =?utf-8?B?dUhmT3ZkYkREUDgrNEJEbEptbVZpRXpXVCtueUNlWGlMaFlEaDBIRWR2a3pj?=
 =?utf-8?B?YUdKRkhQcmZ2QjBJaUNaRVQwQStyZE1KQzN5QzV1ZXdmWDVGZ3VMU05ZZVM0?=
 =?utf-8?B?eGtob2tOSUxUU3dUMmR2dEtqVVRGNUhBaERaL2xEZXNGZitlclhFL1RVZklU?=
 =?utf-8?B?WWFYODBSTzd6Zkdhc2N6ODVCVjUvQUwvV3VlTE9ueEYyVU1OUTlmS29TckE4?=
 =?utf-8?B?UFhSSkhUQW1LeGhHaVhtdGxCa0UzdytEZ3kyN2dwQXpSSkc0Rmp4N1FQSG1D?=
 =?utf-8?B?Z2RyK2xaSFlGUm0vSURnZjU5UCtvN1F1d2YrV3JBQ1Z1L0RNekg0NllmNXlU?=
 =?utf-8?B?ZlZ5QnlWbnhEcHZhTkJKcUQrQUU1NmRXRDBubFF2cUgyaFUyUzFtY1lwY2V3?=
 =?utf-8?B?Zy9iRUlGU0JiWWlGck5VWGY5VkQvZnIrTEQzSlNaZWNpa0Q3eE8zdEdpbzZx?=
 =?utf-8?B?aUdQeW5uaUhzOXZqek1RSFlMU0VqcEMrbHcyR3ZZcFVEUDlZb3ltdGhINDd5?=
 =?utf-8?B?blpNOHhLUkhQbzFHdVVGd2VjeHFIZjRnR2h5bFJzbU1hRDJOUi9vU2M4NmNI?=
 =?utf-8?B?cHlGby8zdDZEa2EzaVYyZGQ3VlQyU3h3K3RSYmFsZXZFQXFZdzAwb1l5b2Vj?=
 =?utf-8?B?K3lhZXFyMVZhcjlQNWxKVWRrQ0dtVk9Xak5oT2psclFkVk5kcUdJZ3E5eFFS?=
 =?utf-8?B?alc0ODJBM2hyZnRKZmVXUThIUVRZV0ZOMVI2NGYxV1Nja2djbmZrWGdSUjdT?=
 =?utf-8?B?cG43dEFrb3hjNDJZZ3MvWHJtM29vUWN2WHR1SmtxSjJ4RXdMbyt2SjNMZU9V?=
 =?utf-8?Q?tGraELlEVSxs4fSEUnSEKjZtc9KUTBuRfd+lM8u8FLV7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <96EE9B41D003634D938FF0FFDE9AAE3E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc970646-b03a-4f0f-b650-08dd76e18337
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2025 21:08:29.7090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6W2hKfuGzy7T/UIaGpJ87JHvv1LOYA7Z4yoztTWqGHI/mzS/YMf3KNRv8o2C0AhTJngLmfDtgBRBlmv9mGSHHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_140834_252157_2C4AEED3 
X-CRM114-Status: GOOD (  11.32  )
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

T24gNC80LzI1IDE1OjQyLCBhbGFuLmFkYW1zb25Ab3JhY2xlLmNvbSB3cm90ZToNCj4gV2hpbGUg
dGVzdGluZyBhdG9taWMgd3JpdGUgcGFyYW1ldGVycyB3aXRoIG11bHRpcGxlIGNvbnRyb2xsZXJz
IHdpdGhpbiANCj4gYSBzdWJzeXN0ZW0sIEkgZm91bmQgYW4gaXNzdWU6DQo+DQo+IFFFTVUtTlZN
RSBDb25maWd1YXJ0aW9uDQo+ID09PT09PT09PT09PT09PT09DQo+IC1kZXZpY2UgbnZtZS1zdWJz
eXMsaWQ9c3Vic3lzMCBcDQo+IC1kZXZpY2UgDQo+IG52bWUsc2VyaWFsPWRlYWRiZWVmLGlkPW52
bWUwLHN1YnN5cz1zdWJzeXMwLGF0b21pYy5kbj1vZmYsYXRvbWljLmF3dW49MzEsYXRvbWljLmF3
dXBmPTE1IA0KPiBcDQo+IC1kZXZpY2UgDQo+IG52bWUsc2VyaWFsPWRlYWRiZWVmLGlkPW52bWUx
LHN1YnN5cz1zdWJzeXMwLGF0b21pYy5kbj1vZmYsYXRvbWljLmF3dW49MTI3LGF0b21pYy5hd3Vw
Zj02MyANCj4gXA0KPiAtZHJpdmUgaWQ9bnMxLGZpbGU9L2Rldi9udWxsYjMsaWY9bm9uZSBcDQo+
IC1kcml2ZSBpZD1uczIsZmlsZT0vZGV2L251bGxiMixpZj1ub25lIFwNCj4gLWRldmljZSBudm1l
LW5zLGRyaXZlPW5zMSxidXM9bnZtZTAsbnNpZD0xLHNoYXJlZD1mYWxzZSBcDQo+IC1kZXZpY2Ug
bnZtZS1ucyxkcml2ZT1uczIsYnVzPW52bWUxLG5zaWQ9MixzaGFyZWQ9ZmFsc2UgXA0KPg0KPiBb
cm9vdEBsb2NhbGhvc3Qgfl0jIG52bWUgaWQtY3RybCAvZGV2L252bWUxbjIgfCBncmVwIGF3dXBm
DQo+IGF3dXBmwqDCoMKgwqAgOiA2Mw0KPiBbcm9vdEBsb2NhbGhvc3Qgfl0jIGNhdCAvc3lzL2Js
b2NrL252bWUxbjIvcXVldWUvYXRvbWljX3dyaXRlX21heF9ieXRlcw0KPiAzMjc2OA0KPiBbcm9v
dEBsb2NhbGhvc3Qgfl0jIG52bWUgaWQtY3RybCAvZGV2L252bWUxbjEgfCBncmVwIGF3dXBmDQo+
IGF3dXBmwqDCoMKgwqAgOiAxNQ0KPiBbcm9vdEBsb2NhbGhvc3Qgfl0jIGNhdCAvc3lzL2Jsb2Nr
L252bWUxbjEvcXVldWUvYXRvbWljX3dyaXRlX21heF9ieXRlcw0KPiAzMjc2OA0KPiBbcm9vdEBs
b2NhbGhvc3Qgfl0jDQo+DQo+IFdoZW4gZHVtcGluZyB0aGUgYXd1cGYgdmFsdWUgd2l0aCBudm1l
LWNsaSwgdGhlIHZhbHVlcyBtYXRjaCB3aGF0IHdhcyANCj4gc2V0dXAgaW4gcWVtdSwgYnV0IHdo
ZW4gZWFjaCBkZXZpY2VzIGF0b21pYyBxdWV1ZSBsaW1pdHMgd2FzIA0KPiBkaXNwbGF5ZWQsIGl0
IGRpZG4ndCBtYXRjaCBpdHMgYXd1cGYuIEN1cnJlbnRseSB0aGUgYXd1cGYgaXMgc2F2ZWQgaW4g
DQo+IHRoZSBudm1lX3N1YnN5c3RlbSwgYnV0IHRoZSBhd3VwZiBpcyBzcGVjaWZpYyB0byB0aGUg
Y29udHJvbGxlciwgbm90IA0KPiB0aGUgc3Vic3lzdGVtLiBUd28gY29udHJvbGxlcnMgaW4gYSBz
dWJzeXN0ZW0gY2FuIGhhdmUgZGlmZmVyZW50IA0KPiBhdG9taWMgcGFyYW1ldGVycy4NCj4NCj4g
VGhlIGNvbW1pdCA4MWFkYjg2MzM0OTEgKCJudm1lOiBzZXQgcGh5c2ljYWwgYmxvY2sgc2l6ZSBh
bmQgb3B0aW1hbCANCj4gSS9PIHNpemUiKSBhZGRlZCBzdWJzeXMtPmF3dXBmLg0KPg0KPiBJIHRo
aW5rIHRoZSBhd3VwZiBiZWxvbmdzIGluIHRoZSBudm1lX2N0cmwgc3RydWN0dXJlLiANCg0KQVdV
UEYgaXMgYSBwYXJ0IG9mIElkZW50aWZ5IGNvbnRyb2xsZXIgZGF0YSBzdHJ1Y3R1cmUgc28gSWRl
YWxseQ0KaXQgc2hvdWxkIGJlIHBhcnQgb2YgdGhlIGNvbnRyb2xsZXIgYXR0cmlidXRlLg0KDQog
RnJvbSBOVk0gRXhwcmVzc8KuIEJhc2UgU3BlY2lmaWNhdGlvbiwgUmV2aXNpb24gMi4yLCBNYXJj
aCAxMXRoLA0KMjAyNSBQYWdlwqAzMTkgOi0NCg0KRmlndXJlIDMxMzogSWRlbnRpZnkg4oCTIElk
ZW50aWZ5IENvbnRyb2xsZXIgRGF0YSBTdHJ1Y3R1cmUsDQpJL08gQ29tbWFuZCBTZXQgSW5kZXBl
bmRlbnQNCg0KNTI5OjUyOA0KDQpBdG9taWMgV3JpdGUgVW5pdCBQb3dlciBGYWlsIChBV1VQRik6
IFRoaXMgZmllbGQgaXMgc3BlY2lmaWMNCnRvIG5hbWVzcGFjZXMgdGhhdCBhcmUgYXNzb2NpYXRl
ZCB3aXRoIGNvbW1hbmQgc2V0cyB0aGF0DQpzcGVjaWZ5IGxvZ2ljYWwgYmxvY2tzIChpLmUuLCBD
b21tYW5kIFNldCBJZGVudGlmaWVyIDBoIG9yIDJoKSwNCmFuZCBzaGFsbCBiZSBjbGVhcmVkIHRv
IDBoIGZvciBuYW1lc3BhY2VzIHRoYXQgYXJlIG5vdCBhc3NvY2lhdGVkDQp3aXRoIGNvbW1hbmQg
c2V0cyB0aGF0IHNwZWNpZnkgbG9naWNhbCBibG9ja3MuIFJlZmVyIHRvIHRoZQ0KYXBwbGljYWJs
ZSBJL08gQ29tbWFuZCBTZXQgc3BlY2lmaWNhdGlvbiAoZS5nLiwgdGhlIEF0b21pYyBPcGVyYXRp
b24NCnNlY3Rpb24gb2YgdGhlIE5WTSBDb21tYW5kIFNldCBTcGVjaWZpY2F0aW9uKS4NCg0KLWNr
DQoNCg0K

