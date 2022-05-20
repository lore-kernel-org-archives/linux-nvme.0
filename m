Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB53C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 20 May 2022 09:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=apG5lnss8gG0irfPdIaEZEq5Wdzt5NUXg9J4ZAoNCjw=; b=X6kfq4V0pyfcbkLeINHI4BJ5C8
	dFMQQEDSLJXCmPppwz8rR0fXTfIVNBUD10ABpyb+Gl8LeagkQuxlRngJkmRbNVWhg0KYOGeeeOH9S
	27ydXA272j21cAHz5OiQs3nPdVqmGC7/7WjKlpa36LBtAB379iyrScn+EP1bt/tVUZASZt09CN5vV
	4PSmkiJ5athEMt0UvxWTeS/NjGaeTkUv4zpValoxJDPnkDKyPZuwpE522Zl9KvVAr1FR7056HPyAr
	MYGBlAcjG4tHyeYOoDbihtWYAav5eu5Tf/0OR4zrV+wSNQEe2123Q/NbY6VUVomyiXzu+8LkRZYHe
	eJzMaewQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nryl6-00BXCf-Kb; Fri, 20 May 2022 09:17:20 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nryl4-00BXB0-7F
 for linux-nvme@lists.infradead.org; Fri, 20 May 2022 09:17:19 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 k126-20020a1ca184000000b003943fd07180so3992482wme.3
 for <linux-nvme@lists.infradead.org>; Fri, 20 May 2022 02:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=apG5lnss8gG0irfPdIaEZEq5Wdzt5NUXg9J4ZAoNCjw=;
 b=r98OzvslbpLkhmBiFMrZ9k6+6b13N4v0DV/wt4BldBhbSpSs1aBg2Q/M8GPtSSvjXk
 lpKbP2gsXQ2ySRO8aBGg10aX16PZVrBgH6dt94CLd90BKubtHSheAtfG+lSxPdSP/KEW
 9OiAzMlEI7ba5sbkrgqHaaFeddIQRCoLoCzRYcOaYrx4XfKpQL1CWaYhADOD1EE65C+y
 PwC+z320xwVW7Djjz41q/Y8utlMGs3te4YPyZOjsbzh+ZoTiFj8NPtme2wTL7ZLN+3vL
 J/ZFD8Np7MaA42K5wDhnoy1UCz/9MteTNaG5aK5wKu5btVbT9RUjNNub7aNF+yF/eSfI
 IAnQ==
X-Gm-Message-State: AOAM530CjESWsgFc9TBhmL0CgsYG1xhQWMG8mmIrYSVmNktPSnHA00ej
 D8NbNkA3uqfR17yaT30GCJnfvi/cJJY=
X-Google-Smtp-Source: ABdhPJzZTu9H784UF9hNt4xcodIYK/N44OGnPmy0XXopU1EcJBDuL2rshgAB3aDQWUBZjmcr99ChUg==
X-Received: by 2002:a7b:cc0d:0:b0:381:220e:a3a0 with SMTP id
 f13-20020a7bcc0d000000b00381220ea3a0mr7180332wmh.59.1653038235284; 
 Fri, 20 May 2022 02:17:15 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il.
 [46.117.125.14]) by smtp.gmail.com with ESMTPSA id
 s30-20020adf979e000000b0020d110bc39esm1962254wrb.64.2022.05.20.02.17.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 May 2022 02:17:15 -0700 (PDT)
Message-ID: <bd99d7d6-c9b2-7448-1eaa-d645f7372694@grimberg.me>
Date: Fri, 20 May 2022 12:17:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] nvme-tcp: Check for write space before queueing
 requests
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220519062617.39715-1-hare@suse.de>
 <20220519062617.39715-3-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220519062617.39715-3-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220520_021718_310245_E3DDC419 
X-CRM114-Status: GOOD (  19.36  )
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


> The current model of always queue incoming requests lead to
> write stalls as we easily overload the network device under
> high I/O load.
> To avoid unlimited queueing we should rather check if write
> space is available before accepting new requests.

I'm somewhat on the fence with this one... On one end, we
are checking the sock write space, but don't check the queued
requests. And, this is purely advisory and not really a check
we rely on.

The merit of doing something like this is that we don't start
the request timer, but we can just as easily queue the request
and have it later queued for long due to sock being overloaded.

Can you explain your thoughts to why this is a good solution?

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ede76a0719a0..606565a4c708 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2464,6 +2464,9 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	if (unlikely(ret))
>   		return ret;
>   
> +	if (!sk_stream_is_writeable(queue->sock->sk))
> +		return BLK_STS_RESOURCE;
> +
>   	blk_mq_start_request(rq);
>   
>   	nvme_tcp_queue_request(req, true, bd->last);

