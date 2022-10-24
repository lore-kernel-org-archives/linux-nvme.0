Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C1DFA3740
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Oct 2022 11:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jJOsptVZv35L5VpbB/zbYMQlu1ugS0dNwQS+slpQtqc=; b=p+c7BF3curEN58B5zE4F4MTx0T
	OxGTQJAXlbe9Iu2KmapPzflZYhyNMjl1UAWumRBHIPAEYr6CREXONY9tj//02APRl2w6w1EGSlBVT
	NnrFvfAMDe/drkkEXWmGK5yvHNC4Gg1T7pj7rZayLWa6jDtCulIaB3zqJBpZWgC0hlo4Vt52DYsO0
	Z9mrzWwMK2oprbq/yRSK2e+SN88EP1cnnJv7t1YAFOjIV/paujEua93ik/hU7ExvCL/QvLkzuFZmA
	ZRLSTNaa3sxmQBr4d2oYOGe5alXEgccYVsAyi7eXt7LkE4yJxTYOvMGVgCE4RqLGMlV+Z5elSntYO
	VlSVW8rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omvoR-0018dB-Lg; Mon, 24 Oct 2022 11:40:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omvX3-000z2u-DN
	for linux-nvme@lists.infradead.org; Mon, 24 Oct 2022 11:22:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5E6D261228;
	Mon, 24 Oct 2022 11:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021FCC433C1;
	Mon, 24 Oct 2022 11:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666610531;
	bh=Tidq8AT4Pb6a6zPdoWxK0qF4MAvcDoJ7X7hx9h9HuNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqqDjUoRhqoCs9qZqe6V/qK41uMffB9YpgMwchup4kIQAOiQSAp/w5CPVgTW0R4id
	 pgikDQVmLfZk2ZCf/0idr2U3yKgpZkYz4B81njY8st73Dumryu31ZsUuBFlnqNgwF+
	 +wFat9uBDQtxyqg5eBHwY8uZV1fhnsurcEP9nyYQ0hHIuf94zrRRURMVfGMratbQVE
	 FulcYBaiKDah2brn4sETiocHNzTivc/1yspSnDE3+khmvgG55MVckYlymmiyltyQpJ
	 +edg4tDRI98C62kgSFnLxL8azi8pWhcHmkinureepiwfrl6/wCXZjP7KPE/IzVWHRs
	 IVaCLVvH5+Eqw==
Date: Mon, 24 Oct 2022 14:22:07 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	tariqt@nvidia.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	hch@lst.de, kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com,
	smalin@nvidia.com, ogerlitz@nvidia.com, yorayz@nvidia.com,
	borisp@nvidia.com, aurelien.aptel@gmail.com, malin1024@gmail.com
Subject: Re: [PATCH v6 01/23] net: Introduce direct data placement tcp offload
Message-ID: <Y1Z1XzLusUVjfnLp@unreal>
References: <20221020101838.2712846-1-aaptel@nvidia.com>
 <20221020101838.2712846-2-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020101838.2712846-2-aaptel@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_042213_700081_E660F1B0 
X-CRM114-Status: GOOD (  35.39  )
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

On Thu, Oct 20, 2022 at 01:18:16PM +0300, Aurelien Aptel wrote:
> From: Boris Pismenny <borisp@nvidia.com>
> 
> This commit introduces direct data placement (DDP) offload for TCP.
> 
> The motivation is saving compute resources/cycles that are spent
> to copy data from SKBs to the block layer buffers and CRC
> calculation/verification for received PDUs (Protocol Data Units).
> 
> The DDP capability is accompanied by new net_device operations that
> configure hardware contexts.
> 
> There is a context per socket, and a context per DDP operation.
> Additionally, a resynchronization routine is used to assist
> hardware handle TCP OOO, and continue the offload. Furthermore,
> we let the offloading driver advertise what is the max hw
> sectors/segments.
> 
> The interface includes five net-device ddp operations:
> 
>  1. sk_add - add offload for the queue represented by socket+config pair
>  2. sk_del - remove the offload for the socket/queue
>  3. ddp_setup - request copy offload for buffers associated with an IO
>  4. ddp_teardown - release offload resources for that IO
>  5. limits - query NIC driver for quirks and limitations (e.g.
>              max number of scatter gather entries per IO)
> 
> Using this interface, the NIC hardware will scatter TCP payload
> directly to the BIO pages according to the command_id.
> 
> To maintain the correctness of the network stack, the driver is
> expected to construct SKBs that point to the BIO pages.
> 
> The SKB passed to the network stack from the driver represents
> data as it is on the wire, while it is pointing directly to data
> in destination buffers.
> 
> As a result, data from page frags should not be copied out to
> the linear part. To avoid needless copies, such as when using
> skb_condense, we mark the skb->ddp bit.
> In addition, the skb->crc will be used by the upper layers to
> determine if CRC re-calculation is required. The two separated skb
> indications are needed to avoid false positives GRO flushing events.
> 
> Follow-up patches will use this interface for DDP in NVMe-TCP.
> 
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> ---
>  include/linux/netdev_features.h    |   3 +-
>  include/linux/netdevice.h          |   5 +
>  include/linux/skbuff.h             |  11 ++
>  include/net/inet_connection_sock.h |   4 +
>  include/net/ulp_ddp.h              | 171 +++++++++++++++++++++++++++++
>  net/Kconfig                        |  10 ++
>  net/core/skbuff.c                  |   3 +-
>  net/ethtool/common.c               |   1 +
>  net/ipv4/tcp_input.c               |   8 ++
>  net/ipv4/tcp_ipv4.c                |   3 +
>  net/ipv4/tcp_offload.c             |   3 +
>  11 files changed, 220 insertions(+), 2 deletions(-)
>  create mode 100644 include/net/ulp_ddp.h
> 
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
> index a36edb0ec199..ff6f4978723a 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1043,6 +1043,7 @@ struct dev_ifalias {

<...>

> @@ -982,6 +984,15 @@ struct sk_buff {
>  #endif
>  	__u8			slow_gro:1;
>  	__u8			csum_not_inet:1;
> +#ifdef CONFIG_ULP_DDP
> +	__u8                    ulp_ddp:1;
> +	__u8			ulp_crc:1;
> +#define IS_ULP_DDP(skb) ((skb)->ulp_ddp)
> +#define IS_ULP_CRC(skb) ((skb)->ulp_crc)
> +#else
> +#define IS_ULP_DDP(skb) (0)
> +#define IS_ULP_CRC(skb) (0)

All users of this define are protected by ifdef CONFIG_ULP_DDP.
It is easier to wrap user of IS_ULP_DDP() too and remove #else
lag from here.

> +#endif
>  
>  #ifdef CONFIG_NET_SCHED
>  	__u16			tc_index;	/* traffic control index */
> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connection_sock.h
> index c2b15f7e5516..2ba73167b3bb 100644
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
> @@ -68,6 +68,8 @@ struct inet_connection_sock_af_ops {
>   * @icsk_ulp_ops	   Pluggable ULP control hook
>   * @icsk_ulp_data	   ULP private data
>   * @icsk_clean_acked	   Clean acked data hook
> + * @icsk_ulp_ddp_ops	   Pluggable ULP direct data placement control hook
> + * @icsk_ulp_ddp_data	   ULP direct data placement private data
>   * @icsk_ca_state:	   Congestion control state
>   * @icsk_retransmits:	   Number of unrecovered [RTO] timeouts
>   * @icsk_pending:	   Scheduled timer event
> @@ -98,6 +100,8 @@ struct inet_connection_sock {
>  	const struct tcp_ulp_ops  *icsk_ulp_ops;
>  	void __rcu		  *icsk_ulp_data;
>  	void (*icsk_clean_acked)(struct sock *sk, u32 acked_seq);
> +	const struct ulp_ddp_ulp_ops  *icsk_ulp_ddp_ops;
> +	void __rcu		  *icsk_ulp_ddp_data;
>  	unsigned int		  (*icsk_sync_mss)(struct sock *sk, u32 pmtu);
>  	__u8			  icsk_ca_state:5,
>  				  icsk_ca_initialized:1,
> diff --git a/include/net/ulp_ddp.h b/include/net/ulp_ddp.h
> new file mode 100644
> index 000000000000..57cc4ab22e18
> --- /dev/null
> +++ b/include/net/ulp_ddp.h
> @@ -0,0 +1,171 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * ulp_ddp.h
> + *	Author:	Boris Pismenny <borisp@nvidia.com>
> + *	Copyright (C) 2022 NVIDIA CORPORATION & AFFILIATES.

The official format is:
Copyright (C) 2022, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
                 ^^^^                  		 ^^^^^^^^^^^^^^^^^^       


<...>

> +config ULP_DDP
> +	bool "ULP direct data placement offload"
> +	default n

No need to set "n" explicitly, it is already default.

Thanks

