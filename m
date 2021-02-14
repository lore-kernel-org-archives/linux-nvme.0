Return-Path: <SRS0=P1pc=HQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D25DC433DB
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Feb 2021 18:16:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2858B64E4E
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Feb 2021 18:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2858B64E4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NJJZ9Oa+h6ss5cvHLUo4KvzXdut+NVcUQLgPGEuFHUA=; b=qnYJ5FqkDqtz+sYNGgXNScMSS
	xDSkHnfEcd1NJHpsn7/ztAIWRIXqOvAdBVFH18rpSxP84a2deQGNqBpCVidxJ5xsQ7ezyI5jT5Tsc
	mJjbF3ktBUNQRzMxLO6K/tN+9Vw7yru0rQYkmLHyN8qVwiRwF1PBRGquwRtsGdDVSchz6vRojxRWL
	7y2NogqWxAjCFw78Tuws/ft4dIQ2PtXH5XAiT049S4egsf5RaeD0/xJkyNIZg3XlEOl/zXnj/3SyA
	Y/7UqlyySJVwSlHmD2nygSgNCQGsjO4ygif3vBY+UkxMn8Qzvg2QRGX27uWK6QZL49HS2VB4Br500
	8+TDmm9LQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBLwt-0007K1-K5; Sun, 14 Feb 2021 18:16:47 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBLwj-0007JZ-Bf
 for linux-nvme@lists.infradead.org; Sun, 14 Feb 2021 18:16:38 +0000
Received: by mail-oi1-x230.google.com with SMTP id i3so5623762oif.1
 for <linux-nvme@lists.infradead.org>; Sun, 14 Feb 2021 10:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Kq7FDDv4Bg29GbbprI0wEcAVH1cweqTzNJcKru2Q2eQ=;
 b=dZ7ANatAQ7vjVErpc5Sgc7vp50Uw7U9oAwKn4VLzXuxLzgI38ESqkpLux1Qyz3G7Vn
 UtpykyDY/TwDrbZoEz45/rI+SGoPGd86a/iQL+Sn87gTagMZ8UNK7lSQw5/xHY1GhbFG
 eEAcdpqGMWkhR6B2TvlbnFBoQMmtkJxamQxLs6zkwB7zetXK7Et/eJf54L2bWrXN9gvZ
 9lmkebbW6JjOjK+4ap2h1iRG+ztGvKlOgdT+Z0XQwEqc5xQ/psGTYVh+eZnyqlQ9L/tl
 OhGmWxY2vpiHHjYRIra/Vmp2peGBZR5XOJoM02LZWx6VOvZK7l2JkbpH2qPaHQQxjyAB
 b4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Kq7FDDv4Bg29GbbprI0wEcAVH1cweqTzNJcKru2Q2eQ=;
 b=YLXqzRylgX2p4oz2f40Fooq/MUsvRhHb2PQ7/Ta9Yx3dWnkAqdXgUIoqNH2hKe+OQC
 0vepwpHFFysEbl8uXMt/xVgwPSS/OZJ/WuCHCrOlSs+89t3ytwKmgE/kGH9AHS9e17bm
 extZIsRLzr3VZIG8rgBxfqrsFLbvRTzQuWtIpK8+dqGAcT58eQfcSdjkywa1QY9XYSkd
 hxssQYDJxDYpXr3GcHJXcbp1HCT5KwusgyfvKauaVP9zPj5FTFdaPjo5BNtlFhVPZFgb
 +Dm1WF/9U4Fq0NutsLE/99Ecu5SsDcY0XnYU+jOCfzwlYNLCuPx32VUh8LsnYGB4zBsD
 iT7w==
X-Gm-Message-State: AOAM532vI0IYpO5uDZn/verqSk9IEiMtbmmkwa7TjWvybgdInwRKyLs8
 UvnanTPmvO/ce1mba9dor7Q=
X-Google-Smtp-Source: ABdhPJye/5uDMbc8XAtx7oIbNvjI+FraHm+LJBN6eiFUQ5sOhd7scgPLM5AgjANlPU1qblUZvai9vw==
X-Received: by 2002:aca:724e:: with SMTP id p75mr6604037oic.109.1613326593954; 
 Sun, 14 Feb 2021 10:16:33 -0800 (PST)
Received: from Davids-MacBook-Pro.local ([8.48.134.33])
 by smtp.googlemail.com with ESMTPSA id p67sm3336764oih.21.2021.02.14.10.16.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Feb 2021 10:16:33 -0800 (PST)
Subject: Re: [PATCH v4 net-next 06/21] nvme-tcp: Add DDP offload control path
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk,
 edumazet@google.com, smalin@marvell.com
References: <20210211211044.32701-1-borisp@mellanox.com>
 <20210211211044.32701-7-borisp@mellanox.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <2dd10b2f-df00-e21c-7886-93f41a987040@gmail.com>
Date: Sun, 14 Feb 2021 11:16:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210211211044.32701-7-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210214_131637_479444_5FE6300D 
X-CRM114-Status: GOOD (  23.90  )
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

On 2/11/21 2:10 PM, Boris Pismenny wrote:
> @@ -223,6 +229,164 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
>  	return nvme_tcp_pdu_data_left(req) <= len;
>  }
>  
> +#ifdef CONFIG_TCP_DDP
> +
> +static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
> +static const struct tcp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
> +	.resync_request		= nvme_tcp_resync_request,
> +};
> +
> +static int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
> +{
> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
> +	struct nvme_tcp_ddp_config config = {};
> +	int ret;
> +
> +	if (!(netdev->features & NETIF_F_HW_TCP_DDP))

If nvme_tcp_offload_limits does not find a dst_entry on the socket then
offloading_netdev may not NULL at this point.

> +		return -EOPNOTSUPP;
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
> +	dev_hold(netdev); /* put by unoffload_socket */
> +	ret = netdev->tcp_ddp_ops->tcp_ddp_sk_add(netdev,
> +						  queue->sock->sk,
> +						  &config.cfg);
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
> +static void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
> +{
> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
> +
> +	if (!netdev) {
> +		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");

you are already logged in nvme_tcp_offload_limits that
get_netdev_for_sock returned NULL; no need to do it again.

> +		return;
> +	}
> +
> +	netdev->tcp_ddp_ops->tcp_ddp_sk_del(netdev, queue->sock->sk);
> +
> +	inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = NULL;
> +	dev_put(netdev); /* held by offload_socket */
> +}
> +
> +static int nvme_tcp_offload_limits(struct nvme_tcp_queue *queue)
> +{
> +	struct net_device *netdev = get_netdev_for_sock(queue->sock->sk, true);
> +	struct tcp_ddp_limits limits;
> +	int ret = 0;
> +
> +	if (!netdev) {
> +		dev_info_ratelimited(queue->ctrl->ctrl.device, "netdev not found\n");

This should be more informative.

> +		queue->ctrl->offloading_netdev = NULL;
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

you save a reference to the netdev here, but then release the refcnt
below. That device could be deleted between this point in time and the
initialization of all queues.


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
> +	/* release the device as no offload context is established yet. */
> +	dev_put(netdev);
> +
> +	return ret;
> +}
> +
> +static void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
> +				     struct sk_buff *skb, unsigned int offset)
> +{
> +	u64 pdu_seq = TCP_SKB_CB(skb)->seq + offset - queue->pdu_offset;
> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
> +	u64 resync_val;
> +	u32 resync_seq;
> +
> +	resync_val = atomic64_read(&queue->resync_req);
> +	/* Lower 32 bit flags. Check validity of the request */
> +	if ((resync_val & TCP_DDP_RESYNC_REQ) == 0)
> +		return;
> +
> +	/* Obtain and check requested sequence number: is this PDU header before the request? */
> +	resync_seq = resync_val >> 32;
> +	if (before(pdu_seq, resync_seq))
> +		return;
> +
> +	if (unlikely(!netdev)) {
> +		pr_info_ratelimited("%s: netdev not found\n", __func__);

can't happen right? you get here because NVME_TCP_Q_OFF_DDP is set and
it is only set if offloading_netdev is set and the device supports offload.

> +		return;
> +	}
> +
> +	/**
> +	 * The atomic operation gurarantees that we don't miss any NIC driver
> +	 * resync requests submitted after the above checks.
> +	 */
> +	if (atomic64_cmpxchg(&queue->resync_req, resync_val,
> +			     resync_val & ~TCP_DDP_RESYNC_REQ))
> +		netdev->tcp_ddp_ops->tcp_ddp_resync(netdev, queue->sock->sk, pdu_seq);
> +}
> +


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
