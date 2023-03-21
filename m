Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E943C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 13:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M9v05Gemu4F1X3tGXd5aoafk1hS3Mjb7SmJUAc4Ia+w=; b=ivq0rwLPuWqzJamTCwn8ZQgp3C
	7r0z0l3D/tTC5iNqc21l4rlyJpG2392Mwh9uWVso/UE/dXZzTmmXdndH/L8NOST8BzmhLOSMrRAFm
	BF7F+gtHoj5LP1EP1R7OcsPlZ7ig5gLc5sKu+ahIZKfVRjZf34FgtSaSIIYa5QLBwRjdv/XvOfbKS
	s5DMm4MlXbHRIU6T0cl6mrAnYlBY2x2Lc9sBqzEJrT9sSre1wvNiU4cQDbXFd7Z2/u8uJlNXon9jn
	/HWUCC/ta3+aPZ6cpjmV1CLjpT8xTC7yEQCsqZAKvOTdvkoj8F0APpdsSNH3us/WSgoPqpfcxuK6l
	axMMpRfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pecDW-00CZJk-38;
	Tue, 21 Mar 2023 13:39:58 +0000
Received: from mail-ed1-f54.google.com ([209.85.208.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pecDT-00CZIW-1p
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 13:39:57 +0000
Received: by mail-ed1-f54.google.com with SMTP id eh3so59757813edb.11
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 06:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679405993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9v05Gemu4F1X3tGXd5aoafk1hS3Mjb7SmJUAc4Ia+w=;
        b=IIgFzG8zUFK4esYXfz2V58Otu3b7V5WlPeiW1449kD6j7Mj5tqTw/0hXOE+81cRMzO
         8MF3yQPPh6/czo8cl4e8UihOxDxoxTikMJ+007vB0m75FBTin9ePnzH77BCu56wYF88n
         ro72f9AmMBQ84L7+gH5uTpNUt/JTEINPvh0TeTHqdnxyPiRuFPQauOOGDurF+Ybr4rum
         Xv2XsAWpZvD47Oh5k26wovn5MpAyze9KIkD1nZy4HA2nrFj5bdzfpt2bZk1NL/cKmuXB
         gfh76FJcOjYT1tJpEn7kvfwnvOFic2BNyu+1QA4Zm5CU+U6Ref9h1y3fH0OWTshldkX+
         H8uQ==
X-Gm-Message-State: AO0yUKWnxVHKDCUsHrPw0R2z78JWaPChY8FHi6BpN8wArguNX7dfy0C/
	kLwtSJSsdEwjR3OtXp43+U8=
X-Google-Smtp-Source: AK7set8xn66DLImr8lUNu4RLLe9UQ/QuP2KLn+kuUuTUE0G9GAxHr8l/nTSAAQpGCk7UedaPaKvC+w==
X-Received: by 2002:a05:6402:2803:b0:4bc:235c:dcb8 with SMTP id h3-20020a056402280300b004bc235cdcb8mr3796629ede.1.1679405993524;
        Tue, 21 Mar 2023 06:39:53 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id g9-20020a056402320900b004fd219242a5sm6257599eda.7.2023.03.21.06.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 06:39:53 -0700 (PDT)
Message-ID: <1fd17fd4-c52a-c29a-d15c-143a316eab9a@grimberg.me>
Date: Tue, 21 Mar 2023 15:39:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 05/18] nvme-tcp: implement recvmsg rx flow for TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-6-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321124325.77385-6-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_063955_645343_B775DBB6 
X-CRM114-Status: GOOD (  28.62  )
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



On 3/21/23 14:43, Hannes Reinecke wrote:
> TLS offload only implements recvmsg(), so implement the receive
> side with using recvmsg().

I don't really mind changing this, however this change makes us
lock the socket for every consumption, instead of taking the lock
once and consume as much as possible. Which in theory is suboptimal.

Is there any material reason why tls cannot implement read_sock() ?

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 156 ++++++++++++++++++++--------------------
>   1 file changed, 77 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 42c0598c31f2..0e14b1b90855 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -529,7 +529,7 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
>   	queue->pdu_remaining = sizeof(struct nvme_tcp_rsp_pdu) +
>   				nvme_tcp_hdgst_len(queue);
>   	queue->pdu_offset = 0;
> -	queue->data_remaining = -1;
> +	queue->data_remaining = 0;
>   	queue->ddgst_remaining = 0;
>   }
>   
> @@ -707,25 +707,32 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
>   	return 0;
>   }
>   
> -static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> -		unsigned int *offset, size_t *len)
> +static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, bool pending)
>   {
>   	struct nvme_tcp_hdr *hdr;
> -	char *pdu = queue->pdu;
> -	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
> +	size_t rcv_len = queue->pdu_remaining;
> +	struct msghdr msg = {
> +		.msg_flags = pending ? 0 : MSG_DONTWAIT,

Umm, why?
What is the reason to block in this recv?

> +	};
> +	struct kvec iov = {
> +		.iov_base = (u8 *)queue->pdu + queue->pdu_offset,
> +		.iov_len = rcv_len,
> +	};
>   	int ret;
>   
> -	ret = skb_copy_bits(skb, *offset,
> -		&pdu[queue->pdu_offset], rcv_len);
> -	if (unlikely(ret))
> +	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_PDU)
> +		return 0;

Why is this check needed? looks like a left-over.

> +
> +	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
> +			     iov.iov_len, msg.msg_flags);
> +	if (ret <= 0)
>   		return ret;
>   
> +	rcv_len = ret;
>   	queue->pdu_remaining -= rcv_len;
>   	queue->pdu_offset += rcv_len;
> -	*offset += rcv_len;
> -	*len -= rcv_len;
>   	if (queue->pdu_remaining)
> -		return 0;
> +		return queue->pdu_remaining;
>   
>   	hdr = queue->pdu;
>   	if (queue->hdr_digest) {
> @@ -734,7 +741,6 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   			return ret;
>   	}
>   
> -
>   	if (queue->data_digest) {
>   		ret = nvme_tcp_check_ddgst(queue, queue->pdu);
>   		if (unlikely(ret))
> @@ -765,19 +771,21 @@ static inline void nvme_tcp_end_request(struct request *rq, u16 status)
>   		nvme_complete_rq(rq);
>   }
>   
> -static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> -			      unsigned int *offset, size_t *len)
> +static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue)
>   {
>   	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
>   	struct request *rq =
>   		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   
> +	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DATA)
> +		return 0;
> +
>   	while (true) {
> -		int recv_len, ret;
> +		struct msghdr msg;
> +		int ret;
>   
> -		recv_len = min_t(size_t, *len, queue->data_remaining);
> -		if (!recv_len)
> +		if (!queue->data_remaining)
>   			break;
>   
>   		if (!iov_iter_count(&req->iter)) {
> @@ -798,25 +806,20 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		}
>   
>   		/* we can read only from what is left in this bio */
> -		recv_len = min_t(size_t, recv_len,
> -				iov_iter_count(&req->iter));
> +		memset(&msg, 0, sizeof(msg));
> +		msg.msg_iter = req->iter;
>   
> -		if (queue->data_digest)
> -			ret = skb_copy_and_hash_datagram_iter(skb, *offset,
> -				&req->iter, recv_len, queue->rcv_hash);
> -		else
> -			ret = skb_copy_datagram_iter(skb, *offset,
> -					&req->iter, recv_len);
> -		if (ret) {
> +		ret = sock_recvmsg(queue->sock, &msg, 0);

Who updates the rcv_hash for data digest validation?

> +		if (ret <= 0) {
>   			dev_err(queue->ctrl->ctrl.device,
> -				"queue %d failed to copy request %#x data",
> +				"queue %d failed to receive request %#x data",
>   				nvme_tcp_queue_id(queue), rq->tag);
>   			return ret;
>   		}
>   
> -		*len -= recv_len;
> -		*offset += recv_len;
> -		queue->data_remaining -= recv_len;
> +		queue->data_remaining -= ret;
> +		if (queue->data_remaining)
> +			nvme_tcp_advance_req(req, ret);
>   	}
>   
>   	if (!queue->data_remaining) {
> @@ -833,27 +836,36 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		}
>   	}
>   
> -	return 0;
> +	return queue->data_remaining;
>   }
>   
> -static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
> -		struct sk_buff *skb, unsigned int *offset, size_t *len)
> +static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue)
>   {
>   	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
>   	char *ddgst = (char *)&queue->recv_ddgst;
> -	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
> +	size_t recv_len = queue->ddgst_remaining;
>   	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
> +	struct msghdr msg = {
> +		.msg_flags = 0,
> +	};
> +	struct kvec iov = {
> +		.iov_base = (u8 *)ddgst + off,
> +		.iov_len = recv_len,
> +	};
>   	int ret;
>   
> -	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
> -	if (unlikely(ret))
> +	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DDGST)
> +		return 0;
> +
> +	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1, iov.iov_len,
> +			     msg.msg_flags);
> +	if (ret <= 0)
>   		return ret;
>   
> +	recv_len = ret;
>   	queue->ddgst_remaining -= recv_len;
> -	*offset += recv_len;
> -	*len -= recv_len;
>   	if (queue->ddgst_remaining)
> -		return 0;
> +		return queue->ddgst_remaining;
>   
>   	if (queue->recv_ddgst != queue->exp_ddgst) {
>   		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
> @@ -881,37 +893,41 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	return 0;
>   }
>   
> -static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
> -			     unsigned int offset, size_t len)
> +static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue, bool pending)
>   {
> -	struct nvme_tcp_queue *queue = desc->arg.data;
> -	size_t consumed = len;
>   	int result;
> +	int nr_cqe = queue->nr_cqe;
>   
> -	while (len) {
> +	do {
>   		switch (nvme_tcp_recv_state(queue)) {
>   		case NVME_TCP_RECV_PDU:
> -			result = nvme_tcp_recv_pdu(queue, skb, &offset, &len);
> -			break;
> +			result = nvme_tcp_recv_pdu(queue, pending);
> +			if (result)
> +				break;
> +			fallthrough;
>   		case NVME_TCP_RECV_DATA:
> -			result = nvme_tcp_recv_data(queue, skb, &offset, &len);
> -			break;
> +			result = nvme_tcp_recv_data(queue);
> +			if (result)
> +				break;
> +			fallthrough;
>   		case NVME_TCP_RECV_DDGST:
> -			result = nvme_tcp_recv_ddgst(queue, skb, &offset, &len);
> +			result = nvme_tcp_recv_ddgst(queue);
>   			break;
>   		default:
>   			result = -EFAULT;
>   		}
> -		if (result) {
> -			dev_err(queue->ctrl->ctrl.device,
> -				"receive failed:  %d\n", result);
> -			queue->rd_enabled = false;
> -			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> -			return result;
> -		}
> +		if (nr_cqe != queue->nr_cqe)
> +			break;
> +	} while (result >= 0);
> +	if (result < 0 && result != -EAGAIN) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"receive failed: %d state %d %s\n",
> +			result, nvme_tcp_recv_state(queue),
> +			pending ? "pending" : "");

I'm unclear why pending would be an input to try_recv. Semantically
it is an output, signalling the io_work that data is pending to be
reaped from the socket.

> +		queue->rd_enabled = false;
> +		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
>   	}
> -
> -	return consumed;
> +	return result < 0 ? result : (queue->nr_cqe - nr_cqe);

Isn't it possible that we consumed data but no completion in this
round? I'm assuming that

