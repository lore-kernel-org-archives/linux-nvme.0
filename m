Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96F5C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 11:50:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D97461247
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 11:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D97461247
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+msucEhKqo4yM6lk/niqGGIvKpVZ4G8VRC1GDMJayTE=; b=p1+UMzTCOtSBbW2Cho6BsGF12+
	/nWDy3lXVGbayOtUIC3RSzUtS7FZbB1Gxx+yog31XlLYzHw+PqMa0awZ+UaeUH7Rb3LxjZkbyRqOO
	DI0sLs+CwrZUnuD99NYyKy1ut56QTI/aNwQcTGO71OHbGypMAfqLiKfaFiileAtj+w+6OKOy745Wh
	M8P8DEAFFvkIG79JuplxuRbz2nMTysPdwZ5l+/qbrMMLfTCVpqMjsAOQ1bxssEHGroR9bk5UDvcKE
	Y0UcnhDc+kGnA6Rk6grmVUfFN1A08Vzti0gk8ytw5h0697DOd+dMfTv4CXPahER/TK2hkb2cJ3Iuq
	XRjtWlVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVY5p-00AssT-NP; Wed, 29 Sep 2021 11:49:45 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVY5m-00AsrV-Vx
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 11:49:44 +0000
Received: by mail-wr1-f49.google.com with SMTP id v17so3746040wrv.9
 for <linux-nvme@lists.infradead.org>; Wed, 29 Sep 2021 04:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kHpUmrPsKhrLx7UYZQumswVnpo8AVuQi6znyFKxVTeY=;
 b=gWwO6c4GB7x6VH5o531xxTGLLGtS2S+IV6KbtcpIpAyEUOpubSuuQECxzANG/j6KYj
 DRwU5u7EPhSu4dlgHFjaOVPWfm4MvFR2z9dSfu8rE+lYQhvluPFZq7BnL4zDbAQB8nZv
 P4GdvuhslzVcimgXtNjeEzTp0lb0pGUNhaNiHFSjsUG5penl6ENwqdKcItlFXQSDfQ1F
 cwRsiX85InxHHMr/9nyU51hqYUpqbW7i3GdVblIvyK97VnluGPM47Ec0SX816KHKcF/o
 xC7AxTtSIj+a2E6Runc8TqzfR57crdX2jJWj27Gy57tlDif74y8YPW4vwyKhS4mTHPDW
 sYjg==
X-Gm-Message-State: AOAM5300gTmKWuHrlC4dGPQvLkDc/JE9Un8KCG8uE2OcGRQI963CaWCR
 D7GvUWnBI2OKC9Bo5os728c=
X-Google-Smtp-Source: ABdhPJycJ2fUmnINyNlIcVFOzUgkS95yA8gAqePHal7+2fu522CVLQLPMpUBX5uMomd10e9BaXxBrw==
X-Received: by 2002:adf:ab5e:: with SMTP id r30mr1010897wrc.124.1632916181530; 
 Wed, 29 Sep 2021 04:49:41 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id t126sm1398862wma.4.2021.09.29.04.49.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Sep 2021 04:49:41 -0700 (PDT)
Subject: Re: [PATCH 4/5] nvme: paring quiesce/unquiesce
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
References: <20210929041559.701102-1-ming.lei@redhat.com>
 <20210929041559.701102-5-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <dc9152dd-afb3-5902-004f-84fa27cee9ca@grimberg.me>
Date: Wed, 29 Sep 2021 14:49:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210929041559.701102-5-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_044943_074854_21DA89CF 
X-CRM114-Status: GOOD (  26.92  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 9/29/21 7:15 AM, Ming Lei wrote:
> The current blk_mq_quiesce_queue() and blk_mq_unquiesce_queue() always
> stops and starts the queue unconditionally. And there can be concurrent
> quiesce/unquiesce coming from different unrelated code paths, so
> unquiesce may come unexpectedly and start queue too early.
> 
> Prepare for supporting nested / concurrent quiesce/unquiesce, so that we
> can address the above issue.
> 
> NVMe has very complicated quiesce/unquiesce use pattern, add one mutex
> and queue stopped state in nvme_ctrl, so that we can make sure that
> quiece/unquiesce is called in pair.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/core.c | 51 ++++++++++++++++++++++++++++++++++++----
>   drivers/nvme/host/nvme.h |  4 ++++
>   2 files changed, 50 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 23fb746a8970..5d0b2eb38e43 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4375,6 +4375,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
>   	spin_lock_init(&ctrl->lock);
>   	mutex_init(&ctrl->scan_lock);
> +	mutex_init(&ctrl->queues_stop_lock);
>   	INIT_LIST_HEAD(&ctrl->namespaces);
>   	xa_init(&ctrl->cels);
>   	init_rwsem(&ctrl->namespaces_rwsem);
> @@ -4450,14 +4451,44 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(nvme_init_ctrl);
>   
> +static void __nvme_stop_admin_queue(struct nvme_ctrl *ctrl)
> +{
> +	lockdep_assert_held(&ctrl->queues_stop_lock);
> +
> +	if (!ctrl->admin_queue_stopped) {
> +		blk_mq_quiesce_queue(ctrl->admin_q);
> +		ctrl->admin_queue_stopped = true;
> +	}
> +}
> +
> +static void __nvme_start_admin_queue(struct nvme_ctrl *ctrl)
> +{
> +	lockdep_assert_held(&ctrl->queues_stop_lock);
> +
> +	if (ctrl->admin_queue_stopped) {
> +		blk_mq_unquiesce_queue(ctrl->admin_q);
> +		ctrl->admin_queue_stopped = false;
> +	}
> +}

I'd make this a bit we can flip atomically.

> +
>   static void nvme_start_ns_queue(struct nvme_ns *ns)
>   {
> -	blk_mq_unquiesce_queue(ns->queue);
> +	lockdep_assert_held(&ns->ctrl->queues_stop_lock);
> +
> +	if (test_bit(NVME_NS_STOPPED, &ns->flags)) {
> +		blk_mq_unquiesce_queue(ns->queue);
> +		clear_bit(NVME_NS_STOPPED, &ns->flags);
> +	}
>   }
>   
>   static void nvme_stop_ns_queue(struct nvme_ns *ns)
>   {
> -	blk_mq_quiesce_queue(ns->queue);
> +	lockdep_assert_held(&ns->ctrl->queues_stop_lock);
> +
> +	if (!test_bit(NVME_NS_STOPPED, &ns->flags)) {
> +		blk_mq_quiesce_queue(ns->queue);
> +		set_bit(NVME_NS_STOPPED, &ns->flags);
> +	}
>   }

Why not use test_and_set_bit/test_and_clear_bit for serialization?

>   
>   /*
> @@ -4490,16 +4521,18 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>   {
>   	struct nvme_ns *ns;
>   
> +	mutex_lock(&ctrl->queues_stop_lock);
>   	down_read(&ctrl->namespaces_rwsem);
>   
>   	/* Forcibly unquiesce queues to avoid blocking dispatch */
>   	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
> -		nvme_start_admin_queue(ctrl);
> +		__nvme_start_admin_queue(ctrl);
>   
>   	list_for_each_entry(ns, &ctrl->namespaces, list)
>   		nvme_set_queue_dying(ns);
>   
>   	up_read(&ctrl->namespaces_rwsem);
> +	mutex_unlock(&ctrl->queues_stop_lock);

This extra lock wrapping the namespaces_rwsem is scary. The
ordering rules are not clear to me.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
