Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31C6C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 10:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ELXj/03hIBPUbbrzoX6thbeIqf22ql2612ozTXEUfI=; b=0i+9r3ukX+vPcg91GqmHQCr4Nx
	dHBEKHbtCZ0EBoMQg1qE/wLJBxUePKxD3MYRt9l4HYAhvLapjMVJcj8Qem5cBJuBzYIdWWbiO6yZk
	cymDROQVVi4yYWnwXWWzuFxE6svrhT3vQ1fpCpq85+2ffVCUNH4xh4xostSar7FSumA9yuTST5xNh
	Ye6PWvzGSXpn9bss18GUSd5EzlqrCwhWwQimVfkYCqLK8V1fwRsjOUOYDdK5rWWD3xmQoCsAj9Qpo
	zrNkP0omRA5kfmq9LJ16N1gHy0D5HSMidF/tfow2AmUDVc2Kma1ezqcTu8XmnnU4wq2IMAucwoMrq
	UK9ArrWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFuBp-00Gzaw-0E;
	Wed, 20 Dec 2023 10:52:37 +0000
Received: from mail-bn8nam12on20611.outbound.protection.outlook.com ([2a01:111:f400:fe5b::611] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFuBl-00GzaZ-2q
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 10:52:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzSFIeD+8mxph7G2FwWU7h45v+X6lK7HjNTDrsLXHOvl1bXBj4iq0w8lektf5jOwW9LPLU48Xnp+29XLGGlwKO8GvlFMDyfoDo9KTIxyJooV+4Y6y2Mv5Nj3BHBTu30dT5ux8fogENN/0foHIJGoKuyboLw6hBePfSOgx4jo5ClfHlIIQypDKtAdiyW8hQDjq0Rik9UON+TaZICzmq9Gp7NdNHn9nX0+eWMv1s3GyueuKTeXhczjTt6tOJ6CxqqL2Lyx/CMpiH18nN0LeHKw3Pwks+I92Xjbx4q8M/art4GdNtRwCs5TESBj+oDz5ht2pDd5aCmuX2wa6pxWSbkVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ELXj/03hIBPUbbrzoX6thbeIqf22ql2612ozTXEUfI=;
 b=l1gPKHa38qfJwx446mlW4M7Zy+SyUwpApyhv8+wCjSHUzibqmgi1j8aEIibO8rHI1YuNxXbsh3DM4QnSxZ22h9VBM6cSU0oC9VfG29WyLLrbK4ysjeTXW3M96rDVW3UJjDTsMkHCY4uDHDTLPQUSoSxJAKpaId616VgsHGFOqntox6xlZ5QQltveP1ZO9zRcuPNOzmQ9I+cycrkUvjcnQmxfkqWR+/l9ZTFuUJs1Dq6YAH4qPC9gByyoayLywW3g2U66c7pM+JeFM4wacGptQtGDNqJ8CF8yoEF8/M+RDaCWSVOSZxhAFd2RPjRrQqceAPsoG/N3KJOT8x8/S90xYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ELXj/03hIBPUbbrzoX6thbeIqf22ql2612ozTXEUfI=;
 b=Scp+Bn9/xQit/u6OorRRRnDu4bysLlTUWlZjFqz7d1+i+I8IuVra+RaxTqmwCMiXGBLqq4tKDEpbu1bHqga506eiat3Qd6GpR6eb2Xhh9UK1nlxFJmEyr6WPaEohG5nBlkD4MkuISNFaTQFrNZdN93ldpZIImYE3pMf05LbjcZEmxOqRFkfnwd9/2qQZ01PPL0hATfsGHnRq1weNupfo8KSj9M+8OhxVzb/vEqFknIxSjbVe/RPGO+v/AQxEob0tk4YMblxvPLanqk5u/n59H+/nL7sRSSlcs1MEcN84WD+hS6r9njTf4Xruj2DY1r+UJDdFLfvcN6zi3E8YlZsjPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 10:52:24 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 10:52:24 +0000
Message-ID: <92b53d3b-8ee6-42b1-a078-9b51886c6003@nvidia.com>
Date: Wed, 20 Dec 2023 12:52:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V2 2/2] nvme: rdma: use ib_device's max_qp_wr to limit
 sqsize
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Guixin Liu <kanie@linux.alibaba.com>,
 hch@lst.de, kbusch@kernel.org, kch@nvidia.com, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
References: <1702971145-111009-1-git-send-email-kanie@linux.alibaba.com>
 <1702971145-111009-3-git-send-email-kanie@linux.alibaba.com>
 <82d16c8c-efef-41d2-b2ff-8ce8f5ac9b28@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <82d16c8c-efef-41d2-b2ff-8ce8f5ac9b28@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0419.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::10) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: 2072bc31-9c50-4d71-c9b2-08dc0149bf98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+0UglG/25O9dn3wjUGC2Aobbaj4Hz26tKYecQFcrxUpLRTxvbRoevzoOvdnng/iefouNddgApBh0oKpsYxmjuoKGGrPf3udRfzKSvBwsZ+RZDEX4PZOcCJo00IapAazwlJbhBWPo5qa9G1vCouPicPmFoVRvAm3sUOJGqRo0mpHmaMtMexneIn22rZIL0KW0AeGqZRhg053cTRa7VmI38JYujSGB5j/iXhRet6v+CW5AGApo7UnsUk/00y4lLrTfAbH57Jv3dxm/MGFUnxhpdvizcsABzTJBPUEaaejzUOKqJ/Gq73NUuHJKU/kqdG7PPLL04La/fsf3e6d/eaWUn+V2mocAHw+GEbYYBQv6YCvcUkymAuY1576HETbAPqULuLDzAHPzlajDHWbbOEfPxEvO86bN0PwdgPZ0uNp381lLs9HIQATSeeBWe7mrv6qNUl+c3lHvesiYndoFzBvcM5WSz1yzSPbKXAysxTFZ5FZxxyRTYj7TG/2Fm/D2vIeTlo4An0gAsg1Bph5W5+1QBOIoT8qAu0oWUwVFp8yYO0u57jZUnvjll47KW7TcsESCGl22sXGf7BOsqGBF2XEV7scsfJcizMgTZ75eldQAKKLrPmOoUSsaWqJWmkJ9fpswDuu1qVIcyGOsaCPh6m17Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66556008)(66946007)(2616005)(83380400001)(66476007)(110136005)(53546011)(38100700002)(478600001)(6486002)(26005)(8936002)(316002)(8676002)(4326008)(6506007)(31686004)(6512007)(6666004)(5660300002)(2906002)(86362001)(31696002)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDh4UVZwc25POE9XZ0JMamF1ZVpMcHJseDFkM1hhM0NiamNla1FaRkROamZI?=
 =?utf-8?B?aWxUOUdrSWorVmRFSVdBUzhhdjN0amFqQUJHLzhuQzYxT1J0Q29udS9tRFUz?=
 =?utf-8?B?dStWRGNpY21xcVZHOEhha0pXWUQyR0d6eENPZzFZOUJLVEJDWEhPNzVQWDR6?=
 =?utf-8?B?NCtBSENYL2FTQ01mdExGWEYvb3dRYlRyQ096aFRlcjg5YkpZZjJUWXNjSW9Y?=
 =?utf-8?B?dXFXamY3bytjbnFhL0NHU0hXUVpQaG44UUNSdjRveWJsY0xOTkJZbmhlc2g4?=
 =?utf-8?B?T2dLSFNKNzRocGpmWG9PNUlmQnJQT1k0UnM4aTQwZXgzZVlSVjR1d2Q3U1Ex?=
 =?utf-8?B?VjVHMXNWYzlQUXc3MEtzWHBRaytQdW9MZXM5NTVkNFBnakxyejJFRjcvMDQv?=
 =?utf-8?B?OFJXVXJSS1JSYW5ycHpCcThjR3hDSUFPVExxaU41ZllMY3hYam9VQWZhNzhU?=
 =?utf-8?B?UVhjRVN2RGNJUERIbVZKQVdYa3liSHI3eGRwL2JjLzdHN3ZncVdvYm5MZm5G?=
 =?utf-8?B?STQ0Qm1WaFIzTGIrbmZoVFFyUlNxdUZHZm1wdXpnTFlwNUlkSlFabGVmODFU?=
 =?utf-8?B?TXNSSE9sNnpXUnBMeE1PZUp5TElUckJ1bElIVEZTSFFpdUE1VHUrMXdMaDJO?=
 =?utf-8?B?ZzJJNmdJbWxNVko5Q2ZaUWlwRFM0elJEaUpZeUFWbXVaVkh2TmEvV1FkZDd6?=
 =?utf-8?B?TXFLeVlaUFJmWTFRNFg5Mm1nNDFldDMyUmN4Z1hyWnUzQnRKSFhmYm0zdWVl?=
 =?utf-8?B?ZTEvdElrNmlTV1BGVGpoQ3VVbVQ4QnRYWUhHQ3B0cHd4ZVZzV1pxbEZhTDVX?=
 =?utf-8?B?TjZYblozOWo0R3Ard0xOUDVXK0FqcStDeExkcmZmRmFJNGU4Q1B6bTUxRjgz?=
 =?utf-8?B?QmRKT0xXY21rQm9nWURnbHZwT3lxV0VuUzhXc1djRmdiVmltdXRqbnF6aXBO?=
 =?utf-8?B?a09ZR2I3M2FWSVVsSXdKNzNxZHZNelQvWnIyZjJJUWRtSU9iT3NOZUF2a1Fm?=
 =?utf-8?B?Y0ZySUE1K1I5UkpZclhGcWdOV2NrK0Y2VlN4RjJpK1kybEo5VWVJR1hFY2dN?=
 =?utf-8?B?TDByK1NySldEQkk2NU5kN0srNkw2dXBiM2UvdmErSVM2dW5VOHNFejNmcXZO?=
 =?utf-8?B?R2RydE5EZTlUWjZGK01yRWo3U1dmNjVYSVlyVk1zY3VUUFFvaDdiekFwVFF6?=
 =?utf-8?B?a2orS1p4MWFHdHA3T0NKY1BOYk1lV3VKYW5oajNodVk1a2JiVWNEM3VieUVO?=
 =?utf-8?B?VWZlSm1XQnEySkZBQTFvOFYwdE5rajFwb2NkbVY3NWwzaE84Nkl5TGpBdmd4?=
 =?utf-8?B?QXUvN2FPTXBQb3J5VkxRRGgrb0grenNqaHUzTldYdnI3NHZoZWdpUkpWcXpT?=
 =?utf-8?B?alhReWJqQm9QTjkzVFVPbE1xTFBQTXR1b0RPS3o2TnhkbVpVeVBhbDRyc29H?=
 =?utf-8?B?b3V0L0FPK09kSG0rQS9DZ3NrUXcyM1BoZTlWYXpJSk5wUHl3QlhoSXdvM1pM?=
 =?utf-8?B?bkNZY3JWWnZHd3R3OHc0WXg1WnhUbFc0S1crbldVWmxWWkU1QU9sQjZGSEZ0?=
 =?utf-8?B?UmRsS3BhT3dLNzBxRk9tSlZHcUNtbzJramZma1BtcFFWeXZWVE9QcmdkSldx?=
 =?utf-8?B?QkJYQ2UvQTdkRDBPeW5MRjA5OEVac0NHTjRWbFRLZXVjYVF1SmZiOUVXNU9V?=
 =?utf-8?B?dFREZ0xaMWxHUGpGazRGWlNDNldRUkE1MUR1N2pXMHljeDZQeTlNSldzQ1V4?=
 =?utf-8?B?RmxSU0s1TjJvWXVsblhOaGdObVJqN1BuTDR0Y0NxRVZJb0RVTFNOL0RiNkx0?=
 =?utf-8?B?eXcyOERrVzV6c1hpUFRIR3JJVDVMeitSUnlpdHd0bm1mSFEwQWhhaDFhWlVQ?=
 =?utf-8?B?NnFLZ0p3L1dMZHFRQ1BwQ0FKVnozOC9CZ2R0czJzQlRLdCtNT3huVzc3dklp?=
 =?utf-8?B?YnhMSnRJTTgyb25wUkFDaUVZazB6azYvRnVBL002Unk1WFJXUFY0U0xJT3cz?=
 =?utf-8?B?QmpqWmNjTGZOVFJUNUU0dFZTeW9IaFZTZ1piVWJ1aG9ldnN6MDZydjBMN0Ur?=
 =?utf-8?B?RXdDSkkxaWwxYTgxam1aUit6MWFCZWs3MTI0bVpzMURMNlcvN0tPazk1cnVV?=
 =?utf-8?Q?5gQmhDiP0GvmrdBtkx8wuws9K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2072bc31-9c50-4d71-c9b2-08dc0149bf98
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 10:52:24.0546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cw98KXUN8SOsLWIPM1GL0Y6fdgjiUcJZiPWxt/sujPThcMwghBNTyGI8Ma2zhQZXIvxmMXYq0OYK7uUOi80RRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231220_025234_055641_EEA39EE7 
X-CRM114-Status: GOOD (  17.93  )
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


Hi Guixin Liu,

On 20/12/2023 11:17, Sagi Grimberg wrote:
> 
> 
> On 12/19/23 09:32, Guixin Liu wrote:
>> Currently, the host is limited to creating queues with a depth of
>> 128. To enable larger queue sizes, constrain the sqsize based on
>> the ib_device's max_qp_wr capability.
>> In addition, the queue size is restricted between 16 and 1024 in
>> nvmf_parse_options(), so the final value of queue depth will not
>> biger than 1024.

can you please explain why this patch series is needed ?
what is the added value you see with it ?

>>
>> And also remove unused NVME_RDMA_MAX_QUEUE_SIZE macro.
>>
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>>   drivers/nvme/host/rdma.c  | 14 ++++++++------
>>   include/linux/nvme-rdma.h |  2 --
>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index 81e2621..982f3e4 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -489,8 +489,7 @@ static int nvme_rdma_create_cq(struct ib_device 
>> *ibdev,
>>   static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
>>   {
>>       struct ib_device *ibdev;
>> -    const int send_wr_factor = 3;            /* MR, SEND, INV */
>> -    const int cq_factor = send_wr_factor + 1;    /* + RECV */
>> +    const int cq_factor = NVME_RDMA_SEND_WR_FACTOR + 1;    /* + RECV */
>>       int ret, pages_per_mr;
>>       queue->device = nvme_rdma_find_get_device(queue->cm_id);
>> @@ -508,7 +507,7 @@ static int nvme_rdma_create_queue_ib(struct 
>> nvme_rdma_queue *queue)
>>       if (ret)
>>           goto out_put_dev;
>> -    ret = nvme_rdma_create_qp(queue, send_wr_factor);
>> +    ret = nvme_rdma_create_qp(queue, NVME_RDMA_SEND_WR_FACTOR);
>>       if (ret)
>>           goto out_destroy_ib_cq;
>> @@ -1006,6 +1005,7 @@ static int nvme_rdma_setup_ctrl(struct 
>> nvme_rdma_ctrl *ctrl, bool new)
>>   {
>>       int ret;
>>       bool changed;
>> +    int ib_max_qsize;
>>       ret = nvme_rdma_configure_admin_queue(ctrl, new);
>>       if (ret)
>> @@ -1030,11 +1030,13 @@ static int nvme_rdma_setup_ctrl(struct 
>> nvme_rdma_ctrl *ctrl, bool new)
>>               ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
>>       }
>> -    if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
>> +    ib_max_qsize = ctrl->device->dev->attrs.max_qp_wr /
>> +            (NVME_RDMA_SEND_WR_FACTOR + 1);
> 
> rdma_dev_max_qsize is a better name.
> 
> Also, you can drop the RFC for the next submission.
> 

Sagi,
I don't feel comfortable with these patches.
First I would like to understand the need for it.
Second, the QP WR can be constructed from one or more WQEs and the WQEs 
can be constructed from one or more WQEBBs. The max_qp_wr doesn't take 
it into account.

