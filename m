Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7930C369DC
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 11:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O1tOQA/b/pMHqe437Sqwyo/kDl3saypAMc7dZp8vas0=; b=mTqExbrLftVJF6K9WTaXhwolOt
	/JVMsv08eo6QefShL7Nsh6MSWjj0YUv6bdXqfd5gorogCmaFZbM/HoCAhCoDDcEcDgD0JqNlvV7zc
	dTf1BGCvplRFsggSykG019iAh7Ga6cqdWyjcR3FEANn2XAWHBDrrcbNjNHgHWam7nasQyx2vrjOix
	LTF75HjL3Z9W/DrT4brZ//LNx3hYfrNDFDC12CzNETFBI2QMg4kQNRFW7LZ/23pcN2k/ghoKvPfI2
	Zr2DxEHdCdrpcyhTDn9ebRb8UBXKlqHQCXos/sPvJJLTjAjoO8S14+7brQ5SGF3qI6iHUKIJhwE++
	y7Wi2cvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9N3T-0000000630i-2tu5;
	Mon, 28 Apr 2025 11:53:47 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Map-00000005wex-0f5i
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 11:24:12 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39ee57c0b8cso5479897f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 28 Apr 2025 04:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745839449; x=1746444249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1tOQA/b/pMHqe437Sqwyo/kDl3saypAMc7dZp8vas0=;
        b=l3sSCjpxR1z3ZyGzVDhh4sHnOQQ+omrgP9W6CsMEzNv5NVbzs+R+NkEYM9Vt9NDvix
         bCj7EdHqQKXP1A4a2MbV9Jj1rLNNjD7Ds2Fj4ZglQkQPPOTiYDDTPq3SM7oXA7xVYYb9
         tQQgpVEP28FZdZNUCMTei4ijYR0ULVhTS7THqC6Llv10SW1ecdIsYEulRfzv53OR1Vy6
         PNjq/9YVRsdL2mSAET01KOxxiIgAFjaxX/5F1nryRmSVgUI6vc4TZv1sG63oLCiGzIRE
         l4W2RVDRguXYNNh9mkP+hK82Xh0NmZwJxSThuWyDqL4hnXfvEbflQw0jnvKYw8hEFV/H
         v/lA==
X-Forwarded-Encrypted: i=1; AJvYcCUWOzp51QVna5p2+xC8W2otT4dLv+kx4stAZgjiKFxOshLBa7U9mMM3Y8/1FRq94NGVrAmDKVKNfvzw@lists.infradead.org
X-Gm-Message-State: AOJu0Yz6m+KdozPZ+jh65i/5HE5XUKW24zn2fIeV0nPrYWQkd2tHqJcD
	V456ltt6qkQQEISlMG0I9qIorO8/hKL+7WecN1Z9fqsWw3OsiHQU
X-Gm-Gg: ASbGncsgvfrKpTjyPBDvgXibZ+lu6Qjz1IWMaEsbwRy1IXZQYsXNIgc6DOPrhbN0FLs
	b+jzB9eZioa7zG0RJg6GOA8u6Xni7RmLLMgsTMERpgU9DxcRlyyqV+7t3MOapsvgY5zszZjHVjH
	oZaf7RwGMRscGsiYtHukxNd0xS4ojyiNKZTQDW/YYKXtq6N5KeqgPvfG3hOHl4udTqW6Ecky5ll
	lW8qmh6kdG3wjsNAIsoP4BDfCQOd/GzyaeeNsu83CVuBYWQoZTCeYx7bMsSIA28d34+KQLJu4B9
	e2aetZWs08MuzjL7IDgghrX7SDC8JE/yja6yg8PmcEZNGaGV4k+ydTU73VmYH3GGsyW07g8zPMb
	ESht7UA==
X-Google-Smtp-Source: AGHT+IHreyHuqObrkOQKzFpGWo8vmiTDLJUOwr8C/Upu8qp6zVqR1iSr0BUl6UBLFxnM5R8MjYg8RA==
X-Received: by 2002:a05:6000:40cb:b0:39e:cbf2:4344 with SMTP id ffacd0b85a97d-3a074e145d1mr7446732f8f.4.1745839448838;
        Mon, 28 Apr 2025 04:24:08 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5d4b0sm10779914f8f.89.2025.04.28.04.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 04:24:08 -0700 (PDT)
Message-ID: <19fd0bee-2c1b-43c5-92ab-85323b918663@grimberg.me>
Date: Mon, 28 Apr 2025 14:24:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-tcp: sanitize request list handling
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Kamaljit Singh <kamaljit.singh@wdc.com>
References: <20250428065040.32663-1-hare@kernel.org>
 <20250428065040.32663-2-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250428065040.32663-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_042411_198016_14CB95AE 
X-CRM114-Status: GOOD (  14.82  )
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



On 28/04/2025 9:50, Hannes Reinecke wrote:
> Validate the request in nvme_tcp_handle_r2t() to ensure it's not
> part of any list, otherwise a malicious R2T PDU might inject a
> loop in request list processing.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/tcp.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index a9d455c39652..10ccd7cf5b8c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -452,7 +452,8 @@ nvme_tcp_fetch_request(struct nvme_tcp_queue *queue)
>   			return NULL;
>   	}
>   
> -	list_del(&req->entry);
> +	list_del_init(&req->entry);
> +	init_llist_node(&req->lentry);
>   	return req;
>   }
>   
> @@ -560,6 +561,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
>   	req->queue = queue;
>   	nvme_req(rq)->ctrl = &ctrl->ctrl;
>   	nvme_req(rq)->cmd = &pdu->cmd;
> +	init_llist_node(&req->lentry);
> +	INIT_LIST_HEAD(&req->entry);
>   
>   	return 0;
>   }
> @@ -764,6 +767,15 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
>   		return -EPROTO;
>   	}
>   
> +	if (queue->request == req ||

This is wrong, please remove this condition. queue->request can still 
reference the
request when handling r2t.

