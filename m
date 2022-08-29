Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9355EECAAD2
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 09:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dYmMm9D82/FNL7fMZ/3XW+aAfFGmL7y6iMLg4qR62E0=; b=uAsqxbI2faxy83dfg6mgLq5ATb
	MEWFugfdVslUM9tO7Y+u4vfg8d8qSKJwbab7IjeBMeEcW/yqhSz+ZT+R+aH9ZhE/V04NPGqk/js+d
	Yy+Y3cQ9QZxDwPvfQPW3VoebEFhOe6jTDIcp/Rb16HlSSZCRqRcYiYW5YeiX+6tp86GI0Sf/BRpE1
	MsVRJtnmlYzcBVgVuZqhUw8hWQOf/1dAQKQ24tIS/Ev+wMQ5r9lDUnUq5jgIa7HgxHRo049Zd20UO
	r6WJmtv0tyvn/R/EEig+DEmte+L+7dpOwZZWSI7Myg5VgtDvhSW0J2ey0ci/TybSVYka+IoWorYB1
	tmWelx+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSaz0-006gVa-Ev; Mon, 29 Aug 2022 09:23:02 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSayu-006gRI-KQ
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 09:23:00 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MGPyV3240zkWj3;
	Mon, 29 Aug 2022 17:19:14 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 17:22:51 +0800
Subject: Re: [PATCH v3 3/3] nvme-rdma: Handle number of queue changes
To: Daniel Wagner <dwagner@suse.de>, <linux-nvme@lists.infradead.org>
CC: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
References: <20220829083856.1850-1-dwagner@suse.de>
 <20220829083856.1850-4-dwagner@suse.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <5cc0b557-7e56-36c9-cfe4-05ca76f5e83e@huawei.com>
Date: Mon, 29 Aug 2022 17:22:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220829083856.1850-4-dwagner@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_022257_472824_D0984113 
X-CRM114-Status: GOOD (  23.88  )
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



On 2022/8/29 16:38, Daniel Wagner wrote:
> On reconnect, the number of queues might have changed.
> 
> In the case where we have more queues available than previously we try
> to access queues which are not initialized yet.
> 
> The other case where we have less queues than previously, the
> connection attempt will fail because the target doesn't support the
> old number of queues and we end up in a reconnect loop.
> 
> Thus, only start queues which are currently present in the tagset
> limited by the number of available queues. Then we update the tagset
> and we can start any new queue.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   drivers/nvme/host/rdma.c | 26 +++++++++++++++++++++-----
>   1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 3100643be299..0d1d29e644d9 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -696,11 +696,12 @@ static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
>   	return ret;
>   }
>   
> -static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
> +static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl,
> +				     int first, int last)
>   {
>   	int i, ret = 0;
>   
> -	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
> +	for (i = first; i < last; i++) {
>   		ret = nvme_rdma_start_queue(ctrl, i);
>   		if (ret)
>   			goto out_stop_queues;
> @@ -709,7 +710,7 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
>   	return 0;
>   
>   out_stop_queues:
> -	for (i--; i >= 1; i--)
> +	for (i--; i >= first; i--)
>   		nvme_rdma_stop_queue(&ctrl->queues[i]);
>   	return ret;
>   }
> @@ -964,7 +965,7 @@ static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl,
>   
>   static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>   {
> -	int ret;
> +	int ret, nr_queues;
>   
>   	ret = nvme_rdma_alloc_io_queues(ctrl);
>   	if (ret)
> @@ -980,7 +981,13 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>   			goto out_free_tag_set;
>   	}
>   
> -	ret = nvme_rdma_start_io_queues(ctrl);
> +	/*
> +	 * Only start IO queues for which we have allocated the tagset
> +	 * and limitted it to the available queues. On reconnects, the
> +	 * queue number might have changed.
> +	 */
> +	nr_queues = min(ctrl->tag_set.nr_hw_queues + 1, nctrl->queue_count);
> +	ret = nvme_rdma_start_io_queues(ctrl, 1, nr_queues);
>   	if (ret)
>   		goto out_cleanup_connect_q;
>   
> @@ -1000,6 +1007,15 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>   		nvme_unfreeze(&ctrl->ctrl);
>   	}
>   
> +	/*
> +	 * If the number of queues has increased (reconnect case)
> +	 * start all new queues now.
> +	 */
> +	ret = nvme_rdma_start_io_queues(ctrl, nr_queues,
> +					ctrl->tag_set.nr_hw_queues + 1);
> +	if (ret)
> +		goto out_wait_freeze_timed_out;
nvme_rdma_start_io_queues(ctrl, 1, nr_queues) need to clean.
> +
>   	return 0;
>   
>   out_wait_freeze_timed_out:
> 

