Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCAAD3A661
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 15:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eK6DNp+8i73kWhmqDGEIA550Siwjw9z95CtAlsJPyo0=; b=MZ6pjvX9SBNyTwZ2EvnzapWTDI
	rqe5tXZDde5y55H4zi2WkSjsXsxmlPomdkaotzUiHO/YCi/VmtNv7oIYYU452U8NG1xMgzZAyn7Sl
	Q4xV4PTQQnpR4i0CErNjGwdvqt+saD60AkjpZxmXyPTSQCzwlpajMyO8Mxs3upVepjvlMxr9ngswY
	VCmVQ66kjauXb61xq4d7ZMnI9OOe+jZJTUldQOIs//eZl49Jv7nLYIIVu/ORvRLbvjVDQmeTlaFjD
	uNBHcjVmEr0ovV7vbBBmKsFbeF8oR8Fw5Y/CnltTWNt0iHTVU4pyB47I7I4gAIPojFuZcv9d96l7O
	50bvfl4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5nnm-0000000EpD8-0aU4;
	Tue, 29 Oct 2024 15:06:34 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5njH-0000000Eo2W-1oLQ
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 15:01:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D4D265C5C6C;
	Tue, 29 Oct 2024 15:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA27EC4CECD;
	Tue, 29 Oct 2024 15:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730214114;
	bh=mGNkVrCOJFDBJDBZAxK15cqt0WEp/ybrcHWkqytziDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YXBw/8Np0pq8/8ZvJS8I5H/K3ds/z/JNnHlc9fMFO61iIwvDJZYb5j5XkKhBpZjw4
	 RWrj7uruehRwEfsaWLWJTKzbZzmLU3ZbVrtZCfCBwzxZBfz/lTBI+oKVRsDC/LYIsm
	 TkBpcuzlBq7f7fOQRU9rN2XTVxeqhqCYc2Gjoh/k0IamETEm0AgQEesdyTrZjBEVvx
	 ufcbcGeNyj+wICTCTJ+xLkoM2wrIpU9zfZMFX/NGIvapmeYMJB6xOEp2ZSDJctF705
	 l0+pFwKgCSuDgxlyaSk2OeT/Mj248F9LWJmkHG5Frj6Htg8C50O/ps1xeOBfXLHd8t
	 N2REjCiqI7BCg==
Date: Tue, 29 Oct 2024 09:01:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	axboe@fb.com, chaitanyak@nvidia.com, dlemoal@kernel.org,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH 3/3] nvme: use helper nvme_ctrl_state in
 nvme_keep_alive_end_io function
Message-ID: <ZyD433W-caGMfVsv@kbusch-mbp>
References: <20241027170209.440776-1-nilay@linux.ibm.com>
 <20241027170209.440776-4-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027170209.440776-4-nilay@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_080155_533332_BDDFE71E 
X-CRM114-Status: GOOD (  16.60  )
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

On Sun, Oct 27, 2024 at 10:32:06PM +0530, Nilay Shroff wrote:
> We no more need acquiring ctrl->lock before accessing the
> NVMe controller state and instead we can now use the helper
> nvme_ctrl_state. So replace the use of ctrl->lock from
> nvme_keep_alive_end_io function with nvme_ctrl_state call.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  drivers/nvme/host/core.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 865c00ea19e3..6e814daf1002 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1296,10 +1296,9 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>  						 blk_status_t status)
>  {
>  	struct nvme_ctrl *ctrl = rq->end_io_data;
> -	unsigned long flags;
> -	bool startka = false;
>  	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
>  	unsigned long delay = nvme_keep_alive_work_period(ctrl);
> +	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl->state);
>  
>  	/*
>  	 * Subtract off the keepalive RTT so nvme_keep_alive_work runs
> @@ -1324,13 +1323,9 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>  
>  	ctrl->ka_last_check_time = jiffies;
>  	ctrl->comp_seen = false;
> -	spin_lock_irqsave(&ctrl->lock, flags);
> -	if (ctrl->state == NVME_CTRL_LIVE ||
> -	    ctrl->state == NVME_CTRL_CONNECTING)
> -		startka = true;
> -	spin_unlock_irqrestore(&ctrl->lock, flags);
> -	if (startka)
> +	if (state == NVME_CTRL_LIVE || state == NVME_CTRL_CONNECTING)
>  		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
> +
>  	return RQ_END_IO_NONE;
>  }

This restores what you had in the reverted patch, which was a
significant portion of the diff stat. If we're keeping this chunk, maybe
a full revert isn't necessary, and we can squash the series to just one
fixing commit.

