Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECDDC38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 22:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Flt81tUT9K3UaATK4lujeUZHrazrkrs23D7GikPeWkk=; b=LSUlnN6VGAHecjyi5vgrZ4BayG
	ggVrqpcDhckEpJ8NEIfO8mrDT8itlhXqWo6b9C8k4nVJvG1yNBiUxKm7x6//gVNUH/Pq3k+R0xPz3
	pAvqC1MTY6cM6t0t86xZSmUmz+PBLJiFuFu+sPeeB9+gLGIvZl0mUVnyU47bJbIiGUMyDWftw5Me/
	D0KHQJKRCdFD3D8RMAtMtocBuiLreFUUOaAj4HjAyKEcvdyvE3Svd4/C678icJ7cpggXXR6c704SO
	PymBoVog4qPzbfXZNo7WMnVtOEnW5yRjHU6/8nXdi/PqVv69RPAJbnjZtOi18vzQsZgxplv+6FNfx
	D4Q+wbeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onSa6-007Qie-QS; Tue, 25 Oct 2022 22:39:34 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onSa3-007Qha-KJ
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 22:39:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 178EA61BC5;
	Tue, 25 Oct 2022 22:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FF3C433D6;
	Tue, 25 Oct 2022 22:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666737567;
	bh=AoyyzEpnw+t2R29yjb3Gs/q5K+EEtgxfzfWYQ8Eg0H8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=INBfO1fWQAshPScb6xwVOFbgzjSajHIINoGcfavL7C66A1YvuVwiijdTmdj6gHkBx
	 kSPwtbSP5xEPY47NThEFHzUFjnMD8JxCpFbVZbi4xMOihHJ0e4/zXVZkfe4Tt6QBw5
	 umGQuv1AJz0B6634FMxgOt/E5xRa4q22GorC3vW+DOg9PisH7FP+XWlIjGGzg/jJkC
	 Ci0Z4n6qVd+Kk7ZuMKED5kYyc0DmubkwWOn6oJuOAuDjkUvpO4S+A7L7umKmC4b6ZE
	 YFv4RC4TJT/J2UI7gFl6HS0wwYQ/hYCEQ7DVIOf85JNCUobz3AkeJj9KHIjCgseKlE
	 WlQNojUuhX3wA==
Date: Tue, 25 Oct 2022 15:39:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, saeedm@nvidia.com, tariqt@nvidia.com, leon@kernel.org,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com, smalin@nvidia.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 aurelien.aptel@gmail.com, malin1024@gmail.com
Subject: Re: [PATCH v7 01/23] net: Introduce direct data placement tcp
 offload
Message-ID: <20221025153925.64b5b040@kernel.org>
In-Reply-To: <20221025135958.6242-2-aaptel@nvidia.com>
References: <20221025135958.6242-1-aaptel@nvidia.com>
	<20221025135958.6242-2-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_153931_774140_05CD37A7 
X-CRM114-Status: GOOD (  23.43  )
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

On Tue, 25 Oct 2022 16:59:36 +0300 Aurelien Aptel wrote:
> diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
> index 7c2d77d75a88..bf7391aa04c7 100644
> --- a/include/linux/netdev_features.h
> +++ b/include/linux/netdev_features.h
> @@ -14,7 +14,7 @@ typedef u64 netdev_features_t;
>  enum {
>  	NETIF_F_SG_BIT,			/* Scatter/gather IO. */
>  	NETIF_F_IP_CSUM_BIT,		/* Can checksum TCP/UDP over IPv4. */
> -	__UNUSED_NETIF_F_1,
> +	NETIF_F_HW_ULP_DDP_BIT,         /* ULP direct data placement offload */

Why do you need a feature bit if there is a whole caps / limit querying
mechanism? 

>  	NETIF_F_HW_CSUM_BIT,		/* Can checksum all the packets. */
>  	NETIF_F_IPV6_CSUM_BIT,		/* Can checksum TCP/UDP over IPV6 */
>  	NETIF_F_HIGHDMA_BIT,		/* Can DMA to high memory. */
> @@ -168,6 +168,7 @@ enum {
>  #define NETIF_F_HW_HSR_TAG_RM	__NETIF_F(HW_HSR_TAG_RM)
>  #define NETIF_F_HW_HSR_FWD	__NETIF_F(HW_HSR_FWD)
>  #define NETIF_F_HW_HSR_DUP	__NETIF_F(HW_HSR_DUP)
> +#define NETIF_F_HW_ULP_DDP	__NETIF_F(HW_ULP_DDP)
>  
>  /* Finds the next feature with the highest number of the range of start-1 till 0.
>   */
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index eddf8ee270e7..84554f26ad6b 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1043,6 +1043,7 @@ struct dev_ifalias {
>  
>  struct devlink;
>  struct tlsdev_ops;
> +struct ulp_ddp_dev_ops;

I thought forward declarations are not required for struct members, 
are they?

>  struct netdev_net_notifier {
>  	struct list_head list;
> @@ -2096,6 +2097,10 @@ struct net_device {
>  	const struct tlsdev_ops *tlsdev_ops;
>  #endif
>  
> +#if IS_ENABLED(CONFIG_ULP_DDP)
> +	const struct ulp_ddp_dev_ops *ulp_ddp_ops;
> +#endif

It's somewhat unclear to me why we add ops to struct net_device,
rather than to ops.. can you explain?

>  	const struct header_ops *header_ops;
>  
>  	unsigned char		operstate;

> +#include <linux/netdevice.h>
> +#include <net/inet_connection_sock.h>
> +#include <net/sock.h>
> +
> +enum ulp_ddp_type {
> +	ULP_DDP_NVME = 1,

I think the DDP and the NVME parts should have more separation.

Are you planning to implement pure TCP placement, without NIC trying 
to also "add value" by processing whatever TCP is carrying.

Can you split the DDP and NVME harder in the API, somehow?

> +};
> +
> +enum ulp_ddp_offload_capabilities {
> +	ULP_DDP_C_NVME_TCP = 1,
> +	ULP_DDP_C_NVME_TCP_DDGST_RX = 2,
> +};
> +
> +/**
> + * struct ulp_ddp_limits - Generic ulp ddp limits: tcp ddp
> + * protocol limits.
> + * Protocol implementations must use this as the first member.
> + * Add new instances of ulp_ddp_limits below (nvme-tcp, etc.).
> + *
> + * @type:		type of this limits struct
> + * @offload_capabilities:bitmask of supported offload types
> + * @max_ddp_sgl_len:	maximum sgl size supported (zero means no limit)
> + * @io_threshold:	minimum payload size required to offload
> + * @buf:		protocol-specific limits struct (if any)
> + */
> +struct ulp_ddp_limits {

Why is this called limits not capabilities / caps?

> +	enum ulp_ddp_type	type;
> +	u64			offload_capabilities;
> +	int			max_ddp_sgl_len;
> +	int			io_threshold;
> +	unsigned char		buf[];

Just put a union of all the protos here.

> +};
> +
> +/**
> + * struct nvme_tcp_ddp_limits - nvme tcp driver limitations
> + *
> + * @lmt:		generic ULP limits struct
> + * @full_ccid_range:	true if the driver supports the full CID range
> + */
> +struct nvme_tcp_ddp_limits {
> +	struct ulp_ddp_limits	lmt;
> +
> +	bool			full_ccid_range;
> +};

> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 0640453fce54..df37db420110 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5233,6 +5233,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
>  #ifdef CONFIG_TLS_DEVICE
>  		nskb->decrypted = skb->decrypted;
> +#endif
> +#ifdef CONFIG_ULP_DDP
> +		nskb->ulp_ddp = skb->ulp_ddp;
> +		nskb->ulp_crc = skb->ulp_crc;
>  #endif
>  		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
>  		if (list)
> @@ -5266,6 +5270,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
>  #ifdef CONFIG_TLS_DEVICE
>  				if (skb->decrypted != nskb->decrypted)
>  					goto end;
> +#endif
> +#ifdef CONFIG_ULP_DDP

no ifdef needed

> +				if (skb_is_ulp_crc(skb) != skb_is_ulp_crc(nskb))
> +					goto end;
>  #endif
>  			}
>  		}


