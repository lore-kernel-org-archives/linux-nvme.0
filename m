Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70C9C001B0
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 14:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hypwtTapfC1qAMNrEPsN+b2bz7xO+GFxnp+ydEGm8Ho=; b=Co/JRl5Lnqj0LaiUbBjd5E+MRp
	g+F5blRpGt9mqHNW21XNez+Bs59e7yf4IG+SgyFB9FeIoPN0JaA7G5kfv4cpRS/SIa/ct1iGUu0gF
	GideIC0UW3g6CN9Nmd2C50QHjuxIqMKCILDcnTlF/6XM9gvaDA7FKTDH0cWSz7Ub5wRVdIrr6qikr
	1jYhpmBRncmtXpDDXwEPsGNjTk1sB2UglMXe0y17XaMedbYP9sZkiQPI4JQUN9+4IqPTMgVXkVvob
	P/TmtiGk+jWZJG9K5jHSIA6eAWX9pieB78kQqSwLLAE5XwJIdjp/DWlXgcqyZegAKcZpSliRY+whu
	DhXQPbxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVCDS-00FFAQ-2R;
	Sun, 13 Aug 2023 14:37:14 +0000
Received: from mail-lj1-f172.google.com ([209.85.208.172])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVCDP-00FF9u-2P
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 14:37:13 +0000
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b9b458b441so7203361fa.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 07:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691937429; x=1692542229;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hypwtTapfC1qAMNrEPsN+b2bz7xO+GFxnp+ydEGm8Ho=;
        b=WSpBw/KdmY+zW3D38XQn0J6tN0wWkR8ZZPRFziPhsVxk5awdKevxY2q4aPBjAPFF0s
         hJszW4aiNtpEjAZ5mN825jZhMMlvDb0RZJVsAWrWf22kO37TuIxYks2urbzQ4k4nIYE9
         cTLD5h46YWlbRsb4ENXa0SnXoSyYQ6gXpD6Q1JN97+ksC5o4J+ZvflrnA9EbKppnNLnA
         8meRLuzXO7K+DEZvKZLp5bxNNqKDVrz/eCgP6WAwbUz9BUQnPjiiiImDLI7pPv1/lOoK
         +Ht5XMPvjekfSxnFpA4gMtrj9dhslfFukIYkGq0rlyMxkbQwZB6Qo3ultOx71rpwci04
         KFfQ==
X-Gm-Message-State: AOJu0YzIPdFvhctkjtaZQ/8+ZjEhwyplV2cQbasSCf5YeU7aF+PlBgjZ
	FW6ZU/z3RkvXYo8S+6e7oAy2tbTb/xk=
X-Google-Smtp-Source: AGHT+IHraw8TrMSVQAIM+IZT7TAlCgjQ+MeHnpIkFSwqUE5zdfKJ+IDIQwXDTU6Szf4xzPYukLgnqg==
X-Received: by 2002:a05:651c:1c6:b0:2bb:7710:1cea with SMTP id d6-20020a05651c01c600b002bb77101ceamr154981ljn.0.1691937429393;
        Sun, 13 Aug 2023 07:37:09 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id w4-20020a1709064a0400b0099cce6f7d50sm4655835eju.64.2023.08.13.07.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 07:37:08 -0700 (PDT)
Message-ID: <28894fc3-2d62-4a48-c538-ee83ec768309@grimberg.me>
Date: Sun, 13 Aug 2023 17:37:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15.y] nvme-tcp: fix potential unbalanced freeze &
 unfreeze
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: stable@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
References: <2023081226-oak-cartoon-6115@gregkh>
 <20230813143106.12390-1-sagi@grimberg.me>
In-Reply-To: <20230813143106.12390-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_073711_783916_E431E5C1 
X-CRM114-Status: GOOD (  20.18  )
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

Sorry Greg...

disregard these patches...
Thought that if they apply 6.1.y it would go further...

I'll just send a fresh series for each stable kernel.

On 8/13/23 17:31, Sagi Grimberg wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> Move start_freeze into nvme_tcp_configure_io_queues(), and there is
> at least two benefits:
> 
> 1) fix unbalanced freeze and unfreeze, since re-connection work may
> fail or be broken by removal
> 
> 2) IO during error recovery can be failfast quickly because nvme fabrics
> unquiesces queues after teardown.
> 
> One side-effect is that !mpath request may timeout during connecting
> because of queue topo change, but that looks not one big deal:
> 
> 1) same problem exists with current code base
> 
> 2) compared with !mpath, mpath use case is dominant
> 
> Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/tcp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 1dc7c733c7e3..8d67cdd844f5 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1884,6 +1884,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   		goto out_cleanup_connect_q;
>   
>   	if (!new) {
> +		nvme_start_freeze(ctrl);
>   		nvme_start_queues(ctrl);
>   		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
>   			/*
> @@ -1892,6 +1893,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   			 * to be safe.
>   			 */
>   			ret = -ENODEV;
> +			nvme_unfreeze(ctrl);
>   			goto out_wait_freeze_timed_out;
>   		}
>   		blk_mq_update_nr_hw_queues(ctrl->tagset,
> @@ -1996,7 +1998,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
>   	if (ctrl->queue_count <= 1)
>   		return;
>   	nvme_stop_admin_queue(ctrl);
> -	nvme_start_freeze(ctrl);
>   	nvme_stop_queues(ctrl);
>   	nvme_sync_io_queues(ctrl);
>   	nvme_tcp_stop_io_queues(ctrl);

