Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A7FC433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 08:52:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF34D64DE8
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 08:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF34D64DE8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cApuz/d5c/+ODCdrxMw9PaHUxMgCYecHlsJJDmDCeYE=; b=XbsBlr4K9YySlHY9b7nvMcp58
	+VaMNndqRn2kiz6i1tnzM/WDJeVD6Nl7tikm5Ccf4gp6XZ5M5oBQpzHI8SPZtKQp2oBCsuxV7IigB
	aeux8PzH6/Mec1g+MrX5YA7bZrUQtuZw/XbvbgAtmN1NZ06dwyFXXk2y4RI0Ci06zscyOPL2oKUR0
	rLBzEZlB4bt1sCoO4gjj3VyXHbXBr7G1gslrdK4Td3sOLRWXZsuoyjpedwi9/VyqCFO41LILo2hIU
	JnBS/dTNNAGCJ830P5KtCKRpmj+ekWXL8U1TCBo4mI1KX2K3WMylbpNt1ZEJqO3k3DSc8pQ3suu9k
	cp3lnZI7w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7DtE-0008Hh-Al; Wed, 03 Feb 2021 08:51:56 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7DtB-0008Gm-KU
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 08:51:54 +0000
Received: by mail-wr1-f45.google.com with SMTP id l12so23225796wry.2
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 00:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3mDiD0JJR4/9Mgq5fzOCXTZgztSQAbNAzSUZFA9ppc4=;
 b=p7p7M0mMiAGfCHHxONTlzgXWpKCR4J2e4x2TdLVexDqjOqMWL0juVbIdPjg0FIKos8
 b19cwiqsdbsVxTjfu2TsaVubukDBANPaydn7x+pUSlWMSSu59hNTOxqN/5uQ0FY796DJ
 l71/b47ZrA6acXcudnNDFiA7xAB3fAg944Sv/mM0FbHC4fUDq4gycnL13qY+Dm9NqRUn
 fNtxo4uczuV7L9rzq0EsxTKUc1cds8uTzLCoTufAd4JbRn0xdOwW5w4DOtaztEMZhdcS
 3qa5CgG9Ne8ARwupETk2TjtQdKRoO7SJd/SFaJKHEkQj/Wiz5Sdv9sJ0foXtBEKIv9PC
 /wIw==
X-Gm-Message-State: AOAM532rn2GYv0JPDeCMg7U+5S1ly/fX5FfkJVz0s0URzX+IRsJgwMb9
 2PXmyUtAcFt76deuIXbCMJU=
X-Google-Smtp-Source: ABdhPJz/sXmbzXlifG2oC+cfB0KfIGBnEzSt3XadolhkJWhyOotfRp7ttmXDHGkeBWv3Nh3X9581Ww==
X-Received: by 2002:adf:d206:: with SMTP id j6mr2194966wrh.427.1612342312029; 
 Wed, 03 Feb 2021 00:51:52 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:819b:e1e8:19a6:9008?
 ([2601:647:4802:9070:819b:e1e8:19a6:9008])
 by smtp.gmail.com with ESMTPSA id i20sm1729359wmq.7.2021.02.03.00.51.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Feb 2021 00:51:51 -0800 (PST)
Subject: Re: [PATCH v3 net-next 07/21] nvme-tcp: Add DDP data-path
To: Boris Pismenny <borisp@mellanox.com>, dsahern@gmail.com, kuba@kernel.org, 
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com,
 smalin@marvell.com
References: <20210201100509.27351-1-borisp@mellanox.com>
 <20210201100509.27351-8-borisp@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9a8041aa-513f-09b9-63f4-3d12db19231c@grimberg.me>
Date: Wed, 3 Feb 2021 00:51:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210201100509.27351-8-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_035153_704498_131BC010 
X-CRM114-Status: GOOD (  33.60  )
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
> Introduce the NVMe-TCP DDP data-path offload.
> Using this interface, the NIC hardware will scatter TCP payload directly
> to the BIO pages according to the command_id in the PDU.
> To maintain the correctness of the network stack, the driver is expected
> to construct SKBs that point to the BIO pages.
> 
> The data-path interface contains two routines: tcp_ddp_setup/teardown.
> The setup provides the mapping from command_id to the request buffers,
> while the teardown removes this mapping.
> 
> For efficiency, we introduce an asynchronous nvme completion, which is
> split between NVMe-TCP and the NIC driver as follows:
> NVMe-TCP performs the specific completion, while NIC driver performs the
> generic mq_blk completion.
> 
> Signed-off-by: Boris Pismenny <borisp@mellanox.com>
> Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
> Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
> Signed-off-by: Yoray Zack <yorayz@mellanox.com>
> ---
>   drivers/nvme/host/tcp.c | 141 +++++++++++++++++++++++++++++++++++++---
>   1 file changed, 131 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index ea67caf9d326..5cb46deb56e0 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -57,6 +57,11 @@ struct nvme_tcp_request {
>   	size_t			offset;
>   	size_t			data_sent;
>   	enum nvme_tcp_send_state state;
> +
> +	bool			offloaded;
> +	struct tcp_ddp_io	ddp;
> +	__le16			status;
> +	union nvme_result	result;
>   };
>   
>   enum nvme_tcp_queue_flags {
> @@ -232,10 +237,74 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
>   #ifdef CONFIG_TCP_DDP
>   
>   static bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags);
> +static void nvme_tcp_ddp_teardown_done(void *ddp_ctx);
>   static const struct tcp_ddp_ulp_ops nvme_tcp_ddp_ulp_ops = {
>   	.resync_request		= nvme_tcp_resync_request,
> +	.ddp_teardown_done	= nvme_tcp_ddp_teardown_done,
>   };
>   
> +static
> +int nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
> +			  u16 command_id,
> +			  struct request *rq)
> +{
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
> +	int ret;
> +
> +	if (unlikely(!netdev)) {
> +		pr_info_ratelimited("%s: netdev not found\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	ret = netdev->tcp_ddp_ops->tcp_ddp_teardown(netdev, queue->sock->sk,
> +						    &req->ddp, rq);
> +	sg_free_table_chained(&req->ddp.sg_table, SG_CHUNK_SIZE);
> +	req->offloaded = false;

Why is the offloaded = false needed here? you also clear it when
you setup.

> +	return ret;
> +}
> +
> +static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
> +{
> +	struct request *rq = ddp_ctx;
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +
> +	if (!nvme_try_complete_req(rq, cpu_to_le16(req->status << 1), req->result))
> +		nvme_complete_rq(rq);

Why is the status shifted here? it was taken from the cqe as is..

> +}
> +
> +static
> +int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
> +		       u16 command_id,
> +		       struct request *rq)
> +{
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	struct net_device *netdev = queue->ctrl->offloading_netdev;
> +	int ret;
> +
> +	req->offloaded = false;
> +
> +	if (unlikely(!netdev)) {
> +		pr_info_ratelimited("%s: netdev not found\n", __func__);

dev_info_ratelimited please.

> +		return -EINVAL;
> +	}
> +
> +	req->ddp.command_id = command_id;
> +	req->ddp.sg_table.sgl = req->ddp.first_sgl;
> +	ret = sg_alloc_table_chained(&req->ddp.sg_table, blk_rq_nr_phys_segments(rq),
> +				     req->ddp.sg_table.sgl, SG_CHUNK_SIZE);
> +	if (ret)
> +		return -ENOMEM;
> +	req->ddp.nents = blk_rq_map_sg(rq->q, rq, req->ddp.sg_table.sgl);
> +
> +	ret = netdev->tcp_ddp_ops->tcp_ddp_setup(netdev,
> +						 queue->sock->sk,
> +						 &req->ddp);
> +	if (!ret)
> +		req->offloaded = true;
> +	return ret;
> +}
> +
>   static
>   int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   {
> @@ -377,6 +446,25 @@ bool nvme_tcp_resync_request(struct sock *sk, u32 seq, u32 flags)
>   
>   #else
>   
> +static
> +int nvme_tcp_setup_ddp(struct nvme_tcp_queue *queue,
> +		       u16 command_id,
> +		       struct request *rq)
> +{
> +	return -EINVAL;
> +}
> +
> +static
> +int nvme_tcp_teardown_ddp(struct nvme_tcp_queue *queue,
> +			  u16 command_id,
> +			  struct request *rq)
> +{
> +	return -EINVAL;
> +}
> +
> +static void nvme_tcp_ddp_teardown_done(void *ddp_ctx)
> +{}
> +
>   static
>   int nvme_tcp_offload_socket(struct nvme_tcp_queue *queue)
>   {
> @@ -665,6 +753,7 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
>   static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		struct nvme_completion *cqe)
>   {
> +	struct nvme_tcp_request *req;
>   	struct request *rq;
>   
>   	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), cqe->command_id);
> @@ -676,8 +765,15 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
>   		return -EINVAL;
>   	}
>   
> -	if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
> -		nvme_complete_rq(rq);
> +	req = blk_mq_rq_to_pdu(rq);
> +	if (req->offloaded) {
> +		req->status = cqe->status;
> +		req->result = cqe->result;
> +		nvme_tcp_teardown_ddp(queue, cqe->command_id, rq);
> +	} else {
> +		if (!nvme_try_complete_req(rq, cqe->status, cqe->result))
> +			nvme_complete_rq(rq);
> +	}

Maybe move this to nvme_tcp_complete_request as it is called from two
code paths.

>   	queue->nr_cqe++;
>   
>   	return 0;
> @@ -871,9 +967,18 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   static inline void nvme_tcp_end_request(struct request *rq, u16 status)
>   {
>   	union nvme_result res = {};
> +	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	struct nvme_tcp_queue *queue = req->queue;
> +	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
>   
> -	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
> -		nvme_complete_rq(rq);
> +	if (req->offloaded) {
> +		req->status = cpu_to_le16(status << 1);
> +		req->result = res;
> +		nvme_tcp_teardown_ddp(queue, pdu->command_id, rq);
> +	} else {
> +		if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
> +			nvme_complete_rq(rq);
> +	}
>   }
>   
>   static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> @@ -920,12 +1025,22 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		recv_len = min_t(size_t, recv_len,
>   				iov_iter_count(&req->iter));
>   
> -		if (queue->data_digest)
> -			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
> -				&req->iter, recv_len, queue->rcv_hash);
> -		else
> -			ret = skb_copy_datagram_iter(skb, *offset,
> -					&req->iter, recv_len);
> +		if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags)) {
> +			if (queue->data_digest)
> +				ret = skb_ddp_copy_and_hash_datagram_iter(skb, *offset,
> +						&req->iter, recv_len, queue->rcv_hash);
> +			else
> +				ret = skb_ddp_copy_datagram_iter(skb, *offset,
> +						&req->iter, recv_len);
> +		} else {
> +			if (queue->data_digest)
> +				ret = skb_copy_and_hash_datagram_iter(skb, *offset,
> +						&req->iter, recv_len, queue->rcv_hash);
> +			else
> +				ret = skb_copy_datagram_iter(skb, *offset,
> +						&req->iter, recv_len);
> +		}
> +

Maybe move this hunk to nvme_tcp_consume_skb or something?

>   		if (ret) {
>   			dev_err(queue->ctrl->ctrl.device,
>   				"queue %d failed to copy request %#x data",
> @@ -1149,6 +1264,7 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>   	bool inline_data = nvme_tcp_has_inline_data(req);
>   	u8 hdgst = nvme_tcp_hdgst_len(queue);
>   	int len = sizeof(*pdu) + hdgst - req->offset;
> +	struct request *rq = blk_mq_rq_from_pdu(req);
>   	int flags = MSG_DONTWAIT;
>   	int ret;
>   
> @@ -1157,6 +1273,10 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>   	else
>   		flags |= MSG_EOR;
>   
> +	if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags) &&
> +	    blk_rq_nr_phys_segments(rq) && rq_data_dir(rq) == READ)
> +		nvme_tcp_setup_ddp(queue, pdu->cmd.common.command_id, rq);
> +
>   	if (queue->hdr_digest && !req->offset)
>   		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
>   
> @@ -2464,6 +2584,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
>   	req->data_len = blk_rq_nr_phys_segments(rq) ?
>   				blk_rq_payload_bytes(rq) : 0;
>   	req->curr_bio = rq->bio;
> +	req->offloaded = false;

offloaded is being cleared lots of times, and I'm not clear what are
the lifetime rules here.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
