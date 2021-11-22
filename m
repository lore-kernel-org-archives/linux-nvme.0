Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D9FC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 11:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1AInrRP5egsREzP4LG0baFr8oV4mVoq9b2T1m/xZjV0=; b=PlhlKzY3Onii7cJ4BnmKpeO21p
	ezZ/sk0qVkAwBcyF9HsOPbTA3qtN/3j58iQsLXgcGgWV8FusIxfJYAuthojpj/d27JnMtSOWHgHkw
	Mf9r2vy6zbvRMtlQQzV/6qfYs9mLcBbRLczZ7hnDe0UNX/PVOk8bRM7wjUV98mFNK1oThvOPgsTKb
	N+97PQIQ8aDzsvPK8D76Sak5hSIOvhm3eGWU5lOTEd1zF07yDgX5iD8wdzxwldpeBsRoehXecbvkJ
	hqS2udcIWLG809Rvn+o9prj64Wu2Nm7bUkO9657POFeHRAhV9SMZemvfoTkhGHSvChtmpf3rLIwkw
	k/7SVXpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp7gl-00G6jy-Rp; Mon, 22 Nov 2021 11:40:47 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp6fL-00Frvk-87
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 10:35:17 +0000
Received: by mail-wm1-f43.google.com with SMTP id y196so14790350wmc.3
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 02:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1AInrRP5egsREzP4LG0baFr8oV4mVoq9b2T1m/xZjV0=;
 b=upMRFXG+fmt0wQjRuAJUwJl1oTflFgg+0ArxXJFZt66pvXIXk0oyn+awE85M4Amd8e
 ISvh3W9ARloWEQLuwShWR3Xordgph9SIr8iI0VI4AWwJGH1fQrK9X6H/V76Zzim9RGaW
 LoV2goyktYD2xDj1eaIkY7rwR5IwfFj4sF7k8TwoZS/oTRSLSY3TnUmF46wOiq2a6VIn
 5e6QdJXNpnd0RXDTOmU20e8psdoNLxFyPulclr5Oia/cdPu8QTi+VQ1A75rQpbiFVWQX
 KGfsw4lM0oJ7Nl1JrjPV0gaNghSXOOfsEir+tsNQmSkaJs/1N3OqbXtDFh3Irq9TBSXx
 YpaA==
X-Gm-Message-State: AOAM530Lvx743lUCC3gUw1lUtU2+u0O1OAEwIapNMOoURT9LSStWbg3T
 mRmWqBpjnHLdSqdxcKMDGYiuRgwo3G8=
X-Google-Smtp-Source: ABdhPJzGuaBn+ZdmX0++mGfNtfg/Lr9Bao3ptLmQCSKnTTAkaLEQJudKMYz+6fTiP6qMe+Q7N0HuJA==
X-Received: by 2002:a05:600c:1d28:: with SMTP id
 l40mr28477204wms.192.1637577313059; 
 Mon, 22 Nov 2021 02:35:13 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id m34sm23961931wms.25.2021.11.22.02.35.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 02:35:12 -0800 (PST)
Subject: Re: [PATCH v2 2/2] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
To: Varun Prakash <varun@chelsio.com>, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <1637576743-3341-1-git-send-email-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f6e46674-5856-1f0d-045c-6ced393bda70@grimberg.me>
Date: Mon, 22 Nov 2021 12:35:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637576743-3341-1-git-send-email-varun@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_023515_370635_0897E264 
X-CRM114-Status: GOOD (  30.39  )
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



On 11/22/21 12:25 PM, Varun Prakash wrote:
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
> v2:
>   removed nvme_tcp_update_h2c_data_pdu()
>   used sock_no_sendpage() instead of kernel_sendmsg()
> 
>   drivers/nvme/host/tcp.c  | 41 +++++++++++++++++++++++++++++++++++------
>   include/linux/nvme-tcp.h |  1 +
>   2 files changed, 36 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 92e07d2..82f8926 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -97,6 +97,7 @@ struct nvme_tcp_queue {
>   	struct nvme_tcp_request *request;
>   
>   	int			queue_size;
> +	u32			maxh2cdata;
>   	size_t			cmnd_capsule_len;
>   	struct nvme_tcp_ctrl	*ctrl;
>   	unsigned long		flags;
> @@ -582,7 +583,7 @@ static void nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req)
>   	u8 hdgst = nvme_tcp_hdgst_len(queue);
>   	u8 ddgst = nvme_tcp_ddgst_len(queue);
>   
> -	req->pdu_len = req->h2cdata_left;
> +	req->pdu_len = min(req->h2cdata_left, queue->maxh2cdata);
>   	req->pdu_sent = 0;
>   
>   	memset(data, 0, sizeof(*data));
> @@ -933,6 +934,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>   {
>   	struct nvme_tcp_queue *queue = req->queue;
>   	int req_data_len = req->data_len;
> +	u32 h2cdata_left = req->h2cdata_left;

No need for the local variable, the reference only happens when the
pdu data transfer is completed.

>   
>   	while (true) {
>   		struct page *page = nvme_tcp_req_cur_page(req);
> @@ -977,7 +979,13 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>   				req->state = NVME_TCP_SEND_DDGST;
>   				req->offset = 0;
>   			} else {
> -				nvme_tcp_done_send_req(queue);
> +				if (h2cdata_left) {
> +					nvme_tcp_setup_h2c_data_pdu(req);
> +					req->state = NVME_TCP_SEND_H2C_PDU;
> +					req->offset = 0;

req->state and req->offset setting can move to
nvme_tcp_setup_h2c_data_pdu() as commented in patch 1.

> +				} else {
> +					nvme_tcp_done_send_req(queue);
> +				}
>   			}
>   			return 1;
>   		}
> @@ -1028,16 +1036,21 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
>   {
>   	struct nvme_tcp_queue *queue = req->queue;
>   	struct nvme_tcp_data_pdu *pdu = req->pdu;
> +	struct page *page = virt_to_page(pdu);
> +	size_t offset = offset_in_page(pdu) + req->offset;
>   	u8 hdgst = nvme_tcp_hdgst_len(queue);
>   	int len = sizeof(*pdu) - req->offset + hdgst;
> +	int flags = MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST;
>   	int ret;

Not sure the local variables are needed, but OK, I'm fine with that.

>   
>   	if (queue->hdr_digest && !req->offset)
>   		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
>   
> -	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
> -			offset_in_page(pdu) + req->offset, len,
> -			MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
> +	if (req->h2cdata_left)
> +		ret = sock_no_sendpage(queue->sock, page, offset, len, flags);
> +	else
> +		ret = kernel_sendpage(queue->sock, page, offset, len, flags);
> +
>   	if (unlikely(ret <= 0))
>   		return ret;
>   
> @@ -1057,6 +1070,7 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
>   {
>   	struct nvme_tcp_queue *queue = req->queue;
>   	size_t offset = req->offset;
> +	u32 h2cdata_left = req->h2cdata_left;

No need for local variable.

>   	int ret;
>   	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
>   	struct kvec iov = {
> @@ -1074,7 +1088,13 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
>   		return ret;
>   
>   	if (offset + ret == NVME_TCP_DIGEST_LENGTH) {
> -		nvme_tcp_done_send_req(queue);
> +		if (h2cdata_left) {
> +			nvme_tcp_setup_h2c_data_pdu(req);
> +			req->state = NVME_TCP_SEND_H2C_PDU;
> +			req->offset = 0;
> +		} else {
> +			nvme_tcp_done_send_req(queue);
> +		}
>   		return 1;
>   	}
>   
> @@ -1260,6 +1280,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
>   	struct msghdr msg = {};
>   	struct kvec iov;
>   	bool ctrl_hdgst, ctrl_ddgst;
> +	u32 maxh2cdata;
>   	int ret;
>   
>   	icreq = kzalloc(sizeof(*icreq), GFP_KERNEL);
> @@ -1343,6 +1364,14 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
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

