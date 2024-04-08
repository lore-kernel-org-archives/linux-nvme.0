Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E2FBCD128A
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 11:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nQ6DQ04h7XxqEQlJ58olINd1bazmyIth4FxMT1Fp5/c=; b=OsQenZNP0XK1ixeFYN99l1Yxi7
	HV6uGw3764V2nK6jFUtIc3637HOy3pM627iWaewrxIxvqs2ieBZrKYEiDyJbyGYyxdWy/VvrAR2Z5
	P1T11ZmLGkrLZQGcnEXa+c4jFdOag4yzuZCwmo6SR31x6wKM9Eed4kWKJpozhO4TqgGZSZWfjcrpD
	OK4NqsxwJuiJSa4X7HPRwa2UAeEJF6PVKQ+kJ7F2yYG5vzPsv5dyB5xtcqD70XSRlINWk0prLV3SO
	YbOgTYYUu1aKQU+m78bw0zYCCDMLebPC4BG1TtOSsWRrZVRbCBDoxzC3QrjvZkWp6OImq+ov6WB+q
	gN98++5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtmrP-0000000FLPA-1k7v;
	Mon, 08 Apr 2024 11:08:23 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtmrL-0000000FLN9-3qHe
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 11:08:21 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-416463e82fbso1927475e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 08 Apr 2024 04:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712574497; x=1713179297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQ6DQ04h7XxqEQlJ58olINd1bazmyIth4FxMT1Fp5/c=;
        b=uZDw+yvSUmGi1zOQYxD8eq4Wy9meX2uRAbnOogpM7HlZ3byxA8i3631ypTcVb2AfUP
         Q7v9g7MsAu408VnCFKMg1xKFwUKtnjaX+HPy9M+S5i2VqKOHvZ0heOC/I454AakITD3+
         AAFB8BnhZSv67S+FXgZtfwt+ugqjoKsO9EVU4frqR6eupDeUY+5yiW2YkjRkNECKLe3T
         jDs3RxTC9XYszkVl6/7J3GHpu8zhqlPl7M5Va8LaQ5N49i4UmklXY8UW7wIR0IwCjCKO
         KGTG4ShmeBwNHTTs3dGtAcoxh68NraYw8dtEhjfc6iWh3yO4t6U5kT7FsWPqoUXGi/ma
         0Nhg==
X-Gm-Message-State: AOJu0YyLyGAUmT7beAxOb05cNVvJqdxUiReBEW4X1QP64pDYS3gpGt+u
	L6YOd45u6gzB9HtWD4Ap5p+ZSJX33SVxPkbFhJ/FV4mvd6Mon9dx
X-Google-Smtp-Source: AGHT+IGlB+AwLM1tm/S/XbatF+U8n43cJyXc98HsiW+jOlfnXt2j1JRV8yJYkgyxGslLBN6tWrPeFg==
X-Received: by 2002:a05:600c:3b96:b0:416:7b2c:df09 with SMTP id n22-20020a05600c3b9600b004167b2cdf09mr1180500wms.1.1712574497241;
        Mon, 08 Apr 2024 04:08:17 -0700 (PDT)
Received: from [10.50.4.160] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c468d00b004163059bb53sm11797208wmo.16.2024.04.08.04.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 04:08:16 -0700 (PDT)
Message-ID: <516a90cb-c03f-4474-8456-056bb3bd87fc@grimberg.me>
Date: Mon, 8 Apr 2024 14:08:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme-tcp: check for invalid request
To: soni.ankit@samsung.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, sathya.m@samsung.com,
 d.palani@samsung.com, prakash.bv@samsung.com, anshul@samsung.com,
 ankitvvsoni@gmail.com
References: <CGME20240408102150epcas5p2d5b4c3460fca7fe58520254a2466271b@epcas5p2.samsung.com>
 <20240408045328.542327-1-soni.ankit@samsung.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240408045328.542327-1-soni.ankit@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_040819_998553_EC453AA8 
X-CRM114-Status: GOOD (  19.96  )
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



On 08/04/2024 7:53, soni.ankit@samsung.com wrote:
> From: Ankit Soni <soni.ankit@samsung.com>
>
> The blk_mq_tag_to_rq() returns NULL for invalid tag.
> Added check condition to prevent NULL Pointer derefernece.

Does this fix an actual bug? Or a theoretic one?

>
> Signed-off-by: Ankit Soni <soni.ankit@samsung.com>
> ---
>   drivers/nvme/host/tcp.c | 34 ++++++++++++++++++++++------------
>   1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index fdbcdcedcee9..01a90bbed70b 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -801,9 +801,17 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   			      unsigned int *offset, size_t *len)
>   {
>   	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
> -	struct request *rq =
> -		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
> -	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	struct nvme_tcp_request *req;
> +	struct request *rq;
> +
> +	rq = nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
> +	if (unlikely(!rq)) {
> +		pr_err("could not locate request for tag %#x\n",
> +			pdu->command_id);
> +		return -EFAULT;
> +	}
> +
> +	req = blk_mq_rq_to_pdu(rq);

We already checked the validity when processing the c2hpdu, there is no 
need to do
that for all the data payload chunks as well as it does not change.

>   
>   	while (true) {
>   		int recv_len, ret;
> @@ -875,6 +883,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	char *ddgst = (char *)&queue->recv_ddgst;
>   	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
>   	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
> +	struct nvme_tcp_request *req;
> +	struct request *rq;
>   	int ret;
>   
>   	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
> @@ -887,13 +897,17 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	if (queue->ddgst_remaining)
>   		return 0;
>   
> -	if (queue->recv_ddgst != queue->exp_ddgst) {
> -		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
> -					pdu->command_id);
> -		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	rq = nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
> +	if (unlikely(!rq)) {
> +		pr_err("could not locate request for tag %#x\n",
> +			pdu->command_id);
> +		return -EFAULT;
> +	}

Same here, the ddgst comes as a trailer to a c2hdata pdu which we already
checked the validity, you are simply taking an already validated pdu and 
using
it. It is redundant.

>   
> -		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
> +	req = blk_mq_rq_to_pdu(rq);
>   
> +	if (queue->recv_ddgst != queue->exp_ddgst) {
> +		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
>   		dev_err(queue->ctrl->ctrl.device,
>   			"data digest error: recv %#x expected %#x\n",
>   			le32_to_cpu(queue->recv_ddgst),
> @@ -901,10 +915,6 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	}
>   
>   	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
> -		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
> -					pdu->command_id);
> -		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> -
>   		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
>   		queue->nr_cqe++;
>   	}


