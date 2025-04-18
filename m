Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6F2C369CB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 11:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ec/XzVcGOwKgl03ZmFZTdHXNDJONfrH6xIDSGmbmdKk=; b=Za2TZBndcJuU08YtLIQbBS3Ua8
	UkG/jt8h3m+woHJnUSC0sX8Q5ox9h39w1b5wgYo4XaFpfooj22d7bbuBB5j20vOgBHe/ypIX9uGKU
	FsVaRQL0XVTVHYAL1SHRthykBLezff/Smm04Jt0H+is/rMDo/p/4xccMkZLeGMTUSAnVK8QxFPFeW
	zYzJm89MUAa/gwl/ojPDG0zfK1RXtB4JiHXvQeGSKe9a5OhzDeTWIhcOXEY3glxKX1njEdD3E88Kj
	qR3cHt8DajUZdTjiee5LKHd7Chvf6mnLZZmDo0r9QwjG784Qp4LK9gxijNns7ut1HczSOwLKWYInJ
	E5QJGc5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5jy0-0000000Fz43-3rZy;
	Fri, 18 Apr 2025 11:33:08 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5jvo-0000000Fymu-0YwE
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 11:30:53 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso16712065e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 18 Apr 2025 04:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744975850; x=1745580650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ec/XzVcGOwKgl03ZmFZTdHXNDJONfrH6xIDSGmbmdKk=;
        b=IhGojBvRz4f2miDhe8AaZBaT+zRUSiN9N03yVrXw7jM0PrzvurgXZ5dFByfUo25WKb
         dPv9WPi+ZpgUT//p8IWay3puXx7qLOg53Pq+1wKSnKwYrtnYDlJ5+JPksQrD8qJOr0m3
         dKvY1zJ0pGn1jxNVocX6hjDKg9uHnC2ZFZgboBNCdGX6NBEIemGmgz7pdyuvfl5hDidD
         DjFjY6Pa0OF491E0wxA0/nauBxmIh9+hMTdu/qRRveBNR5gno5YYI/YIVFY8wN2Ur9DD
         9ZhzMOW4r5O9LIadh8tnaJa+T+9pyV90wSLqx8wkiFR0/NqjZlCaA1bSEa+MIE/zwSjt
         Vi4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVB8L30SaRr8vUdilLkXlnheh3qTiq7hjWnBHzOFuoDn2/nS4z7xJRAFenX9I2iixMYjqxpA1fdY7TB@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/ejJvv+jPEkQcb4MkFjleiurxtfA9WsaexUHZ3Fb2j9Tz63M8
	5Ojxw9GzrW++y3al1Ns8h38p494QHmFEDK+HrC+O3N/fmkaLHK3OQ6UwgvUU
X-Gm-Gg: ASbGncs5b39RQN0vMMCkEac/r4A6rKkGyw3N6tOthie9dk4Ed85R0vTeU1TCuWRj067
	ehaSMGa6lOaQW+24wzjceDUD5FN9zKkJ+8HDPCeNWoCbr02MMJMjjPSwrYbVq2iuQLsEWz7lztE
	YQH5v+7b78DdrB5nKK2M3F+bj+vsL4LEDM8RwWtZbQWN/WOogOKOgtSdKqc7cv6L632VkOWmTLp
	S5tLC4asGdwhSBLQ9hWAI+zSeyIViKV8bGcgTOHpmlQUNeExPeEAJIPM8Ub3RhIUxk9Zkmu88cV
	NLO7z55JasKmXVSMcFx6JrVkNKsXxpJ94wyBueau
X-Google-Smtp-Source: AGHT+IHopOoTjCgVg0Mcg1+7QOl+DxqAuGkARymIBOfr2XaYZywOwRZjhRW0NML5Krd9zqG52QhLSg==
X-Received: by 2002:a05:600c:348a:b0:43c:e8a5:87a with SMTP id 5b1f17b1804b1-4406aba5f97mr22060475e9.16.1744975850184;
        Fri, 18 Apr 2025 04:30:50 -0700 (PDT)
Received: from [10.100.102.67] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5cf2dfsm19346195e9.29.2025.04.18.04.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 04:30:49 -0700 (PDT)
Message-ID: <acc46429-6228-475e-8fd8-bc3d43c7f710@grimberg.me>
Date: Fri, 18 Apr 2025 14:30:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] nvme-tcp: wait socket wmem to drain in queue stop
To: Michael Liang <mliang@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250417071359.iw3fangcfcuopjza@purestorage.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250417071359.iw3fangcfcuopjza@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_043052_172301_B1543C26 
X-CRM114-Status: GOOD (  27.15  )
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



On 4/17/25 10:13, Michael Liang wrote:
> This patch addresses a data corruption issue observed in nvme-tcp during
> testing.
>
> Issue description:
> In an NVMe native multipath setup, when an I/O timeout occurs, all inflight
> I/Os are canceled almost immediately after the kernel socket is shut down.
> These canceled I/Os are reported as host path errors, triggering a failover
> that succeeds on a different path.
>
> However, at this point, the original I/O may still be outstanding in the
> host's network transmission path (e.g., the NIC’s TX queue). From the
> user-space app's perspective, the buffer associated with the I/O is considered
> completed since they're acked on the different path and may be reused for new
> I/O requests.
>
> Because nvme-tcp enables zero-copy by default in the transmission path,
> this can lead to corrupted data being sent to the original target, ultimately
> causing data corruption.
>
> We can reproduce this data corruption by injecting delay on one path and
> triggering i/o timeout.
>
> To prevent this issue, this change ensures that all inflight transmissions are
> fully completed from host's perspective before returning from queue
> stop. To handle concurrent I/O timeout from multiple namespaces under
> the same controller, always wait in queue stop regardless of queue's state.
>
> This aligns with the behavior of queue stopping in other NVMe fabric transports.
>
> Reviewed-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> Reviewed-by: Randy Jennings <randyj@purestorage.com>
> Signed-off-by: Michael Liang <mliang@purestorage.com>
> ---
>   drivers/nvme/host/tcp.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 26c459f0198d..62d73684e61e 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1944,6 +1944,21 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
>   	cancel_work_sync(&queue->io_work);
>   }
>   
> +static void nvme_tcp_stop_queue_wait(struct nvme_tcp_queue *queue)
> +{
> +	int timeout = 100;
> +
> +	while (timeout > 0) {
> +		if (!sk_wmem_alloc_get(queue->sock->sk))
> +			return;
> +		msleep(2);
> +		timeout -= 2;
> +	}
> +	dev_warn(queue->ctrl->ctrl.device,
> +		 "qid %d: wait draining sock wmem allocation timeout\n",
> +		 nvme_tcp_queue_id(queue));
> +}
> +
>   static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
>   {
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> @@ -1961,6 +1976,7 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
>   	/* Stopping the queue will disable TLS */
>   	queue->tls_enabled = false;
>   	mutex_unlock(&queue->queue_lock);
> +	nvme_tcp_stop_queue_wait(queue);
>   }
>   
>   static void nvme_tcp_setup_sock_ops(struct nvme_tcp_queue *queue)

This makes sense. But I do not want to pay this price serially.
As the concern is just failover, lets do something like: diff --git 
a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c index 
5041cbfd8272..d482a8fe2c4b 100644 --- a/drivers/nvme/host/tcp.c +++ 
b/drivers/nvme/host/tcp.c @@ -2031,6 +2031,8 @@ static void 
nvme_tcp_stop_io_queues(struct nvme_ctrl *ctrl) for (i = 1; i < 
ctrl->queue_count; i++) nvme_tcp_stop_queue(ctrl, i); + for (i = 1; i < 
ctrl->queue_count; i++) + nvme_tcp_stop_queue_wait(&ctrl->queues[i]); } 
static int nvme_tcp_start_io_queues(struct nvme_ctrl *ctrl, @@ -2628,8 
+2630,10 @@ static void nvme_tcp_complete_timed_out(struct request *rq) 
{ struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq); struct nvme_ctrl 
*ctrl = &req->queue->ctrl->ctrl; + int idx = 
nvme_tcp_queue_id(req->queue); - nvme_tcp_stop_queue(ctrl, 
nvme_tcp_queue_id(req->queue)); + nvme_tcp_stop_queue(ctrl, idx); + 
nvme_tcp_stop_queue_wait(&ctrl->queues[idx]); 
nvmf_complete_timed_out_request(rq); }

