Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028F7C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 11:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b8FdAqNO7QVAOcyB6c49Xx2eAQd3BjC+J+fZ8wv8+FE=; b=wQKoi7H7tH/t7iHy3+sYyPYNZc
	h3AhHll9KWl3N8F386DGxBwiaRcnuz6W75AMvdlUsIJDyI1IwrLCay0PSmeKA3L1FMZuPuSL72qsP
	12L63NQ034SPSPKwoxER0b3n7CBLvBtbFKK/djpov0UURDCsOzCLZdM5IXsIeKimau5/lDlnKqijB
	CaIcRyvkyjs5S7WyQ8tb+Q8Uyw457xcFVR4chniXA+b+Q5U3piiTzhbwUte1esP69tMgZ3TrUSIhW
	/rxpbH7KEmrCrcHFEHnaQIla9PYz4OXTqPSVdztPI3kL5iNl35KUaqZqQcXXqXuwi/6jKajnkBNbw
	gxooDFlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp7fi-00G6MO-58; Mon, 22 Nov 2021 11:39:42 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp6aT-00Fqjv-3s
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 10:30:15 +0000
Received: by mail-wr1-f43.google.com with SMTP id d27so31779675wrb.6
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 02:30:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b8FdAqNO7QVAOcyB6c49Xx2eAQd3BjC+J+fZ8wv8+FE=;
 b=xKB74vQK7rkPVk1/043KNtzpkDBre5i+T0hU02uaWOyMe6EKX0/wTNhUxkcxygquvt
 1vbdq+96SbDewtuQfgApiuz4vUCgUIO4339/fst3OMr15jdWLe0e+//b03CtkcQ0dsNG
 BU1j8f0ANRvtkZhkKT2LNwP6r3OPCGJ8hqYygkTaIrJKobIaAGbqFVGmcgZmddFDGP5q
 tMUOGuZQPcSH/5QMGFEEmXpg/K4v1gZjXq0FkifQwq7jqPlZW52qoDWOZUWvhaDQ92q3
 bIzqxQYpBtfGQPloYkcPOhTLsX/IKOs4p3KTd2q9yB5WGTXZM95HRe9FLZGfbxhIgaXy
 LPYQ==
X-Gm-Message-State: AOAM531KHFsUXCkt00qZbDS8EHI+THNSpMe6vvqlpYwkgmRgXeJQt2Rx
 6iVo1ue8Cyx+wqblQOSk3zqdStAiIgg=
X-Google-Smtp-Source: ABdhPJzTFO0m2d8QO1VSeGRaHtdopnk7jEy8GETa/whZ4HOoPATL6EvZxr7FT7+U7zj+kcFU0YV3Bg==
X-Received: by 2002:a05:6000:1a85:: with SMTP id
 f5mr35669121wry.361.1637577007452; 
 Mon, 22 Nov 2021 02:30:07 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id e12sm10129380wrq.20.2021.11.22.02.30.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 02:30:07 -0800 (PST)
Subject: Re: [PATCH 1/2] nvme-tcp: validate R2T PDU in nvme_tcp_handle_r2t()
To: Varun Prakash <varun@chelsio.com>, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <1637575953-3143-1-git-send-email-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f0086acd-c400-97e5-fe2f-5a1dd6744130@grimberg.me>
Date: Mon, 22 Nov 2021 12:30:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637575953-3143-1-git-send-email-varun@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_023013_226323_02A965EB 
X-CRM114-Status: GOOD (  24.06  )
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


> If maxh2cdata < r2t_length then driver will form multiple
> H2CData PDUs, validate R2T PDU in nvme_tcp_handle_r2t() to
> reuse nvme_tcp_setup_h2c_data_pdu().

This patch does more than it is documenting.

> 
> Signed-off-by: Varun Prakash <varun@chelsio.com>
> ---
>   drivers/nvme/host/tcp.c | 79 +++++++++++++++++++++++++++----------------------
>   1 file changed, 44 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 33bc83d..92e07d2 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -44,7 +44,9 @@ struct nvme_tcp_request {
>   	u32			data_len;
>   	u32			pdu_len;
>   	u32			pdu_sent;
> -	u16			ttag;
> +	u32			h2cdata_left;
> +	u32			h2cdata_offset;
> +	u16			h2cdata_ttag;

All of these are unused in this patch - they need to move
to the next patch.

Let's limit this patch to just moving the checks to
nvme_tcp_handle_r2t().

>   	__le16			status;
>   	struct list_head	entry;
>   	struct llist_node	lentry;
> @@ -572,8 +574,7 @@ static int nvme_tcp_handle_comp(struct nvme_tcp_queue *queue,
>   	return ret;
>   }
>   
> -static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
> -		struct nvme_tcp_r2t_pdu *pdu)
> +static void nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req)
>   {
>   	struct nvme_tcp_data_pdu *data = req->pdu;
>   	struct nvme_tcp_queue *queue = req->queue;
> @@ -581,35 +582,11 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
>   	u8 hdgst = nvme_tcp_hdgst_len(queue);
>   	u8 ddgst = nvme_tcp_ddgst_len(queue);
>   
> -	req->pdu_len = le32_to_cpu(pdu->r2t_length);
> +	req->pdu_len = req->h2cdata_left;
>   	req->pdu_sent = 0;
>   
> -	if (unlikely(!req->pdu_len)) {
> -		dev_err(queue->ctrl->ctrl.device,
> -			"req %d r2t len is %u, probably a bug...\n",
> -			rq->tag, req->pdu_len);
> -		return -EPROTO;
> -	}
> -
> -	if (unlikely(req->data_sent + req->pdu_len > req->data_len)) {
> -		dev_err(queue->ctrl->ctrl.device,
> -			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
> -			rq->tag, req->pdu_len, req->data_len,
> -			req->data_sent);
> -		return -EPROTO;
> -	}
> -
> -	if (unlikely(le32_to_cpu(pdu->r2t_offset) < req->data_sent)) {
> -		dev_err(queue->ctrl->ctrl.device,
> -			"req %d unexpected r2t offset %u (expected %zu)\n",
> -			rq->tag, le32_to_cpu(pdu->r2t_offset),
> -			req->data_sent);
> -		return -EPROTO;
> -	}
> -
>   	memset(data, 0, sizeof(*data));
>   	data->hdr.type = nvme_tcp_h2c_data;
> -	data->hdr.flags = NVME_TCP_F_DATA_LAST;
>   	if (queue->hdr_digest)
>   		data->hdr.flags |= NVME_TCP_F_HDGST;
>   	if (queue->data_digest)
> @@ -618,11 +595,16 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
>   	data->hdr.pdo = data->hdr.hlen + hdgst;
>   	data->hdr.plen =
>   		cpu_to_le32(data->hdr.hlen + hdgst + req->pdu_len + ddgst);
> -	data->ttag = pdu->ttag;
> +	data->ttag = req->h2cdata_ttag;
>   	data->command_id = nvme_cid(rq);
> -	data->data_offset = pdu->r2t_offset;
> +	data->data_offset = cpu_to_le32(req->h2cdata_offset);
>   	data->data_length = cpu_to_le32(req->pdu_len);
> -	return 0;
> +
> +	req->h2cdata_left -= req->pdu_len;
> +	req->h2cdata_offset += req->pdu_len;
> +
> +	if (!req->h2cdata_left)
> +		data->hdr.flags |= NVME_TCP_F_DATA_LAST;
>   }
>   
>   static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
> @@ -630,7 +612,8 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
>   {
>   	struct nvme_tcp_request *req;
>   	struct request *rq;
> -	int ret;
> +	u32 r2t_length = le32_to_cpu(pdu->r2t_length);
> +	u32 r2t_offset = le32_to_cpu(pdu->r2t_offset);
>   
>   	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	if (!rq) {
> @@ -641,10 +624,33 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
>   	}
>   	req = blk_mq_rq_to_pdu(rq);
>   
> -	ret = nvme_tcp_setup_h2c_data_pdu(req, pdu);
> -	if (unlikely(ret))
> -		return ret;
> +	if (unlikely(!r2t_length)) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"req %d r2t len is %u, probably a bug...\n",
> +			rq->tag, r2t_length);
> +		return -EPROTO;
> +	}
> +
> +	if (unlikely(req->data_sent + r2t_length > req->data_len)) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
> +			rq->tag, r2t_length, req->data_len,
> +			req->data_sent);
> +		return -EPROTO;
> +	}
> +
> +	if (unlikely(r2t_offset < req->data_sent)) {
> +		dev_err(queue->ctrl->ctrl.device,
> +			"req %d unexpected r2t offset %u (expected %zu)\n",
> +			rq->tag, r2t_offset, req->data_sent);
> +		return -EPROTO;
> +	}
> +
> +	req->h2cdata_left = r2t_length;
> +	req->h2cdata_offset = r2t_offset;
> +	req->h2cdata_ttag = pdu->ttag;
>   
> +	nvme_tcp_setup_h2c_data_pdu(req);
>   	req->state = NVME_TCP_SEND_H2C_PDU;
>   	req->offset = 0;

In order to make stuff easier, let's move this setting to 
nvme_tcp_setup_h2c_data_pdu(), it is also consistent with
nvme_tcp_setup_cmd_pdu() that is setting req->state and req->offset...

