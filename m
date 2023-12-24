Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F50C3DA6E
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Dec 2023 01:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+nwBB9RW804lLujE7UQIzgeGYEG2iBhqPC87wX5aorA=; b=vLpohdHbHyA32lheQbxyecMZss
	sxoYryrhSsa4lFWAiO0WfXECuZEUky0MiexkO+FLYofgVNQaEJEwv9W7z4opwYuZLXLw4INcMsTSl
	ARdbrSFlkCwGkJo0S014ruPpace99r6JLvu84hL+DDPm391eQFsPfv7N+03fdlH3Vp/J5blZ6jjq2
	T0alFTiCsInVJMdBYgZPDRCLNCDbIQ//4nhTYMnLlBVWgW3ZCQb7P8sLsUyONDy7pQgCUMaN+bO6a
	Po/VwdfzDVeax8VU1GGfXO1010+RP2u5tjHbeaNZKxEC5Fg0G8i0Q3AkArjJWieFt1u0m1R7ev7XL
	HRy8X+VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHDQm-008ioF-2c;
	Sun, 24 Dec 2023 01:37:28 +0000
Received: from mail-dm6nam11on20626.outbound.protection.outlook.com ([2a01:111:f400:7eaa::626] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHDQj-008inL-1q
	for linux-nvme@lists.infradead.org;
	Sun, 24 Dec 2023 01:37:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JN0js+4tmno2iRoWkBiKEOtzH/E/JrQY7O1wREWkmHxSoOzNOtpenXqdQbCd/KTVve7Bw3gGEHT5FLZTA0UBJs6m3w6vTjrmcuPOmO7XbwFxrCL8TVU9mGyO+CjXk65B1E0zV9jq5EVf1Va074KFzk415+hHsjc1PedQBMktxN3A5YzrQbdRWPzRvMXsF9wldTJqgc5l6KaVjPgIQGnbSuWwg40YKjymy1t8IFXi7KWMSyFUx9ynz4BUo93/ZryPX0Ys2zXvcJKiBiCzL8Y98FsH9ub4YmB1MoRB1uRhW0oVFJuWyzrlrxR8RKG+UoyF37xtuHl/vxg9xcN4wVE0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nwBB9RW804lLujE7UQIzgeGYEG2iBhqPC87wX5aorA=;
 b=UiUpMvRI3I1MTr6FVgFIr/gxjcVLdPi/pzeI1i7MBY+Uzc1kIymgnqdTZcUR4qHM6vUy6quVkWpauxm9Zy2oCe+CpCn3zJqOETHtS3/szncY7HevnplmW/Z+OuTga7xYqwVyFL+Dfv9XdzIqUFJXkz64XwJuJIk0nm2eZF7WLyaN7Js7APXJZzEGS0ARMtRbCqZ8Q3vP7STLu0ToXJ8YynIlMlpOpivd6szq9tzs4p5Wtz+5UmAAelJ5wINc69OeKbiMWJKZ2bI7c/FnI1w16N+w+d7pJ+pCVxcfaPBxp8oFutrl5f9XG3yvgdNsL6wPCPaCPp2okhAQIeBRVm0+RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nwBB9RW804lLujE7UQIzgeGYEG2iBhqPC87wX5aorA=;
 b=pOMMBtmNEYUXZpR50Gllna4WfjDljbcKB21zYUVd7HF+gF44Q4KzjYUI3toEo12AamcuZoaARbTK8F48n9c8Y91VC3KmKG6X1fQLLIdizVWbZ7n+vE8cbGPjnS+RIa6jqWwqIJ6IlVeHlYNHyV3RoI5tba0JF+9slAJsV4099t2z2jlzA/pqPVs62byNIm9RhrlGrTQ+TL54xLsHVaajKJPzku6r+BqpZuD4xehBxoe/eEaB60IOQrek44/tWYbVTFUEVr3ASN6vP0t1h5QPFAPmKJwEyL0ae/eYEqABgvHvxSU0r0IzznUyJiUNYRSQ0kI4w4dN/MXmVhbiaJQpWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.24; Sun, 24 Dec
 2023 01:37:09 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7113.023; Sun, 24 Dec 2023
 01:37:09 +0000
Message-ID: <d5c0a0d8-f67b-49de-bb25-a64c53be5345@nvidia.com>
Date: Sun, 24 Dec 2023 03:37:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 2/2] nvme: rdma: use ib_device's max_qp_wr to limit
 sqsize
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, Sagi Grimberg <sagi@grimberg.me>,
 hch@lst.de, kbusch@kernel.org, kch@nvidia.com, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
References: <1702971145-111009-1-git-send-email-kanie@linux.alibaba.com>
 <1702971145-111009-3-git-send-email-kanie@linux.alibaba.com>
 <82d16c8c-efef-41d2-b2ff-8ce8f5ac9b28@grimberg.me>
 <92b53d3b-8ee6-42b1-a078-9b51886c6003@nvidia.com>
 <77df6829-3a14-49a1-82e5-f3389ba47d86@grimberg.me>
 <436efebd-ab7e-4b23-9be0-a316884552ca@linux.alibaba.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <436efebd-ab7e-4b23-9be0-a316884552ca@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS7PR12MB6214:EE_
X-MS-Office365-Filtering-Correlation-Id: def8322a-d122-4ec3-0377-08dc0420d810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fpYwvpzd2ej6w/4XtpDV95Thz6+ZWv/Rcl1HcWfEEkhAUjVW0AtU2k5owbLVE1qJG9z9UkaNujb03iG2F73wljsNBXmVfvPJjEkRQz9N7f4Thc6PvJHA2uMPAMR9JsvNDS8D+ixflbC19eaREOolME3I7N8nQxWHiMW09MLa6PbYaqWXYB6TSTvXnvrPQq1+fcacMcL5mgXw7owOkQGi3/B6wsM/GTHb9bXM658m6KU7+cupG3vLO0NXk/G5af/a2CA6eZMFVQ197/+a8UXmSchYAR5c9E3Bg3kMk/9/shk52dZN+9RwZ/+aOpfYMmW0BNoj41Z44hxr8E778cMKlK7RwzZ4iVPrpKAhXpHF7XV1OcxYx5GXeLrqRPxOCTnyXI7MG0duvz4QixPVXvRHXApT8sZf15Rau3i5X872bSIePacsuF4UJ/nyqTjDinloWgqcUmCgFMUpbUdJWjFHcQ/H6EIoZW+KrnWw/FRN1AFMKCh7/9teW5Q6RqJeWlNpCyOA9liKoR996QMS76m2a8lDQJfnw2kY+68X8eb391x8MLWC/ZJQTzIiWTY8xxf11ZCXcEaNXTv5YqmFQ1l26KtvQoSoiBQsxsb8nwfKwDgnbQ2q3Pkhfwwv/rZs/v1aB2Y5suA6aPO1NrLqbeSD2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2906002)(478600001)(8936002)(6486002)(5660300002)(36756003)(6506007)(6512007)(6666004)(53546011)(66476007)(66556008)(66946007)(8676002)(316002)(110136005)(4326008)(31686004)(2616005)(83380400001)(26005)(86362001)(41300700001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UElaSE1jbHQ0djFwbTUvMk9IWGcrQjhQUUQ3YTh1VnhoZjhqRG5zZGpQUXZJ?=
 =?utf-8?B?aGNrSFhxZ3dxSDM1ZGlXRUJPNkhOd0NZeVVPODlEUlVhd1F6RG5JMC9QTGhT?=
 =?utf-8?B?dG1tOVRDNUM0OEltZGhvNFdFeDI2ZmMyK2lid25JM2czY0ZUYnZtUURCUVE3?=
 =?utf-8?B?N3ZJUXo3ZmhuZDZHQXFsOThpektBL09ad0FySTVuL2g5Q0VVbUNtYzdveDhI?=
 =?utf-8?B?emhTVWsyNHFBVFd3Y2YwSG1CbHNtV0VCK2U0bm9OT2tXNE5ka0RGR1pxNHUr?=
 =?utf-8?B?OTdrOE5WOWkzT0JEallTcysreTQ2eVcyWEpDWDNxR3JPZWhGa2VJR3VEVzA0?=
 =?utf-8?B?TVl3RkpNTlY0VVFUbmdEeWVVY3BkMFJDMi9TeXZEODB0STEyZWZVOTAzNDYz?=
 =?utf-8?B?NCtoQUlsY2diWHhndHRab1RWNmFCdWE2Z1Nra3ZpQkJIUjFlNkVRNmRKNU1t?=
 =?utf-8?B?QXZNVUorNDNJOVh0WDBxUU9jNXFCSVNZZzVFejhZb1NlS1Qvd2ViWEltanN3?=
 =?utf-8?B?MnZVSlZGRllHNVpuU2trclB3SEFCM25qcER2RmZCbmlkbGErRW5BNmV0Qmg1?=
 =?utf-8?B?cHhBajhzWXNWdlN5Wi84RmxoOUc3YURxeTZ3YlExYUlodUhJNSt5Tm5xdWdZ?=
 =?utf-8?B?MENYOC9IN3FJaFprVEFJR2t6dWZ4QUlRM1ZsZmJnRDN1bnZ4dWh0b055WDUr?=
 =?utf-8?B?di9ldG81U3ZlMytCVkx5TlB6YXR2OGtxNzdNTVh5RG5QQXJQTzAwNXUzamNZ?=
 =?utf-8?B?bHNkczBZTFI5Z2grVDd2clorSkhwTnBTZHVoRS9JdVNBM1dUckQ4R1VleHFj?=
 =?utf-8?B?eEV0NzVIUllFdnIyVW5MU2xrZzA2aFpIMTZBVHpGOVdjS0RuTjRkOGFUeURx?=
 =?utf-8?B?aTIyYURxY3psVi9zem0wdS9TaGQyRy9waXE1SWo4Q0Z0QmYyTVhuaDZGc2pG?=
 =?utf-8?B?dmNDUEZzcE1GTThRbXpVTWgwTTJaQ1lWWXlESVVPRUJNQmp5cmN1SkJRVWxS?=
 =?utf-8?B?SHQ4OUIxdHBnUWZjcklJOGtYdFgzS0txazJUWHNaZUxCMDV2aW5jdW9xc1Zy?=
 =?utf-8?B?cERDVVZUUGVyYWFXcCtQT3l5T29wdFYvWFZSWUMxRDZVYnFXbFV0RFM1dzBx?=
 =?utf-8?B?TG1uUTlVYU5wZFhTYmd5NmlqU3BJM2NxLzNIeU5DdU53aGxac204L1JWRUxU?=
 =?utf-8?B?RitmZi9lZmgyaitTNEZ4OG5GYVdvbXdZNHA3aFArc015VWdWcFpGZ29LdkVo?=
 =?utf-8?B?ZkZCcEdHeGlyckx0cnQ4SkgvV1pocHdCTkc0KzcrN01ySklZNEUzU3ZEWkd4?=
 =?utf-8?B?TFkyUTlYV1EzRlVEMkNnRmFjSXl0RElHNDVKTzNuamxXQ3kyVmo2NXV5Z1Fp?=
 =?utf-8?B?bzBFUC9mTXoxdG9OSzUxUzhTK3Q4OVUyUVFOc1B2Mk92SUVQK1JqaFhXOGRq?=
 =?utf-8?B?VkN4NCtEVkVrSm9LbHRLTVpEOVFvSXc0Q3NBUDZjK0oxQk53alJ4T3BFWTEv?=
 =?utf-8?B?WkVsVEdzZDBGeUJUaVdBQTY0QU5ON3c3Um85ZjhCckdaYzhhNFoyclNUVXJv?=
 =?utf-8?B?bnJueEpLSTZtQi8rWU9PZ1pVY2I4WTFzckhraU5zMWdoWXhXOHNya2VlR2xn?=
 =?utf-8?B?bVNCK0x5ZStZdTNCWmFpSldTUnFIemlxcXJwNWJHY1RibE94Zzl4Nk5ob0V3?=
 =?utf-8?B?dVBaZFl4MTdMa0lDdzdKWUI3eHd2QVY1TEx2Tmt0aHRYemt1RVRsQ2RMa2Ja?=
 =?utf-8?B?NDQ3V0lxbU5HcFNUbm4xcS9zVXdGSHg0d3loRjFTVTlhMnI1SUR0aGpicWg0?=
 =?utf-8?B?RDBKOHlKcmpzTkhiclErMHZKWVEvN2VFclJQWTFZdGZVMHhIR0tHN0NQek1J?=
 =?utf-8?B?K0hJaUhFOXZRMGI5dTdBNjgzMmJoeXZSbnJydGd6SXUzRDdXQkJuNFBUb2pS?=
 =?utf-8?B?MStpRjZBTWs1VzBqMjNNd3ZjT3VzMHF4ZExiQTMreWFqdDJneTR3Y1A4dW56?=
 =?utf-8?B?SVNsNjBsWVdaNHFiZU9sTUFHS0Y3UkNpdGQwOGV6Vnd4SFpCbXRYWFlIWjRv?=
 =?utf-8?B?VUdvemRrMlFqQVZoemp1S3VGOXFWdTk3eXkyWFRJY25pclc4QW5Jci9KUUdV?=
 =?utf-8?Q?9WlEojjoHJDa8MLYebkDQkdYP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def8322a-d122-4ec3-0377-08dc0420d810
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 01:37:09.2598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOWRKg3EDJ9aXqv/BJ48Q2GWUu0BNDO9r1qdX5bXSrajMDKwQ4/S+uBrJ20MISqb8PclJ8TJzClB8j03L7lyLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231223_173725_673643_BA7DE8BF 
X-CRM114-Status: GOOD (  19.00  )
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



On 22/12/2023 8:58, Guixin Liu wrote:
> 
> 在 2023/12/21 03:27, Sagi Grimberg 写道:
>>
>>>>> @@ -1030,11 +1030,13 @@ static int nvme_rdma_setup_ctrl(struct 
>>>>> nvme_rdma_ctrl *ctrl, bool new)
>>>>>               ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
>>>>>       }
>>>>> -    if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
>>>>> +    ib_max_qsize = ctrl->device->dev->attrs.max_qp_wr /
>>>>> +            (NVME_RDMA_SEND_WR_FACTOR + 1);
>>>>
>>>> rdma_dev_max_qsize is a better name.
>>>>
>>>> Also, you can drop the RFC for the next submission.
>>>>
>>>
>>> Sagi,
>>> I don't feel comfortable with these patches.
>>
>> Well, good that you're speaking up then ;)
>>
>>> First I would like to understand the need for it.
>>
>> I assumed that he stumbled on a device that did not support the
>> existing max of 128 nvme commands (which is 384 rdma wrs for the qp).
>>
> The situation is that I need a queue depth greater than 128.
>>> Second, the QP WR can be constructed from one or more WQEs and the 
>>> WQEs can be constructed from one or more WQEBBs. The max_qp_wr 
>>> doesn't take it into account.
>>
>> Well, it is not taken into account now either with the existing magic
>> limit in nvmet. The rdma limits reporting mechanism was and still is
>> unusable.
>>
>> I would expect a device that has different size for different work
>> items to report max_qp_wr accounting for the largest work element that
>> the device supports, so it is universally correct.
>>
>> The fact that max_qp_wr means the maximum number of slots is a qp and
>> at the same time different work requests can arbitrarily use any number
>> of slots without anyone ever knowing, makes it pretty much impossible to
>> use reliably.
>>
>> Maybe rdma device attributes need a new attribute called
>> universal_max_qp_wr that is going to actually be reliable and not
>> guess-work?
> 
> I see, the max_qp_wr is not as reliable as I imagined. Is there any 
> another way to get a queue depth grater than 128
> 
> instead of changing NVME_RDMA_MAX_QUEUE_SIZE?
> 

When I added this limit to RDMA transports it was to avoid a situation 
that a QP will fail to be created if one will ask a large queue.

I choose 128 since it was supported for all the RDMA adapters I've 
tested in my lab (mostly Mellanox adapters).
For this queue depth we found that the performance is good enough and it 
will not be improved if we will increase the depth.

Are you saying that you have a device that can provide better 
performance with qdepth > 128 ?
What is the tested qdepth and what are the numbers you see with this 
qdepth ?

