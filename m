Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DA9C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Feb 2024 12:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QXh4mMY9cErrbtHk7IHvHIwaGV1Q36D0oS2J1Lu2az0=; b=rY8nfoJQ7pUfhAhOg0RgM8cobS
	kkSXrA+Jn+SlSTZIxfokEeYfoWj6fsRaYNI44pq7dUKBv6Z54ImTYp9CPq5fEREgLS4J8uRFG7y0L
	zbC6V08PHD5cSIrJROr24lvEUUXZpLLZYjh30fnYaZuDUhNowuWl00l+m3w07GR4cRSv5vnWHjAXF
	YCE2iFkc5oT1rSBjNV2VIp6Nzx/kjgFEJdsK2DQmt2dbCzmdh/RxoNAkK8mkeAunOUSTlnOhqoMc0
	rCCOfEnB3zIBdl9f7G6EKpiwaUUnKyKn1ww1JZaOT40a3CnTHfzxSCOpZhd0YbWfW9/g7U2J2vj+O
	13Tfvawg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rffc4-0000000DWoF-1epA;
	Thu, 29 Feb 2024 12:34:12 +0000
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2417::601] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rffc1-0000000DWnZ-2Bzy
	for linux-nvme@lists.infradead.org;
	Thu, 29 Feb 2024 12:34:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBHJJ7nTYdI4uU7L/bO/FsLCQI4NEuWhMOW8tPEMHXv2bhIMgdH50BxACn+bI0fgtsHpRpozlaQk+iEBuYo5QBWrrmwEdtmgFCqAoWPGqyYNy0ZovojPTfKmYNx4QKliGzu8xrPqFXnpXIyqe7mK+byWyQ+y6aO3CoO5aeFvJ3OZPMYm/rvZMCV4DCgQhCjoh9exAI3ZJnTpXKoR6+JL71uAyGBXxut/QKQz6KxSInp7Z2xmAPVSFvd7mHFpcsHbl+FN4ugHJkAxkbNLuTBzZ8+b8pfGNfhEcjJwVdrPaB1FilCodk+c5dDtlAP+pbLvvL1lklvA6ZTZtig3+E72Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXh4mMY9cErrbtHk7IHvHIwaGV1Q36D0oS2J1Lu2az0=;
 b=ONLr6SDhsWDJQsS/X3vMJniyMj6ZOg2gOS7eFa0QVenvIiG8XxVRxGK50RXSZS1JojL9VXgYcGJYAQ+vR7eBDgIqFiLZo5HWEP9GhWqcG7P/LKL1U7wBaAKd7VuV1CdIQg49OYn9KkXYvecpnAtOEJSKWmJi3F1ahEeQnFxz9LyM6ulLOAVEEHUDcS4x+NQUOK6EPEC94K0DDtiVHhdNRHWeR20yqGm5B41o3AvexTbmbIAzIevVwUyfqasb4Bko46K8zM93Dp9dVjq5ecpPYEyUO2h2J3MNwfZu3lNW0BuO3lrs5Ct9zZcv+3iIxFADc/ZrFCNxBPtFvQ++JJpCWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXh4mMY9cErrbtHk7IHvHIwaGV1Q36D0oS2J1Lu2az0=;
 b=QvvzWOEQQHpRXgrOddN930DVKW0g+nGu46MAHJUrVRL1Qgz0rB4wWrqOwXw4VbEwWQaAwTVTAUEZDqHmcP5rrXIOHe5TxwEEtWnpVjgu8M11ObcejbMhyvyeX1C/7jDvtQ5ApFHW+eNYtWBmk8RKe5lNXQT6bmo7bDZat9KppT/JwQQLpXuq6JEEGZrcjY8m4WEdK0g+V/rDOVNRhKgF8Hf5LHWVaVhMKsSnq7OJ7Iq1xhQHOXA24vBXRbd7/M8sREq5Yr+tIJAip7w1z4tJpzspAgRB7Li7GDHc3dOv9s7Q8k2ZvPgleYYFpNLpOQnUVic+avnOOtNUhgyw3IkTwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH8PR12MB7447.namprd12.prod.outlook.com (2603:10b6:510:215::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 12:34:02 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1%3]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 12:34:00 +0000
Message-ID: <0e4db292-6dea-41de-b9f6-47455c9e7846@nvidia.com>
Date: Thu, 29 Feb 2024 14:33:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/21] nvme: cleanup the nvme_init_integrity calling
 conventions
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20240228181215.873854-1-hch@lst.de>
 <20240228181215.873854-8-hch@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20240228181215.873854-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::20) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH8PR12MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: cfdc737d-df90-4fb2-561b-08dc3922b4a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iomKJC7j3II/JQ4rVUguvz080wXmPx6Ox9AZqRBDI+pT0x0+qwXQ8lBLaXXnIaDMi6UnHvkENn/E7V2UffstoJLqmDgA1LxMbDxYX9eYQjdPne/s2bmnLUf7SwpEDN3t6yH7VBPLlytfELxcq+B5MljSB8UN/i20KQf+w9Q1rS4BmdwwOP3ZzkolS2QIehPXibL+nx5AEtwbnWPKo4FvnNX72AyTilk9pIyZDdCW+W+FJrkRRppkXPo54wrCkhRdnAvEWQUOntVBWUUVbJjyyNfMZIAxJLKNFUfsUy+rWgAR3TqcFhlzSWouXtHDrX9Ac3yp9qPsFYMPUL1fGFGT5nhvbQVLsQzM8lxVQcuZu/8d8+XK/17H8cTYDrAZ2rMD1c3rW76HvIeSurbEnMQUrJgocwOkBR1qjUG3QT1++0G0AEK5Z+YgMkmF623Z6ejQLNoN4rrKGWkuADj3KVy49vsJ4xBNnKL7B/sfPHdS5pTxvTux66h2jrGRxAfKvIH9COkTOlo+PdiRZDAjj9oxKFnS1XvHWvWBV7FDBkY5q0Epmz1WVzWV6R7IQpIlm+bc+2FbMD9zgXq4VvFzXiQL7+WWLJqUcU1bDJBDM6cGd8HO+wF6XM0KHPEtimICcomLwA6niqWefgsB8qxkfRWrOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkhWK0IwTW5LVk9JUUE4Wm9WT1ZMc2xYdGZDNkNidG9aVnJReGo3OVJkOHRJ?=
 =?utf-8?B?aS9FUUJ5UzlycGlRSEpDdWVxenBxV2tYUTdBN08ySHBiNVk3RHp2R1ZHc1p5?=
 =?utf-8?B?czJjNVZQTEprTjZZekFOeG56U3ZkNXpnNU9YSnBER3ZpQWdIaWQ1ZEhkMVcv?=
 =?utf-8?B?NVQydEMrcG9YZzZvYzFnOFZOSTdwNFcxYXJIZ3Q3RnZac3BzbkYyRTFyWGhF?=
 =?utf-8?B?RmFYZnFYVHBCTmU0WFB3YU1HVTBmQVdEWWxvb0dLR01PYkFqLys3ZlZxRTZP?=
 =?utf-8?B?ZXZSbWhSeHk0UElCSmNSakFnYVh2dFE3NU1ZYkhlODRFNDlEVGVsMWlMOXVB?=
 =?utf-8?B?QU5oWG9hdDZIVXRjY1BDdDcrU0J0U0pmalFiVlRQS1BjbHA0UUVOajFFOFAr?=
 =?utf-8?B?cStJUlpjdnZBT0dOcWFOS0VIaElhTStiTXJDT1p1UG1MQ0tWR21aTzlmWGRv?=
 =?utf-8?B?WEQrazd1WTNlRDROS0NPZDlzWkRuZWdNQW8wVWx2OUNnSjhQemp1eDlROGRo?=
 =?utf-8?B?azJRcWkwaEx3Y1U4NkR5Z2grTHYycUh3NUpaUGduZTdkS25jSHJMSXdTTzRE?=
 =?utf-8?B?QmwrVkl4SHl3MElYTFUxTlFzVEJONUsrL2dBa3pXT0pJUjdYSk50cDN4STdx?=
 =?utf-8?B?NWhoTWNibUtlK09xZm1LUFliZWJZQlo3M0l0MGtlOGhKNjNUUjlqZE9xanVi?=
 =?utf-8?B?TE9sNDlGMmdqNFpyTVZSWnJLV2FpU3Q2T1VNS21yT3dZaFpQNVFJZCtBTjlx?=
 =?utf-8?B?dnM2VTViUTdFUkxueFplSzU2Sm43MENBT0kwZUtvOTVUcE80TmphSFhmcWp4?=
 =?utf-8?B?ejlIbG9WVXo1WDhlRStVMTBpdGdaMGJuV2VHTlhhKzY5ajZSSjBON2xDcklH?=
 =?utf-8?B?M2UvckNwbVpESkVhbFRVb1Y5OWRDMmdrVGFlYjA3WmkzcEZTSE9LNEpaYmhr?=
 =?utf-8?B?RWxxamhlc0FKM2RlbUFadzNjRkVnc3ZQVm5IaVdVZFVYNUdiSC9hRS95bnZ1?=
 =?utf-8?B?MFgxQ0drd2o0TTJZb3hkTDlMWmpzTlhwbHRLY09odEVnZ2VQUVVDTGJFb1J2?=
 =?utf-8?B?VExmSmhXbG44cXBRd0pBWTNhQ0V6RnBDOEpLTUZ2NklMbE41MkltNGMvKzY3?=
 =?utf-8?B?RUJVa1lWQjVVNmcyUUlmT0EwYitDMDNCOWVaSFh1NGd3MUVqUjZGcXFSOFVx?=
 =?utf-8?B?MHNlVC9zS2ViM0JMYTgwQUZVWGdLVEtlOGNDc1BFelRvWGlHWGl3QVdvUEFa?=
 =?utf-8?B?bkpLUmFzTko4bE1EUWNTRlRzdjRUTDFDR1dCbFBUL0NSKzUvcXJsWndlZm9V?=
 =?utf-8?B?L1AxMDJ0OHZxYis5NWF5SzdXTFd5Z2ZvWkNBKzdIazV4TGp4OUpDM0tRWVNj?=
 =?utf-8?B?aUQ1VEFCTzdKcm5kcXFrU1k3RXcrUUJWSjhyZm5JZDFiZ3YvcTl6bFV5dy9Z?=
 =?utf-8?B?VlJFZEM4eFpGWUxYamRoWVNKUXhDdzBCeFVWUDVNMExFM20rS01HclZVaVFH?=
 =?utf-8?B?Y2JvS283Rk9LSVB0bkRvUmUzREg2SlE3NjA3RzU1azRybXZJWmFUNHl1cGIw?=
 =?utf-8?B?NVVSUG1sQ3Q4cU1ZWnpWUjI4anAvVGlOK1Q1Si9SK3A2SVUra2prUzRLRThH?=
 =?utf-8?B?SWdMQUp4VGQ2dDlYckpsUVRBNzlpMkROV1lyZk1GUXY1dGN0anJpb2hBNUds?=
 =?utf-8?B?OG1mYXNCVFN2S2Q0SmRnVHVmTmpsS291TTdXWm9Gem1wUzVsWlJOdm5MYXlu?=
 =?utf-8?B?SWcrYXRFREsyREdWbU83dXdzUy83eS8xcHFWRncrTFZwaHdrU3M2Z3gyWEVJ?=
 =?utf-8?B?UHFod3VJWHRqS1pRcXMxY0dQYWRwOWRQczRzWWxGK2t1UmkvQzE2aGhlWHI1?=
 =?utf-8?B?RTRZcEkwbTZVcFM0YmF3ZFR2Qmg2cUFxOEp1ck9MWU13bjBWdGg3ZjFDTHly?=
 =?utf-8?B?dzZlbXhPSE5jUTN6VHZPTjl4TU5YTEU5bnJtZDZBMlJHaWJlUURNMHZPRWRw?=
 =?utf-8?B?QjVPOVZJRnp5bzZkMGZHYzFmZ2xrOWlvS0FRelZRL3FtSHJjVlczbTBycUh4?=
 =?utf-8?B?cHlMWWdmVE0rMmhScW1tYjZBY2lVLzZnc2x3SitLSGRqejhoYlF0SFJSV1dk?=
 =?utf-8?B?MC81ZkltUGNURUNzMzcwbWVHUGx3aytCYmRUdFVxUnVnRjhNNXUvQWpheG5o?=
 =?utf-8?B?Nnc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdc737d-df90-4fb2-561b-08dc3922b4a6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 12:34:00.4489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c90V2eNQt4Fimu1rcQRMgU6h6jHK9PlAtJBzH0/JetbnD1YGdfznBmkyLN8DEpbhVxrEIB2dHNbq/SaNSCBJXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7447
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_043409_623609_7D8302A8 
X-CRM114-Status: GOOD (  22.24  )
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
> Handle the no metadata support case in nvme_init_integrity as well to
> simplify the calling convention and prepare for future changes in the
> area.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 94d835f9dc90e9..76e548902ec33e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1723,11 +1723,21 @@ int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>   	return 0;
>   }
>   
> -#ifdef CONFIG_BLK_DEV_INTEGRITY
> -static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns_head *head)
> +static bool nvme_init_integrity(struct gendisk *disk, struct nvme_ns_head *head)
>   {
>   	struct blk_integrity integrity = { };
>   
> +	if (!head->ms)
> +		return true;
> +
> +	/*
> +	 * PI can always be supported as we can ask the controller to simply
> +	 * insert/strip it, which is not possible for other kinds of metadata.
> +	 */
> +	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ||
> +	    !(head->features & NVME_NS_METADATA_SUPPORTED))
> +		return nvme_ns_has_pi(head);
> +
>   	switch (head->pi_type) {
>   	case NVME_NS_DPS_PI_TYPE3:
>   		switch (head->guard_type) {
> @@ -1772,12 +1782,8 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns_head *head)
>   	integrity.tuple_size = head->ms;
>   	integrity.pi_offset = head->pi_offset;
>   	blk_integrity_register(disk, &integrity);
> +	return true;
>   }
> -#else
> -static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns_head *head)
> -{
> -}
> -#endif /* CONFIG_BLK_DEV_INTEGRITY */
>   
>   static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
>   		struct nvme_ns_head *head)
> @@ -2012,13 +2018,8 @@ static void nvme_update_disk_info(struct nvme_ctrl *ctrl, struct gendisk *disk,
>   	 * I/O to namespaces with metadata except when the namespace supports
>   	 * PI, as it can strip/insert in that case.
>   	 */
> -	if (head->ms) {
> -		if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
> -		    (head->features & NVME_NS_METADATA_SUPPORTED))
> -			nvme_init_integrity(disk, head);
> -		else if (!nvme_ns_has_pi(head))
> -			capacity = 0;
> -	}
> +	if (!nvme_init_integrity(disk, head))
> +		capacity = 0;
>   
>   	set_capacity_and_notify(disk, capacity);
>   

Looks good,
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>


