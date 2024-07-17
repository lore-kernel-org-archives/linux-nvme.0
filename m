Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1F4C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 21:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xeot4Wl845K+K7G6zsJDtzVvcHd8h/5gd+6gXVn14fU=; b=mRAqHe0e2KqRbKkb8ILDW3QOmF
	g7fzu0DtOt+GbY7cituxDNmFruzY2+xicJoltptET1YacDP5XNBwtnZutDhmjMxWl5ubmeMDkylR1
	x/qP8d8p3Nim8qsPJhb1ssk8ZHcC29ZqC5MRhRxCkn6HiHztsrzD0Myz4YvNrQIh1+lzQJUgP/YoW
	2If55SDNy22nFL0GWcGPo4iHoxg6oJby6wy6Jncwxorrk/oxwABEH6K40e2eckpmpuji9W9fNSia0
	J6EYUh/ezz+0P7MjtvMm5Ue/39bWwVESGVBMAHkwNcva8KvtTiKllsL+CzLmfgtcS77a+PxvASJUK
	PO/KExMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBwT-0000000Evxm-3WQn;
	Wed, 17 Jul 2024 21:12:05 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBvx-0000000Evuq-16o1
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 21:12:04 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-426ff626778so84705e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 14:11:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250691; x=1721855491;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xeot4Wl845K+K7G6zsJDtzVvcHd8h/5gd+6gXVn14fU=;
        b=LygrTbMe38u7LogiRvOOf1HvBQOD6TvCcDvxWnszpEh+F9aEShh6zlsbkVeXrYh/Fv
         xNXM4b7BImyQU7Ql+9q41cfFOCaTY/EmKC7o1iA+xhu1Cik6CAFykCmAGdj5rm7u9S49
         n1CNPST/hAynHZ06lMEhydksWa0Sv26FQ5X6H96IEILSfbwBYQTZKIHdlXouuW3uGBea
         kxQ3atGgqBYiWkrcuEL56YEeDX61pbTHp4yPplsh1Rjfns3ChVUfkVg218XH+ahG+NdD
         nvIkGya60ZG9L52E363dRAWTkTY/WRsfvHFYeqzMjLSGLv4xhKJ9D/4Fk24zoKxed2M9
         U9bw==
X-Forwarded-Encrypted: i=1; AJvYcCXiN73CCpgd0UwiyW4RetH92YZ2KQoJIlIupbZ4EZIe/Or/dr5kvcvTKCCviGvhr8q9Jqwdn2eoCywI@lists.infradead.org
X-Gm-Message-State: AOJu0YxRDHXcih3ys1Osuc7g4WYeylMxZit/R0yU7djj2B2SFigo1PEG
	fcVpi1mMtltVM3yeLfi/Ei+ztjnX2GuJQPyKGP1IETHqrHWfTG7IFOwMhg==
X-Google-Smtp-Source: AGHT+IGYswnCLAZA0V9N4LNmSmBH9O/f6tU5VjiYn+PTrQA+cmzW7Uc6a7WYfg+zpEpFNt65Al6jqw==
X-Received: by 2002:a05:600c:1d21:b0:426:6ecc:e5c4 with SMTP id 5b1f17b1804b1-427c5817cabmr9069335e9.4.1721250691376;
        Wed, 17 Jul 2024 14:11:31 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c7859125sm10391865e9.43.2024.07.17.14.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:11:30 -0700 (PDT)
Message-ID: <7a854ec5-adcc-49d5-bc4f-1a41238437b0@grimberg.me>
Date: Thu, 18 Jul 2024 00:11:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] nvme-tcp: improve stall debugging
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240716073616.84417-1-hare@kernel.org>
 <20240716073616.84417-5-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240716073616.84417-5-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_141133_342533_08F2CFC1 
X-CRM114-Status: GOOD (  21.20  )
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



On 16/07/2024 10:36, Hannes Reinecke wrote:
> Add counter for the number of send and receive calls, and an additional
> counter for the number of SQEs processed.

TBH, this looks like something that should be added as trace points
and have something like an ebpf program that attach to them and performs 
this type of logic.

Otherwise, these counters need to be grouped in a proper stats struct to
clarify what they are used for.

>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/tcp.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 04d840709d5d..9caee99955c2 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -156,7 +156,10 @@ struct nvme_tcp_queue {
>   	int			pdu_offset;
>   	size_t			data_remaining;
>   	size_t			ddgst_remaining;
> +	unsigned int		nr_sqe;
> +	unsigned int		nr_send;
>   	unsigned int		nr_cqe;
> +	unsigned int		nr_recv;
>   
>   	/* send state */
>   	struct nvme_tcp_request *request;
> @@ -368,6 +371,8 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
>   	int ret;
>   
>   	/* drain the send queue as much as we can... */
> +	queue->nr_sqe = 0;
> +	queue->nr_send = 0;
>   	do {
>   		ret = nvme_tcp_try_send(queue);
>   	} while (ret > 0);
> @@ -944,6 +949,7 @@ static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
>   	if (unlikely(!queue->rd_enabled))
>   		return -EFAULT;
>   
> +	queue->nr_recv++;
>   	while (len) {
>   		switch (nvme_tcp_recv_state(queue)) {
>   		case NVME_TCP_RECV_PDU:
> @@ -1028,6 +1034,7 @@ static void nvme_tcp_state_change(struct sock *sk)
>   static inline void nvme_tcp_done_send_req(struct nvme_tcp_queue *queue)
>   {
>   	queue->request = NULL;
> +	queue->nr_sqe++;
>   }
>   
>   static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
> @@ -1071,6 +1078,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>   
>   		bvec_set_page(&bvec, page, len, offset);
>   		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
> +		queue->nr_send++;
>   		ret = sock_sendmsg(queue->sock, &msg);
>   		if (ret <= 0)
>   			return ret;
> @@ -1127,6 +1135,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>   
>   	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
>   	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
> +	queue->nr_send++;
>   	ret = sock_sendmsg(queue->sock, &msg);
>   	if (unlikely(ret <= 0))
>   		return ret;
> @@ -1165,6 +1174,7 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
>   
>   	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
>   	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
> +	queue->nr_send++;
>   	ret = sock_sendmsg(queue->sock, &msg);
>   	if (unlikely(ret <= 0))
>   		return ret;
> @@ -1198,6 +1208,7 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
>   	else
>   		msg.msg_flags |= MSG_EOR;
>   
> +	queue->nr_send++;
>   	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
>   	if (unlikely(ret <= 0))
>   		return ret;
> @@ -1275,6 +1286,7 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>   	rd_desc.count = 1;
>   	lock_sock(sk);
>   	queue->nr_cqe = 0;
> +	queue->nr_recv = 0;
>   	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
>   	release_sock(sk);
>   	return consumed;
> @@ -1288,6 +1300,8 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   	u64 tx_deadline = start + deadline;
>   	bool pending = false;
>   
> +	queue->nr_sqe = 0;
> +	queue->nr_send = 0;
>   	do {
>   		int result;
>   
> @@ -1318,8 +1332,9 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   	overrun = ktime_to_us(ktime_get()) - start;
>   	if (overrun > 10 * deadline) {
>   		dev_dbg(queue->ctrl->ctrl.device,
> -			"queue %d: stall (%llu msecs)%s%s\n",
> +			"queue %d: stall (%llu msecs) send %u sqe %u recv %u cqe %u%s%s\n",
>   			nvme_tcp_queue_id(queue), div_u64(overrun, 1000),
> +			queue->nr_send, queue->nr_sqe, queue->nr_recv, queue->nr_cqe,
>   			list_empty(&queue->send_list) ? " empty" : "", queue->request ? " pending" : "");
>   	}
>   	if (pending)


