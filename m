Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916EAC001B0
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 07:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eM6AMEk25jFKH8Ncr1jvUfURTeC2iBEYVYXvaWeLUGs=; b=z9bQXySGeUCNXaSWBKLjZ1pav1
	VKo6TfRPG4Ev8+U8OvK8F6gjhU4wDBUK0HQ9pqQBYcjyTp/cL7c7dn3x99HzZ1W81et1GUQERRDwv
	5wMLATbELlxvrwULR2uEQX20MF1svTGuRp3TJmH2TDBzS+bS8iS7NzsqVS+nJHOap94aRSnJDp2Zu
	E1zTfIr1Pv/e3RqRcSaNjP8Ubl9xgZmIuA2XIXLYxI2EtzqVGDvIDSz9r62KbiQQU1aiWYZJLFlAI
	TfOR2a2l7oanazFOaD7csKsBmio+6bZnBaz3gOB/RQthSOf1JbrdElukQfOyQFkY5vheuuJmh7cx5
	D4vNp/gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSuSj-00GLPp-1a;
	Mon, 07 Aug 2023 07:15:33 +0000
Received: from mail-ej1-f52.google.com ([209.85.218.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSuSe-00GLND-14
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 07:15:32 +0000
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-99bcf3c8524so128831966b.0
        for <linux-nvme@lists.infradead.org>; Mon, 07 Aug 2023 00:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691392525; x=1691997325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eM6AMEk25jFKH8Ncr1jvUfURTeC2iBEYVYXvaWeLUGs=;
        b=HvSc9HGOZFmrLRS+ljbVdi08zv6tbDLXOFx+oFd2gHUe7p7bGKx0yXMo9JOoLWHrEu
         fw3/EZCe5lQ78lESDXSvlMhAH75vrSVYkY4EUBN2C1ZZVae44LtuZMF6tgWVUSQm6CTg
         pDa8IJ0wnItg2IsKkW8rgmW5RYkie7rSQM4Kz0hQPGRtAwLnkX+CTH9yBZVw5LK61u4r
         11FWeg8OgrjwY9QCZr7nBg401HpcM3lktzxWVR6mMiS8ZJpV1yk3uvSi74arR2Iruo4V
         Dm+VOloZMiGY1QQSaWpv1HxXmDrAJQUqBB9magIrfJ7/1RNYfTyOvxcZuGqPtz5xLmAG
         PynA==
X-Gm-Message-State: AOJu0YziE+Z9Miy8HFvxA8dUgyq1mxWpEzn4bPeLqj/z4tZB+KOcbFui
	tdnC/c//BgZv5iEa0JVxd3NyIciy3n4=
X-Google-Smtp-Source: AGHT+IFpvom2HQBh0sFhg4PSgrJg5loZuNoNjS51VTrv09IP8OYMia108R4uygCpIteQfmlXtkgWkg==
X-Received: by 2002:a17:906:74d9:b0:99c:db0f:e115 with SMTP id z25-20020a17090674d900b0099cdb0fe115mr1053793ejl.3.1691392525407;
        Mon, 07 Aug 2023 00:15:25 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709064c9200b009875a6d28b0sm4761642eju.51.2023.08.07.00.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 00:15:25 -0700 (PDT)
Message-ID: <28c702b1-57f8-d3b9-9027-e6220d81aefe@grimberg.me>
Date: Mon, 7 Aug 2023 10:15:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 07/14] nvme/tcp: allocate socket file
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-8-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230803105102.30949-8-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_001528_364738_B88C1D79 
X-CRM114-Status: GOOD (  19.70  )
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



On 8/3/23 13:50, Hannes Reinecke wrote:
> When using the TLS upcall we need to allocate a socket file such
> that the userspace daemon is able to use the socket.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 9ce417cd32a7..c3b3b938c0f9 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1338,7 +1338,9 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
>   	}
>   
>   	noreclaim_flag = memalloc_noreclaim_save();
> -	sock_release(queue->sock);
> +	/* ->sock will be released by fput() */
> +	fput(queue->sock->file);
> +	queue->sock = NULL;
>   	memalloc_noreclaim_restore(noreclaim_flag);
>   
>   	kfree(queue->pdu);
> @@ -1512,6 +1514,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>   	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
>   	int ret, rcv_pdu_size;
> +	struct file *sock_file;
>   
>   	mutex_init(&queue->queue_lock);
>   	queue->ctrl = ctrl;
> @@ -1534,6 +1537,12 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
>   		goto err_destroy_mutex;
>   	}
>   
> +	sock_file = sock_alloc_file(queue->sock, O_CLOEXEC, NULL);
> +	if (IS_ERR(sock_file)) {
> +		sock_release(queue->sock);
> +		ret = PTR_ERR(sock_file);
> +		goto err_sock;

Is it safe to fput() an error sock file?

> +	}
>   	nvme_tcp_reclassify_socket(queue->sock);
>   
>   	/* Single syn retry */
> @@ -1640,7 +1649,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
>   	if (queue->hdr_digest || queue->data_digest)
>   		nvme_tcp_free_crypto(queue);
>   err_sock:
> -	sock_release(queue->sock);
> +	/* ->sock will be released by fput() */
> +	fput(queue->sock->file);
>   	queue->sock = NULL;
>   err_destroy_mutex:
>   	mutex_destroy(&queue->send_mutex);

