Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8623C433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 09:17:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B6464F4B
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 09:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B6464F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pkN/MWhR0FAbwEQlo9SmJZqnT+tpXUtkkGaGq6c3QkI=; b=GOhmL71YLpzj2o2U83T36xnxQ
	621r85msosV4JXQW1EbahCq4snWSDWkcGD/KFOdoeI5jjI+ljA04FcI+4BtTKnQ/AZTur7NJbhNcT
	FkXmqYAC28V879XIKMrAEU+EsEJTYOw447sogGm0UUgFBxmRq7ClNN0FCRSFa2uxez/1LBPH0dqvR
	/42bHD09AFAW3q4TEGz1fXQonV8Rk0U1XslY5G+A1R9yjhl9Q+zQJAenph5X+54f5Iu18lhnUm9sb
	Mmgo2QHFxI7oSSHv/UG9rxLMvMaYMLZM4fWOfTEUSbBDK6hQOY0cre9rzIdfeluXyQT3BFo27gns/
	p5dqU1C4g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7EIJ-0002Fr-IP; Wed, 03 Feb 2021 09:17:51 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7EIF-0002F8-RU
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 09:17:49 +0000
Received: by mail-wr1-f43.google.com with SMTP id m13so23307056wro.12
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 01:17:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7EeDLJNrMM8/PMi+pckNdgS8b9TquLNjKhA1vzScE+k=;
 b=fOE07mK+08Ry23Dl04RBIk1ewlkfZBDja+Lwub39fOFfFrC61hHz4QgUoKs9BLyMWU
 PzAsey1Q7O/VFliUe+Lmo5+kyjPs72QwfWtb/UxMN0ay85RAOUywlEil1Ez6LxCdJmC3
 0140Sd++LoELtMCm8pDsMmyPA/D1PxxiTarBCvyJggznNVzLWsEGxNq1vMM1YxhX6Xrc
 6LToOsVWk65z34R/bvTxGfwllJ8HbVQGbNS72z3h6HaFmX/L/nxYn12F4LNaCVAImd+r
 ApcxoQruaqkCpnaNWGeNPsjmGw856+ocoUiNyIeXPNtgZDuUK9GPMDs6BNtR4o3k8inb
 BMRA==
X-Gm-Message-State: AOAM532yIl+kD/N27imHQ75iULPPebuqQv8gy8j4t70MlcN5W0HG1dfv
 OjoNc+P4SuarkcYq/r/UCnk=
X-Google-Smtp-Source: ABdhPJx3uBBqcI+aw3/JWnT0NUYuQY2JdwwtIywAbFzGNeFoD0OMIIHJtm4RRmgP8OHEcQfAoMkZVw==
X-Received: by 2002:adf:ff91:: with SMTP id j17mr2261420wrr.377.1612343866337; 
 Wed, 03 Feb 2021 01:17:46 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:819b:e1e8:19a6:9008?
 ([2601:647:4802:9070:819b:e1e8:19a6:9008])
 by smtp.gmail.com with ESMTPSA id 36sm2718262wrj.97.2021.02.03.01.17.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Feb 2021 01:17:45 -0800 (PST)
Subject: Re: [PATCH v3 net-next 06/21] nvme-tcp: Add DDP offload control path
To: Boris Pismenny <borisp@mellanox.com>, dsahern@gmail.com, kuba@kernel.org, 
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com,
 smalin@marvell.com
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-7-borisp@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <701052c3-1d55-ecb1-b14e-65b2e3a7c4e6@grimberg.me>
Date: Wed, 3 Feb 2021 01:17:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210201100509.27351-7-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_041747_926557_35EA5B78 
X-CRM114-Status: GOOD (  38.66  )
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
> This commit introduces direct data placement offload to NVME
> TCP. There is a context per queue, which is established after the
> handshake using the tcp_ddp_sk_add/del NDOs.
> 
> Additionally, a resynchronization routine is used to assist
> hardware recovery from TCP OOO, and continue the offload.
> Resynchronization operates as follows:
> 
> 1. TCP OOO causes the NIC HW to stop the offload
> 
> 2. NIC HW identifies a PDU header at some TCP sequence number,
> and asks NVMe-TCP to confirm it.
> This request is delivered from the NIC driver to NVMe-TCP by first
> finding the socket for the packet that triggered the request, and
> then finding the nvme_tcp_queue that is used by this routine.
> Finally, the request is recorded in the nvme_tcp_queue.
> 
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
>   drivers/nvme/host/tcp.c | 200 +++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 198 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 881d28eb15e9..ea67caf9d326 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -14,6 +14,7 @@
>   #include <linux/blk-mq.h>
>   #include <crypto/hash.h>
>   #include <net/busy_poll.h>
> +#include <net/tcp_ddp.h>
>   
>   #include "nvme.h"
>   #include "fabrics.h"
> @@ -62,6 +63,7 @@ enum nvme_tcp_queue_flags {
>   	NVME_TCP_Q_ALLOCATED	= 0,
>   	NVME_TCP_Q_LIVE		= 1,
>   	NVME_TCP_Q_POLLING	= 2,
> +	NVME_TCP_Q_OFF_DDP	= 3,
>   };
>   
>   enum nvme_tcp_recv_state {
> @@ -111,6 +113,8 @@ struct nvme_tcp_queue {
>   	void (*state_change)(struct sock *);
>   	void (*data_ready)(struct sock *);
>   	void (*write_space)(struct sock *);
> +
> +	atomic64_t  resync_req;
>   };
>   
>   struct nvme_tcp_ctrl {
> @@ -129,6 +133,8 @@ struct nvme_tcp_ctrl {
>   	struct delayed_work	connect_work;
>   	struct nvme_tcp_request async_req;
>   	u32			io_queues[HCTX_MAX_TYPES];
> +
> +	struct net_device       *offloading_netdev;
>   };
>   
>   static LIST_HEAD(nvme_tcp_ctrl_list);
> @@ -223,6 +229,183 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
>   	return nvme_tcp_pdu_data_left(req) <= len;
>   }
>   
> +#ifdef CONFIG_TCP_DDP
> +
> +static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
> +static const struct tcp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
> +	.resync_request		= nvme_tcp_resync_request,
> +};
> +
> +static
> +int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
> +{
> +	struct net_device *netdev = get_netdev_for_sock(queue->sock->sk, true);

Sometimes you use get_netdev_for_sock and sometimes
queue->ctrl->offloading_netdev, is this because of admin vs. io queue?

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

Isn't the comment redundant.

> +}
> +
> +static
> +int nvme_tcp_offload_limits(struct nvme_tcp_queue *queue)
> +{
> +	struct net_device *netdev = get_netdev_for_sock(queue->sock->sk, true);
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
> +		dev_dbg_ratelimited(queue->ctrl->ctrl.device,
> +				    "netdev %s offload limits: max_ddp_sgl_len %d\n",
> +				    netdev->name, limits.max_ddp_sgl_len);
> +		queue->ctrl->ctrl.max_segments = limits.max_ddp_sgl_len;
> +		queue->ctrl->ctrl.max_hw_sectors =
> +			limits.max_ddp_sgl_len << (ilog2(SZ_4K) - 9);
> +	} else {
> +		queue->ctrl->offloading_netdev = NULL;

In other error paths in the function this assignment is not needed?

> +	}
> +
> +	/* release the device as no offload context is established yet. */
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
> +static
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
> +int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
> +{
> +	return -EINVAL;
> +}
> +
> +static
> +void nvme_tcp_unoffload_socket(struct nvme_tcp_queue *queue)
> +{}
> +
> +static
> +int nvme_tcp_offload_limits(struct nvme_tcp_queue *queue)
> +{
> +	return -EINVAL;
> +}
> +
> +static
> +void nvme_tcp_resync_response(struct nvme_tcp_queue *queue,
> +			      unsigned int pdu_seq)
> +{}
> +
> +static
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
> @@ -638,6 +821,11 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
>   	int ret;
>   
> +	u64 pdu_seq = TCP_SKB_CB(skb)->seq + *offset - queue->pdu_offset;
> +
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +		nvme_tcp_resync_response(queue, pdu_seq);

Maybe just pass (queue, skb, *offset) and retrieve the pdu_seq in
nvme_tcp_resync_response?

> +
>   	ret = skb_copy_bits(skb, *offset,
>   		&pdu[queue->pdu_offset], rcv_len);
>   	if (unlikely(ret))
> @@ -1532,6 +1720,9 @@ static void __nvme_tcp_stop_queue(struct nvme_tcp_queue *queue)
>   	kernel_sock_shutdown(queue->sock, SHUT_RDWR);
>   	nvme_tcp_restore_sock_calls(queue);
>   	cancel_work_sync(&queue->io_work);
> +
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
> +		nvme_tcp_unoffload_socket(queue);
>   }
>   
>   static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
> @@ -1550,10 +1741,13 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
>   	int ret;
>   
> -	if (idx)
> +	if (idx) {
>   		ret = nvmf_connect_io_queue(nctrl, idx, false);
> -	else
> +		nvme_tcp_offload_socket(&ctrl->queues[idx]);
> +	} else {
>   		ret = nvmf_connect_admin_queue(nctrl);
> +		nvme_tcp_offload_limits(&ctrl->queues[idx]);
> +	}
>   
>   	if (!ret) {
>   		set_bit(NVME_TCP_Q_LIVE, &ctrl->queues[idx].flags);
> @@ -1656,6 +1850,8 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   {
>   	int ret;
>   
> +	to_tcp_ctrl(ctrl)->offloading_netdev = NULL;
> +
>   	ret = nvme_tcp_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
>   	if (ret)
>   		return ret;
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
