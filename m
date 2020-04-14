Return-Path: <SRS0=WXQx=56=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81326C2BA19
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Apr 2020 12:59:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5145D20732
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Apr 2020 12:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PaPfSI3T";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="FeikMm0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5145D20732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=R2L9LgEsjfyW6QUmSmCXyj7C3EgH47un+y1WH7dGNkU=; b=PaPfSI3TTpLDzuAGkjReO+lno
	88567Uq6U6YcQx8/Of1t073lfq3O/ia9PG+DamEe959sPyPehRGZTdc9Wc6A+q1JOY38GldMqjceP
	iKBBmm1jzTcUEUl6uRj26t4WKPMyL2q8zclleKTgAxZmP7oueliJ7Qaqscv+tV8YPggThyhFQodZ8
	Yz5hD0tUsHac58Iq6g0s0tRRIg/g8xxv80g/Ebb775qdt1/5GmjQnJALDnrsdy+8KON1NQK6vszGu
	I0qfTRwyLA5Ghhd/b5pJvjU6EA6YW2ztJkqQV6QmidSk6EWu/h4YqseFpQM7jRzuKwmYj9uJD7lhN
	UgREDpxLA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jOL9x-0002TG-6j; Tue, 14 Apr 2020 12:59:25 +0000
Received: from mail-he1eur04on060f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::60f]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jOL9u-0002Hm-OC
 for linux-nvme@lists.infradead.org; Tue, 14 Apr 2020 12:59:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKi1sIpaiUZHs5QeY4jWmi6Wp3UAz1hOih3TqnD7GvuoocLHwi9v9TlT/3zmd33+rMwdfMZhD1p5ypwdgUDHlqQU2zbQxUw+Io7R87hCl4ZZHVApVagadyJ0NMHc+sJ1o5zOwz7wioq3uFQvpf2BcZ4ccgEQt1gsIoDrGc32EL4HND4fh2AJvNfikK0ucM+K2NY52gwt/nBjo7ws4YpprThO0SOs86+Vi6lxIM4MHUSEI5RCLVAaopTe5BdZrW7gmbVDZ4ezcYvAs+c0Gcyet9uAa/Zzdm+k32zBBQKKUKsMdvhEoigTk4HWHfyKlwvGtTzOGYZ4HKS/bUkZPMFcNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5W/vRxtszcM0sfYBLm+j13rgoNHcMtV+h9QtytNB1k=;
 b=kXYOiCUPOiwLy8UX1xuYmdDzhotIGMFhnff/ff74SalSS+QUT7uBlGgxBlVQXmArMBb701LDkZVC/3FqJV3GwVl9g9lCvLDpEzjZJKDXSi3lvAQNy1PXhmKmX8PLW6bBNipXu/s8Yjz+4Jf9iwhiYHUFsFCqgf7Yb4LBiO2tg2brWFM7PbYf1c3VoFTTqf+uEZFIkYur1F321owycVyiZMwLgqoyavSEfEvJqjDt2ADHuMw9to6VR3OQ6njDtHHMIDk0oPDFCeBgh7+I7BpUVqaGNEnFcQ9+1qDnJwyJlM+ZS6T9PJ3VgB/7j2mBX1m5/rr/ohsmtpRA46p7Do8Sng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5W/vRxtszcM0sfYBLm+j13rgoNHcMtV+h9QtytNB1k=;
 b=FeikMm0+lz+eFBuNVT8SNuDyV3m2ygB9E9qx1fwdSk02EfiecRqMaiCYEFdIfJFvl+7PWlrPwmM5TYaGiozFgJbKIzTAUAIhDwH2q/i8AlkCBuW7t7Vu21/NyYLfJs80riXiIKD5JhEC+eYb2XHitSuaCA1U96XlUvA1jrzINYM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=maxg@mellanox.com; 
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com (2603:10a6:208:11f::18)
 by AM0PR05MB6018.eurprd05.prod.outlook.com (2603:10a6:208:12b::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17; Tue, 14 Apr
 2020 12:59:15 +0000
Received: from AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4]) by AM0PR05MB5810.eurprd05.prod.outlook.com
 ([fe80::408a:27c1:55f8:eed4%5]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 12:59:15 +0000
Subject: Re: [PATCH] nvme: align io queue count with allocted nvme_queue in
 nvme_probe
To: Weiping Zhang <zwp10758@gmail.com>
References: <20200410095719.GA4393@192.168.3.9>
 <188ad279-9211-9dca-3e6c-b5718ae6fc80@mellanox.com>
 <CAA70yB63bHGcFOzKPrLz+-bjHoEMQWiZEpFyoZ72rzDy9ZaO3Q@mail.gmail.com>
 <66add5c2-62b9-5c2d-977b-0499834b2b7a@mellanox.com>
 <CAA70yB7bkeSwQVjJ5rjGS3HxZtkraUY1FX9ZMHXH8FO6a-8omw@mail.gmail.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <df0fa3a0-7764-bc1f-711d-d264fc4f444f@mellanox.com>
Date: Tue, 14 Apr 2020 15:59:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <CAA70yB7bkeSwQVjJ5rjGS3HxZtkraUY1FX9ZMHXH8FO6a-8omw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM6P193CA0086.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:88::27) To AM0PR05MB5810.eurprd05.prod.outlook.com
 (2603:10a6:208:11f::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.3] (217.132.177.164) by
 AM6P193CA0086.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.17 via Frontend Transport; Tue, 14 Apr 2020 12:59:14 +0000
X-Originating-IP: [217.132.177.164]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc8b587b-11cc-4b39-6ce3-08d7e073a2f8
X-MS-TrafficTypeDiagnostic: AM0PR05MB6018:
X-Microsoft-Antispam-PRVS: <AM0PR05MB601837ECB4F204EFFFEB6869B6DA0@AM0PR05MB6018.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR05MB5810.eurprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(5660300002)(6486002)(81156014)(31686004)(8676002)(66476007)(2906002)(6916009)(498600001)(66556008)(66946007)(2616005)(52116002)(31696002)(8936002)(4326008)(86362001)(186003)(36756003)(16576012)(16526019)(956004)(26005)(54906003)(53546011);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSDVhwX2PEd3A2LGxp0tsVm72d3dRScIvuKdSlFOkwaU6Za6GNy2wf1KAl1YrWxWgfxom6BJpN8IOVaTiwBTN0CtOAZaksjbvFutizywsnLeF8lasmXmiaeBKk8a7l/CaOglYXwqgZl/1lMAD1ZKeWOiF6Dcwfq3OYBg5z7i/5g/xu47Va3Otyp2szKFo69iOBSyI6LM+hkO8xBfUc8FGUs0JRA1J9g7+iSADWrAIJ86ZPxI0SGVt5QWCOqKdh4Of7G1jnNWx/8jr9nz1HlDD4ybt1lQPLh7xdvBKv5nGc9Kmu7yjPDdTCUPpIzQ8KI728a/KOb60B5/qELeMv7tEs+TbYz0k5L3kMQrYAnzblzv/qX09AXIXd09eVTPWRCShbXFOmh96EaZt16VOCHCxsuR1fIUDWdPHDfFoBxsAva7UzOUnUevh71/wNCR3aXI
X-MS-Exchange-AntiSpam-MessageData: 3O0IHWjo8jukHOwmOKPQUK4Hg4hveLpIyPUFBRstLMNcqynFkd6mN3HQsrhk8HLHueiaJczUe74xwqcpTtmOddsJ0gziaILgcKTvwvytnBeu8EaCCqT4puD4ixbz/5WqSaMxceYDNxoiafNjiQoZ3w==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8b587b-11cc-4b39-6ce3-08d7e073a2f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 12:59:15.7834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDhG50hGdT+6CY+oLP31Z/N9ssmaEmRbG5gR6VaXFfopoBurLaeUie14I31hfmWSRt3g/SZt0gYD1wmgaJJF6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6018
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200414_055922_792448_AD236CDA 
X-CRM114-Status: GOOD (  22.15  )
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


On 4/13/2020 3:00 PM, Weiping Zhang wrote:
> On Mon, Apr 13, 2020 at 5:37 PM Max Gurtovoy <maxg@mellanox.com> wrote:
>>
>> On 4/13/2020 4:01 AM, Weiping Zhang wrote:
>>> On Sun, Apr 12, 2020 at 8:38 PM Max Gurtovoy <maxg@mellanox.com> wrote:
>>> Hi Max,
>>>
>>>> hi,
>>>>
>>>> how about the following minor update:
>>>>
>>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>>> index 4e79e41..46ab28b 100644
>>>> --- a/drivers/nvme/host/pci.c
>>>> +++ b/drivers/nvme/host/pci.c
>>>> @@ -89,6 +89,7 @@
>>>>      */
>>>>     struct nvme_dev {
>>>>            struct nvme_queue *queues;
>>>> +       int nr_allocated_queue;
>>>>            struct blk_mq_tag_set tagset;
>>>>            struct blk_mq_tag_set admin_tagset;
>>>>            u32 __iomem *dbs;
>>>> @@ -209,15 +210,15 @@ struct nvme_iod {
>>>>            struct scatterlist *sg;
>>>>     };
>>>>
>>>> -static unsigned int max_io_queues(void)
>>>> +static unsigned int nr_dev_io_queues(struct nvme_dev *dev)
>>>>     {
>>>> -       return num_possible_cpus() + write_queues + poll_queues;
>>>> +       return dev->nr_allocated_queue - 1;
>>>>     }
>>>>
>>>>     static unsigned int max_queue_count(void)
>>>>     {
>>>>            /* IO queues + admin queue */
>>>> -       return 1 + max_io_queues();
>>>> +       return 1 + num_possible_cpus() + write_queues + poll_queues;
>>>>     }
>>>>
>>>>     static inline unsigned int nvme_dbbuf_size(u32 stride)
>>>> @@ -2073,7 +2074,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>>>>            int result, nr_io_queues;
>>>>            unsigned long size;
>>>>
>>>> -       nr_io_queues = max_io_queues();
>>>> +       nr_io_queues = nr_dev_io_queues(dev);
>>>>
>>> It may have some problem when user decrease queue count for multiple tagset map.
>>> For example, there are total 128 IO and 96 cpus(system),
>>> insmod nvme write_queues=32
>>> nvme_probe will allocate 129(128io + 1 admin), nr_allocated_queue=129;
>>> and then user decrease queue count
>>> echo 2 > /sys/module/nvme/parameters/write_queues
>>> echo 1 > /sys/block/nvme0n1/device/reset_controller.
>>> nvme_setup_io_queues should use
>>> 96(num_possible_cpus) + 2(write_queues) instead of 129(nr_allocated_queue).
>> Any change that you will try to do (increase/decrease) will not effect.
>>
>> If you want it to effect, you need to make nvme_probe to run.
>>
>> I don't see a value only for making the code not to crash but not really
>> effect the queue count.
>>
>> write_queues and poll queues shouldn't be writable IMO.
>>
> I think we can keep it writeable, the user case is that setup as many io
> queues as possible when load nvme module, then change queue count
> for each tag set map dynamically.

We can keep it writable but I prefer not change the controller initial 
queue count after reset controller operation.

So we can keep dev->write_queues and dev->poll_queues count for that.

You can use the writable param in case you aim to hotplug a new device 
and you want it to probe with less/more queues.

IMO this feature should've somehow configured using nvme-cli as we do 
with fabrics controllers that we never change this values after initial 
connection.

Keith/Christoph,

what is the right approach in your opinion ?


>
>> Since nvme_dbbuf_dma_alloc/nvme_dbbuf_dma_free also call
>> max_queue_count() that uses writable module params.
>>
>> we can save this values locally or make it read-only param.
> It's not safe to use max_queue_count() for these two function,
> and there is also a problem in nvme_dbbuf_dma_alloc,
> static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
> {
>          unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
>
>          if (dev->dbbuf_dbs)
>                  return 0;
> it does not aware queue count was changed or not.
>
> But it can be fixed by
> unsigned int mem_size = nvme_dev->nr_allocated_queue * 8 * dev->db_stride;
>
> Thanks

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
