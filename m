Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A33CC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 01:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uepnnaF/rmgIGFJ1waC7W+YqkqT3F6JJmrCu7Gd9bZE=; b=Pt/Ut+orlD6HCsxp7HtVXpt1PR
	v8Ou/yaw4UVG/mkaej33+NKEs5ITYILh5W27S5P95yNfOnybbOIYpc2K38xSTOmHQKIJrQzkRIw9y
	Fvfu9AsNahs7MsIxEDtADQeDeI+y+6xE+CDMwMLGW6EONaIP9WylsDv3JIiCW9ot6qZ7eDyziQTdX
	d2zxZUiI5Eqe7xzy0xYBvcv+KtsDGWrA0qJ/A0Xknsa4rKUsPvt/TIESZVUbG5bxms/JXpL9QCMyn
	WD0UkmJwTG5664qnc89jmlH2LokF+lyWTN8RYSTv+QKKX1NUcegXpykH2qqrjogU/+FY5x5gQImd7
	ubrjHaFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olhE7-004IA3-G7; Fri, 21 Oct 2022 01:53:35 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olhE4-004I8w-0D
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 01:53:34 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MtnYP3g5zzHv7B;
	Fri, 21 Oct 2022 09:53:13 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 09:53:21 +0800
Subject: Re: [PATCH 1/8] block: set the disk capacity to 0 in
 blk_mark_disk_dead
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
CC: Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-2-hch@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <e3ab9d31-7a9e-4bad-9a04-1f20845c6268@huawei.com>
Date: Fri, 21 Oct 2022 09:53:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221020105608.1581940-2-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_185332_410865_37EA817F 
X-CRM114-Status: GOOD (  25.17  )
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

Reviewed-by: Chao Leng <lengchao@huawei.com>

On 2022/10/20 18:56, Christoph Hellwig wrote:
> nvme and xen-blkfront are already doing this to stop buffered writes from
> creating dirty pages that can't be written out later.  Move it to the
> common code.  Note that this follows the xen-blkfront version that does
> not send and uevent as the uevent is a bit confusing when the device is
> about to go away a little later, and the the size change is just to stop
> buffered writes faster.
> 
> This also removes the comment about the ordering from nvme, as bd_mutex
> not only is gone entirely, but also hasn't been used for locking updates
> to the disk size long before that, and thus the ordering requirement
> documented there doesn't apply any more.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/genhd.c                | 3 +++
>   drivers/block/xen-blkfront.c | 1 -
>   drivers/nvme/host/core.c     | 7 +------
>   3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 17b33c62423df..2877b5f905579 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -555,6 +555,9 @@ void blk_mark_disk_dead(struct gendisk *disk)
>   {
>   	set_bit(GD_DEAD, &disk->state);
>   	blk_queue_start_drain(disk->queue);
> +
> +	/* stop buffered writers from dirtying pages that can't written out */
> +	set_capacity(disk, 0);
>   }
>   EXPORT_SYMBOL_GPL(blk_mark_disk_dead);
>   
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 35b9bcad9db90..b28489290323f 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -2129,7 +2129,6 @@ static void blkfront_closing(struct blkfront_info *info)
>   	if (info->rq && info->gd) {
>   		blk_mq_stop_hw_queues(info->rq);
>   		blk_mark_disk_dead(info->gd);
> -		set_capacity(info->gd, 0);
>   	}
>   
>   	for_each_rinfo(info, rinfo, i) {
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 059737c1a2c19..44a5321743128 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5106,10 +5106,7 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
>   /*
>    * Prepare a queue for teardown.
>    *
> - * This must forcibly unquiesce queues to avoid blocking dispatch, and only set
> - * the capacity to 0 after that to avoid blocking dispatchers that may be
> - * holding bd_butex.  This will end buffered writers dirtying pages that can't
> - * be synced.
> + * This must forcibly unquiesce queues to avoid blocking dispatch.
>    */
>   static void nvme_set_queue_dying(struct nvme_ns *ns)
>   {
> @@ -5118,8 +5115,6 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
>   
>   	blk_mark_disk_dead(ns->disk);
>   	nvme_start_ns_queue(ns);
> -
> -	set_capacity_and_notify(ns->disk, 0);
>   }
>   
>   /**
> 

