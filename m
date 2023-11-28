Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B08B1C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mjJxS7p9+IiDxE6FTR+YE31h+D0ZFJ7s2N4nV3VgPJA=; b=00G0WPoJ8dqLCO8L7mJyxjB9tC
	C8hE2YkzeJBEWYX8MpIS53ceGXgqMfns8dKwQX/xnKmy64HyvmyI+WIANVvblXeTpL6ilOOQYh1Ww
	8FfDY/K4peiQHCaWtLwwQQGORz0H20lVSx8JjWKzYxJpCA/3lLA+i3XpgvniMUfKpYTF/gsdLMgFd
	M1Sw4PDxcTT1d8kb8EshPInfmHvqs5FXhXOO2NUXyDrtzGpFYo2H2sxZtZfoUtoi40HhH41XeRgoR
	didu8jTwHYCCqCKLNaNgntYothsPj5hOKEb4Brw8C3wdeE1TyNUoyehieOHl12LH7Xwb/SBhuXUY5
	fndnBgmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7vVr-004wtd-0d;
	Tue, 28 Nov 2023 10:40:19 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7vVo-004wsf-0g
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 10:40:17 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40b3febbce3so3525745e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 28 Nov 2023 02:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701168013; x=1701772813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjJxS7p9+IiDxE6FTR+YE31h+D0ZFJ7s2N4nV3VgPJA=;
        b=XV/feKO3Y2AJwslb0MEwGF68xKlybGV0DaLgpbfZ6ZcGrJhEgAXgk0qMpcD0nEk3cr
         to1v0iLYj7DH+Bimkx+rko6QbP8TL4wj8dlLAYMU1vtHImNqMgF2MY9CC+VNsSYYTinR
         5tTebFX+War/jm1zXydW0hrXaVL5lAgQ2E5OKTZ8VU949sYUSnybfqgGu3cNQuw1ELRW
         Y8odJZJWm9y63a0mXC4Ms2z725XOh0hRTXq6fjrjsiAhc6EWRGELuzIDyZh7kLKivxl4
         Qv4J35D958ijZwfBBYik6UkGR7wIO9xa1Yu6VRM9RzZ2wLC4rmrNZ3Ei7pUhmF70IdNy
         0gSQ==
X-Gm-Message-State: AOJu0YwTG1ckss0IzgwaRSWWVT5F8XaNXoPdSceWYvNESXTXCk4TRinN
	qhWZ1wWV+IyijQrwtR7es1s=
X-Google-Smtp-Source: AGHT+IG1SegaRk+FvFxzQk6OH1r5/1kqkxH9cQpJkjhv34SFVg1FDEkwJzI7ieHTPkIjT3+f6SDL0Q==
X-Received: by 2002:a05:600c:3b0c:b0:40b:2708:2a52 with SMTP id m12-20020a05600c3b0c00b0040b27082a52mr10198925wms.1.1701168013235;
        Tue, 28 Nov 2023 02:40:13 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id jg28-20020a05600ca01c00b004063cd8105csm17665570wmb.22.2023.11.28.02.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:40:12 -0800 (PST)
Message-ID: <84efdc69-364f-43fc-9c7a-0fbcab47571b@grimberg.me>
Date: Tue, 28 Nov 2023 12:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 06/20] nvme-tcp: Add DDP data-path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20231122134833.20825-1-aaptel@nvidia.com>
 <20231122134833.20825-7-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231122134833.20825-7-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_024016_251893_9A356B07 
X-CRM114-Status: GOOD (  13.12  )
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


> +static void nvme_tcp_complete_request(struct request *rq,
> +				      __le16 status,
> +				      union nvme_result result,
> +				      __u16 command_id)
> +{
> +#ifdef CONFIG_ULP_DDP
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	if (req->offloaded) {
> +		req->ddp_status = status;

unless this is really a ddp_status, don't name it as such. afiact
it is the nvme status, so lets stay consistent with the naming.

btw, for making the code simpler we can promote the request
status/result capture out of CONFIG_ULP_DDP to the general logic
and then I think the code will look slightly simpler.

This will be consistent with what we do in nvme-rdma and PI.

> +		req->result = result;
> +		nvme_tcp_teardown_ddp(req->queue, rq);
> +		return;
> +	}
> +#endif
> +
> +	if (!nvme_try_complete_req(rq, status, result))
> +		nvme_complete_rq(rq);
> +}
> +
>   static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		struct nvme_completion *cqe)
>   {
> @@ -772,10 +865,9 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
>   		req->status = cqe->status;
>   
> -	if (!nvme_try_complete_req(rq, req->status, cqe->result))
> -		nvme_complete_rq(rq);
> +	nvme_tcp_complete_request(rq, req->status, cqe->result,
> +				  cqe->command_id);
>   	queue->nr_cqe++;
> -
>   	return 0;
>   }
>   
> @@ -973,10 +1065,13 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   
>   static inline void nvme_tcp_end_request(struct request *rq, u16 status)
>   {
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	struct nvme_tcp_queue *queue = req->queue;
> +	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
>   	union nvme_result res = {};
>   
> -	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
> -		nvme_complete_rq(rq);
> +	nvme_tcp_complete_request(rq, cpu_to_le16(status << 1), res,
> +				  pdu->command_id);
>   }
>   
>   static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> @@ -1283,6 +1378,9 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>   	else
>   		msg.msg_flags |= MSG_EOR;
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +		nvme_tcp_setup_ddp(queue, blk_mq_rq_from_pdu(req));
> +

We keep coming back to this. Why isn't setup done at setup time?

