Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242A2C4346E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 06:14:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57555235FD
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 06:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TzkEC2VW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57555235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jUQS1IU6FwCjbj4+CGA6aCMcTkVBsUuv8Oy0dwWY5gQ=; b=TzkEC2VWyLsehQc3OIy7H2RPv
	mFgpaKyJl+wBs4AFXjSqjin+XW5kV5Gk8w3k06V/0pX4b/EfstE+5eph3NFH+5RvkaZ9tjFz4kYHW
	L1M9Andv9zS3GubNEu5+v3MHfe+nWVUKXMD424zdx5y3zonHCFu2wWyOLtQQoZYd5A9nsr9ZOtCMa
	zy1ILHBooxSzF6IMuYR3HwYP8kcvBotUcLsdWr1Mgf4dOxBWqcF1R/SkbH+3lLti9Zjpbpe/wN06A
	UR/3CphZPEL/W5rN8giFVUfqSZqjxCobniDATobv3nUizIhTWlqWy5X7EmA40eSVCqXVpCV5G88OM
	BBwmSDy7Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLKWe-0000Em-Jr; Thu, 24 Sep 2020 06:14:40 +0000
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLKWb-0000Cx-Fh
 for linux-nvme@lists.infradead.org; Thu, 24 Sep 2020 06:14:38 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0U9wZfYu_1600928058; 
Received: from admindeMacBook-Pro-2.local(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0U9wZfYu_1600928058) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Sep 2020 14:14:19 +0800
Subject: Re: [RFC] nvme/pci: allocate separate interrupt for reserved
 non-polled IO queue
From: JeffleXu <jefflexu@linux.alibaba.com>
To: axboe@fb.com, hch@lst.de
References: <20200922042816.92192-1-jefflexu@linux.alibaba.com>
Message-ID: <f1696d27-0e35-5f10-59d8-e09b046a64a5@linux.alibaba.com>
Date: Thu, 24 Sep 2020 14:14:18 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200922042816.92192-1-jefflexu@linux.alibaba.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200924_021437_734919_8F290052 
X-CRM114-Status: GOOD (  20.12  )
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
Cc: joseph.qi@linux.alibaba.com, linux-nvme@lists.infradead.org,
 xiaoguang.wang@linux.alibaba.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Any comments?

On 9/22/20 12:28 PM, Jeffle Xu wrote:
> One queue will be reserved for non-polled IO when nvme.poll_queues is
> greater or equal than the number of IO queues that the nvme controller
> can provide. Currently the reserved queue for non-polled IO will reuse
> the interrupt used by admin queue in this case, e.g, vector 0.
>
> This can work and the performance may not be an issue since the admin
> queue is used unfrequently. However this behaviour may be inconsistent
> with that when nvme.poll_queues is smaller than the number of IO
> queues available.
>
> Thus allocate separate interrupt for this reserved queue, and thus make
> the behaviour consistent.
>
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>   drivers/nvme/host/pci.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 899d2f4d7ab6..ff3e28a8a9e0 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2042,12 +2042,14 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
>   
>   	/*
>   	 * Poll queues don't need interrupts, but we need at least one IO
> -	 * queue left over for non-polled IO.
> +	 * queue left over for non-polled IO. Also one interrupt for admin
> +	 * queue.
>   	 */
>   	this_p_queues = dev->nr_poll_queues;
>   	if (this_p_queues >= nr_io_queues) {
>   		this_p_queues = nr_io_queues - 1;
> -		irq_queues = 1;
> +		/* Allocate separate interrupt for reserved non-polled IO queue. */
> +		irq_queues = 2;
>   	} else {
>   		irq_queues = nr_io_queues - this_p_queues + 1;
>   	}

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
