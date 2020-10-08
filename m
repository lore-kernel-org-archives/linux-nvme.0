Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6C2C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 22:47:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20DC22247
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 22:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zLJOEH6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20DC22247
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=E2EZyWialoYbjpp80FJsZVg1R7naeHdO3ZrCWoc43fs=; b=zLJOEH6V9UozNAVHtXQqCRebX
	jH52UoR/yA6MkUVSptwE9r7OUvssR0Dg3Fe8fQuU/GxD+RYIbyQaRcLdSWUYGAidApTjiqtWB6o7d
	YkMLf8bHmB6jJvtH10viPSosO3STB8kdgltErMw4QwwD26ad8PiGeoX1+R8j862k+ee2SNis+PgcX
	1wr8CZWPkF6Xn2f6njd8lo06NJUi15UYpCsDNslUXxuWnHPDfPcaOckYPwEYnUnsoBVPlBI+qk/9v
	WvLW5MgDvmsxLsiYvWTRG6PSryfdd6o6fvkvd9HY5Bl3/eKu4VMt0or8hZq5j9KCEZ+fE3utTojk+
	hNTTtnuoA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQehP-0004MU-GI; Thu, 08 Oct 2020 22:47:47 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQehN-0004M8-8G
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 22:47:45 +0000
Received: by mail-wm1-f67.google.com with SMTP id e2so8037319wme.1
 for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2020 15:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=myET8DqnZqvbDgPBngwcFUQxMHa6/4RcZksUikkSMe8=;
 b=scEKKMrW+AKFNuyKvlLUXUa3L8cyDB6ROPzB3mYDq6tAO2RooJtDb9ZDhrlTbriBr/
 CEJgtLLs+Aj7gQKNPcdyPOcmsfImxObwJiB7GjfBsGDVIkvlQ+wZcp5L0VBy0es8Bv7P
 T4XqpuXgXBg4rCXlXyxRBX6UcavqP5S/317MWc6tutaWNz7NWldFT5DPsp7KB1oU1fY6
 fW284pttOFq2GEIFlIBN7510J0z+wvEHxEyXZkwIHusigWco8OrasNpwpt3gqDcFCFGC
 ilF7MJqMJKZOB1PKfl/yFkjqorzXfW7tPM6om2pAayiGNw1oGVeUwd4p3LmUqQXcKSf8
 zZig==
X-Gm-Message-State: AOAM533f8n9Nadm2knGCMltLezwSMpCX/IlMxH1i9ZxnePzKecfx3UJo
 8tC9dpD3mYO4YF8ek3s2LfoceHsuVaw=
X-Google-Smtp-Source: ABdhPJyT43XB0vMUH89OAuDnOhzflLVRD7yxBGR62gVIcWU1MGydvxwjPXNofkMxxcCcVaoBH0gnBw==
X-Received: by 2002:a7b:c935:: with SMTP id h21mr10377582wml.99.1602197263796; 
 Thu, 08 Oct 2020 15:47:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:68d6:3fd5:5a8b:9959?
 ([2601:647:4802:9070:68d6:3fd5:5a8b:9959])
 by smtp.gmail.com with ESMTPSA id q20sm8805434wmc.39.2020.10.08.15.47.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 15:47:43 -0700 (PDT)
Subject: Re: [PATCH net-next RFC v1 08/10] nvme-tcp: Deal with netdevice DOWN
 events
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-9-borisp@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <67e29f83-5bab-4abd-44c0-9c5ae29d5784@grimberg.me>
Date: Thu, 8 Oct 2020 15:47:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930162010.21610-9-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_184745_311572_9E0DE97F 
X-CRM114-Status: GOOD (  32.50  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Yoray Zack <yorayz@mellanox.com>, Ben Ben-Ishay <benishay@mellanox.com>,
 boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 9/30/20 9:20 AM, Boris Pismenny wrote:
> From: Or Gerlitz <ogerlitz@mellanox.com>
> 
> For ddp setup/teardown and resync, the offloading logic
> uses HW resources at the NIC driver such as SQ and CQ.
> 
> These resources are destroyed when the netdevice does down
> and hence we must stop using them before the NIC driver
> destroyes them.
> 
> Use netdevice notifier for that matter -- offloaded connections
> are stopped before the stack continues to call the NIC driver
> close ndo.
> 
> We use the existing recovery flow which has the advantage
> of resuming the offload once the connection is re-set.
> 
> Since the recovery flow runs in a separate/dedicated WQ
> we need to wait in the notifier code for an ACK that all
> offloaded queues were stopped which means that the teardown
> queue offload ndo was called and the NIC doesn't have any
> resources related to that connection any more.
> 
> This also buys us proper handling for the UNREGISTER event
> b/c our offloading starts in the UP state, and down is always
> there between up to unregister.
> 
> Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
> Signed-off-by: Boris Pismenny <borisp@mellanox.com>
> Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
> Signed-off-by: Yoray Zack <yorayz@mellanox.com>
> ---
>   drivers/nvme/host/tcp.c | 39 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 9a620d1dacb4..7569b47f0414 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -144,6 +144,7 @@ struct nvme_tcp_ctrl {
>   
>   static LIST_HEAD(nvme_tcp_ctrl_list);
>   static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
> +static struct notifier_block nvme_tcp_netdevice_nb;
>   static struct workqueue_struct *nvme_tcp_wq;
>   static const struct blk_mq_ops nvme_tcp_mq_ops;
>   static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
> @@ -412,8 +413,6 @@ int nvme_tcp_offload_limits(struct nvme_tcp_queue *queue,
>   		queue->ctrl->ctrl.max_segments = limits->max_ddp_sgl_len;
>   		queue->ctrl->ctrl.max_hw_sectors =
>   			limits->max_ddp_sgl_len << (ilog2(SZ_4K) - 9);
> -	} else {
> -		queue->ctrl->offloading_netdev = NULL;

Squash this change to the patch that introduced it.

>   	}
>   
>   	dev_put(netdev);
> @@ -1992,6 +1991,8 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   {
>   	int ret;
>   
> +	to_tcp_ctrl(ctrl)->offloading_netdev = NULL;
> +
>   	ret = nvme_tcp_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
>   	if (ret)
>   		return ret;
> @@ -2885,6 +2886,26 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>   	return ERR_PTR(ret);
>   }
>   
> +static int nvme_tcp_netdev_event(struct notifier_block *this,
> +				 unsigned long event, void *ptr)
> +{
> +	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
> +	struct nvme_tcp_ctrl *ctrl;
> +
> +	switch (event) {
> +	case NETDEV_GOING_DOWN:
> +		mutex_lock(&nvme_tcp_ctrl_mutex);
> +		list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
> +			if (ndev != ctrl->offloading_netdev)
> +				continue;
> +			nvme_tcp_error_recovery(&ctrl->ctrl);
> +		}
> +		mutex_unlock(&nvme_tcp_ctrl_mutex);
> +		flush_workqueue(nvme_reset_wq);

Worth a small comment that this we want the err_work to complete
here. So if someone changes workqueues he may see this.

> +	}
> +	return NOTIFY_DONE;
> +}
> +
>   static struct nvmf_transport_ops nvme_tcp_transport = {
>   	.name		= "tcp",
>   	.module		= THIS_MODULE,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
