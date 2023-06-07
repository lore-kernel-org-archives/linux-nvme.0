Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA8BC77B7A
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 08:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6/BNzNeAOfWsAKs3my9FzhzKUF+3ZmqXaC1TbkpXzBQ=; b=aVQmcmpsmzCcIRAAg5l3DFdS6N
	rZgYHKx8dM5MLnfjcW3U1z5NIiJdPg2gDvzGEKtmVBoLlxfObtfoNkOusztOb+qCEeW1a4cipNJSe
	aH6zVLrzsmQLGjnzQBj0x9uv2e51LpuG9U3oUfpbv3eu3Npsf4WiloGOA3FTFG3U2A1PzaeFxWZTl
	JPRPCw0txJhdVi08ND3W5HcRFP29hdqaHrqF1uenImNK2xv1/noxhryqpZ0McdQTQdzbnK36VpkD5
	ui/LHbX/m3eCePxTmahPzyR66eDc40ZzuyAgJ/5AApiWFu2nTljN7Blvs0+2BoPp7cE/W+4zcwez3
	EJLZ1Jdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6o8t-004r4w-1S;
	Wed, 07 Jun 2023 08:03:43 +0000
Received: from mail-bn7nam10on2060f.outbound.protection.outlook.com ([2a01:111:f400:7e8a::60f] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6o8q-004r3i-1p
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jun 2023 08:03:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty7EUzTtmm+TPT+Qpttj9+L+iMe3MLwO5q25xdBXrXL4afDUJYkQxDXOE17INhJt1e0rHxQ/JiP3UN4mrCSkWEWzYHf/ZXWsbejHzd19FM3pVE2qJBGRtJd3QVQi1BYHJv5YTg5/+CnBJup4f2FvxsrrN9abTY4BGTFsetQVtiVuI/eRjYBVBz0Fja2A5g8FBgBvr4FHYgsYtT50HpbE4H3fXHtN3CraDwrbgxqju39cxnBb86SEstErBD0wuJqw3ImfadI0rxjq64zcBRP3Rf5SnBvwn8jEblMplxIfCPABX+Bb5KX2DfyheODuCDlAkYaNYRrgXD829urq9zB4lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/BNzNeAOfWsAKs3my9FzhzKUF+3ZmqXaC1TbkpXzBQ=;
 b=b8Q0BDljfsVv8Bgbt+5ZZehlQ/cbnMzgMIITxsRxNdonNV0vFwA2FFjBl5E0INMuC/ag88NOgPQt4PtGQNiUOLyczhqw0KzXOV8xVYNrFgSsfLZvXesy6apkOdFGwiMmys2tfI5SWbSOKzeCbboCsYkxRd3p1zdtt/2Z2ty8TJGHa4iaMOXZgiEBbhamwR4Gr0uZHyRcVOawfRHrLdpQhKPNo2tm2M843h2vnT3TuxqEBhOg1MgBdeO/U7nJ5+JHBMqc2JxZHJtOAo/gGEnUD/7Q/KwurZ0CYN9f7LlUrDjOspImgberzXgojWlA/MNv2o5jPYCmkglx4r83Elf2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/BNzNeAOfWsAKs3my9FzhzKUF+3ZmqXaC1TbkpXzBQ=;
 b=toabe2KWcLh5VchfNbFo/iS2ZBM21MY5jevDeeibVY4IkKxeLgGvRjvdk9htxI7cLx+6FobgefuHT7rvZoFv3WWYMG+gXPtKZjw1A+54gmej/DitbreztvlnHMLFSCyDdTVsEmMwpfGARyugmdSGPdoubAAkvJ/S0sdiVvQ9NqhT45QvGr59/LuD1s1+HrcIncRD+1go5uDWyNNTCcuBnfZPeBqeSvfyRli2/ytjkC1PzHNyyCv5w8XcJ6LV/SyT+mBiMpqgNunah2XqOzFi6p7s/oZV3TjVewZhhPqJbZydQ2ImaiIya77DZilUoheoSbl73PWVtJyueOrFqZlmJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BL1PR12MB5206.namprd12.prod.outlook.com (2603:10b6:208:31c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 08:03:32 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fe3:edc2:ade4:32ea%6]) with mapi id 15.20.6477.016; Wed, 7 Jun 2023
 08:03:32 +0000
Message-ID: <ec66d848-5246-529a-7050-afca3d1d981f@nvidia.com>
Date: Wed, 7 Jun 2023 11:03:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] nvme-rdma: Fix T10-PI when SW doesn't generate/verify
 metadata
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Israel Rukshin <israelr@nvidia.com>
Cc: Linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Nitzan Carmi <nitzanc@nvidia.com>,
 oevron@nvidia.com
References: <1686048690-374365-1-git-send-email-israelr@nvidia.com>
 <20230607050855.GA20010@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230607050855.GA20010@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|BL1PR12MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: 2927fe89-c146-4d83-0684-08db672dafa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U22bx1yrsmyZ1Z+dyw3kf36PFKC3qLjDpmGx1VW4cb/zXpo9eeQxaxz/7ROGO0BcAY6ZoBZJYC/iIumi5L1VmqRVcTo6BLhqPsdADZ8u0TmmvTkZATHdn1E/wpgq/6m5CNZsr8rpU9f8lFpo5QtpBOI5+2Y8wT8TIu2r5Wwmg2qmxJ0Q27WHXdPwtbQZtR/AuIZMqEqDpTtPLZjTbfGVZUzLDH2e6HBZNkbOdgppNbTfrt4U1Wye0DKYxk9CgWGBi38dAzufVZgwy2NIRdBQDRj3CO7OnfB43n7GUotz8NaKNmSpr5JwYfXhGC1GHjO9+tW+K8gObATeUzrZqZNAT7/iVnudt0FE/JGMrAPnPn+qGykqz2xJ5nmycnslfgSb1oRZOw4mLQfx8PAjog8c9IeI0Z6bMZ8mQylL4rENjXvNFHbyINPBZ5tmKPnOM6Oaa6KuqeoQ5Bln3nrDjEqSKpkGj5T9XoYQZWThMv+064jCa3jZq0uSlEm2dEf4X0d+OOMH5ShH2wa0izkwksTtlPAFCryrb03mc/emXIT417qRYa68z0lMR7rM6TGUbCqBr3sWzuLkuVuE7s1ddlyCmbJm8IKjDzbvU79+iZhCb+XRss4MW8WxXmoAJpYuJLY62iHbCrDxZyMAU7uKWyqojriF+nZ0GwYygVCW1sZxnLF6qnVDSovy+LwpVFdEqbt/KmY9FTIAKNXV2CpZxJzgpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(86362001)(83380400001)(54906003)(110136005)(4326008)(6636002)(38100700002)(66476007)(66946007)(6666004)(66556008)(6486002)(478600001)(2906002)(36756003)(186003)(2616005)(5660300002)(8936002)(41300700001)(8676002)(15650500001)(316002)(31696002)(31686004)(107886003)(26005)(53546011)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGRrWVd1dlJ0bFlBSjFaY25laWsyMlJJd0g5NUJ2WlVvVFdaMkhoeWZkK1FO?=
 =?utf-8?B?MFdyN3NNZVNIOGFSZEhOaDMyYk9zQ1M3djdLd0FVSWdFa0xOc0hGN1dxcWZ6?=
 =?utf-8?B?dVhhMi9GUzBLUFNCM1U1a09XOG4yclhhdnFaR1FTdHRaYlBzbHRMUEdhMVRL?=
 =?utf-8?B?cWdZNXdsQ3RjblNzbDA1Ty80VkFuUm1tWmp4RisvSWI5Sk0wNUpXSk9LQ2RR?=
 =?utf-8?B?cyt6Qm8yWUxBV0x4UTNtNE41M2huK3VHdkhqSUg1MkNPNjlUUVlEbVVFdHRl?=
 =?utf-8?B?SVlDWStHK2JFZXdJbm85R2R1eXhWNU9nSmQyM0VydXh5cXUvTm1kTE9hSDQ4?=
 =?utf-8?B?Qm9xQVptcEpHQThiUVlHS0xWYkZFS1FxdXFBZks2ek5TUmMwc0tvNG5uQUtZ?=
 =?utf-8?B?YzArUzVUSnNvaGE1SkVFQ082QlRpMGhRS1hycndvOXVRNWhiZDVqY1VldDNy?=
 =?utf-8?B?VFdJdVg1SENkUjdNZWZJbVhEaUZyZWFkWVBuaHYrbSt6a1BPQXRmNytUaTR1?=
 =?utf-8?B?NmJDdEQ4ZTk0WDBnaVJHeUI2Nm1PREJrdnhnV1RLUEFiK0JzMFo4SWRhbWZ2?=
 =?utf-8?B?cGtjQndRUVpNbEJOcmR3OHN5bFk2aURyVFNsTW9raDNZLzBuRFg4dysyQTJN?=
 =?utf-8?B?eTI2L3psbnVvM0JLSEplM0ZMTnQwUFoyenM4aUhZclVEbERIeEVHU083ZzRI?=
 =?utf-8?B?eTR0VEMvbDNmRnA4VzNGSkthemRoUjVNSDN6R1RGMGNFSGNvL1F2ajBtQUxF?=
 =?utf-8?B?ZVB6bkc2alJtOGZRcU05V1FxdkdhR3lmV2tHRk9DN3cvU3RjWDFSQ01CNFZ2?=
 =?utf-8?B?d0FaM01wV3ZqWk9aU3VnTnJXNXZqM1pqZmpiQWFvZmVJUmd0OE1IV1RIZkJB?=
 =?utf-8?B?TFZOOGNuUW05V0luTkhYemZSMmxTRHkyRWZBSjA4SGdibHZkOGlFdWhMTXJx?=
 =?utf-8?B?LzdxaGlUMWgvWGl5dTlONzJCc2ZuaGdlVEtFQ2hxdGFtWTh1M2M4amZiWDF3?=
 =?utf-8?B?WERqZVAvejFqUkRqSUVkMmRrcDg5cG01NGxQSWtzdGpGTFdMQUcrU0JtdXBY?=
 =?utf-8?B?M3ZlNElOZ1VGLzBiUHFKY0dNanEwZkcwMmxRVGtTVmxQUWVudXMxQ2E4c3dE?=
 =?utf-8?B?Q015OXY0Q2tHR0dxc3BzcllJeUIyVjZlOG44ZDVIamQyTzJMZjhDUGo2aEg1?=
 =?utf-8?B?QXdoUHVJZjV5SFZndlBkbFJnbTZYQUVieSs3WGtMNnBJWU41UEJkUmwzUEc1?=
 =?utf-8?B?dk40MUFiS0k0YnZHb29MK0h1M3lOaG9NOXR3ZVVaS2dWcERoZDl3a2oraWZ0?=
 =?utf-8?B?c2NvY05qbHVWTTQvVkJyV3hVakhJaXZMVnNLaDIrWWlDVytlQUc0VUl2K2lZ?=
 =?utf-8?B?TWNEVFhIVUQ1R3EvRlNHK05YUkRyMU5ZU0RTRVRNMklFdysxTXJYQ0FycU1s?=
 =?utf-8?B?N2swb09lQlJ4dGUwWHpJOUtPSEVOdFYyczF6VnBrZ2NPMkw3V3cvUWNzNFY5?=
 =?utf-8?B?bWkxM0k2ODh1blhOQW1xYWpBaDVVQ0dlVU5GeGRiSnhPQlpOeW5IOWs0aTRa?=
 =?utf-8?B?aWl6OXFhQStjVEJXNGhFR1ozajBHVW9YdlZCcldzdlR6RzN1a1V4aUVldytK?=
 =?utf-8?B?aXlOdXZidzJ1ZDFUbERJOGZGZE1Dc1VOVUVnOHZtNk9wUmdIbTRxQ2t2U1hY?=
 =?utf-8?B?SFVURmdCZ084UnV3TlRzZEM3QWtKQkhvZThqdXN1OU9XWFRKMTcveHFvV203?=
 =?utf-8?B?RTEzZHAzM08zMzgxNE9KZ3YybjZWcUFtL3JKR3B3eHpRUWdoZWRTVVlIMXlB?=
 =?utf-8?B?NUdZY1dsZmVpTGpjaFptS3pTUW8yaHdTakl4aTZ5bUtTV2xlZlZaNnNKU1Ni?=
 =?utf-8?B?Uy94Yjd6OVZ1RlFPNWlhQjF6alVtR0lkK0pucGt6dGNtSUhDOElsbEpDcWRM?=
 =?utf-8?B?MmhNR1o1dUIxNjVDNHl1dld1Q3hJdkV1Snl0U0VWYmt5Mktyc0xLN3c1Q3Fs?=
 =?utf-8?B?UFIwSTNZdDZWTXpwc3BFVWp5elNiWVJpZWdEU3NabEJyRVA2NGl5UHIyNmRx?=
 =?utf-8?B?THhwNmJJU3pCczE1bXRFb3A5MTluTTZFVFJ4cUp6WklNL0ZtcXFEdkZURGJm?=
 =?utf-8?B?ZVBYeTVIb1paRTFYQ1R4TE5SQUZFallHa2djK1o4VjJrWElLcWxrSTBGTmpN?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2927fe89-c146-4d83-0684-08db672dafa5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:03:32.3108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCV/3Wy3goUlNC6RXuuZiFKldetWXD1eWOzvuZL+AaeYKL92XUSYTns8VbM94wkeQaZC5MU9NsvuJZDnl/2C/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5206
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_010340_627952_049375B5 
X-CRM114-Status: GOOD (  19.23  )
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



On 07/06/2023 8:08, Christoph Hellwig wrote:
> On Tue, Jun 06, 2023 at 01:51:30PM +0300, Israel Rukshin wrote:
>> When the SW doesn't generate/verify metadata, the SG length is
>> smaller than the transfer length.
> 
> What is "the SW"?

better to say the block layer.

> 
>> length when there is no metadata SGL. The bug reproduces when
>> setting read_verify/write_generate to 0 at the child multipath
>> device or at the primary device when multipath is disabled. Note
>> that setting those to 0 on the multipath device doesn't have any
>> impact on the I/Os.
> 
> And we really need to prevent this from happening per the last
> discussion.  Please submit a patch to fail adding a new path to
> a ns_head if the PI settings mismatch.

We're working on it.

I'm not sure what is the intention regarding the support for having 
shared namespaces that are not under multipath. There is some comment in 
the code that some support will be removed.
Will we allow the same namespace to be exposed twice ? or only the first 
one will be exposed in case there is no match in the PI-offload 
capabilities ?

but the above doesn't answer what is the behavior we should have if we 
change the read_verify/write_generate of the head device ? should it 
propagate to the children ?


