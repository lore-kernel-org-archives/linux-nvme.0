Return-Path: <SRS0=eVk/=55=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01492C2BA19
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2020 09:37:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC62020692
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2020 09:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qXUo8F07";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="YnHTF1is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC62020692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FyWtb5W+7kFgzBub3PytJl+LbcDNBBzcpYSGScpQFlU=; b=qXUo8F071EXnLXRLFJkejzPfB
	0QcqbztYl+3uSJTO06n0jDvJio1g/5rVwgkkZ8Wx1mGXN/LPB+4VPDC43YqiRmGQ/paMVWaYnsQ5C
	Dwt1P1yKgxIB5y/RDv1Q/RwdS2H0ROhZRyE65v9YMMx5Ucw1XmTXzz7udDP4rogyF3D7ZvMjNOWZq
	igp79uDMMiHOYfU3dVhD8t0dh1iqwLslfYsDAwpksGVN7tp7oLZkBIb453vwJIo3mjbQIGg3Z6lkU
	HquxkExvV/ArfZZY7ZyEx4pByVyzJ9lHuPoKYHilwEhS/yLThgS3SEaLNYTAeiXpg38iy4Dp0IErM
	ZcULMqLig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jNvWf-0002QV-VV; Mon, 13 Apr 2020 09:37:09 +0000
Received: from mail-am6eur05on2052.outbound.protection.outlook.com
 ([40.107.22.52] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jNvWd-0002Q9-7U
 for linux-nvme@lists.infradead.org; Mon, 13 Apr 2020 09:37:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWB02jcr7d6FN4SZoXLL6hVX6Bgmwh1txh5KuJ2rZ5SXmN7sQxXQgNDcYR7hHZKoBhj6gBm+Pvqoj93anjnKzf50+H5oaE+pT3kt+eYrnJKmmohaMNbeRcZDo1ntjFuSNmgrejItzUsv/tGUW5MUjgE38k7lGhN5rlnRuJq3UFSm/OQFlIa+LjkyeQ5BrgriaTfBLOIhnM9aI6mdHu5AaKLbqgEpYzRuhJ+CmZs1hzCPAFjkZMdzKmC6pGrHGYYkko4IZV+ToUMMElz7qHImfGl63WtJC09H74Y/8xL6v1ci0i51yprarZK0I/gBorlkZMjBVmDKBThfeQzo7BzOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Izctv1eW6bGRTawDUBS6A77w47FXvIN0Wmy9q58mCmk=;
 b=btbDEAc6yfabgeOETvHT4A2bg9Nb1Qm+yTO7ctqQzAGhaXGuYqBQBYud6zw55Sbi8oC1sVzv2SAeiNw+gaECPkhi0gSK30BjdbzPz9PxhEJI6B8gJp8ArFcj6AiJQ4c1Jzrg1ZEhqVMx1F+gtdR4eafRxexp5x2XLn4WhAIipFPoyBTq/wmoCmUXR2bLf14YJI125vWgCkERgNyNYd6afKW5v8Y2AzlfzaBJ5c61OcY+iSSPncCn3bPnQxoYchasgnXzODHkOrwxyOjSKkVy7MAJOZoSSpiscnpP9Jc/IFgQwuuk6aBFMRQt8ZoOiZ3AmZlbA8P4aR+aziWp5Uta8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Izctv1eW6bGRTawDUBS6A77w47FXvIN0Wmy9q58mCmk=;
 b=YnHTF1isFQxCe/Wy8TcHyYh7DyfDho51dafsvhYt894qeDndEptzlXk48Qrc/3HCpf3AofB9OEvwiM3jEHOnQKGceun5H37dHCClylLVR0gHlAmJ03KgUm7/icaEZrTRjN/8eK6NcCiWDfJQylG8E+tKGhzqcuZza0vdDvCQRfs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6243.eurprd05.prod.outlook.com (2603:10a6:208:12f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Mon, 13 Apr
 2020 09:37:04 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 09:37:04 +0000
Subject: Re: [PATCH] nvme: align io queue count with allocted nvme_queue in
 nvme_probe
To: Weiping Zhang <zwp10758@gmail.com>
References: <20200410095719.GA4393@192.168.3.9>
 <188ad279-9211-9dca-3e6c-b5718ae6fc80@mellanox.com>
 <CAA70yB63bHGcFOzKPrLz+-bjHoEMQWiZEpFyoZ72rzDy9ZaO3Q@mail.gmail.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <66add5c2-62b9-5c2d-977b-0499834b2b7a@mellanox.com>
Date: Mon, 13 Apr 2020 12:37:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <CAA70yB63bHGcFOzKPrLz+-bjHoEMQWiZEpFyoZ72rzDy9ZaO3Q@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::6) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.177.164) by
 FR2P281CA0019.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.16 via Frontend Transport; Mon, 13 Apr 2020 09:37:03 +0000
X-Originating-IP: [217.132.177.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3034b5b-36eb-4244-3762-08d7df8e3985
X-MS-TrafficTypeDiagnostic: AM0PR05MB6243:
X-Microsoft-Antispam-PRVS: <AM0PR05MB6243AEDEB598BCA42FA9B1EDB6DD0@AM0PR05MB6243.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(6916009)(4326008)(6486002)(186003)(2616005)(45080400002)(53546011)(8936002)(956004)(54906003)(16576012)(5660300002)(16526019)(26005)(31686004)(2906002)(478600001)(52116002)(316002)(966005)(81156014)(66946007)(66476007)(31696002)(66556008)(86362001)(36756003)(8676002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3AGpCwM04L21VMuy2yYtKPMBVMnm4oJk2A/epQnu/Fo7qJ68Hp/VSYvHytclvtnyJYQwXeFwob+Eb2ivagGz3wBm7HRs71z5ID2OD+fVqcL8jGenPGwiBXM9+bczGe7xM2BALvaIuOhDZl/zxch+pqwAoF/AuRpEPzBmAj0aAPZ1RDlBFzRNkAvUUzgpZj8EmTFO9a0iNHo4IvvkELKAvQAJqUEJUqAq3ozxFQkN30SKgVGszb49ElXwBZY+Vsw8KdrylZI/Q1VoFtF2KhLC27jFj9bDPPAdpAeidij/+wjXTffaasTHkYLyHpn8dl3ZAeHIEiXTfp/9Z+71cwcIKNj0fL6IOq7jPcHv9uwwQrWGG3Stf5yKHIALnkWWpK4TWQULxil2AmxOQlCyeZ+FIqYNhxUjPLr+PWFQQb06y4g8RbrhhARXcErxN6wYyRAXdWf/EHPjyrPXU6WkV1mKgQEUXu418h9isSMEdKLxyor8PJA4alH5cA8nQUpOLxXcumNumzJjjthoHtP1uh417Q==
X-MS-Exchange-AntiSpam-MessageData: K69pratVxGD91cDsUeusX9OKIFPb76/DMhifMDmaQydbSRa+0gAUFBkmNmeFzkihlMOeBcdCtmpR6+bPJmp2ApOCGKtboKflAZsolmpnBz9plrY3ZEV3HqNwxlch4GZGLzfE60S+azQQy9KPvbprTA==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3034b5b-36eb-4244-3762-08d7df8e3985
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 09:37:04.1525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A7Hk3tKnkgam1rZrKyimb6kytOSzPiuw1+zA8icFGRYIHcO8AINp8HekLU3X+4uFbjtuTfSWo0FrhGs3Jk6pMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6243
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200413_023707_347029_B7551400 
X-CRM114-Status: GOOD (  20.26  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, sagi@grimberg.me,
 Weiping Zhang <zhangweiping@didiglobal.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 4/13/2020 4:01 AM, Weiping Zhang wrote:
> On Sun, Apr 12, 2020 at 8:38 PM Max Gurtovoy <maxg@mellanox.com> wrote:
> Hi Max,
>
>> hi,
>>
>> how about the following minor update:
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 4e79e41..46ab28b 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -89,6 +89,7 @@
>>     */
>>    struct nvme_dev {
>>           struct nvme_queue *queues;
>> +       int nr_allocated_queue;
>>           struct blk_mq_tag_set tagset;
>>           struct blk_mq_tag_set admin_tagset;
>>           u32 __iomem *dbs;
>> @@ -209,15 +210,15 @@ struct nvme_iod {
>>           struct scatterlist *sg;
>>    };
>>
>> -static unsigned int max_io_queues(void)
>> +static unsigned int nr_dev_io_queues(struct nvme_dev *dev)
>>    {
>> -       return num_possible_cpus() + write_queues + poll_queues;
>> +       return dev->nr_allocated_queue - 1;
>>    }
>>
>>    static unsigned int max_queue_count(void)
>>    {
>>           /* IO queues + admin queue */
>> -       return 1 + max_io_queues();
>> +       return 1 + num_possible_cpus() + write_queues + poll_queues;
>>    }
>>
>>    static inline unsigned int nvme_dbbuf_size(u32 stride)
>> @@ -2073,7 +2074,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>>           int result, nr_io_queues;
>>           unsigned long size;
>>
>> -       nr_io_queues = max_io_queues();
>> +       nr_io_queues = nr_dev_io_queues(dev);
>>
> It may have some problem when user decrease queue count for multiple tagset map.
> For example, there are total 128 IO and 96 cpus(system),
> insmod nvme write_queues=32
> nvme_probe will allocate 129(128io + 1 admin), nr_allocated_queue=129;
> and then user decrease queue count
> echo 2 > /sys/module/nvme/parameters/write_queues
> echo 1 > /sys/block/nvme0n1/device/reset_controller.
> nvme_setup_io_queues should use
> 96(num_possible_cpus) + 2(write_queues) instead of 129(nr_allocated_queue).

Any change that you will try to do (increase/decrease) will not effect.

If you want it to effect, you need to make nvme_probe to run.

I don't see a value only for making the code not to crash but not really 
effect the queue count.

write_queues and poll queues shouldn't be writable IMO.

Since nvme_dbbuf_dma_alloc/nvme_dbbuf_dma_free also call 
max_queue_count() that uses writable module params.

we can save this values locally or make it read-only param.


>>           /*
>>            * If tags are shared with admin queue (Apple bug), then
>> @@ -2742,7 +2743,7 @@ static void nvme_async_probe(void *data,
>> async_cookie_t cookie)
>>
>>    static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id
>> *id)
>>    {
>> -       int node, result = -ENOMEM;
>> +       int node, nr_queues, result = -ENOMEM;
>>           struct nvme_dev *dev;
>>           unsigned long quirks = id->driver_data;
>>           size_t alloc_size;
>> @@ -2755,11 +2756,14 @@ static int nvme_probe(struct pci_dev *pdev,
>> const struct pci_device_id *id)
>>           if (!dev)
>>                   return -ENOMEM;
>>
>> -       dev->queues = kcalloc_node(max_queue_count(), sizeof(struct
>> nvme_queue),
>> -                                       GFP_KERNEL, node);
>> +       nr_queues =  max_queue_count();
>> +       dev->queues = kcalloc_node(nr_queues, sizeof(struct nvme_queue),
>> +                                  GFP_KERNEL, node);
>>           if (!dev->queues)
>>                   goto free;
>>
>> +       dev->nr_allocated_queue = nr_queues;
>> +
>>           dev->dev = get_device(&pdev->dev);
>>           pci_set_drvdata(pdev, dev);
>>
>>
>> -Max
>>
>> On 4/10/2020 12:57 PM, Weiping Zhang wrote:
>>> Since the commit 147b27e4bd0 "nvme-pci: allocate device queues storage space at probe"
>>> nvme_alloc_queue will not alloc struct nvme_queue any more.
>>> If user change write/poll_queues to larger than the number of
>>> allocated queue in nvme_probe, nvme_alloc_queue will touch
>>> the memory out of boundary.
>>>
>>> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
>>> ---
>>>    drivers/nvme/host/pci.c | 10 ++++++++--
>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>> index 4e79e412b276..cc10258e578e 100644
>>> --- a/drivers/nvme/host/pci.c
>>> +++ b/drivers/nvme/host/pci.c
>>> @@ -89,6 +89,7 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
>>>     */
>>>    struct nvme_dev {
>>>        struct nvme_queue *queues;
>>> +     int nr_allocated_queue;
>>>        struct blk_mq_tag_set tagset;
>>>        struct blk_mq_tag_set admin_tagset;
>>>        u32 __iomem *dbs;
>>> @@ -2074,6 +2075,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>>>        unsigned long size;
>>>
>>>        nr_io_queues = max_io_queues();
>>> +     if (nr_io_queues > dev->nr_allocated_queue - 1)
>>> +             nr_io_queues = dev->nr_allocated_queue - 1;
>>>
>>>        /*
>>>         * If tags are shared with admin queue (Apple bug), then
>>> @@ -2742,7 +2745,7 @@ static void nvme_async_probe(void *data, async_cookie_t cookie)
>>>
>>>    static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>    {
>>> -     int node, result = -ENOMEM;
>>> +     int node, nr_queue, result = -ENOMEM;
>>>        struct nvme_dev *dev;
>>>        unsigned long quirks = id->driver_data;
>>>        size_t alloc_size;
>>> @@ -2755,11 +2758,14 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>        if (!dev)
>>>                return -ENOMEM;
>>>
>>> -     dev->queues = kcalloc_node(max_queue_count(), sizeof(struct nvme_queue),
>>> +     nr_queue = max_queue_count();
>>> +     dev->queues = kcalloc_node(nr_queue, sizeof(struct nvme_queue),
>>>                                        GFP_KERNEL, node);
>>>        if (!dev->queues)
>>>                goto free;
>>>
>>> +     dev->nr_allocated_queue = nr_queue;
>>> +
>>>        dev->dev = get_device(&pdev->dev);
>>>        pci_set_drvdata(pdev, dev);
>>>
>> _______________________________________________
>> linux-nvme mailing list
>> linux-nvme@lists.infradead.org
>> https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&amp;data=02%7C01%7Cmaxg%40mellanox.com%7Ceaf57db9f05f425f94eb08d7df4643de%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C0%7C637223365187382864&amp;sdata=NdQYX2fHf8vr8nOlXGhT%2Fr4jHV64ubuBER%2FEPDl3Z%2FU%3D&amp;reserved=0
> Thanks

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
