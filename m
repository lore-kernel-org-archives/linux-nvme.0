Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAA4CED266
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 05:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tBu7iuSRwkmPb4x9xzqUm9cf72tyLMrswFQWtDkuSKg=; b=0p5N2zl0aFgCbKYX73rwDVQE1f
	5gDLRFxGglbVUkPMw4YKWZVM7X7Gcd7195HOvwACpFLmlWMhxZbdLAtysc8KxXdWSIv1QOThAYQOU
	4xE6xqUca1gmDFGEemIfHIsis/Hgc+SkIKSalfrPYoelG2Q+HSLrK/gvgcPRXUa6/ybhlbysmZaLP
	dSEeQf1RLV5nhxSkW4+Xq+5n9P/48uL7kvwthXDvSctaYsCWSErVjFbBR437qZWBjOXrthcrFyFV6
	zNvxrANf2gNNqo2NxlKsVaxj8zsp1d6SYyRrX4h1CXJ60nLmTb0OyybGYErY7KAct0S4OlivtzKy0
	xG15vDBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy2cu-00000004Xhw-3tnk;
	Tue, 08 Oct 2024 05:19:16 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy2co-00000004XgH-0wmA
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 05:19:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 09E3A5C5DAB;
	Tue,  8 Oct 2024 05:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01636C4CEC7;
	Tue,  8 Oct 2024 05:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728364749;
	bh=75u2mTcvM6+7bxOhq6TQdjDXrpx2NtH+NBqHh9xAS7U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BonMUsWemZSoG+0BzuzOrdf3AMTa01M2UVwslST/nnARRlEKC0L1GE1OEt3K0v1lr
	 0ph6cJol/JKqWTBRVcKPL6tmyCXIkrez7/5qrmWboy9zLotcx77J+QviPRkX0DsYUT
	 y0GvzjPYYBAxS+UOapjiZwbpPEuePsrb5pSR3/1xIqxMW1SZf7HA06GxGKvM2aIw1x
	 cQg5HU2+lKP3f3QKe0rzHdl/1IsRoGFQOPrkhCltotDkeLiavqd2UFtF3qGHQiSZLW
	 k7gESnIRfqepx3PmUUa3nK2nk827sF2r8wg+AMtXwlt8b5CTxUiFbeKe03OSDLO3wk
	 0/7BB1O+HJy7Q==
Message-ID: <4e159735-7703-4f39-b98e-25c21824506c@kernel.org>
Date: Tue, 8 Oct 2024 14:19:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nvme: use helper nvme_ctrl_state in
 nvme_keep_alive_finish function
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
 chaitanyak@nvidia.com, gjoyce@linux.ibm.com
References: <20241008041436.1073281-1-nilay@linux.ibm.com>
 <20241008041436.1073281-4-nilay@linux.ibm.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241008041436.1073281-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_221910_343920_7F417E71 
X-CRM114-Status: GOOD (  15.60  )
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

On 10/8/24 13:13, Nilay Shroff wrote:
> We no more need acquiring ctrl->lock for accessing the NVMe controller
> state and instead we can now use the helper nvme_ctrl_state. So replace
> the ctrl->lock from nvme_keep_alive_finish function with nvme_ctrl_state
> call.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  drivers/nvme/host/core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 736adbf65ef5..5a690cf16e5e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1296,10 +1296,10 @@ static void nvme_keep_alive_finish(struct request *rq,
>  				blk_status_t status,
>  				struct nvme_ctrl *ctrl)
>  {
> -	unsigned long flags;
>  	bool startka = false;
>  	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
>  	unsigned long delay = nvme_keep_alive_work_period(ctrl);
> +	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
>  
>  	/*
>  	 * Subtract off the keepalive RTT so nvme_keep_alive_work runs
> @@ -1322,11 +1322,8 @@ static void nvme_keep_alive_finish(struct request *rq,
>  
>  	ctrl->ka_last_check_time = jiffies;
>  	ctrl->comp_seen = false;
> -	spin_lock_irqsave(&ctrl->lock, flags);
> -	if (ctrl->state == NVME_CTRL_LIVE ||
> -	    ctrl->state == NVME_CTRL_CONNECTING)
> +	if (state == NVME_CTRL_LIVE || state == NVME_CTRL_CONNECTING)
>  		startka = true;

	startka = state == NVME_CTRL_LIVE || state == NVME_CTRL_CONNECTING;

But do you even need that variable now ? The below "if (startka)" could be
replaced with "if (state == NVME_CTRL_LIVE || state == NVME_CTRL_CONNECTING)", no ?

> -	spin_unlock_irqrestore(&ctrl->lock, flags);
>  	if (startka)
>  		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
>  }


-- 
Damien Le Moal
Western Digital Research

