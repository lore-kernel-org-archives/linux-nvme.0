Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB6EC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 09:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+6XuX8B89xc0JK55vdXwViXJ+778e6tW8nWbKqjIrOI=; b=aruCHK2pI5Zj/K+vqAxioKbVPI
	G/B92qA1EUd//nC1Q/pHdu73zkltWL4hXFilrYsf9KPFekWfzYh5mPnpUwXbngr6LX5OwUYd833Am
	Aiggh0kESBQU0OO997lA2vG5naL5c5O9xCfDkfKqk4eAbyyyZTSeJUVgw52bMf09GU8ZlujQ+tEIX
	XGAbaDc0wnTP/WZWrqKhB5e197hVhXXaFt0HkTH7K9toVnytGIn+GDStaO0rIVbL3qqAIIJ66xxUk
	/PiGF5pX6HWSYOcAxBHcDfeNZOgscHjvufOQOYdfI2jMuTrR8P8P/Wqofe8GNTFHffs3dXvbuwsK4
	0ITNhO1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nryZW-00BSAq-9x; Fri, 20 May 2022 09:05:22 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nryZU-00BS8V-5F
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 09:05:21 +0000
Received: by mail-wm1-f48.google.com with SMTP id p189so4187229wmp.3
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 02:05:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=+6XuX8B89xc0JK55vdXwViXJ+778e6tW8nWbKqjIrOI=;
 b=VIiHdd/iDhQU5hKlYHGNJVI2Z/q+MQN0x1jxEhZKC9MhDS5aho/FCUcy/Rahq7l/is
 UWqj4JTmG9e5OMCLnA424fRZR6cRzaCeI2MUmN+hAwiuczL1CBShNOH3Ey0TMBSfxWi9
 WjjoGZ3kpwYaBpKiniHwhl7Q/BGwMM/m03LayhoV7meW/UNFwaHjyRnZ/2fHvcIhMkyS
 3ITsPayHvCDrWVcn0pRq3z/xVoR0WqGcm4gsQzOm/7dmpCMLxU3jX0/LvcKrfv4udKJC
 O7ffE0HJL/Kual6cETErzAxPWi3Nd5ZfCA2gQHt7WFRTFhYwIMv+6Yk3EWDk5BLxJUgh
 Rfeg==
X-Gm-Message-State: AOAM531h+8NZJrNFAtHqUhZeND1rOOCzuZqxgiM3UlSi9nGW8mL/sUKM
 nW2cD7vQ07cq3VvwCezSGEg=
X-Google-Smtp-Source: ABdhPJzz9IYVWKxLnttpoFsPkE5hPc5EAyXYYwn679BK0KidGa8TgzgddnEmZZYBV/e2ygwysLlOBg==
X-Received: by 2002:a05:600c:4e91:b0:394:8d30:d6dd with SMTP id
 f17-20020a05600c4e9100b003948d30d6ddmr7159172wmq.21.1653037516994; 
 Fri, 20 May 2022 02:05:16 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il.
 [46.117.125.14]) by smtp.gmail.com with ESMTPSA id
 k6-20020adfb346000000b0020c5253d8fcsm2089700wrd.72.2022.05.20.02.05.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 May 2022 02:05:16 -0700 (PDT)
Message-ID: <7827d599-7714-3947-ee24-e343e90eee6e@grimberg.me>
Date: Fri, 20 May 2022 12:05:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] nvme-tcp: spurious I/O timeout under high load
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220519062617.39715-1-hare@suse.de>
 <20220519062617.39715-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220519062617.39715-2-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_020520_233897_DB6CBC3B 
X-CRM114-Status: GOOD (  21.67  )
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

The patch title does not explain what the patch does, or what it
fixes.

> When running on slow links requests might take some time
> for be processed, and as we always allow to queue requests
> timeout may trigger when the requests are still queued.
> Eg sending 128M requests over 30 queues over a 1GigE link
> will inevitably timeout before the last request could be sent.
> So reset the timeout if the request is still being queued
> or if it's in the process of being sent.

Maybe I'm missing something... But you are overloading so much that you
timeout even before a command is sent out. That still does not change
the fact that the timeout expired. Why is resetting the timer without
taking any action the acceptable action in this case?

Is this solving a bug? The fact that you get timeouts in your test
is somewhat expected isn't it?

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index bb67538d241b..ede76a0719a0 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2332,6 +2332,13 @@ nvme_tcp_timeout(struct request *rq, bool reserved)
>   		"queue %d: timeout request %#x type %d\n",
>   		nvme_tcp_queue_id(req->queue), rq->tag, pdu->hdr.type);
>   
> +	if (!list_empty(&req->entry) || req->queue->request == req) {
> +		dev_warn(ctrl->device,
> +			 "queue %d: queue stall, resetting timeout\n",
> +			 nvme_tcp_queue_id(req->queue));
> +		return BLK_EH_RESET_TIMER;
> +	}
> +
>   	if (ctrl->state != NVME_CTRL_LIVE) {
>   		/*
>   		 * If we are resetting, connecting or deleting we should


