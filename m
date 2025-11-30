Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252F4CFD376
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 22:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xcQPpGxPe5sL+9Hgs4hRWML4oh/qUbrpFwVuPEgD/H8=; b=2yBro29uck9egLvmblJx9bmPz4
	yXnxq+lrqPH61HJdpCKBYN0JgzEejLmmjZB4fL/8HVHNqf6pJTt5nio/XhviCkLwzu9EYgbdcEvzg
	JTmZX48zPV5VroN6gRHzvrZUeLbkMBoMATsl7Kyl3Kr79es5f0bjFAajXzwC7+9q9jdHav0pIbCKW
	pSHg4IpV5Vm1HmahqEhlMGhvy9WDWfv2RRJOMZIHjTraOoJzRqM9mn394NywLY+zPelsehmL9taCa
	rCfMLv/Vs9SsVm3h34zTcNkqEMqNvxKe3b2ZHvD+twRL5r+Z7CbEifIUmwZQXJf7uqfa3qn9UqdJC
	qsnCcQxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpxI-00000002d6t-1MDQ;
	Sun, 30 Nov 2025 22:31:44 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpxG-00000002d6T-2l67
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 22:31:43 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477a219db05so21105185e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 14:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764541901; x=1765146701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcQPpGxPe5sL+9Hgs4hRWML4oh/qUbrpFwVuPEgD/H8=;
        b=IHI5KDIFFTbY9TqlWf/xApuS2FLfDb0p6jx3ttWL1cAsrC7R9z/byBQpEC+K5t/y0b
         vnEdiYCFA9QT+fvMeCAuHkyQGHJoDNLTd20kS3r7a8slI5NUGotRl7UsuQodMuWodpCo
         vWFxwEVfHNKb97rSkSeMdLbX6cFzn0baRRluEaiDHvQfvuYdq/QZvR347QTJgEkNJPQr
         IZiSGen4RU7eqwGzSmuMkXkzP2+oXAMWCUmNj5e6avZ/lGWcuw/hKeZwO7RCn9+OTVWg
         zfgxSZJSIctwLhJRVAJJjD9D8xe34vl2TP9XVIbdYUXE9+jqDMLSpzjHHTSfsF7qQWKj
         DRnw==
X-Forwarded-Encrypted: i=1; AJvYcCXEI3utXymDJ1fAyi/JOkX0DUTTiZoSDHd9GVuz5X5OH84WuXDbs5XwombGQZGl6CXI+IM0ev30YHPw@lists.infradead.org
X-Gm-Message-State: AOJu0YxGNir2Qrddvd4qtVkYZfMQG6cO2iD5STt9in8fJEo+U/oEiNmL
	L65rl83GsjmIRDgiSt0SCRdKp8SO8ibmbNHGBdca4WMJJcO8YMMLEiFK
X-Gm-Gg: ASbGncueEnoz4/PT8F57UPADcyhpvzpHbJ3qyHldAiOeLcPeP/ft6Yp3CSgdUhqrY8B
	5oqMJD2jaqYV9FKK9RJMPX24cHDKAk1IaUvVdbWr43BakR2+Yxi7rV3KnYJHEL8WnW8O8yI36/M
	5wpZQ8voVWbv43JAqbagJ73+qoHGTFQxJV4JKHNd+sNUEzlOL3H8NOWoFP1Wx7sgZ3f1ihnGAIg
	24OqV2chuuerHLLWVLC5o5VJ5gwtqrRv15aUQ9Whn9OOPFmt7YNUrIj05dEL8GN8K3WqEsjpQ5u
	+AbPe2Vh+S1eJYPyuakgH617l3oFyz5msQqIZ8Q+OFLmLPtUbEbdqYtJ0LOVQ/wFahDmKcfFNkY
	AsGtEDdMGoPLD1RivWgdjkjqvFcYGnSxkJY6D/3g3YY4d43pHXaLXy7iWDYqdf3fG1cViVBM8ur
	YubcOcdarxq6s49UIPybjdxTDiNKkBXS/Pr0jxTYA5
X-Google-Smtp-Source: AGHT+IE06nECDAq+Uk5QtE1+56tfrJDdijXtZ3fW9Zv+27AAc3S+rK/IWGF+IFYLl0pdMZ3C0cSJQA==
X-Received: by 2002:a05:600c:1f0f:b0:477:8b2e:aa7d with SMTP id 5b1f17b1804b1-477c1132bf2mr354572535e9.30.1764541900754;
        Sun, 30 Nov 2025 14:31:40 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4791163e36csm198706755e9.9.2025.11.30.14.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 14:31:40 -0800 (PST)
Message-ID: <1184961b-5488-4150-b647-29ed363e2276@grimberg.me>
Date: Mon, 1 Dec 2025 00:31:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] nvme-tcp: Support KeyUpdate
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
 kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, kch@nvidia.com,
 hare@suse.de, Alistair Francis <alistair.francis@wdc.com>
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-6-alistair.francis@wdc.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251112042720.3695972-6-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_143142_732088_F3CFC392 
X-CRM114-Status: GOOD (  34.12  )
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



On 12/11/2025 6:27, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>
> If the nvme_tcp_try_send() or nvme_tcp_try_recv() functions return
> EKEYEXPIRED then the underlying TLS keys need to be updated. This occurs
> on an KeyUpdate event as described in RFC8446
> https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3.
>
> If the NVMe Target (TLS server) initiates a KeyUpdate this patch will
> allow the NVMe layer to process the KeyUpdate request and forward the
> request to userspace. Userspace must then update the key to keep the
> connection alive.
>
> This patch allows us to handle the NVMe target sending a KeyUpdate
> request without aborting the connection. At this time we don't support
> initiating a KeyUpdate.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---

I see this is on top of Hannes recvmsg patch. Worth noting in the patch 
here at least.

> v5:
>   - Cleanup code flow
>   - Check for MSG_CTRUNC in the msg_flags return from recvmsg
>     and use that to determine if it's a control message
> v4:
>   - Remove all support for initiating KeyUpdate
>   - Don't call cancel_work() when updating keys
> v3:
>   - Don't cancel existing handshake requests
> v2:
>   - Don't change the state
>   - Use a helper function for KeyUpdates
>   - Continue sending in nvme_tcp_send_all() after a KeyUpdate
>   - Remove command message using recvmsg
>
>   drivers/nvme/host/tcp.c | 85 +++++++++++++++++++++++++++++++++--------
>   1 file changed, 70 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 4797a4532b0d..5cec5a974bbf 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -172,6 +172,7 @@ struct nvme_tcp_queue {
>   	bool			tls_enabled;
>   	u32			rcv_crc;
>   	u32			snd_crc;
> +	key_serial_t		handshake_session_id;
>   	__le32			exp_ddgst;
>   	__le32			recv_ddgst;
>   	struct completion       tls_complete;
> @@ -858,7 +859,10 @@ static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
>   static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
>   {
>   	char *pdu = queue->pdu;
> +	char cbuf[CMSG_LEN(sizeof(char))] = {};
>   	struct msghdr msg = {
> +		.msg_control = cbuf,
> +		.msg_controllen = sizeof(cbuf),
>   		.msg_flags = MSG_DONTWAIT,
>   	};
>   	struct kvec iov = {
> @@ -873,12 +877,17 @@ static int nvme_tcp_recvmsg_pdu(struct nvme_tcp_queue *queue)
>   	if (ret <= 0)
>   		return ret;
>   
> +	hdr = queue->pdu;
> +	if (hdr->type == TLS_HANDSHAKE_KEYUPDATE) {
> +		dev_err(queue->ctrl->ctrl.device, "KeyUpdate message\n");
> +		return 1;
> +	}
> +
>   	queue->pdu_remaining -= ret;
>   	queue->pdu_offset += ret;
>   	if (queue->pdu_remaining)
>   		return 0;
>   
> -	hdr = queue->pdu;
>   	if (unlikely(hdr->hlen != sizeof(struct nvme_tcp_rsp_pdu))) {
>   		if (!nvme_tcp_recv_pdu_supported(hdr->type))
>   			goto unsupported_pdu;
> @@ -944,6 +953,7 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
>   	struct request *rq =
>   		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
> +	char cbuf[CMSG_LEN(sizeof(char))] = {};
>   
>   	if (nvme_tcp_recv_state(queue) != NVME_TCP_RECV_DATA)
>   		return 0;
> @@ -976,10 +986,26 @@ static int nvme_tcp_recvmsg_data(struct nvme_tcp_queue *queue)
>   
>   		ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
>   		if (ret < 0) {
> -			dev_err(queue->ctrl->ctrl.device,
> -				"queue %d failed to receive request %#x data",
> -				nvme_tcp_queue_id(queue), rq->tag);
> -			return ret;
> +			/* If MSG_CTRUNC is set, it's a control message,
> +			 * so let's read the control message.
> +			 */
> +			if (msg.msg_flags & MSG_CTRUNC) {
> +				memset(&msg, 0, sizeof(msg));
> +				msg.msg_flags = MSG_DONTWAIT;
> +				msg.msg_control = cbuf;
> +				msg.msg_controllen = sizeof(cbuf);
> +
> +				ret = sock_recvmsg(queue->sock, &msg, msg.msg_flags);
> +			}
> +
> +			if (ret < 0) {
> +				dev_dbg(queue->ctrl->ctrl.device,
> +					"queue %d failed to receive request %#x data, %d",
> +					nvme_tcp_queue_id(queue), rq->tag, ret);
> +				return ret;
> +			}
> +
> +			return 0;
>   		}
>   		if (queue->data_digest)
>   			nvme_tcp_ddgst_calc(req, &queue->rcv_crc, ret);
> @@ -1384,15 +1410,39 @@ static int nvme_tcp_try_recvmsg(struct nvme_tcp_queue *queue)
>   		}
>   	} while (result >= 0);
>   
> -	if (result < 0 && result != -EAGAIN) {
> -		dev_err(queue->ctrl->ctrl.device,
> -			"receive failed:  %d\n", result);
> -		queue->rd_enabled = false;
> -		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> -	} else if (result == -EAGAIN)
> -		result = 0;
> +	if (result < 0) {
> +		if (result != -EKEYEXPIRED && result != -EAGAIN) {
> +			dev_err(queue->ctrl->ctrl.device,
> +				"receive failed:  %d\n", result);
> +			queue->rd_enabled = false;
> +			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
> +		}
> +		return result;
> +	}
> +
> +	queue->nr_cqe = nr_cqe;
> +	return nr_cqe;
> +}
> +
> +static void update_tls_keys(struct nvme_tcp_queue *queue)
> +{
> +	int qid = nvme_tcp_queue_id(queue);
> +	int ret;
> +
> +	dev_dbg(queue->ctrl->ctrl.device,
> +		"updating key for queue %d\n", qid);
>   
> -	return result < 0 ? result : (queue->nr_cqe = nr_cqe);
> +	flush_work(&(queue->ctrl->ctrl).async_event_work);
> +
> +	ret = nvme_tcp_start_tls(&(queue->ctrl->ctrl),
> +				 queue, queue->ctrl->ctrl.tls_pskid,
> +				 HANDSHAKE_KEY_UPDATE_TYPE_RECEIVED);

No need to quiesce the queue or anything like that? everything continues 
as usual?
Why are you flushing async_event_work?

