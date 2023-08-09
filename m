Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3357C001B0
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 07:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2n8/6w7yhql79Lt1EY1uSKvblBxD8K1x2ezScZOM+lc=; b=oRJKngKx7wIbeVUFymOhrudujm
	VDcgWnnkKD6HX85O2XqFdtOD9Il8uZh3KLQuZ/9TQ3riOsKv1/iS37TmkgNcJQXtY0g2lIyN4h1JY
	0uIu9ujoFjk4OHeKtCRXf/dmY7NKve6/WB1ZmqpZBEap5ulyvziRk+YFuTdO3OQDckuFa/zJTJR0O
	ZXUtiaLKxMuRbQ6ZApMHOvVqBdCsPotaNaDoCR2KU3zD3BKMsz2VPamT0LtSIi09Br9UlsaYLAnRB
	CCdCqnkVJm/SOrp35wvG+ht29JhU3+JDr+B2F1qbWiscw2bhDwf4v+efz8OSLkrQEI9NUCzqbqilT
	eOWROuKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTe6A-004JX9-34;
	Wed, 09 Aug 2023 07:59:18 +0000
Received: from mail-lj1-f174.google.com ([209.85.208.174])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTe68-004JWl-0A
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 07:59:17 +0000
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b73261babdso19993891fa.1
        for <linux-nvme@lists.infradead.org>; Wed, 09 Aug 2023 00:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691567954; x=1692172754;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2n8/6w7yhql79Lt1EY1uSKvblBxD8K1x2ezScZOM+lc=;
        b=F0eKciYBOmq8KLIJGQfdFbHiNxklZzeGdkejwpIs8U60SdF8KH4MiMI58hdfJcoG/d
         Sq+k7fqouXlTRyZQaJ8a4vJLP86IgDdxwCJ/+Lp9RLWX86OZP5Wo1leJkzBgjuEdLlnf
         x3+6lkQ9JuIT12GK8iYll8DMY+qywsJc+EfsnW1hsHuKcPYtrTVxPQKPpEgLCJiye5bC
         3S0tCb4m6MxI38ai1xGrY6n7qPLwQNzAJ1TD6qYV3sFa6a10zJtXaRTLX0YZrpMMGfj4
         8a+Ee2ZlfVSn19XyTDDhiheGCTIilP45EXiabC+de+O6Yulu2AvjLjv0/sUCiaJNE0IF
         9kwg==
X-Gm-Message-State: AOJu0YztCE46pwmZZrOorxLtCxlK5dqRNWz6lXq7C53oZlyLUH+cq4ez
	47KSVOgUFxXamVO257aiq/I=
X-Google-Smtp-Source: AGHT+IHX9MdDgYZ/P3MqcMC4IJ3QItCoeNGeGhTKAzymUrtzwvr890CzYwmE/X8qCOrmaiSs+eZXEQ==
X-Received: by 2002:a05:651c:c8a:b0:2b6:cd7f:5ea8 with SMTP id bz10-20020a05651c0c8a00b002b6cd7f5ea8mr1388775ljb.1.1691567953660;
        Wed, 09 Aug 2023 00:59:13 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s12-20020a1709067b8c00b00992b50fbbe9sm7691220ejo.90.2023.08.09.00.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 00:59:13 -0700 (PDT)
Message-ID: <2a75b296-edff-3151-7c6e-22209f09a100@grimberg.me>
Date: Wed, 9 Aug 2023 10:59:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 09/26] nvme-tcp: RX DDGST offload
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-10-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230712161513.134860-10-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_005916_108826_2859C6A0 
X-CRM114-Status: GOOD (  34.37  )
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



On 7/12/23 19:14, Aurelien Aptel wrote:
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
> ---
>   drivers/nvme/host/tcp.c | 120 +++++++++++++++++++++++++++++++++++++---
>   1 file changed, 112 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 6057cd424a19..df58668cbad6 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -130,6 +130,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
>   	NVME_TCP_Q_OFF_DDP	= 3,
> +	NVME_TCP_Q_OFF_DDGST_RX = 4,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -168,6 +169,7 @@ struct nvme_tcp_queue {
>   	 */
>   	atomic64_t		resync_req;
>   	struct ulp_ddp_limits	ddp_limits;
> +	bool			ddp_ddgst_valid;
>   #endif
>   
>   	/* send state */
> @@ -358,9 +360,29 @@ static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
>   	if (test_bit(ULP_DDP_C_NVME_TCP_BIT, netdev->ulp_ddp_caps.active))
>   		return true;
>   
> +	/*
> +	 * Otherwise, if netdev supports nvme-tcp ddgst offload and it
> +	 * was enabled, we can offload
> +	 */
> +	if (queue->data_digest && test_bit(ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
> +					   netdev->ulp_ddp_caps.active))
> +		return true;
> +
>   	return false;
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
>   static int nvme_tcp_req_map_ddp_sg(struct nvme_tcp_request *req, struct request *rq)
>   {
>   	int ret;
> @@ -375,6 +397,38 @@ static int nvme_tcp_req_map_ddp_sg(struct nvme_tcp_request *req, struct request
>   	return 0;
>   }
>   
> +static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
> +				      struct request *rq,
> +				      __le32 *ddgst)
> +{
> +	struct nvme_tcp_request *req;
> +
> +	if (!rq)
> +		return;
> +
> +	req = blk_mq_rq_to_pdu(rq);
> +
> +	if (!req->offloaded) {
> +		/* if we have DDGST_RX offload without DDP the request
> +		 * wasn't mapped, so we need to map it here
> +		 */
> +		if (nvme_tcp_req_map_ddp_sg(req, rq))
> +			return;

grr.. wondering if this is something we want to support (crc without
ddp).

> +	}
> +
> +	req->ddp.sg_table.sgl = req->ddp.first_sgl;

Why is this assignment needed? why not pass req->ddp.first_sgl ?

> +	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, (u8 *)ddgst,
> +				req->data_len);
> +	crypto_ahash_digest(hash);
> +
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
> @@ -434,6 +488,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   {
>   	struct net_device *netdev = queue->ctrl->offloading_netdev;
>   	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
> +	bool offload_ddp = test_bit(ULP_DDP_C_NVME_TCP_BIT,
> +				    netdev->ulp_ddp_caps.active);
> +	bool offload_ddgst_rx = test_bit(ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
> +					 netdev->ulp_ddp_caps.active);
>   	int ret;
>   
>   	config.nvmeotcp.pfv = NVME_TCP_PFV_1_0;
> @@ -460,7 +518,10 @@ static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   	}
>   
>   	inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = &nvme_tcp_ddp_ulp_ops;
> -	set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +	if (offload_ddp)
> +		set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +	if (queue->data_digest && offload_ddgst_rx)
> +		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
>   	return 0;
>   }
>   
> @@ -474,6 +535,7 @@ static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
>   	}
>   
>   	clear_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +	clear_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
>   
>   	netdev->netdev_ops->ulp_ddp_ops->sk_del(netdev, queue->sock->sk);
>   
> @@ -562,6 +624,20 @@ static inline bool is_netdev_ulp_offload_active(struct net_device *netdev,
>   	return false;
>   }
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
>   static int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue, u16 command_id,
>   			      struct request *rq)
>   {
> @@ -844,6 +920,9 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
>   	queue->pdu_offset = 0;
>   	queue->data_remaining = -1;
>   	queue->ddgst_remaining = 0;
> +#ifdef CONFIG_ULP_DDP
> +	queue->ddp_ddgst_valid = true;
> +#endif
>   }
>   
>   static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
> @@ -1047,7 +1126,8 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
>   	int ret;
>   
> -	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) ||
> +	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))

This now becomes two atomic bitops to check for each capability, where
its more likely that neighther are on...

Is this really racing with anything? maybe just check with bitwise AND?
or a local variable (or struct member)
I don't think that we should add any more overhead for the normal path
than we already have.

>   		nvme_tcp_resync_response(queue, skb, *offset);
>   
>   	ret = skb_copy_bits(skb, *offset,
> @@ -1111,6 +1191,10 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   
> +	if (queue->data_digest &&
> +	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))

And a third atomic bitop..

> +		nvme_tcp_ddp_ddgst_update(queue, skb);
> +
>   	while (true) {
>   		int recv_len, ret;
>   
> @@ -1139,7 +1223,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		recv_len = min_t(size_t, recv_len,
>   				iov_iter_count(&req->iter));
>   
> -		if (queue->data_digest)
> +		if (queue->data_digest &&
> +		    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))

and a 4'th atomic bitop...

>   			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
>   				&req->iter, recv_len, queue->rcv_hash);
>   		else
> @@ -1181,8 +1266,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	char *ddgst = (char *)&queue->recv_ddgst;
>   	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
>   	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
> +	struct request *rq;
>   	int ret;
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
> +		nvme_tcp_ddp_ddgst_update(queue, skb);

and a 5'th atomic bitop...

>   	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
>   	if (unlikely(ret))
>   		return ret;
> @@ -1193,9 +1281,25 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	if (queue->ddgst_remaining)
>   		return 0;
>   
> +	rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
> +			    pdu->command_id);
> +
> +	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags)) {

and a 6'th... ok this is just spraying atomic bitops on the data
path. Please find a better solution to this.

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
> @@ -1206,9 +1310,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   			le32_to_cpu(queue->exp_ddgst));
>   	}
>   
> +out:
>   	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
> -		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
> -					pdu->command_id);
>   		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   
>   		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
> @@ -2125,7 +2228,8 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
>   	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>   	nvme_tcp_restore_sock_ops(queue);
>   	cancel_work_sync(&queue->io_work);
> -	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) ||
> +	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
>   		nvme_tcp_unoffload_socket(queue);
>   }
>   

