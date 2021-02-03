Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDC2C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 09:07:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E066164F76
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 09:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E066164F76
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WIRgbkmFjWCy2AGt8YUDyf5NRzFdcY/m5AW/oo33Rn4=; b=I+Cm6iDvaLAsYj4W+Hvw3hdGe
	3jZaHRwXvmscQ+M3W7hzoN0unV5Za/wtP3ujJCCUzJIhd7tWzmo6ogKZgZQao8cCxdl/0DUEGlfE1
	spAAjP4aFTKh5M3whxKpzoGwJ/wn89QPEPihpFoikBW8BwGn6J86uViw1a0R6UOPYc1sRR5RflBoZ
	cZVUI2QFE9P1zy3V9WDL3DyuBy+d/sdHV+u0X4AyUeFpR9UW6yqIjToKhPXpwcl8Hs8tCoUHCUaj+
	e61eopiSD1I9RXXDo+ixSM9HoplF+wI9m3XrjR3pfnO15i2L+HCSVIX0yA+fUNdmgPijXuNHajXBA
	5RF78AF6A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7E7q-0001Ie-Gl; Wed, 03 Feb 2021 09:07:02 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7E7o-0001ID-OC
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 09:07:01 +0000
Received: by mail-wr1-f52.google.com with SMTP id b3so5133244wrj.5
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 01:07:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=g3fKcT/3fzsUqeyTRN+4L/vhOhFUdq1bKllMqkLEfFo=;
 b=rHOGu0HkC+G1RGcau5gpR+37qsCg8rsw75RuGuyKjDS7Kn1VHTthv0uc29gazAGAU7
 7V4JeuMhBoqO34RpXTQqkaUkOrhqTeDUvNjLntNzCTWWyJ+hU+shfjIj7ftG8wzziSOo
 s5jEYtb58z4ajj28dFA7TE6VZosZwoGpWZStSQ96bNKtpaTUiYc2fK0I5Zy7zNjlXVco
 2xMu2cRvWi4WE7svzE7gmUgKnPKfmMqzgf+ETgSVfF8r2hxQ33hOypAU64nRoWle+egH
 bdsX7dP38QAfEKyiuvF/dN7eiES8amZt0KgCXJpWUhMF+bBJcrVmycy4GSEjPpQZVCPP
 oySw==
X-Gm-Message-State: AOAM533T3MCUAnQXBG+nJZOQoONZambIafzl+q/Oy3d8rdZwz6XalYmi
 oUzF/igPfQ31b1h/cgE2cIc=
X-Google-Smtp-Source: ABdhPJw8Lr4Ml8OGBAA7KXvTQtu68lV0hL/jaaBz+hNNfrPBQyyfI6v8ZAv8PJR0Jsptp0kGWyO5iQ==
X-Received: by 2002:adf:d085:: with SMTP id y5mr2373359wrh.41.1612343219307;
 Wed, 03 Feb 2021 01:06:59 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:819b:e1e8:19a6:9008?
 ([2601:647:4802:9070:819b:e1e8:19a6:9008])
 by smtp.gmail.com with ESMTPSA id q6sm2430150wrw.43.2021.02.03.01.06.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Feb 2021 01:06:58 -0800 (PST)
Subject: Re: [PATCH v3 net-next 08/21] nvme-tcp : Recalculate crc in the end
 of the capsule
To: Boris Pismenny <borisp@mellanox.com>, dsahern@gmail.com, kuba@kernel.org, 
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com,
 smalin@marvell.com
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-9-borisp@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a104a5d1-b4cb-4275-6ced-b80f911b6f47@grimberg.me>
Date: Wed, 3 Feb 2021 01:06:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210201100509.27351-9-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_040700_853652_13F178BD 
X-CRM114-Status: GOOD (  31.70  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 benishay@nvidia.com, linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2/1/21 2:04 AM, Boris Pismenny wrote:
> From: Ben Ben-ishay <benishay@nvidia.com>
> 
> crc offload of the nvme capsule. Check if all the skb bits
> are on, and if not recalculate the crc in SW and check it.
> 
> This patch reworks the receive-side crc calculation to always
> run at the end, so as to keep a single flow for both offload
> and non-offload. This change simplifies the code, but it may degrade
> performance for non-offload crc calculation.
> 
> Signed-off-by: Boris Pismenny <borisp@mellanox.com>
> Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
> Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
> Signed-off-by: Yoray Zack <yorayz@mellanox.com>
> ---
>   drivers/nvme/host/tcp.c | 118 ++++++++++++++++++++++++++++++++--------
>   1 file changed, 95 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 5cb46deb56e0..eb47cf6982d7 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -69,6 +69,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
>   	NVME_TCP_Q_OFF_DDP	= 3,
> +	NVME_TCP_Q_OFF_DDGST_RX = 4,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -96,6 +97,7 @@ struct nvme_tcp_queue {
>   	size_t			data_remaining;
>   	size_t			ddgst_remaining;
>   	unsigned int		nr_cqe;
> +	bool			ddgst_valid;
>   
>   	/* send state */
>   	struct nvme_tcp_request *request;
> @@ -234,7 +236,56 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
>   	return nvme_tcp_pdu_data_left(req) <= len;
>   }
>   
> -#ifdef CONFIG_TCP_DDP
> +static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)
> +{
> +	return queue->ddgst_valid;
> +}
> +
> +static inline void nvme_tcp_ddp_ddgst_update(struct nvme_tcp_queue *queue,
> +					     struct sk_buff *skb)
> +{
> +	if (queue->ddgst_valid)
> +#ifdef CONFIG_TCP_DDP_CRC
> +		queue->ddgst_valid = skb->ddp_crc;
> +#else
> +		queue->ddgst_valid = false;
> +#endif
> +}
> +
> +static int nvme_tcp_req_map_sg(struct nvme_tcp_request *req, struct request *rq)
> +{
> +	int ret;
> +
> +	req->ddp.sg_table.sgl = req->ddp.first_sgl;
> +	ret = sg_alloc_table_chained(&req->ddp.sg_table, blk_rq_nr_phys_segments(rq),
> +				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
> +	if (ret)
> +		return -ENOMEM;
> +	req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
> +	return 0;
> +}
> +
> +static void nvme_tcp_ddp_ddgst_recalc(struct ahash_request *hash,
> +				      struct request *rq)
> +{
> +	struct nvme_tcp_request *req;
> +
> +	if (!rq)
> +		return;
> +
> +	req = blk_mq_rq_to_pdu(rq);
> +
> +	if (!req->offloaded && nvme_tcp_req_map_sg(req, rq))
> +		return;
> +
> +	crypto_ahash_init(hash);
> +	req->ddp.sg_table.sgl = req->ddp.first_sgl;
> +	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, NULL,
> +				le32_to_cpu(req->data_len));
> +	crypto_ahash_update(hash);
> +}
> +
> +#if defined(CONFIG_TCP_DDP) || defined(CONFIG_TCP_DDP_CRC)
>   
>   static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
>   static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
> @@ -290,12 +341,9 @@ int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
>   	}
>   
>   	req->ddp.command_id = command_id;
> -	req->ddp.sg_table.sgl = req->ddp.first_sgl;
> -	ret = sg_alloc_table_chained(&req->ddp.sg_table, blk_rq_nr_phys_segments(rq),
> -				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
> +	ret = nvme_tcp_req_map_sg(req, rq);

Why didn't you introduce nvme_tcp_req_map_sg in the first place?

>   	if (ret)
>   		return -ENOMEM;
> -	req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
>   
>   	ret = netdev->tcp_ddp_ops->tcp_ddp_setup(netdev,
>   						 queue->sock->sk,
> @@ -317,7 +365,7 @@ int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   		return -ENODEV;
>   	}
>   
> -	if (!(netdev->features & NETIF_F_HW_TCP_DDP)) {
> +	if (!(netdev->features & (NETIF_F_HW_TCP_DDP | NETIF_F_HW_TCP_DDP_CRC_RX))) {
>   		dev_put(netdev);
>   		return -EOPNOTSUPP;
>   	}
> @@ -345,6 +393,9 @@ int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   	if (netdev->features & NETIF_F_HW_TCP_DDP)
>   		set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
>   
> +	if (netdev->features & NETIF_F_HW_TCP_DDP_CRC_RX)
> +		set_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
> +
>   	return ret;
>   }
>   
> @@ -376,7 +427,7 @@ int nvme_tcp_offload_limits(struct nvme_tcp_queue *queue)
>   		return -ENODEV;
>   	}
>   
> -	if (netdev->features & NETIF_F_HW_TCP_DDP &&
> +	if ((netdev->features & (NETIF_F_HW_TCP_DDP | NETIF_F_HW_TCP_DDP_CRC_RX)) &&
>   	    netdev->tcp_ddp_ops &&
>   	    netdev->tcp_ddp_ops->tcp_ddp_limits)
>   		ret = netdev->tcp_ddp_ops->tcp_ddp_limits(netdev, &limits);
> @@ -739,6 +790,7 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
>   	queue->pdu_offset = 0;
>   	queue->data_remaining = -1;
>   	queue->ddgst_remaining = 0;
> +	queue->ddgst_valid = true;
>   }
>   
>   static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
> @@ -919,7 +971,8 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   
>   	u64 pdu_seq = TCP_SKB_CB(skb)->seq + *offset - queue->pdu_offset;
>   
> -	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) ||
> +	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
>   		nvme_tcp_resync_response(queue, pdu_seq);
>   
>   	ret = skb_copy_bits(skb, *offset,
> @@ -988,6 +1041,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   	struct nvme_tcp_request *req;
>   	struct request *rq;
>   
> +	if (queue->data_digest && test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
> +		nvme_tcp_ddp_ddgst_update(queue, skb);
>   	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	if (!rq) {
>   		dev_err(queue->ctrl->ctrl.device,
> @@ -1025,15 +1080,17 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		recv_len = min_t(size_t, recv_len,
>   				iov_iter_count(&req->iter));
>   
> -		if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) {
> -			if (queue->data_digest)
> +		if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) {
> +			if (queue->data_digest &&
> +			    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
>   				ret = skb_ddp_copy_and_hash_datagram_iter(skb, *offset,
>   						&req->iter, recv_len, queue->rcv_hash);
>   			else
>   				ret = skb_ddp_copy_datagram_iter(skb, *offset,
>   						&req->iter, recv_len);
>   		} else {
> -			if (queue->data_digest)
> +			if (queue->data_digest &&
> +			    !test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
>   				ret = skb_copy_and_hash_datagram_iter(skb, *offset,
>   						&req->iter, recv_len, queue->rcv_hash);
>   			else
> @@ -1055,7 +1112,6 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   
>   	if (!queue->data_remaining) {
>   		if (queue->data_digest) {
> -			nvme_tcp_ddgst_final(queue->rcv_hash, &queue->exp_ddgst);
>   			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
>   		} else {
>   			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
> @@ -1076,8 +1132,12 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	char *ddgst = (char *)&queue->recv_ddgst;
>   	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
>   	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
> +	bool offload_fail, offload_en;
> +	struct request *rq = NULL;
>   	int ret;
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
> +		nvme_tcp_ddp_ddgst_update(queue, skb);
>   	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
>   	if (unlikely(ret))
>   		return ret;
> @@ -1088,17 +1148,29 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	if (queue->ddgst_remaining)
>   		return 0;
>   
> -	if (queue->recv_ddgst != queue->exp_ddgst) {
> -		dev_err(queue->ctrl->ctrl.device,
> -			"data digest error: recv %#x expected %#x\n",
> -			le32_to_cpu(queue->recv_ddgst),
> -			le32_to_cpu(queue->exp_ddgst));
> -		return -EIO;
> +	offload_fail = !nvme_tcp_ddp_ddgst_ok(queue);
> +	offload_en = test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags);
> +	if (!offload_en || offload_fail) {
> +		if (offload_en && offload_fail) { // software-fallback
> +			rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
> +					      pdu->command_id);
> +			nvme_tcp_ddp_ddgst_recalc(queue->rcv_hash, rq);
> +		}
> +
> +		nvme_tcp_ddgst_final(queue->rcv_hash, &queue->exp_ddgst);
> +		if (queue->recv_ddgst != queue->exp_ddgst) {
> +			dev_err(queue->ctrl->ctrl.device,
> +				"data digest error: recv %#x expected %#x\n",
> +				le32_to_cpu(queue->recv_ddgst),
> +				le32_to_cpu(queue->exp_ddgst));
> +			return -EIO;
> +		}

I still dislike this hunk. Can you split the recalc login to its
own ddp function at least? This is just a confusing piece of code.

>   	}
>   
>   	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
> -		struct request *rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
> -						pdu->command_id);
> +		if (!rq)
> +			rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue),
> +					      pdu->command_id);

Why is this change needed? Maybe just move this assignment up?

>   
>   		nvme_tcp_end_request(rq, NVME_SC_SUCCESS);
>   		queue->nr_cqe++;
> @@ -1841,8 +1913,10 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
>   	nvme_tcp_restore_sock_calls(queue);
>   	cancel_work_sync(&queue->io_work);
>   
> -	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) ||
> +	    test_bit(NVME_TCP_Q_OFF_DDGST_RX, &queue->flags))
>   		nvme_tcp_unoffload_socket(queue);
> +

extra newline

>   }
>   
>   static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
> @@ -1970,8 +2044,6 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   {
>   	int ret;
>   
> -	to_tcp_ctrl(ctrl)->offloading_netdev = NULL;
> -

Unclear what is the intent here.

>   	ret = nvme_tcp_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
>   	if (ret)
>   		return ret;
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
