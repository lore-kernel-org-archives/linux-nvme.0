Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A287C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aMPne/C4LiNjjWBACzIby+HOl2X4RAw3WeaDlK0TJDM=; b=jXvufG9qtihOVvwKd8J9lR2AT7
	8gcwh40cQmuLJbaF89Bz37rCDRFNVXO9SBITwLHfYQeZ6jgEk0hfYFDBhPZwG+F+Ji/BjeILu1Vss
	UwIFhxtCqOqYLRs/nLTQe7aDcP2P1xZpnxLZWoy5XY+CCzW93L59b5h0ySLhZONRhN9iSw8AMcs85
	TSHwsFdlwmBe8v76X8I1JDKzEqKivIL9gLfYTUhtq7icZG3DwkK2NTocEiqWwm66dJWDvAlOhLy+W
	ZPJsPaZa8dvZw5xR6wtPdjpl13DwNEr/e+wOk6MP5yXmASXVRTY+afNjEU78c5cxWXB+Lp1YirOPg
	uDBTGouw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpVg8-002KNj-HI; Tue, 23 Nov 2021 13:17:44 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpVNC-002EPp-57
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 12:58:12 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 n33-20020a05600c502100b0032fb900951eso2149777wmr.4
 for <linux-nvme@lists.infradead.org>; Tue, 23 Nov 2021 04:58:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aMPne/C4LiNjjWBACzIby+HOl2X4RAw3WeaDlK0TJDM=;
 b=weaEBjyAxt2dUZoh3LCUZSVy8iFqXNshfZx4HQ2Od1xzIsYxwsBtVw2cq4hfhez3nE
 CG51KyNpP/wDv4gqUpLSDcU8BoWgBA6liDoHu+Q8kZWXOuz+TtG5PdG46xpKRfZJ2Dr1
 AsY0PYzawowR2Om9AgKSHJgH2p5ukyXcCtegbg6Me0WTiCI/xY1USmMUgSHrVE/TO/9p
 MuFqAeozOhW3VJ5AA1lhSTyvXyaksitQ3gXdI9gMl0DXjJ0BecnWaHQqNeRFWWomelJD
 +mxqQc3C2+5epl2L78YfgDEtXRtctSej2Ez4jF7edevIezRm9H1ymL4nQQXGQx3Uqscl
 Sscw==
X-Gm-Message-State: AOAM5338cFx56hjKIenGDtuIrg0e+pvHaNbdeHvSCRA+5Pxc6ZNrB5ip
 R1kwh2wBPEb3UoUpH+ivQKaqjI6E6Ac=
X-Google-Smtp-Source: ABdhPJxwx1LXJ3zGNgIpz8QpCqmZuFptEZAH0UL2mfiKtbqW96UBJqA5bO5ZfWBwGMbx5oKscQ8AjQ==
X-Received: by 2002:a7b:c2a1:: with SMTP id c1mr2832281wmk.112.1637672287625; 
 Tue, 23 Nov 2021 04:58:07 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id o12sm16890172wrc.85.2021.11.23.04.58.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Nov 2021 04:58:07 -0800 (PST)
Subject: Re: [PATCH v3 2/2] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
To: Varun Prakash <varun@chelsio.com>, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <1637665162-3609-1-git-send-email-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3b3a65a7-0885-0dc9-e78f-ac8a8c04a646@grimberg.me>
Date: Tue, 23 Nov 2021 14:58:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637665162-3609-1-git-send-email-varun@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_045810_311095_E8AD2F1C 
X-CRM114-Status: GOOD (  29.65  )
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



On 11/23/21 12:59 PM, Varun Prakash wrote:
> As per NVMe/TCP specification (revision 1.0a, section 3.6.2.3)
> Maximum Host to Controller Data length (MAXH2CDATA): Specifies the
> maximum number of PDU-Data bytes per H2CData PDU in bytes. This value
> is a multiple of dwords and should be no less than 4,096.
> 
> Current code sets H2CData PDU data_length to r2t_length,
> it does not check MAXH2CDATA value. Fix this by setting H2CData PDU
> data_length to min(req->h2cdata_left, queue->maxh2cdata).
> 
> Also validate MAXH2CDATA value returned by target in ICResp PDU,
> if it is not a multiple of dword or if it is less than 4096 return
> -EINVAL from nvme_tcp_init_connection().
> 
> Signed-off-by: Varun Prakash <varun@chelsio.com>
> ---
> 
> v3:
> - added h2cdata_left, h2cdata_offset
> - removed unnecessary local variables from nvme_tcp_try_send_data_pdu()
> 
> v2:
> - removed nvme_tcp_update_h2c_data_pdu()
> - used sock_no_sendpage() instead of kernel_sendmsg()
> 
>   drivers/nvme/host/tcp.c  | 63 +++++++++++++++++++++++++++++++++++++-----------
>   include/linux/nvme-tcp.h |  1 +
>   2 files changed, 50 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 5f8ad4d..0065892 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -44,6 +44,8 @@ struct nvme_tcp_request {
>   	u32			data_len;
>   	u32			pdu_len;
>   	u32			pdu_sent;
> +	u32			h2cdata_left;
> +	u32			h2cdata_offset;
>   	u16			ttag;
>   	__le16			status;
>   	struct list_head	entry;
> @@ -95,6 +97,7 @@ struct nvme_tcp_queue {
>   	struct nvme_tcp_request *request;
>   
>   	int			queue_size;
> +	u32			maxh2cdata;
>   	size_t			cmnd_capsule_len;
>   	struct nvme_tcp_ctrl	*ctrl;
>   	unsigned long		flags;
> @@ -572,23 +575,26 @@ static int nvme_tcp_handle_comp(struct nvme_tcp_queue *queue,
>   	return ret;
>   }
>   
> -static void nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
> -		struct nvme_tcp_r2t_pdu *pdu)
> +static void nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req)
>   {
>   	struct nvme_tcp_data_pdu *data = req->pdu;
>   	struct nvme_tcp_queue *queue = req->queue;
>   	struct request *rq = blk_mq_rq_from_pdu(req);
> +	u32 h2cdata_sent = req->pdu_len;
>   	u8 hdgst = nvme_tcp_hdgst_len(queue);
>   	u8 ddgst = nvme_tcp_ddgst_len(queue);
>   
>   	req->state = NVME_TCP_SEND_H2C_PDU;
>   	req->offset = 0;
> -	req->pdu_len = le32_to_cpu(pdu->r2t_length);
> +	req->pdu_len = min(req->h2cdata_left, queue->maxh2cdata);
>   	req->pdu_sent = 0;
> +	req->h2cdata_left -= req->pdu_len;
> +	req->h2cdata_offset += h2cdata_sent;
>   
>   	memset(data, 0, sizeof(*data));
>   	data->hdr.type = nvme_tcp_h2c_data;
> -	data->hdr.flags = NVME_TCP_F_DATA_LAST;
> +	if (!req->h2cdata_left)
> +		data->hdr.flags = NVME_TCP_F_DATA_LAST;
>   	if (queue->hdr_digest)
>   		data->hdr.flags |= NVME_TCP_F_HDGST;
>   	if (queue->data_digest)
> @@ -597,9 +603,9 @@ static void nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
>   	data->hdr.pdo = data->hdr.hlen + hdgst;
>   	data->hdr.plen =
>   		cpu_to_le32(data->hdr.hlen + hdgst + req->pdu_len + ddgst);
> -	data->ttag = pdu->ttag;
> +	data->ttag = req->ttag;
>   	data->command_id = nvme_cid(rq);
> -	data->data_offset = pdu->r2t_offset;
> +	data->data_offset = cpu_to_le32(req->h2cdata_offset);
>   	data->data_length = cpu_to_le32(req->pdu_len);
>   }
>   
> @@ -609,6 +615,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
>   	struct nvme_tcp_request *req;
>   	struct request *rq;
>   	u32 r2t_length = le32_to_cpu(pdu->r2t_length);
> +	u32 r2t_offset = le32_to_cpu(pdu->r2t_offset);
>   
>   	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
>   	if (!rq) {
> @@ -633,14 +640,19 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
>   		return -EPROTO;
>   	}
>   
> -	if (unlikely(le32_to_cpu(pdu->r2t_offset) < req->data_sent)) {
> +	if (unlikely(r2t_offset < req->data_sent)) {
>   		dev_err(queue->ctrl->ctrl.device,
>   			"req %d unexpected r2t offset %u (expected %zu)\n",
> -			rq->tag, le32_to_cpu(pdu->r2t_offset), req->data_sent);
> +			rq->tag, r2t_offset, req->data_sent);
>   		return -EPROTO;
>   	}
>   
> -	nvme_tcp_setup_h2c_data_pdu(req, pdu);
> +	req->pdu_len = 0;

Why do you need to set this here? it is set in the initial command
execution...

> +	req->h2cdata_left = r2t_length;
> +	req->h2cdata_offset = r2t_offset;
> +	req->ttag = pdu->ttag;
> +
> +	nvme_tcp_setup_h2c_data_pdu(req);
>   	nvme_tcp_queue_request(req, false, true);
>   
>   	return 0;
> @@ -920,6 +932,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>   {
>   	struct nvme_tcp_queue *queue = req->queue;
>   	int req_data_len = req->data_len;
> +	u32 h2cdata_left = req->h2cdata_left;
>   
>   	while (true) {
>   		struct page *page = nvme_tcp_req_cur_page(req);
> @@ -964,7 +977,10 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>   				req->state = NVME_TCP_SEND_DDGST;
>   				req->offset = 0;
>   			} else {
> -				nvme_tcp_done_send_req(queue);
> +				if (h2cdata_left)
> +					nvme_tcp_setup_h2c_data_pdu(req);
> +				else
> +					nvme_tcp_done_send_req(queue);
>   			}
>   			return 1;
>   		}
> @@ -1022,9 +1038,14 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
>   	if (queue->hdr_digest && !req->offset)
>   		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
>   
> -	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
> -			offset_in_page(pdu) + req->offset, len,
> -			MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
> +	if (!req->h2cdata_left)
> +		ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
> +				offset_in_page(pdu) + req->offset, len,
> +				MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
> +	else
> +		ret = sock_no_sendpage(queue->sock, virt_to_page(pdu),
> +				offset_in_page(pdu) + req->offset, len,
> +				MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
>   	if (unlikely(ret <= 0))
>   		return ret;
>   
> @@ -1044,6 +1065,7 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
>   {
>   	struct nvme_tcp_queue *queue = req->queue;
>   	size_t offset = req->offset;
> +	u32 h2cdata_left = req->h2cdata_left;
>   	int ret;
>   	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
>   	struct kvec iov = {
> @@ -1061,7 +1083,10 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
>   		return ret;
>   
>   	if (offset + ret == NVME_TCP_DIGEST_LENGTH) {
> -		nvme_tcp_done_send_req(queue);
> +		if (h2cdata_left)
> +			nvme_tcp_setup_h2c_data_pdu(req);
> +		else
> +			nvme_tcp_done_send_req(queue);
>   		return 1;
>   	}
>   
> @@ -1247,6 +1272,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>   	struct msghdr msg = {};
>   	struct kvec iov;
>   	bool ctrl_hdgst, ctrl_ddgst;
> +	u32 maxh2cdata;
>   	int ret;
>   
>   	icreq = kzalloc(sizeof(*icreq), GFP_KERNEL);
> @@ -1330,6 +1356,14 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>   		goto free_icresp;
>   	}
>   
> +	maxh2cdata = le32_to_cpu(icresp->maxdata);
> +	if ((maxh2cdata % 4) || (maxh2cdata < NVME_TCP_MIN_MAXH2CDATA)) {
> +		pr_err("queue %d: invalid maxh2cdata returned %u\n",
> +		       nvme_tcp_queue_id(queue), maxh2cdata);
> +		goto free_icresp;
> +	}
> +	queue->maxh2cdata = maxh2cdata;
> +
>   	ret = 0;
>   free_icresp:
>   	kfree(icresp);
> @@ -2314,6 +2348,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
>   	req->data_sent = 0;
>   	req->pdu_len = 0;
>   	req->pdu_sent = 0;
> +	req->h2cdata_left = 0;
>   	req->data_len = blk_rq_nr_phys_segments(rq) ?
>   				blk_rq_payload_bytes(rq) : 0;
>   	req->curr_bio = rq->bio;
> diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
> index 959e0bd..7547015 100644
> --- a/include/linux/nvme-tcp.h
> +++ b/include/linux/nvme-tcp.h
> @@ -12,6 +12,7 @@
>   #define NVME_TCP_DISC_PORT	8009
>   #define NVME_TCP_ADMIN_CCSZ	SZ_8K
>   #define NVME_TCP_DIGEST_LENGTH	4
> +#define NVME_TCP_MIN_MAXH2CDATA 4096
>   
>   enum nvme_tcp_pfv {
>   	NVME_TCP_PFV_1_0 = 0x0,
> 

