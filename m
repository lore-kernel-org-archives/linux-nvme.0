Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C3EC61DD9
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 21:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uuJOe3GXp1yLi6HGLhOGLcLd6ROOLjMJGjbmgFBkKj8=; b=F3u9mjWHNS/yj+pd5h4Z6onOGE
	3eelrOA4e3o5jYLPB5N63tGBIbSd/19tcqrOAae2/KqY297bDTFQwc2eu0KVIQq8wfno7dkbDANMa
	fXkMPYxxMgEQ6U2HxhR7LX/0TXOpci4zF6MER59FgDXrPHdw3UH1aYTXmgM52mPudr35qXN8C4RU+
	MqM/63skMurvQWej+BhQOmb6mSrzIHYesqS3/VWohFpiG10Phyk4IzkqnPOScZPfMsqmLN95iBCwm
	nR6aFP9i3UYLNN7CnZEh11VejBDL4sIjspL9mq/8kl39qFcfmmHpC301hpF5FZoBVC48mtnPCIeOX
	fwSWAppw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0nWB-000000089EF-1R23;
	Sun, 30 Aug 2026 21:56:47 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0nW8-000000089Dg-3vy6
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 21:56:45 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso37897645e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 14:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788127002; x=1788731802;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uuJOe3GXp1yLi6HGLhOGLcLd6ROOLjMJGjbmgFBkKj8=;
        b=A0pJZ6OLdteMCIKmZV/sc5JU1P7U3saoC0tft/MMqFH6NOH1tAZZhFfydS6y5mahC+
         x8BgBO8XehHl1eEipKh+xcdREN8Lg6hYKhyvwRLV0LA2kIO/okPZgnT1HM98rO1xL+IZ
         K7QWJWk58h5aFVN72UtdbpRyPHQfrgXGozbSwqOZydI45vnJ7np/9ZP3ljtos54aesIr
         T1Hc1O8YMIDcYAwmpfNwrFznY4d9SRKsMoLYik/2f53+amZhGZpwmg0hA4cxrlXYHbUs
         LR5AA8416AXVnMrmV7zP7oV/ImdIR/2MDtv4go8kq8dfn165Jygh1z+IYcHKuQQ2/NYt
         W3jA==
X-Gm-Message-State: AFuF++mPfVMOyzh6mkL9MAznE3ut6ohHHLFY/Mx3KqZjtSvB0AJ7C6Dy
	vJhOHm2cwj3FfGDLoCyZdM4B5cf/lpg1JQIBuYQ8A8F37BTIL7dUrhwu
X-Gm-Gg: AR+sD10kmxJAzPsWxJtoAOcOHvtemqqbEtyqQ1jSebg2ZUaay88bAwIGiwfd1U7TJyB
	0htXXpUANJ7Sl5njdc63XnJ7QCzr6F//G2sb7/KMBadiEW4a9dqwElUxXCUnywmmmtef0+yPWw8
	copklomarcM2GTGWm6ifGsJz4324vWBSKOrGPUwAKhwT5btfFMeaNIrtRprlk5weT8p+QPncLoZ
	vtuk60aXC9kh/YUE7y1LjCQWlBFbifolApBk00AXsTz1hdp0T7+OS1DRxFk2e7DKUcEiHKqjiak
	PNIIlJKOZT3xCTo728eHuQUoJOk8UAK4zBGt/Ms8ExerJxfF8jXCY0bhGcVlDAcJsYliP+1IhpG
	DFIkKX5t7Ea4Ldtk596AWE8Hw9+3qUdEO6mPes8Ky5DnWAedPVXGDkPlNv6KlMnQFrzr5uwN8hJ
	fyUxOqlhAT8iv6fzVuXyqtpFnub7bKaggC3FyP3Il3CNT5Re71uWsE3gOFo9PpFijJ6heMmLOWu
	HDicbSPvmOLDbAYVsghng==
X-Received: by 2002:a05:600c:c08b:b0:49b:9202:6f80 with SMTP id 5b1f17b1804b1-49b92027118mr290072615e9.6.1788127002421;
        Sun, 30 Aug 2026 14:56:42 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b94dd2517sm237392705e9.7.2026.08.30.14.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2026 14:56:40 -0700 (PDT)
Message-ID: <d55e8223-44cb-42e7-bb41-d659f206d573@grimberg.me>
Date: Mon, 31 Aug 2026 00:56:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nvme-tcp: refactor I/O queue setup path
To: Surabhi Gogte <sgogte@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 mkhalfella@purestorage.com, randyj@purestorage.com, adailey@purestorage.com
References: <20260824225648.316962-1-sgogte@purestorage.com>
 <20260824225648.316962-2-sgogte@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260824225648.316962-2-sgogte@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_145644_991308_1941BC03 
X-CRM114-Status: GOOD (  19.38  )
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



On 25/08/2026 1:56, Surabhi Gogte wrote:
> Split the I/O queue setup helpers apart so that the individual steps can
> be called directly from nvme_tcp_configure_io_queues():
>
> - Queue count negotiation moves out of nvme_tcp_alloc_io_queues() into a
>    new nvme_tcp_io_queue_count(), leaving the allocator with just the
>    per-queue allocation loop.
> - TLS PSK validation moves out of __nvme_tcp_alloc_io_queues() into a
>    new nvme_tcp_tls_check_psk().
> - nvme_tcp_configure_io_queues() now calls the three steps directly in
>    the same order as before.
>
> Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
> ---
>   drivers/nvme/host/tcp.c | 25 +++++++++++++++++++------
>   1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 5fda9661bdb7..354668ad29ac 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2171,10 +2171,8 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   	return ret;
>   }
>   
> -static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
> +static int nvme_tcp_tls_check_psk(struct nvme_ctrl *ctrl)
>   {
> -	int i, ret;
> -
>   	if (nvme_tcp_tls_configured(ctrl)) {
>   		if (ctrl->opts->concat) {
>   			/*
> @@ -2196,6 +2194,13 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   		}
>   	}
>   
> +	return 0;
> +}
> +
> +static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
> +{
> +	int i, ret;
> +
>   	for (i = 1; i < ctrl->queue_count; i++) {
>   		ret = nvme_tcp_alloc_queue(ctrl, i,
>   				ctrl->tls_pskid);
> @@ -2212,7 +2217,7 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   	return ret;
>   }
>   
> -static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
> +static int nvme_tcp_io_queue_count(struct nvme_ctrl *ctrl)

Strange function name... maybe nvme_tcp_set_io_queue_count?

