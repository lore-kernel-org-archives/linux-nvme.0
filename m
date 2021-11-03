Return-Path: <SRS0=DxE/=PW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983DDC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 07:11:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10586611C0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Nov 2021 07:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 10586611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:CC:References:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gUg+mujLhIFICHqes4UdU//7NvY+DNA1JQ6X8oRn7Vw=; b=IKAYdzv7ytXPWLsnb5U/Yslidt
	iF7veJfqLMYSRJMtjM1O4x/2kwf2jpDO4yCztrl/BKGXvKYg41Ae66zR9Rr5dGOT3u0A+UW5Rfw4c
	JD34jJssq55SddGR57/hdSsFTemt9xOVGGs8eaq4LpT7svPKR9ts0Lqbicl4TwX+xM1yRsWwhaLSm
	TSPru8+9Fg5EyJTB1GlicA8gv3KlYroJ8mb1q8NaGKmsmLhzl0vDTjfWk4SOhKMmfC0hmgFYPswzm
	kDsvp9sveszivq1FvIDB6w137svJJp1Itb75G4nOka08sc8srhaUQQveRWDWxs3ad1r2baSV5G3I0
	5/tLQoXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1miAR2-004O7M-Si; Wed, 03 Nov 2021 07:11:48 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1miAQy-004O4x-NH
 for linux-nvme@lists.infradead.org; Wed, 03 Nov 2021 07:11:47 +0000
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HkdDd2flkzZcSr;
 Wed,  3 Nov 2021 15:09:21 +0800 (CST)
Received: from [127.0.0.1] (10.40.193.166) by dggeme756-chm.china.huawei.com
 (10.3.19.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Wed, 3
 Nov 2021 15:11:25 +0800
Subject: Re: [PATCH 14/16] block: switch polling to be bio based
To: Christoph Hellwig <hch@lst.de>
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-15-hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Jeffle Xu <jefflexu@linux.alibaba.com>, Ming
 Lei <ming.lei@redhat.com>, Damien Le Moal <Damien.LeMoal@wdc.com>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, "Wunderlich,
 Mark" <mark.wunderlich@intel.com>, "Vasudevan, Anil"
 <anil.vasudevan@intel.com>, <linux-block@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-nvme@lists.infradead.org>
From: "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <beb633f4-4508-ea53-4a34-adf0f20cda85@hisilicon.com>
Date: Wed, 3 Nov 2021 15:11:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20211012111226.760968-15-hch@lst.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211103_001145_408846_9806A883 
X-CRM114-Status: GOOD (  20.50  )
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

Hi Christoph,


ÔÚ 2021/10/12 19:12, Christoph Hellwig Ð´µÀ:
> Replace the blk_poll interface that requires the caller to keep a queue
> and cookie from the submissions with polling based on the bio.
>
> Polling for the bio itself leads to a few advantages:
>
>   - the cookie construction can made entirely private in blk-mq.c
>   - the caller does not need to remember the request_queue and cookie
>     separately and thus sidesteps their lifetime issues
>   - keeping the device and the cookie inside the bio allows to trivially
>     support polling BIOs remapping by stacking drivers
>   - a lot of code to propagate the cookie back up the submission path can
>     be removed entirely.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Mark Wunderlich <mark.wunderlich@intel.com>
> ---
......
>   /**
>    * blk_cloned_rq_check_limits - Helper function to check a cloned request
>    *                              for the new queue limits
> diff --git a/block/blk-exec.c b/block/blk-exec.c
> index 1fa7f25e57262..55f0cd34b37b9 100644
> --- a/block/blk-exec.c
> +++ b/block/blk-exec.c
> @@ -65,13 +65,19 @@ EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
>   
>   static bool blk_rq_is_poll(struct request *rq)
>   {
> -	return rq->mq_hctx && rq->mq_hctx->type == HCTX_TYPE_POLL;
> +	if (!rq->mq_hctx)
> +		return false;
> +	if (rq->mq_hctx->type != HCTX_TYPE_POLL)
> +		return false;
> +	if (WARN_ON_ONCE(!rq->bio))
> +		return false;
> +	return true;
>   }
>   
>   static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
>   {
>   	do {
> -		blk_poll(rq->q, request_to_qc_t(rq->mq_hctx, rq), 0);
> +		bio_poll(rq->bio, 0);
>   		cond_resched();
>   	} while (!completion_done(wait));
>   }

For some scsi command sent by function __scsi_execute() without data, it 
has request but no bio (bufflen = 0),
then how to use bio_poll() for them ?

Best Regards,
Xiang Chen


