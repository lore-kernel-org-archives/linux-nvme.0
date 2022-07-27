Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234C4C04A68
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gZqJobVGeLnh3Mw2+8fZvQrpyCk4JE27kumfTsYdPP0=; b=iDBL+89mY48MlXwmCI1sm8Yow6
	JSzma2A9sU6LvxYrOHRLbmVpsk7up2/ryeMjHxT+LE2ZracXdGbwffGBz24cLDa/p6Q/coeOG3Y97
	PYXfKuzlKtt3kO63p7NUIK7QqrFJVQK8lJsoU9gwRMdBP6AzAAgUGMvVnOpiB02A5sq1VjXjktXBB
	vS6wmtwgT8w0/aTBzrP2X+E40PzeoE38CNf1hyt6HtEsX8Rl7IDfKsFhqY5+MIVSxjm1FT22E+Nf8
	JdNMf9lBZdQvZ3kElPFeKhN1g7Xx+6kT/zbfCaABIC4qBk5WsjVTUg3q/yUNy8DeQ8BEjysgqK56D
	kREn7JtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGkOS-00FrDW-5W; Wed, 27 Jul 2022 17:00:20 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGkOP-00Fr8Q-08
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 17:00:18 +0000
Received: by mail-pg1-x52f.google.com with SMTP id r186so16425850pgr.2
        for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 10:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gZqJobVGeLnh3Mw2+8fZvQrpyCk4JE27kumfTsYdPP0=;
        b=T3XapnIzudr6DmfdQi6E7DPXJYsOETt5h2Ggy5KVnJcqH+gIR5FlbQ+KPak93Iw2mw
         JXKXIs8Y3RxZjeOgPeHhJGNu3W3uZ1Oxa1im5YCXZj9Wy5RM2P31IWRwAa+Ko2T7kg0f
         V9q7gD/+NlMetThr2f3Nhtemuhm2hQZiXMULb59gs2W8p2B/eieMXBKuYs1iX4BiV4qW
         yUXcmtSceAynIUqhfLdRAhXlOaterafT0v8M/hAn7CHpGQWOna5KvJEiPjm7ppTNSG45
         lNIo+no8cWijSRyKbeufUMeKt9FDJB0dKB4HiVoMwrMHWKHOBntDCEVAv/IJYU4wwCOO
         zq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gZqJobVGeLnh3Mw2+8fZvQrpyCk4JE27kumfTsYdPP0=;
        b=2W7IzgbLZN5HbABIdO+eVWZM4SUVB2khOpjYKTSqkMGvE4dU1YclnGzTrvmRuveGAd
         6IWL4u8u2OiNdRi2gemw6NQcSHON5+1O1ZDHDjJJdTHqpEJWkvCEELmuaOIu9BMB46Td
         1bJsApMtudbsM5Bn1Wk33VuRTzEunLuGC3EFWu7IqZQ78A3c5zHvlEXVU56n8KFk5MnS
         0qcT0ng2w7wm1FTW2ERjvKivui7pVi5SWsu9AlgIa0jvwtvDmycGAeFfx2NL33qFCKpl
         xDo4zA3Hr2heAuAnneEYEWODviTxEJbbdzKIMQHLuO+OWA53mrSei68QIbtuU0byOVMs
         u0sg==
X-Gm-Message-State: AJIora9Gg8mQ37REMWYYkDFC9ECtIlCPJhCLwayhtODF4aFJMMJre3Qr
	CQuZW3SmsfnGt5Ngp15v+gg=
X-Google-Smtp-Source: AGRyM1sThZcVFkaeNgUvx4WGQ9DvdVGjHz04Ex1/lmZIraehBTPdIniyhKsx9nvVIBSmIgmGRUjEHA==
X-Received: by 2002:a63:5b5e:0:b0:41a:5e8f:b127 with SMTP id l30-20020a635b5e000000b0041a5e8fb127mr19069248pgm.104.1658941212316;
        Wed, 27 Jul 2022 10:00:12 -0700 (PDT)
Received: from [10.69.47.244] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y17-20020a63ce11000000b00419acadde52sm12256894pgf.46.2022.07.27.10.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 10:00:11 -0700 (PDT)
Message-ID: <a6a2ba1a-3da2-c586-4750-3e5f5efd73b8@gmail.com>
Date: Wed, 27 Jul 2022 10:00:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.1
Subject: Re: [PATCH] nvme-fc: restart admin queue if the caller needs to
 restart queue
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>, "Ewan D . Milne" <emilne@redhat.com>
References: <20220721003358.543509-1-ming.lei@redhat.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220721003358.543509-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_100017_076473_869A1E68 
X-CRM114-Status: GOOD (  13.74  )
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

On 7/20/2022 5:33 PM, Ming Lei wrote:
> Without restarting admin queue in __nvme_fc_abort_outstanding_ios(),
> it leaves controller not capable of handling admin pt request, and
> causes io hang.
> 
> Fixes it by restarting admin queue if the caller of __nvme_fc_abort_outstanding_ios
> requires to restart queue.
> 
> Tested-by: Ewan D. Milne <emilne@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/fc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 9987797620b6..8d14df8eeab8 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2533,6 +2533,8 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
>   	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>   				nvme_fc_terminate_exchange, &ctrl->ctrl);
>   	blk_mq_tagset_wait_completed_request(&ctrl->admin_tag_set);
> +	if (start_queues)
> +		nvme_start_admin_queue(&ctrl->ctrl);
>   }
>   
>   static void

Looks correct.

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james


