Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D45C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Feb 2024 13:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kR1cRNpw/tjYJIkCXcemjbVg5+fxcDTtBfuNlTjklIQ=; b=SOG9NomWVGPbSnjeIbRIf8u7tZ
	i+bzNtyPXPZa/7BBM529jWPz6G9L/k55DGEbRyCbc0zQHDt8YWvHa83ud+H0cUnB66er43tC3lRIt
	2JAAZOTNKIft8zzzFh12VQJLIuU3xs6jNqtW5kVzI1XzCmbJSUEtVT48oZsonITpPfUYx3E8SZ9VK
	JS9QOU7EyO6bM/LKTgA2O6jX0EYzNqQPzjiN5DLThvXnN8/qLCHoiYr/Y7zL0IFpfjAcvHi9x90tP
	Z5Fzx6UawD6ln8H7dMOcb9vlbre8hBTBEWR87Dyv83V1vr6wlxUcXMufylEk1uEuajixdksaql5uP
	l/4cy0kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfgUe-0000000DfgR-1qH3;
	Thu, 29 Feb 2024 13:30:36 +0000
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:200a::600] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfgUb-0000000Dffe-3sL7
	for linux-nvme@lists.infradead.org;
	Thu, 29 Feb 2024 13:30:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FieARNAiSldFouu6CXW3aMB7lVoL9QddyJKD45YUO0dh+zJtL9uqJchidXt2E+Nol3kLZxEUEdjTnVfwyj5uO+RVlskYRaj1+8bp+slXi9AR5PNNNWTsmtB/iWsCFmCGxxIGeXVDEO5Ku7jrEmXRtkI8Ucf8cYpcDizhsq2vFteUPHG+51M7lRD5gdYconeXf7XtcStL/Hm7orwDU7a2M8sqi0WaOAI4NTyS6ItQeTrNYR8g2hXFReGfzqa6hT6L0i3ZKaFE9ZZE7YPJY5wljYTUHPTAMXqzRA3U/e6F6mPXGBcI97UNlB83pBJJTy+GLIcrpu+sZOuCaCPAL3tXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR1cRNpw/tjYJIkCXcemjbVg5+fxcDTtBfuNlTjklIQ=;
 b=Ull+wm+pK6/Wwcqyw+XDO78a/II9Z/qb1/OomTK3Si+JU/X/Fef0yZx5iQ82Mb2+HVITT3zON0+zN9LtatRso9ho9zGV6qkl9cJzhuXf6qGK11NM5gEEVYHM1RWep3I1n7XcCGnyZA8vd9YJlRp7L4onncVSc+cTW7X8MImJjGKChhZr9TBQnCYXqGfjT8eaOwrlHADXhRwJX7e4H+4GfyuPCY2WN9sPWOJpdTjJ1P15dL0RyeEhe/ugYwZDifqpENd74rYLmYY7Tt4TZXmxkCHTme9Go2+gbL4VFPoY3kDDQpeZgRctfSm1hWAQjsiuga8FwskTp4Emb+CHmSHWNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR1cRNpw/tjYJIkCXcemjbVg5+fxcDTtBfuNlTjklIQ=;
 b=O6CpvtgtSKHNBB4YIiitwPZ/FEvy2G5aTwe5ffO2S0GTIm0KXUAsia7VUgiCtR+lwerOpaGHbBTSoVf8bQYYNXIzQmTLe0+FHl54w0o205xVkbQR9vrhmr7tW1Eu1R645J/ikdtadKbcJ3vJx50GzZ0l/SA5CJN4aF3LfGXq6i3GmefMkA4lbANGZArF6V8RBAbo6DzLXLk3vUdnuhC81dgDBOpBGIpmrTpazo9I22A42ockbXY3PR3k9i3U8FmARx3LCCdqCfPebnmHbpKHKCTDqh+9jteH0HH5S6v8eIX/xutBO/BmXxKbnWD8f9D9gy8udCHXLPqCPMD/8703mA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SA3PR12MB9197.namprd12.prod.outlook.com (2603:10b6:806:39e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 13:30:29 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1%3]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 13:30:29 +0000
Message-ID: <e8a57b1e-7884-497d-b090-4a3967104063@nvidia.com>
Date: Thu, 29 Feb 2024 15:30:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/21] nvme: move common logic into nvme_update_ns_info
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20240228181215.873854-1-hch@lst.de>
 <20240228181215.873854-13-hch@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20240228181215.873854-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0259.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::9) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SA3PR12MB9197:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0bdbeb-0174-418d-337e-08dc392a989b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vq7gufvslyAj+gzr6qfKeJSsrHFulj65lnsuNpHCpR5ajnWUQnNKmi/oifNPj5hXCWt2gg8e9b8gH0A5/IHaOQjvwpT2oR541FGg8IQiuP1Gzge9NolIxU0Afz8b+Uzmk7vuIVHPRRv+k8BYsNvw7AJsllbFBdSTaRahQepwGqqTbgKaQZY53wVor+22GOSpOaoludTaSgnNFUANwfCKQkP0cAFce+qFqDc8Ln0fUksVtHj4t+ofeEL8UBwWhdncryCLX6VwGmUO1+aD1QyeYfRUSyQcs0rp8Q8L3KxXUvwTeWyTtbs1tyJXQp8FTisEg5UUp8vLqpbOOqeerqWOfDHV7KluVyKCFeRQQYyB1vZGWJbE3xunARa1qzJNcbnueTNxU02lbhqG+qNZPKcdo1RqFKl7sbHf4YhJVMap7ZuMYcX078iEdwTdo9tdGMFEyqRJDlxrlgP9DORmCoJUT3HiwXILlyFNuu0fjuF6WoWDbDKJyabn14n4wBFldK3cSjIPmfcHk1Fz1zxZJzccx9+cJP2unLd0+7b2vtRm/ce5gORC1i8e9ei/nw3KAnyHnyQY+v3onRsBfvpuThZMfepjjG2hEMQnKSXDPYdSnNshBsI29gbWDAte245NQVqUt1kKXM776gHV5HU8A1IY+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2RSY0RJdnNGZEtRMkZ4dCt2Y2ZaT1pkWlRzbHVMN3VaRXY4Q3RoRThqd0Nm?=
 =?utf-8?B?UXNDUGNVRVYwbm9MMHhvTDd1VTBRT0VvK21YOU9seDJ5YWxTZUkwUFp5S2pZ?=
 =?utf-8?B?eDd0VGhEOGk0RytwMHJFalo2Y3I4d1d1T3Z0YkZIRHRiQU5OdXlOd1hucDRq?=
 =?utf-8?B?elNiUUlheG1JdkNqSTl2Tk4zbnNqc2UxZFAzSEZyVU4vWm5HL2xCYndKeDBN?=
 =?utf-8?B?UjFXc0lVM2E4d0NyNUpWRnFqYWg3OHg0UjZjbnh5K2xWclJnNEw4eURTMHBI?=
 =?utf-8?B?ZjdiMmMwbVQwSWR4bk5JNStkalA5Ym9EY3U4OTY0c3BVcmRaMmQzVU9kMXE0?=
 =?utf-8?B?V2Jhd09SVHhmR3pYSGhVV05MQ283aVllNnRTT1RqUjhuTkFNSjZtVmpHekIy?=
 =?utf-8?B?dUJQOTg4cXhEaHBwL24yNFJ5V3BiVkpZOC9mWUIvRXJmcnRDM3kxaHlmSUc1?=
 =?utf-8?B?YlJBSW0rSVliSnlSYnkvZ05vVUxFOWRHRFJuWENFc0VwWG9ZYldtUHVMekV5?=
 =?utf-8?B?Y20vSjJVSHFMclJGV28vYkxweFJMVkZ0Q0lydnFOZis1TWJpcE9oL3dOVm9I?=
 =?utf-8?B?L2svNG8veWc0d0o4eW1pYk01L1JES3ZZMnNIRzByd0dBdXlKS3ExR0pueE9O?=
 =?utf-8?B?RXJ5WE9RL1d5SDN6dGVhZzBjNzdMeUpYcGtLc0ZGT0tqWTFqdWZRSGdhVmhn?=
 =?utf-8?B?Zm5lQkxNWU1pNWtYeENZUTNrSUJtR0RNMEVRekgxUG1ETS9saFpjeWNqdjVk?=
 =?utf-8?B?dGpWL0F3Vk1heFpmd2hkTk16SW9JWkU1eU80SG5pSWxzUGxoRFNOTjhkT1ZC?=
 =?utf-8?B?dm5HSEdPSUtmdms2Vlh5T21ML0RzZDhKL3JRemcvbU5PZkJjek9oWUQxclZM?=
 =?utf-8?B?dmtkbmMrRzBVUThBRm1ZRjlBVktHc05xTzluZFRSTjN4dE5iTjNlWEN3OFNP?=
 =?utf-8?B?RVl2UzB4NUh3clBjUGIyMktFS0E3eFVCTi84ZVdCb0NTaDB4ZXh3R2U3eGRz?=
 =?utf-8?B?T3hxYWI3RlhUN0krNGtyZzVuTytlWnd5eEJ1OFlJS2dWYkVjVTgvc3hKUUVh?=
 =?utf-8?B?YUJsYkw5dlVENFFCbk9OcUdwU3NoZk1OMnBoTlJFRVpUdUJ4SUxLRWJadDJV?=
 =?utf-8?B?UXUvZ1p3U0FjeG13Y2xZVCtMcTRGYU80ZmNHaXcydlpkNXRGNzlGc1laOUx4?=
 =?utf-8?B?emZtZEczeFk0NVVXdTgrS0VpT0ZXNzJ3R2pLdk9MNkhnYUNFa3FMRkZTTGNR?=
 =?utf-8?B?Q0dUeGNTU1lQbW9pQlRxdU1ZcVhLMC85Z3VhQURUZExVemtwZlM0K3B1VFc0?=
 =?utf-8?B?Tkl4Y2FKcHQrc1NNUUt6TGEzcERxN28yeUU1TzRUK1VHUndyeFQyMllYUGdR?=
 =?utf-8?B?K2pkZWR6WGtMa2h3K3lHd0ZDaGV1djN0bCt5QzVyM01RK3duWmxvSmw5MFVt?=
 =?utf-8?B?UzJqWUF3M3hUZ29wNDRLakx1S1hlV0k0Y3dCSytQTG1JTkhJRGhVRSszVnBU?=
 =?utf-8?B?ZGs1TmsweDVONnQ3RGxNbStqSmlVVnpUSlg2QlNOb3NvUk5FcUVkVGF6UmIw?=
 =?utf-8?B?U2pHRGoxRFkrbUlvbnFrS0t5cnc4cTg0Rmo4NW9sbitvZ0lsMUdHTGJnbjVk?=
 =?utf-8?B?a2ErZGVmckNzV1VZSitBY1hpODI2eHFkdzZ0bFRIbWpXTU11NWR2Q3BpNGc1?=
 =?utf-8?B?WkEyVDdzTkJsMVhubk5KVnljZFltWVNoNzNxeEoyTm5YSmhRU1poa1o1c3hG?=
 =?utf-8?B?L3lHbHB3SVNuY3hMcGNJa1VMOFkrcDlYYjkyamFoWlNkZXZiVVFXVFN2Zjls?=
 =?utf-8?B?SERTSXRZSStuUG5pM0g5bElLbDV0VCtyUnhMVUxjVGQxZXExSHRxSHQ0NXJY?=
 =?utf-8?B?WklmejRkQWxUY1ZOaGdIbnhtL0o1cTV2Z3dqc2RhWS93U2cvaC9SVjY5a05K?=
 =?utf-8?B?SWNzb3liY2VQUXhHVngxQjVlcjh4Zm9rM1o3YlFMcU1pcUNxR1Rmd3FsN1lM?=
 =?utf-8?B?WldWUHZJWm9Mb1FveVIwbHdKajFYMHQyKzFmZGY4SzZ3OHJhNHBtNVIwNnNx?=
 =?utf-8?B?RWcyM3dMdVR0a25RTkRJZGw3N2tmZE1DWE04RmVCZjRsVzdGbTFvTkJEYklI?=
 =?utf-8?B?RWtkWlNucVVTayswWTNxOVg3QWRhZ2g5YnJBQjR4dGhPWXJYNS9TZVFiWktw?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0bdbeb-0174-418d-337e-08dc392a989b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 13:30:29.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVKNynXkFdeOOSEh5LOe+eKLU6pyjabqtbwbQ3xIyGLKT9fZFixyKVvoZcFdDqj3A884ZcGBSIsApny369cV+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9197
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_053034_024616_1523FA47 
X-CRM114-Status: GOOD (  22.14  )
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



On 28/02/2024 20:12, Christoph Hellwig wrote:
> nvme_update_ns_info_generic and nvme_update_ns_info_block share a
> fair amount of logic related to not fully supported namespace
> formats and updating the multipath information.  Move this logic
> into the common caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 79 +++++++++++++++++++---------------------
>   1 file changed, 37 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dcb8d0590ed0f3..78667ba89ec491 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2070,21 +2070,8 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
>   	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
>   	blk_mq_unfreeze_queue(ns->disk->queue);
>   
> -	if (nvme_ns_head_multipath(ns->head)) {
> -		blk_mq_freeze_queue(ns->head->disk->queue);
> -		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
> -		nvme_mpath_revalidate_paths(ns);
> -		blk_stack_limits(&ns->head->disk->queue->limits,
> -				 &ns->queue->limits, 0);
> -		ns->head->disk->flags |= GENHD_FL_HIDDEN;
> -		blk_mq_unfreeze_queue(ns->head->disk->queue);
> -	}
> -
>   	/* Hide the block-interface for these devices */
> -	ns->disk->flags |= GENHD_FL_HIDDEN;
> -	set_bit(NVME_NS_READY, &ns->flags);
> -
> -	return 0;
> +	return -ENODEV;
>   }
>   
>   static int nvme_update_ns_info_block(struct nvme_ns *ns,
> @@ -2104,7 +2091,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>   		/* namespace not allocated or attached */
>   		info->is_removed = true;
>   		ret = -ENODEV;
> -		goto error;
> +		goto out;
>   	}
>   
>   	blk_mq_freeze_queue(ns->disk->queue);
> @@ -2162,54 +2149,62 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>   			goto out;
>   	}
>   
> -	if (nvme_ns_head_multipath(ns->head)) {
> -		blk_mq_freeze_queue(ns->head->disk->queue);
> -		nvme_init_integrity(ns->head->disk, ns->head);
> -		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
> -		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
> -		nvme_mpath_revalidate_paths(ns);
> -		blk_stack_limits(&ns->head->disk->queue->limits,
> -				 &ns->queue->limits, 0);
> -		disk_update_readahead(ns->head->disk);
> -		blk_mq_unfreeze_queue(ns->head->disk->queue);
> -	}
> -
>   	ret = 0;
>   out:
> -	/*
> -	 * If probing fails due an unsupported feature, hide the block device,
> -	 * but still allow other access.
> -	 */
> -	if (ret == -ENODEV) {
> -		ns->disk->flags |= GENHD_FL_HIDDEN;
> -		set_bit(NVME_NS_READY, &ns->flags);
> -		ret = 0;
> -	}
> -
> -error:
>   	kfree(id);
>   	return ret;
>   }
>   
>   static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>   {
> +	int ret;
> +
>   	switch (info->ids.csi) {
>   	case NVME_CSI_ZNS:
>   		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
>   			dev_info(ns->ctrl->device,
>   	"block device for nsid %u not supported without CONFIG_BLK_DEV_ZONED\n",
>   				info->nsid);
> -			return nvme_update_ns_info_generic(ns, info);
> +			ret = nvme_update_ns_info_generic(ns, info);
> +			break;
>   		}
> -		return nvme_update_ns_info_block(ns, info);
> +		ret = nvme_update_ns_info_block(ns, info);
> +		break;
>   	case NVME_CSI_NVM:
> -		return nvme_update_ns_info_block(ns, info);
> +		ret = nvme_update_ns_info_block(ns, info);
> +		break;
>   	default:
>   		dev_info(ns->ctrl->device,
>   			"block device for nsid %u not supported (csi %u)\n",
>   			info->nsid, info->ids.csi);
> -		return nvme_update_ns_info_generic(ns, info);
> +		ret = nvme_update_ns_info_generic(ns, info);
> +		break;
> +	}
> +
> +	/*
> +	 * If probing fails due an unsupported feature, hide the block device,
> +	 * but still allow other access.
> +	 */
> +	if (ret == -ENODEV) {
> +		ns->disk->flags |= GENHD_FL_HIDDEN;
> +		set_bit(NVME_NS_READY, &ns->flags);
> +		ret = 0;
> +	}
> +
> +	if (!ret && nvme_ns_head_multipath(ns->head)) {
> +		blk_mq_freeze_queue(ns->head->disk->queue);
> +		if (!(ns->disk->flags & GENHD_FL_HIDDEN))
> +			nvme_init_integrity(ns->head->disk, ns->head);

the logic in "nvme_update_ns_info_generic()" today is to hide also 
ns->head->disk..


> +		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
> +		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
> +		nvme_mpath_revalidate_paths(ns);
> +		blk_stack_limits(&ns->head->disk->queue->limits,
> +				 &ns->queue->limits, 0);
> +		disk_update_readahead(ns->head->disk);

we don't call disk_update_readahead() in "nvme_update_ns_info_generic()" 
today..

> +		blk_mq_unfreeze_queue(ns->head->disk->queue);
>   	}
> +
> +	return ret;
>   }
>   
>   #ifdef CONFIG_BLK_SED_OPAL

