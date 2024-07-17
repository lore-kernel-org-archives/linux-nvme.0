Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CA4C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 23:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oB2a2SllLAwtI5Pb8o7rvTOM/lYPEb9fucZNuBoleq4=; b=U+W57iYgvSenASmTy4z2/YRORb
	Q7o7i/nEqaMawL5+BPRbz/W6qSg12qTIDc7lvDeckfgyChs5A2eACkBZxqobZlfDbIkf1Wwn47ZNK
	nRtO/NzNDRHHIruGvke7E0nSXIEbKhgyJLvJUEBpdLNITyeuHe5uwRXSUbHyLEyMcOA+8yh1hhwA+
	wW94D/WZLkqmBL3SodhESzqiIc8SuR2ZopUQVmAHJEuy1Q2Ii5vx1kCGT3+nHBOpfQYR31REbo2KD
	pYTTPGv5/1AfbwZ+TbFi47i2bOJJW4J2lgBd/CRXwoG3jXALC69vuJXaG/Wh7QL9CFMzReCs3cMPb
	5B36uMJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUDdZ-0000000FAWm-2143;
	Wed, 17 Jul 2024 23:00:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCaf-0000000F1wc-05yu
	for linux-nvme@bombadil.infradead.org;
	Wed, 17 Jul 2024 21:53:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=oB2a2SllLAwtI5Pb8o7rvTOM/lYPEb9fucZNuBoleq4=; b=bhno4auD3QHinnCCUNiZgJ5pR+
	DvNam7Okb2yb7/HujihvFvway+NGEzw+Y/q8A+qH4NeH5f3NElyY1K6HtIOAuBrkqb6TM7jvhTdFJ
	klqgvOJq4ScYXnqs4IBrU9++fDolg0sxDCJUfai2nvofcR4dvDmHBOJtIASfjrz24u9i0A44IbBMs
	YS1Md+a66OTsNDEA5ZKqIyW5zNQHwPuXUM/ns30IUAeppJWPSNFUqB0399pE9NU5gBmrG+Qs4JrT5
	C1A07pgrUBMtE1mL4zpISRr+QBhj+G8LDOGPnwox/nEQGFJzAzPeLvGwT4dl6KGzX+xx3rWuoIZnO
	IH2m5fUg==;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCab-00000002Pm1-3LRG
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 21:53:35 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-427bc3877d0so239185e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 14:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721253211; x=1721858011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oB2a2SllLAwtI5Pb8o7rvTOM/lYPEb9fucZNuBoleq4=;
        b=mdfUTEIovCnTzi8PbwVxyjW2tFPadp2TNU+W2nCTshu2yHhgliPypwQdOlJ0r3TwTB
         pxRqNx3qRiA6ebRIhVq47UF6fc6yUvGckEYSR5qzlm1RQ1BOp1SVLpR6/obXYPvVGsNl
         qjVe1uzCjp0gFRKSoHh1v3CJN1uX7lgYAxVGnGp4UXps/9SkWYkrG25xPSZEP99qef4M
         sLwzFTevpLAnBCN1crq+e5rZ6D754JTSbH/tQ1U9Hl3xEfUxm/08bgDhtBLYkaKlHanz
         mR//7CYiLFBQApvijurCYnLcGARfHWjcqartUTJTq99pVwOo9+Whz+eH9P2rRp4r3i9D
         Xqlg==
X-Forwarded-Encrypted: i=1; AJvYcCVtKROOe2YU2mEDXgnAm1BOVcpQPzGaNFcmmKP865dhzYqVKgS2PbJE9U8Fa5MkRbegKmb7vqfC5BwtLIBlgGQySddxzQMkP/RgxtOAwr8=
X-Gm-Message-State: AOJu0YzXtGz7l89Gfd3NRLvemsVEtrKL1Vsd2wX4ocHyNY+efjrkmy84
	aeTvyIPDF7Nup2Mj7UNl8MSOtfDB43QIl4EPyowScyoCo6FWhA4vgIt9qg==
X-Google-Smtp-Source: AGHT+IHes3m/YPX344oz2L14ZNSOrs7UWzFLJrpbrj+bIm3I2L9dlzHaw3JcKlcHR5/1oBaLwvoqTQ==
X-Received: by 2002:a05:6000:4020:b0:364:8215:7142 with SMTP id ffacd0b85a97d-368315e8055mr905100f8f.1.1721253210623;
        Wed, 17 Jul 2024 14:53:30 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3ed9sm12793028f8f.9.2024.07.17.14.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:53:30 -0700 (PDT)
Message-ID: <715ffc48-cd34-4776-a51a-e1199b8d0435@grimberg.me>
Date: Thu, 18 Jul 2024 00:53:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] nvme-tcp: sanitize TLS key handling
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <20240717091031.143188-3-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091031.143188-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_225334_030039_73EB2BDF 
X-CRM114-Status: GOOD (  21.17  )
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



On 17/07/2024 12:10, Hannes Reinecke wrote:
> There is a difference between TLS configured (ie the user has
> provisioned/requested a key) and TLS enabled (ie the connection
> is encrypted with TLS). This becomes important for secure concatenation,
> where the initial authentication is run unencrypted (ie with
> TLS configured, but not enabled), and then the queue is reset to
> run over TLS (ie TLS configured _and_ enabled).
> So to differentiate between those two states store the provisioned
> key in opts->tls_key (as we're using the same TLS key for all queues)
> and only the key serial of the key negotiated by the TLS handshake
> in queue->tls_pskid.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/core.c  |  1 -
>   drivers/nvme/host/nvme.h  |  2 +-
>   drivers/nvme/host/sysfs.c |  4 ++--
>   drivers/nvme/host/tcp.c   | 47 ++++++++++++++++++++++++++++-----------
>   4 files changed, 37 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 8d8e7a3549c6..947f1e631ee5 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4641,7 +4641,6 @@ static void nvme_free_ctrl(struct device *dev)
>   
>   	if (!subsys || ctrl->instance != subsys->instance)
>   		ida_free(&nvme_instance_ida, ctrl->instance);
> -	key_put(ctrl->tls_key);
>   	nvme_free_cels(ctrl);
>   	nvme_mpath_uninit(ctrl);
>   	cleanup_srcu_struct(&ctrl->srcu);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index c63f2b452369..cdb53323f4eb 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -370,7 +370,7 @@ struct nvme_ctrl {
>   	struct nvme_dhchap_key *ctrl_key;
>   	u16 transaction;
>   #endif
> -	struct key *tls_key;
> +	key_serial_t tls_pskid;
>   
>   	/* Power saving configuration */
>   	u64 ps_max_latency_us;
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 3c55f7edd181..5b1dee8a66ef 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -671,9 +671,9 @@ static ssize_t tls_key_show(struct device *dev,
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

I swear I'll ask this every single time that I don't understand it. Why 
is this per-queue and
not per controller?

