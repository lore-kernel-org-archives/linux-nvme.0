Return-Path: <SRS0=ulAu=GW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FD4C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 03:47:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3534B22509
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jan 2021 03:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3534B22509
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zwo4ALbbhW2U69KaQS5wcGZCMcetYCShemVRXgX8NVA=; b=ZLTQX/1+FSNfWRgs6KeGiAjkr
	SFAKk7WnsZFndZJFSfK9by2UHmxPPTkVFgqOn40fB+0m/YfSk2tVA/RL/CBtgTuzYJsQGW8ZRStv5
	O1/O2tHbg4lNZChzn1PeYfS7pNX1jDMuEcOqX6Po/rb54wWj6mUf4iYggcJY+pely1YXU/H3bXp8W
	2dX1avKu+FVThTcsoj7nhx2MOasfTVOB1NFYHMwN+M55cSpF81V9v9pM0IMim1uBaA5uVlv3/wbsG
	lr6hbeSo8Op0N32fLm7/MHBARwpsWgefpFTY7MzEZfZQWBkafYOScK58S0sc9nzx2KOVZy+dZ7TDO
	K/3AISAAA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l1hzC-0001Ft-JX; Tue, 19 Jan 2021 03:47:18 +0000
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l1hz9-0001F3-Ej
 for linux-nvme@lists.infradead.org; Tue, 19 Jan 2021 03:47:16 +0000
Received: by mail-ot1-x332.google.com with SMTP id o11so18524723ote.4
 for <linux-nvme@lists.infradead.org>; Mon, 18 Jan 2021 19:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LEBogkZ4IQHYkFDaqnlPZw8aJhD0X+Er1BtoG8LWR7o=;
 b=qvLA3LvTgXP7DgsVwyVP5kRc9Ias6NBJtlQVAy4CcSsJWClVFh30Xfn3JIBOrrUAzf
 L1TStHr6oyVSXIYg/EC3a5h7+dZU5drk7yawYs6bbIaeEH8tdlgdi+BJDaYS8VP77204
 X5xaABMF9RyN/S4zKmMC78vcVFFYvbA+8tekxfwJC1dCtNT2trMyaj8I4rtQZXpDi11g
 SahJhXmcuUlWUqszcPi50Ap1DsT3YI+1J2NyQ0diT/S14yWCy8Wdx2f1RRlnwPegDOIA
 QqFULfN7mjBKneEDxOpdPLNZSB00BhR46xvcJU8ueRT/Ob1kUU9tl6ZPnehqJGs02mfR
 o/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LEBogkZ4IQHYkFDaqnlPZw8aJhD0X+Er1BtoG8LWR7o=;
 b=XWZmGZe3fZT31X5SQ1FDAJ6D6g247KWyLIE5dnlXynOLNbm6s9fcBmfKVqhrtczpZ1
 j4Vriw+cqGy9S2oQ/WPh0o9MzqgJuQVIGtphQ8D8/nL0O0HZ1pv90CT+ReK1rt1M3LXq
 CzGFne8jgxN/qMIRyOUFoGp6cNEntF9KQqpMAJeTIXC2TNyZ0pD6bTivWYQFXqsCFkQp
 PICm39OwlJ9wT09fGJQufWgETlJPzpVVwjW7Prukvnw50fCyPEhWyehXthrOe4AFqcIB
 W7OxBWlR3tgHvs+hCuBPFkgmVcUtPIgAyQZOUUZ312pQf9pJzKK4wBmxOZ766TfvUq5A
 3BkA==
X-Gm-Message-State: AOAM531nDqcBv7aAtM0N2dInu5bMUuu42bjyFoMdkPPb3BH0aSYLz2aY
 j3xsEFwfGwd1cXRrMbb+dd0=
X-Google-Smtp-Source: ABdhPJyjOHYOkMe+KTHzBd+kmzzYF6C/9dZKi7sFMS5JhOO50R20PtuG16/OG7KfcTEhekCRAImIug==
X-Received: by 2002:a9d:8f6:: with SMTP id 109mr2116503otf.199.1611028031149; 
 Mon, 18 Jan 2021 19:47:11 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.6.112.193])
 by smtp.googlemail.com with ESMTPSA id v67sm2185482otb.43.2021.01.18.19.47.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Jan 2021 19:47:10 -0800 (PST)
Subject: Re: [PATCH v2 net-next 06/21] nvme-tcp: Add DDP offload control path
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com, smalin@marvell.com
References: <20210114151033.13020-1-borisp@mellanox.com>
 <20210114151033.13020-7-borisp@mellanox.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <37861060-9651-49c8-e583-2b070914361c@gmail.com>
Date: Mon, 18 Jan 2021 20:47:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210114151033.13020-7-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210118_224715_510358_33C794E7 
X-CRM114-Status: GOOD (  18.20  )
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

On 1/14/21 8:10 AM, Boris Pismenny wrote:
> +static
> +int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
> +{
> +	struct net_device *netdev = get_netdev_for_sock(queue->sock->sk, true);
> +	struct nvme_tcp_ddp_config config = {};
> +	int ret;
> +
> +	if (!netdev) {
> +		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!(netdev->features & NETIF_F_HW_TCP_DDP)) {
> +		dev_put(netdev);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	config.cfg.type		= TCP_DDP_NVME;
> +	config.pfv		= NVME_TCP_PFV_1_0;
> +	config.cpda		= 0;
> +	config.dgst		= queue->hdr_digest ?
> +		NVME_TCP_HDR_DIGEST_ENABLE : 0;
> +	config.dgst		|= queue->data_digest ?
> +		NVME_TCP_DATA_DIGEST_ENABLE : 0;
> +	config.queue_size	= queue->queue_size;
> +	config.queue_id		= nvme_tcp_queue_id(queue);
> +	config.io_cpu		= queue->io_cpu;
> +
> +	ret = netdev->tcp_ddp_ops->tcp_ddp_sk_add(netdev,
> +						  queue->sock->sk,
> +						  (struct tcp_ddp_config *)&config);

typecast is not needed; tcp_ddp_config is an element of nvme_tcp_ddp_config

> +	if (ret) {
> +		dev_put(netdev);
> +		return ret;
> +	}
> +
> +	inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = &nvme_tcp_ddp_ulp_ops;
> +	if (netdev->features & NETIF_F_HW_TCP_DDP)
> +		set_bit(NVME_TCP_Q_OFF_DDP, &queue->flags);
> +
> +	return ret;
> +}
> +
> +static
> +void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
> +{
> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
> +
> +	if (!netdev) {
> +		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
> +		return;
> +	}
> +
> +	netdev->tcp_ddp_ops->tcp_ddp_sk_del(netdev, queue->sock->sk);
> +
> +	inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = NULL;
> +	dev_put(netdev); /* put the queue_init get_netdev_for_sock() */

have you validated the netdev reference counts? You have a put here, and ...

> +}
> +
> +static
> +int nvme_tcp_offload_limits(struct nvme_tcp_queue *queue)
> +{
> +	struct net_device *netdev = get_netdev_for_sock(queue->sock->sk, true);

... a get here ....

> +	struct tcp_ddp_limits limits;
> +	int ret = 0;
> +
> +	if (!netdev) {
> +		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");
> +		return -ENODEV;
> +	}
> +
> +	if (netdev->features & NETIF_F_HW_TCP_DDP &&
> +	    netdev->tcp_ddp_ops &&
> +	    netdev->tcp_ddp_ops->tcp_ddp_limits)
> +		ret = netdev->tcp_ddp_ops->tcp_ddp_limits(netdev, &limits);
> +	else
> +		ret = -EOPNOTSUPP;
> +
> +	if (!ret) {
> +		queue->ctrl->offloading_netdev = netdev;


... you have the device here, but then ...

> +		dev_dbg_ratelimited(queue->ctrl->ctrl.device,
> +				    "netdev %s offload limits: max_ddp_sgl_len %d\n",
> +				    netdev->name, limits.max_ddp_sgl_len);
> +		queue->ctrl->ctrl.max_segments = limits.max_ddp_sgl_len;
> +		queue->ctrl->ctrl.max_hw_sectors =
> +			limits.max_ddp_sgl_len << (ilog2(SZ_4K) - 9);
> +	} else {
> +		queue->ctrl->offloading_netdev = NULL;
> +	}
> +
> +	dev_put(netdev);

... put here. And this is the limit checking function which seems like
an odd place to set offloading_netdev vs nvme_tcp_offload_socket which
sets no queue variable but yet hangs on to a netdev reference count.

netdev reference count leaks are an absolute PITA to find. Code that
takes and puts the counts should be clear and obvious as to when and
why. The symmetry of offload and unoffload are clear when the offload
saves the address in offloading_netdev. What you have now is dubious.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
