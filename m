Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7853AC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jul 2022 10:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ie+4S+fvAkKkTn3GYGcxj9SdB6dX2iUCjsgtX0lvhs=; b=VPnqEL8EGJU2jp7s9AsyUMj2wc
	4gwcJO63JzITe4fc4+xPfVmkSDRSmcXBuZm3A/LJqBZMj6AL/TxBb9f+cxUj/vKsXzaPanXOZ1JAl
	G4vnogeeQRx0tQrkmQYjz+TKYB9JaQIOAKJcOInzW8pgjR03kB9N2TINxyU08bAjGXDqGed5pfzSP
	KPwW+pqy968/3AVeSavTkyx0BlqyQBAfw8drw76bzTYGCg1frAb3vcUNF73r8dLHObptgU6lbrunS
	idjF4y8Bbzs2JRIGlwZZOJEbV7tB2WIm+eeBmiX4RNNUkrVD8I8+b6Z3PyoyWLHtxHEOpDD7UiFRy
	PFG0wXZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9knv-0035dy-G4; Fri, 08 Jul 2022 10:01:43 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9knl-0035ba-1u; Fri, 08 Jul 2022 10:01:34 +0000
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LfTH518qzzThJk;
	Fri,  8 Jul 2022 17:57:53 +0800 (CST)
Received: from kwepemm600011.china.huawei.com (7.193.23.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 18:01:25 +0800
Received: from [10.169.46.19] (10.169.46.19) by kwepemm600011.china.huawei.com
 (7.193.23.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Jul
 2022 18:01:24 +0800
Subject: Re: [PATCH] nvme-apple: use nvme core helper to cancel requests in
 tagset
To: Guixin Liu <kanie@linux.alibaba.com>, <marcan@marcan.st>,
	<sven@svenpeter.dev>, <alyssa@rosenzweig.io>, <kbusch@kernel.org>,
	<axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>, <p.zabel@pengutronix.de>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-nvme@lists.infradead.org>
References: <1657249565-89708-1-git-send-email-kanie@linux.alibaba.com>
From: liruozhu <liruozhu@huawei.com>
Message-ID: <94a30444-f397-036b-3913-739f13171c21@huawei.com>
Date: Fri, 8 Jul 2022 18:01:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <1657249565-89708-1-git-send-email-kanie@linux.alibaba.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600011.china.huawei.com (7.193.23.229)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220708_030133_309778_FA1E4F28 
X-CRM114-Status: GOOD (  11.60  )
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

On 2022/7/8 11:06, Guixin Liu wrote:

> Use nvme core helper nvme_cancel_tagset and nvme_cancel_admin_tagset
> instead of same logic code.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/host/apple.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index d702d7d..7816b5a 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -845,11 +845,8 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
>   	apple_nvme_handle_cq(&anv->adminq, true);
>   	spin_unlock_irqrestore(&anv->lock, flags);
>   
> -	blk_mq_tagset_busy_iter(&anv->tagset, nvme_cancel_request, &anv->ctrl);
> -	blk_mq_tagset_busy_iter(&anv->admin_tagset, nvme_cancel_request,
> -				&anv->ctrl);
> -	blk_mq_tagset_wait_completed_request(&anv->tagset);
> -	blk_mq_tagset_wait_completed_request(&anv->admin_tagset);
> +	nvme_cancel_tagset(&anv->ctrl);
> +	nvme_cancel_admin_tagset(&anv->ctrl);
>   
>   	/*
>   	 * The driver will not be starting up queues again if shutting down so
Looks good to me,

Reviewed-by: Ruozhu Li <liruozhu@huawei.com>

