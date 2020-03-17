Return-Path: <SRS0=JSXe=5C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11123C1975A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 20:00:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D981520738
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2020 20:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lMAiUzUQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Ay1zeYcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D981520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sV/GCgu/bTRGaJwwPl6R6u+lzGDCaRlD+jJIXJARsdo=; b=lMAiUzUQA6BBMv3CsuwfrkbJQ
	oWtOV4zRWiyZ9R9PirjgIlLqmbwV/kLy9ohJoswYQYmF0EiT8afE/NOeDG1HRJFvfTRTOsQLSSGvE
	1KjUkeEna2PgyKSS4LGw4sOojEPqC8H8wBnNz/ebA4mvIvOA5tTul7eIG1O+xzSEUo7l/w0QhqKdq
	CP1is9OMKuP0oOwZep0wYxx3ELIUCjglogzdpbi1c6QUD14FhrZC5zdl4OaAxMHQY8pba0fNtri9I
	4/+deykG7q4GaEkzpJ0j5ykPEb0przioHP7Q4Iu6GqWvO4ObpP8xj1yMLU3pzyoS/66UpJtRvGHnc
	TUVcdjClQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jEINZ-00063k-NM; Tue, 17 Mar 2020 19:59:57 +0000
Received: from mail-eopbgr10045.outbound.protection.outlook.com ([40.107.1.45]
 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jEIND-0005fR-Os
 for linux-nvme@lists.infradead.org; Tue, 17 Mar 2020 19:59:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlfkjbMwZCpZKvU7tO8l1SUmNUA0IsfZ8NgRyonoDWLpKwYNXhI2KmIiGv8+a0rAY2oNzL18VhFrrgH271JV9zEVArcoCKIa8mkNrsTzPbtjne9h3n1ZcbkArHbkYJcgJFKbPay5FtKda4BGxcJCUup/kCsJ8usyfTIjCoAkr/woRP8k64yy4+L8SsnzvRKPGNj0jzGd9pvy+mtn9Hf4ec6PezvvjGXHG7n01Ga0VhzFa9Me3+ZFTT8p/DaQkJJ9GI9R92AW6ktvViOxn5Wf/p6Zk5VOGqPSfncfCepxXKrftv0IHxV0cDhc1VmxPr9bDnwFPmldmNxpGUXDgzhoJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en2IT065kz052PYnTIft97VJA5+kFePoRzBHMXwp8ZM=;
 b=HwfCRyAV7upNVOVAqURwadDxzhyzQwbDda4nBjEySynASMH5Q0VHobkuK/JfetpSKhHBcuJp5cL/PaUxpKEpTLbHV0yvPFRJfcDHmQwoImCQMoHY1JmfQpFcpBqbZ9iGdU/kZx2K3u9ktwYzBbHr3ogt+QukDY/f5+ZRx4tlsyo8ArZCRuPhCGbvlKdSw2Qzf1yaVF1cB1Znv2nymCp+zHX9RdE6dczz89R/JzhEy2gr3SJGDFS+lWYrXXo1Ruwls4P5kA0pb1JD6cjT21dXDg2n/Mqzx+COMTTeFzzEqWPJ77nZP84a7JtwiymiN47JShfc8KkmQj4UfJPlMpJonA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=redhat.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en2IT065kz052PYnTIft97VJA5+kFePoRzBHMXwp8ZM=;
 b=Ay1zeYcD2Rgiv5CJqHhBOhcy4gZt+i7jyh+IUvr1BeAV5fn4alh/CodRdLzYcuUKyaJNM/KqyPtQ/Qv/5WMXrLALSlBWRO81mUXzVlmMOMZaqhGFIi8mjiToaWI8+q48jePKCEKCYrqU7jOzQlOnII8tip3NYsHtTtfZ4wccYyg=
Received: from DB6PR0202CA0015.eurprd02.prod.outlook.com (2603:10a6:4:29::25)
 by HE1PR0502MB3914.eurprd05.prod.outlook.com (2603:10a6:7:87::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Tue, 17 Mar
 2020 19:59:26 +0000
Received: from DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:29:cafe::54) by DB6PR0202CA0015.outlook.office365.com
 (2603:10a6:4:29::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend
 Transport; Tue, 17 Mar 2020 19:59:26 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT010.mail.protection.outlook.com (10.152.20.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2814.13 via Frontend Transport; Tue, 17 Mar 2020 19:59:25 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Tue, 17 Mar 2020 18:47:53
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Tue,
 17 Mar 2020 18:47:53 +0200
Received: from [172.27.14.181] (172.27.14.181) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0;
 Tue, 17 Mar 2020 18:43:40 +0200
Subject: Re: [PATCH 5/5] RDMA/srpt: use SRQ per completion vector
To: Leon Romanovsky <leonro@mellanox.com>
References: <20200317134030.152833-1-maxg@mellanox.com>
 <20200317134030.152833-6-maxg@mellanox.com> <20200317135812.GH3351@unreal>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <ece3acbf-316e-cbb5-fd98-9bf8813ee682@mellanox.com>
Date: Tue, 17 Mar 2020 18:43:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317135812.GH3351@unreal>
Content-Language: en-US
X-Originating-IP: [172.27.14.181]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251; IPV:; CTRY:IL; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(199004)(46966005)(81166006)(8676002)(6636002)(81156014)(47076004)(36756003)(356004)(8936002)(70206006)(70586007)(478600001)(16576012)(54906003)(31686004)(2906002)(37006003)(316002)(16526019)(6862004)(2616005)(86362001)(53546011)(31696002)(186003)(26005)(107886003)(4326008)(336012)(5660300002)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR0502MB3914; H:mtlcas13.mtl.com; FPR:;
 SPF:Pass; LANG:en; PTR:InfoDomainNonexistent; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f088fdf3-58fc-44a6-135c-08d7caadb1fa
X-MS-TrafficTypeDiagnostic: HE1PR0502MB3914:
X-Microsoft-Antispam-PRVS: <HE1PR0502MB391448E7FA730CEFB8967E81B6F60@HE1PR0502MB3914.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0345CFD558
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lhv94tkbqS3/PzTnV4TNb92tH4MDP6uWkwm651g4mw+kqKkmvM1BTJTPJniZqc3wC1zsgjxnU8DayrlQxZ6WcjrN/3bvTbPnMEY2wIg8gzPLf4z/Hy7rP4fl1sQ831rZxyvU7ClMmHbzxcsfTUjsa0KUXTWoSD06vCbz2zGhsr5GaJx4uBDhdMJPzCNvE8dLCVOMGcapA6/l8KSsYnQ43zYfHpVQN3wm2aCAdUV2EnChyNWHeUygiGChKxEMliHza2J0ZEnPvzFsSAESK59RNfGGFJBGD+YEuXEXQiOlmpFUddZrJ10cu9cIuAUj4dgU/DuAlWi3Js3cnF8fM5jitxJSMySo334jTU1vDcN6wGcsqxAzctKrHsXVOIpzUiRnTqoQK/qHP6ZCg4FJHXJJ72fkbzJ1U0g8FeqVkUaLSpZekmswl0Jwqd0vW79nkthU/JZuQPziN/vKjASQ8kI50CsiPdmhT+oTeDJyUaadMzZcCzMRDP68Snu9s/rWUdwaYJTzzIf0lMc1et3+LQiqatO9/bKS0z4gaf3h2Ab580M=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 19:59:25.8492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f088fdf3-58fc-44a6-135c-08d7caadb1fa
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b; Ip=[193.47.165.251];
 Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB3914
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200317_125935_807759_68E00C92 
X-CRM114-Status: GOOD (  15.24  )
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
Cc: loberman@redhat.com, bvanassche@acm.org, vladimirk@mellanox.com,
 shlomin@mellanox.com, linux-rdma@vger.kernel.org,
 linux-nvme@lists.infradead.org, idanb@mellanox.com, dledford@redhat.com,
 jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 3/17/2020 3:58 PM, Leon Romanovsky wrote:
> On Tue, Mar 17, 2020 at 03:40:30PM +0200, Max Gurtovoy wrote:
>> In order to save resource allocation and utilize the completion
>> locality in a better way (compared to SRQ per device that exist
>> today), allocate Shared Receive Queues (SRQs) per completion vector.
>> Associate each created channel with an appropriate SRQ according to the
>> completion vector index. This association will reduce the lock
>> contention in the fast path (compared to SRQ per device solution) and
>> increase the locality in memory buffers.
>>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
>> ---
>>   drivers/infiniband/ulp/srpt/ib_srpt.c | 169 +++++++++++++++++++++++++---------
>>   drivers/infiniband/ulp/srpt/ib_srpt.h |  26 +++++-
>>   2 files changed, 148 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> index 9855274..34869b7 100644
>> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>> @@ -811,6 +811,31 @@ static bool srpt_test_and_set_cmd_state(struct srpt_send_ioctx *ioctx,
>>   }
>>
>>   /**
>> + * srpt_srq_post_recv - post an initial IB receive request for SRQ
>> + * @srq: SRPT SRQ context.
>> + * @ioctx: Receive I/O context pointer.
>> + */
>> +static int srpt_srq_post_recv(struct srpt_srq *srq, struct srpt_recv_ioctx *ioctx)
>> +{
>> +	struct srpt_device *sdev = srq->sdev;
>> +	struct ib_sge list;
>> +	struct ib_recv_wr wr;
>> +
>> +	BUG_ON(!srq);
>> +	list.addr = ioctx->ioctx.dma + ioctx->ioctx.offset;
>> +	list.length = srp_max_req_size;
>> +	list.lkey = sdev->lkey;
>> +
>> +	ioctx->ioctx.cqe.done = srpt_recv_done;
>> +	wr.wr_cqe = &ioctx->ioctx.cqe;
>> +	wr.next = NULL;
>> +	wr.sg_list = &list;
>> +	wr.num_sge = 1;
>> +
>> +	return ib_post_srq_recv(srq->ibsrq, &wr, NULL);
>> +}
>> +
>> +/**
>>    * srpt_post_recv - post an IB receive request
>>    * @sdev: SRPT HCA pointer.
>>    * @ch: SRPT RDMA channel.
>> @@ -823,6 +848,7 @@ static int srpt_post_recv(struct srpt_device *sdev, struct srpt_rdma_ch *ch,
>>   	struct ib_recv_wr wr;
>>
>>   	BUG_ON(!sdev);
>> +	BUG_ON(!ch);
>>   	list.addr = ioctx->ioctx.dma + ioctx->ioctx.offset;
>>   	list.length = srp_max_req_size;
>>   	list.lkey = sdev->lkey;
>> @@ -834,7 +860,7 @@ static int srpt_post_recv(struct srpt_device *sdev, struct srpt_rdma_ch *ch,
>>   	wr.num_sge = 1;
>>
>>   	if (sdev->use_srq)
>> -		return ib_post_srq_recv(sdev->srq, &wr, NULL);
>> +		return ib_post_srq_recv(ch->srq->ibsrq, &wr, NULL);
>>   	else
>>   		return ib_post_recv(ch->qp, &wr, NULL);
>>   }
>> @@ -1820,7 +1846,8 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
>>   					SRPT_MAX_SG_PER_WQE);
>>   	qp_init->port_num = ch->sport->port;
>>   	if (sdev->use_srq) {
>> -		qp_init->srq = sdev->srq;
>> +		ch->srq = sdev->srqs[ch->cq->comp_vector % sdev->srq_count];
>> +		qp_init->srq = ch->srq->ibsrq;
>>   	} else {
>>   		qp_init->cap.max_recv_wr = ch->rq_size;
>>   		qp_init->cap.max_recv_sge = min(attrs->max_recv_sge,
>> @@ -1878,6 +1905,8 @@ static int srpt_create_ch_ib(struct srpt_rdma_ch *ch)
>>
>>   static void srpt_destroy_ch_ib(struct srpt_rdma_ch *ch)
>>   {
>> +	if (ch->srq)
>> +		ch->srq = NULL;
>>   	ib_destroy_qp(ch->qp);
>>   	ib_free_cq(ch->cq);
>>   }
>> @@ -3018,20 +3047,75 @@ static struct se_wwn *srpt_lookup_wwn(const char *name)
>>   	return wwn;
>>   }
>>
>> -static void srpt_free_srq(struct srpt_device *sdev)
>> +static void srpt_free_srq(struct srpt_srq *srq)
>>   {
>> -	if (!sdev->srq)
>> -		return;
>>
>> -	ib_destroy_srq(sdev->srq);
>> -	srpt_free_ioctx_ring((struct srpt_ioctx **)sdev->ioctx_ring, sdev,
>> -			     sdev->srq_size, sdev->req_buf_cache,
>> +	srpt_free_ioctx_ring((struct srpt_ioctx **)srq->ioctx_ring, srq->sdev,
>> +			     srq->sdev->srq_size, srq->sdev->req_buf_cache,
>>   			     DMA_FROM_DEVICE);
>> +	rdma_srq_put(srq->sdev->pd, srq->ibsrq);
>> +	kfree(srq);
>> +
>> +}
>> +
>> +static void srpt_free_srqs(struct srpt_device *sdev)
>> +{
>> +	int i;
>> +
>> +	if (!sdev->srqs)
>> +		return;
>> +
>> +	for (i = 0; i < sdev->srq_count; i++)
>> +		srpt_free_srq(sdev->srqs[i]);
>>   	kmem_cache_destroy(sdev->req_buf_cache);
>> -	sdev->srq = NULL;
>> +	rdma_srq_set_destroy(sdev->pd);
>> +	kfree(sdev->srqs);
>> +	sdev->srqs = NULL;
>>   }
>>
>> -static int srpt_alloc_srq(struct srpt_device *sdev)
>> +static struct srpt_srq *srpt_alloc_srq(struct srpt_device *sdev)
>> +{
>> +	struct srpt_srq	*srq;
>> +	int i, ret;
>> +
>> +	srq = kzalloc(sizeof(*srq), GFP_KERNEL);
>> +	if (!srq) {
>> +		pr_debug("failed to allocate SRQ context\n");
> Please no to kzalloc prints and no to pr_* prints.

Sure no problem.

I'll remove the above print.


>
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>> +	srq->ibsrq = rdma_srq_get(sdev->pd);
>> +	if (!srq) {
> !srq->ibsrq ????

Yup good catch.


>
>> +		ret = -EAGAIN;
>> +		goto free_srq;
>> +	}
> Thanks

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
