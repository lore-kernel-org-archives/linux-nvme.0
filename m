Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B468CC3DA60
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 21:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LVmOD3PzaV2I7aZUPK+aeE5lGzA2HAjY+dmcoGXY1q0=; b=FtZbXPctkIRfk/MMDicbj8zTgP
	hgf+lzWRsUy5pFWuL402AALzS2Zt6Ookzu9vNMUTRk/Y/M57Ltw6VZMC5g5g/c6IrOFR0ccLJrPgL
	tKkQiTeYTf5xnARc1GFXpq3Zxqo8vbzqc74Tl4Rx4Z4DmsJObFVXf1NvUTW1MWPlOhNdMFbc2dna9
	xHMKyK3hl2ITBjyEzZ4cJf0yLbagHV3CkYSpBTrri6kXRpl7Nn87Tq0C6XcaNLgMGS2S2aaF1iihM
	OXJksTYXIIiSrTXjqGuEKQk/BWn18oLApLbh3RMQEAm8uKHUJdNIped7dtlWt68UTeBD1uRSwoTeN
	HufASbjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUC3u-0000000Ex6U-1G5o;
	Wed, 17 Jul 2024 21:19:46 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUC3h-0000000Ex4V-342i
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 21:19:44 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42111cf2706so120285e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 14:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721251172; x=1721855972;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LVmOD3PzaV2I7aZUPK+aeE5lGzA2HAjY+dmcoGXY1q0=;
        b=pUHzYe63FI/lN/ujJAYYf70b5/c9hVGP3pp79ogB96uiHf9+h9908t3DlsQew4HcTY
         X4lYJ1PyQffQvWk3a6WmA9QVHlKRBebJj66QHrcRMI7DpuO99hQ1kpTS1q+pxruzKieh
         faV8C2j52pj+B73cTDxm7q9+rp74UAq29ojprFDl9YRW7l7oVKFAfOlSCoV5m7woDKPd
         SJZQeDzXxISv3sm4o49jRq3k0GAqDIdAxVKil2L1IACGJkyWHRTjAmN8BWdsEFydjy6G
         kuEv7+MAxPddpxxCKr+YnZd0PkPYW6loe6Pv3+UqnlMg0CaaNx/DRyOidkr2Nip5AKby
         eMKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYUkc7+yYi17Zb6hD/0cc88cYGrbPYJoajBgQvkHnFZUFut/yYT5U6xMF8M8oHIS3l5JTvuBGVsT3qYj/V+jdQDmqC3Fu3hHiFPcGd9H8=
X-Gm-Message-State: AOJu0YxIO0Sq0aTmDc0ig7Mb3ac8kIOthQcvOeCaklNSGGrsYFXp3eG0
	Btc30JJh9Z7hmkNQENGP6YgR+VKP8ZCWblAUfKsFFwijlJ6C17X/
X-Google-Smtp-Source: AGHT+IFWlVCU0sNu8zdrx75sjTk2lonC9SCGflpxGKwDKTyKRA5khCz98MGqDjxfJPMpLF6KD/UupA==
X-Received: by 2002:a05:600c:314f:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-427c2d2003dmr12909895e9.5.1721251171670;
        Wed, 17 Jul 2024 14:19:31 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3684d3c6940sm343564f8f.70.2024.07.17.14.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:19:31 -0700 (PDT)
Message-ID: <9b8b57ca-83ae-43a4-84c6-33017dc81a32@grimberg.me>
Date: Thu, 18 Jul 2024 00:19:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] nvme-tcp: reduce callback lock contention
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 netdev@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240716073616.84417-1-hare@kernel.org>
 <20240716073616.84417-7-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240716073616.84417-7-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_141933_905489_CBABE9D7 
X-CRM114-Status: GOOD (  18.00  )
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
> From: Hannes Reinecke <hare@suse.de>
>
> We have heavily queued tx and rx flows, so callbacks might happen
> at the same time. As the callbacks influence the state machine we
> really should remove contention here to not impact I/O performance.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/tcp.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index a758fbb3f9bb..9634c16d7bc0 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1153,28 +1153,28 @@ static void nvme_tcp_data_ready(struct sock *sk)
>   
>   	trace_sk_data_ready(sk);
>   
> -	read_lock_bh(&sk->sk_callback_lock);
> -	queue = sk->sk_user_data;
> +	rcu_read_lock();
> +	queue = rcu_dereference_sk_user_data(sk);
>   	if (likely(queue && queue->rd_enabled) &&
>   	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags)) {
>   		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   		queue->data_ready_cnt++;
>   	}
> -	read_unlock_bh(&sk->sk_callback_lock);
> +	rcu_read_unlock();

Umm, this looks dangerous...

Please give a concrete (numeric) justification for this change, and 
preferably a big fat comment
on why it is safe to do (for either .data_ready or .write_space).

Is there any precedence of another tcp ulp that does this? I'd like to 
have the netdev folks
review this change. CC'ing netdev.

>   }
>   
>   static void nvme_tcp_write_space(struct sock *sk)
>   {
>   	struct nvme_tcp_queue *queue;
>   
> -	read_lock_bh(&sk->sk_callback_lock);
> -	queue = sk->sk_user_data;
> +	rcu_read_lock();
> +	queue = rcu_dereference_sk_user_data(sk);
>   	if (likely(queue && sk_stream_is_writeable(sk))) {
>   		clear_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>   		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   		queue->write_space_cnt++;
>   	}
> -	read_unlock_bh(&sk->sk_callback_lock);
> +	rcu_read_unlock();
>   }
>   
>   static void nvme_tcp_state_change(struct sock *sk)
> @@ -2076,6 +2076,7 @@ static void nvme_tcp_restore_sock_ops(struct nvme_tcp_queue *queue)
>   	sock->sk->sk_state_change = queue->state_change;
>   	sock->sk->sk_write_space  = queue->write_space;
>   	write_unlock_bh(&sock->sk->sk_callback_lock);
> +	synchronize_rcu();
>   }
>   
>   static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
> @@ -2115,6 +2116,7 @@ static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)
>   	queue->sock->sk->sk_ll_usec = 1;
>   #endif
>   	write_unlock_bh(&queue->sock->sk->sk_callback_lock);
> +	synchronize_rcu();
>   }
>   
>   static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)


