Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4021C3A59D
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Oct 2022 01:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JzOtnRtKvgJCdhBpIs3+qQEJ9HhKuemIbkDqK1FkKSQ=; b=FlV7l67fgiybn3/bl3hNAKcNfz
	Ysb8DbzLYI0KVSh1F2DY1kF/+/WGBz5yDCTwnj2dZVTjrRLv+RpZ8nxBA/wkTddyPalR6JfbXuAf3
	hZohS9uzNhE8oJWoaCo+4bQU0yUw3itXU0udEenalWQmfp3l1i1YWKv6lTVqVrhWqFS/fTOd5GFac
	40bY5MwYkriPWChwKUxVJHb8h1XhxYN+6Dbn1yl4sR9sGhEYnGO0skWGcthMH8aLg4nZDfqG18S+u
	FCIrNLinYoj2Tp6t4MDd4C8E1iLw35Jajp1pYgHi3o9etY39aB5A7ZzURLmz0u4H1NTzdsuKxqkQK
	azoNEOCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ommiX-00GjgS-RK; Mon, 24 Oct 2022 01:57:29 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ommiS-00Gjet-Mk
	for linux-nvme@lists.infradead.org; Mon, 24 Oct 2022 01:57:26 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MwdP12sMQzmVJw;
	Mon, 24 Oct 2022 09:52:21 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 09:57:11 +0800
Subject: Re: [PATCH 5/8] blk-mq: add tagset quiesce interface
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>, Jens
 Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>
CC: Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-6-hch@lst.de>
 <01e45c37-5db8-b1a5-33c6-251da2637fb5@acm.org>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <e092e8b6-66d5-b191-805d-f49ffdafc8a8@huawei.com>
Date: Mon, 24 Oct 2022 09:57:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <01e45c37-5db8-b1a5-33c6-251da2637fb5@acm.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221023_185724_960702_5CE40933 
X-CRM114-Status: GOOD (  13.02  )
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



On 2022/10/22 5:22, Bart Van Assche wrote:
> On 10/20/22 03:56, Christoph Hellwig wrote:
>> From: Chao Leng <lengchao@huawei.com>
>>
>> Drivers that have shared tagsets may need to quiesce potentially a lot
>> of request queues that all share a single tagset (e.g. nvme). Add an
>> interface to quiesce all the queues on a given tagset. This interface is
>> useful because it can speedup the quiesce by doing it in parallel.
>>
>> Because some queues should not need to be quiesced(e.g. nvme connect_q)
> 
> should not need -> do not have
> 
>> when quiesce the tagset. So introduce QUEUE_FLAG_SKIP_TAGSET_QUIESCE to
> 
> quiesce -> quiescing
> 
> . So -> ,
> 
>> tagset quiesce interface to skip the queue.
> 
> Hi Christoph,
> 
> Are there any drivers that may call blk_mq_quiesce_tagset() concurrently from two different threads? blk_mq_quiesce_queue() supports this but blk_mq_quiesce_tagset() cannot support this because of the mechanism used to mark request queues that should be skipped (queue flag).
> 
blk_mq_quiesce_tagset() support concurrency. blk_mq_quiesce_tagset() just
check the flag(QUEUE_FLAG_SKIP_TAGSET_QUIESCE), it has no impact on concurrency.

