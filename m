Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B00C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 21:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BXwI/HxUAHW14224r2k5H+5pARNPtZN4VPBGb9J2Qbc=; b=1phul7HI63Wdueu2L37PFyoiO6
	dcKLdVtOA7P+MUONoDkXFt8GLcwhdvLCy2Agmn0un0uaR6LrJcQ6qMn32b7jt3pQ3PcUb7hKfprPE
	EyDA09AP3BnuUM7XfHqAy6FGaEm8O0vBuINbhLUVb9g3hxHrx2hsDFOwUgW4MzyvECK3/mgs/jzFM
	EOzFOr8RsZrJ11s3yVmqMKl5UK0FdR9J8PrD/9OhwpNRyEbe2VeK1OuVmOijbbbK6g9Db3ucHKN57
	SGQR5IdL6ewnW4Q6Gbz7Mv4qagCtKtV6xoWnToYGzay6PCK1w9C4P+GG+s8vShwI3zvDTNer77nzT
	Bf/+pqWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBpi-0000000EvA2-3hQP;
	Wed, 17 Jul 2024 21:05:06 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUBpg-0000000Ev9R-2VOU
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 21:05:05 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266ea4e4bdso89925e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 14:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721250303; x=1721855103;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXwI/HxUAHW14224r2k5H+5pARNPtZN4VPBGb9J2Qbc=;
        b=ZBbhkGaQyu/pP0k+cI+BhWxosh6zDC65lIfTa/OgZ4s95nQ6SeNiafXa1wbJ3D8Tw+
         UMbk8cHvxnO6m38qR2QXqPNo0zlafdDRKyoEgntoShlAxvXqV/6eL+cEmA79d7Zv/VYg
         AzcSmyeDOjUncr+BWlecXRiUIcACBkrJg5ew9iqZkaSa/DAWYzMTZZZ4WQ/MJngnNjqk
         solRU6p6uZXEVm5gwXsT6b8+Ulu7xZZsMH7pDT4ixHNqARmoiFWVIKZqpY2GnEsoW15w
         yeFLtJ2cwaOxChnv/aIegkFRs4ojpti/BSZJhpVyw6Q6mh2eEy9Vs/A2W4UGtZGAr/dq
         DFEw==
X-Forwarded-Encrypted: i=1; AJvYcCVIJqC90JQ7RYrt+SadBW+IKbQ5Bm6w9QaQ6ryUGuEBsgBRFr4JFWckK3bszJipNrh8VHapJ3O8aWGkxCAFsnUgl3bFXG4U0PUQbhSBNcs=
X-Gm-Message-State: AOJu0YzR7t4qYErtK9NkluaGcj7qhkrtg520ipHx4W45zCLxymm/fcSH
	9nDBDQKt7+/WRFonbN0o3wq2IOu+dMvVrpjL+0pzIJedmkLn2MWc
X-Google-Smtp-Source: AGHT+IGh0YWlQnW/2cdt/xVxnYG5grx7gIT81qew7D18uqIbaypRxeuLvlx04Lwl1RoEuQfY4d7H7g==
X-Received: by 2002:a05:600c:1c07:b0:425:65b1:abb4 with SMTP id 5b1f17b1804b1-427c6ba724bmr6169985e9.0.1721250302866;
        Wed, 17 Jul 2024 14:05:02 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427ba20aaf8sm63840505e9.0.2024.07.17.14.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:05:02 -0700 (PDT)
Message-ID: <3b38f1b2-b4f4-4b72-a5ab-4ee248324338@grimberg.me>
Date: Thu, 18 Jul 2024 00:05:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] nvme-tcp: io_work stall debugging
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240716073616.84417-1-hare@kernel.org>
 <20240716073616.84417-3-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240716073616.84417-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_140504_677431_C62F6A89 
X-CRM114-Status: GOOD (  17.94  )
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
> Add a debug message when the io workqueue exceeds the latency target
> given by 'deadline'.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/tcp.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 3cf9a9abb0e0..7876bf7d2fac 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1282,13 +1282,14 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   {
>   	struct nvme_tcp_queue *queue =
>   		container_of(w, struct nvme_tcp_queue, io_work);
> -	u64 start = ktime_to_us(ktime_get());
> +	u64 start = ktime_to_us(ktime_get()), overrun;
>   	u64 tx_deadline = start + deadline;
> +	bool pending = false;
>   
>   	do {
> -		bool pending = false;
>   		int result;
>   
> +		pending = false;
>   		if (mutex_trylock(&queue->send_mutex)) {
>   			result = nvme_tcp_try_send(queue);
>   			mutex_unlock(&queue->send_mutex);
> @@ -1304,12 +1305,23 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   		else if (unlikely(result < 0))
>   			return;
>   
> -		if (!pending || !queue->rd_enabled)
> +		if (!queue->rd_enabled)
>   			return;
> +		if (!pending)
> +			goto check;

...

>   
>   	} while (ktime_to_us(ktime_get()) < tx_deadline); /* quota is exhausted */
>   
> -	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
> +check:
> +	overrun = ktime_to_us(ktime_get()) - start;
> +	if (overrun > 10 * deadline) {
> +		dev_dbg(queue->ctrl->ctrl.device,
> +			"queue %d: stall (%llu msecs)%s%s\n",
> +			nvme_tcp_queue_id(queue), div_u64(overrun, 1000),
> +			list_empty(&queue->send_list) ? " empty" : "", queue->request ? " pending" : "");
> +	}
> +	if (pending)
> +		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
>   }
>   
>   static void nvme_tcp_free_crypto(struct nvme_tcp_queue *queue)


