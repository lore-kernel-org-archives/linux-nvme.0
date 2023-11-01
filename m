Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B82C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Nov 2023 16:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9z0VThv8CZnzdEVjyzC3nggHrPOhiiJ0OFGz1hqR0vA=; b=TKANSl50jNTAUlsEeUwyCeCgUb
	GfADaqLGem3rp0OOdVzV+BMakjIBc4/GoZLGn3QF5TuHSYpdz1net3rEc5pwOaDrEcMTZ1+h0z6fL
	ZZOmyV37+Au1ktg5NGznzslsvSqa/6N1Uc0u84c21+YlSgZUHvPn3tBy1MnLew1s/gYmiQ6NWf2YU
	Z5GTAgeI2BNbhPIW24yXmWtej0PFHrFJah+/0kkqxKI1pKKwVRELs/lPoW6pUwmNWw9UKGf3LnCiV
	/usUIPV6J8XtUppcbq+UH56CDq0NJFkp8zT4nlq+xs15yrpsSKDVLEkT27b5x9zOiBc2VDGnR8VKr
	8u/grDpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyDyO-007o1z-2U;
	Wed, 01 Nov 2023 16:21:40 +0000
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyDyM-007o1g-1d
	for linux-nvme@lists.infradead.org;
	Wed, 01 Nov 2023 16:21:40 +0000
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-3593d2018bfso1206805ab.0
        for <linux-nvme@lists.infradead.org>; Wed, 01 Nov 2023 09:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1698855696; x=1699460496; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9z0VThv8CZnzdEVjyzC3nggHrPOhiiJ0OFGz1hqR0vA=;
        b=qKLesD9aaqTcWe9tBmsumxN6VJ46G2JMZxr4dzsTgceFvYnT1GxDYiqjiP2IB/RV5r
         j95nqKjYbNmN9ARQ+ZAMFy1bWAVQhDCWEn65andpKnsK3YuAb/dFIJZOoEd04mXncAEU
         iDuwpEzZn3wMX5vJq3Yl+jXRGtS7/GYg0/d2cmrW/Gl+Q6J+DKEXycTA7LJI+KjMts8P
         TIQJe8adZUUYNy8g74CMH/35t9qSaUGZ8KWgFrkcpnDzo29m2GMswCC79K+N55BsmkBV
         JhgvVK/B5WdY9eZZA9DquGq6etk3ymDi2Z3ahWSc90yztQoEPV1QQqh5KPXwiPrapK4H
         4kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698855696; x=1699460496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9z0VThv8CZnzdEVjyzC3nggHrPOhiiJ0OFGz1hqR0vA=;
        b=s5Ccc02XS++Lb4KNPIiT4RSKmIcimhv4pr22U44xBjW1fbbEQDTQWBu8wJefAA+Lj7
         ZzaYL3aPkqMEMf/G8iD1wOTblfKOJI5FdJRVZe69/cxvXJujfs1G3HQXtIcFhHXOLz06
         HcAQYUFYo+tPtoUYa85ecKIGfdIvyGQlY/l98tvEzJkFz1uDUa6NHvWUYWw/5FvL2kbv
         g9QCqD73x3BPBBUOJT9+xa6BQwNi6d5YjHZd1YomMrpMqa3WqWYWtTyPHEoW7VtK+e0v
         bQoZ/j8whOvcvA0TfTdUMdLSpWugtCyEX0fPJATeet/5NOfOIszYRrYxfStsBEVP/iN9
         RnCQ==
X-Gm-Message-State: AOJu0YznNhNXcC3SIa7vtPKtBiTDJLVwmbwiT7pfVh/Cv/1Gun5LxqsU
	hzQWdliMuCxsVLqcUsOMhmXfjw==
X-Google-Smtp-Source: AGHT+IHWX4PUqsKKugmpHyGy6JDExOlBI6OydQ5Es/7NP+ZhO0kRtkPDo4A3pg3ZIZy8X1Z/JMmpaQ==
X-Received: by 2002:a5d:924a:0:b0:7a9:7aa9:c175 with SMTP id e10-20020a5d924a000000b007a97aa9c175mr17910344iol.1.1698855696488;
        Wed, 01 Nov 2023 09:21:36 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h22-20020a02b616000000b0045c1fcf2ef7sm978697jam.37.2023.11.01.09.21.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 09:21:35 -0700 (PDT)
Message-ID: <29253636-b9da-40b0-a217-013800ffc18c@kernel.dk>
Date: Wed, 1 Nov 2023 10:21:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet-rdma: avoid circular locking dependency on
 install_queue()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20231101103228.136570-1-hare@suse.de>
 <20231101103228.136570-2-hare@suse.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231101103228.136570-2-hare@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231101_092138_761631_364115F0 
X-CRM114-Status: GOOD (  21.87  )
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

On 11/1/23 4:32 AM, Hannes Reinecke wrote:
> nvmet_rdma_install_queue() is driven from the ->io_work workqueue
> function, but will call flush_workqueue() which might trigger
> ->release_work() which in itself calls flush_work on ->io_work.
> 
> To avoid that check for pending queue in disconnecting status,
> and return 'controller busy' until all disconnects are completed.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/target/rdma.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 4597bca43a6d..eaeb94a9e863 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1583,8 +1583,18 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
>  	}
>  
>  	if (queue->host_qid == 0) {
> -		/* Let inflight controller teardown complete */
> -		flush_workqueue(nvmet_wq);
> +		struct nvmet_rdma_queue *q;
> +		int pending = 0;
> +
> +		mutex_lock(&nvmet_rdma_queue_mutex);
> +		list_for_each_entry(q, &nvmet_rdma_queue_list, queue_list) {
> +			if (q->state == NVMET_RDMA_Q_DISCONNECTING)
> +				pending++;
> +		}
> +		mutex_unlock(&nvmet_rdma_queue_mutex);
> +		/* Retry for pending controller teardown */
> +		if (pending)
> +			return NVME_SC_CONNECT_CTRL_BUSY;

Not sure if it's worth turning this into a helper since both patches do
the same thing. Probably not, since you'd need to pass in the mutex and
state too. In any case, why not just break if you hit
NVMET_RDMA_Q_DISCONNECTING rather than keep looping? You don't care
about the exact count, jsut whether it's non-zero or not.

-- 
Jens Axboe


