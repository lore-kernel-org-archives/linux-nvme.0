Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F4DC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 03:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uCQ7/gdNSIJahifQau/YQjM95zEX3dbTyYNVnBq3uVM=; b=hbdcjTgcWf3jMhAryWr4Nn1Dcn
	ybb33gTX+UTGIdR7VGX15CR2tMnDk2G+MYUCDAk30rc9dnWG5qmrssWRwfDobRWXh56JlH4Mxt+sq
	fJCbGDJDQ7tgLzrQncFL6tSCVA6CL+Q6ACE+RL1YGgGNFdj+u5j2HoSi3b2tt9a7/dUAz4kJtuSYi
	bp0N49ZvCIROfWJbBje8g9bSE0uH28kV+G4fNXoZG8coNJHGFyt+rmCnx15TFPyTE491wkpKQfrHR
	llGrMirhdm/8V8L1on7sD/oQpAPt/FtMvT5K2k1fmrrDjxV/6Ahpw2uwIWu5M5bPK+hlezXpLu1dy
	EEDXba7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaqXz-008bax-P1; Wed, 21 Sep 2022 03:37:15 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaqXw-008bYw-9N
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 03:37:14 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MXPBQ4T4LzlVhw;
	Wed, 21 Sep 2022 11:33:02 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 11:37:09 +0800
Subject: Re: [PATCH 01/13] nvme: add common helpers to allocate and free
 tagsets
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>
CC: <linux-nvme@lists.infradead.org>
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-2-hch@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <c9bc8a76-94aa-5a4c-526e-f92204635a22@huawei.com>
Date: Wed, 21 Sep 2022 11:37:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20220920171611.1289361-2-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_203712_706879_9907B05D 
X-CRM114-Status: GOOD (  20.86  )
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



On 2022/9/21 1:15, Christoph Hellwig wrote:
> Add common helpers to allocate and tear down the admin and I/O tag sets,
> including the special queues allocated with them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 100 +++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h |   8 ++++
>   2 files changed, 108 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8c9c1176624da..f8d9f32adc87c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4800,6 +4800,106 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>   }
>   EXPORT_SYMBOL_GPL(nvme_complete_async_event);
>   
> +int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
> +		const struct blk_mq_ops *ops, unsigned int flags,
> +		unsigned int cmd_size)
> +{
> +	int ret;
> +
> +	memset(set, 0, sizeof(*set));
> +	set->ops = ops;
> +	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
> +	if (ctrl->ops->flags & NVME_F_FABRICS)
> +		set->reserved_tags = NVMF_RESERVED_TAGS;
> +	set->numa_node = ctrl->numa_node;
> +	set->flags = flags;
> +	set->cmd_size = cmd_size;
> +	set->driver_data = ctrl;
> +	set->nr_hw_queues = 1;
> +	set->timeout = NVME_ADMIN_TIMEOUT;
> +	ret = blk_mq_alloc_tag_set(set);
> +	if (ret)
> +		return ret;
> +
> +	ctrl->admin_q = blk_mq_init_queue(set);
> +	if (IS_ERR(ctrl->admin_q)) {
> +		ret = PTR_ERR(ctrl->admin_q);
> +		goto out_free_tagset;
> +	}
> +
> +	if (ctrl->ops->flags & NVME_F_FABRICS) {
> +		ctrl->fabrics_q = blk_mq_init_queue(set);
> +		if (IS_ERR(ctrl->fabrics_q)) {
> +			ret = PTR_ERR(ctrl->fabrics_q);
> +			goto out_cleanup_admin_q;
> +		}
> +	}
> +
> +	ctrl->admin_tagset = set;
> +	return 0;
> +
> +out_cleanup_admin_q:
> +	blk_mq_destroy_queue(ctrl->fabrics_q);
> +out_free_tagset:
> +	blk_mq_free_tag_set(ctrl->admin_tagset);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(nvme_alloc_admin_tag_set);
> +
> +void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl)
> +{
> +	blk_mq_destroy_queue(ctrl->admin_q);
> +	if (ctrl->ops->flags & NVME_F_FABRICS)
> +		blk_mq_destroy_queue(ctrl->fabrics_q);
> +	blk_mq_free_tag_set(ctrl->admin_tagset);
> +}
> +EXPORT_SYMBOL_GPL(nvme_remove_admin_tag_set);
> +
> +int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
> +		const struct blk_mq_ops *ops, unsigned int flags,
> +		unsigned int cmd_size)
> +{
> +	int ret;
> +
> +	memset(set, 0, sizeof(*set));
> +	set->ops = ops;
> +	set->queue_depth = ctrl->sqsize + 1;
> +	set->reserved_tags = NVMF_RESERVED_TAGS;
> +	set->numa_node = ctrl->numa_node;
> +	set->flags = flags;
> +	set->cmd_size = cmd_size,
> +	set->driver_data = ctrl;
> +	set->nr_hw_queues = ctrl->queue_count - 1;
> +	set->timeout = NVME_IO_TIMEOUT;
> +	if (ops->map_queues)
> +		set->nr_maps = ctrl->opts->nr_poll_queues ? HCTX_MAX_TYPES : 2;
> +	ret = blk_mq_alloc_tag_set(set);
> +	if (ret)
> +		return ret;
> +
> +	ctrl->connect_q = blk_mq_init_queue(set);
> +        if (IS_ERR(ctrl->connect_q)) {
> +		ret = PTR_ERR(ctrl->connect_q);
> +		goto out_free_tag_set;
> +	}
Maybe we should move the connect_q related code to nvme_alloc_admin_tag_set.
Thus we don't need to set NVMF_RESERVED_TAGS for tagset,
if there are large amount of ns queues, it will save resources.
At the same time, it will simplify tagset-based implementation.
According to the behavior logic, connect_q is a management resource.
However, connect_q use the I/O tagset.
As a result, it is difficult to process some logic based on tagset.
> +
> +	ctrl->tagset = set;
> +	return 0;
> +
> +out_free_tag_set:
> +	blk_mq_free_tag_set(set);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(nvme_alloc_io_tag_set);
> +
> +void nvme_remove_io_tag_set(struct nvme_ctrl *ctrl)
> +{
> +	if (ctrl->ops->flags & NVME_F_FABRICS)
> +		blk_mq_destroy_queue(ctrl->connect_q);
> +	blk_mq_free_tag_set(ctrl->tagset);
> +}
> +EXPORT_SYMBOL_GPL(nvme_remove_io_tag_set);
> +
>   void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>   {
>   	nvme_mpath_stop(ctrl);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1bdf714dcd9e4..6dec8a3bef1aa 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -722,6 +722,14 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
>   void nvme_start_ctrl(struct nvme_ctrl *ctrl);
>   void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
>   int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl);
> +int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
> +		const struct blk_mq_ops *ops, unsigned int flags,
> +		unsigned int cmd_size);
> +void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl);
> +int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
> +		const struct blk_mq_ops *ops, unsigned int flags,
> +		unsigned int cmd_size);
> +void nvme_remove_io_tag_set(struct nvme_ctrl *ctrl);
>   
>   void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
>   
> 

