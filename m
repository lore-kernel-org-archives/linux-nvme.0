Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0E6C54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 09:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lPn90cefn+KkbfnXmcUH9bYS3VAL4AEt9EhaXSuJmwI=; b=Jc0wm7d01GixCVrKGyNQriPCvE
	eXtnRwM6hlXOBNSgvhl/cXxZTmWBzbYYu1v4f/Csz6t/S3++sQ3Qe9HTZCyPUqbp5Wsi6J/sx7wJ3
	qJu9HvYB9bqQ5eJi/wPeK/2S1Ef4NiJZ8xK6wrSw8YYrfT7+5IDdMFt3CvDK0dZYrq1U0qNFQGSOv
	V2NIuRs1OteKukVk0YrVBwrUm3dASDewULKW1PKD1Im/rdrTITO+Hrx4qx/cArfI8Iakmazr983zA
	cM31Nn3MLS1Lgc2UgsbuYp6fouQymZIVqr689jcEaixupkuoXisphldV9IMzAype0ubDn63ec45l7
	YMtCC0Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riA3s-00000003rLh-2NNg;
	Thu, 07 Mar 2024 09:29:12 +0000
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2412::601] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riA3o-00000003rJp-49sG
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 09:29:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BKbFRDJtYDrIuM7rPHTkMtDZOcgK9VY4U1rnLnLcFVjMbigIPCx+WJJn3nLHOmxBUrUu7NNMBBX8A31LIvP+Cra8IMuwahksBur3xVs6aV36s7DdM2syD4bov7Qfq2LRd7XtvVNDqrbh8hRTJgqSWA4I83Q9gc+HPhphVK2N8UI81zCnzW++JLEihcgaGtQv5+9sdfdSxjmjVo9cyncdeRr1wG2D42sqFziS280zyNnqnFf8FYEpK42LaJ40en3aHPZAKC90T+ugur/1nZWKbz59bNzZw+60gm9icUKRUL76SAOjKs65Yi/MLSk6eeUiseRGPz4ir/BrejagJs67Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPn90cefn+KkbfnXmcUH9bYS3VAL4AEt9EhaXSuJmwI=;
 b=DQs2MdmgW3PyZJ79mPP3DKT5VDeshJ8sz0W621keaS9ElfxWOBuuP+y5fNXXbymmK/1eS4BJv00mwEzpcRlUyyUmIFO60hDBr+ujOPhAVpno2yuJ6lTUB2V1hFSjShl6tm5ZGv3BxliBa6cBoWmyUakSwnjhVx6yX8Vu6+b5Pp03B5+F6T9WgEKOPVhAEaiPsLnbZMVjsJYCowYCii5kR/3MwNNrmnG8anuVkYmDC/DBiUti2LzuO80Z/VPcmxIqizYsGvPw+waIVsYNvLl6+750CoDa7QzGLQvhrdPseJZLBrOu+hP2pW0a3N7q4h3JQMn98Dxj8nyIUqqv65WsGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPn90cefn+KkbfnXmcUH9bYS3VAL4AEt9EhaXSuJmwI=;
 b=rMSKzGS0MpXqXlmlfkUpIpLP6NcYsFSfcCs9kg2Y/K38IPWZoTcY2vRoc0G6cXRV7hl5riWC2RCJ28rLoQY5HTwZ1OTQh9YzCozwymH+ZC7k7Vu/QjhwZesomjBYUNwGhofSr1J7t22HuEJq7f/M1/dIYwhjCopilwwhIkrwUXINEgkdwMCm+ApOVvcrhLVDP2cGwFEIfRW+n0qjq+yLQDED/EWdLMoJASE68xl8IpjlhNfOFsNR2D3biFwC7hMERbfD5iL3uioMqJ2qzRtvpEZGN/2TGV3KpUldBXpdgkGQDN+SX25EwQZWIaWLftkkDM7dDrwoLPSfMD/X6Dlwbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 09:29:01 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1%3]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 09:29:00 +0000
Message-ID: <dc6c4d98-e56a-448d-b372-38ce0cd927e9@nvidia.com>
Date: Thu, 7 Mar 2024 11:28:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: Use pr_dbg, not pr_info, when setting shutdown
 timeout
Content-Language: en-US
To: Len Brown <lenb@kernel.org>, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Cc: maxg@mellanox.com, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
References: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0601.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::21) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: be61e20f-ea3c-4c00-93ff-08dc3e8905bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pT/aTAzuNJRh0zDpjAYekuu7gWPKXCAOJpE3vpMddM3iMhiGBtuOmtt6PGEBJOriqaqB7l9b6yhSHZnkJJrC+ZUXK4M4yA+80iOu2iFo0HgQZFk2q7ZJKlv/6+3hedHzjgwFdm9HuRdkyhTpdPDNbvlMfm96IGDaF4KOlRTDw8NTzwoI8YvDkhzdKIl8WWtCX6VdW5N3s0j7Gu6M1OX+ksybC9i/dtCfEOz0D0N/+LkjULDG2cAQrdpSPbB82RLKZ3HusdN3YpQ1tRAvfm0UY4TW5cAXVd8VMu4cOKddO3WlfTjVY9nQc75LooA9EUCBD3Upv4kPozpLdigxPTS0K9FiA/MfdpTBgMdy20dCwJY5TE7Zuyb/oyZ9bi318xSY7ECouPmKkiBJn47tklrRoxPDw7ojvj+RKS+wHTomPgCZyU1+kP1WsIC4l2wxLot3/EBmLisit+181h7JDTeLoLsZthi4dOkdWHJqIyhnHfe1EFWjWLKAHq4PCWnhLIEngodkBVb2PShRMPdljJCY1g0+UrLp3O1E7Gwx+a7CyWjXdZj+06wOSfpbCEAvm6LGMIlvkrMlG9KXHZswkLkF/cmuKgqfZOHpptulREUoM6Wi1VuOiVVLUCfeVHS9CP14RYS4Se8cr0triuEypZQRfhemd1T0FvmJlUJ9zj6qIAo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW4ySDJMeURwWmtRRHVUMk4rbXduNlNKUFQ1Nzg2SFBwL1UrT3J5NnJxRHlF?=
 =?utf-8?B?YjVqaFVHRjVmSHhxV1FZMnVHWDlHZjg3ZnY2MTF2RmhLRmpxUGNLZm9ORmw2?=
 =?utf-8?B?TFE2RWJzczc2ZStiYmdheElkRElGVFAzMStsSVlncGRsQjF6bDRqOUgwend0?=
 =?utf-8?B?WklRQVpnWmlFNUMwNGtvSm9CTFNhUDdBLzhSQi9YZzRjQjB2YnFIVllYM24x?=
 =?utf-8?B?Y3RrYVJFRTRuRkpKWEc4c3luNXRhYUV5OUJ2YVgralJhMzdwZVVIU0ZGTDF3?=
 =?utf-8?B?aXhuQjE5UWlQTkY2TFNsWGdKLy9xK21xYzdiRXYrQmlsQmJIY2pNaEVsN1U1?=
 =?utf-8?B?TC8yQmdiNVhRZ3pXN0Z1VTh5ZzlTeEpUaDlBYlFpWURtSzRoRFhOZ1czeU1o?=
 =?utf-8?B?cUVPUE5aQTlDTzc0OUF5dWhQVFdFaHgrRldnMjZNTlJHb1BxV09RNEViTHhB?=
 =?utf-8?B?N2piUFY3MTdhYVFNN1kxb1p6M0xHQzJOZTlOaURxSDIyV1BNYnBhamdUWndS?=
 =?utf-8?B?bW5nd2FkMW9xcTNpOUkzZnlzS0sxbEFQZkFLV2V4aDkwV3NqV25QQVpkMG5z?=
 =?utf-8?B?dVN4UFVPcnpYdUpCUjJEbmcybi9QTnZHRnFOTks2WkpSdkx1RXB4NXc5aWZr?=
 =?utf-8?B?VjRtMGJUMlJuQldvd0ZtWGpEdTlid0ppTGZ6NFJOeThHUi9hZ1BibGhKZlBz?=
 =?utf-8?B?dDM2Z01HUTlTcmpZS2pDaE5hSVBNOU0xZmdqOUlEZTVwc1Z4QmtxbmxiNFpo?=
 =?utf-8?B?MGh6T0xhdTlRZk5VNnFKQ3puZ2F0Um5URklWLzhQV1U5VjUxT3o2YUFVMEJN?=
 =?utf-8?B?NXJWc0lQemdLaXA2dDlCd0hyTnpRZWRlN05ZdWxCY3RrYXVkQkw1ZXBKK2Nn?=
 =?utf-8?B?NTVIeVBkSGNpT2dxS1liY3VKZjg3RnZ2Tk5SeUc0K0RucFVsbzJUb0VkWmd2?=
 =?utf-8?B?b01ZM3NJakxzam9mYjkzbENHWVZNemUzSTc3TGMzSkJVcUVtTmZoMlg1UUgy?=
 =?utf-8?B?N3l4d1lEWG44YjhxNVkrakZSYjh1a2VjMURKSE00MEVoZExiNFlvaURZUEsy?=
 =?utf-8?B?a1MrakoyMGJkcXpkOUpjV2FSRGdpd1QvSEJhRFpacWI4cnJMVzcrV3VDYlQ1?=
 =?utf-8?B?bGdHM1NYTnpzTGhMcnJ0OUl5a2llcjd3VmtaOHZ0a25rRWwwMTRCQTNMSk5a?=
 =?utf-8?B?M1kvWVJkMzlpTmtpVWkrdnNSaFFQclFQVzk1OTBWK3ZQaFVYUXNLN2g5Q1RD?=
 =?utf-8?B?azBSUm1LQ2F1cmcvU25wQzNEOHZBWStxeEVnczVhY2dGVkIzbU14allKU0RD?=
 =?utf-8?B?VmJ5djdqZ2pMY29GVWYyNXc2TUszVUxGMS9wa0FHMEJ1VVBnRGZhTHR5ZWtK?=
 =?utf-8?B?cWVkUkRqSUJzZU01NWF6bWk0eDdnTHhHVkMwU3F6MXZZdGcwRDNxVGloTUdN?=
 =?utf-8?B?b0JXQ09yakZJZ1FFYThtd0ZySnU0WjRBalhpZkU5b25UdEhkZ0w5OUljajZq?=
 =?utf-8?B?aWlIcXZuRWlKNWdaM09GYndnaEhsTll2Sjd2eGF5OVJYWTFrVnJMUFZwYTBi?=
 =?utf-8?B?a2VSUlBXTlFzTHAwYXMybDRQRTIraExnNmRtai9FekQzU3VrUTc5aTRNQlly?=
 =?utf-8?B?UnpUWmM3RFB1dGMyNUVCNXkxWDVoQS9SQmVHWC9qMmFDZzE0WE1Ld3hPdmoy?=
 =?utf-8?B?dXVsYSs0ckZ1UDVUWC9pa2p2eXFsbTU1UGRqVjFiczA0UjlrVDRwL09GSVJu?=
 =?utf-8?B?cmxQRHBmU05kcURXTGhTR2ZJQ0o1Z3dXMXQ5VzV5cDNzcUNnNWZWTldkRjJu?=
 =?utf-8?B?K0ZCOVpiYnNVNG4ydW9yOFFGZEh5Ymt6cXRNdkdueTRJSHNMN2U1RTFITmVj?=
 =?utf-8?B?NVNPNEY3ZXJuT0pWcVFkMVFCNnRiQnplUzBUWi9UOEg0K2ZsTHZSOTRRSDRl?=
 =?utf-8?B?bHZxNUtIOVlSWXZnRjR2VzVaU3UrZUdSTkd0bHh2bVN6S2xlYXpON1c5Nzg1?=
 =?utf-8?B?UFBCWXZXQWZDS2dnZUU3QllTcURmZWorcDYrVE04SklMbDZhdzlpSTlwdXZG?=
 =?utf-8?B?VjZpSlFuTHZFSVlmVW9YMGlkZUEremw0OHVjT1B3YXNVSUV0L3Y3TUxMYk5U?=
 =?utf-8?Q?pkgtqdD6QZ9o8LkJNV4Vhr1Lj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be61e20f-ea3c-4c00-93ff-08dc3e8905bc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 09:29:00.9251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xTbVm4hs3KVeMGa4dt414hNVp9VAZoqvQX22dc8mzLn8I6P1+sqwS7CctC5sAJJK7piFdQBMNTYqgdfNNr8kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_012909_164339_A7C1CCE2 
X-CRM114-Status: GOOD (  20.13  )
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



On 07/03/2024 3:05, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> Some words are alarming in routine kernel messages.
> "timeout" is one of them...
> 
> Here NVME is routinely setting a timeout value,
> rather than reporting that a timeout has occurred.

No.
see the original commit message

"When an NVMe controller reports RTD3 Entry Latency larger than the 
value of shutdown_timeout module parameter, we update the 
shutdown_timeout accordingly to honor RTD3 Entry Latency. Use an 
informational debug level instead of a warning level for it."

So this is not a routine flow. This informs users about using a 
different value than the module param they set.



> 
> Assuming this message is actually useful to somebody somewhere,
> let's make it DEBUG level...

why ?
I don't think it is necessary.
> 
> Fixes: 1a3838d732ea ("nvme: modify the debug level for setting shutdown timeout")

This doesn't sounds like a bug fix to me.

> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0a96362912ce..e361af1953a4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3205,7 +3205,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>   						 shutdown_timeout, 60);
>   
>   		if (ctrl->shutdown_timeout != shutdown_timeout)
> -			dev_info(ctrl->device,
> +			dev_dbg(ctrl->device,
>   				 "Shutdown timeout set to %u seconds\n",
>   				 ctrl->shutdown_timeout);
>   	} else

