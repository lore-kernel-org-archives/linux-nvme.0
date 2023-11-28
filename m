Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C127C4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 10:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YKVzGvl+LlWimuqcFatkZrJ/6x3ko69rmC3lpZC3FlM=; b=ohqWiZaCC7TyjXFZ8kYU7HU0H1
	B6huJHS80Bb1RXZTZkJ9dKydvHBXtEvyeW1DN9/1s1chcj3z5KYtfIaoMUsI/sLu1/8pUE+tzDDLB
	mNbW+7VCeV/cxoTdCtmmmZWNhc18Q1hbcky8kHg27DY7qskpejxChJjEMmUBrKvIs3CArdlZvamGC
	YTs46Bay/RO37aGrRQi6NXedbE2XbeKFhvqjG5eg7XhEsNhq35+nPuboYcXaV6TkDFSEeheggLECc
	p7RwfRhqa6F4mBpGbX8LHTkeKPJ4e7bLgfcA5zKPjyAfqw9gaNK5dcb38dc4FqN0kBcS9AOO6COuE
	p9Wc3ozQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7vYU-004xLh-29;
	Tue, 28 Nov 2023 10:43:02 +0000
Received: from mail-lj1-f173.google.com ([209.85.208.173])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7vYR-004xK7-0o
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 10:43:00 +0000
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2c9ace45341so1495311fa.0
        for <linux-nvme@lists.infradead.org>; Tue, 28 Nov 2023 02:42:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701168175; x=1701772975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKVzGvl+LlWimuqcFatkZrJ/6x3ko69rmC3lpZC3FlM=;
        b=QCtFj8iiB4TFyiX4FuMZAw7uiNynIkh+flVpeX0W33/Aa9hXOVvXDj0CVGOzkiieBr
         Nq+GiDjeDK1r4fnxHJMp7H6c2vb+3/JKF0WyyxP0LlHQCGNoWBMVLrVY7UktW2C93y7t
         5+VIz68oteMJni39lo+17OR+RbZ3Yz7FlWrxeLfBkmgxL/C4Hrj7EU8hgX25rYd9fGui
         47s3Oe1u/dAtROoFxGqlK7P6KEMDQAddZek12DbefRtZVbqM3ii9/Yha+Fn5DjBeMHSm
         8/mU4OM0Db/3hEdO0IQb1Anch5Uc6IJrhokJmIJXS4PkO0+cKTXdB+kidK3OF6lNNyNN
         f6Sw==
X-Gm-Message-State: AOJu0YxHNnBoLBCgbLmg9RyxvwR4tMpdq/gUUmU5woodeNhnstGyWaPX
	brhqIcpUSxFI46g+UgySTd7dIW0GTz8=
X-Google-Smtp-Source: AGHT+IHXqUOVAr2hEym0ib8T1psOwVqNhwmvdtSEWIcqlpLG702FVoysQYOEl62vAw3KRlfkq0+w6Q==
X-Received: by 2002:a2e:5404:0:b0:2c8:38b2:2c33 with SMTP id i4-20020a2e5404000000b002c838b22c33mr8507107ljb.3.1701168174702;
        Tue, 28 Nov 2023 02:42:54 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b0040b347d90d0sm17643343wmq.12.2023.11.28.02.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:42:54 -0800 (PST)
Message-ID: <bc6ec871-de51-477a-b27f-4d516e5bc3e1@grimberg.me>
Date: Tue, 28 Nov 2023 12:42:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 07/20] nvme-tcp: RX DDGST offload
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20231122134833.20825-1-aaptel@nvidia.com>
 <20231122134833.20825-8-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231122134833.20825-8-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_024259_292901_56E83D02 
X-CRM114-Status: GOOD (  20.96  )
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



On 11/22/23 15:48, Aurelien Aptel wrote:
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
>   drivers/nvme/host/tcp.c | 84 ++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 79 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 680d909eb3fb..5537f04a62fd 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -141,6 +141,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
>   	NVME_TCP_Q_OFF_DDP	= 3,
> +	NVME_TCP_Q_OFF_DDGST_RX = 4,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -178,6 +179,7 @@ struct nvme_tcp_queue {
>   	 *   is pending (ULP_DDP_RESYNC_PENDING).
>   	 */
>   	atomic64_t		resync_tcp_seq;
> +	bool			ddp_ddgst_valid;
>   #endif
>   
>   	/* send state */
> @@ -360,6 +362,33 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
>   	return netdev;
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
> +	if (!rq)
> +		return;

How is this even possible? And what happens down the road if this is
indeed a null rq?

> +
> +	req = blk_mq_rq_to_pdu(rq);
> +	ahash_request_set_crypt(hash, req->ddp.sg_table.sgl, (u8 *)ddgst,
> +				req->data_len);
> +	crypto_ahash_digest(hash);
> +}
> +
>   static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
>   static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
>   static const struct ulp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
> @@ -430,6 +459,8 @@ static void nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
>   static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   {
>   	struct ulp_ddp_config config = {.type = ULP_DDP_NVME};
> +	bool offload_ddgst_rx = ulp_ddp_is_cap_active(queue->ctrl->ddp_netdev,
> +						      ULP_DDP_CAP_NVME_TCP_DDGST_RX);

Not sure a local variable is needed here.

