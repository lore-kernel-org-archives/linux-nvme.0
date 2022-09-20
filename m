Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6801C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 08:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TLI4w9g1s84i6IHF+ymcxJa+MDSzy6Li40azMD1IRiI=; b=V3BTBPzdRFxcU4jUoGj9zEiaNv
	BLI9IxcBP5ggvxbnZX+8nJToFyqgLNF7MRvLmnOH132HGvSWC05iYZmE+3I22vGmKptQQ0BjJZ5EN
	IAcAD0pHiIm2ak/JDMSNOxbxqDF6SnHmucnCWWe+FW3oSIxahVMA4JoAvMGXyaljmCS4NUOqmod9i
	WyErjbOX9+K0bD48eF9WE27SDGnciypHVy/4MAu3/H60cnQEqGICs4FeKZ6/Vlmu1ibIcGqaOqpRk
	ALHnmQMyf8giHxbV/OmOADvIyYs8bAnU+fILJ4JqBZ+VkMXR+jvw4EN8+SzGKQrDTyngbRxan/Iye
	wKG5zCgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaYSn-001j9P-Sy; Tue, 20 Sep 2022 08:18:41 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaYSk-001j4G-0r
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 08:18:39 +0000
Received: by mail-wm1-f44.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso1108497wmr.3
        for <linux-nvme@lists.infradead.org>; Tue, 20 Sep 2022 01:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TLI4w9g1s84i6IHF+ymcxJa+MDSzy6Li40azMD1IRiI=;
        b=k41hCHMjYBhSJkQh30jRW44/C1jeLTV4S87TYBFlMcVmQcKXDNHexQyz+PrBT1tEY+
         mMu4U4Bzo2z6Nvi2Cv9+OG2FXSBLLwjzoF4+h7VbCMdzW6uu5h1+4leXf476GYDyC8kw
         QjkyHs/+vSWF8fCX6tnN9sV5pJPcHtZRoIc/aYevRvWFmvwcL7JcQAtEbg6raVbxhKas
         LUZpNQizeG1pGxg0mGifjbGkhlVrfj/meIzhWI2aCAyGwynhJvltKIk0TIONth5nOerq
         5hjbxCITyzzGxFx8gze6swVDvSf2AKO7xdjOLDDWOBoTWg/lFLE2zbeeI6C/LjjhvGfb
         pqNQ==
X-Gm-Message-State: ACrzQf2M0l7O5+wv72r+kbCLykBUTPxi20oCyay8/PViUsSjj0JIDDjC
	HImuwX/3O60xjjJWC8Ac0O0=
X-Google-Smtp-Source: AMsMyM5oUcLo9DGzM8t+1U20VYXfwBLhCY/8K1pcvQ+8gmoTp4v/o/W/19yRh6UTs3OjRMcLRz3dHg==
X-Received: by 2002:a7b:c051:0:b0:3a6:36fc:8429 with SMTP id u17-20020a7bc051000000b003a636fc8429mr1390715wmc.78.1663661915474;
        Tue, 20 Sep 2022 01:18:35 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id x10-20020a5d444a000000b0022af63bb6f2sm843221wrr.113.2022.09.20.01.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:18:34 -0700 (PDT)
Message-ID: <c04a263f-31cb-0cb8-c2f0-a3d318093b6c@grimberg.me>
Date: Tue, 20 Sep 2022 11:18:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme: don't wait freeze during resetting
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>
References: <20220920015719.1840164-1-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920015719.1840164-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_011838_106262_DBF3118D 
X-CRM114-Status: GOOD (  29.26  )
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


> First it isn't necessary to call nvme_wait_freeze during reset.
> For nvme-pci, if tagset isn't allocated, there can't be any inflight
> IOs; otherwise blk_mq_update_nr_hw_queues can freeze & wait queues.
> 
> Second, since commit bdd6316094e0 ("block: Allow unfreezing of a queue
> while requests are in progress"), it is fine to unfreeze queue without
> draining inflight IOs.
> 
> Also both nvme-rdma and nvme-tcp's timeout handler provides forward
> progress if the controller state isn't LIVE, so it is fine to drop
> the timeout function of nvme_wait_freeze_timeout().

The rdma/tcp should probably be split to separate patches.

> 
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chao Leng <lengchao@huawei.com>
> Cc: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/apple.c |  1 -
>   drivers/nvme/host/pci.c   |  1 -
>   drivers/nvme/host/rdma.c  | 13 -------------
>   drivers/nvme/host/tcp.c   | 13 -------------
>   4 files changed, 28 deletions(-)
> 
> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
> index 5fc5ea196b40..9cd02b57fc85 100644
> --- a/drivers/nvme/host/apple.c
> +++ b/drivers/nvme/host/apple.c
> @@ -1126,7 +1126,6 @@ static void apple_nvme_reset_work(struct work_struct *work)
>   	anv->ctrl.queue_count = nr_io_queues + 1;
>   
>   	nvme_start_queues(&anv->ctrl);
> -	nvme_wait_freeze(&anv->ctrl);
>   	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
>   	nvme_unfreeze(&anv->ctrl);
>   
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 98864b853eef..985b216907fc 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2910,7 +2910,6 @@ static void nvme_reset_work(struct work_struct *work)
>   		nvme_free_tagset(dev);
>   	} else {
>   		nvme_start_queues(&dev->ctrl);
> -		nvme_wait_freeze(&dev->ctrl);
>   		if (!dev->ctrl.tagset)
>   			nvme_pci_alloc_tag_set(dev);
>   		else
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 3100643be299..beb0d1a6a84d 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -986,15 +986,6 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>   
>   	if (!new) {
>   		nvme_start_queues(&ctrl->ctrl);
> -		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
> -			/*
> -			 * If we timed out waiting for freeze we are likely to
> -			 * be stuck.  Fail the controller initialization just
> -			 * to be safe.
> -			 */
> -			ret = -ENODEV;
> -			goto out_wait_freeze_timed_out;
> -		}

So here is the description from the patch that introduced this:
--
nvme-rdma: fix reset hang if controller died in the middle of a reset

If the controller becomes unresponsive in the middle of a reset, we
will hang because we are waiting for the freeze to complete, but that
cannot happen since we have commands that are inflight holding the
q_usage_counter, and we can't blindly fail requests that times out.

So give a timeout and if we cannot wait for queue freeze before
unfreezing, fail and have the error handling take care how to
proceed (either schedule a reconnect of remove the controller).
--

So if between nvme_start_queues() and the freeze (with a full wait)
that is done in blk_mq_update_nr_hw_queues() the controller becomes
non responsive, in this case we may hang blocking on I/O that was
pending and requeued after nvme_start_queues().

The problem is, that we cannot do any error recovery because the
controller is in the middle of a reset/reconnect...
So the code that you deleted was designed to detect this state, and
reschedule another reconnect if the controller became non responsive.

What is preventing this from happening now?

I wish we had a test for this... It is very difficult to hit because the
controller needs to become non-responsive exactly at this point in the
reset...

>   		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
>   			ctrl->ctrl.queue_count - 1);
>   		nvme_unfreeze(&ctrl->ctrl);
> @@ -1002,10 +993,6 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>   
>   	return 0;
>   
> -out_wait_freeze_timed_out:
> -	nvme_stop_queues(&ctrl->ctrl);
> -	nvme_sync_io_queues(&ctrl->ctrl);
> -	nvme_rdma_stop_io_queues(ctrl);
>   out_cleanup_connect_q:
>   	nvme_cancel_tagset(&ctrl->ctrl);
>   	if (new)
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index d5871fd6f769..49d9bef806f9 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1920,15 +1920,6 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   
>   	if (!new) {
>   		nvme_start_queues(ctrl);
> -		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
> -			/*
> -			 * If we timed out waiting for freeze we are likely to
> -			 * be stuck.  Fail the controller initialization just
> -			 * to be safe.
> -			 */
> -			ret = -ENODEV;
> -			goto out_wait_freeze_timed_out;
> -		}
>   		blk_mq_update_nr_hw_queues(ctrl->tagset,
>   			ctrl->queue_count - 1);
>   		nvme_unfreeze(ctrl);
> @@ -1936,10 +1927,6 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   
>   	return 0;
>   
> -out_wait_freeze_timed_out:
> -	nvme_stop_queues(ctrl);
> -	nvme_sync_io_queues(ctrl);
> -	nvme_tcp_stop_io_queues(ctrl);
>   out_cleanup_connect_q:
>   	nvme_cancel_tagset(ctrl);
>   	if (new)

