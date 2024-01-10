Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AE3C4707C
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jan 2024 16:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c1vOkHNh98Rjr6tnyhGCdvbi+xua5GJGrn0Z4bVNhlU=; b=effb/xJYjX/cxbyJbPc5KIenyC
	8srFbJGiTXlN8NhFc+Qr7KRlsPHv4EyKYcYJ6ldDrzRVMpHlD15WPcMGv5dtHgAJbjQOChkGjS4ej
	K+AKZugmv7K0EEQJRNEKfHody/lYyucT2wkXmIwUtY7O4HTjKUjHKeX4nePTTKZ3eY4mTNYfCC3kH
	TGAy7YYcuFXiuU92ctiLEhwCqNV39g8nbhdLpBkr+jbaQz6/nekVAkwN172RJaasqzre81xcCVvNK
	2E3TjKpAFuj6qbr/+0ERxmNsuVavk9hSWArU04q+J4t6k5aCImykOzaWf9LRGyAFwZK/cb8hSbBQT
	Lpdy6aBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNb1j-00Cl5T-2V;
	Wed, 10 Jan 2024 16:01:59 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNb1h-00Cl26-0E
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jan 2024 16:01:58 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3367f8757d0so443466f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 10 Jan 2024 08:01:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704902515; x=1705507315;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c1vOkHNh98Rjr6tnyhGCdvbi+xua5GJGrn0Z4bVNhlU=;
        b=qq2XMX3ho1r9CXQXPLtulG5UZMkjoXOIwDv98wc54KgkTDYt3UvjNETJbcXCmEQqur
         IgHpWZ6VZGvDmiQR74BXdci/kch1zmJKym09gkMvvEpnisYtILauNQcM2MCD5AQS8F05
         09hwUozHw+nPhUUBTxrE2K67zNZGG2U2KNhaUoAheTfofvP6zOrl4iqFvzykWhUaAe9f
         p4t90XmouWsJ4cSSu0aGTpHp8bo6UhL228y/i7/Vv/Wfa2vhVPaF7f4ylu7jPuodIG+7
         Z5XIFcZ6QG0WOur6hfiZ0/LjUOUmErSiftgpizwEhhDMwtI/Zc4A9f51OX2kTgFvcWqX
         x3Rw==
X-Gm-Message-State: AOJu0YxNL82Nf51iXbeXTUJSldgmkuNgUel8KTlRAwOScUXcmAOcuYIA
	08sG4k9gkI1ZXEvktlNp6YiyM6nxyOk=
X-Google-Smtp-Source: AGHT+IEFa0ye+uF7IJgam5SCh2K9DoNA+o3Nj2eQ/iN4V29rQmqUmFOvWhNwPe8zmm5j+ni4ndayrA==
X-Received: by 2002:a5d:46c9:0:b0:337:39c6:a911 with SMTP id g9-20020a5d46c9000000b0033739c6a911mr1445386wrs.2.1704902515420;
        Wed, 10 Jan 2024 08:01:55 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h16-20020a05600004d000b003367ff4aadasm5212422wri.31.2024.01.10.08.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 08:01:55 -0800 (PST)
Message-ID: <f9e315d1-5876-49da-870b-a073c911df28@grimberg.me>
Date: Wed, 10 Jan 2024 18:01:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 08/20] nvme-tcp: Deal with netdevice DOWN events
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, yorayz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20231221213358.105704-1-aaptel@nvidia.com>
 <20231221213358.105704-9-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231221213358.105704-9-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240110_080157_111713_F545A4F0 
X-CRM114-Status: GOOD (  30.73  )
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



On 12/21/23 23:33, Aurelien Aptel wrote:
> From: Or Gerlitz <ogerlitz@nvidia.com>
> 
> For ddp setup/teardown and resync, the offloading logic
> uses HW resources at the NIC driver such as SQ and CQ.
> 
> These resources are destroyed when the netdevice does down
> and hence we must stop using them before the NIC driver
> destroys them.
> 
> Use netdevice notifier for that matter -- offloaded connections
> are stopped before the stack continues to call the NIC driver
> close ndo.
> 
> We use the existing recovery flow which has the advantage
> of resuming the offload once the connection is re-set.
> 
> This also buys us proper handling for the UNREGISTER event
> b/c our offloading starts in the UP state, and down is always
> there between up to unregister.
> 
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/tcp.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 6eed24b5f90c..00cb1c8404c4 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -235,6 +235,7 @@ struct nvme_tcp_ctrl {
>   
>   static LIST_HEAD(nvme_tcp_ctrl_list);
>   static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
> +static struct notifier_block nvme_tcp_netdevice_nb;
>   static struct workqueue_struct *nvme_tcp_wq;
>   static const struct blk_mq_ops nvme_tcp_mq_ops;
>   static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
> @@ -3193,6 +3194,32 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
>   	return ERR_PTR(ret);
>   }
>   
> +static int nvme_tcp_netdev_event(struct notifier_block *this,
> +				 unsigned long event, void *ptr)
> +{
> +#ifdef CONFIG_ULP_DDP
> +	struct net_device *ndev = netdev_notifier_info_to_dev(ptr);
> +	struct nvme_tcp_ctrl *ctrl;
> +
> +	switch (event) {
> +	case NETDEV_GOING_DOWN:
> +		mutex_lock(&nvme_tcp_ctrl_mutex);
> +		list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
> +			if (ndev == ctrl->ddp_netdev)
> +				nvme_tcp_error_recovery(&ctrl->ctrl);
> +		}
> +		mutex_unlock(&nvme_tcp_ctrl_mutex);
> +		flush_workqueue(nvme_reset_wq);
> +		/*
> +		 * The associated controllers teardown has completed,
> +		 * ddp contexts were also torn down so we should be
> +		 * safe to continue...
> +		 */
> +	}

Will this handler ever react to another type of event? because
if not, maybe its better to just have:

	if (event != NETDEV_GOING_DOWN)
		return NOTIFY_DONE;

	...

> +#endif
> +	return NOTIFY_DONE;
> +}
> +
>   static struct nvmf_transport_ops nvme_tcp_transport = {
>   	.name		= "tcp",
>   	.module		= THIS_MODULE,
> @@ -3208,6 +3235,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
>   
>   static int __init nvme_tcp_init_module(void)
>   {
> +	int ret;
> +
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_hdr) != 8);
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_cmd_pdu) != 72);
>   	BUILD_BUG_ON(sizeof(struct nvme_tcp_data_pdu) != 24);
> @@ -3222,8 +3251,19 @@ static int __init nvme_tcp_init_module(void)
>   	if (!nvme_tcp_wq)
>   		return -ENOMEM;
>   
> +	nvme_tcp_netdevice_nb.notifier_call = nvme_tcp_netdev_event;
> +	ret = register_netdevice_notifier(&nvme_tcp_netdevice_nb);
> +	if (ret) {
> +		pr_err("failed to register netdev notifier\n");
> +		goto out_free_workqueue;
> +	}
> +
>   	nvmf_register_transport(&nvme_tcp_transport);
>   	return 0;
> +
> +out_free_workqueue:
> +	destroy_workqueue(nvme_tcp_wq);
> +	return ret;
>   }
>   
>   static void __exit nvme_tcp_cleanup_module(void)
> @@ -3231,6 +3271,7 @@ static void __exit nvme_tcp_cleanup_module(void)
>   	struct nvme_tcp_ctrl *ctrl;
>   
>   	nvmf_unregister_transport(&nvme_tcp_transport);
> +	unregister_netdevice_notifier(&nvme_tcp_netdevice_nb);
>   
>   	mutex_lock(&nvme_tcp_ctrl_mutex);
>   	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)

