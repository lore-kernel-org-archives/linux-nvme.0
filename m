Return-Path: <SRS0=tSwM=QE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F93C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 09:04:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941A561BAA
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 09:04:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 941A561BAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hhVc2y+QZBQ2GIulCkcsrwzsAZu1TwDqCc9PUxfmqAc=; b=FK+GMeWCcCm9PwOHIEl6f1jro3
	XSL70o4gImKHlG8HD4Xt4YyAt1QtnoUUgVje3We7YOKWSMY8EeTkh6VqW3Nko00HqUsKodvVoR4TH
	DsrR5qCwuzEImUlGmVP9pMFXY0GmMu9738oem4cUz+zJPMVk1KvlQAqe/BEknqoDvwaTUhg0x4B+l
	ZP3bV0hD+SSCbhkYn8ks/bx78Gn4CpWWAw6MRdEXXVOaJqXe7qSjX2OiEOH+Ppe3OYIrVf3soMf2/
	B86hHfP7ViXI17UA6naKQThzS0mM4a7azSgX/aGqZlLAQzUQSmLHiCG5TxqjZO71Ns/IC34nWgh3W
	/o3G3bcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnGrQ-0044qY-I0; Wed, 17 Nov 2021 09:04:08 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnGpJ-0043VD-0U
 for linux-nvme@lists.infradead.org; Wed, 17 Nov 2021 09:01:58 +0000
Received: by mail-wr1-f48.google.com with SMTP id d5so3230339wrc.1
 for <linux-nvme@lists.infradead.org>; Wed, 17 Nov 2021 01:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hhVc2y+QZBQ2GIulCkcsrwzsAZu1TwDqCc9PUxfmqAc=;
 b=oO0eWCida1KotQ0LVie4iwI3+yvivA/VvBPLhQIBQG0Mpu8qnCZ+6ONDjvZL7GmoxP
 L1ETf1neAtgJ/Vz8rd4vgmG6JHdG+19ouFUywJ8tlU4zjI8S2rLg1IvmKZm9cvR9uPeo
 chyT13YPVa0PslTiC2e6pXa2xxo8FpjpYB8rFXWYPyF/u1c/F84aJl1hxa81/5TPardc
 Kf+wMINWiPQgM+PFkfa3nO5awaaULDlVl5RPup848Tzc9XZ0qxMjch6EtigNGJKKZY8X
 WzumRIgz/Ar8fFXtQnEZFTH6PNmTB9YH5CiYFB0RPvNle9yH/JHZlIb0/YdLy9b7va2A
 K4TA==
X-Gm-Message-State: AOAM5339xHZ5nzwvytojn7z6H2wYQIWvWVZWQf5jjPBXWZ4LNT7fPEoe
 etPUCbdHacthnKoBM2iM3izWG9qGwdQ=
X-Google-Smtp-Source: ABdhPJzoQQDSCJROcCthRfq4Pkm78ZN5AXpy9UdQ91N1CbrUITClH3RxTPkhhWrFiI1j5NrmuwUQDg==
X-Received: by 2002:a5d:6e8c:: with SMTP id k12mr17868141wrz.401.1637139713973; 
 Wed, 17 Nov 2021 01:01:53 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id r17sm5841768wmq.5.2021.11.17.01.01.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Nov 2021 01:01:53 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
To: Varun Prakash <varun@chelsio.com>, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <1635337439-4311-1-git-send-email-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <57fe4578-d8be-8c05-4f52-ece4b3f4cabb@grimberg.me>
Date: Wed, 17 Nov 2021 11:01:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1635337439-4311-1-git-send-email-varun@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_010157_128196_4FC91A80 
X-CRM114-Status: GOOD (  34.82  )
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

Hi Varun,

Sorry for the delay, thanks for the patch, I have a few
comments.

On 10/27/21 3:23 PM, Varun Prakash wrote:
> As per NVMe/TCP specification (revision 1.0a, section 3.6.2.3)
> Maximum Host to Controller Data length (MAXH2CDATA): Specifies the
> maximum number of PDU-Data bytes per H2CData PDU in bytes. This value
> is a multiple of dwords and should be no less than 4,096.
> 
> Current code sets H2CData PDU data_length to r2t_length,
> it does not check MAXH2CDATA value. Fix this by setting H2CData PDU
> data_length to min(req->rem_r2t_len, queue->maxh2cdata).
> 
> Also validate MAXH2CDATA value returned by target in ICResp PDU,
> if it is not a multiple of dword or if it is less than 4096 return
> -EINVAL from nvme_tcp_init_connection().
> 
> Signed-off-by: Varun Prakash <varun@chelsio.com>
> ---
>   drivers/nvme/host/tcp.c  | 86 ++++++++++++++++++++++++++++++++++++++++--------
>   include/linux/nvme-tcp.h |  1 +
>   2 files changed, 74 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 22da856..d7a7d85 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -42,6 +42,7 @@ struct nvme_tcp_request {
>   	void			*pdu;
>   	struct nvme_tcp_queue	*queue;
>   	u32			data_len;
> +	u32			rem_r2t_len;

I suggest that given this is a decrementing value we should
call it h2cdata_left.

>   	u32			pdu_len;
>   	u32			pdu_sent;
>   	u16			ttag;
> @@ -95,6 +96,7 @@ struct nvme_tcp_queue {
>   	struct nvme_tcp_request *request;
>   
>   	int			queue_size;
> +	u32			maxh2cdata;
>   	size_t			cmnd_capsule_len;
>   	struct nvme_tcp_ctrl	*ctrl;
>   	unsigned long		flags;
> @@ -578,23 +580,21 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
>   	struct nvme_tcp_data_pdu *data = req->pdu;
>   	struct nvme_tcp_queue *queue = req->queue;
>   	struct request *rq = blk_mq_rq_from_pdu(req);
> +	u32 r2t_length = le32_to_cpu(pdu->r2t_length);
>   	u8 hdgst = nvme_tcp_hdgst_len(queue);
>   	u8 ddgst = nvme_tcp_ddgst_len(queue);
>   
> -	req->pdu_len = le32_to_cpu(pdu->r2t_length);
> -	req->pdu_sent = 0;
> -
> -	if (unlikely(!req->pdu_len)) {
> +	if (unlikely(!r2t_length)) {
>   		dev_err(queue->ctrl->ctrl.device,
>   			"req %d r2t len is %u, probably a bug...\n",
> -			rq->tag, req->pdu_len);
> +			rq->tag, r2t_length);
>   		return -EPROTO;
>   	}
>   
> -	if (unlikely(req->data_sent + req->pdu_len > req->data_len)) {
> +	if (unlikely(req->data_sent + r2t_length > req->data_len)) {
>   		dev_err(queue->ctrl->ctrl.device,
>   			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
> -			rq->tag, req->pdu_len, req->data_len,
> +			rq->tag, r2t_length, req->data_len,
>   			req->data_sent);
>   		return -EPROTO;
>   	}

I think we should move these checks to nvme_tcp_handle_r2t anyways, this
should only be setting the h2cdata pdu. This should probably be a prep
patch.

> @@ -607,9 +607,15 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
>   		return -EPROTO;
>   	}
>   
> +	req->rem_r2t_len = r2t_length;
> +	req->pdu_len = min(req->rem_r2t_len, queue->maxh2cdata);
> +	req->pdu_sent = 0;
> +	req->rem_r2t_len -= req->pdu_len;
> +
>   	memset(data, 0, sizeof(*data));
>   	data->hdr.type = nvme_tcp_h2c_data;
> -	data->hdr.flags = NVME_TCP_F_DATA_LAST;
> +	if (!req->rem_r2t_len)
> +		data->hdr.flags = NVME_TCP_F_DATA_LAST;
>   	if (queue->hdr_digest)
>   		data->hdr.flags |= NVME_TCP_F_HDGST;
>   	if (queue->data_digest)
> @@ -923,9 +929,34 @@ static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
>   	nvme_tcp_end_request(blk_mq_rq_from_pdu(req), NVME_SC_HOST_PATH_ERROR);
>   }
>   
> +static void nvme_tcp_update_h2c_data_pdu(struct nvme_tcp_request *req)
> +{
> +	struct nvme_tcp_queue *queue = req->queue;
> +	struct nvme_tcp_data_pdu *data = req->pdu;
> +	u8 hdgst = nvme_tcp_hdgst_len(queue);
> +	u8 ddgst = nvme_tcp_ddgst_len(queue);
> +	u32 pdu_sent = req->pdu_len;
> +
> +	req->pdu_len = min(req->rem_r2t_len, queue->maxh2cdata);
> +	req->pdu_sent = 0;
> +	req->rem_r2t_len -= req->pdu_len;
> +
> +	if (!req->rem_r2t_len)
> +		data->hdr.flags |= NVME_TCP_F_DATA_LAST;
> +	data->hdr.plen =
> +		cpu_to_le32(data->hdr.hlen + hdgst + req->pdu_len + ddgst);
> +	data->data_offset =
> +		cpu_to_le32(le32_to_cpu(data->data_offset) + pdu_sent);
> +	data->data_length = cpu_to_le32(req->pdu_len);
> +
> +	req->state = NVME_TCP_SEND_H2C_PDU;
> +	req->offset = 0;
> +}

Ideally we don't have two functions one for setup and one for update,
they should be the same.

This can probably be acheived when the r2t checks will move out of
this function, and we can record the r2t_legnth and r2t_offset in the
request and use that in nvme_tcp_setup_h2c_data_pdu.

> +
>   static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>   {
>   	struct nvme_tcp_queue *queue = req->queue;
> +	u32 rem_r2t_len = req->rem_r2t_len;
>   
>   	while (true) {
>   		struct page *page = nvme_tcp_req_cur_page(req);
> @@ -969,7 +1000,10 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>   				req->state = NVME_TCP_SEND_DDGST;
>   				req->offset = 0;
>   			} else {
> -				nvme_tcp_done_send_req(queue);
> +				if (rem_r2t_len)
> +					nvme_tcp_update_h2c_data_pdu(req);
> +				else
> +					nvme_tcp_done_send_req(queue);
>   			}
>   			return 1;
>   		}
> @@ -1022,14 +1056,26 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
>   	struct nvme_tcp_data_pdu *pdu = req->pdu;
>   	u8 hdgst = nvme_tcp_hdgst_len(queue);
>   	int len = sizeof(*pdu) - req->offset + hdgst;
> +	int flags = MSG_DONTWAIT | MSG_MORE;
>   	int ret;
>   
>   	if (queue->hdr_digest && !req->offset)
>   		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
>   
> -	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
> -			offset_in_page(pdu) + req->offset, len,
> -			MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
> +	if (req->rem_r2t_len) {
> +		struct msghdr msg = { .msg_flags = flags };
> +		struct kvec iov = {
> +			.iov_base = (u8 *)pdu + req->offset,
> +			.iov_len = len
> +		};
> +
> +		ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
> +	} else {
> +		ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
> +				      offset_in_page(pdu) + req->offset, len,
> +				      flags | MSG_SENDPAGE_NOTLAST);
> +	}

Why is this needed? Seems out-of-place to me...

