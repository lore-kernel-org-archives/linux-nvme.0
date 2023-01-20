Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F61C05027
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Jan 2023 08:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s05YPlw7nmMKi6ofHH0R/IZx5C4v82IYIl8ziCcbJRY=; b=dWKuF/GlqA50pPBAY73zS+WUKu
	mOzJVPSQYNM2+VjpqFBrxDblpNE9e5PT65i7yjyq3kHXbEgVtpHMVlJxFn9Pqay1dB6JzTTTb0Eeq
	vvknULbkqHh6W0QnzmUw1VRxQTXQ4wnvhI5s2j8Oc5T8Vi9BjnvA6Qjc/YTNSPtY5rugy4wHvlXYd
	CdXQyofL2EjWeS0pKvUXuY0LRebrmt7FkuwI0DwdcEXoXdtGEoTSqOnz6tTS1YSEl17YATNBTv0Dn
	hy3AwH2XMf/JdH2iiqTeWoiNURuZmSEr7cmDOb1llkSRiw5RjUDW9kzGtSO8sUDGDWQiW1j93yfTg
	NiBRVMNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIn8f-0098EY-Bc; Fri, 20 Jan 2023 08:52:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIn8b-0098DP-GQ
	for linux-nvme@lists.infradead.org; Fri, 20 Jan 2023 08:52:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674204758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s05YPlw7nmMKi6ofHH0R/IZx5C4v82IYIl8ziCcbJRY=;
	b=fklP5Kh9003g/4R6XVVkBhKc4j3SLyG2+2a4nVZsgb3GwDwK4aSEge9FHd/DMFb5utVF4r
	R/VWAjQ//eCtb90//YKIJtqQxEQNSRxK9Yl5Fi+5FyLpiiWD88Z/CfVvBrtabOeQV8k/h9
	mq6dh0iuxCayOcjJjUNW3Dos2T6hBgk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-52-loviJtjdMJuLUgxjJquOVA-1; Fri, 20 Jan 2023 03:52:36 -0500
X-MC-Unique: loviJtjdMJuLUgxjJquOVA-1
Received: by mail-ed1-f70.google.com with SMTP id y20-20020a056402271400b0046c9a6ec30fso3410683edd.14
        for <linux-nvme@lists.infradead.org>; Fri, 20 Jan 2023 00:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JX7cSnmRj5odrp9epb0eSRVpnWx88LuuvW+Uj+VscN8=;
        b=oO8C7AOSYVrUPEHsz5NPpi6MhK2XaOSc9KGRdS0nxgQ1UCeIotcIWheKfm5W6ItM/X
         y1r+9YTvNgB9tPqrQ11XUPwMq8oumXu9XQp5MCg6hLBNmmhg58i8EeSSh/aa6cIlG7vn
         FIwJMxKJ+eBckgotbuZmGHp0WOf/cl+gwroa7sbyJi/FP37qarvsmi9TGsBx3hNrB4vD
         DRyiEVhABalQl2VfR6D10IBGvNXEt7Ifir27gJavFIqm1eYSSxGJH+jA6i2qw7hqgihO
         719eUX6GD/FasmdaZ8SBJaLBHBL+q2gti31BSU4p+HY2UCxeOMF9dewD5ZunvUE0em3W
         7QSg==
X-Gm-Message-State: AFqh2kpIS6FIqr/XZ/76p8T+9CRVMa3j3RhNpPa4BzENLC8bmKSPLQVt
	qtuwRSFZ+tq3dlrTNVOZ9oRVeMlfOizh94XMefF9u+rwNoUlS8zmiUrXdX0uoYIvPs+FH4AYfwU
	rXbSHtkJUMYrnQ23MNutNgBQHz0c=
X-Received: by 2002:a05:6402:5508:b0:49e:9751:2f17 with SMTP id fi8-20020a056402550800b0049e97512f17mr3955384edb.17.1674204755683;
        Fri, 20 Jan 2023 00:52:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuBuZX6eoY187ZIrq4ChdQRMWXhXLwhqMY3LdelWyWTti8Lr+t2tU2GiPwdtDljaDyUFoaOlQ==
X-Received: by 2002:a05:6402:5508:b0:49e:9751:2f17 with SMTP id fi8-20020a056402550800b0049e97512f17mr3955374edb.17.1674204755397;
        Fri, 20 Jan 2023 00:52:35 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-124-97.dyn.eolo.it. [146.241.124.97])
        by smtp.gmail.com with ESMTPSA id t20-20020a056402021400b0049e210884dasm6034248edv.15.2023.01.20.00.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 00:52:34 -0800 (PST)
Message-ID: <e279ebf025b62b8ce8878d16d1a77afb2e59ca7e.camel@redhat.com>
Subject: Re: [PATCH v9 01/25] net: Introduce direct data placement tcp
 offload
From: Paolo Abeni <pabeni@redhat.com>
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org, 
	netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, 
	axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com, 
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com
Date: Fri, 20 Jan 2023 09:52:34 +0100
In-Reply-To: <20230117153535.1945554-2-aaptel@nvidia.com>
References: <20230117153535.1945554-1-aaptel@nvidia.com>
	 <20230117153535.1945554-2-aaptel@nvidia.com>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230120_005241_675719_8C79B61A 
X-CRM114-Status: GOOD (  35.01  )
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

On Tue, 2023-01-17 at 17:35 +0200, Aurelien Aptel wrote:
> From: Boris Pismenny <borisp@nvidia.com>
>=20
> This commit introduces direct data placement (DDP) offload for TCP.
>=20
> The motivation is saving compute resources/cycles that are spent
> to copy data from SKBs to the block layer buffers and CRC
> calculation/verification for received PDUs (Protocol Data Units).
>=20
> The DDP capability is accompanied by new net_device operations that
> configure hardware contexts.
>=20
> There is a context per socket, and a context per DDP operation.
> Additionally, a resynchronization routine is used to assist
> hardware handle TCP OOO, and continue the offload. Furthermore,
> we let the offloading driver advertise what is the max hw
> sectors/segments.
>=20
> The interface includes five net-device ddp operations:
>=20
>  1. sk_add - add offload for the queue represented by socket+config pair
>  2. sk_del - remove the offload for the socket/queue
>  3. ddp_setup - request copy offload for buffers associated with an IO
>  4. ddp_teardown - release offload resources for that IO
>  5. limits - query NIC driver for quirks and limitations (e.g.
>              max number of scatter gather entries per IO)
>=20
> Using this interface, the NIC hardware will scatter TCP payload
> directly to the BIO pages according to the command_id.
>=20
> To maintain the correctness of the network stack, the driver is
> expected to construct SKBs that point to the BIO pages.
>=20
> The SKB passed to the network stack from the driver represents
> data as it is on the wire, while it is pointing directly to data
> in destination buffers.
>=20
> As a result, data from page frags should not be copied out to
> the linear part. To avoid needless copies, such as when using
> skb_condense, we mark the skb->ulp_ddp bit.
> In addition, the skb->ulp_crc will be used by the upper layers to
> determine if CRC re-calculation is required. The two separated skb
> indications are needed to avoid false positives GRO flushing events.
>=20
> Follow-up patches will use this interface for DDP in NVMe-TCP.
>=20
> Capability bits stored in net_device allow drivers to report which
> ULP DDP capabilities a device supports. Control over these
> capabilities will be exposed to userspace in later patches.
>=20
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> ---
>  include/linux/netdevice.h          |  15 +++
>  include/linux/skbuff.h             |  24 ++++
>  include/net/inet_connection_sock.h |   4 +
>  include/net/ulp_ddp.h              | 173 +++++++++++++++++++++++++++++
>  include/net/ulp_ddp_caps.h         |  41 +++++++
>  net/Kconfig                        |  20 ++++
>  net/core/skbuff.c                  |   3 +-
>  net/ipv4/tcp_input.c               |   8 ++
>  net/ipv4/tcp_ipv4.c                |   3 +
>  net/ipv4/tcp_offload.c             |   3 +
>  10 files changed, 293 insertions(+), 1 deletion(-)
>  create mode 100644 include/net/ulp_ddp.h
>  create mode 100644 include/net/ulp_ddp_caps.h
>=20
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index aad12a179e54..289cfdade177 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -52,6 +52,10 @@
>  #include <net/net_trackers.h>
>  #include <net/net_debug.h>
> =20
> +#ifdef CONFIG_ULP_DDP
> +#include <net/ulp_ddp_caps.h>
> +#endif
> +
>  struct netpoll_info;
>  struct device;
>  struct ethtool_ops;
> @@ -1392,6 +1396,8 @@ struct netdev_net_notifier {
>   *=09Get hardware timestamp based on normal/adjustable time or free runn=
ing
>   *=09cycle counter. This function is required if physical clock supports=
 a
>   *=09free running cycle counter.
> + * struct ulp_ddp_dev_ops *ulp_ddp_ops;
> + *=09ULP DDP operations (see include/net/ulp_ddp.h)
>   */
>  struct net_device_ops {
>  =09int=09=09=09(*ndo_init)(struct net_device *dev);
> @@ -1616,6 +1622,9 @@ struct net_device_ops {
>  =09ktime_t=09=09=09(*ndo_get_tstamp)(struct net_device *dev,
>  =09=09=09=09=09=09  const struct skb_shared_hwtstamps *hwtstamps,
>  =09=09=09=09=09=09  bool cycles);
> +#if IS_ENABLED(CONFIG_ULP_DDP)
> +=09const struct ulp_ddp_dev_ops=09*ulp_ddp_ops;
> +#endif
>  };
> =20
>  /**
> @@ -1783,6 +1792,9 @@ enum netdev_ml_priv_type {
>   *=09@mpls_features:=09Mask of features inheritable by MPLS
>   *=09@gso_partial_features: value(s) from NETIF_F_GSO\*
>   *
> + *=09@ulp_ddp_caps:=09Bitflags keeping track of supported and enabled
> + *=09=09=09ULP DDP capabilities.
> + *
>   *=09@ifindex:=09interface index
>   *=09@group:=09=09The group the device belongs to
>   *
> @@ -2071,6 +2083,9 @@ struct net_device {
>  =09netdev_features_t=09mpls_features;
>  =09netdev_features_t=09gso_partial_features;
> =20
> +#ifdef CONFIG_ULP_DDP
> +=09struct ulp_ddp_netdev_caps ulp_ddp_caps;
> +#endif
>  =09unsigned int=09=09min_mtu;
>  =09unsigned int=09=09max_mtu;
>  =09unsigned short=09=09type;
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 4c8492401a10..8708c5935e89 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -811,6 +811,8 @@ typedef unsigned char *sk_buff_data_t;
>   *=09=09delivery_time in mono clock base (i.e. EDT).  Otherwise, the
>   *=09=09skb->tstamp has the (rcv) timestamp at ingress and
>   *=09=09delivery_time at egress.
> + *=09@ulp_ddp: DDP offloaded
> + *=09@ulp_crc: CRC offloaded
>   *=09@napi_id: id of the NAPI struct this skb came from
>   *=09@sender_cpu: (aka @napi_id) source CPU in XPS
>   *=09@alloc_cpu: CPU which did the skb allocation.
> @@ -983,6 +985,10 @@ struct sk_buff {
>  =09__u8=09=09=09slow_gro:1;
>  =09__u8=09=09=09csum_not_inet:1;
>  =09__u8=09=09=09scm_io_uring:1;
> +#ifdef CONFIG_ULP_DDP
> +=09__u8                    ulp_ddp:1;
> +=09__u8=09=09=09ulp_crc:1;
> +#endif
> =20
>  #ifdef CONFIG_NET_SCHED
>  =09__u16=09=09=09tc_index;=09/* traffic control index */
> @@ -5053,5 +5059,23 @@ static inline void skb_mark_for_recycle(struct sk_=
buff *skb)
>  }
>  #endif
> =20
> +static inline bool skb_is_ulp_ddp(struct sk_buff *skb)
> +{
> +#ifdef CONFIG_ULP_DDP
> +=09return skb->ulp_ddp;
> +#else
> +=09return 0;
> +#endif
> +}
> +
> +static inline bool skb_is_ulp_crc(struct sk_buff *skb)
> +{
> +#ifdef CONFIG_ULP_DDP
> +=09return skb->ulp_crc;
> +#else
> +=09return 0;
> +#endif
> +}
> +
>  #endif=09/* __KERNEL__ */
>  #endif=09/* _LINUX_SKBUFF_H */
> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_connec=
tion_sock.h
> index c2b15f7e5516..2ba73167b3bb 100644
> --- a/include/net/inet_connection_sock.h
> +++ b/include/net/inet_connection_sock.h
> @@ -68,6 +68,8 @@ struct inet_connection_sock_af_ops {
>   * @icsk_ulp_ops=09   Pluggable ULP control hook
>   * @icsk_ulp_data=09   ULP private data
>   * @icsk_clean_acked=09   Clean acked data hook
> + * @icsk_ulp_ddp_ops=09   Pluggable ULP direct data placement control ho=
ok
> + * @icsk_ulp_ddp_data=09   ULP direct data placement private data
>   * @icsk_ca_state:=09   Congestion control state
>   * @icsk_retransmits:=09   Number of unrecovered [RTO] timeouts
>   * @icsk_pending:=09   Scheduled timer event
> @@ -98,6 +100,8 @@ struct inet_connection_sock {
>  =09const struct tcp_ulp_ops  *icsk_ulp_ops;
>  =09void __rcu=09=09  *icsk_ulp_data;
>  =09void (*icsk_clean_acked)(struct sock *sk, u32 acked_seq);
> +=09const struct ulp_ddp_ulp_ops  *icsk_ulp_ddp_ops;
> +=09void __rcu=09=09  *icsk_ulp_ddp_data;

The above probably need a

#if IS_ENABLED(CONFIG_ULP_DDP)

compiler guard.

Have you considered avoiding adding the above fields here, and instead
pass them as argument for the setup() H/W offload operation?=C2=A0

I feel like such fields belong more naturally to the DDP offload
context/queue and currently the icsk DDP ops are only used by the
offloading driver. Additionally it looks strange to me 2 consecutive
different set of ULPs inside the same object (sock).

Thanks,

Paolo


