Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C79C77B7A
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 13:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nRRH/7qrI/7OWN7DpTOtqhA0hU7prBpMWIgwS0148uI=; b=c1tcnW64DXarlJwGiB+gPdvv4B
	FGBG/7qWsW6xN51dUclzdTqEXPPI2JzxUk8kWeLvzOUXSbo/93rtxFO1HHNGXUmGRkPYWTb7bCCYL
	MdKqTd9066VJ4pQtTKFSxkvOS5Fz7bfX4F9ig9GYkHh7AbhlNcafECtCzwrMR2zQXL+7jcR2rPbEy
	ZDC30gfhbRwJNlxw51cuOgpEfe5zEmGoFVCOIwauCG5FD7/9N4WemOA4IpM3d4l7YcdUMhrZW0rql
	hObljx0dzAW+uDe79al23TGeNxfiyR4Fn7VtPcqq9cOB7KGJcVy4Bgx2mKo+Z9hfHOjYDSI+0ZY/F
	CVjoIQbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q93qK-00894z-2r;
	Tue, 13 Jun 2023 13:13:52 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q93qG-00893y-24
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 13:13:50 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-30a9df84328so600272f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Jun 2023 06:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686662026; x=1689254026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRRH/7qrI/7OWN7DpTOtqhA0hU7prBpMWIgwS0148uI=;
        b=caJYcdPIWgNNvnwlpVHmy90r5+ao19fNuE5mjJCyClUbgtZFJ2rEd3J97luZgWoJ4x
         dT4TkUf8GxR0ZKFWxMbhEH48k9e3nSGNOgQKtaf2v199f2fEPYqFP7yFex0PuCX1XAup
         7qTFpiVmRe+bhYogRY18DnXL2y+nbRfWqbB2A1TSjW+CGD4Fa6ByqJTYcxuXduA5Lxob
         Fp5sRhdOkV3q5MA18Cf7t9YgJAlK4PHbbvzdBBVBjwV6USoxkddy4cHZvccoHdc2+h/8
         fxo+8Y+0ns/wOoemPYaMTV307On8489vYriJNwW04Mk4EhLd7gufhaLhMkifNYsYmABO
         bZNQ==
X-Gm-Message-State: AC+VfDz5xs9OYxewD7jJRn+KKW+R5OPV26IR4+tq2CKDJatfmqWs45Lp
	iSTRoUktL2l+wUdkWpVKvnQ=
X-Google-Smtp-Source: ACHHUZ4WW8RLcs2lEf3XEC2buKDAOUJz0NPjJNQcqOASRUn/sdaHy3S6nhmBhDbYlpgPh9SoTrWvMQ==
X-Received: by 2002:a5d:4e07:0:b0:30e:4af6:87fb with SMTP id p7-20020a5d4e07000000b0030e4af687fbmr9081799wrt.3.1686662025568;
        Tue, 13 Jun 2023 06:13:45 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb03000000b0030ab5ebefa8sm15262032wrr.46.2023.06.13.06.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 06:13:44 -0700 (PDT)
Message-ID: <c850f479-36b9-3478-6400-95faea095467@grimberg.me>
Date: Tue, 13 Jun 2023 16:13:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] nvme: don't freeze/unfreeze queues from different
 contexts
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
 Chunguang Xu <brookxu.cn@gmail.com>
References: <20230613005847.1762378-1-ming.lei@redhat.com>
 <20230613005847.1762378-3-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230613005847.1762378-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_061348_703195_B9ADA2DB 
X-CRM114-Status: GOOD (  32.61  )
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


> For block layer freeze/unfreeze APIs, the caller is required to call the
> two in strict pair, so most of users simply call them from same context,
> and everything works just fine.
> 
> For NVMe, the two are done from different contexts, this way has caused
> all kinds of IO hang issue, such as:
> 
> 1) When io queue connect fails, this controller is deleted without being
> marked as DEAD. Upper layer may wait forever in __bio_queue_enter(), because
> in del_gendisk(), disk won't be marked as DEAD unless bdev sync & invalidate
> returns. If any writeback IO waits in __bio_queue_enter(), IO deadlock is
> caused. Reported from Yi Zhang.
> 
> 2) error recovering vs. namespace deletiong, if any IO originated from
> scan work is waited in __bio_queue_enter(), flushing scan work hangs for
> ever in nvme_remove_namespaces() because controller is left as frozen
> when error recovery is interrupted by controller removal. Reported from
> Chunguang.
> 
> Fix the issue by calling the two in same context just when reset is done
> and not starting freeze from beginning of error recovery. Not only IO hang
> is solved, correctness of freeze & unfreeze is respected.
> 
> And this way is correct because quiesce is enough for driver to handle
> error recovery. The only difference is where to wait during error recovery.
> With this way, IO is just queued in block layer queue instead of
> __bio_queue_enter(), finally waiting for completion is done in upper
> layer. Either way, IO can't move on during error recovery.
> 
> Reported-by: Chunguang Xu <brookxu.cn@gmail.com>
> Closes: https://lore.kernel.org/linux-nvme/cover.1685350577.git.chunguang.xu@shopee.com/
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/core.c | 4 +---
>   drivers/nvme/host/pci.c  | 8 +++++---
>   drivers/nvme/host/rdma.c | 3 ++-
>   drivers/nvme/host/tcp.c  | 3 ++-
>   4 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4ef5eaecaa75..d5d9b6f6ec74 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4707,10 +4707,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>   	 * removing the namespaces' disks; fail all the queues now to avoid
>   	 * potentially having to clean up the failed sync later.
>   	 */
> -	if (ctrl->state == NVME_CTRL_DEAD) {
> +	if (ctrl->state == NVME_CTRL_DEAD)
>   		nvme_mark_namespaces_dead(ctrl);
> -		nvme_unquiesce_io_queues(ctrl);
> -	}

Shouldn't this be in the next patch? Not sure what
this helps in this patch? It is not clearly documented
in the commit msg.

>   
>   	/* this is a no-op when called from the controller reset handler */
>   	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 492f319ebdf3..5d775b76baca 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2578,14 +2578,15 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>   	dead = nvme_pci_ctrl_is_dead(dev);
>   	if (dev->ctrl.state == NVME_CTRL_LIVE ||
>   	    dev->ctrl.state == NVME_CTRL_RESETTING) {
> -		if (pci_is_enabled(pdev))
> -			nvme_start_freeze(&dev->ctrl);
>   		/*
>   		 * Give the controller a chance to complete all entered requests
>   		 * if doing a safe shutdown.
>   		 */
> -		if (!dead && shutdown)
> +		if (!dead && shutdown & pci_is_enabled(pdev)) {
> +			nvme_start_freeze(&dev->ctrl);
>   			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
> +			nvme_unfreeze(&dev->ctrl);
> +		}

I'd split out the pci portion, it is not related to the reported issue,
and it is structured differently than the fabrics transports (as for now
at least).

>   	}
>   
>   	nvme_quiesce_io_queues(&dev->ctrl);
> @@ -2740,6 +2741,7 @@ static void nvme_reset_work(struct work_struct *work)
>   	 * controller around but remove all namespaces.
>   	 */
>   	if (dev->online_queues > 1) {
> +		nvme_start_freeze(&dev->ctrl);
>   		nvme_unquiesce_io_queues(&dev->ctrl);
>   		nvme_wait_freeze(&dev->ctrl);
>   		nvme_pci_update_nr_queues(dev);
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 0eb79696fb73..354cce8853c1 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -918,6 +918,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>   		goto out_cleanup_tagset;
>   
>   	if (!new) {
> +		nvme_start_freeze(&ctrl->ctrl);
>   		nvme_unquiesce_io_queues(&ctrl->ctrl);
>   		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
>   			/*
> @@ -926,6 +927,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>   			 * to be safe.
>   			 */
>   			ret = -ENODEV;
> +			nvme_unfreeze(&ctrl->ctrl);

What does this unfreeze designed to do?

