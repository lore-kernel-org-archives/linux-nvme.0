Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC2EC3DA61
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Jul 2024 11:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BDtDSDrKxRR9nVqHo74OJblYxExeekISKrC8or/l14k=; b=1Jfsg+d795jb2lMJyjoANQtNij
	2a4WZfZvvz5pcESRL8pjUvsHlz85WB0sdtCLfOPkLenHnaWn//KHOdJmhF8ZQK1lWcr6nrO2akt3+
	+PBy7renZA848bHjqMrHY9U1gL5yt1EgDXmmijBgtI9FKHAXAO6dZkvGQqP08nneUb7UY15fxrpxo
	FJG5GpGaz7isknAgbgTFoQ2kfdfd1VCBCi+iir0Rxpaxu6/04smx446HsVT6N+H7l0OUonKk+8xle
	ksvD//OAXBetD3eltctaOr3yl2V1Pa9BGdRz/lk1TvKwH0cqUansJ+FR3wO8TW9hzXvZ2PErYotUn
	42wllM7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVUWt-00000006hnd-1lCc;
	Sun, 21 Jul 2024 11:15:03 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVUWq-00000006hms-1hFY
	for linux-nvme@lists.infradead.org;
	Sun, 21 Jul 2024 11:15:01 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-426744ca29bso2994875e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 21 Jul 2024 04:15:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721560499; x=1722165299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BDtDSDrKxRR9nVqHo74OJblYxExeekISKrC8or/l14k=;
        b=nCmyFXePMbh7ZVYpgV2GVyZ0SbZFtmdKwHhNOOARMm69OwtyBIHLtEbU84bXY0QVBM
         BLgu587iqj7Jb9hzWY3nI5jNLGDJHmzKqIDAs2csEHaJMfirmAltbO/uRzrJZ50XGGvF
         AIxgC9DVVpJcIb3jK7KsOAG+0BUTe0MxRJQOaM5q92HEla06mDL1wSA/LGpGPC0xpABn
         /aSXy+RtWWrHbrXVg1f91KanQc58MRbwnCb8CmRoB1vmQYROqPRGeikRyOujMxuLVAEU
         zwE5zCedh5RMn+Xv69SeWOmNiV/96zbinCVqkeemxinWCA+gEXB9stiUdDBzAIStrcm4
         UUVA==
X-Forwarded-Encrypted: i=1; AJvYcCUPC6McuOsuOtRcuPGkJb1ldnJjvV4KwYnT5ZEusZAKyDnZQrQkE++3WiIz6ZMsTOBPWRgsycHbhC0cISH0pDsOBk+UWyNjOrrK+jIjW9s=
X-Gm-Message-State: AOJu0YzWLNE3yHDoKzUtgp8DdFURc5Lfd3vGQ6aM0dULKj/sRuR7JBjd
	QMDklofOqLm9ypSnWxeFhYrJxZ+CwD13jInnzMbep+oJM00TWJ42gsSnPw==
X-Google-Smtp-Source: AGHT+IGiMkQRBdI2vwAFnqa1AmMobET7C5zlGaAMs4Ce5ypRgJ5sjDBn3z2cx0vBsAvV8vuU0O4xVA==
X-Received: by 2002:a05:600c:35c3:b0:426:5f08:542b with SMTP id 5b1f17b1804b1-427da99aedbmr21546425e9.0.1721560498725;
        Sun, 21 Jul 2024 04:14:58 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a94380sm114585765e9.39.2024.07.21.04.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 04:14:58 -0700 (PDT)
Message-ID: <e8ddc060-f35a-4b3a-b09c-7c3168026d13@grimberg.me>
Date: Sun, 21 Jul 2024 14:14:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] nvme-tcp: sanitize TLS key handling
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240719083901.35399-1-hare@kernel.org>
 <20240719083901.35399-3-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240719083901.35399-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_041500_481183_07052786 
X-CRM114-Status: GOOD (  23.42  )
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




On 19/07/2024 11:38, Hannes Reinecke wrote:
> There is a difference between TLS configured (ie the user has
> provisioned/requested a key) and TLS enabled (ie the connection
> is encrypted with TLS). This becomes important for secure concatenation,
> where the initial authentication is run on an unencrypted connection
> (ie with TLS configured, but not enabled), and then the queue is reset to
> run over TLS (ie TLS configured _and_ enabled).
> So to differentiate between those two states store the generated
> key in opts->tls_key (as we're using the same TLS key for all queues),
> the key serial of the resulting TLS handshake in ctrl->tls_pskid
> (to signal that TLS on the admin queue is enabled), and a simple
> flag for the queues to indicated that TLS has been enabled.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c  |  1 -
>   drivers/nvme/host/nvme.h  |  2 +-
>   drivers/nvme/host/sysfs.c |  4 ++--
>   drivers/nvme/host/tcp.c   | 47 ++++++++++++++++++++++++++++-----------
>   4 files changed, 37 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e78ef31eeef0..663fa14162ab 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4675,7 +4675,6 @@ static void nvme_free_ctrl(struct device *dev)
>   
>   	if (!subsys || ctrl->instance != subsys->instance)
>   		ida_free(&nvme_instance_ida, ctrl->instance);
> -	key_put(ctrl->tls_key);
>   	nvme_free_cels(ctrl);
>   	nvme_mpath_uninit(ctrl);
>   	cleanup_srcu_struct(&ctrl->srcu);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9ac587e64166..185fb986a5cc 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -373,7 +373,7 @@ struct nvme_ctrl {
>   	struct nvme_dhchap_key *ctrl_key;
>   	u16 transaction;
>   #endif
> -	struct key *tls_key;
> +	key_serial_t tls_pskid;
>   
>   	/* Power saving configuration */
>   	u64 ps_max_latency_us;
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index ba05faaac562..72675b59a7a7 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -670,9 +670,9 @@ static ssize_t tls_key_show(struct device *dev,
>   {
>   	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>   
> -	if (!ctrl->tls_key)
> +	if (!ctrl->tls_pskid)
>   		return 0;
> -	return sysfs_emit(buf, "%08x", key_serial(ctrl->tls_key));
> +	return sysfs_emit(buf, "%08x", ctrl->tls_pskid);
>   }
>   static DEVICE_ATTR_RO(tls_key);
>   #endif
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index a2a47d3ab99f..92ad5b8cc1b4 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -165,6 +165,7 @@ struct nvme_tcp_queue {
>   
>   	bool			hdr_digest;
>   	bool			data_digest;
> +	bool			tls_enabled;
>   	struct ahash_request	*rcv_hash;
>   	struct ahash_request	*snd_hash;
>   	__le32			exp_ddgst;
> @@ -213,7 +214,15 @@ static inline int nvme_tcp_queue_id(struct nvme_tcp_queue *queue)
>   	return queue - queue->ctrl->queues;
>   }
>   
> -static inline bool nvme_tcp_tls(struct nvme_ctrl *ctrl)
> +static inline bool nvme_tcp_tls_enabled(struct nvme_tcp_queue *queue)
> +{
> +	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS))
> +		return 0;
> +
> +	return queue->tls_enabled;
> +}

One suggestion.

Can we call it:
nvme_tcp_queue_tls() ? It will first clarify that this is a queue level 
setting,
and will disambiguate (at least for me) the difference from 
nvme_tcp_tls_configured().

