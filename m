Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E8FC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 08:00:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3574D64F7F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 08:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3574D64F7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=G5yeRN+3Em2om8nF7pHMe5iNERno5cjd3SHwbVXVkZg=; b=Gx+DRdid0OKhl6ZcEuBogH6xF
	AXtyY4YJaxiZqgName7OXcND9CBkoL6CyjXqDtzJzt3b7jF314cBwyoyJRb1ctR3zJrgJGf7e+LMB
	PaVbX/6J9pq2AIzYZjHHeyei/zeoInfn+mqCzcBlo/TDR33FlgqugXB2eh24Q1JK0gkURbaAdlWY5
	V2v47wwMBoq6jgUCKGpyuNn12Ul3oyctpRadpyyUtyf9T9C6kirpnscTWoXnstynK/YMR2mycjUYo
	YKYP4uHV2ZWdbiiqdTCqUifOAFXBopf5mI8N+ndKPsBI05uLYCdwMe+qHSRL+WpSG63seZi0cbrbb
	J0K9qiiqA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMR6F-002heH-GR; Wed, 17 Mar 2021 08:00:15 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMR60-002hc0-Df
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 08:00:03 +0000
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4F0jDs2Zh1z5ckk;
 Wed, 17 Mar 2021 15:57:33 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Wed, 17 Mar 2021 15:59:56 +0800
Received: from [10.169.42.93] (10.169.42.93) by dggema772-chm.china.huawei.com
 (10.1.198.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2106.2; Wed, 17
 Mar 2021 15:59:56 +0800
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
To: Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni
 <Chaitanya.Kulkarni@wdc.com>
References: <20210315222714.378417-1-sagi@grimberg.me>
 <1b2ccda9-5789-e73a-f0c9-2dd40f320203@grimberg.me>
 <20210316204204.GA23332@redsun51.ssa.fujisawa.hgst.com>
 <59f7a030-ea33-5c31-3c18-197c5a12e982@grimberg.me>
 <17b15849-f0f3-af61-113f-0eb717e96f0f@huawei.com>
 <20210317065910.GC14498@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <2e391aae-58c7-b8f7-1a9e-d7ad5bb3f8f3@huawei.com>
Date: Wed, 17 Mar 2021 15:59:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20210317065910.GC14498@lst.de>
Content-Language: en-US
X-Originating-IP: [10.169.42.93]
X-ClientProxiedBy: dggeme710-chm.china.huawei.com (10.1.199.106) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_080000_837252_DD64BDAA 
X-CRM114-Status: GOOD (  14.87  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021/3/17 14:59, Christoph Hellwig wrote:
> On Wed, Mar 17, 2021 at 10:55:57AM +0800, Chao Leng wrote:
>>>> Will it work if nvme mpath used request NOWAIT flag for its submit_bio()
>>>> call, and add the bio to the requeue_list if blk_queue_enter() fails? I
>>>> think that looks like another way to resolve the deadlock, but we need
>>>> the block layer to return a failed status to the original caller.
> 
> Yes, I think BLK_MQ_REQ_NOWAIT makes total sense here.  dm-mpath also
> uses it for its request allocation for similar reasons.
> 
>>>
>>> But who would kick the requeue list? and that would make near-tag-exhaust performance stink...
> 
> The multipath code would have to kick the list.  We could also try to
> split into two flags, one that affects blk_queue_enter and one that
> affects the tag allocation.
> 
>> moving nvme_start_freeze from nvme_rdma_teardown_io_queues to nvme_rdma_configure_io_queues can fix it.
>> It can also avoid I/O hang long time if reconnection failed.
> 
> Can you explain how we'd still ensure that no new commands get queued
> during teardown using that scheme?
1. tear down will cancel all inflight requests, and then multipath will clear the path.
2. and then we may freeze the controler.
3. nvme_ns_head_submit_bio can not find the reconnection controller as valid path, so it is safe.
> .
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
