Return-Path: <SRS0=CVLn=P6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED8CC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 04:09:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22D9760200
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Nov 2021 04:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22D9760200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:CC:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SC6SuGCzD3/q0TC+C6OWsQnN/wVxZ7ey5I5+zOkycL8=; b=fCAIIzwDXtooTmCB1Cslf2vrad
	u1zCad6yJ7aaS6FMtfAutRhnoZimAbY83qYXYUoTRdBIkQp7kbuDGHvQNr6ehqYtNmQLlAew0ilRq
	1Fd83DkF+V7NWPka4Pu5byjpWoIx0yXDjlgsB6bK1tm4jhx+LQLhpHcM3y2z67wkaYG53EwV7aTXX
	goFylNj8iOPjZjJYg/rqMazgcT8fkayybfiWLvDNmOuzTegN1rktzZpFVsQusFj6SVe01WMe4pzuu
	l9I0/hhuLC3NDM25ibAtxlMF9+T5uRvQ7h9yWM/LcJe0Cnsz0marYC/22yZRPVZf6IFGFOlC2SNN1
	kdwd8Aug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ml1P5-006zDi-F7; Thu, 11 Nov 2021 04:09:35 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ml1P1-006zCb-Qw
 for linux-nvme@lists.infradead.org; Thu, 11 Nov 2021 04:09:33 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HqSry3jmyz90wM;
 Thu, 11 Nov 2021 12:09:06 +0800 (CST)
Received: from kwepemm600011.china.huawei.com (7.193.23.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 11 Nov 2021 12:09:22 +0800
Received: from [10.169.46.19] (10.169.46.19) by kwepemm600011.china.huawei.com
 (7.193.23.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 11 Nov
 2021 12:09:21 +0800
Subject: Re: [PATCH 1/1] nvme: fix use after free when disconnect a
 reconnecting ctrl
From: liruozhu <liruozhu@huawei.com>
To: <linux-nvme@lists.infradead.org>
CC: <sagi@grimberg.me>, James Smart <jsmart2021@gmail.com>
References: <20211104071332.28952-1-liruozhu@huawei.com>
 <20211104071332.28952-2-liruozhu@huawei.com>
Message-ID: <69d5bb86-c6fa-9e9b-c972-677b9e6da876@huawei.com>
Date: Thu, 11 Nov 2021 12:09:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20211104071332.28952-2-liruozhu@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600011.china.huawei.com (7.193.23.229)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211110_200932_187003_19B880D4 
X-CRM114-Status: GOOD (  20.45  )
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

Hi all,

Are there any other suggestions for this problem?

Thanks,
Ruozhu

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

