Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0921C001B0
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Aug 2023 12:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B7Lqy097R8OY6bViOb7g/Tma9/HIVAyqy/XJ0/8qcqM=; b=cxqT2yhSpQ+8+FFjd2IzFoORSw
	qRQD2/+tHANOfnTQJ28prcUSEqyaQHxJkK95MkWAF1VwPCLAHz6Y4rsf2hJYXNwLTkx7mG96X6FT+
	be/ceoABYoNTvIr6tFqPQo1CqJz2UHkESaWyvnvhUESwyYFgRMgarLzJ/eLFSDYY/VCB36bwuGKlD
	2HTwyq1YNumsBYSo1qz9vj7XBUX7xm0qaO/UjhHwvZZVapyf7rA8cLpC3MW9D01M8trZ81vuDPhOt
	2kYPMd3aFz4BYgvIWZIffR1KI07W0GO/8GM1numMX77sNo4xk2l7eolswQ05+/nCaET1v2qRbFhlX
	+KC0AITg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWFfv-0049Ee-35;
	Wed, 16 Aug 2023 12:30:59 +0000
Received: from mail-dm6nam10on2061c.outbound.protection.outlook.com ([2a01:111:f400:7e88::61c] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWFfs-0049E2-2J
	for linux-nvme@lists.infradead.org;
	Wed, 16 Aug 2023 12:30:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUfTljYza9dz9xpFHKIuDfT/RFjnB1rX/ED2IMNaDhRAtmPczrOPTTac8ul1vWmNDLztCNRHFM5cbD60GuDG16rPGRqh1CyxwcG7tM2IkLtFNA+A2AwoB0IK6LY0uvnx1/7f6ZNlW6zJpIe2AtpPJWUET9tY3p2/rIkK/taVBaPA6wzmOVOB9V9N9dlS0HY9heWirN1Qzi5hmjjAn/m3iF2v06DW9/ho2TzpG9qLYBOziYlEqT6I4UnPyeTBHjeJ7viAQDDbObdhlmQM8txICzuncPZ4WucZMtQ6D+bJ9n+pIEmjZ728dD3RCbquJOFvkzqi5f4wOdJFd96h7CUb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7Lqy097R8OY6bViOb7g/Tma9/HIVAyqy/XJ0/8qcqM=;
 b=DPGYeWg0HklRrEngAcWcxIunLVfJK9Oea7h+gPmu8a1PZ1oiatb14bJKqhcKgeMPnheU/chGIsOxLjAzp+Iks2Rq6oGTIrwiNyGzmMiT5JQUpN9EqpytlIEZLayDyOB7XNs3K74uO74YjL9Ia2ZxwFoZlCDAyYm/3HvCZL1pAo1YDeD7hoWgwU8V1AsIQk/K1zsjjOaciCXURn9gEp64LvJuw3mcatT72gXbwW0hAfejJ4eVTrLjzFYhqatNuk5rCcvkoOJwZuc2tnuRI6Rbg/fRAKANm8VlEMsmrdsD4sDzgPZE9cCZT1g2zuFx2Q54+WkpagBvQ8kunQoY24G14w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7Lqy097R8OY6bViOb7g/Tma9/HIVAyqy/XJ0/8qcqM=;
 b=oXqw1emSrWYSV1+a372jTur3Fh87dSwMvS5cv7RGEoMmhS0i97Ac18kBaDt0HhAO7u8GQZ4WaDehQFtuma0spL1VOtMu35jRSQJYYHd38fMtGNFZi/jG8LEMMQSL5j1pw5QZbGRDSQji4VpnrAbhLKCCAg2NjGLGJlNqxKkdGD0Jjiv0iMNv5vgcIlbmeSm7cbR0r/zEO8nNDrtl9C5oj60O3FXh6FL3xra930B/O6D5w4iZK3ABA792USCCsBB6Sx34q9WNApJK3b9sCcQuHozmk1gBu3hOq1twMOkveIt2Ku+Pw5qHQj3CKfQgCAysr70TI82NXvd61g8Uwl/Gfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Wed, 16 Aug 2023 12:30:51 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::968e:999a:9134:766b%7]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 12:30:51 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v12 07/26] nvme-tcp: Add DDP offload control path
In-Reply-To: <bc5cd2a7-efc4-e4df-cae5-5c527dd704a6@grimberg.me>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-8-aaptel@nvidia.com>
 <fa07042c-3d13-78cd-3bec-b1e743dc347d@grimberg.me>
 <2538radwqm3.fsf@nvidia.com>
 <bc5cd2a7-efc4-e4df-cae5-5c527dd704a6@grimberg.me>
Date: Wed, 16 Aug 2023 15:30:44 +0300
Message-ID: <253wmxvuq2z.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR02CA0070.eurprd02.prod.outlook.com
 (2603:10a6:802:14::41) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fc2255-00af-4539-facf-08db9e54a058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /XY2mbU9ccinFJvObbk9+9ZKislOhjklalafW3OHFHLj8Sr9vw4wycpvd2K/c04tHPZiLITsqJP9xkLLTHQk2og7DloyhKotOqlNavRGNb7VUq0YqI5jPKcd7WgdOzubHQEbmjjwbKahP/1sj1GjbHCkWtvo1AsjUUYKfIWA6TJp0u4i7MelBkb8IBgNNIhOn+fNpdAWSNCR3thqnlmJQ4mp7Kmmr2BQedL0zTAUhv7cxkyZwPGa6umH6G8+tjMDw/GMrSLvQqk4NiziIM2oes6OyGLXgw3vJqwSnbtAVCyJatTZnDRm91hCM+FHb0t0fB1KV/d/M3qaq/GD4WClHipyOpkvU8JO315aEArBRTG9avEFqsNakIFPGjz1ErZ4+Wpt4CZKeaXvS7OMVLl4DePTE141aQxcqAKvbAm+ppRwAz+HN9c8eHRGSavLu9lRpMonZTzyDvNYO7XL8jctaFgUeDYJwIhpy8RO5NSxpnce5hw/NB9lQ7ztoqfMMlTZjc+EOVOhYcD6Q+Kcbu1bNBjX+bADH+MWTceVSRV94VM3Ss6rV6yigevsmmo1aqW1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199024)(1800799009)(186009)(2906002)(83380400001)(7416002)(86362001)(478600001)(6506007)(107886003)(36756003)(6486002)(2616005)(6666004)(6512007)(26005)(5660300002)(41300700001)(316002)(66946007)(66556008)(66476007)(8676002)(8936002)(4326008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ce9mSvo882Wru/Ue5BjBOZDB7skHX1iF3HSi0X1JyonlXvyD5dAHT+Ah+3n8?=
 =?us-ascii?Q?Izw4Njvl0frUKinX5sgD3NDh2L5Bwg/jEbNCLS2q/ZbgcAYLmxHu8AFqeBGO?=
 =?us-ascii?Q?57zpS7BjwCuh0zYKIKOK0ryIbfSgEKXpkQNAUdjTuKUzCYFEKtwNhqoiEYTa?=
 =?us-ascii?Q?PKTVzy5Z5Se/s7gE6xkzRhYZ2iWhaEk4Es62uogNyYwU+frbBN4UanaqRJDN?=
 =?us-ascii?Q?1jU9gYBni2eekWwDBDJtYLdHjRvTXW3ANHwoqTP50JNPHTX6SVkIOGAnuoWh?=
 =?us-ascii?Q?EaRISQSp8Ij+bOd3eUqFr2Uati5WecXNiT1YPB8RK7sDhw7qA11aAU1IPp7Q?=
 =?us-ascii?Q?49H6fLSfdQEfAeDoZuTrJUH6QquOCKJEisdHNeJvWx+4J21kBGK9o85Wk1Yd?=
 =?us-ascii?Q?ji80DE+ohxcNgc0uOx7jFSN6xDd4Y+7N7PK6IZhFPEhNmbcHRxPyfVddLzK5?=
 =?us-ascii?Q?hgCFtBwkupZYBKgvExP+zd+tSSshiMg4xQ9kczxP+ssFNp7ru1xm50rxEpX5?=
 =?us-ascii?Q?EnDG/aadOk7ARmZQQ5YbdAyD1S9TLfhde9XAFaaIEUewFqLxwaTgoZPcda6O?=
 =?us-ascii?Q?SErFruNYkgPwxOJ6PfQ1UFvsWU1BXNjKcih+br8rVJ1co/kXIXq8fkksPO9t?=
 =?us-ascii?Q?NoB+hIbHlnsiLNLQD5f0FTbnNvPk4VWfwP7d7FE3Zd76dpWzEPeHMxlkad7k?=
 =?us-ascii?Q?o8wwBZcsoeMYeK61FGO9jDMFeBrx3q5RgzYVZ7S3dqlAzpZUuvx+1icziYkZ?=
 =?us-ascii?Q?FEziz1ULbB1OKBL0JE+ui58vobTr1xnknTia4SUz4iSWMFvBLh7TmfiZdUMG?=
 =?us-ascii?Q?PuZ96JbDwQMXNJCviCReHKYNgdrWXAnbuM8LbIvwomQqLwKDl+pKdrFkQj3j?=
 =?us-ascii?Q?0xb+ezNsaWIgAyIQchV51S8wBNE4Prd6M7R8EpGajvZDqhVDXR9JCnfXBUHn?=
 =?us-ascii?Q?U0eKTNaECYMiSb6rS/NRn1iwTv1VXpUZ+AAjNmyk4U0DzjoQgoXB9gLVTv1q?=
 =?us-ascii?Q?5K93OEaxcGUmV2vPufVmQWDWG2ZsdMWaJoqu3ET83WslplXCJ34q2WjDa/Mt?=
 =?us-ascii?Q?Ri4KIcfCiRzRg9SVJBBtrC4x4Mw5shhDY0/kKG5Me71OU3TJwCLy93XPzrEs?=
 =?us-ascii?Q?GuIC9PU4eHiY1hgUZiEFJq/8hVt2dGhvNn5CS6hlkOOTsLmBDmfTZkxbuxB6?=
 =?us-ascii?Q?wzDqvBWZZj+fS+h//IITIrcEjl/4Oe3enPtDfXIPEf6B53ZJZM6YIJc+LMvi?=
 =?us-ascii?Q?1LSx0DlxNX133hdXEsVF86sOD6ps8fSW21KIhwJeS9Ar3sbT7svudFqOPwVo?=
 =?us-ascii?Q?ZhImGhgqaN+YdKHJcntXWD8bpgrjQfARMZbTSGTDoKbLlp5XfobvrvFfgxSv?=
 =?us-ascii?Q?HudNsL5P3jeLzo26SaNSSHTdyDUwiIlLbbjmxIYHoX9xWrbiZ5E77KO+sZ4y?=
 =?us-ascii?Q?avDivDHj7bzsIkhpTQptoHDQSUCHievLgkyriPMcGbJ0V8b1NuGc7jfvBLJm?=
 =?us-ascii?Q?eH6eg0dVhiRtzAMKgHMUrM/SHbvJbjs9l8uJm/ra1f7ZkojggmASxQ+7XEy9?=
 =?us-ascii?Q?UEALBx3VV21dIR2g5kldIS5hE22Y487uxvQo06S6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fc2255-00af-4539-facf-08db9e54a058
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 12:30:50.9211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQclayznYOMjLT14gk1Dx9WOp1P2w0M0+9bBQem1jSNZN2anvsMJ0aoBzzVtkrXdPjNoCOtEAq2umSkkBO+Pbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230816_053056_782910_D5C45C93 
X-CRM114-Status: GOOD (  36.00  )
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

Sagi Grimberg <sagi@grimberg.me> writes:
>>>> +     if (!netdev || !queue)
>>>> +             return false;
>>>
>>> Is it reasonable to be called here with !netdev or !queue ?
>>
>> The check is needed only for the IO queue case but we can move it
>> earlier in nvme_tcp_start_queue().
>
> I still don't understand even on io queues how this can happen.

In case where the netdev does not support DDP, when the admin queue is
started, netdev->offloading_netdev will not be set and therefore will be
NULL.

Later, when the IO queue is started:

    netdev = queue->ctrl->offloading_netdev; <== NULL
    if (is_netdev_ulp_offload_active(netdev, queue)) { <== we pass NULL

We can move the NULL check higher-up if you prefer, like so:

    if (queue->ctrl->offloading_netdev &&
        is_netdev_ulp_offload_active(queue->ctrl->offloading_netdev, queue)) {

>>>> +
>>>> +     /* If we cannot query the netdev limitations, do not offload */
>>>> +     if (!nvme_tcp_ddp_query_limits(netdev, queue))
>>>> +             return false;
>>>> +
>>>> +     /* If netdev supports nvme-tcp ddp offload, we can offload */
>>>> +     if (test_bit(ULP_DDP_C_NVME_TCP_BIT, netdev->ulp_ddp_caps.active))
>>>> +             return true;
>>>
>>> This should be coming from the API itself, have the limits query
>>> api fail if this is off.
>>
>> We can move the function to the ULP DDP layer.
>>
>>> btw, what is the active thing? is this driven from ethtool enable?
>>> what happens if the user disables it while there is a ulp using it?
>>
>> The active bits are indeed driven by ethtool according to the design
>> Jakub suggested.
>> The nvme-tcp connection will have to be reconnected to see the effect of
>> changing the bit.
>
> It should move inside the api as well. Don't want to care about it in
> nvme.

Ok, we will move it there.

>>>> +
>>>> +     return false;
>>>
>>> This can be folded to the above function.
>>
>> We won't be able to check for TLS in a common wrapper. We think this
>> should be kept.
>
> Why? any tcp ddp need to be able to support tls. Nothing specific to
> nvme here.

True, we will move it to the ULP wrapper.

>>>> +     /*
>>>> +      * The atomic operation guarantees that we don't miss any NIC driver
>>>> +      * resync requests submitted after the above checks.
>>>> +      */
>>>> +     if (atomic64_cmpxchg(&queue->resync_req, pdu_val,
>>>> +                          pdu_val & ~ULP_DDP_RESYNC_PENDING) !=
>>>> +                          atomic64_read(&queue->resync_req))
>>>> +             netdev->netdev_ops->ulp_ddp_ops->resync(netdev,
>>>> +                                                     queue->sock->sk,
>>>> +                                                     pdu_seq);
>>>
>>> Who else is doing an atomic on this value? and what happens
>>> if the cmpxchg fails?
>>
>> The driver thread can set queue->resync_req concurrently in patch
>> "net/mlx5e: NVMEoTCP, data-path for DDP+DDGST offload" in function
>> nvmeotcp_update_resync().
>>
>> If the cmpxchg fails it means a new resync request was triggered by the
>> HW, the old request will be dropped and the new one will be processed by
>> a later PDU.
>
> So resync_req is actually the current tcp sequence number or something?
> The name resync_req is very confusing.

queue->resync_req is the TCP sequence for which the HW requested a
resync operation. We can rename it with queue->resync_tcp_seq.

>>>> +                     ret = nvme_tcp_offload_socket(queue);
>>>> +                     if (ret) {
>>>> +                             dev_info(nctrl->device,
>>>> +                                      "failed to setup offload on queue %d ret=%d\n",
>>>> +                                      idx, ret);
>>>> +                     }
>>>> +             }
>>>> +     } else {
>>>>                ret = nvmf_connect_admin_queue(nctrl);
>>>> +             if (ret)
>>>> +                     goto err;
>>>>
>>>> -     if (!ret) {
>>>> -             set_bit(NVME_TCP_Q_LIVE, &queue->flags);
>>>> -     } else {
>>>> -             if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
>>>> -                     __nvme_tcp_stop_queue(queue);
>>>> -             dev_err(nctrl->device,
>>>> -                     "failed to connect queue: %d ret=%d\n", idx, ret);
>>>> +             netdev = get_netdev_for_sock(queue->sock->sk);
>>>
>>> Is there any chance that this is a different netdev than what is
>>> already recorded? doesn't make sense to me.
>>
>> The idea is that we are first starting the admin queue, which looks up
>> the netdev associated with the socket and stored in the queue. Later,
>> when the IO queues are started, we use the recorded netdev.
>>
>> In cases of bonding or vlan, a netdev can have lower device links, which
>> get_netdev_for_sock() will look up.
>
> I think the code should in high level do:
>         if (idx) {
>                 ret = nvmf_connect_io_queue(nctrl, idx);
>                 if (ret)
>                         goto err;
>                 if (nvme_tcp_ddp_query_limits(queue))
>                         nvme_tcp_offload_socket(queue);
>
>         } else {
>                 ret = nvmf_connect_admin_queue(nctrl);
>                 if (ret)
>                         goto err;
>                 ctrl->ddp_netdev = get_netdev_for_sock(queue->sock->sk);
>                 if (nvme_tcp_ddp_query_limits(queue))
>                         nvme_tcp_offload_apply_limits(queue);
>         }

Ok, we will follow this design.

> ctrl->ddp_netdev should be cleared and put when the admin queue
> is stopped/freed, similar to how async_req is handled.

Thanks, we will clear ddp_netdev on queue stop/free.
This will also prevent reusing a potentially wrong netdev after a reconnection.

>>>> +             /*
>>>> +              * release the device as no offload context is
>>>> +              * established yet.
>>>> +              */
>>>> +             dev_put(netdev);
>>>
>>> the put is unclear, what does it pair with? the get_netdev_for_sock?
>>
>> Yes, get_netdev_for_sock() takes a reference, which we don't need at
>> that point so we put it.
>
> Well, you store a pointer to it, what happens if it goes away while
> the controller is being set up?

It's a problem. We will remove the dev_put() to keep the first
reference, and only release it when it is cleared from the admin queue.


