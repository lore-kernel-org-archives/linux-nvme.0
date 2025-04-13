Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE79C3601E
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Apr 2025 23:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JYz3x+lS6m5S+xbCQosAzd0muz3cX10GPpjugvCeuCM=; b=j0GuxE6811ntk4uzgT7kBUc1V+
	maISVZuJW+6d6gLLcvjHVPjamhcvlkempVOzBY/e2acsydYQhrIB5+cM2Lt14R9pavPNAOzsdeOBr
	ijPQWrqDmh2SpPwBVYQ6EVSr89fXv16Ww+OdkE5OGf+rNHDDpL2d5eEiTBpkozKVJLzT8YxHqnqW6
	2soQxWaq8HnzpA2bAXnPrTqSwmEGUaUxBvKzs7RtHTKrdeeTUL4Hpy6sXVG9pB79H8wyY47oxnbe3
	BKYNAo9BXhL9fJSi76N293D5xoalclBWzFpymyKkbqg0mYjTqgydX1BtvacHf5loEXxtyn7CK9kwF
	UdxLdfuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u46Jx-00000000K2L-2ckJ;
	Sun, 13 Apr 2025 23:01:01 +0000
Received: from mail-ej1-f45.google.com ([209.85.218.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u46Ju-00000000K1B-3Wnj
	for linux-nvme@lists.infradead.org;
	Sun, 13 Apr 2025 23:01:00 +0000
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so741835266b.3
        for <linux-nvme@lists.infradead.org>; Sun, 13 Apr 2025 16:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744585257; x=1745190057;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYz3x+lS6m5S+xbCQosAzd0muz3cX10GPpjugvCeuCM=;
        b=C4OuueLcJDtw5PRXuQk9d0TgK7VcWWiD6bwo5Xlqc3v+gx/ETRtRVJWcUfPw+sLugx
         tsIXpqGbN1gZ9QJYJ6vDVqxKd3fDKaqdTIJpy1vz/GSYDORK+wm4xcBjuU8cmL0/LE3Z
         Se1Zq9yr4GWU8Jw0Vgl7uGRVmGgwFnPeN8K/y2joAZ2Viohhgys1EUk+WP9JrlXsUlXI
         pmTSmbXqEp+YJ8a45iv5h+XmH1i+Ur9bp739OCJ1PSZ75IS2hNjS6FBiJ6NqZwf+EhpC
         cROpznRG1GZfc+cJXzRqZEcI7h7C+rcK+qkAlyKMMLiGyf0+2FjprcPUxpJqmz/PY1RO
         jP3A==
X-Forwarded-Encrypted: i=1; AJvYcCVR/hf+Bp7uRNbVr6yQaEfUENtoTisQP8FLXjoWONir5ApiJwxfAdgLJrjwcUjETXDWCbxtvlqNUAbB@lists.infradead.org
X-Gm-Message-State: AOJu0YyvxopPakfx1t9V9W6sg67NZrTCkC2NZw82yqxKN9BZcd0Npwcl
	8P2PGpoV2Z6NbsvakBLWQ5CwQGyijXA55/M5QLVMfj4d06B0yxZo
X-Gm-Gg: ASbGncveQxZABGnu4ZN2e2coQo0nPkJioVSS7CvFQ/GhyHSlxLrKGXCrAeOj1dMl79i
	Rj3nt1X5+Ip7zgszUBz3Bhv8nzLRCeegdG7vD6w5XNvZqSC+o/bHXKTSFxSNusIKUXIKbicYT54
	Lv8Jq0W+CEhoDNf7qlLLnT4jSxW5sdk941kh64UqoQG25BTKcKhs6dqVNeos0Plo+/LJo8wR4kh
	yjnwtD5WRpcNgNfuMdiEVurC19bntSRS/j6adKJNKMaHjfvXkNLRrP+PSlTF6m+VMzw44EWF5Kn
	qHUjPhoGYJLNKfvpQuAQeebOS/2GenPW3Htv+AH7tMViExrULouwPHGt9wZCvJYuIb8+iWjJ
X-Google-Smtp-Source: AGHT+IGONQsSS0SUG/3cbZphKIF+BsAOPuhqdWmp58NXqSn6kLdiZGhgTdArO3PI74v9nC6IRiV5aw==
X-Received: by 2002:a17:907:3f8d:b0:ac2:dcb9:d2d4 with SMTP id a640c23a62f3a-acad3499db4mr810305166b.14.1744585256912;
        Sun, 13 Apr 2025 16:00:56 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccad01sm798547066b.125.2025.04.13.16.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 16:00:56 -0700 (PDT)
Message-ID: <f30a41f0-496b-4ad7-a0aa-01f2d5eade73@grimberg.me>
Date: Mon, 14 Apr 2025 02:00:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme-tcp: sanitize request list handling
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-3-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250403065522.90807-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250413_160058_883719_EEAC0A73 
X-CRM114-Status: GOOD (  17.83  )
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



On 03/04/2025 9:55, Hannes Reinecke wrote:
> Validate the request in nvme_tcp_handle_r2t() to ensure it's not
> part of any list, otherwise a malicious R2T PDU might inject a
> loop in request list processing.

Not clear what do you mean by "malicious R2T PDU".
Can you please clarify what you have seen/observed in the commit msg 
(i.e. what led you
to this patch)?

>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/tcp.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index b2f2aef2e2f2..1a319cb86453 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -454,6 +454,7 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
>   	}
>   
>   	list_del(&req->entry);
> +	init_llist_node(&req->lentry);
>   	return req;
>   }
>   
> @@ -561,6 +562,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
>   	req->queue = queue;
>   	nvme_req(rq)->ctrl = &ctrl->ctrl;
>   	nvme_req(rq)->cmd = &pdu->cmd;
> +	init_llist_node(&req->lentry);
> +	INIT_LIST_HEAD(&req->entry);
>   
>   	return 0;
>   }
> @@ -765,6 +768,15 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
>   		return -EPROTO;
>   	}
>   
> +	if (queue->request == req ||
> +	    llist_on_list(&req->lentry) ||
> +	    !list_empty(&req->entry)) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"req %d unexpected r2t while processing request\n",
> +			rq->tag);
> +		return -EPROTO;
> +	}
> +
>   	req->pdu_len = 0;
>   	req->h2cdata_left = r2t_length;
>   	req->h2cdata_offset = r2t_offset;
> @@ -773,7 +785,8 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
>   	nvme_tcp_setup_h2c_data_pdu(req);
>   
>   	llist_add(&req->lentry, &queue->req_list);
> -	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
> +	if (list_empty(&queue->send_list))
> +		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);

Is this change mandatory? looks out of place.

