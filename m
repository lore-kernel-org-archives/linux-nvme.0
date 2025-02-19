Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5171C021AA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2025 12:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GxLSsAUezh0Zg7fzDAIm5WUJg1HmKmKlm++KzJmJeUA=; b=RfXOnqas1rrkE8VPLLo0T1Fugn
	v3qKoe83mb9CA2KiaI4xrGqa4A5DswAHtETHvzOyCgQ10wuz5hwS+FnU+iMdqBwOivjvhDVdrjknV
	hgHUO28TjZmlmiMxdjvWT2Cdf4B46usqClywyPePP2OSEwLcfKnNxYco4s/VC4tXXRjnIJnuPnKMz
	tP+xpcMY8CCo3LYYi4Nrj2JSS54XTzUX0JT428e4uIzJ8bFPg2TqJSQdOC0DXe58HejCLWbhhzx1i
	WxbCT/u4FF2XjiuiA7Mv5bVzxT1LhL6yBjd+XaOdTABPFNj1UNd7W7QpTwi0TcNTeDBtkTaPYp89r
	D8nCTQfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkjDO-0000000CfLB-0Sfm;
	Wed, 19 Feb 2025 12:30:10 +0000
Received: from mail-vi1eur05on2071e.outbound.protection.outlook.com ([2a01:111:f403:2613::71e] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkjBj-0000000Ceq4-0tvd
	for linux-nvme@lists.infradead.org;
	Wed, 19 Feb 2025 12:28:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOIBaBWbnkHokT4aDFhZ0Wj5Fqxqldj1mxUVfayslC02gWwn0BGrmDdMfJGj1nmNYW0nQXPrfKISF0tLbN4FOhfF9/DclZkIrATpxfsxOwSguytjAtKutLYxWlnhQk2pFErk1UJuNq8SbiWd5WZwzC7paZIOnwqkkIr3DcTWp1ByfzRJeIA6RdtKZusp4VT084LUPXax3tw2IkSdfzXZ2+AS5Bzw3uGsvfg49HwRcJc2ZPj7LgW291d25rbUrZIavskG+D+mGLfGd1P1Ph4QnZj+TsyAEes+GeGuvMDijEEMQ0QXExWb5cR6RHB9Ee9Y4d5krh1nHWn313xX7Fumyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GxLSsAUezh0Zg7fzDAIm5WUJg1HmKmKlm++KzJmJeUA=;
 b=MP6EBwcLAaT6zAH4NEIvlZ1My/2u3mUFUWO4pKu2ToyX6S97X7/jf+XJpHF/Iq9dXgxdsKXxISMJ2kJ7bHCr1Ac0ycjbjeY/9LEEbD9gbbVrhN62KMspgxyFa44bxnzMYuQn3kQ4e5spMQg1WHQIrxYlGSCkujKyXRPUN+rgkK2SG2KLW/MJ4PPQUGuOzt/IvlE7i++9oZuWJ7OtRbj/AyLFHGWpxUSB1jUe75pFJtzGR7B9pDxR8mu2L92ys5Z8UKgBp/8/2a2m5E6UJaQQ6p5ulXUKjndfcio62w80xP63lGnsTY2O5vXTeq0echpNcX3QDHOcSgphgNhDi7zPVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GxLSsAUezh0Zg7fzDAIm5WUJg1HmKmKlm++KzJmJeUA=;
 b=GnNJNr7cMyYAWav6+vb4YirZmxJfMWK8bHIAbWBC/Tnbz8L3QKempNcZONgfikA4ECu+9nPn50CX+h7w+9f1yAXnlKqk2pW4x+U4mW9/ZhXYFHkxPBRQZfXeqREFuISBdavvLErfK6kFX/rejzu5hJraAQrMmp8kucNAiiY63ydBU60fHJYqLEkvvSvZAKfHh6gBBiRpoMs1TMNriWYAKLtAVXti9RyMQgRvtOJXH92Z/o9yiwkdBzolkdsa5kygj9nTvIUFo7r9Jxww5fxjXrr2DZK7sMXSa+z6vxa3eG8SJrOK5irx4Hc9a5/Jbp3fBlvEU0Iw+k8IuquMApI9VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by VI2PR04MB10740.eurprd04.prod.outlook.com (2603:10a6:800:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Wed, 19 Feb
 2025 12:28:17 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 12:28:16 +0000
Message-ID: <5ab82e6f-5bcd-48e1-925b-d9e4d65d728e@volumez.com>
Date: Wed, 19 Feb 2025 14:28:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet-tcp: Enforce update ordering between queue->cmd
 and rcv_state
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20250217142210.2144548-1-meir.elisha@volumez.com>
 <Z7SlAMLxwjuRwEBe@kbusch-mbp>
Content-Language: en-US
From: Meir Elisha <meir.elisha@volumez.com>
In-Reply-To: <Z7SlAMLxwjuRwEBe@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|VI2PR04MB10740:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd3661f-b185-4eb3-8a60-08dd50e0e2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEpiQzNMMjJhanRBSlBDZU9EWmtram1VV0NTeWxoT0lNZldOMWpZc2dqSmNi?=
 =?utf-8?B?ZGtuRVFyTjlYT0l4YzZIOGdEa0M1MXFqRWV3NEZoTDVTRlc0RnpoZlNJR0lr?=
 =?utf-8?B?UCtpY2cvdmVPMHhXVTIvbWF4R0xBQ3ZMSklQUzhULzlXUE5GSGpSdisrbXpz?=
 =?utf-8?B?V3hWdFlLYUZNK2Vyd2thQnpyVU1Md2xRZ2Q0b2dFaHVWZjVDNi8rRGpGRnBx?=
 =?utf-8?B?b0Q2S0tWaXVQWnEzaTNOQVJpOTRsb25jbjliOEUra0NMeU45aE1NTGRzZW5y?=
 =?utf-8?B?Qk52TC9QbWJtbEQrWThDamVtbnBEdmJNYStFbHh1R0x0WjlXZnJONnBUWDVB?=
 =?utf-8?B?TEpBVXQ3T3RsQ3M0UW9RdDFWSXV2OERPSStlV3k3NDQ4QWg1cTdwYXpqN0hr?=
 =?utf-8?B?bVExV0d0STdDVUpVSGJjQU41MG40Nm90Skg4cGJsdThZNmMyOFdsSnNYbXlB?=
 =?utf-8?B?alcrZXUrWElaWkhkbjlXMHlZNzRlTXRod2ZrQ2JwQzBseXhubzZKbldZam1S?=
 =?utf-8?B?S2NFaHM4WGt6cCs4dXpGcnlSQkxWTDJtT0dUMEFta0gzVVVEcUxNeVQvVjlJ?=
 =?utf-8?B?N2RUUE1nVEVDc2JLbWNBT1ppZnBJZlZNcHdOc2tUTllualRMZkdnb0xQM3ho?=
 =?utf-8?B?czJiQjhocTdBT0x2Wk1mbFM3OVdqcTd6TVp3RGQzR1h0eGhoNld1bDN1Zk0r?=
 =?utf-8?B?RDdTcWRQaGRKWVpELytkak5XYnJBUmUxalFJclFCU3NGL3haNDNjNnpQdFM2?=
 =?utf-8?B?WS9RdkVuNzNMYWYrMXJxak40c3hwcEdBNEFEUThEUUhwaWY4YnQwTFdyeTZI?=
 =?utf-8?B?bXdYNkthVjVjVGVXc3VsN0Z0OFpLNDlRWXpwQmJvZDlSRHJSVXlRK0FubVg2?=
 =?utf-8?B?RndGaThlY1pXa2VHdVIvcHFiTWVXWURWWTVaRVBjVFZRYW1Lb0VscHVrbTc4?=
 =?utf-8?B?QndMeEhkbk1UTGtLT0FVRTEzbHk5S1phR1MwdnYwRjRjLzBIRXZ6ZVQrTjgr?=
 =?utf-8?B?TE5SNTdYMExpZWR3T2crVzNhMDFGN1hYbUFHcXhST2NCa3M5R1QyMC9zTlAz?=
 =?utf-8?B?Qm9ld0VyM0JYL2dGV3RvZnBCRldrZW1kc0JCTjRCRGl3SEVweS9vbCtDd1Nz?=
 =?utf-8?B?NFBnMkNZVW90NUdSV29Ka0ZRZ3FhWCtkYXdtY0VmdjJBc3JHRU5UNkVkckZZ?=
 =?utf-8?B?NWFjZ1pLWk9CZjBRZWV3RDBPY2J4dEpyUVlWY29vbVFhYjlwbngzQTBGWDgw?=
 =?utf-8?B?RGpRbDNsenRHRENvQnhvUVhMZzJMNkVLbWd5SFNJZEJIWExRVmNtb2FVZlFa?=
 =?utf-8?B?Kzc1b0lWUDlsczZHem11NlBrTEE3TjhTckpxdnBqdERWaHk1NzBSZTFSRTFO?=
 =?utf-8?B?cFJjT1BETjZhUVpPU3gwelFtTFZTTmxqYXk0NlV0UGhUWjNtb3BrOGdOWXRn?=
 =?utf-8?B?MytRRlgzMHVKZ29jU0owRzFxNmszVXpZM2Q3eEpzYUhSZzBzVUhMVzI1V1ln?=
 =?utf-8?B?ZmZOaXgrUFJwU29RQWxGcC9EYVFVRk0veng1R3ZnbnpSaHp4dEVMNWpXR2lG?=
 =?utf-8?B?SHNnNkcycUhFWG5pTkVsbHhHSzdrYjRxMkZNMTFnMGY0VHhRbC8wbC8wc0p2?=
 =?utf-8?B?UHdtMWk2N0tYQ3QxRC96YmVJbmFrcU5tVzBIZmF4TlcvbStwdHhLMVBEalhP?=
 =?utf-8?B?bno2UjdpL2xmVEcwV21JR1FveTZBUmZXUlRBcTV2b0Q2QUV5QVk5a25Xc0R3?=
 =?utf-8?B?UGpjaHdnUjBBb1JVM2lwcmpMS2hGclFob0dGdGczSGttYS9lTE1DUDBuTUkr?=
 =?utf-8?B?YUlCYzlhVkpaaTdRelNiT3Z3cHlQRmxCN3Rha1YwWVU1YVdlSzQrSzBHbm5k?=
 =?utf-8?Q?iraBj6sWXqsSV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0lwNWV4OGJEVWo5WVFmK0xGQmcxaGlza3liaVQybWJpUU9TVFRaa2dkSFZC?=
 =?utf-8?B?bldtWHplcTBreUtWWUtHamdCSHVXRnIxdjBId0lzZzljamZCc1ZUdjBRVVVh?=
 =?utf-8?B?eU9ldEppVUlWbGVqSWk0THdSaHlqQ05KWHN0Wkh2b3BMdElQMEFCQlR3aUtx?=
 =?utf-8?B?TjZUOVI3SHpjYjZua212bCtWRis2dXhtL2RDYkF1eVdQemNjRGR3aVU4R1di?=
 =?utf-8?B?MEt4S3U3Q3h2dC8vUkNXbmZXbjBabm05bUtJeWorcCt6VXdFZWQ5UXVzUHZE?=
 =?utf-8?B?cW5vZ1EvbjNxQStGUUlMMCtJb01VOTdueFVzR2R0bkc4Q0RHNDUvY2pUQ0ht?=
 =?utf-8?B?TW1taGR5MEtsK0ZWdVo1QzF3MzM1R3lkWDAya1ByRVZEVGVVQ2dpdmh6dCtF?=
 =?utf-8?B?YUs5bUUzK2NGelNYV1kwcE1PZzFGVzl6VlRsSDh4a251VVRsTzdJcjRKQzQ0?=
 =?utf-8?B?c2NWemJPZWdhTUQ4Z1Y5M1FmcGs4NHRmQUVsUXJZeVVOdFBTZ3dQd2h5M0hX?=
 =?utf-8?B?UC91blhDckJIbkxRT3VJdkd1SG1xcldMTHNLd0dHSi93anU0bXFkREdBWVlT?=
 =?utf-8?B?a0FCK21lOWxtOVQyTUI4eXlYaDYrYzRRalU1NGtQcUpBc3RnT1NuQ3BrM1lN?=
 =?utf-8?B?VG1Ja1NJRi9oWDVGVTlwYUF3L1RLK0JuZjNySjNhUWNZUXhqU21GVStVQW9L?=
 =?utf-8?B?UXZwNXk0S0lvMDZPUU02N0VCZ0twTk1ybTNnSWRMUXd1bXUzUStLeTdPQTlK?=
 =?utf-8?B?SnAxMnI2UzhHZEtubC90M3hWdE85anREOHdYeUVTVGNqNE5sMFlJMHBBR0dU?=
 =?utf-8?B?em5JRnlvS2lkNVBRam5Wdkp2NW45SVkzdjRtMjJNMk5ZM21jcjYvQTdIbGxI?=
 =?utf-8?B?bVZwK2tNMEJSdVROZUdMeER6YVo5cWJKTjZCNnRIaXl2V25DMGlzOWNhUDhT?=
 =?utf-8?B?S21tMnhQTDJsVkFzWm1LM28xdzh0S013R1BCQmVYY1k2YWxuSE52Nk05UEh2?=
 =?utf-8?B?Q0d1RTdWU2oyZVFzbHYxbXo1clFlOUZDb0ZVSldydXVCOVZFYVZGYlZtdi9L?=
 =?utf-8?B?RzBIZWxiOUlRdjMvRjBweS9LakdKbjFhY3lodW5nQVZmdFB0aVU0elIwN3By?=
 =?utf-8?B?YVRYRjU3dGphMmtpZWMvN0JudGIwUnVQb0RrOU9XK2hzVm1tSlJyUUcvdURa?=
 =?utf-8?B?Ky9uczM3MEV0ZVoxcTg0bmtvdHFNdHl4QkZmL0x2dGRXcTlDR2ZvUy93SGI1?=
 =?utf-8?B?OE5wdjlzRFoyeWpQM0RZclNDb0hTcE1WN3RrNFFYR3ZtRGU0T0x4NVh1R1pY?=
 =?utf-8?B?N05ycWxxc1FLOHJQam54cVVuRjhZMWFYYjFMVUFoa2FXcHVjTWoyZDIzQmU0?=
 =?utf-8?B?MUlRMDlQUmRaYmx2UU53a1RMQk1nOGZ3RFJaWnJlS3YzYkIybCtkdGNaY3hn?=
 =?utf-8?B?Wnd4OWdiNXVVZTdnd01md1FGd0d0bnpmYjdka3NXVEEwYi95VVZUM1FIUDZw?=
 =?utf-8?B?dS9oaC9jV1dFRmN4UHBBWW1NdlZvMkFGVlFKM2JqamZBN3p1dnpOT2JwVXly?=
 =?utf-8?B?QU9Ob0hRbW96Nnl4VjY1VGdUU2pNMVdEY3M5RDVNdm1kNzRGQm9OTjM5bjhX?=
 =?utf-8?B?Qm9RSG9wM2txYVl4bm54SlYxckVqTmU0WHl0OEl1L2RFaHFpWEVyWHQ1cU5Q?=
 =?utf-8?B?Z1E1YVVKOWk3MnBxdm5YL04waDFNYmJvOE51UU1mQmg3K2dHMU16bGxkdUx5?=
 =?utf-8?B?N0owaGcyUzViTytmcklGejdZakY0c214VnlaaG9qcFJSSENuc0M4RFphSTdY?=
 =?utf-8?B?SjlaeHZOZmw5c3dwcDEyU1JaZFppaUNobFk1S2lnM1BJQ0tHdlpQYXFIOVFW?=
 =?utf-8?B?TWRmR3d4VVMzU0N1M0hQcks1V0E4SkE5YlEzdzF4LzBzOThtd05WaCtaNFBV?=
 =?utf-8?B?aHJtVm5NWE1TZ1lTb0pVU0pMMHc1RTBNcHpoK0RiZFg5VGhGUk5KU2JnSTBN?=
 =?utf-8?B?TUxCR055SW50bk9MZ2dOajl6ek41cHhNeEo5eVNmT2FDZGRCQVZwd0dSZ3Mx?=
 =?utf-8?B?YUQwSnpGV3NTSVJ1OUJJaFpVbURiZDFPWWRSOWdadlc4M2xYaHBrN1NUZGVU?=
 =?utf-8?B?R0gwM2tNSEk0R2lGVGtOYlRkMXZ5UW4xWDIwOFdKeDlTYVRWZFU4RFF3NzRi?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd3661f-b185-4eb3-8a60-08dd50e0e2f1
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 12:28:16.8414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLO6/5kqUcfw2Yuh0BY7YBWenRsdGqSG5+VwmEZ4tWRd1JK4CE33Oh3hK8ZEMc0PzZr0t1PZjLEclb41gIoYUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10740
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_042827_269150_977E9B7A 
X-CRM114-Status: GOOD (  21.40  )
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



On 18/02/2025 17:19, Keith Busch wrote:
> On Mon, Feb 17, 2025 at 04:22:10PM +0200, Meir Elisha wrote:
>> The order in which queue->cmd and rcv_state are updated is crucial.
>> If these assignments are reordered by the compiler, the worker might not
>> get queued in nvmet_tcp_queue_response(), hanging the IO. to enforce the
>> the correct reordering, set rcv_state using smp_store_release().
>>
>> Signed-off-by: Meir Elisha <meir.elisha@volumez.com>
>> ---
>> v2: Change comments to c-style
>>
>>  drivers/nvme/target/tcp.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 7c51c2a8c109..49ce2f9ac6c8 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -848,7 +848,8 @@ static void nvmet_prepare_receive_pdu(struct nvmet_tcp_queue *queue)
>>  	queue->offset = 0;
>>  	queue->left = sizeof(struct nvme_tcp_hdr);
>>  	queue->cmd = NULL;
>> -	queue->rcv_state = NVMET_TCP_RECV_PDU;
>> +	/* Ensure rcv_state is visible only after queue->cmd is set */
>> +	smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_PDU);
>>  }
>>  
>>  static void nvmet_tcp_free_crypto(struct nvmet_tcp_queue *queue)
>> @@ -1017,7 +1018,8 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
>>  	cmd->pdu_recv = 0;
>>  	nvmet_tcp_build_pdu_iovec(cmd);
>>  	queue->cmd = cmd;
>> -	queue->rcv_state = NVMET_TCP_RECV_DATA;
>> +	/* Ensure rcv_state is visible only after queue->cmd is set */
>> +	smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_DATA);
>>  
>>  	return 0;
>>  
>> -- 
>> 2.34.1
>>
>> This ordering is critical on weakly ordered architectures (such as ARM)
>> so that any observer which sees the new rcv_state is guaranteed to also
>> see the updated cmd. 
> 
> Something seems off if smp_store_release() isn't paired with
> smp_load_acquire(). Why does the reader side not need a barrier?

Hi Keith

Thanks for the reply. After reviewing the code again, I think there may
still be a race condition here.

consider the following, worker thread executed the request (queue->cmd->req.execute) and before
it regains execution,nvmet_tcp_queue_response() gets called from another context.
It passes the first if statement(queue->cmd == cmd) and just before evaluating the
second one(queue->state == NVMET_TCP_RECV_PDU) the worker executes again and sets both queue->cmd and rcv_state.
In that case, the second thread will mistakenly exit on the second if statement causing a hanging IO.
I will create another version that declares the cmd and the state as local variables in
nvmet_tcp_queue_response (using the read barrier and READ_ONCE) in an opposite order
which should enforce the correct ordering and fix the problem I've mentioned above.

