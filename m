Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21EFC54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 09:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2jYCYIkiLKOmH3hbqFdCsnIQYuJXKlJhi19cZlr5ON8=; b=MTHfyxNcCRJTLyOXl7ETkERTyg
	55z+7dQe0JDbup6rFASzEqhA41yfVyqQnIoPdEjY40UtaAkAFCCM6dHp05dqcysctlDO2HUgG04sz
	jRIgSr6RJJMaRXvxVOQUMi6gZ1pOZu8ny1cpf1IwG9z21SzMQ6sys1UWslSBroFar1Sd/Sfais25o
	2BpDegUef++Z159WGId+Q2P31M4QGZK4alQeFhESourekZDTE/Xkz6+x1p8t26bP876z542NS/gXV
	qlnU1nFKIFq+/nQa+8CzjYYxDWcRiUQ3a9qV5CpC09toqZ8CZ2QpGy8tQ4sc6trqcSRSr+nLJ+15n
	RWeRrPWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri9tG-00000003oBW-0ZtU;
	Thu, 07 Mar 2024 09:18:14 +0000
Received: from mail-lf1-f42.google.com ([209.85.167.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri9tB-00000003o7f-3l7s
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 09:18:12 +0000
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5132bd70e7dso170782e87.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 01:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709803088; x=1710407888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jYCYIkiLKOmH3hbqFdCsnIQYuJXKlJhi19cZlr5ON8=;
        b=hXHNmLia/igoNkHk7KmAuyaHVrM31X2Av/JQ80Xpep2S18cNKpqzrEID6czul6r5DQ
         DpUmWnQRR+yU/az9W4CioMBZO2SXn5f9sbJ8UnMBt/Ez2CdWw+rJGz6bOHGTz6XeJMe/
         tj/y8f0C/BreWVN9u3AA0Bv7QXVFLUG55l6Cr6DePWNBOEzmHU7GYntnIKOY2BuMA4Xi
         TSd3Dzb8y2f3WR9s5sf3M+N24Z/jeiFj2sJT4RjcRO7DfKlkE525OD2Zh3UMgdYo8KkW
         svLaFr+OCdcqLgzsvh93PYZ5IvqYrtVHCcQsIY+WS9CG0LjGBvQy+NavDFZ3diEZ9kaW
         hBTg==
X-Forwarded-Encrypted: i=1; AJvYcCVMGiAnyOjaoZiAwSMvDXgODtHNIx8r5Y0bXyMh+Bgzfyo/lj9n2hSYJCcj2q5SLhroT3ROb4KPZ2wMSOEgL0LRQB3gt0wRgISz5NHZYo0=
X-Gm-Message-State: AOJu0YzMENYVdD66FnN3dPcl8zq2SSIz9T+oYaplZ8RgaFB+h/L9bmVh
	a/tUPhJCIUsYbY6YCGDzgTPOssnkudrAxRB3R2WBBrFg7OOhaYT8PuS++l5e
X-Google-Smtp-Source: AGHT+IF7wqY42WTgiTtIvAx5OyS1uQdFyLA+BiVAmSiZ3OAEcCIBjGOAnMKh5E/fHC/RqFQXo1+CNQ==
X-Received: by 2002:a19:771c:0:b0:513:30fd:2991 with SMTP id s28-20020a19771c000000b0051330fd2991mr923434lfc.0.1709803087808;
        Thu, 07 Mar 2024 01:18:07 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id c6-20020a05600c0a4600b00412f2136793sm2061506wmq.44.2024.03.07.01.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 01:18:07 -0800 (PST)
Message-ID: <91318572-af38-464c-9c7a-4f6d1f642eee@grimberg.me>
Date: Thu, 7 Mar 2024 11:18:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 07/20] nvme-tcp: RX DDGST offload
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20240228125733.299384-1-aaptel@nvidia.com>
 <20240228125733.299384-8-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240228125733.299384-8-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_011810_122950_02C26652 
X-CRM114-Status: GOOD (  29.10  )
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



On 28/02/2024 14:57, Aurelien Aptel wrote:
> From: Yoray Zack <yorayz@nvidia.com>
>
> Enable rx side of DDGST offload when supported.
>
> At the end of the capsule, check if all the skb bits are on, and if not
> recalculate the DDGST in SW and check it.
>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/tcp.c | 96 ++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 91 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index b7cfe14661d6..2eebd9d2aee5 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -143,6 +143,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
>   	NVME_TCP_Q_OFF_DDP	= 3,
> +	NVME_TCP_Q_OFF_DDGST_RX = 4,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -180,6 +181,7 @@ struct nvme_tcp_queue {
>   	 *   is pending (ULP_DDP_RESYNC_PENDING).
>   	 */
>   	atomic64_t		resync_tcp_seq;
> +	bool			ddp_ddgst_valid;
>   #endif
>   
>   	/* send state */
> @@ -393,6 +395,46 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
>   	return NULL;
>   }
>   
> +static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
> +{
> +	return queue->ddp_ddgst_valid;
> +}
> +
> +static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
> +					     struct sk_buff *skb)
> +{
> +	if (queue->ddp_ddgst_valid)
> +		queue->ddp_ddgst_valid = skb_is_ulp_crc(skb);
> +}
> +
> +static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
> +				      struct request *rq,
> +				      __le32 *ddgst)
> +{
> +	struct nvme_tcp_request *req;
> +
> +	req = blk_mq_rq_to_pdu(rq);
> +	if (!req->offloaded) {
> +		/* if we have DDGST_RX offload but DDP was skipped
> +		 * because it's under the min IO threshold then the
> +		 * request won't have an SGL, so we need to make it
> +		 * here
> +		 */
> +		if (nvme_tcp_ddp_alloc_sgl(req, rq))
> +			return;
> +	}
> +
> +	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, (u8 *)ddgst,
> +				req->data_len);
> +	crypto_ahash_digest(hash);
> +	if (!req->offloaded) {
> +		/* without DDP, ddp_teardown() won't be called, so
> +		 * free the table here
> +		 */
> +		sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
> +	}
> +}
> +
>   static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
>   static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
>   static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
> @@ -478,6 +520,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   		return ret;
>   
>   	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +	if (queue->data_digest &&
> +	    ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
> +				  ULP_DDP_CAP_NVME_TCP_DDGST_RX))
> +		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
>   
>   	return 0;
>   }
> @@ -485,6 +531,7 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
>   {
>   	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
>   	ulp_ddp_sk_del(queue->ctrl->ddp_netdev, queue->sock->sk);
>   }
>   
> @@ -593,6 +640,20 @@ static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
>   				     struct sk_buff *skb, unsigned int offset)
>   {}
>   
> +static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
> +{
> +	return false;
> +}
> +
> +static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
> +					     struct sk_buff *skb)
> +{}
> +
> +static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
> +				      struct request *rq,
> +				      __le32 *ddgst)
> +{}
> +
>   #endif
>   
>   static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
> @@ -853,6 +914,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
>   	queue->pdu_offset = 0;
>   	queue->data_remaining = -1;
>   	queue->ddgst_remaining = 0;
> +#ifdef CONFIG_ULP_DDP
> +	queue->ddp_ddgst_valid = true;
> +#endif
>   }
>   
>   static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
> @@ -1118,6 +1182,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
> +		nvme_tcp_ddp_ddgst_update(queue, skb);
> +
>   	while (true) {
>   		int recv_len, ret;
>   
> @@ -1146,7 +1213,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		recv_len = min_t(size_t, recv_len,
>   				iov_iter_count(&req->iter));
>   
> -		if (queue->data_digest)
> +		if (queue->data_digest &&
> +		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
>   			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
>   				&req->iter, recv_len, queue->rcv_hash);
>   		else
> @@ -1188,8 +1256,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	char *ddgst = (char *)&queue->recv_ddgst;
>   	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
>   	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
> +	struct request *rq;
>   	int ret;
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
> +		nvme_tcp_ddp_ddgst_update(queue, skb);
>   	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
>   	if (unlikely(ret))
>   		return ret;
> @@ -1200,9 +1271,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	if (queue->ddgst_remaining)
>   		return 0;
>   
> +	rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
> +			    pdu->command_id);
> +
> +	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags)) {
> +		/*
> +		 * If HW successfully offloaded the digest
> +		 * verification, we can skip it
> +		 */
> +		if (nvme_tcp_ddp_ddgst_ok(queue))
> +			goto out;
> +		/*
> +		 * Otherwise we have to recalculate and verify the
> +		 * digest with the software-fallback
> +		 */
> +		nvme_tcp_ddp_ddgst_recalc(queue->rcv_hash, rq,
> +					  &queue->exp_ddgst);
> +	}
> +
>   	if (queue->recv_ddgst != queue->exp_ddgst) {
> -		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
> -					pdu->command_id);
>   		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   
>   		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
> @@ -1213,9 +1300,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   			le32_to_cpu(queue->exp_ddgst));
>   	}
>   
> +out:

Nit: you can rename the label to ddgst_valid: or ddgst_ok:

Other than that,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

