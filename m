Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6355AC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 13:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JKojxPlDMMLq/R5KbOnWiU0CR1Dux2GzEEVHTEbFsDI=; b=TKA9yif2aIIXru2b9C3ddIJ8HX
	SmmGUPu/Ayg09RH4ULfqqmWsO8upyWmgxDIze6OlGae445gExVvOjCszP7+NVI2RqLz2bgNIjKybV
	C5dnSkCmNSSThxAvUJuAcwhWctvW0Ga0B0aWLMqNrTosOZYvcKnFCbtASNIsh/EHAAgPJKypGF6ZM
	TU+X3PvVQdZiyxRYEHslghR/12rDoh4/idrg2tYKdUe3B2U5cHj6XeYCuK8ZZdc8HMIRJMtNW4RW1
	+GpRE/Nlc9OFT48m9J6PLMzlJDnsW2gZz4Cu5y7TmrolJ6WqgssHVaCtibYOTPay1Vs7yNCYL0/Rq
	xWcP6pNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olVq5-00Feiz-96; Thu, 20 Oct 2022 13:44:01 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olVd6-00FTz5-H7
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 13:30:38 +0000
Received: by mail-wm1-f53.google.com with SMTP id 186-20020a1c02c3000000b003c6c154d528so2325281wmc.4
        for <linux-nvme@lists.infradead.org>; Thu, 20 Oct 2022 06:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JKojxPlDMMLq/R5KbOnWiU0CR1Dux2GzEEVHTEbFsDI=;
        b=LHg5WgTdr6Mv5uWyopq8dnpqfoPTbhMshbCknqNGovXYChqDjM0tM4Re9Lk8q/HLKm
         5Qjdc8L54y85Te5GKFD8hZIsRF6I/dsGinji1O10FTCw8sswZJ2cfxugt8VbgIRvacKj
         OLfiSAo2ir3Y4jjAyadfWqZqPzAvl6keeE6rbQ5zkF4V9bRhyHjCIKcw37CAsxIZjGWS
         1j0rGgBzrtbWkWLqyAslM1v0NCmZ2TBt2CzNn+IQdmTNYafHnyaHmt9NSN0qP7pGrvoI
         Kzk61E6SnvdNQVe3h6FhVcLctaZV1ljEV3xMcTMoMWt6geAlxWC0vh8mCtPflzmAdMgF
         em9w==
X-Gm-Message-State: ACrzQf3/QXuH4/spB5pEyFa1c2205qK+QiO9bYqlwRvzXwg3dXl1dpOE
	7a+0+wMXF1AgUBqmH7JTlKYcNylvIps=
X-Google-Smtp-Source: AMsMyM6WgG5OBBMTp6bmksHwmHjgE0Cb6tSezWSfJVyn7oUXB0ls76DBvacNRiFuxGK2xfmQU22zYA==
X-Received: by 2002:a05:600c:4588:b0:3c6:f8b2:dd34 with SMTP id r8-20020a05600c458800b003c6f8b2dd34mr13615571wmo.178.1666272623338;
        Thu, 20 Oct 2022 06:30:23 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j16-20020adfea50000000b00228d6bc8450sm19557838wrn.108.2022.10.20.06.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:30:22 -0700 (PDT)
Message-ID: <ac33021a-b7a1-37cf-b156-df021ac4de43@grimberg.me>
Date: Thu, 20 Oct 2022 16:30:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 6/8] nvme: move the NS_DEAD flag to the controller
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221020105608.1581940-1-hch@lst.de>
 <20221020105608.1581940-7-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020105608.1581940-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_063036_619828_F421B8A6 
X-CRM114-Status: GOOD (  24.29  )
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



On 10/20/22 13:56, Christoph Hellwig wrote:
> The NVME_NS_DEAD flag is only set in nvme_set_queue_dying, which is
> called in a loop over all namespaces in nvme_kill_queues.  Switch it
> to a controller flag checked and set outside said loop.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 16 +++++++---------
>   drivers/nvme/host/nvme.h |  2 +-
>   2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a74212a4f1a5f..fa7fdb744979c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4330,7 +4330,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
>   {
>   	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
>   
> -	if (test_bit(NVME_NS_DEAD, &ns->flags))
> +	if (test_bit(NVME_CTRL_NS_DEAD, &ns->ctrl->flags))
>   		goto out;
>   
>   	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
> @@ -4404,7 +4404,8 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>   
>   	down_write(&ctrl->namespaces_rwsem);
>   	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> -		if (ns->head->ns_id > nsid || test_bit(NVME_NS_DEAD, &ns->flags))
> +		if (ns->head->ns_id > nsid ||
> +		    test_bit(NVME_CTRL_NS_DEAD, &ns->ctrl->flags))
>   			list_move_tail(&ns->list, &rm_list);
>   	}
>   	up_write(&ctrl->namespaces_rwsem);
> @@ -5110,9 +5111,6 @@ static void nvme_stop_ns_queue(struct nvme_ns *ns)
>    */
>   static void nvme_set_queue_dying(struct nvme_ns *ns)
>   {
> -	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
> -		return;
> -
>   	blk_mark_disk_dead(ns->disk);
>   	nvme_start_ns_queue(ns);
>   }
> @@ -5129,14 +5127,14 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>   	struct nvme_ns *ns;
>   
>   	down_read(&ctrl->namespaces_rwsem);
> -
>   	/* Forcibly unquiesce queues to avoid blocking dispatch */
>   	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
>   		nvme_start_admin_queue(ctrl);
>   
> -	list_for_each_entry(ns, &ctrl->namespaces, list)
> -		nvme_set_queue_dying(ns);
> -
> +	if (!test_and_set_bit(NVME_CTRL_NS_DEAD, &ctrl->flags)) {
> +		list_for_each_entry(ns, &ctrl->namespaces, list)
> +			nvme_set_queue_dying(ns);
> +	}

Looking at it now, I'm not sure I understand the need for this flag. It
seems to make nvme_kill_queues reentrant safe, but the admin queue
unquiesce can still end up unbalanced under reentrance?

How is this not broken today (or ever since quiesce/unquiesce started
accounting)? Maybe I lost some context on the exact subtlety of how
nvme-pci uses this interface...

>   	up_read(&ctrl->namespaces_rwsem);
>   }
>   EXPORT_SYMBOL_GPL(nvme_kill_queues);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a29877217ee65..82989a3322130 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -237,6 +237,7 @@ enum nvme_ctrl_flags {
>   	NVME_CTRL_FAILFAST_EXPIRED	= 0,
>   	NVME_CTRL_ADMIN_Q_STOPPED	= 1,
>   	NVME_CTRL_STARTED_ONCE		= 2,
> +	NVME_CTRL_NS_DEAD     		= 3,
>   };
>   
>   struct nvme_ctrl {
> @@ -483,7 +484,6 @@ struct nvme_ns {
>   	unsigned long features;
>   	unsigned long flags;
>   #define NVME_NS_REMOVING	0
> -#define NVME_NS_DEAD     	1
>   #define NVME_NS_ANA_PENDING	2
>   #define NVME_NS_FORCE_RO	3
>   #define NVME_NS_READY		4

