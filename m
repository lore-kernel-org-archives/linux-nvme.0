Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CECC54E41
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Feb 2024 10:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/rV/Hfn4TP2PkoyfbPVeiGJ+rnyl+mZfoVJlkJoDOOE=; b=zpNDOWNRbSLWCb2ZQrRhlpEdAZ
	EAJ4fvQCJXE/Fu/DGgUTQEdYfxW9/F0YctRoLQ/oc3JurWkfU9FjB/JGn9zHrNHjQvli4qvVDrnpf
	gp6fwx9qRThuZacyYOTI6mXqy2j4KGF+/LkKT5oyHIHRW7HQXuxBguQ/9QrDaZxHW6MEtUV55xnDL
	U9JH/iMpnuTlKkQTJgzhJdgpiqxVmHXH4ap7h/ytyDY2TPxWqWwoCkggXDB+Z7BiN4Yr32PeKK6Yy
	9LcQBzP0aEvgzAlWgsUABqrKY84f3oRu3BGzeGIFEyIq+P1kclnNMDVMIjY8XBYWuK2Xnp8xGJJI+
	YhtcoFmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfe7t-0000000DGMP-42QH;
	Thu, 29 Feb 2024 10:58:57 +0000
Received: from mail-dm6nam04on20601.outbound.protection.outlook.com ([2a01:111:f403:2409::601] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfe7r-0000000DGL6-0Xjy
	for linux-nvme@lists.infradead.org;
	Thu, 29 Feb 2024 10:58:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=if2L4Lw+XKV3B2NUvfArKO7XAyWSYwHHcoF21VoEicoeKn1AQWCppAPfZW7FAZWiE7qNaonF8IYw7sOB6bF9o3Lh+CXfHz7fJY1L1x/3t98EK10OA8eURbfNhvZjl8k4+sLpdgrW7B21aDgAjjGHuopWfv5GoWqVsjXVRdh0KqaCQfnmr1nkhHEiw3Wu3MYvkMIbvaXC7dOVmXOhe9JUC16whppuABydo5VB0/4BbgKHRnhgXg28ARXBRWrLz5GS4r+6yszt8/QX+lqn2i8fzVUs7CxwQVyEnvTC04hxq1XHmseJC2mzFBQ69vu/d0EHUlFgctIrDdXNJrhY1oSMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rV/Hfn4TP2PkoyfbPVeiGJ+rnyl+mZfoVJlkJoDOOE=;
 b=ge4MU4J7ke9y59cyFTmREt81ByYqZpI8nOqbacvwCli45Pry8ktr4aLz1zjIQsz+f/oIyWpbf497marGrj4cahHgePys6qISoqbQ64xv/h+fRlofiE0/BArFuugZw1Rut+ovurDCgBPDVBpkhS+XSD7EERNrZb9iSh853WcG8c+hGbxbAPhiOPEDkMgtO7OQljGWYK/Ras3XpQiW96M9hlx1rUcjeT5ZdFnihhjSk1m4x9kEKZ+sRDdYVUKq51vYQX2lApp90nEh3AKgwkd4XoMmqPhq4BqlYimkFG131tNB8VBikfTmy1Eb0vAlB7zzYsYzbyHn59XVCFPrnYwiSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rV/Hfn4TP2PkoyfbPVeiGJ+rnyl+mZfoVJlkJoDOOE=;
 b=khpj4MD8s3DVhldtIHvtq6wrWFx59qq6x0eIuvD33NjhfkXolm/kRc8fz9hWafNsqMJ0XYUQYrIPgNc8yhTClsQ/mbgOBX050EebZR5bppqVj27hQDbv4H4PBV8oc/bpzytI5kB/O5Ev/85M5W3Q5b7W4fBdJOTWtVT15N5yExfXZO6rEVFetEI9HkYiYfptBrQwQ3jqTBeQZEH+zYNGCGFjWNhpO/3N1l4Leg7lZqPpzPlfusafI3l9dNqGoHB+wTJHxqnpkMeBSGmMWJqwHR8VNXfbG0PWxJd4zrUx4Vj8EZV+kTLN0i4bzuEEVM+wABga0s82mAD5u9HY7U7Qkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MW5PR12MB5649.namprd12.prod.outlook.com (2603:10b6:303:19d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 10:58:49 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1%3]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 10:58:49 +0000
Message-ID: <97703d0e-9fd6-49f5-bbbf-4ee50cc8cb46@nvidia.com>
Date: Thu, 29 Feb 2024 12:58:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/21] nvme: move max_integrity_segments handling out of
 nvme_init_integrity
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20240228181215.873854-1-hch@lst.de>
 <20240228181215.873854-7-hch@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20240228181215.873854-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::20) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MW5PR12MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: 26075e2e-f99d-44e6-c14f-08dc39156855
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: siFR0TGQkG3rtqsCZSYK6hw8CxX9vAp4VzButcDraqIn0gfGdlsJGfx+0wVshgjhBUGkZMotucWpYO8abKL6oThiMT3hLDLxOOZQQ92DgDGoDa3iGlr66SQAuWvJ7O+yCrm8r1Aw5XwbQLkySXEqlQbNqvwyN8qy6bZOreakDZ/AKwzy9tf4Wj6r9/PLq2aDSLWrQofSG/xX8CyMoUmA4nLxDqGcF2/5L6F6Wo+vVAnls94QAfAqqZ70W5g9qhEY5MrwhRJH94FfzBe2E98o1If0VVzcffPwPyVW9F8x0XpyJn194zrvTDrpgjblYQsDGhF9VHfG4QGu01iBENKKin1IrBca46QFCoxV6cU0TsOhLD/uCCz0NAZy0j4WT/SVM/KQvuQmMZWG9ZqckBONskTbetBnR6bfTW6iFbXbOIafp76UpYHZUS+WGbWDzDXvAICwIoI4HXnK7HeIZt8cemxZC/RXTfrpaHB/svcsaz5HOcpEPHlCJ1dA6uGe5BKkfD5+D2sxm3l1zvFjZbS8/s91JxcNp87d4OL1xCnLaRoQorVs13UJqDKnwOa7lRUrHyy1O/aGg+bcbquw8z9fWuziyp0u2tsXj68bsw6LqF21+1HW97IhTcynKUxu21zivsBpW8e0Sc8+cHkOQG5AOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDRqV0pueFpFcEszUnJuaFlTYlEvRkkwZGZQNmc4SkdNbXgwYlJGWjhsaVVK?=
 =?utf-8?B?OU5MbnZVY2RWd3BJQmtoL3R4ZTlBVlE2VTJzVE9tY2pjYTBkZ2ZUNVJOWm5u?=
 =?utf-8?B?VjMveC9LVnBJNkI5ZUpaQzR1TWlwTncrejBQRzhReDJNbjBHMDFSLzRVQ1ox?=
 =?utf-8?B?a2d0cmhBUi9CeDNSL25vVGI3RlBjNm15eHdSVTNGZmhyWVN6ZEN3R3B4Rm5p?=
 =?utf-8?B?QXE5Q0xmOCtNVlZJdmpXdm9nR2Q5VmgrYk4reXM3Qk9QUFJZZEZHREFITWFn?=
 =?utf-8?B?L2NGdHBDV2NDQWtUbkw0SVZ6cUdhOW9SMXVQVE0vRk5ZblVUZFZ3bnpMbUJ2?=
 =?utf-8?B?TmVZUU82cjAxcnRYenI5TWpvaXFNeXA5THpJZlJVckI5bWdZMnJvUEl0RHkx?=
 =?utf-8?B?Y1JnWTJ1UEh5QnFZK1RJTFZIMWYzOFFpdXlaVlBTN25WT1d4OG5nMDBDL2VP?=
 =?utf-8?B?STh3K1ROTkN3eXFXZzcwbDh5VTRVa1ZLR0dhakFLQnBrTDFwRGl0VTh2emtO?=
 =?utf-8?B?YzRkcmh2RmJDRVVHeTVRWXU2UXROYldWY21lMFVRb0pRNGRSbGU3RFp2QkVC?=
 =?utf-8?B?ZGZpY0NUR3craDhnTzhUc1ptTkd0Q3pQQm9VWFRLNXJZc0VkTlRpZEtKQnE2?=
 =?utf-8?B?eFVIR1BMWWJ2S053M3Q1NFVVdGJvdUFLSVRKWGdWNzJLNXUxSzNGdzVyTlht?=
 =?utf-8?B?TmZpV2lsZVBPY0phckdLdU9rOS9ubDZUa202ckhoV2J1MDhIdUN3dHNFTUhG?=
 =?utf-8?B?MFlScUhsRytOZ2paK2ZUa3VmUkEyUFdUOFpPdndsWlN3U1MwSUR3a0FQRlo4?=
 =?utf-8?B?K0J5V0RNZEIxQ2RWUUZ5dmczRjBnUDdOb1ZvMll4VSttWlpHMDMxVEZQNTYw?=
 =?utf-8?B?dEVNbW5nTmxTZU8rY1UxOFBxV3RxQjQveW5PYUV3M2pLYlVUMnVITlVVWFg2?=
 =?utf-8?B?eVdiM3liM2JOMFV1ZjI4bitlMSszM2lsZXFEMVZmMmgvbHUrRnJuVmdJcEsv?=
 =?utf-8?B?dzdFZTMvRzJDUWk0N050UGhRbzB5aEtoQUFFa2FaTnRINENhV1lBbHZOOWRk?=
 =?utf-8?B?WGJiQXJUbW8yNUZNQmJ1UTJBdTlCZmV4SUR4QnZ0bGRBbWN4SlhMUVJCNStv?=
 =?utf-8?B?aTI3eFF3SGg1WTFFdGp0K0hwUmx0cjgvTVJyZjc3ZlJNTm5PazVkdG0vcWI2?=
 =?utf-8?B?eHJkakJ3dDZic1dvdXZKNEJMMU5tNDNZZjQxbjZpVWQyMHlsY2t3SGEyemFE?=
 =?utf-8?B?WGRtckdRWmMyZmUvYnBjZlRxcStLYW9zRzRTMFVFQ1hCZXdoSm5SdWEvaWRM?=
 =?utf-8?B?VnBLaGRrcTlpeEIvdW4zNWlaeXhESTVINzZTWlhCUGd3QXphb2RnZlRaeUxu?=
 =?utf-8?B?MGJFdlVXenVnNGNINXd0MWNwUThMSWhBdlFCU3NHKzk3NnlURGNQS0tFd0Fp?=
 =?utf-8?B?YTR5Zk5oRXB1K2JjaDhlTHprUzB3cjNyV3JJMDdYdmd1eVlUM01DM1RuRldV?=
 =?utf-8?B?aVlJYWszMzB0U05tMTdTYUxLbGo1Rk1wOXZlQ2d2MDNRS1E3VThtdXpuQUFZ?=
 =?utf-8?B?WXBNQzVpenowMmlkNThmRGNFS0NnTHUxV1lhV21maldDc0k4dmFtRzN6Q2ln?=
 =?utf-8?B?bTkyWXV3V0dCZGVlMmJQWFRQZkl6ZTRpVjZMRWxLWE5xNkNZTDRPVWhFd0R5?=
 =?utf-8?B?b3BGN0U2aFpDbDVYU0ZyaDkrdEdVQnowWThhNVRPbCtQUTcxcktQNTZUSXI1?=
 =?utf-8?B?VmErQ1hqdkhKSzdpOERKaVk0SVE0RU9hODFNL1daRnNnaFZwbEMwbzhBM3I3?=
 =?utf-8?B?YVVlYThZeHA0Z3JyeittSEdndmFwb1cxVXEwYjAyaWFGVjlUYmRsVG41K1JB?=
 =?utf-8?B?Y00xRS9XVms2Y2UvOTR1RS9ESFNqbCtSeU56YU12d0FxVmRzNmg5cWRxNm0y?=
 =?utf-8?B?cTFkR2tuWldPak96QmhvaThXMWFNMkFTdXdHRlRhUE8wZjc0OEJLcG9nTUhB?=
 =?utf-8?B?Sk1nTXg0TTNHYnlzQkpWSTJTbTN6Q1hkYWJ5TU5qMGQySmFRakNoVVU4SGFL?=
 =?utf-8?B?QVdWeWNNdlBLRURiUzhVaWdyampvbGI4bWtQSk1FbTlqbW1OSFVlZGZNYzN0?=
 =?utf-8?B?MDBvbkQyd1Q4Qkd3ZDBOV1JGMVhjTWd1S2x6QTRndllETi9zVkxoNDhRRDUr?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26075e2e-f99d-44e6-c14f-08dc39156855
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 10:58:48.9443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PW3jcAtJTvFUvit46Mo6Uhr0SyWiC2OQebAV4WhP73wJ09MDVoaHBACgvooEp2eGsC1PLh2CjU5KGFy+8o1XIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5649
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_025855_206822_A2F47A7A 
X-CRM114-Status: GOOD (  17.44  )
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
> max_integrity_segments is just a hardware limit and doesn't need to be
> in nvme_init_integrity with the PI setup.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4a05045e409904..94d835f9dc90e9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1724,8 +1724,7 @@ int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
>   }
>   
>   #ifdef CONFIG_BLK_DEV_INTEGRITY
> -static void nvme_init_integrity(struct gendisk *disk,
> -		struct nvme_ns_head *head, u32 max_integrity_segments)
> +static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns_head *head)
>   {
>   	struct blk_integrity integrity = { };
>   
> @@ -1773,11 +1772,9 @@ static void nvme_init_integrity(struct gendisk *disk,
>   	integrity.tuple_size = head->ms;
>   	integrity.pi_offset = head->pi_offset;
>   	blk_integrity_register(disk, &integrity);
> -	blk_queue_max_integrity_segments(disk->queue, max_integrity_segments);
>   }
>   #else
> -static void nvme_init_integrity(struct gendisk *disk,
> -		struct nvme_ns_head *head, u32 max_integrity_segments)
> +static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns_head *head)
>   {
>   }
>   #endif /* CONFIG_BLK_DEV_INTEGRITY */
> @@ -1954,6 +1951,7 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
>   	blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
>   	blk_queue_max_segments(q, min_t(u32, USHRT_MAX,
>   		min_not_zero(nvme_max_drv_segments(ctrl), ctrl->max_segments)));
> +	blk_queue_max_integrity_segments(q, ctrl->max_integrity_segments);
>   	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
>   	blk_queue_dma_alignment(q, 3);
>   	blk_queue_write_cache(q, vwc, vwc);
> @@ -2017,8 +2015,7 @@ static void nvme_update_disk_info(struct nvme_ctrl *ctrl, struct gendisk *disk,
>   	if (head->ms) {
>   		if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
>   		    (head->features & NVME_NS_METADATA_SUPPORTED))
> -			nvme_init_integrity(disk, head,
> -					    ctrl->max_integrity_segments);
> +			nvme_init_integrity(disk, head);
>   		else if (!nvme_ns_has_pi(head))
>   			capacity = 0;
>   	}

Looks good,
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>


