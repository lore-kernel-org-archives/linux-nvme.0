Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FCFC3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 10:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JaSKY7ogwhVkOl69kgS9swBkIri6JzddNh8bfST+Xzo=; b=vCRkPWHKy3NSBG/bb7rmIWOwJm
	Pqiwl421D+1bUZ6JGkhOXvR/trmCFUmevBX4K5RfG9C06F2woMXSgaH654teVdwaCmrBoaFVLqJg0
	atFI76MC07uA8fVnluN6Q6SurZM1vDDYMbTRJEMKvCu+I2bOJtq38BsPzdVGSfyBmxjIyBaU3HLqf
	TOWFJw5l1cQakQM9ZxezK4m4b0hBiAsDL4fgQjjacN1uFyhNTZDkkRK9MDLNJZ0bzGLxqY9qsqMIq
	JvDXeFoM9fZ80tCOfnidS0EXT8y2nUol5dwB51Owxqv3RtZQJwNUAcnWwr+dDeMYCj0C3cTHurw3G
	ukOsrN8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHiK4-00AYz0-1j;
	Mon, 25 Dec 2023 10:36:36 +0000
Received: from mail-dm6nam11on20619.outbound.protection.outlook.com ([2a01:111:f400:7eaa::619] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHiK1-00AYwg-3C
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 10:36:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaQ+nQIARSY6tz7Kkitgk0Pfzm4uMeaAvZugvadQWF9lrOUZ7Ja5ircczijOngDMw6wn4VDTtQNGq9bzObxoFxCvdEOYYSlNX6dCC1bzLitmasmSLhwdC9s+9H1Ovv6zYMjPkvKR2pVl1iWlDjEQ/Lbsh2RlEaeF50I030FVURsUzZDAQI+47Vm57AY8muPNPopo3wtO+qHZMPC7dg/6ikokODyYOqpsUVr5GE/yuTyGcwpqZ5xPFtS37f/lQAclifSuULwaussDb0jU+iZCnalFyF10Auw8Gt8LKEnfSjEtziPOz+oPRiw/u0wIXMWhdJJ7PXQuTET8uD/BH5m6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaSKY7ogwhVkOl69kgS9swBkIri6JzddNh8bfST+Xzo=;
 b=KB/N+69Fk6SWuvy6dgTYRFWCmgIL/VhrqAsdpZJLsCMWoDKvHj59qBKB91zFPceUxgox6IuV4iRzXPzICsxB4d1jGqpPw1pNR02//nutxXz5tL/BdyzFCobR4IaitzZwl6M85Bu0xk9vEOJABZmGGfvAuk+0cb+PA2ZziltvofX0rSbxlkztI9hjoL5DTeACb3qf4+4TLvVbzkh9Gg/YU05nhuVn0FUtSpxaadPiCiJkMXwUSB2cIbF0bAG1GILG55w6P47MwOe3D555mHGE332WzwWO+W2deS4rbFXVgK/JT1QokPdbAAETD2CR+Pw494PbYfubee22PeOgSpEssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaSKY7ogwhVkOl69kgS9swBkIri6JzddNh8bfST+Xzo=;
 b=QXkS04ja01YftrUMQSYiC9zyKX9mlpVPYu6jB7WQuFAz5V/ZejR93T8ZJCfQu7bxfNUDjByoX1NvFrg2vu4aGZynKSKOTo3HMX5gxJDkOr/11ryWOfiffiZrbVmXsnMCwpFAahKovhNWErmdzCHcCHyOa0xa6evMUcsJaujqpWBAf6rm0s3pC+wuTy1Wt5TgTHwngiyEkK5yn0tlTV3yv1Heba9IK/9shWBbd4wlJjfYW2EayToGwmF91utsEsAmSBk++puu4/FfEKwtAgi32TsYNj7D6AKFG6AOOSzNE92AVMfClX+LNGoHGnOKMt18Xkd/ZRcI8E1hWqZLoC7pdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 10:36:28 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 10:36:26 +0000
Message-ID: <d5e688be-3419-4cf6-9bd9-bf2c1a6fb092@nvidia.com>
Date: Mon, 25 Dec 2023 12:36:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: don't set a virt_boundary unless needed
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, marcan@marcan.st, sven@svenpeter.dev,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 James Smart <james.smart@broadcom.com>
Cc: alyssa@rosenzweig.io, asahi@lists.linux.dev,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20231221084853.1175482-1-hch@lst.de>
 <155ec506-ede8-42c7-95f7-e8be32800a8d@grimberg.me>
 <8cfe55f2-4f2e-46f9-bbc8-5ab80d06f3d5@nvidia.com>
 <0f126715-9b51-4e14-8cef-c999f8760e4e@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <0f126715-9b51-4e14-8cef-c999f8760e4e@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::8) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MN2PR12MB4335:EE_
X-MS-Office365-Filtering-Correlation-Id: 17542743-5c36-4057-0778-08dc0535592b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXESMdbKWZxW11vrVb3ZoBIOtFLNsmmrWVC6esurRio4aUiEJglxgLRlcaE4PqzKkSfBL/LRQT44CSiUWR2v7BXN589pTQnRZ6BAMWoM1nM7QMmew85izesfluAmSrMA8Ru5/TsgaErx4+jQn0NY9QJ+V/hA5sfzpdMbpdnYUctHyTeJYm7fIyGSVJ9B47HMsZiiJXrLcnGALm7oDfh/+2nHPcV936F5NYostImctDbeP62iweF1Rx6o9h9J41UNwIoMeIO6OuW4dMF+EwenRAQ8UJFLazmXFQy7rwBKjqKGiqTrGT8LzzTCgBCdPbJ3AzjKGVWU3Q3uo/vbipABKmyVpJ82ksgtlen/5joF2QfZHmjZ27gd3A7sti2L4vLGp1YYZJc6V3P3wXuZEpu9B8vP5p67ah52Vke052XI1mE3/At78YZqCU0wvpv6pnw0fdE7sbEEF9EAedQtXqsa4EZd+jRi6/KrqNRJreNpIcjxeitrgdaw1wCW4JfkseTo9NP1Wr7DPaZzP/3NxKIw5ABkSylXRy51lNboiZU14NM6Xt5hW/O70HP+knZ0sAZJ8CR8b6Gp209yP3l9nEpNSxbIW07jp0EVQVH6Aw2u/Z7JKgxhFybD3eKDxniurTgwH1yA0igOy4D2CvJgNYkm6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(107886003)(6506007)(6666004)(53546011)(6512007)(4326008)(83380400001)(5660300002)(7416002)(66556008)(2906002)(41300700001)(8676002)(6486002)(66946007)(316002)(110136005)(66476007)(478600001)(8936002)(31696002)(86362001)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qm5veUdrY05OdzJrNjhDWFFFOCs2b2tUTjYvdys2czZjb0pGcmVWRDlWREs0?=
 =?utf-8?B?N3pnUm5hWENUYkluT1ZKd2FxaVRucWw5ZHdOa1pVR2JyQnJWVkF6cGc4Skp5?=
 =?utf-8?B?dXNXQndiN3F2bW05aWJVNXNHcTNyRHZNL0VsYUEzL0c5Snp6VldBY29BaDZo?=
 =?utf-8?B?MmRkdmhJT0xyVHVzUEpNOHVTelVnOGFsUUFZRXhlSDhUNG5zeGtzT1Q5QmUr?=
 =?utf-8?B?RGtXbzBLSnJUeG83cXFaTVAyY05CR05uRzZGM3VYL0J1TEg3dGJTdTlVaHVI?=
 =?utf-8?B?TVBkZHl1SU1BWkJyR05hUWNYRmNxbWJ0cjNGSHUzbU8wL0VCNkdQc3VjTExC?=
 =?utf-8?B?WjM4NTFJM2o1WDJFVjBEU1NMS1RURWsrRTN4Ulh0L0E5and4Z2gyQTY0RENY?=
 =?utf-8?B?dEJpREZnb3RtQUJRQkt0T0FZczNGdU9FYkQ5UWJiSnI2VVdDT0c5U1FMTEdY?=
 =?utf-8?B?RlpzUGFaTTEwWmpiaTFRcHVBNXh0b2dTL1lLSDl4aFdmczhtMTFMdjNJSEdQ?=
 =?utf-8?B?WlZSeitwbXlzempXT043Q1BrSk1VWTNoMk0vaUp1UmpBNzdGRDV5bHM5ZDJp?=
 =?utf-8?B?YnkvQ2piTVBDclZpbjNPd2llS0c3MmYrczRLOUFOVi9jNzZGdEpWRFJOU0JW?=
 =?utf-8?B?OHZZNmJyWStoQ1dmUGVZUVNwZ1ovRFBKY0c2dURJZWM1cVRGdlZXT0Z5RVBw?=
 =?utf-8?B?MWNtQ2I0OTYrMkw3K29KL0ZQMlpQTE9xMTVudHhEbVRNczhxWkVCS0gzUG1J?=
 =?utf-8?B?Wk5raWdaaTNEU2hBNEhzUlpoeStzNGlQSDNOM21wZnhoNzBpdTdVc2VKQmU4?=
 =?utf-8?B?VHBraFV2NzhpMjFkK3lENk1Uc2R3anhaaTU1VGlEUlg4VG5YNHBXb2E2NzVO?=
 =?utf-8?B?cVNGOUlGQVY0Vy9nZXFmOTRnWVB0aXV0eFRHUVVkcWdEWURlczhHWGNTNTNK?=
 =?utf-8?B?VDgzelJUOEx1NjdkamRBY25hUUE3cWJpR1U0NkNQQisxVFNYVTJMelV6RzEw?=
 =?utf-8?B?OEFxREw1NW4vTjIzaUhQdFBSbVhqRXArMUZ3SWNNRFdjd3dzcHRBS1BMckxU?=
 =?utf-8?B?Rk1DaC9zdjFJZSt3RWhDYzZVU1JuRjBkV05QdlUvRUpScGtUUTNIbWQxSjY1?=
 =?utf-8?B?cmJaaVphRlVxcTFGa2lOQTNWNm54eWxBUlErdjFBdE1nUWpvdmNMSjhHbER2?=
 =?utf-8?B?dno0ZnFMVHhhdkM5Y3Bhbk9wYkhlamlNUTBkN0ZCR2lmaUhnWW9UTWxZdGFF?=
 =?utf-8?B?R0tESFBwUStBeDgwelgvWTZIczBwUE1QUWNnRXhQci9FL3QyMUt2cFRGQzM0?=
 =?utf-8?B?K2pOSTJsL3dham8zK1dwY0djRGdZbVRRMGU3anpSWWRqNEM5S3ZsOFVnQU9x?=
 =?utf-8?B?RncwSGVGM0phYVVjWkZ2YnN2eFk4d2dTeVYvcTh4ck93eDlYQzFwZEladC9G?=
 =?utf-8?B?OFhxd3RXeCt5NzV3ckhzQVJGNURoNFgzTWUwWDR1NXJJQUlUbEFkZFJqaWJl?=
 =?utf-8?B?RHU2czBYTy9pbmZpSGwxcnk2TEU1b2FzMnAzcEhpMHUxdkJhK0paVldLK2kv?=
 =?utf-8?B?bWFqdGVNSFhRemhKbFFKaEI3MHZHRCtieFlGeGdDMVJhZGlGTms0dXpwY240?=
 =?utf-8?B?QXpiS2NXOFZtYm5URGVrTmZ2bWt2eE1aUHFhMHVZcjM5ZENYNHgrUTUwR3lk?=
 =?utf-8?B?UWlvNHoxYU1nUkdGb2tEdUhiRHVpdCtMWk5DR3JkRjNrUjBidTBuOWtsWDEv?=
 =?utf-8?B?ZXdseE9YWXUzRzFEQjRoRVhoMHdLeWhiU3pFMFBYMENwUTdrSFEzRXFOOXhN?=
 =?utf-8?B?M3FuQlRXK2I0T1A1RCsxUTZ0Zkx0YTNHLzBLQS9yalZVb0s4OGpLclNpWVAr?=
 =?utf-8?B?TCs2ck1sR2NwblEvVERLbUc0djdtTnBJR0RvT3lIVkpYaEduVlErRDZodk94?=
 =?utf-8?B?YlpETEt1OUpNaERiWUVvRll2ZnpnT1dzdUx2elltcmR1d3lsN2dQajFSODJN?=
 =?utf-8?B?bndsZjU2UElIV0dud21BdnRUejhxTWNWamZBQkRQYWt3T0lMYjBKMGFiL0FY?=
 =?utf-8?B?UTFsdE9sQXFhVDJOZDJzemk4U1BJQ1A4L0NrUlVyNm9MK2t5NjZnKzVGRS8v?=
 =?utf-8?Q?VakrhmLXaK1CZ06n0BzDGPp+D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17542743-5c36-4057-0778-08dc0535592b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 10:36:26.9298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 042t25QbNiS3+7ckoSg4MQzob1jt83sYM7Fo7iO4Wss+u0uyv6sZ6EUsVG96EwPUoiq1qGoVyog+/Cmmg11a2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_023634_050157_8E02D101 
X-CRM114-Status: GOOD (  33.71  )
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



On 25/12/2023 12:08, Sagi Grimberg wrote:
> 
> 
> On 12/22/23 03:16, Max Gurtovoy wrote:
>>
>>
>> On 21/12/2023 11:30, Sagi Grimberg wrote:
>>>
>>>> NVMe PRPs are a pain and force the expensive virt_boundary checking on
>>>> block layer, prevent secure passthrough and require scatter/gather I/O
>>>> to be split into multiple commands which is problematic for the 
>>>> upcoming
>>>> atomic write support.
>>>
>>> But is the threshold still correct? meaning for I/Os small enough the
>>> device will have lower performance? I'm not advocating that we keep it,
>>> but we should at least mention the tradeoff in the change log.
>>>
>>>> Fix the NVMe core to require an opt-in from the drivers for it.
>>>>
>>>> For nvme-apple it is always required as the driver only supports PRPs.
>>>>
>>>> For nvme-pci when SGLs are supported we'll always use them for data I/O
>>>> that would require a virt_boundary.
>>>>
>>>> For nvme-rdma the virt boundary is always required, as RMDA MRs are 
>>>> just
>>>> as dumb as NVMe PRPs.
>>>
>>> That is actually device dependent. The driver can ask for a pool of
>>> mrs with type IB_MR_TYPE_SG_GAPS if the device supports IBK_SG_GAPS_REG.
>>>
>>> See from ib_srp.c:
>>> -- 
>>>         if (device->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
>>>                  mr_type = IB_MR_TYPE_SG_GAPS;
>>>          else
>>>                  mr_type = IB_MR_TYPE_MEM_REG;
>>
>> For now, I prefer not using the IB_MR_TYPE_SG_GAPS MR in NVMe/RDMA 
>> since in the case of virtual contiguous data buffers it is better to 
>> use IB_MR_TYPE_MEM_REG. It gives much better performance. This is the 
>> reason I didn't add IB_MR_TYPE_SG_GAPS MR support for NVMe/RDMA.
> 
> I see. I guess it is not *that* trivial then.
> 
>> I actually had a plan to re-write the IB_MR_TYPE_SG_GAPS MR logic (or 
>> create a new MR type) that will internally open 2 MRs so if the IO is 
>> contiguous it will use the MTT/MEM_REG and if it isn't it will use the 
>> KLM/SG_GAPS.
>> This is how we implemented the SIG_MR but still didn't make it for the 
>> IB_MR_TYPE_SG_GAPS MR.
> 
> Sounds like a reasonable option. But doesn't think mean that the
> driver will need to scan the page scatterlist to determine what internal
> mr to use? Even a fallback mechanism can be affected by a given
> workload. Plus there is the cost of doubling the number of preallocated
> mrs.
> 

Scanning the scatterlist is done anyway for mapping purposes so I don't 
think it will affect the performance.
The cost of doubling the number of MRs is the what we need to pay to get 
optimal performance for contig and discontig IOs, I guess..

>> Actually, I think we should have the same logic in the NVMe PCI driver:
>> if the IOs can be delivered as PRPs then the driver will prepare SQE 
>> with PRP. Otherwise, driver will prepare SGL.
>> I think that doing the check in the driver for each IO is not so bad 
>> and devices will get benefit from it. Usually HW devices like to work 
>> with contiguous buffers. If the buffers can't be mapped with PRPs, 
>> then the HW will work a bit harder and use SGLs (it is better than 
>> doing a bounce buffer in the block layer).
>>
>> I actually did a POC internally for NVMe/RDMA and created sg_gaps 
>> ib_mr and mem_reg ib_mr and checked the buffers mapping for each IO 
>> and got a big benefit if the buffers were discontig (used the sg_gaps 
>> mr). Also the contig buffers performance didn't degraded because of 
>> the check of the buffers mapping.
>>
>> I created a fio flags that in purpose sends discontig IOs for my testing.
>>
>> WDYT ?
> 
> Sounds possible. However for rdma we probably want this transparent to
> the ulp such that all consumers can have this benefit. Also perhaps add
> this logic in the rdma core so other drivers can use it as well
> (although I don't know if any other rdma driver supports sg gaps
> anyways).
> 
> If this proves to be a good approach, pci can do something similar.

For RDMA, I plan to do it in the device driver (mlx5) layer and not the 
ib_core layer. It is unique to our implementation.

For the NVMe PCI case, I suggested doing it unrelated to the NVMe/RDMA 
solution. The NVMe/PCI is actually the device driver of the PCI device 
and the scanning of the scatterlist should happen in the device driver.
I suggest to try this solution since we always debating about thresholds 
and when to use SGLs.
Now that Christoph opens the gate for the driver to work with discontig 
IOs I believe that for *any* discontig IO we should use SGLs and for 
*any* contig IO we should use PRPs.

NVMe SSD vendors will be able to test this approach and report their 
numbers.

