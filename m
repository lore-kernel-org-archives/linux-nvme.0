Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BEDCC3DA42
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jul 2024 11:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IfT9aMXid43LaybVtUdZF4tnvbRoXbRQnEMzzl4ywxs=; b=w8tGmlSp8wuqdcIoJfS9ekNYVD
	XdeGQtaGUM3e0VGc3IZmCojMDZlzWVtl7wskct7gZvu5Qmz2FOzevHbtuekoFn9cVqcZ0mz3be2Zg
	VDK4FjnROG8T03jGF3KhRehMM0AAaOqJqU6I1g8UpCD6hrv6hbUd5yJMPFwMQsnukwyI0b6MHBkeW
	0A32x4NVKMYPemPQX58OrX/msZPodkrQOR4ESLll00F8Ll5QkfZqL1f/hhYlJ/7OM21D4zKKQaQy+
	m6Aq9sKXcrqo5MYMIulmB+coSAuBnK17V/i25DfV0dOy2Ga3Lp8XQXL+XlTLQ8gMJ+bTcejcEl1yH
	hHvHdyHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQn09-00000003fOU-37vJ;
	Mon, 08 Jul 2024 11:57:49 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQn06-00000003fNI-1fAC
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jul 2024 11:57:48 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-426593b99daso2891585e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 08 Jul 2024 04:57:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720439864; x=1721044664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfT9aMXid43LaybVtUdZF4tnvbRoXbRQnEMzzl4ywxs=;
        b=o5thUTdE045Af9R3FZLZqZrEcqXb36HZoBPHV6oJ49s+v641B4eAHtjvi/Makaptrm
         0kIUGbS8YgRWZC9uywrGxfRg2iTYQykeZfboQFkh3Cmw1dtXUYW4RptLnghg94PhLR12
         WSfWWCaMERJSnJSnI8r3w9j38+cDmFjRosaZOLb0bj5FB7UC63yjkcORjFxkyp21GWxe
         KyZCVBw5LSoDYCYqX75Tw2CYZRqD4nJf8p/Z6d+iroCNQi+y9H87yi9O4OQMgOKsBDYt
         KLBKdFZGRtTf96DW8L2ItQ9FPfDCbzdUw7/XmTueCYVlIqpgKmei4El6qkzh4500ried
         5Sow==
X-Forwarded-Encrypted: i=1; AJvYcCX4/C0dMZH2ahVnLR93+bzhp8pMH3MNmbG61KhA00HokmSsHIzQHEhqARGtJ0Hes5cm8k/XXvFUMolGwztpHSsc9M4Mdjb7bjBsuax0AzQ=
X-Gm-Message-State: AOJu0YzTtcwYCunFCeNDvJtKs8Dss6gh/isyyd/SoN6bCU+5Bw2H9Spn
	s8u0opFO3OILynGCrn445s6GEFaj0gxxdT9qGUk8E3QN/XYnzt+RG3pjHaOM
X-Google-Smtp-Source: AGHT+IH8MPjiiRYFQCAtO3ulVDUB91rh95R2JRFD0r4wq92uGCdyEntePPYJyUqdLZoiFjdPoghPvQ==
X-Received: by 2002:a05:600c:4511:b0:425:6962:4253 with SMTP id 5b1f17b1804b1-4264a48345bmr87400105e9.4.1720439863929;
        Mon, 08 Jul 2024 04:57:43 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a25198dsm164979805e9.32.2024.07.08.04.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 04:57:43 -0700 (PDT)
Message-ID: <96bb4107-abc0-4fd3-8e2b-35eafa6a5d4f@grimberg.me>
Date: Mon, 8 Jul 2024 14:57:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] nvme-tcp: improve rx/tx fairness
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240708071013.69984-1-hare@kernel.org>
 <20240708071013.69984-2-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240708071013.69984-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_045746_474742_35EA81B2 
X-CRM114-Status: GOOD (  36.35  )
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

Hey Hannes, thanks for doing this.

On 08/07/2024 10:10, Hannes Reinecke wrote:
> We need to restrict both side, rx and tx, to only run for a certain time
> to ensure that we're not blocking the other side and induce starvation.
> So pass in a 'deadline' value to nvme_tcp_send_all()

Please split the addition of nvme_tcp_send_all() to a separate prep patch.

>   and nvme_tcp_try_recv()
> and break out of the loop if the deadline is reached.

I think we want to limit the rx/tx in pdus/bytes. This will also allow us
to possibly do burst rx from data-ready.

>
> As we now have a timestamp we can also use it to print out a warning
> if the actual time spent exceeds the deadline.
>
> Performance comparison:
>                 baseline rx/tx fairness
> 4k seq write:  449MiB/s 480MiB/s
> 4k rand write: 410MiB/s 481MiB/s
> 4k seq read:   478MiB/s 481MiB/s
> 4k rand read:  547MiB/s 480MiB/s
>
> Random read is ever so disappointing, but that will be fixed with the later
> patches.

That is a significant decline in relative perf. I'm counting 12.5%...
Can you explain why that is?

How does this look for multiple controllers?



>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/tcp.c | 38 +++++++++++++++++++++++++++++---------
>   1 file changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 0873b3949355..f621d3ba89b2 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -153,6 +153,7 @@ struct nvme_tcp_queue {
>   	size_t			data_remaining;
>   	size_t			ddgst_remaining;
>   	unsigned int		nr_cqe;
> +	unsigned long		deadline;

I don't see why you need to keep this in the queue struct. You could have
easily initialize it in the read_descriptor_t and test against it.

>   
>   	/* send state */
>   	struct nvme_tcp_request *request;
> @@ -359,14 +360,18 @@ static inline void nvme_tcp_advance_req(struct nvme_tcp_request *req,
>   	}
>   }
>   
> -static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
> +static inline int nvme_tcp_send_all(struct nvme_tcp_queue *queue,
> +				    unsigned long deadline)
>   {
>   	int ret;
>   
>   	/* drain the send queue as much as we can... */
>   	do {
>   		ret = nvme_tcp_try_send(queue);
> +		if (time_after(jiffies, deadline))
> +			break;
>   	} while (ret > 0);
> +	return ret;

I think you want a different interface, nvme_tcp_send_budgeted(queue, 
budget).
I don't know what you pass here, but jiffies is a rather large 
granularity...

>   }
>   
>   static inline bool nvme_tcp_queue_has_pending(struct nvme_tcp_queue *queue)
> @@ -385,6 +390,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>   		bool sync, bool last)
>   {
>   	struct nvme_tcp_queue *queue = req->queue;
> +	unsigned long deadline = jiffies + msecs_to_jiffies(1);
>   	bool empty;
>   
>   	empty = llist_add(&req->lentry, &queue->req_list) &&
> @@ -397,7 +403,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>   	 */
>   	if (queue->io_cpu == raw_smp_processor_id() &&
>   	    sync && empty && mutex_trylock(&queue->send_mutex)) {
> -		nvme_tcp_send_all(queue);
> +		nvme_tcp_send_all(queue, deadline);
>   		mutex_unlock(&queue->send_mutex);
>   	}

Umm, spend up to a millisecond in in queue_request ? Sounds like way too 
much...
Did you ever see this deadline exceeded? sends should be rather quick...

>   
> @@ -959,9 +965,14 @@ static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
>   			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>   			return result;
>   		}
> +		if (time_after(jiffies, queue->deadline)) {
> +			desc->count = 0;
> +			break;
> +		}
> +

That is still not right.
You don't want to spend a full deadline reading from the socket, and 
then spend a full deadline
writing to the socket...

You want the io_work to take a full deadline, and send budgets of 
try_send and try_recv. And set
it to sane counts. Say 8 pdus, or 64k bytes. We want to get to some 
magic value that presents a
sane behavior, that confidently fits inside a deadline, and is fair.

>   	}
>   
> -	return consumed;
> +	return consumed - len;
>   }
>   
>   static void nvme_tcp_data_ready(struct sock *sk)
> @@ -1258,7 +1269,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   	return ret;
>   }
>   
> -static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
> +static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue, unsigned long deadline)
>   {
>   	struct socket *sock = queue->sock;
>   	struct sock *sk = sock->sk;
> @@ -1269,6 +1280,7 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
>   	rd_desc.count = 1;
>   	lock_sock(sk);
>   	queue->nr_cqe = 0;
> +	queue->deadline = deadline;
>   	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
>   	release_sock(sk);
>   	return consumed;
> @@ -1278,14 +1290,15 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   {
>   	struct nvme_tcp_queue *queue =
>   		container_of(w, struct nvme_tcp_queue, io_work);
> -	unsigned long deadline = jiffies + msecs_to_jiffies(1);
> +	unsigned long tx_deadline = jiffies + msecs_to_jiffies(1);
> +	unsigned long rx_deadline = tx_deadline + msecs_to_jiffies(1), overrun;
>   
>   	do {
>   		bool pending = false;
>   		int result;
>   
>   		if (mutex_trylock(&queue->send_mutex)) {
> -			result = nvme_tcp_try_send(queue);
> +			result = nvme_tcp_send_all(queue, tx_deadline);
>   			mutex_unlock(&queue->send_mutex);
>   			if (result > 0)
>   				pending = true;
> @@ -1293,7 +1306,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   				break;
>   		}
>   
> -		result = nvme_tcp_try_recv(queue);
> +		result = nvme_tcp_try_recv(queue, rx_deadline);

I think you want a more frequent substitution of sends/receives. the 
granularity
of 1ms budget may be too coarse?

>   		if (result > 0)
>   			pending = true;
>   		else if (unlikely(result < 0))
> @@ -1302,7 +1315,13 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   		if (!pending || !queue->rd_enabled)
>   			return;
>   
> -	} while (!time_after(jiffies, deadline)); /* quota is exhausted */
> +	} while (!time_after(jiffies, rx_deadline)); /* quota is exhausted */
> +
> +	overrun = jiffies - rx_deadline;
> +	if (nvme_tcp_queue_id(queue) > 0 &&
> +	    overrun > msecs_to_jiffies(10))
> +		dev_dbg(queue->ctrl->ctrl.device, "queue %d: queue stall (%u msecs)\n",
> +			nvme_tcp_queue_id(queue), jiffies_to_msecs(overrun));

Umm, ok. why 10? why not 2? or 3?
Do you expect io_work to spend more time executing?

>   
>   	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   }
> @@ -2666,6 +2685,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>   {
>   	struct nvme_tcp_queue *queue = hctx->driver_data;
>   	struct sock *sk = queue->sock->sk;
> +	unsigned long deadline = jiffies + msecs_to_jiffies(1);
>   
>   	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
>   		return 0;
> @@ -2673,7 +2693,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>   	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
>   	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
>   		sk_busy_loop(sk, true);
> -	nvme_tcp_try_recv(queue);
> +	nvme_tcp_try_recv(queue, deadline);

spend a millisecond in nvme_tcp_poll() ??
Isn't it too long?

