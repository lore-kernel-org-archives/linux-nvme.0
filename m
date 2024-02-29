Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A50BC54E49
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Feb 2024 12:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=35b2fvRHRpxCneUJka8xZyfo0rZwJhhaUfmaAFrALvY=; b=23rNTIN78z4a8YqLllQUITMUOF
	FYvjbVxdvwcputbnNNBZfLcEN9jzJ/gbgchyG96Z9hIq4SEcl/MMAt5JeK3i0XJCEnH1f3Kg5YELI
	SGNzDyyQPn+r/PgwbIEY5C0AE/9Em8efTdiUlO8M0u/bO/5hD2/bUHmqReWjOyXHXlMsBD0coWMA0
	+Lpjabvw4r9TMLvpjL+SSfhTH8F2MNs28tujbz3w9Sm0inrtN0WlBW+EN7/rPIQphjq2gONn8Eo6p
	mRPGi88DMKEbakDzNl9KRqqgzSIw3Xk8VPxbSIX8EddtoOPaWrUqln9IkxpvlYYEX0aTpdOxmvGzQ
	OgXNXJfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rffpF-0000000DYiz-1fzP;
	Thu, 29 Feb 2024 12:47:49 +0000
Received: from mail-dm6nam04on20601.outbound.protection.outlook.com ([2a01:111:f403:2409::601] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rffpC-0000000DYiG-1UQB
	for linux-nvme@lists.infradead.org;
	Thu, 29 Feb 2024 12:47:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9S59lq/hsEGBek2KDIUmsV8cFhsOonM7eVuOBdLXNmw4VTbTZiEwRZ2Ac21doscWtlTy7fv2Tmd/TtDovwvUHJul+Lz+a/f5qTC/5SdkZENT2QBjp86lqLAEKjXJ2D2zDQb/PdbiE1wRsuW1C7wHm6KTcFayw+yOVPEczs2i3UAz45iGTTya8OwGhoT0H5BSIXNKBEb2jV0O+syyhULKXUvcXE12gDDnvf6wNdZWH04Xfha0PGMLmhcgZR3/RJJtDejAa9fdJ09Ad3cbxrIBma7C9RBiziNBfxB58wAZhUfLyWUxHyIeXuEl7oj6rwXt6O6VxFBH4R2EyCTVlPBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35b2fvRHRpxCneUJka8xZyfo0rZwJhhaUfmaAFrALvY=;
 b=MGNUJWjkxkdUfDdc8uC48McBlu39z9tuUYsnxsuc1hDpqWKG575O2Kvumw8IE/e54qziAecZJ/tHeRclzDjbiMWI+p6ki0sihrxg7Qz3jJurnVXX4GN8goiWszUyy9ATdS/7vRtdwg+TB+Ht+Q+p9bt+93q9CqoJQPOiNdoSytYG8TzY4hJyxyRLHAiPZT3YwOm4Mpg0A0V+q4gl6jF3No5mzLOe9C61Gk3QHOD1UPcAxDP7UyZm5ArEeM0I3Q7/zSg27AyGU6Npcoj9mf1zApBBZYX3MEA5DlQfP1geKjWIUjNv5y0qU6vsvJ1J9xINxDk5Pi67VVtp1HPXUhvLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35b2fvRHRpxCneUJka8xZyfo0rZwJhhaUfmaAFrALvY=;
 b=rtJzyccWTpAnt515fl34HAcgXhZEa3aUv9myeuWK60n3C+t+7LHqD9l93xhKEXHuLOkh91IxOnCLBt4f0LzBslF0UWy1en1M8/4zGLdZ1R4a14JEc1CrR48iXzaYmL4aqUXNJhdpjZxdA3FpttjjBYUB/Z9K/I3U5Y3Hr0yq54v2IPH2R7/L7KTUXsFaoe4nkmtIJDSF5ViiZvthi/Trpla3yxhsR1tpPWKq210oWIlKJB+FGoGpzLLzXcqwSKCR/S4ORqfz6XHD8PBYnkYENlqaSJh9z5pa5+CaFpJ1061LwbUIVBWEftxnxJvs7RRMUtalvVj9me7qyCC7VIS+VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SA1PR12MB7366.namprd12.prod.outlook.com (2603:10b6:806:2b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 12:47:40 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1%3]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 12:47:39 +0000
Message-ID: <009a747a-0c56-46cf-8cc1-1b66d9b2a5c6@nvidia.com>
Date: Thu, 29 Feb 2024 14:47:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/21] nvme: don't use nvme_update_disk_info for the
 multipath disk
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20240228181215.873854-1-hch@lst.de>
 <20240228181215.873854-10-hch@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20240228181215.873854-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0169.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::6) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SA1PR12MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dda393d-e47e-4108-91c0-08dc39249cfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZR3n8GnGLKxE2xP3NqXBxSKSvZStHzFoSFrJszUqm55wexuRDLGPe13uY9QFKawVUJ6xfr/RIShKVVBZl8TytnaESSb3oa1WaaI4HJTmczYVBJoAZoxTiiGHAF6nKy7Yf0UwkvJImUGZeisWV6rGNqvJOpgQizLXUpLvU47FvgC/20EM62iVFiUWJjD4KtVOYuYm0EUN0yC6fzGpZXuSQ4UIokoA76C837Mt35y6fqve5HoZn/Ry92s/Y4CWOXrFVfHfpzvlzsiccuB8IM9TpFxArCvVao90i5l+5PrqTybSs5ykIl4sJF2IyyCbctyN/ZnEwTh9EAHW3cmcl4ItXskgn4CjPt4ED04LZqRMoLWCdsXz+GAwDIPG4AlUGMVgfENi2aGsBvyztjaziCiM4q0kLmT+gB8MaxdTd8TnRqXkYnqcp/W6/EmytW6bLk5JXnqzeO1ec/giRYPq1CTYONQOQyQMH/5o3h+C2w4Gz6Uj7afCpslp+/Yw5W6nClLvQxw7lm8s4aKDn6NAD9zosVTe1bfRCORzskdf9MNmYRJ80Pv7xRnwOfjDgIfFYpYoejIO/Zo/Hnz8ntnf640Y1HMxKzQ/sU7VJZ90NPDgSbD+6YtHZAl2HMz1U0ecT9HsdA5DCMf/UuBQyBX4gZHZ7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXczYzMzc0dxMXNyU21LUXBWTU82OHFhSW1WWTFkUGQ4d3c1M0NrR0ZHZXJZ?=
 =?utf-8?B?ZHZidjJ5NkZVMmFVSERWWjBZQWFuaGJUUkUzK1lSYTdMRkIzRlJ3L2xpeDJy?=
 =?utf-8?B?WGE2OWYveXlPdk9xemxwc0phclhMZkk4QytaRkZUK0VEdVVKZmE4c3BNT01l?=
 =?utf-8?B?NWJtLzNXajFCcW51R2k4QjFhT0pVZVdVelpXbU9EbkxKczVRS3JOYk11NFQr?=
 =?utf-8?B?V3FKV1dqM0VYTmtoK1VrM2pUV2toaWQzZHZWRE9QNDI3b0tJd1I1N3VyU0hz?=
 =?utf-8?B?NlRGK2V3MTVsZ1hXR0JxbnBoYlBHd2JORjM3N21xTDJsZU1YL0FMWmIzN0FQ?=
 =?utf-8?B?UjBjQll5TEJpQ2h0T0ZsZjhNZUdwOWZ6SjBPWStzRFhpR1hLUGNzd3huQzV1?=
 =?utf-8?B?dE5Hc0cvVmJwVUc4bnFWWDR6QnZkS0oxL0VMc1pzbmxtcWdjV2xOMHZlajd5?=
 =?utf-8?B?NDhrUDE3Z2RreHduNnFmcGNnaXpLNnF6NitEbUFnemZZekN3YVdaMU1uTUxj?=
 =?utf-8?B?ZExaZDBWbVd6WTVtYzhxWmhXY0M5NStod1FVNGVWazdrb0s0elUvZ0ZiMVVC?=
 =?utf-8?B?TitXZkNrMGRZNHRkdkZBd3FzUExRREpuajkzZEhLN0J0V2MrZDN6MnR5bnFN?=
 =?utf-8?B?OXhKdk83MWhiQWdmb2F2S0NPRktzMGxIdldIOEg3engyMUZWQkxEdWFMenNq?=
 =?utf-8?B?QW1yemdzc1ZCbnJ0N0JXa2owVHM1cG8xZ3RjSWJkUXNENFFEWVFiY1lNTUox?=
 =?utf-8?B?Tm9YQXEvaGIrOHBDTWczdXB5Q1E2cFNsOW0rK1krY08xNkVJQVhXcmRBYktz?=
 =?utf-8?B?bDR1T1l1clZmWWl2WTY1RmJOdDNXeWxPVlZUbjhSMWE4aVJKcHhYK2hCbjNP?=
 =?utf-8?B?Q3hCRGxmcFBjalFPeFNNaG5UR2VQRHlvZTZCSWNjUEZvSkdhYm1kWDBSbEJw?=
 =?utf-8?B?Q05TOVowWjA5bVJWcE1WUVNUSTJqYll0NmV3b3VRNy9ub1ZLRnBGYXRhUC9L?=
 =?utf-8?B?RnpBZkwvTkJIbmZhNHBxQzU4bk5BVDJWL0tkMlhJRXZ2WnYyS25uTDN6L1M4?=
 =?utf-8?B?VVVlYWxXam56eTJSWHpZWW55QnM3Ky9aRE5iTElVclNtUkFNOGRHUGdubXBG?=
 =?utf-8?B?Y0xYUnk1QzQrTnUrMTFkRnlFWFFyY2hiSEJ4cmkvWWdjdmhRbFNESXkzVUUw?=
 =?utf-8?B?MVJ2QVNGQkdUS2hXMzFlbGRYZm1kcU1TUTJnRklMN1lLdnVzWU1WREhIMHJk?=
 =?utf-8?B?cER6QTJuK2ZBTm1hYUZYY0tYM0lsUUl2YWxGSlFQREpsQjkzZGJmNGMvbng2?=
 =?utf-8?B?QWtTS3M5d3A4L21LNzJYZ0lLNmIxUFlndjRxMGFFMFp3ckFJbGJoWnp6UDI4?=
 =?utf-8?B?MW1IcjNVVllIclhVcjdtVDdRMjlqTEt2N1BKSy91eEtXaDUvc1g4SkRIeXhF?=
 =?utf-8?B?RVZQZVlHTjVkMXF1M250a2xiRFRidjByTVFsN2o3REl5NXlvS0szREhOanQv?=
 =?utf-8?B?WTlWU3RYSUUrck9JRDNzcWw2MFpaK2xLTHJlNUxOdG93djRCS1BsVk9lWFh2?=
 =?utf-8?B?RFg3TVhlRkEvVDkwT3lLWk8zT1RuT2YzTTY5em1rVlQ1SEdCdmVBNzJpWUU0?=
 =?utf-8?B?THV5OTRKdlErMEJEYk4zSVFLOXdDOU5YYzRDYVpHbTFna2tCRmJMcW9MNlZt?=
 =?utf-8?B?OGlaZXFOWmo1eExLdGhiZ0ZzTFZnS0pQTUVGcUc5V1ZHeElXVmlTbytUY0ta?=
 =?utf-8?B?eFJTSHI2OEMxQ2lFeENUN0tEZS94a3R0NTNLRCs3TlluZTBRcnBuWEJ1RDRa?=
 =?utf-8?B?dEtOUTN1T2xUaDd2MWg0bkxXRzdNSGU0cGd1U1ByU1JZNndnWGtZK2FHUlhX?=
 =?utf-8?B?NUZtTmVDM2dPV0tBczZnRnZ0RHZ6NnA0Q0did2xrbUlFRzVkYVJuZ09BSDdq?=
 =?utf-8?B?UktJVkM2amJXdTFwelM5eklwZ0pZL21PNWFwUEtwSVZ1U1FYQTYzZ0ttdFJM?=
 =?utf-8?B?bWYxVk45azZLdDN2VEh1NHFNMnhyZmo0N05ETHE0RS94MGYzUldSUU5sczZm?=
 =?utf-8?B?RHY2U0RaaW5BMVAwbUF3eTdqWHdHZmZJaVBIdTg1a3BZWnNUZGUvVit3OXdF?=
 =?utf-8?B?ZGIxSENnZXo3U0ltRkcvQ3NiMDZsQ0Rjb1o1dmJGQklEdzdubUo0dGhmVHVL?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dda393d-e47e-4108-91c0-08dc39249cfa
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 12:47:39.7831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4fK1TZ2+iKxhie4hRB/pgwdkiVc+1JuyqMOTHRqDsxyPK97xFSnhlRjjp9reHONxHSJkdVdHSsGbbNPOVV68/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7366
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_044746_438547_1723C3B3 
X-CRM114-Status: GOOD (  17.86  )
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
> Currently nvme_update_ns_info_block calls nvme_update_disk_info both for
> the namespace attached disk, and the multipath one (if it exists).  This
> is very different from how other stacking drivers work, and leads to
> a lot of complexity.
> 
> Switch to setting the disk capacity and initializing the integrity
> profile, and let blk_stack_limits which already is called just below
> deal with updating the other limits.

where does the blk_stack_limits called in the nvme/core ?
Is it part of some preparation series ?

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 105046a7957272..0bf30580f29d5b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2159,7 +2159,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>   
>   	if (nvme_ns_head_multipath(ns->head)) {
>   		blk_mq_freeze_queue(ns->head->disk->queue);
> -		nvme_update_disk_info(ns->ctrl, ns->head->disk, ns->head, id);
> +		nvme_init_integrity(ns->head->disk, ns->head);
> +		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
>   		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
>   		nvme_mpath_revalidate_paths(ns);
>   		blk_stack_limits(&ns->head->disk->queue->limits,

