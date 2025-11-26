Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47566D10384
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 07:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2kS/jWNIawxgTJg5C6OhtBDtDgaZEKdArxCMlHpDTmg=; b=Na7vN0rZBPTi+li0wLS54yWrBy
	WfWFJTdc2cCVX7QqIEiSFVcTUqrhoxMVKh2qKP9BLmdwBa/SQKRqzSr4E0NhkeRvAcMz0zGYD4HDL
	TKCRKPCKIaz4diHbu9p0y7Q20BCki917d/iSj+8qYS+frLyeS3xn4YXE0FUtg2zFtW6HJ8zwCo9Hl
	6Y2nwNA6Hy1X2i55W7HO1xRVs+I+IrSA0rftDJVwLnzt7cCXvz77o+vqT93Sey84V7RtSXXjODwsl
	Vu9RZVwyhjYfkiEny1XdxCE7g57hbVh3P6rMIZlwByoI9Hd1PXTCfZNaMR4f+5Z9TTsXvVObcqA/c
	B8IK0EZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOA1N-0000000EWYi-1RyZ;
	Wed, 26 Nov 2025 07:33:01 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOA1K-0000000EWY1-1Gwf
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 07:32:59 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so41793275e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 23:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764142376; x=1764747176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kS/jWNIawxgTJg5C6OhtBDtDgaZEKdArxCMlHpDTmg=;
        b=tLzrGQC6cBs9kP8MD1LuAhHoaZGryB8gPOm19uIlXgJCcDMW/5fHc83E865JUPRB7e
         L0zFwq+aX4hh7OTE7x5aI1VftKElgqfB+d2ZvjN7AxT/JdR+dFSjrAxsezKdLd0UNGEr
         CA2LvjPElTZRAIilxOgmkD+QNvyLqfEp2HOrEINbaaarle4xBYMFHF3Hdq0sO7qOu1ZI
         yVzb1n6hur51qZNkQJXUViO4OOUS5nL6HnOdu2JWtnszk5kWORFtpzjbukX7Trasuxir
         5+M/vWQA20SgKmvhCwu5bTSGaUle6P1UJyriHtIkDMx5p4AgZXiy/w1K7soxMPCaEH2v
         GVbA==
X-Forwarded-Encrypted: i=1; AJvYcCUV2rvVIWmiSZTOD2NJ+C7fLXgmKYKs0QkG2MzPUg6JTJtNpnrndUBGEBP8p1NdmjNcxo+WimHDgr5U@lists.infradead.org
X-Gm-Message-State: AOJu0Yw1FqcGa5bL+PsxpvybG/OeIziwkxSYrFmkpbjQlch6vYzQ+Ax/
	uVWt9TU2pB8V0xRTY64lpOTrcOErViAPVm+OFIEuc9C5r850nBEUfjPDnAHG/A==
X-Gm-Gg: ASbGncu694ywBYkdFlUFi3FZFpJKoa+9KkssJxxVYve6RFw0bl+8optbLc6yjFOrsXz
	18XRGUL6fhowuAZu5I6UgN7MV2XrKOTqMsrPN8+osDrqj3ZTooiH/4OLjnff+Ptq28K1DrYklWa
	WQ1sGnZVoLJdhm1puyD8fGHKZnfnIFvD6XlfElQJbwSZPx+3xNk9j48l4CEpALH6FlAU2d270kC
	s/47dSMlo+1jiR0dWpvCzaEk8s28WyRSMkAv3D5Xn9muuBR8v6B4+lb7O9c+aD9A7KKYcR0LG5B
	V2YCJlAgLMvBTWd8SkEEiN16iNs3mnX/+GQS0g0xz5xUYw4k+961HMvXWn1dFqU63i35Z8HK21k
	e5d+oQLwZiDJznH9PiyPZXRWGEQ93uYsVR9UcRuqViK90nrrUxkKoVsWnqN5TczzfzxmE6skpI4
	jzs5Hr8u01XD5AGQsGpJrujbb9AL4zUzX1Q2HUCYQvMvkWFcqntGF+LXJbGdM+djo=
X-Google-Smtp-Source: AGHT+IEv9orI+YSPNyEwKpciDeUG7oxBpOwdmA/rHeTmTBRiMD/6jOJ6HgTYQMUPbdHl65mvuKiDmQ==
X-Received: by 2002:a05:600c:4e93:b0:471:9da:5232 with SMTP id 5b1f17b1804b1-477c10e1ccdmr196532805e9.15.1764142376321;
        Tue, 25 Nov 2025 23:32:56 -0800 (PST)
Received: from [10.50.4.190] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47906cb1f60sm32919325e9.1.2025.11.25.23.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 23:32:55 -0800 (PST)
Message-ID: <42d6103c-3cbe-49e9-a8c3-6a6c652a60e7@grimberg.me>
Date: Wed, 26 Nov 2025 09:32:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-tcp: Implement recvmsg() receive flow
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20251020085815.20657-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251020085815.20657-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_233258_416220_5349E5EB 
X-CRM114-Status: GOOD (  40.38  )
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



On 20/10/2025 11:58, Hannes Reinecke wrote:
> The nvme-tcp code is using the ->read_sock() interface to
> read data from the wire. While this interface gives us access
> to the skbs themselves (and so might be able to reduce latency)
> it does not interpret the skbs.
> Additionally for TLS these skbs have to be re-constructed from
> the TLS stream data, rendering any advantage questionable.
> But the main drawback for TLS is that we do not get access to
> the TLS control messages, so if we receive any of those message
> the only choice we have is to tear down the connection and restart.
> This patch switches the receive side over to use recvmsg(), which
> provides us full access to the TLS control messages and is also
> more efficient when working with TLS as skbs do not need to be
> artificially constructed.

Hannes,

I generally agree with this approach. I'd like to point out though
that this is going to give up running RX from directly from softirq context.
I've gone back and forth on weather nvme-tcp should do that, but never
got to do a thorough comparison between the two. This probably shuts
the door on that option.

Having said that, I am fine with this approach. recvmsg is a saner 
interface.

>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/tcp.c | 203 ++++++++++++++++++++++------------------
>   1 file changed, 110 insertions(+), 93 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 9a96df1a511c..081f53fa9fc4 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -17,6 +17,7 @@
>   #include <net/tls_prot.h>
>   #include <net/handshake.h>
>   #include <linux/blk-mq.h>
> +#include <linux/iov_iter.h>
>   #include <net/busy_poll.h>
>   #include <trace/events/sock.h>
>   
> @@ -476,6 +477,28 @@ static inline void nvme_tcp_ddgst_update(u32 *crcp,
>   	}
>   }
>   
> +static size_t nvme_tcp_ddgst_step(void *iter_base, size_t progress, size_t len,
> +				  void *priv, void *priv2)
> +{
> +	u32 *crcp = priv;
> +
> +	*crcp = crc32c(*crcp, iter_base, len);
> +	return 0;
> +}
> +
> +static int nvme_tcp_ddgst_calc(struct nvme_tcp_request *req, u32 *crcp,
> +			       size_t maxsize)
> +{
> +	struct iov_iter tmp = req->iter;
> +	int err = 0;
> +
> +	tmp.count = maxsize;
> +	if (iterate_and_advance_kernel(&tmp, maxsize, crcp, &err,
> +				       nvme_tcp_ddgst_step) != maxsize)
> +		return err;
> +	return 0;
> +}
> +
>   static inline __le32 nvme_tcp_ddgst_final(u32 crc)
>   {
>   	return cpu_to_le32(~crc);
> @@ -827,23 +850,26 @@ static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
>   		"Received C2HTermReq (FES = %s)\n", msg);
>   }
>   
> -static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> -		unsigned int *offset, size_t *len)
> +static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
>   {
> -	struct nvme_tcp_hdr *hdr;
>   	char *pdu = queue->pdu;
> -	size_t rcv_len = min_t(size_t, *len, queue->pdu_remaining);
> +	struct msghdr msg = {
> +		.msg_flags = MSG_DONTWAIT,
> +	};
> +	struct kvec iov = {
> +		.iov_base = pdu + queue->pdu_offset,
> +		.iov_len = queue->pdu_remaining,
> +	};
> +	struct nvme_tcp_hdr *hdr;
>   	int ret;
>   
> -	ret = skb_copy_bits(skb, *offset,
> -		&pdu[queue->pdu_offset], rcv_len);
> -	if (unlikely(ret))
> +	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
> +			     iov.iov_len, msg.msg_flags);
> +	if (ret <= 0)
>   		return ret;
>   
> -	queue->pdu_remaining -= rcv_len;
> -	queue->pdu_offset += rcv_len;
> -	*offset += rcv_len;
> -	*len -= rcv_len;
> +	queue->pdu_remaining -= ret;
> +	queue->pdu_offset += ret;
>   	if (queue->pdu_remaining)
>   		return 0;
>   
> @@ -907,20 +933,19 @@ static inline void nvme_tcp_end_request(struct request *rq, u16 status)
>   		nvme_complete_rq(rq);
>   }
>   
> -static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
> -			      unsigned int *offset, size_t *len)
> +static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
>   {
>   	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
>   	struct request *rq =
>   		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   
> -	while (true) {
> -		int recv_len, ret;
> +	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DATA)
> +		return 0;
>   
> -		recv_len = min_t(size_t, *len, queue->data_remaining);
> -		if (!recv_len)
> -			break;
> +	while (queue->data_remaining) {
> +		struct msghdr msg;
> +		int ret;
>   
>   		if (!iov_iter_count(&req->iter)) {
>   			req->curr_bio = req->curr_bio->bi_next;
> @@ -940,25 +965,22 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		}
>   
>   		/* we can read only from what is left in this bio */
> -		recv_len = min_t(size_t, recv_len,
> -				iov_iter_count(&req->iter));
> +		memset(&msg, 0, sizeof(msg));
> +		msg.msg_iter = req->iter;
> +		msg.msg_flags = MSG_DONTWAIT;
>   
> -		if (queue->data_digest)
> -			ret = skb_copy_and_crc32c_datagram_iter(skb, *offset,
> -				&req->iter, recv_len, &queue->rcv_crc);
> -		else
> -			ret = skb_copy_datagram_iter(skb, *offset,
> -					&req->iter, recv_len);
> -		if (ret) {
> +		ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
> +		if (ret < 0) {
>   			dev_err(queue->ctrl->ctrl.device,
> -				"queue %d failed to copy request %#x data",
> +				"queue %d failed to receive request %#x data",
>   				nvme_tcp_queue_id(queue), rq->tag);
>   			return ret;
>   		}
> -
> -		*len -= recv_len;
> -		*offset += recv_len;
> -		queue->data_remaining -= recv_len;
> +		if (queue->data_digest)
> +			nvme_tcp_ddgst_calc(req, &queue->rcv_crc, ret);
> +		queue->data_remaining -= ret;
> +		if (queue->data_remaining)
> +			nvme_tcp_advance_req(req, ret);
>   	}
>   
>   	if (!queue->data_remaining) {
> @@ -968,7 +990,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   		} else {
>   			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
>   				nvme_tcp_end_request(rq,
> -						le16_to_cpu(req->status));
> +						     le16_to_cpu(req->status));
>   				queue->nr_cqe++;
>   			}
>   			nvme_tcp_init_recv_ctx(queue);
> @@ -978,24 +1000,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
>   	return 0;
>   }
>   
> -static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
> -		struct sk_buff *skb, unsigned int *offset, size_t *len)
> +static int __nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue)
>   {
>   	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
> -	char *ddgst = (char *)&queue->recv_ddgst;
> -	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
> -	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
> -	int ret;
> -
> -	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
> -	if (unlikely(ret))
> -		return ret;
> -
> -	queue->ddgst_remaining -= recv_len;
> -	*offset += recv_len;
> -	*len -= recv_len;
> -	if (queue->ddgst_remaining)
> -		return 0;
>   
>   	if (queue->recv_ddgst != queue->exp_ddgst) {
>   		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
> @@ -1023,40 +1030,32 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
>   	return 0;
>   }
>   
> -static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
> -			     unsigned int offset, size_t len)
> +static int nvme_tcp_recvmsg_ddgst(struct nvme_tcp_queue *queue)
>   {
> -	struct nvme_tcp_queue *queue = desc->arg.data;
> -	size_t consumed = len;
> -	int result;
> +	char *ddgst = (char *)&queue->recv_ddgst;
> +	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
> +	struct msghdr msg = {
> +		.msg_flags = MSG_WAITALL,
> +	};

I don't think we want to use MSG_WAITALL ever. Why are you opting to do 
that?

> +	struct kvec iov = {
> +		.iov_base = (u8 *)ddgst + off,
> +		.iov_len = queue->ddgst_remaining,
> +	};
> +	int ret;
>   
> -	if (unlikely(!queue->rd_enabled))
> -		return -EFAULT;
> +	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DDGST)
> +		return 0;
>   
> -	while (len) {
> -		switch (nvme_tcp_recv_state(queue)) {
> -		case NVME_TCP_RECV_PDU:
> -			result = nvme_tcp_recv_pdu(queue, skb, &offset, &len);
> -			break;
> -		case NVME_TCP_RECV_DATA:
> -			result = nvme_tcp_recv_data(queue, skb, &offset, &len);
> -			break;
> -		case NVME_TCP_RECV_DDGST:
> -			result = nvme_tcp_recv_ddgst(queue, skb, &offset, &len);
> -			break;
> -		default:
> -			result = -EFAULT;
> -		}
> -		if (result) {
> -			dev_err(queue->ctrl->ctrl.device,
> -				"receive failed:  %d\n", result);
> -			queue->rd_enabled = false;
> -			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> -			return result;
> -		}
> -	}
> +	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1, iov.iov_len,
> +			     msg.msg_flags);
> +	if (ret <= 0)
> +		return ret;
>   
> -	return consumed;
> +	queue->ddgst_remaining -= ret;
> +	if (queue->ddgst_remaining)
> +		return 0;
> +
> +	return __nvme_tcp_recv_ddgst(queue);
>   }
>   
>   static void nvme_tcp_data_ready(struct sock *sk)
> @@ -1356,20 +1355,38 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
>   	return ret;
>   }
>   
> -static int nvme_tcp_try_recv(struct nvme_tcp_queue *queue)
> +static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
>   {
> -	struct socket *sock = queue->sock;
> -	struct sock *sk = sock->sk;
> -	read_descriptor_t rd_desc;
> -	int consumed;
> +	int result;
> +	int nr_cqe = queue->nr_cqe;
> +
> +	if (unlikely(!queue->rd_enabled))
> +		return -EFAULT;
> +
> +	do {
> +		switch (nvme_tcp_recv_state(queue)) {
> +		case NVME_TCP_RECV_PDU:
> +			result = nvme_tcp_recvmsg_pdu(queue);
> +			break;
> +		case NVME_TCP_RECV_DATA:
> +			result = nvme_tcp_recvmsg_data(queue);
> +			break;
> +		case NVME_TCP_RECV_DDGST:
> +			result = nvme_tcp_recvmsg_ddgst(queue);
> +			break;
> +		default:
> +			result = -EFAULT;
> +		}
> +	} while (result >= 0);
> +
> +	if (result < 0 && result != -EAGAIN) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"receive failed:  %d\n", result);
> +		queue->rd_enabled = false;
> +		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +	}
>   
> -	rd_desc.arg.data = queue;
> -	rd_desc.count = 1;
> -	lock_sock(sk);
> -	queue->nr_cqe = 0;
> -	consumed = sock->ops->read_sock(sk, &rd_desc, nvme_tcp_recv_skb);
> -	release_sock(sk);
> -	return consumed == -EAGAIN ? 0 : consumed;
> +	return result < 0 ? result : (queue->nr_cqe = nr_cqe);

This is changing the semantics of the retcode - can you please document 
in the commit msg
the change?

>   }
>   
>   static void nvme_tcp_io_work(struct work_struct *w)
> @@ -1391,7 +1408,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   				break;
>   		}
>   
> -		result = nvme_tcp_try_recv(queue);
> +		result = nvme_tcp_try_recvmsg(queue);
>   		if (result > 0)
>   			pending = true;
>   		else if (unlikely(result < 0))
> @@ -2800,7 +2817,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>   	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
>   	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
>   		sk_busy_loop(sk, true);
> -	ret = nvme_tcp_try_recv(queue);
> +	ret = nvme_tcp_try_recvmsg(queue);
>   	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
>   	return ret < 0 ? ret : queue->nr_cqe;
>   }


