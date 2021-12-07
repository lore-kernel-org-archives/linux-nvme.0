Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB0FC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Dec 2021 12:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:CC:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lzhiuOj5tM8poYs1UWpaBuoXnO0L+BWxm3O4Tn86ZTI=; b=UGqEDwKhABgU/jJtDPdGgosSuV
	6G54JfB+iA9eIsFpMBsK0j1AYqCDcSozql2shUevBZq10LbAzLRz8X36xYneooaHzs4MkBHED8eYb
	ewpvKCtTXG3ZO8AxYummUYE03WjOo0AS8ZYDqLgfqVzvDtd6uy4i7BxAJbnGcx60Ny1wHFnLZ61JF
	PEGu5hoRCgChOl62uBZd8hQzSRajWyaP+EcCm4D0oTvif+BkdtIxvz+si6A7H6sc7VYGYOLEM/sd2
	44PDlMLwkQMV01TLTQ+DRxC0y+jhrz2ktWOHPo/ICOAfyJQ+lQS8l8l62AI0A6pEaQ/dSjAWAcwVs
	rd/9W74g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1muZsE-008VwD-FA; Tue, 07 Dec 2021 12:47:10 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muZqT-008VEf-FF
 for linux-nvme@lists.infradead.org; Tue, 07 Dec 2021 12:45:23 +0000
Received: from kwepemi100005.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J7g4G3jr1zcbbx
 for <linux-nvme@lists.infradead.org>; Tue,  7 Dec 2021 20:45:02 +0800 (CST)
Received: from kwepemm600011.china.huawei.com (7.193.23.229) by
 kwepemi100005.china.huawei.com (7.221.188.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 20:45:14 +0800
Received: from [10.169.46.19] (10.169.46.19) by kwepemm600011.china.huawei.com
 (7.193.23.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 7 Dec
 2021 20:45:13 +0800
Subject: Re: [PATCH 1/1] nvme: fix use after free when disconnect a
 reconnecting ctrl
From: liruozhu <liruozhu@huawei.com>
To: <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>
References: <20211104071332.28952-1-liruozhu@huawei.com>
 <20211104071332.28952-2-liruozhu@huawei.com>
Message-ID: <9db489fc-ecdd-e1d7-cce1-78d47dfb44fb@huawei.com>
Date: Tue, 7 Dec 2021 20:45:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20211104071332.28952-2-liruozhu@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600011.china.huawei.com (7.193.23.229)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211207_044521_744413_B03397C7 
X-CRM114-Status: GOOD (  20.33  )
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

On 2021/11/4 15:13, Ruozhu Li wrote:

> A crash happens when I try to disconnect a reconnecting ctrl:
>
> 1) The network was cut off when the connection was just established,
> scan work hang there waiting for some IOs complete.Those IOs were
> retrying because we return BLK_STS_RESOURCE to blk in reconnecting.
>
> 2) After a while, I tried to disconnect this connection.This procedure
> also hung because it tried to obtain ctrl->scan_lock.It should be noted
> that now we have switched the controller state to NVME_CTRL_DELETING.
>
> 3) In nvme_check_ready(), we always return true when ctrl->state is
> NVME_CTRL_DELETING, so those retrying IOs were issued to the bottom
> device which was already freed.
>
> To fix this, when ctrl->state is NVME_CTRL_DELETING, issue cmd to bottom
> device only when queue state is live.If not, return host path error to blk.
>
> Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
> ---
>   drivers/nvme/host/core.c | 1 +
>   drivers/nvme/host/nvme.h | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 838b5e2058be..752203ad7639 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -666,6 +666,7 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
>   		struct request *rq)
>   {
>   	if (ctrl->state != NVME_CTRL_DELETING_NOIO &&
> +	    ctrl->state != NVME_CTRL_DELETING &&
>   	    ctrl->state != NVME_CTRL_DEAD &&
>   	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
>   	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index b334af8aa264..9b095ee01364 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -709,7 +709,7 @@ static inline bool nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>   		return true;
>   	if (ctrl->ops->flags & NVME_F_FABRICS &&
>   	    ctrl->state == NVME_CTRL_DELETING)
> -		return true;
> +		return queue_live;
>   	return __nvme_check_ready(ctrl, rq, queue_live);
>   }
>   int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,

Hi Christoph,

friendly ping...

thanks,
Ruozhu


