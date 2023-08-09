Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A00BC001B0
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 08:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q3sy719J1OdKMCl1tpcdWo2P4o7Y0NWOiudBzFSrvUs=; b=O/WJ/eJWFPfdboDm66xZi8XH8B
	nkUvlugGNfT2Fb3H2GcKm1B6lyMHYUpEHSfBDMcsXzUpCYN+v35K61R5yUsZ68bDOguwR7R53lFhZ
	ejev4lv1DC/FcMTKSGMs3YKa9nJmdWg8G3VYmr+3B4jKCGEfJXXOlkv63tmOKXB62+fEaAIgorIMU
	r2fuoQ85lUsGuJryMRDnTTtesU09AUOH2J9PU3OYj50a0KXYm+nmlbgzWDo2u0/1T6YqEfMGSO5Y8
	S1OfHmCXzxTPFhWg0nhQDTEbW5pBUtBZSOfX5oJMzS9zrcVNHxZ/7jEReNDMs5aKqP+hC8XXnO1el
	WXu6yXlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTe7I-004JgW-0G;
	Wed, 09 Aug 2023 08:00:28 +0000
Received: from mail-ej1-f47.google.com ([209.85.218.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTe7F-004JfV-0x
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 08:00:27 +0000
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-98273ae42d0so197587366b.0
        for <linux-nvme@lists.infradead.org>; Wed, 09 Aug 2023 01:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691568022; x=1692172822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3sy719J1OdKMCl1tpcdWo2P4o7Y0NWOiudBzFSrvUs=;
        b=ahi05PsHrhjmkKzQLcxNZv0VxJCyHgsm9H0mva77IdKtSLocXAvOOhPA4SkN0jKYX/
         KnoC8gRt3RsDCfcQYJPsFRbJ60p5tIKcLiNG2XE0y4t5+HYUByDwhWkXN9lfh9pxhYvt
         4l0a6ALK2RMTPVkEmkqCuDvgA4ParAyZ97SnMT1hsLnmobYwAZ9SXzv0R7yGbpUNnj2v
         fU5+h2B8whAhZaJC1+Q7HWeEQt8qLig9p7hdCoOfFyPEmKkGSToMnvS7DPIJSGSd4+0U
         W0yb1wGssxG6sxC6Q5t+k+Fag5Bcg8Pv+QsVmKLNqfUfPwU6tougrFmE055/TXtuT8cm
         WWIg==
X-Gm-Message-State: AOJu0YzFCbnsC42/XQ2ZCFk5oPKW0KbZdqbAp+wU4ZNOfbvdtH4tBkMj
	QmP2KYjCBl6/3X3QbV6Xptg=
X-Google-Smtp-Source: AGHT+IG00dZk5hezrxoS1oGLommC7BmAfwLMSx7C11sYJ98hNFag2T//DFpR2NTawUYpowPgfJ7oWw==
X-Received: by 2002:a17:906:2096:b0:99c:d995:22e8 with SMTP id 22-20020a170906209600b0099cd99522e8mr1229614ejq.7.1691568022095;
        Wed, 09 Aug 2023 01:00:22 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bh10-20020a170906a0ca00b0099bd86f9248sm7606086ejb.63.2023.08.09.01.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 01:00:21 -0700 (PDT)
Message-ID: <b94efb3f-8d37-c60c-5bf6-f87d41967da4@grimberg.me>
Date: Wed, 9 Aug 2023 11:00:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 10/26] nvme-tcp: Deal with netdevice DOWN events
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, yorayz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-11-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230712161513.134860-11-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_010025_330194_4603AEBA 
X-CRM114-Status: GOOD (  24.95  )
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



On 7/12/23 19:14, Aurelien Aptel wrote:
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
> ---
>   drivers/nvme/host/tcp.c | 39 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index df58668cbad6..e68e5da3df76 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -221,6 +221,7 @@ struct nvme_tcp_ctrl {
>   
>   static LIST_HEAD(nvme_tcp_ctrl_list);
>   static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
> +static struct notifier_block nvme_tcp_netdevice_nb;
>   static struct workqueue_struct *nvme_tcp_wq;
>   static const struct blk_mq_ops nvme_tcp_mq_ops;
>   static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
> @@ -3234,6 +3235,30 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
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
> +			if (ndev == ctrl->offloading_netdev)
> +				nvme_tcp_error_recovery(&ctrl->ctrl);
> +		}
> +		mutex_unlock(&nvme_tcp_ctrl_mutex);
> +		flush_workqueue(nvme_reset_wq);

In what context is this called? because every time we flush a workqueue,
lockdep finds another reason to complain about something...

Otherwise looks good,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

