Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C341C6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 11:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bhADh05tE8V09pdMJVFbERuYWGTOhtvfa2xFcWhkvk8=; b=DlUwYfQnypmAEk0l1T0pEAwq0L
	oUnjb78CDxOMfEf9fCPlAIjDTTBcxGW3XlD3F16xUNi8yiT9t6Po60Nnknba3tAOMcLLX9eU1Vc6o
	Y/vlg5xP73Ip+rhEFxzHOh1ro/PUTsv+87xTY+P2df+Nh3Mrtjiwx0o/1d7UGtcsQKDcMHF0iFXpc
	FPUaYVmJT6tlPnx/DXGzyfwTdpJUCqvHUOyFYbj5Mdm2WTtXqtTfxdejjHCLw3RTsGwwO41UqujR1
	eJOjAelVQ+ZrQwSeZ/IyrUP9zJ5bEXu+D6RStXilVO4kBt1RPnD0pVvDBfHawcWzxp2oVeumPGrkx
	y9JznHCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pewiR-00Fmts-0b;
	Wed, 22 Mar 2023 11:33:15 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pewiN-00FmsK-1k
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 11:33:13 +0000
Received: by mail-wm1-f41.google.com with SMTP id p34so6273812wms.3
        for <linux-nvme@lists.infradead.org>; Wed, 22 Mar 2023 04:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679484788; x=1682076788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhADh05tE8V09pdMJVFbERuYWGTOhtvfa2xFcWhkvk8=;
        b=rDUOjq9nmExNw31WHrOhR5FSsff/hCXr7Uk/Kf+zzVAjbPqyMaOocSx+ePGwULMXjR
         yVr/6gWbGd0WHP1MzXW5Zp8qFvr/0F3ypAhuRjM7mFq73Lc5S0f8z4Dc/W8En/wXNt+r
         sw/Wseak9rSt02jsZ5GikNPztbRowghTrjykGcJNUrwlm2PoSAcSlrwj4lYI+X8mcHy5
         z2MBF8qxj2sfMO4EUqJDScCQgYuX2L+23u8sa0C/Nc3zqqx5MoYSbJhUSAXpCoGhrOTG
         w89+gDqz5GelXarntqkmtrHohoOWzrjJ0zcG1x6+4vicE4mWkEPlGZRuc8lFZ5K+qCT4
         d/Sw==
X-Gm-Message-State: AO0yUKUbM+bzmhDqzj8AEkfe6LM9jh47saaYM1e3lgOwDdus6JjYKgX8
	gWCwIkNTmLoHWy+F7cDYkjY=
X-Google-Smtp-Source: AK7set9khoviidrqaAgFWWljv4M7OtRDy9zpYyOOYZEnFeeGGfkThwXJMF8Nk8MyYsdEBZWsvxwEEw==
X-Received: by 2002:a05:600c:4f47:b0:3e2:17c2:fc8 with SMTP id m7-20020a05600c4f4700b003e217c20fc8mr5622393wmq.2.1679484787713;
        Wed, 22 Mar 2023 04:33:07 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b003ee610d1ce9sm1568384wmq.34.2023.03.22.04.33.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 04:33:07 -0700 (PDT)
Message-ID: <0be88516-8e29-a1a5-f0ff-204830c0fba5@grimberg.me>
Date: Wed, 22 Mar 2023 13:33:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 11/18] nvme-tcp: control message handling for recvmsg()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 "boris.pismenny@gmail.com" <boris.pismenny@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-12-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321124325.77385-12-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_043311_850522_1CD0F09C 
X-CRM114-Status: GOOD (  23.72  )
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


> kTLS is sending TLS ALERT messages as control messages for recvmsg().
> As we can't do anything sensible with it just abort the connection
> and let the userspace agent to a re-negotiation.

Is this a problem if we do end up adding read_sock to tls?
Although I do see that the tls code does manage this in the
sk_buff control buffer, so I assume there is access to this info.

CC'ing Boris here as well.

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 68 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 007d457cacf9..e0fc98ac9e05 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -13,6 +13,7 @@
>   #include <linux/nvme-keyring.h>
>   #include <net/sock.h>
>   #include <net/tcp.h>
> +#include <net/tls.h>
>   #include <net/handshake.h>
>   #include <linux/blk-mq.h>
>   #include <crypto/hash.h>
> @@ -727,7 +728,12 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, bool pending)
>   {
>   	struct nvme_tcp_hdr *hdr;
>   	size_t rcv_len = queue->pdu_remaining;
> +	char cbuf[CMSG_LEN(sizeof(char))] = {};
> +	struct cmsghdr *cmsg;
> +	unsigned char ctype;
>   	struct msghdr msg = {
> +		.msg_control = cbuf,
> +		.msg_controllen = sizeof(cbuf),
>   		.msg_flags = pending ? 0 : MSG_DONTWAIT,
>   	};
>   	struct kvec iov = {
> @@ -743,6 +749,18 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, bool pending)
>   			     iov.iov_len, msg.msg_flags);
>   	if (ret <= 0)
>   		return ret;
> +	cmsg = (struct cmsghdr *)cbuf;
> +	if (CMSG_OK(&msg, cmsg) &&
> +	    cmsg->cmsg_level == SOL_TLS &&
> +	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
> +		ctype = *((unsigned char *)CMSG_DATA(cmsg));
> +		if (ctype != TLS_RECORD_TYPE_DATA) {
> +			dev_err(queue->ctrl->ctrl.device,
> +				"queue %d unhandled TLS record %d\n",
> +				nvme_tcp_queue_id(queue), ctype);
> +			return -ENOTCONN;
> +		}
> +	}
>   
>   	rcv_len = ret;
>   	queue->pdu_remaining -= rcv_len;
> @@ -793,6 +811,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue)
>   	struct request *rq =
>   		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	char cbuf[CMSG_LEN(sizeof(char))];
> +	struct cmsghdr *cmsg;
> +	unsigned char ctype;
>   
>   	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DATA)
>   		return 0;
> @@ -824,6 +845,8 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue)
>   		/* we can read only from what is left in this bio */
>   		memset(&msg, 0, sizeof(msg));
>   		msg.msg_iter = req->iter;
> +		msg.msg_control = cbuf;
> +		msg.msg_controllen = sizeof(cbuf);
>   
>   		ret = sock_recvmsg(queue->sock, &msg, 0);
>   		if (ret <= 0) {
> @@ -832,6 +855,18 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue)
>   				nvme_tcp_queue_id(queue), rq->tag);
>   			return ret;
>   		}
> +		cmsg = (struct cmsghdr *)cbuf;
> +		if (CMSG_OK(&msg, cmsg) &&
> +		    cmsg->cmsg_level == SOL_TLS &&
> +		    cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
> +			ctype = *((unsigned char *)CMSG_DATA(cmsg));
> +			if (ctype != TLS_RECORD_TYPE_DATA) {
> +				dev_err(queue->ctrl->ctrl.device,
> +					"queue %d unhandled TLS record %d\n",
> +					nvme_tcp_queue_id(queue), ctype);
> +				return -ENOTCONN;
> +			}
> +		}
>   
>   		queue->data_remaining -= ret;
>   		if (queue->data_remaining)
> @@ -861,7 +896,12 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue)
>   	char *ddgst = (char *)&queue->recv_ddgst;
>   	size_t recv_len = queue->ddgst_remaining;
>   	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
> +	char cbuf[CMSG_LEN(sizeof(char))] = {};
> +	struct cmsghdr *cmsg;
> +	unsigned char ctype;
>   	struct msghdr msg = {
> +		.msg_control = cbuf,
> +		.msg_controllen = sizeof(cbuf),
>   		.msg_flags = 0,
>   	};
>   	struct kvec iov = {
> @@ -877,6 +917,18 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue)
>   			     msg.msg_flags);
>   	if (ret <= 0)
>   		return ret;
> +	cmsg = (struct cmsghdr *)cbuf;
> +	if (CMSG_OK(&msg, cmsg) &&
> +	    cmsg->cmsg_level == SOL_TLS &&
> +	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
> +		ctype = *((unsigned char *)CMSG_DATA(cmsg));
> +		if (ctype != TLS_RECORD_TYPE_DATA) {
> +			dev_err(queue->ctrl->ctrl.device,
> +				"queue %d unhandled TLS record %d\n",
> +				nvme_tcp_queue_id(queue), ctype);
> +			return -ENOTCONN;
> +		}
> +	}
>   
>   	recv_len = ret;
>   	queue->ddgst_remaining -= recv_len;
> @@ -1372,6 +1424,9 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>   {
>   	struct nvme_tcp_icreq_pdu *icreq;
>   	struct nvme_tcp_icresp_pdu *icresp;
> +	char cbuf[CMSG_LEN(sizeof(char))] = {};
> +	struct cmsghdr *cmsg;
> +	unsigned char ctype;
>   	struct msghdr msg = {};
>   	struct kvec iov;
>   	bool ctrl_hdgst, ctrl_ddgst;
> @@ -1409,10 +1464,23 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>   	memset(&msg, 0, sizeof(msg));
>   	iov.iov_base = icresp;
>   	iov.iov_len = sizeof(*icresp);
> +	msg.msg_control = cbuf;
> +	msg.msg_controllen = sizeof(cbuf);
>   	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
>   			iov.iov_len, msg.msg_flags);
>   	if (ret < 0)
>   		goto free_icresp;
> +	cmsg = (struct cmsghdr *)cbuf;
> +	if (CMSG_OK(&msg, cmsg) &&
> +	    cmsg->cmsg_level == SOL_TLS &&
> +	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE) {
> +		ctype = *((unsigned char *)CMSG_DATA(cmsg));
> +		if (ctype != TLS_RECORD_TYPE_DATA) {
> +			pr_err("queue %d: unhandled TLS record %d\n",
> +			       nvme_tcp_queue_id(queue), ctype);
> +			return -ENOTCONN;
> +		}
> +	}
>   
>   	ret = -EINVAL;
>   	if (icresp->hdr.type != nvme_tcp_icresp) {

