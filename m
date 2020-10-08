Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E88BC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 22:44:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98ABD22243
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 22:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XD89Dxyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98ABD22243
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FuXbFBXJYBT6UGxPANBTm7CH0uwTUiRCzPVCj7mDDSs=; b=XD89DxyzEhWMQF9JAMKKFORbG
	i6o42QV1+iSopVvKvJqglFHA9hOYpzOOm60gsHBPWd4xR14/NugJW1Ok0HNZN9vLee060htTyThqN
	g1wlGczzqoRPPo2qL/sWvf8YqAQVzehTV2IYxYWM/F90eg06U5LcmsDapPOXiB69kDXJcyZY0IW71
	BpXGtidwfIpXJ9IoWfWOd8DZ2zafK1JvD04o4++AC+94Ylev3+OSoWU5GLpk4X5j+vwQU/k1vh1E4
	PUQAAZxnX7v8gjPu39o9zPuCfhxFmC/RydDim3YSZMoKSH8sktLBBPEuHjn2ppiwe5ThcmVy+v5BA
	TXlN0wwQA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQee2-0004ES-6G; Thu, 08 Oct 2020 22:44:18 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQedz-0004E7-3w
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 22:44:16 +0000
Received: by mail-wm1-f66.google.com with SMTP id d81so7982101wmc.1
 for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2020 15:44:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QoGWFApjFmPwuVg12KwUBchVevUx69KKitnsFYiHYbc=;
 b=GLQDD6EGyWmV4miZMaQUTzL3hFMYAyAiLjt/eaLaild4KT7CEcvwS+39hLWqf7aGUh
 g1ya7smgHrmEwVL4MrDUcN578kiO/N+emwpBa0mtsZ9DKrVucR5dtkEm50oAiKcRRRd5
 Lh2dkxRANARnoXJ3pCEkKR17XeTzQ9nqJQfp9sSfiKSbazHe9RxLzECo7PZ+cbPLeztA
 /muwtRNaZBJWRmk+bP59U7kFX13aeg73p5pVjPz4+LLyg5mi9q1zU1VZleufFsJ7jbRX
 IMIXNUzBFSCKAc7Pzl1uMw6cH5eEk4kiuvyH1k83LByWu59Cu9rEwtLPrWW+2xhxo+Dd
 G4JQ==
X-Gm-Message-State: AOAM5313Jxmq7j/bnk98LPXHAG2myESU+JZpiP+MG1PuFHgKRs62k+Ea
 /AuWVJWBsnNSemI+F1/iEnA=
X-Google-Smtp-Source: ABdhPJzgcX5y4mU2wOcsCl5+4e1DVM3ehj2OxfpvOLh3sIZTwoDl6cDzFfMQUx5uVXrz88K3ILsGfA==
X-Received: by 2002:a7b:c189:: with SMTP id y9mr10450864wmi.141.1602197053671; 
 Thu, 08 Oct 2020 15:44:13 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:68d6:3fd5:5a8b:9959?
 ([2601:647:4802:9070:68d6:3fd5:5a8b:9959])
 by smtp.gmail.com with ESMTPSA id 40sm9600575wrc.46.2020.10.08.15.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 15:44:13 -0700 (PDT)
Subject: Re: [PATCH net-next RFC v1 07/10] nvme-tcp : Recalculate crc in the
 end of the capsule
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-8-borisp@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a17cf1ca-4183-8f6c-8470-9d45febb755b@grimberg.me>
Date: Thu, 8 Oct 2020 15:44:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930162010.21610-8-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_184415_177730_12AB860A 
X-CRM114-Status: GOOD (  28.77  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Ben Ben-Ishay <benishay@mellanox.com>,
 boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> crc offload of the nvme capsule. Check if all the skb bits
> are on, and if not recalculate the crc in SW and check it.

Can you clarify in the patch description that this is only
for pdu data digest and not header digest?

> 
> This patch reworks the receive-side crc calculation to always
> run at the end, so as to keep a single flow for both offload
> and non-offload. This change simplifies the code, but it may degrade
> performance for non-offload crc calculation.

??

 From my scan it doeesn't look like you do that.. Am I missing something?
Can you explain?

> 
> Signed-off-by: Boris Pismenny <borisp@mellanox.com>
> Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
> Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
> Signed-off-by: Yoray Zack <yorayz@mellanox.com>
> ---
>   drivers/nvme/host/tcp.c | 66 ++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 58 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7bd97f856677..9a620d1dacb4 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -94,6 +94,7 @@ struct nvme_tcp_queue {
>   	size_t			data_remaining;
>   	size_t			ddgst_remaining;
>   	unsigned int		nr_cqe;
> +	bool			crc_valid;
>   
>   	/* send state */
>   	struct nvme_tcp_request *request;
> @@ -233,6 +234,41 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
>   	return nvme_tcp_pdu_data_left(req) <= len;
>   }
>   
> +static inline bool nvme_tcp_device_ddgst_ok(struct nvme_tcp_queue *queue)

Maybe call it nvme_tcp_ddp_ddgst_ok?

> +{
> +	return queue->crc_valid;
> +}
> +
> +static inline void nvme_tcp_device_ddgst_update(struct nvme_tcp_queue *queue,
> +						struct sk_buff *skb)

Maybe call it nvme_tcp_ddp_ddgst_update?

> +{
> +	if (queue->crc_valid)
> +#ifdef CONFIG_TCP_DDP_CRC
> +		queue->crc_valid = skb->ddp_crc;
> +#else
> +		queue->crc_valid = false;
> +#endif
> +}
> +
> +static void nvme_tcp_crc_recalculate(struct nvme_tcp_queue *queue,
> +				     struct nvme_tcp_data_pdu *pdu)

Maybe call it nvme_tcp_ddp_ddgst_recalc?

> +{
> +	struct nvme_tcp_request *req;
> +	struct request *rq;
> +
> +	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
> +	if (!rq)
> +		return;
> +	req = blk_mq_rq_to_pdu(rq);
> +	crypto_ahash_init(queue->rcv_hash);
> +	req->ddp.sg_table.sgl = req->ddp.first_sgl;
> +	/* req->ddp.sg_table is allocated and filled in nvme_tcp_setup_ddp */
> +	ahash_request_set_crypt(queue->rcv_hash, req->ddp.sg_table.sgl, NULL,
> +				le32_to_cpu(pdu->data_length));
> +	crypto_ahash_update(queue->rcv_hash);
> +}
> +
> +
>   #ifdef CONFIG_TCP_DDP
>   
>   bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
> @@ -706,6 +742,7 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
>   	queue->pdu_offset = 0;
>   	queue->data_remaining = -1;
>   	queue->ddgst_remaining = 0;
> +	queue->crc_valid = true;
>   }
>   
>   static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
> @@ -955,6 +992,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   	struct nvme_tcp_request *req;
>   	struct request *rq;
>   
> +	if (test_bit(NVME_TCP_Q_OFFLOADS, &queue->flags))
> +		nvme_tcp_device_ddgst_update(queue, skb);

Is the queue->data_digest condition missing here?

>   	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	if (!rq) {
>   		dev_err(queue->ctrl->ctrl.device,
> @@ -992,7 +1031,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		recv_len = min_t(size_t, recv_len,
>   				iov_iter_count(&req->iter));
>   
> -		if (queue->data_digest)
> +		if (queue->data_digest && !test_bit(NVME_TCP_Q_OFFLOADS, &queue->flags))
>   			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
>   				&req->iter, recv_len, queue->rcv_hash);

This is the skb copy and hash, not clear why you say that you move this
to the end...

>   		else
> @@ -1012,7 +1051,6 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   
>   	if (!queue->data_remaining) {
>   		if (queue->data_digest) {
> -			nvme_tcp_ddgst_final(queue->rcv_hash, &queue->exp_ddgst);

If I instead do:
			if (!test_bit(NVME_TCP_Q_OFFLOADS,
                                       &queue->flags))
				nvme_tcp_ddgst_final(queue->rcv_hash,
						     &queue->exp_ddgst);

Does that help the mess in nvme_tcp_recv_ddgst?

>   			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
>   		} else {
>   			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
> @@ -1033,8 +1071,11 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	char *ddgst = (char *)&queue->recv_ddgst;
>   	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
>   	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
> +	bool ddgst_offload_fail;
>   	int ret;
>   
> +	if (test_bit(NVME_TCP_Q_OFFLOADS, &queue->flags))
> +		nvme_tcp_device_ddgst_update(queue, skb);
>   	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
>   	if (unlikely(ret))
>   		return ret;
> @@ -1045,12 +1086,21 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	if (queue->ddgst_remaining)
>   		return 0;
>   
> -	if (queue->recv_ddgst != queue->exp_ddgst) {
> -		dev_err(queue->ctrl->ctrl.device,
> -			"data digest error: recv %#x expected %#x\n",
> -			le32_to_cpu(queue->recv_ddgst),
> -			le32_to_cpu(queue->exp_ddgst));
> -		return -EIO;
> +	ddgst_offload_fail = !nvme_tcp_device_ddgst_ok(queue);
> +	if (!test_bit(NVME_TCP_Q_OFFLOADS, &queue->flags) ||
> +	    ddgst_offload_fail) {
> +		if (test_bit(NVME_TCP_Q_OFFLOADS, &queue->flags) &&
> +		    ddgst_offload_fail)
> +			nvme_tcp_crc_recalculate(queue, pdu);
> +
> +		nvme_tcp_ddgst_final(queue->rcv_hash, &queue->exp_ddgst);
> +		if (queue->recv_ddgst != queue->exp_ddgst) {
> +			dev_err(queue->ctrl->ctrl.device,
> +				"data digest error: recv %#x expected %#x\n",
> +				le32_to_cpu(queue->recv_ddgst),
> +				le32_to_cpu(queue->exp_ddgst));
> +			return -EIO;

This gets convoluted here...

> +		}
>   	}
>   
>   	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
