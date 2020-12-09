Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69170C4361B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 08:25:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF23523B97
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 08:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF23523B97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=39S8qvGEU1FN48sc1qV4ngf3OCblOM6v6X59RfLq33o=; b=i7RSwxs2gh2PTZrCkJpFS2XDv
	2JFCJ+dxOvLSDbUThph5R0OsvGJQnSfauVyeMImXgaS+nWbf4/pEMzlIIkpsmBXDcDftOXmI8sMhr
	sp1xrXG0cb6G524IR7ogJGFsB982fwm7Was0JHE00OKQcG9Jart7OObTcjIs1e8ZddgbxiqvRWDTN
	R82nDW8VCSnQfCUM4O2wnKndJUYqQJ8icBWYZ5DlZJxelva+AxqAbBq8dUJqiiiDqIekiRGZqN1o5
	Ts7tQKHJKLtoDcyVft4Hb2DAQdaUG6zgr1gncsKrxPaGQaVBc+hrW9+69ahfoR0JYBrEM17jFi6qu
	w6FHMZ1aw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmumv-00047G-U4; Wed, 09 Dec 2020 08:25:29 +0000
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmumu-00046u-AF
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 08:25:29 +0000
Received: by mail-ej1-x642.google.com with SMTP id n26so854535eju.6
 for <linux-nvme@lists.infradead.org>; Wed, 09 Dec 2020 00:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vObXydUW0UVv6YJ6tKDX5OM1cYwJwAuJ0yJUA+AFQUY=;
 b=HHipdgwlt3DObeEHboinNYqWVJczcegdmRMaVNWSO9ryVbP+v/jt4IsLW/QybAjabS
 EKcNbcSUo126naO5lErTnNN3V6RzMr30jK+nNXpFr42eh7uFglPp0QA0bsmoI+fEiQnf
 5GDZnvEFywwAJvaUo32Oy7+c6i6h5TpyAj07b4jk82YG1DNbthDROXBk5liuTgGVL+mo
 PuPbVe9PphmKGy7e33YBptyFgANaTO3GqkwbOAvLBPbHYwIeHxojbfE8xMTHqI7xVHDE
 vIVZYHGl6OgF1cdp2o8Mw2+B+5Sy+GQKPXdAH+m9V4MH0YiTV8czP6BwFwTjn6Bovrjz
 pVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vObXydUW0UVv6YJ6tKDX5OM1cYwJwAuJ0yJUA+AFQUY=;
 b=OYsQv5/7NdQJEqXsP1eOnAiOCxyAJHWbSQzjBui87cr7yMzD/8eSbyWSnqPQ8kLhwP
 o1R555zX/pWXeIrlt7+6itIv3q2ZS6jH+J9LwTaNbs0hpyUwTpc+wHEfJZ73X2Iqvgwe
 doln1uZxfYFOrxDj+m26AzoOWAJLd7snWWx/ogJ/giECKUad3zQjsQYh51JRTr3voRmF
 ByPtNr6+FsvV3aTAb4QG8PSPP661psQ+qa0lXHvlYtbr9Cp2JmN3Z9/3IJ6coWb73DBy
 aLLo6ymQygyfjtYS1V0L9W2M4v9ccHyHOVoz0e6dErGAm4mSm/GWYNfT33WJjLNUA0eK
 W5WQ==
X-Gm-Message-State: AOAM531iykW0qdOJPGVQ6MprM1CLCWFW4URiiHwJ7RHs48xNRUM8txjd
 Ri77G+1fiVz+DCxuqHoCNWg=
X-Google-Smtp-Source: ABdhPJzbzd0VZ1AKGVp3uHTOs/2w4ISoZPe6jhUwtFpSsjdnwWHUv8PvL3iS4yQEwVG8Rx3Y03LwGw==
X-Received: by 2002:a17:907:9691:: with SMTP id
 hd17mr1074458ejc.306.1607502327107; 
 Wed, 09 Dec 2020 00:25:27 -0800 (PST)
Received: from [132.68.43.153] ([132.68.43.153])
 by smtp.gmail.com with ESMTPSA id da9sm825367edb.84.2020.12.09.00.25.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Dec 2020 00:25:26 -0800 (PST)
Subject: Re: [PATCH v1 net-next 02/15] net: Introduce direct data placement
 tcp offload
To: David Ahern <dsahern@gmail.com>, Boris Pismenny <borisp@mellanox.com>,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-3-borisp@mellanox.com>
 <824e3bea-60d2-5a4d-e8ce-770d70f0ba37@gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <a5de567b-c07e-d21b-318a-5d2a9e38045c@gmail.com>
Date: Wed, 9 Dec 2020 10:25:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <824e3bea-60d2-5a4d-e8ce-770d70f0ba37@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_032528_377649_355C5C60 
X-CRM114-Status: GOOD (  28.34  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 09/12/2020 2:57, David Ahern wrote:
> On 12/7/20 2:06 PM, Boris Pismenny wrote:
>> diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
>> index 934de56644e7..fb35dcac03d2 100644
>> --- a/include/linux/netdev_features.h
>> +++ b/include/linux/netdev_features.h
>> @@ -84,6 +84,7 @@ enum {
>>  	NETIF_F_GRO_FRAGLIST_BIT,	/* Fraglist GRO */
>>  
>>  	NETIF_F_HW_MACSEC_BIT,		/* Offload MACsec operations */
>> +	NETIF_F_HW_TCP_DDP_BIT,		/* TCP direct data placement offload */
>>  
>>  	/*
>>  	 * Add your fresh new feature above and remember to update
>> @@ -157,6 +158,7 @@ enum {
>>  #define NETIF_F_GRO_FRAGLIST	__NETIF_F(GRO_FRAGLIST)
>>  #define NETIF_F_GSO_FRAGLIST	__NETIF_F(GSO_FRAGLIST)
>>  #define NETIF_F_HW_MACSEC	__NETIF_F(HW_MACSEC)
>> +#define NETIF_F_HW_TCP_DDP	__NETIF_F(HW_TCP_DDP)
> 
> All of the DDP naming seems wrong to me. I realize the specific use case
> is targeted payloads of a ULP, but it is still S/W handing H/W specific
> buffers for a payload of a flow.
> 
> 

This is intended to be used strictly by ULPs. DDP is how such things were
called in the past. It is more than zerocopy as explained before, so naming
it zerocopy will be misleading at best. I can propose another name. How about:
"Autonomous copy offload (ACO)" and "Autonomous crc offload (ACRC)"?
This will indicate that it is independent of other offloads, i.e. autonomous,
while also informing users of the functionality (copy/crc). Other names are
welcome too.


>>   * @icsk_listen_portaddr_node	hash to the portaddr listener hashtable
>>   * @icsk_ca_state:	   Congestion control state
>>   * @icsk_retransmits:	   Number of unrecovered [RTO] timeouts
>> @@ -94,6 +96,8 @@ struct inet_connection_sock {
>>  	const struct tcp_ulp_ops  *icsk_ulp_ops;
>>  	void __rcu		  *icsk_ulp_data;
>>  	void (*icsk_clean_acked)(struct sock *sk, u32 acked_seq);
>> +	const struct tcp_ddp_ulp_ops  *icsk_ulp_ddp_ops;
>> +	void __rcu		  *icsk_ulp_ddp_data;
>>  	struct hlist_node         icsk_listen_portaddr_node;
>>  	unsigned int		  (*icsk_sync_mss)(struct sock *sk, u32 pmtu);
>>  	__u8			  icsk_ca_state:5,
>> diff --git a/include/net/tcp_ddp.h b/include/net/tcp_ddp.h
>> new file mode 100644
>> index 000000000000..df3264be4600
>> --- /dev/null
>> +++ b/include/net/tcp_ddp.h
>> @@ -0,0 +1,129 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> + *
>> + * tcp_ddp.h
>> + *	Author:	Boris Pismenny <borisp@mellanox.com>
>> + *	Copyright (C) 2020 Mellanox Technologies.
>> + */
>> +#ifndef _TCP_DDP_H
>> +#define _TCP_DDP_H
>> +
>> +#include <linux/netdevice.h>
>> +#include <net/inet_connection_sock.h>
>> +#include <net/sock.h>
>> +
>> +/* limits returned by the offload driver, zero means don't care */
>> +struct tcp_ddp_limits {
>> +	int	 max_ddp_sgl_len;
>> +};
>> +
>> +enum tcp_ddp_type {
>> +	TCP_DDP_NVME = 1,
>> +};
>> +
>> +/**
>> + * struct tcp_ddp_config - Generic tcp ddp configuration: tcp ddp IO queue
>> + * config implementations must use this as the first member.
>> + * Add new instances of tcp_ddp_config below (nvme-tcp, etc.).
>> + */
>> +struct tcp_ddp_config {
>> +	enum tcp_ddp_type    type;
>> +	unsigned char        buf[];
> 
> you have this variable length buf, but it is not used (as far as I can
> tell). But then ...
> 
> 

True. This buf[] is here to indicate that users are expected to extend it with
the ULP specific data as in nvme_tcp_config. We can remove it and leave a comment
if you prefer that.

>> +};
>> +
>> +/**
>> + * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
>> + *
>> + * @pfv:        pdu version (e.g., NVME_TCP_PFV_1_0)
>> + * @cpda:       controller pdu data alignmend (dwords, 0's based)
>> + * @dgst:       digest types enabled.
>> + *              The netdev will offload crc if ddp_crc is supported.
>> + * @queue_size: number of nvme-tcp IO queue elements
>> + * @queue_id:   queue identifier
>> + * @cpu_io:     cpu core running the IO thread for this queue
>> + */
>> +struct nvme_tcp_ddp_config {
>> +	struct tcp_ddp_config   cfg;
> 
> ... how would you use it within another struct like this?
> 

You don't.

>> +
>> +	u16			pfv;
>> +	u8			cpda;
>> +	u8			dgst;
>> +	int			queue_size;
>> +	int			queue_id;
>> +	int			io_cpu;
>> +};
>> +
>> +/**
>> + * struct tcp_ddp_io - tcp ddp configuration for an IO request.
>> + *
>> + * @command_id:  identifier on the wire associated with these buffers
>> + * @nents:       number of entries in the sg_table
>> + * @sg_table:    describing the buffers for this IO request
>> + * @first_sgl:   first SGL in sg_table
>> + */
>> +struct tcp_ddp_io {
>> +	u32			command_id;
>> +	int			nents;
>> +	struct sg_table		sg_table;
>> +	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
>> +};
>> +
>> +/* struct tcp_ddp_dev_ops - operations used by an upper layer protocol to configure ddp offload
>> + *
>> + * @tcp_ddp_limits:    limit the number of scatter gather entries per IO.
>> + *                     the device driver can use this to limit the resources allocated per queue.
>> + * @tcp_ddp_sk_add:    add offload for the queue represennted by the socket+config pair.
>> + *                     this function is used to configure either copy, crc or both offloads.
>> + * @tcp_ddp_sk_del:    remove offload from the socket, and release any device related resources.
>> + * @tcp_ddp_setup:     request copy offload for buffers associated with a command_id in tcp_ddp_io.
>> + * @tcp_ddp_teardown:  release offload resources association between buffers and command_id in
>> + *                     tcp_ddp_io.
>> + * @tcp_ddp_resync:    respond to the driver's resync_request. Called only if resync is successful.
>> + */
>> +struct tcp_ddp_dev_ops {
>> +	int (*tcp_ddp_limits)(struct net_device *netdev,
>> +			      struct tcp_ddp_limits *limits);
>> +	int (*tcp_ddp_sk_add)(struct net_device *netdev,
>> +			      struct sock *sk,
>> +			      struct tcp_ddp_config *config);
>> +	void (*tcp_ddp_sk_del)(struct net_device *netdev,
>> +			       struct sock *sk);
>> +	int (*tcp_ddp_setup)(struct net_device *netdev,
>> +			     struct sock *sk,
>> +			     struct tcp_ddp_io *io);
>> +	int (*tcp_ddp_teardown)(struct net_device *netdev,
>> +				struct sock *sk,
>> +				struct tcp_ddp_io *io,
>> +				void *ddp_ctx);
>> +	void (*tcp_ddp_resync)(struct net_device *netdev,
>> +			       struct sock *sk, u32 seq);
>> +};
>> +
>> +#define TCP_DDP_RESYNC_REQ (1 << 0)
>> +
>> +/**
>> + * struct tcp_ddp_ulp_ops - Interface to register uppper layer Direct Data Placement (DDP) TCP offload
>> + */
>> +struct tcp_ddp_ulp_ops {
>> +	/* NIC requests ulp to indicate if @seq is the start of a message */
>> +	bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
>> +	/* NIC driver informs the ulp that ddp teardown is done - used for async completions*/
>> +	void (*ddp_teardown_done)(void *ddp_ctx);
>> +};
>> +
>> +/**
>> + * struct tcp_ddp_ctx - Generic tcp ddp context: device driver per queue contexts must
>> + * use this as the first member.
>> + */
>> +struct tcp_ddp_ctx {
>> +	enum tcp_ddp_type    type;
>> +	unsigned char        buf[];
> 
> similar to my comment above, I did not see any uses of the buf element.
> 

Same idea, we will remove it an leave a comment.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
