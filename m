Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407E8C5B549
	for <linux-nvme@archiver.kernel.org>; Thu, 29 May 2025 13:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OP3937SfA9lD7qYYQPRwxydonPdWzIIz/Tu6DAbtpAw=; b=yhj/t1k+bjlIIeXXwFpmPeN12d
	WuZ49JtUi3ajMVQibx0t/QB5dzE/ORdM2dr37r/UbI8r9A6Jz6fcERnMk0C6aqnl8dHAQTcor8kVM
	rDsN3xJ/v/72WRZ6vuKf+02+J6xfqL65uhvBq1qS7EasV3hqN2fCxc1djwhH5TAcnFZbFuuERwwPY
	ez+7wZygloJ0H+xuhU84fqsswi60YyQCN+6F2X04K2H+2xdTKcC4h3Y+q0Mir8weQCh4InqYyAP9K
	+NMJpxu5eFl7G/a2Tq+8l7tRej7olhgZewHoRixKN+1rMRxQswkYXznmWGeZ5cZwz23lr4Yk2Osfp
	V3lCpwGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKcrv-0000000FoAI-3b8d;
	Thu, 29 May 2025 13:00:23 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKcWk-0000000FkRm-0HxU
	for linux-nvme@lists.infradead.org;
	Thu, 29 May 2025 12:38:32 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-441c99459e9so6120915e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 29 May 2025 05:38:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748522308; x=1749127108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OP3937SfA9lD7qYYQPRwxydonPdWzIIz/Tu6DAbtpAw=;
        b=h52qGmzP1+EwggnGyj9EITWSRgOA8BW9cdmAvIVeq3rnso7e/Chq+8AKL9YIznz1HR
         1vmA2gNt2SRuoXBOTEw3U/aPM4u/FFXw1/CCMW5OLlC5pgG2dUj4Lz/CrvRwFgALGtg/
         v2orBfI+wQM4/+mMJldX3/BMYY7tzlI/YSaagS3/sxPzdapeRBlnDi+8Y+FD3eqVdLYc
         C3jWyKUEtaHUblZyi+hmNM5ayUyNsOAR3schGM3VqhiT3Cr/tX33KtWgkhEG5Jja+c0f
         cJpy9VUNeARY6OcopIHge90R5ggpuajnZFCb4GoD3KaxxekuYCYIt3BHnY5JZUq6XLxP
         2/DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUpIjnP8u+KiXmvDvsNV56qgQbCDb8Y3JkkP1AEqPt+trlefJkAJJ7nsxuLElO3GpuHYY1IPBPtB0q@lists.infradead.org
X-Gm-Message-State: AOJu0Yx9J8hPZPmX9r83pQhzLpcabOv2zYSrBbBUQbFfgAAD+htHJptP
	K9bsTLSSuUOasSgpavz3hSDU7G8t8XMyG0rzmn4OKmik/nUkZfxVvckH
X-Gm-Gg: ASbGncuP6QGTVL8lmkV/qpeqqrxAIcbUAPe8d+DE3qWAFEXfXCERQQDnMRrRaZQQH4Q
	Mjsnd/lfvTXQqYLXLM+Or0Q0L1nMHMgHr6H08+D3j0qo2vD6AU/FtYFGWllaOWW47uj/qaKbFvL
	BHupOcR5CvMBqkTaWh3ntIfQpF6Bri6stFzdKTmcEaykordeDx1bzz3nwDPR2y5batqucNyFsz+
	QEKy+r8Hyr3t/DW7uodaDEju2L8odRrOr5DMRzs2cpaLj3n1hxJ6+rclUqgSaFVY0b+J8a0Ml8S
	oo5EXDCubhdldPfpuKojEC2ebZNSmA6f/9kZ2jAkqyiHzP8YVP8+UTuvvpPQsDZAcxpCZpY4ckk
	KGR2ZPS8t
X-Google-Smtp-Source: AGHT+IE6LZbEZITA5vsn8eaDgo0imhEGriDvWhpliI607gOj2izLz19PCdoAT127zrFfTs1s+hK6Kg==
X-Received: by 2002:a05:600c:a00e:b0:43c:fe90:1279 with SMTP id 5b1f17b1804b1-45077d424bbmr53581605e9.21.1748522307821;
        Thu, 29 May 2025 05:38:27 -0700 (PDT)
Received: from [10.100.102.74] (89-138-68-29.bb.netvision.net.il. [89.138.68.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc782b0sm18776435e9.38.2025.05.29.05.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 05:38:27 -0700 (PDT)
Message-ID: <8aa2cf47-580d-49f5-8afd-7fba9451c9f5@grimberg.me>
Date: Thu, 29 May 2025 15:38:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme-tcp: do not queue io_work on a full socket
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Kamaljit Singh <kamaljit.singh1@wdc.com>, linux-nvme@lists.infradead.org
References: <20250528064535.135653-1-hare@kernel.org>
 <20250528064535.135653-4-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250528064535.135653-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_053831_591401_5BD421D0 
X-CRM114-Status: GOOD (  24.78  )
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



On 28/05/2025 9:45, Hannes Reinecke wrote:
> There really is no point in scheduling io_work from ->queue_rq()
> if the socket is full; we'll be notified by the ->write_space()
> callback once space on the socket becomes available.
> Consequently we also need to remove the check for 'sk_stream_is_writeable()'
> in the ->write_space() callback as we need to schedule io_work
> to receive packets even if the sending side is blocked.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/tcp.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 0e178115dc04..e4dd1620dc28 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -411,6 +411,9 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>   	empty = llist_add(&req->lentry, &queue->req_list) &&
>   		list_empty(&queue->send_list) && !queue->request;
>   
> +	if (!sk_stream_is_writeable(queue->sock->sk))
> +		empty = false;

This is wrong. the fact that the socket it not writeable does not mean 
that the queue
is not empty (meaning we have rqeuests that we have yet to write to the 
socket).

> +
>   	/*
>   	 * if we're the first on the send_list and we can try to send
>   	 * directly, otherwise queue io_work. Also, only do that if we
> @@ -422,7 +425,8 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>   		mutex_unlock(&queue->send_mutex);
>   	}
>   
> -	if (last && nvme_tcp_queue_has_pending(queue))
> +	if (last && nvme_tcp_queue_has_pending(queue) &&
> +	    sk_stream_is_writeable(queue->sock->sk))

I think its fine, because either this or the callback will effectively 
not queue the work
as the work can only be queued once.

>   		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   }
>   
> @@ -1074,7 +1078,7 @@ static void nvme_tcp_write_space(struct sock *sk)
>   
>   	read_lock_bh(&sk->sk_callback_lock);
>   	queue = sk->sk_user_data;
> -	if (likely(queue && sk_stream_is_writeable(sk))) {
> +	if (likely(queue)) {
>   		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>   		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   	}

I'd keep only this change. Unless you are convinced that the other 
stream checks
are correct?

