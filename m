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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EE8C433E7
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 22:19:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C93522241
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 22:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mbUSfod/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C93522241
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3EVsj52oaxc/71NOaHdxqgb3rh1HWa8dN60OvPdPlw4=; b=mbUSfod/9kAjavTHXmHIGkR9h
	/nrgMo4DlmbfZ33h0CtFE84JHhqH8o8YZO8ZaWsz03YUJZO8xXWunW+4Ut1q6CXJNWa9POEKjOSU3
	x+ESCRSeNG6bt6z8HxBk4Cx05PTgxvfalAkrduuKfog8uqRr5XaLQ3+gJK/KpFn0AcCHXUbvPfvYg
	ccOIslWtql0WbDPYw0pOg0vWByZq+NxIivCliC/APJ8VrE56yjA7IuGXMR2A5fmgo0eZmJcZy/N33
	gwdGJjlD3OUUUyWhWqu705KS39w3a6gpVhp2kmum7KMvk1xbRFiZnmXKjPRCz2MXmTjNSzNtciWWy
	xFcwqlT3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQeGI-0002gD-DL; Thu, 08 Oct 2020 22:19:46 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQeGE-0002fi-Eq
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 22:19:43 +0000
Received: by mail-wr1-f66.google.com with SMTP id e17so8214592wru.12
 for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2020 15:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KTXCtB8ktOz/XLUEtBaKfVYbkCIn3TTozF+OK73tMU0=;
 b=RuFgPST0Ww2fMlpBAnC0sL688iXC5dlVfu2nOdXXZiQ0wzWE5Y3zF7twi/KzsUzxPP
 LuXuzn+1WEMqezkcXvYSNCh0SGhfKriPlMf/g0fJcyHg0kcJFCuNNxspWG94NvJKQYSy
 B1GITeStdmEER/fA4QsYbj8pfN9OTrd/YWm3ylQfbUOmszisITSwukV0vPYFLZaqVA/s
 grW6p8cxO9PBNtgT4gzu+0VMJ1Wqb6WX8ZzOgYphwp9bO6WjaFIWFfqmUGAnPOdkMhYy
 gPTVMk+Oo1yu1Eg2lAWxN4rKGE15FTXnqBQaQ0/12jvXnf4LYEiH7DUyWaz9Nx2LOjuz
 SzIQ==
X-Gm-Message-State: AOAM5333El2cQO+YbJ5FV6ing5UjnORoprtUJwWb6ANT/GiHFj7kBjku
 +t3pUCA0KSbBZDayhBfjQEQ=
X-Google-Smtp-Source: ABdhPJyRcpUEv7laYWKD+F6CQu+ckahcbVjTDIqQIoL73250MFfKI1EPLnHGzMQz4Q23qpPUy5RpVQ==
X-Received: by 2002:adf:ffd0:: with SMTP id x16mr11765386wrs.104.1602195581262; 
 Thu, 08 Oct 2020 15:19:41 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:68d6:3fd5:5a8b:9959?
 ([2601:647:4802:9070:68d6:3fd5:5a8b:9959])
 by smtp.gmail.com with ESMTPSA id z13sm8922454wro.97.2020.10.08.15.19.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 15:19:40 -0700 (PDT)
Subject: Re: [PATCH net-next RFC v1 05/10] nvme-tcp: Add DDP offload control
 path
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-6-borisp@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c6bb16cc-fdda-3c4e-41f6-9155911aa2c8@grimberg.me>
Date: Thu, 8 Oct 2020 15:19:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930162010.21610-6-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_181942_516062_6D2536D8 
X-CRM114-Status: GOOD (  38.90  )
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



On 9/30/20 9:20 AM, Boris Pismenny wrote:
> This commit introduces direct data placement offload to NVME
> TCP. There is a context per queue, which is established after the
> handshake
> using the tcp_ddp_sk_add/del NDOs.
> 
> Additionally, a resynchronization routine is used to assist
> hardware recovery from TCP OOO, and continue the offload.
> Resynchronization operates as follows:
> 1. TCP OOO causes the NIC HW to stop the offload
> 2. NIC HW identifies a PDU header at some TCP sequence number,
> and asks NVMe-TCP to confirm it.
> This request is delivered from the NIC driver to NVMe-TCP by first
> finding the socket for the packet that triggered the request, and
> then fiding the nvme_tcp_queue that is used by this routine.
> Finally, the request is recorded in the nvme_tcp_queue.
> 3. When NVMe-TCP observes the requested TCP sequence, it will compare
> it with the PDU header TCP sequence, and report the result to the
> NIC driver (tcp_ddp_resync), which will update the HW,
> and resume offload when all is successful.
> 
> Furthermore, we let the offloading driver advertise what is the max hw
> sectors/segments via tcp_ddp_limits.
> 
> A follow-up patch introduces the data-path changes required for this
> offload.
> 
> Signed-off-by: Boris Pismenny <borisp@mellanox.com>
> Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
> Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
> Signed-off-by: Yoray Zack <yorayz@mellanox.com>
> ---
>   drivers/nvme/host/tcp.c  | 188 +++++++++++++++++++++++++++++++++++++++
>   include/linux/nvme-tcp.h |   2 +
>   2 files changed, 190 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 8f4f29f18b8c..06711ac095f2 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -62,6 +62,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_ALLOCATED	= 0,
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
> +	NVME_TCP_Q_OFFLOADS     = 3,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -110,6 +111,8 @@ struct nvme_tcp_queue {
>   	void (*state_change)(struct sock *);
>   	void (*data_ready)(struct sock *);
>   	void (*write_space)(struct sock *);
> +
> +	atomic64_t  resync_req;
>   };
>   
>   struct nvme_tcp_ctrl {
> @@ -129,6 +132,8 @@ struct nvme_tcp_ctrl {
>   	struct delayed_work	connect_work;
>   	struct nvme_tcp_request async_req;
>   	u32			io_queues[HCTX_MAX_TYPES];
> +
> +	struct net_device       *offloading_netdev;
>   };
>   
>   static LIST_HEAD(nvme_tcp_ctrl_list);
> @@ -223,6 +228,159 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
>   	return nvme_tcp_pdu_data_left(req) <= len;
>   }
>   
> +#ifdef CONFIG_TCP_DDP
> +
> +bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
> +const struct tcp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops __read_mostly = {
> +	.resync_request		= nvme_tcp_resync_request,
> +};
> +
> +static
> +int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue,
> +			    struct nvme_tcp_config *config)
> +{
> +	struct net_device *netdev = get_netdev_for_sock(queue->sock->sk, true);
> +	struct tcp_ddp_config *ddp_config = (struct tcp_ddp_config *)config;
> +	int ret;
> +
> +	if (unlikely(!netdev)) {

Let's remove unlikely from non datapath routines, its slightly
confusing.

> +		pr_info_ratelimited("%s: netdev not found\n", __func__);

dev_info_ratelimited with queue->ctrl->ctrl.device ?
Also, lets remove __func__. This usually is not very helpful.

> +		return -EINVAL;
> +	}
> +
> +	if (!(netdev->features & NETIF_F_HW_TCP_DDP)) {
> +		dev_put(netdev);
> +		return -EINVAL;

EINVAL or ENODEV?

> +	}
> +
> +	ret = netdev->tcp_ddp_ops->tcp_ddp_sk_add(netdev,
> +						 queue->sock->sk,
> +						 ddp_config);
> +	if (!ret)
> +		inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = &nvme_tcp_ddp_ulp_ops;
> +	else
> +		dev_put(netdev);
> +	return ret;
> +}
> +
> +static
> +void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
> +{
> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
> +
> +	if (unlikely(!netdev)) {
> +		pr_info_ratelimited("%s: netdev not found\n", __func__);

Same here.

> +		return;
> +	}
> +
> +	netdev->tcp_ddp_ops->tcp_ddp_sk_del(netdev, queue->sock->sk);
> +
> +	inet_csk(queue->sock->sk)->icsk_ulp_ddp_ops = NULL;

Just a general question, why is this needed?

> +	dev_put(netdev); /* put the queue_init get_netdev_for_sock() */
> +}
> +
> +static
> +int nvme_tcp_offload_limits(struct nvme_tcp_queue *queue,
> +			    struct tcp_ddp_limits *limits)
> +{
> +	struct net_device *netdev = get_netdev_for_sock(queue->sock->sk, true);
> +	int ret = 0;
> +
> +	if (unlikely(!netdev)) {
> +		pr_info_ratelimited("%s: netdev not found\n", __func__);
> +		return -EINVAL;

Same here

> +	}
> +
> +	if (netdev->features & NETIF_F_HW_TCP_DDP &&
> +	    netdev->tcp_ddp_ops &&
> +	    netdev->tcp_ddp_ops->tcp_ddp_limits)
> +			ret = netdev->tcp_ddp_ops->tcp_ddp_limits(netdev, limits);
> +	else
> +			ret = -EOPNOTSUPP;
> +
> +	if (!ret) {
> +		queue->ctrl->offloading_netdev = netdev;
> +		pr_info("%s netdev %s offload limits: max_ddp_sgl_len %d\n",
> +			__func__, netdev->name, limits->max_ddp_sgl_len);

dev_info, and given that it per-queue, please make it dev_dbg.

> +		queue->ctrl->ctrl.max_segments = limits->max_ddp_sgl_len;
> +		queue->ctrl->ctrl.max_hw_sectors =
> +			limits->max_ddp_sgl_len << (ilog2(SZ_4K) - 9);
> +	} else {
> +		queue->ctrl->offloading_netdev = NULL;

Maybe nullify in the controller setup intead?

> +	}
> +
> +	dev_put(netdev);
> +
> +	return ret;
> +}
> +
> +static
> +void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
> +			      unsigned int pdu_seq)
> +{
> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
> +	u64 resync_val;
> +	u32 resync_seq;
> +
> +	if (unlikely(!netdev)) {
> +		pr_info_ratelimited("%s: netdev not found\n", __func__);
> +		return;

What happens now, fallback to SW? Maybe dev_warn then..
will the SW keep seeing these responses after one failed?

> +	}
> +
> +	resync_val = atomic64_read(&queue->resync_req);
> +	if ((resync_val & TCP_DDP_RESYNC_REQ) == 0)
> +		return;
> +
> +	resync_seq = resync_val >> 32;
> +	if (before(pdu_seq, resync_seq))
> +		return;

I think it will be better to pass the skb to this func and keep the
pdu_seq contained locally.

> +
> +	if (atomic64_cmpxchg(&queue->resync_req, resync_val, (resync_val - 1)))
> +		netdev->tcp_ddp_ops->tcp_ddp_resync(netdev, queue->sock->sk, pdu_seq);

A small comment on this manipulation may help the reader.

> +}
> +
> +bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
> +{
> +	struct nvme_tcp_queue *queue = sk->sk_user_data;
> +
> +	atomic64_set(&queue->resync_req,
> +		     (((uint64_t)seq << 32) | flags));
> +
> +	return true;
> +}
> +
> +#else
> +
> +static
> +int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue,
> +			    struct nvme_tcp_config *config)
> +{
> +	return -EINVAL;
> +}
> +
> +static
> +void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
> +{}
> +
> +static
> +int nvme_tcp_offload_limits(struct nvme_tcp_queue *queue,
> +			    struct tcp_ddp_limits *limits)
> +{
> +	return -EINVAL;
> +}
> +
> +static
> +void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
> +			      unsigned int pdu_seq)
> +{}
> +
> +bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
> +{
> +	return false;
> +}
> +
> +#endif
> +
>   static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
>   		unsigned int dir)
>   {
> @@ -628,6 +786,11 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
>   	int ret;
>   
> +	u64 pdu_seq = TCP_SKB_CB(skb)->seq + *offset - queue->pdu_offset;
> +
> +	if (test_bit(NVME_TCP_Q_OFFLOADS, &queue->flags))
> +		nvme_tcp_resync_response(queue, pdu_seq);

Here, just pass in (queue, skb)

> +
>   	ret = skb_copy_bits(skb, *offset,
>   		&pdu[queue->pdu_offset], rcv_len);
>   	if (unlikely(ret))
> @@ -1370,6 +1533,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
>   {
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>   	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
> +	struct nvme_tcp_config config;
> +	struct tcp_ddp_limits limits;
>   	int ret, rcv_pdu_size;
>   
>   	queue->ctrl = ctrl;
> @@ -1487,6 +1652,26 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
>   #endif
>   	write_unlock_bh(&queue->sock->sk->sk_callback_lock);
>   
> +	if (nvme_tcp_queue_id(queue) != 0) {

	if (!nvme_tcp_admin_queue(queue)) {

> +		config.cfg.type		= TCP_DDP_NVME;
> +		config.pfv		= NVME_TCP_PFV_1_0;
> +		config.cpda		= 0;
> +		config.dgst		= queue->hdr_digest ?
> +						NVME_TCP_HDR_DIGEST_ENABLE : 0;
> +		config.dgst		|= queue->data_digest ?
> +						NVME_TCP_DATA_DIGEST_ENABLE : 0;
> +		config.queue_size	= queue->queue_size;
> +		config.queue_id		= nvme_tcp_queue_id(queue);
> +		config.io_cpu		= queue->io_cpu;

Can the config initialization move to nvme_tcp_offload_socket?

> +
> +		ret = nvme_tcp_offload_socket(queue, &config);
> +		if (!ret)
> +			set_bit(NVME_TCP_Q_OFFLOADS, &queue->flags);
> +	} else {
> +		ret = nvme_tcp_offload_limits(queue, &limits);
> +	}

I'm thinking that instead of this conditional, we want to place
nvme nvme_tcp_alloc_admin_queue in nvme_tcp_alloc_admin_queue, and
also move nvme_tcp_alloc_admin_queue to __nvme_tcp_alloc_io_queues
loop.

> +	/* offload is opportunistic - failure is non-critical */

Than make it void...

> +
>   	return 0;
>   
>   err_init_connect:
> @@ -1519,6 +1704,9 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
>   	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>   	nvme_tcp_restore_sock_calls(queue);
>   	cancel_work_sync(&queue->io_work);
> +
> +	if (test_bit(NVME_TCP_Q_OFFLOADS, &queue->flags))
> +		nvme_tcp_unoffload_socket(queue);

Why not in nvme_tcp_free_queue, symmetric to the alloc?

>   }
>   
>   static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
> diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
> index 959e0bd9a913..65df64c34ecd 100644
> --- a/include/linux/nvme-tcp.h
> +++ b/include/linux/nvme-tcp.h
> @@ -8,6 +8,8 @@
>   #define _LINUX_NVME_TCP_H
>   
>   #include <linux/nvme.h>
> +#include <net/sock.h>
> +#include <net/tcp_ddp.h>

Why is this needed? I think we want to place this in tcp.c no?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
