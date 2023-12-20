Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8A3C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 13:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5HNN7LsxMSJ8ECbBfX35M7iomrHflT6BWKqYVnV51Rw=; b=hqeZ9ONwFPyTQXIXTjLJiCJG7o
	w1QEqhV/H6jvgBMdnZEAJf80ouS5NxiitRlGTI/kf5DIHBX3QTsWIFJKss8k+DEz9wWSv9jdu8PuC
	/reCkeUXitkP/1ZuTsG51TxgQUD39iNEiLHnrfXJFkNhop5NAm2ZmzUkFMUnASPeFoLu5GR8o1nZ0
	9McCZnEee9oFqzij2y5KbigGEylXzi+kpzmkwECVfNLYswQaqytjikRxOLR0c5vaYlcan15a349TR
	FPdHyMCEmLtpWRb+7WIXSzfD0Jl3uVPIaDKG0ayP+5+Njvh2yvTD7WrVfsdxJit98n84XsCVLW09V
	uICTzVCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFwqz-00HYAs-2T;
	Wed, 20 Dec 2023 13:43:17 +0000
Received: from mail-dm6nam04on20601.outbound.protection.outlook.com ([2a01:111:f403:2409::601] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFwqx-00HYAF-0O
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 13:43:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvX522gtcSDRiL7V83U1FsnArhX9Gi84x1Y+0rofk0QbBatT/6ur7WPd7bc/KpNqCgE8/cHuFujJwh5XP1B4ooE/qJ28TMLvl1X1hoGFV0J1c2B5/QSH+YY0rTipnVOfcAA7c+rlhQFKbMHjILCKv3OaEn1PR7Hovdm2LGwxjVCujz+iJzctiZI/6RCEbHtKyRhVkSolXitb97TELTpxknhozxOsJWIxkRa+u6lImmshURro+QpYx5a7MADFaJO2+Cwf5wBme3O0l0pEVLleEAl41qJBu21SE+xl9SdhQ45otDRgoBZGUoONbfq1sFgPpsmRqyW2V1scYTE2VXvkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HNN7LsxMSJ8ECbBfX35M7iomrHflT6BWKqYVnV51Rw=;
 b=cv/Eay9MLchKQ9Q/BfIAityK9CpZkxrUzW5hyzvVuZ49ptM0P6oo22GlPZjASlIbW+YrIrdujelNqy6i4wYBOT1uveXXwVWE3+kYGpkM/wmBSV20MNi5pWR9a618kgBQji86R7/yXFHo2YR2NOF/KWCfoVtBG07gdYDTi1GSp+nk+IbMC8LLs0LpKbiFOfomAXHt+X9f5UH3pXxx3lAJrcpm3A3WIUe0IPo0jCXhKtYb/j8HHy3oIpMhBcosVg1+eZlUWYWKKQpfYsU6vod43Tn8PHIwSdtOLZ4JhWNI5w8hwFifx3TyeYHHegV1glOFd6/9+2brBr9F6ssED1uDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HNN7LsxMSJ8ECbBfX35M7iomrHflT6BWKqYVnV51Rw=;
 b=GHrvuL3URV+VZPa+qDu2/nt6ftZ0znbd70K1tCJ4KwdMoDqIJaHnR+zI41QGTvtIQYZZRy872gnnNz5zTjTvZAln7N1FxClrt2GblKGTVoiFNx+QjhRE62QikpRYC6J6NOJqJ9Dx1i3alLsFlVcThITq1dA/iMP8DBnajt8sBcPxhQjvZWl5tV87dRVhmCfQatRVR+bheoU/fnPPFr/ZlUbwVdco5fHoEbvhmnBihKyUqmssEFOGBN+giHWxJ7viXOCapyoE/zXFfhUIhUwxCiA44YnYqiTNJPdpYnIMpd1Oe9mu8fd8YVqdEasVeVACNArVx8ymu03sxKSKMxsV8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Wed, 20 Dec
 2023 13:43:10 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 13:43:10 +0000
Message-ID: <26567ee7-cef8-4484-ad8e-d8b6fbb1d1cb@nvidia.com>
Date: Wed, 20 Dec 2023 15:43:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-fc: set numa_node after nvme_init_ctrl
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 james.smart@broadcom.com
Cc: sagi@grimberg.me, hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20231219174934.20400-1-kbusch@meta.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20231219174934.20400-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0088.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::21) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e487d3-1696-4e7c-138b-08dc01619aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XfUYcHqwBjC4fYhB1EeJ0zXFgTVEDhf31rjnP0tU0yGlqQ+Z2+6n8M//2VCykTUmtZM2KBqC7HRf8gRXtZCaI/NqzzeycTgvLMc3gR4JBrX8gWlNcXhsxtrtu6aC+Bt3zyu+gKHXpMRjEQF3qQMdwWyQ9MuPTl4M4cHlGA1mN+wtbRCCrOjK8XpuNmDq8OANMquCT0QOBOfqTTvle+sSyPAiXrnuIPLq4A78ozk6sIf2iIa2Sjk14bS8rURTWaTMrGKjA0o6l4Z+5brv6jLWdlquEH8IJ0cVjCxMTPiUilC6nv17kUw9dNdiP5uFX1Kjh6bFvuvvBzTaC6aZb1/UquOVfe8n4I7ZPuybuWkU5Kuxq+Q0qNvuARWnN4cslXYkNt1K7nyxc86oLIjwrIBToD/KR0PodW9/5bCPPP0bgOXJKLjyiMlAN6nO+hVgDsabSNX2slPIeR/BmbwRJofFuFJwjjMQYNYQceWq/1ezu+TA4rBVnJUUMU5Y6Mu62VCu/4Sf860zRhb6E1VTZDVBLBBy4o7/Ic8e6NdVcd97dy2gkOhAv0fHUSHEtJlp94dm74jg5PlSJA7EteO8/x+JCDadEUfLEdnEpTToC7zdwrHVHlGo2CbZvQgf9Ct9qEt6BMMd5VY+mKA8rTzr1FhogQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(86362001)(26005)(2616005)(6506007)(31696002)(2906002)(83380400001)(53546011)(6666004)(6512007)(38100700002)(36756003)(8676002)(5660300002)(66476007)(41300700001)(316002)(8936002)(66946007)(478600001)(4326008)(66556008)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZC9wM0EzaENqRStkcHVWanBKN0tIdWlUWWtNTWJGeHpYWktPVVdrVExCVTN5?=
 =?utf-8?B?ZTNVSTNYcDh5Z3RXSVppRG1GblpTc1BzZVVJQVVjWC9mRzFXWk1nZlRpM3Fi?=
 =?utf-8?B?eG5HNjRhU0JlSDlsRmhHQlRNMjN5eEdVRk1nQVkyRzFlTFY1ajZvNGZBaWRP?=
 =?utf-8?B?LzhPRnA0Z2VONFZTNFRIcHVXdU10VGc2NHFMOHdXZUJFMDJJTmhoNW5zNnRZ?=
 =?utf-8?B?MlpodnIvbU92ekRVR254eUpIS2JVbFpSaDB1cFdOSHJPVW5sUEJ5TTRzZC9O?=
 =?utf-8?B?N3VIVEVEd3BrWllSY0l0Y3JibWsrV2tMYmFPNk5oTzFQcUVEVmVrdmtsR3h6?=
 =?utf-8?B?WkhFTzZBOHFNVVcvR0tDVVRQeDhMdGYzblFhcElya05vbFBuKzZVZlFPN0xI?=
 =?utf-8?B?dEtwR2hUcFNEZFptY2JFY0pOdUN0SGlGQU1SUmh3ZmxkR2Y2NUdRMXBOblox?=
 =?utf-8?B?TzIrNTFEYUZZcFM2NjdtL1E2VUtFZDYrUklhTm1UR3d3RmI5Wmx0bFkyY3hG?=
 =?utf-8?B?aWhHL0YxYXFydG5ON095Smh6UDJxY0RROW5MSm01WUQxMCtUWk1QYmVVS2h5?=
 =?utf-8?B?VlN1QTlrajdBNDV3ZG1wdyt2d3lsNTB1bE1ubTNBREFuZmtITUtDcEg1R2wr?=
 =?utf-8?B?b0VMZGt5azZiL3JiVE9MSVErT2J6bG9XQ003WVdkcHZNZzV0TGwycTVuSkdv?=
 =?utf-8?B?UnV0d1JSb3hXTC9USmNPWHM3eFJQSFhRSTA0UG9OM2t0RVhwbVVlRUhPczkr?=
 =?utf-8?B?MFNRYlBzbDQwQU9MdndpVjBsWS9Fb2NJZFpVSnlIVDU4djFHRXkxaU4zd1Fk?=
 =?utf-8?B?U2pzYnR5Um9uWGhGR3VmU045U25EN3M0MHJOLzVJNVArdUh0OFBkaHdqdUM0?=
 =?utf-8?B?dkczeVdOMGdySk42MnhhdzBjdHMvMGJqeXBkYWorVVg3SFQ0dHROZDBJWndJ?=
 =?utf-8?B?TzRQemp6ZDAzUkVUSGREMENLZDhzZDRPekRuNVRBNDlEYjl2cmFHR2ZhSENm?=
 =?utf-8?B?SVgzWDVROHZJNG5FdmdGNDc2alNFWUdKWDRBMDlxTnA1bExkNHEwcURJS0E0?=
 =?utf-8?B?aWRmdUpKcENPTXhTRjBqRFloS053SmttRlpiMjRmcGdkWjBmTmpjN2FsTVVN?=
 =?utf-8?B?d0lFNllSMjUyOG1EVkY0VC9UZGp1cVFFQkJkMStsUndHMktuMDMxYXZueHEx?=
 =?utf-8?B?NVNvUDhQdWluVjJLS2R5NFlGd1Q4K1JEemwvSnErbjB2VWlCRkt0SnozSzA0?=
 =?utf-8?B?UVFpamI3UkI4em5MeTF6ekhVWmxHeVdqNzViZmM0ZXpIWldrbERoeTg0cW9Q?=
 =?utf-8?B?d1VNbU1iQVE4K05WZ2lyNmhOZFg1bnFob3puM1BMaDdkYWpjekxnVXdibG9U?=
 =?utf-8?B?cUh4TlFqMi9xczg4U1VPZk5qaGIxMXE4emgrMWpuazZYNVlReDRQV0hpcFZ5?=
 =?utf-8?B?N1VmZTUzZmJGNjEzR05pckwvd09qSXdnS2FuUHVGWElER3d2dXkxcEcrK2oy?=
 =?utf-8?B?d0FLbXpxOTF2TithNUt4S0VCaVRNeUY4ZlpOUVJZdGRqcHhDYVVXVWN6Qk5N?=
 =?utf-8?B?WHlINTA2Sk5wL1VMenZxbVU0V2R1WUFieUtYd2NadnVzaEdFdW5oUmtvalA1?=
 =?utf-8?B?UXZ6d09iYUZoeEhWWW84OEhMdWpPdDR5NlhraHNELzJkdjFBbXFDTWZtdHVw?=
 =?utf-8?B?dVd3Ulk4ZERjaWs1ZkJ3SVpqVFFYbDczQ1hWckw2bUdnWE44azk2UGQ0MGt2?=
 =?utf-8?B?cUpxaTZ4Y2hHcW1JT3JyckZiTnNQUE10K1QzY0RWQ2NKOWt6ZUd4aGQ2QzEx?=
 =?utf-8?B?L1FFd3QxZVJqYTFHeWIwcGcvS2oxVUJSajlFRlB1b3ZXeGpUS3R1SThYWjJV?=
 =?utf-8?B?cStnZkN5NEZNaUkwLzVjQUI2blJhWE9FUE5wWXpEN2Y5T1NiNUlOa2diWExM?=
 =?utf-8?B?S29pYUZGY28wMituZzhrbk5TMW44a0IxcGRYUXJnS0xVTlgrNHB0TEd1UzlP?=
 =?utf-8?B?UUZDZXhUYkc0RGRXSzRrNVFjS3NjOHJNNWVKK2VPZmZ1TVVrMnBFcGhCYXpG?=
 =?utf-8?B?NnpTdDQwRExBSnQxU1U1dFhQWTI4WXFOUDMvcnJuY0dFdmhBV3pGZ2lkQ3Nm?=
 =?utf-8?B?SG4yNm5odFoxUHlVdUV4emlLMmRjN1dOZXorVlJYenJYVkMyZVUvVUs0Tmdn?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e487d3-1696-4e7c-138b-08dc01619aae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 13:43:10.0347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wa/Nx5rOLuNTXR21EGpsFpaVW+CS+L1H+H6y8Yn17CwgZAhHsZFa4N0aME08hlXsAgEA37eYRbNWxpDJkcfs+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_054315_165219_61FD6F73 
X-CRM114-Status: GOOD (  14.12  )
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

Hi Keith,

On 19/12/2023 19:49, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> nvme_init_ctrl() always sets ctrl->numa_node to NUMA_NO_NODE. Set the
> desired value after that function call so it won't be overwritten.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/fc.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 9f9a3b35dc64d..2de506d58593b 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3509,10 +3509,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   
>   	ctrl->ctrl.opts = opts;
>   	ctrl->ctrl.nr_reconnects = 0;
> -	if (lport->dev)
> -		ctrl->ctrl.numa_node = dev_to_node(lport->dev);
> -	else
> -		ctrl->ctrl.numa_node = NUMA_NO_NODE;
>   	INIT_LIST_HEAD(&ctrl->ctrl_list);
>   	ctrl->lport = lport;
>   	ctrl->rport = rport;
> @@ -3558,6 +3554,11 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   	if (ret)
>   		goto out_free_queues;
>   
> +	if (lport->dev)
> +		ctrl->ctrl.numa_node = dev_to_node(lport->dev);
> +	else
> +		ctrl->ctrl.numa_node = NUMA_NO_NODE;

We don't need the "else" clause, it is initialized to NUMA_NO_NODE.

Otherwise,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

> +
>   	/* at this point, teardown path changes to ref counting on nvme ctrl */
>   
>   	ret = nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,

