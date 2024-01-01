Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A19C47073
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 17:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XNHKzw39t71Dbm4C1wiLQ93qBmjns/ke8u4tsLbWZQQ=; b=B/mxo/EXSAaSp6Dz363UMMYwz5
	1S+KfoLiYDfFIHDt/8hBDayhOetcmLMhI+0cTqgqGAwa9tyv/nh4tKYFrkZ2tapEY4Kw4GBNloFRo
	Y5JTuhpfjkq/C/xC3U3mV3W9Fic6zjCd4Z7E6jMzXNZ+rLkuuXFpZIgKWCQTtt2qQn+LGqC9MM0+t
	tf8Fjj0e2ZuoP1oH0sHj1xvlFRVPDFpuLZVKppcosNE61HmVOtNS8S1yWpiR1Agb+xNM1kVfyv88c
	W8J3/9SUD+V7Cwo6Os1UsIfB+JnQnKrTZ4skvB7LOaZzXDbGzyPx0B9BsFtXA1/Yv7NYKG24tV355
	+r3NlD0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKLzi-006Z2d-07;
	Mon, 01 Jan 2024 17:22:30 +0000
Received: from mail-bn8nam04on20626.outbound.protection.outlook.com ([2a01:111:f400:7e8d::626] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKLzf-006Z2A-2e
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 17:22:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9lqbWygG9dqWxTXw6iNFpOkj+PvhY44pbGYcgpBS4ustnyW4Z44eh5KRWsvJW9Ejey/Kges9WF/1IyT7UQMDsomxSU6GeWFcNOnI9ClblYmT7wQgX5nslld06omHtN+xBdbbHlprIHKRJVYDTGPTFiHidblPBtQ+IKKJI1W9iyt67NKnc4WIF1JNHNnAKX0q5jKq2PFfz3nAyEpiOgiV2ANp/tn0zlJNDw/3YNcxlloRzNEfQU9/RvkHuj7972l76flsjSvjZaB2XLsHX9Ru1EEnaItqpTR9u43XVUKL9rtsizzyQsPYeWJv2E2wwn6OPaWCg0HAe2jWfZ/4I24dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNHKzw39t71Dbm4C1wiLQ93qBmjns/ke8u4tsLbWZQQ=;
 b=S7VOdOyO07A4Hr9WpgzlOPjGsm4Y6RbG1RTR634NHayaGzXV+eD6vHufjnsLoEFsOf4PDfpW9u65v6CiEPI810fCtKnK+TyHipjMtsqm6/y5XyP580gQKuKmR8VP5uSmzajkSc0F0eBDWEK7M06SuF6NjdwobYz4vR5jfptwIUV8U2fq5hWnrZafJ2fYJ1TzPdlDRAMZFtcOWMUZvPkHjrfT32BDUhjpelB+V7VvsdhWbB6FGaFqfoP0u/Z9wg5iaGLd8eFvxBqmAeJLDbom08WR9paFLPY0Jtpx0iGXcHv7mkB1W6ebhJBXWnW94jFUd7AzQmlwXo0jpaHw8Uec+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNHKzw39t71Dbm4C1wiLQ93qBmjns/ke8u4tsLbWZQQ=;
 b=qA3Owmg1CGohK9eMX6KQtXqjz/JOWXgcP7chzU2QPpBRTWFxOM2CmXzoGgO9AotrfrFpUUKc9A0tGMN1kIMjl1xHh6ZHC1P+yVrPqCeuJwzDXJj7cuV+18UjDyDlpaYySh5zjjIfuStXt9srePORf/0RhxS640Z5MWN+6jmeryp6wZ6MkSRha4KkmfOKxtZSgoca+Ap0+YmSpmGjXrTmUj0He5aT/L0KOvs7VlVLhAaIwP9DDKMMRLdabNWFFFWZl6kPYi9tWj+7Sfg67vcaF9RAo1oZwvfCgap/tdNciMAHPoPmIoIQvUdTc/0DgjuOlti9nALBcrgRddQHYvaagw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Mon, 1 Jan
 2024 17:22:16 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7135.023; Mon, 1 Jan 2024
 17:22:16 +0000
Message-ID: <1633aed8-47d3-4998-b2a8-394783adf899@nvidia.com>
Date: Mon, 1 Jan 2024 19:22:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] nvme-rdma: clamp queue size according to ctrl cap
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-9-mgurtovoy@nvidia.com>
 <764288fe-0a62-4c22-9f10-307d5a156239@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <764288fe-0a62-4c22-9f10-307d5a156239@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0419.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::10) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 2184c5db-f67c-4a84-e6dc-08dc0aee3379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qs/YUuF7+mhcENXb0FG/NxQiAUUshcdVH08lVhtVDgbAbcdsN8NGIhr+tUguVahgeM89b2spIhpQ8zfjEliXvMLVndf38Zj3bUeRmTlj4noMBTqwHiVamoni3yrK7QEhaqZMwvumwcKCu3E3JS6YT//AB9Hz4D6otFXmpKID08Skh5StT73Z9o5BtHjQ/vxutYilhaLGwYj6/fJZqxGpEzEIybGS9710bN9buiOU++L1dBHMwjU6ZuR5H9JcS9XvDKFwiPsgTbjph3bN35v5YO53r+8o/F2ayOi4hz0dB16H5l6MSIJ0bWy7nRAuLiQwbBP1qbGt40AACUZYUfNxZIpyVvvzwOCgPvGOK9xrfWWlesY83an4J1oA9Ot+l4tzoJR3vSfYqYYWtkHrJgDqlROF6dhkYh9ITWBAgQyjvHWGVI2oGpeyXR7GOOGZXbqoek0xnnrYlYOeVTbD+RfSUwlLZaasiFYh+13VZKOtW61gjqAuYOvlmHj0UOhdtpuRWW/jpOz9Qhu8CsmL3cwjZ8I7AuNsaqoFyXKW5bRD7yzhyuqxE0sqika89L1X2bAjZrptZs/rd1+RajTEwXq/QO6LCiucp6cqAUS7tAZHUfR6ho0apP1XXvnGUekp/dg3QD3MMjOKKvbJ7838Ue03VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(38100700002)(31696002)(86362001)(36756003)(6512007)(26005)(2616005)(107886003)(53546011)(6486002)(478600001)(4744005)(2906002)(66556008)(316002)(66476007)(66946007)(6506007)(6666004)(5660300002)(8936002)(41300700001)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVcxN3hRMS94dW5DVFByYUUwSjV1NGFLdDcvcm50cWJqTmM2cStCQ2s0RHR0?=
 =?utf-8?B?MHBWMS9CNHNIbGhSNXdRcE1tejVzdXd4eDBQaFZKem1HU3VtTjVTd0FVVTBZ?=
 =?utf-8?B?Z2UvS3lSSEE4cFdTdEhxdjd1MldRbWRBWUdCeTlaU3R3ck1lUEJHdVVBNWhk?=
 =?utf-8?B?aDZSTk5HODJTZ0VMckhaNmNiMElOTFJPaHc0RmhsbjlqZUwxajkwaER3RnhX?=
 =?utf-8?B?RDR4d1p0bkwrcENxK0dqZHpxUTZiY1gvbTd4YWtIN2Y5WVE0Mk1nSE44b1cy?=
 =?utf-8?B?c0JsdXl2VXdtK2pDS2RnR3R5RWZRb0FnNkFsWVhXSmh4T1lsUzhTWWk3MkNz?=
 =?utf-8?B?UkhjbDIrVUhNVS9CaXV1YW1HNGFGY3dBcmM5UjRhTHpaSHRITENaQnZ5cG1C?=
 =?utf-8?B?T0JDV3BLSFh6cTVSUCtzRVVSSlQwTHBvdDFJaUFWODJoWnBhby9LUDl3cjF2?=
 =?utf-8?B?anEvQlhVc0phVFhmdVJoNndKNzE5RUM4UmhaMXZEeW9CZk4wQ095QWhsZkpM?=
 =?utf-8?B?emlMbm1nanZQdGsxQzY1N3lXOUp2aFB1LzBnUzhuOVJ6Z0RjcEpFMFBHSnRL?=
 =?utf-8?B?MTRaTk5hMGJ5akE5aGw5SFhqQmhRM2NRYlUrK3RTaWtGMGZueHRmY0Y4bEVv?=
 =?utf-8?B?WHBkQk9TeHBtSHdIZk1LdnI3aGhVU3R3M1IxMzIxd0t6ZERYWkN6T0dCWXhj?=
 =?utf-8?B?Sy9xRnhsTnhxa25qR0FwNmVJc3RQSnJGbzg1RmVIbitoVHVsNU5pRldKQW1B?=
 =?utf-8?B?TlJXN3VodGVITW1lZ20rSEFyYjU1QS9RU3ZyRnk4a21Vejh4TENlczFXVmlG?=
 =?utf-8?B?Wjc3cGtoOUVMMlpobG5FSW41THFtWGxaVkZQQlRFZUMvOEtqYXBTdmlYdjNE?=
 =?utf-8?B?YkpNOE5xV0drMWExd0lDWDBMMmVDUTBUMEZCSStxSFlBRWZheVlja2RQZTJM?=
 =?utf-8?B?OFZJWlhSaHJqU2E4K3pBeGtEUWhUL2VwYTZkRlpoUkRzSzBibFArNGsyN09z?=
 =?utf-8?B?Tlg5ZFRtbUtGVVNaR0xBQlFtbnhPRk90WVQ3Yk5qVWw3K0ZVYXMrcXBCaFor?=
 =?utf-8?B?aTNhaGZ1Z2pBTXRBc0M1UFc4OHVpR3B2RDVHcW5ZaDM2b01SSldGRFRMMHZq?=
 =?utf-8?B?c01yVmd6dU5jZGhPYlFEQzh1UjVVMllicGdyKy9yTjlHZGlDMFlta2NCUTVS?=
 =?utf-8?B?cHhyV1B1SWdiaEEzeUJwQTdReW43VWwrOTZxYlMrTndKTXhvUDA2V1FnUE1F?=
 =?utf-8?B?ZVBoU1QyYlNHZ3NWN3Z6WHpnL3J3UE5yMVZub3NTamZNN0UxcG5jVnZ1TlBN?=
 =?utf-8?B?WGliZ25vSDAzaktlTytGZDNUbXI4Y0QrVmtVc01zbi81cTVJNENGa3Rrb2hW?=
 =?utf-8?B?NFQ1S0pZZE44bnUybVovWWg2QzU4ZCtGeGVlU3hoc0xBM0tubUhERkxiaGZ3?=
 =?utf-8?B?YXdlbEw3b1crVGZ3WFJPcndPbWhsUjIrYlVHMEUzZmVnKzUvZytDQXpBSFo1?=
 =?utf-8?B?eVY4bXlaWkV6Q1NGUTdTaTdZZFVHRjZmWXNHTGkvZ3B6Y2JCekxnQzJicU1t?=
 =?utf-8?B?SkhZeUZ3SlRjR1VqM0M4eTRTYTZRSEtUazZKMDVkWTR3WERHY2lTaEkrM0dE?=
 =?utf-8?B?L0dxN2hLY1g5RWhqZE84MStWRHBXMVpndVR1V0lzU1QvcVJseXA1eEpBc2VX?=
 =?utf-8?B?QWNBU1JoWUJjZExQcVpPOFRPQWJpbWx1RnJYVnVQaW0yVnorZWZtMXBFemNS?=
 =?utf-8?B?SE1oSTFnTWl4eFExYmpmd1FWZGQrRE5FZjdUdStiS2tyNlJvYkhWSWt5Wmdx?=
 =?utf-8?B?MGlvV3d5WE5KRXVGaXNwSDd6YlZWMWhZVTJqem9MR2NJbWxhSjRKWjhXZ3JL?=
 =?utf-8?B?QXdiWFI3UVhBU1ZJUnEwZElTS2pEQVVOMzNUSzhOZWs0Yi9tdFhSNVNjamNl?=
 =?utf-8?B?aEh6eHlFM0pLK09paVM1Qi9EN2IwYWhRSnlZR1Q0SHhJTDNlZ3dhaExheW5x?=
 =?utf-8?B?QlFJdXh0NCt2d0dUektRWHIzaVJzYjZwRmR5V0VZaE1nT20wNEM5VUNmUnZI?=
 =?utf-8?B?WWhoZ0I5SHhpeDRQL1NHNEV3WWpTQTQ2NktGUDNFcW5WY3RNVHNId0E1L21O?=
 =?utf-8?B?dUxRS1Y3dlZ1enA2RmJ2eU1rdVZNZGFiMXV4aiszNWVsYmxKV0NaeDBiT3Bu?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2184c5db-f67c-4a84-e6dc-08dc0aee3379
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2024 17:22:16.4861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTdzV5XdwSuD4vW5zwNzxFWfC192w3QjLe3BWI5UwttEdkGG1ESymD8Vf5zUcAhvqtzgCk8kLvo8gjT74vI2Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_092227_916503_BD325C05 
X-CRM114-Status: UNSURE (   8.76  )
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



On 01/01/2024 11:35, Sagi Grimberg wrote:
> 
>> If a controller is configured with metadata support, clamp the maximal
>> queue size to be 128 since there are more resources that are needed
>> for metadata operations. Otherwise, clamp it to 256.
> 
> Does the qp allocation succeeds or fails if attempting to create
> 256 size with metadata?

It succeeds (tried ConnectX-4 and ConnectX-6 dx), but there are a lot of 
metadata resources we allocate so the scale will be lower. I don't see a 
reason to allocate more than 128 entries for metadata controllers.

