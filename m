Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43230C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 08:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m1ErIhDNM7ZaKrQrAYu5n65NmI7HYat8no8f5QMtTxs=; b=lgfK57NZFt0qSpJn4pb8E/Wh5S
	foOS4CNWFuPnar8nzT1vHGAblSXR1PW12RfPMjAdMQlKyKerx/qgBMBm/Jad4QGnENFW8VoS3Xj/f
	7q8lqc8J5FowS2E/Cr8qwHe+oMgi/k8UcJTAwXroqeemWh6BUZjZwgFxtfCVl9M3K7f1D1ICo+tkL
	6VEz70/KvO4wCFdHcTy5CNPewdnr5x+58YLwdKg0SP3dy5BBoCvkDsUeTMPqGMkXm5QvsvtPjZ1LR
	Gli78DssyQFC4GPdi5RWQ76KJQHpV+wPXSI76S93HyL9OK/wzxzp+Wl1pNJWVbhn28No207Q+udpM
	SgqVcFYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2TYy-0056gh-B6; Tue, 06 Dec 2022 08:44:28 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2TYu-0056WA-UU
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 08:44:26 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NRDTZ0jkTzmWM3;
	Tue,  6 Dec 2022 16:43:30 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 16:43:45 +0800
Subject: Re: [PATCH 2/5] nvme: consolidate setting the tagset flags
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>
CC: James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni
	<kch@nvidia.com>, <linux-nvme@lists.infradead.org>
References: <20221130174240.227616-1-hch@lst.de>
 <20221130174240.227616-3-hch@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <3b03aa7f-ea25-2973-3efc-900676f11220@huawei.com>
Date: Tue, 6 Dec 2022 16:43:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221130174240.227616-3-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_004425_362158_92B66996 
X-CRM114-Status: GOOD (  20.80  )
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



On 2022/12/1 1:42, Christoph Hellwig wrote:
> All nvme transports should be using the same flags for their tagsets,
> with the exception for the blocking flag that should only be set for
> transports that can block in ->queue_rq.
> 
> Add a NVME_F_BLOCKING flag to nvme_ctrl_ops to control the blocking
> behavior and lift setting the flags into nvme_alloc_{admin,io}_tag_set.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c   | 15 +++++++++------
>   drivers/nvme/host/fc.c     |  4 ++--
>   drivers/nvme/host/nvme.h   |  9 +++++----
>   drivers/nvme/host/rdma.c   |  3 +--
>   drivers/nvme/host/tcp.c    |  3 +--
>   drivers/nvme/target/loop.c |  4 ++--
>   6 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3b369900928fde..f31586c4689334 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4831,8 +4831,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>   EXPORT_SYMBOL_GPL(nvme_complete_async_event);
>   
>   int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
> -		const struct blk_mq_ops *ops, unsigned int flags,
> -		unsigned int cmd_size)
> +		const struct blk_mq_ops *ops, unsigned int cmd_size)
>   {
>   	int ret;
>   
> @@ -4842,7 +4841,9 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>   	if (ctrl->ops->flags & NVME_F_FABRICS)
>   		set->reserved_tags = NVMF_RESERVED_TAGS;
>   	set->numa_node = ctrl->numa_node;
> -	set->flags = flags;
> +	set->flags = BLK_MQ_F_NO_SCHED;
> +	if (ctrl->ops->flags & NVME_F_BLOCKING)
> +		set->flags |= BLK_MQ_F_BLOCKING;
>   	set->cmd_size = cmd_size;
>   	set->driver_data = ctrl;
>   	set->nr_hw_queues = 1;
> @@ -4890,8 +4891,8 @@ void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl)
>   EXPORT_SYMBOL_GPL(nvme_remove_admin_tag_set);
>   
>   int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
> -		const struct blk_mq_ops *ops, unsigned int flags,
> -		unsigned int nr_maps, unsigned int cmd_size)
> +		const struct blk_mq_ops *ops, unsigned int nr_maps,
> +		unsigned int cmd_size)
>   {
>   	int ret;
>   
> @@ -4900,7 +4901,9 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>   	set->queue_depth = ctrl->sqsize + 1;
>   	set->reserved_tags = NVMF_RESERVED_TAGS;
>   	set->numa_node = ctrl->numa_node;
> -	set->flags = flags;
> +	set->flags = BLK_MQ_F_SHOULD_MERGE;
> +	if (ctrl->ops->flags & NVME_F_BLOCKING)
> +		set->flags |= BLK_MQ_F_BLOCKING;
>   	set->cmd_size = cmd_size,
>   	set->driver_data = ctrl;
>   	set->nr_hw_queues = ctrl->queue_count - 1;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index fa245a50f630b8..7cfc1bc021085f 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1858,7 +1858,6 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   	if (new) {
>   		ret = nvme_alloc_io_tag_set(ctrl, &to_tcp_ctrl(ctrl)->tag_set,
>   				&nvme_tcp_mq_ops,
> -				BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING,
tcp should set NVME_F_BLOCKING in ctrl->ops->flags, I did not see that in this patch.
Did I miss something?

