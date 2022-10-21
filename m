Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720D6C433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 02:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RBv4vpO2nz0wVzPSH7o4Vt6+sErbqq88Koyu4e6Ocbw=; b=5CGmEOLH0dkjJgcVSmVHos6SFn
	+T0wj2DJkl9G4sYYgcpq/Vr6GtQCFkK7VvT2uiwYi4PK4ceVW0IkY2ex8T80YIF+GHwjw0KXuBrS9
	21g9yiNPxGXAqX5oTo5auf96LHt0etCaGa7Y1luIM6pjJtEqX1kXxz1WlXmf2Hc2LTM9CzLUCM6DJ
	TTm5mz1ufSsJHU/r6lPlD3fp+Vk2YyVVQcysRVMwO0xhmgVA6WuWSJBVl6jsPKMvjhqcnMkfDUPTW
	5pCwIpHt5Wh5SOs1d7KAwekWDoSo9m3DxImEDrnx4KmBkmLh2AjeON+i43UlLsb8QYQ5S7vZ5VF7r
	QE6gHo7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oli6q-004ZVt-Gn; Fri, 21 Oct 2022 02:50:08 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oli6m-004ZR3-VJ
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 02:50:06 +0000
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mtplr2L9SzDsKj;
	Fri, 21 Oct 2022 10:47:20 +0800 (CST)
Received: from [10.169.59.127] (10.169.59.127) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 10:50:00 +0800
Subject: Re: [PATCH 7/8] nvme: remove nvme_set_queue_dying
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith Busch
	<kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
CC: Ming Lei <ming.lei@redhat.com>, <linux-nvme@lists.infradead.org>,
	<linux-block@vger.kernel.org>
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-8-hch@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <07131141-71a4-4e44-c31d-4de6d1bda9e3@huawei.com>
Date: Fri, 21 Oct 2022 10:50:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20221020105608.1581940-8-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.169.59.127]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_195005_225543_674FFE7B 
X-CRM114-Status: GOOD (  16.32  )
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
> This helper is pretty pointless now, and also in the way of per-tagset
> quiesce.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 18 ++++--------------
>   1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fa7fdb744979c..0ab3a18fd9f85 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5104,17 +5104,6 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
>   		blk_mq_wait_quiesce_done(ns->queue->tag_set);
>   }
>   
> -/*
> - * Prepare a queue for teardown.
> - *
> - * This must forcibly unquiesce queues to avoid blocking dispatch.
> - */
> -static void nvme_set_queue_dying(struct nvme_ns *ns)
> -{
> -	blk_mark_disk_dead(ns->disk);
> -	nvme_start_ns_queue(ns);
> -}
> -
>   /**
>    * nvme_kill_queues(): Ends all namespace queues
>    * @ctrl: the dead controller that needs to end
> @@ -5130,10 +5119,11 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>   	/* Forcibly unquiesce queues to avoid blocking dispatch */
>   	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
>   		nvme_start_admin_queue(ctrl);
> -
>   	if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
> -		list_for_each_entry(ns, &ctrl->namespaces, list)
> -			nvme_set_queue_dying(ns);
> +		list_for_each_entry(ns, &ctrl->namespaces, list) {
> +			blk_mark_disk_dead(ns->disk);
> +			nvme_start_ns_queue(ns);
> +		}
>   	}
>   	up_read(&ctrl->namespaces_rwsem);
>   }
> 

