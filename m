Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213E1C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 11:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3u2puAsIXvMxpc1YF0UlIA91Nn8UBHuihCB3NdojJAM=; b=y0KFSZWrFeNdaWDNC8xmvM9qeX
	5tbcIHMn7nSatVJn2wPA/aKl+DyC0YmUshj2eTlPhrL8ryuC9jWEjS4oiPYBF3gI00Jp8VymjnHec
	FF/P1MzqR0XnvUFposT/RDOO1AbEB1xXBkmqMfVWv6Hkgz3Hj3S4vFcD/XkRSSWttexex79+nLwxY
	AziBZhbasJ9C2frwZgaaZYBJI0m/UmTD/5UgxzRwwRB5DWWvibdyOx7lkEZJlfB2tXCk0O89liWEY
	yT1VrAlFU5pmHQbEC6grttaL4Df4yzr5zEnmaebTB9CMLLAIl8b6BIko0ohjh9/TumhmcUnBxMz6d
	pPCLgCJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp7if-00G7LK-Vg; Mon, 22 Nov 2021 11:42:46 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp6nZ-00Ftob-R2
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 10:43:47 +0000
Received: by mail-wr1-f54.google.com with SMTP id d27so31850509wrb.6
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 02:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3u2puAsIXvMxpc1YF0UlIA91Nn8UBHuihCB3NdojJAM=;
 b=Tv7l+Y2beh9YDRX0qhFC5rGFFKQezTKVsGg2kABO7zjY9aGvcVZUJwYDFqAe/5gGRA
 h3XSVSS1OTh3gGOb8id+WunJidC3rSay1CuaxLcX/E9Lr0JW9QGihOiOIVsYhVUSjVif
 THd7ZqvZKNT3TCM9bhpdSt7tHTuzFVU9WEslI0t5P8gKkb70EYbfwF/S5Z9ZXPclbNoy
 XJDXv5zRgJUxn1hie7EJmHaXxoa9rbbtzN2qD5Rsex/Jd/X9CrsZF6OQIXZuVvvndpr5
 2DVbD4WTsPESbptiu9T47lEBR2axMdPIvy0jzzxTF4KU4nHf1zF+cV56wIVdDRD1wCvz
 Iwag==
X-Gm-Message-State: AOAM533wHJfmtam5y6aM0YDMSxA4JeI06BkdeMeq00gQ8iULWqTGWuRv
 kRnh6YWHSxhw7+jjk5zi300sEXvS8vE=
X-Google-Smtp-Source: ABdhPJxZYJi3tetjDzDuqJY/7glREwzfhZaNwndZaox7M1oJ75FHeaLEt0rQAQDTgY8XAR3bCBelwA==
X-Received: by 2002:a05:6000:1a86:: with SMTP id
 f6mr36709956wry.230.1637577823379; 
 Mon, 22 Nov 2021 02:43:43 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id k15sm8457904wrx.53.2021.11.22.02.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 02:43:43 -0800 (PST)
Subject: Re: [PATCH 1/2] nvme-tcp: validate R2T PDU in nvme_tcp_handle_r2t()
To: Varun Prakash <varun@chelsio.com>, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <1637575953-3143-1-git-send-email-varun@chelsio.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <23b20797-f085-5fe0-ff6a-554e7d10575c@grimberg.me>
Date: Mon, 22 Nov 2021 12:43:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1637575953-3143-1-git-send-email-varun@chelsio.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_024345_952592_31DB8958 
X-CRM114-Status: GOOD (  26.99  )
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



On 11/22/21 12:12 PM, Varun Prakash wrote:
> If maxh2cdata < r2t_length then driver will form multiple
> H2CData PDUs, validate R2T PDU in nvme_tcp_handle_r2t() to
> reuse nvme_tcp_setup_h2c_data_pdu().
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

No need to move the hdr.flags setting here to the bottom, you can keep
it where it was. Also perhaps let's have h2cdata_left and h2cdata_offset
advanced right after they were used?

I'm thinking about something like this:
--
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4d49fc816a74..16d45afe5753 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -44,6 +44,8 @@ struct nvme_tcp_request {
         u32                     data_len;
         u32                     pdu_len;
         u32                     pdu_sent;
+       u32                     h2cdata_left;
+       u32                     h2cdata_offset;
         u16                     ttag;
         __le16                  status;
         struct list_head        entry;
@@ -95,6 +97,7 @@ struct nvme_tcp_queue {
         struct nvme_tcp_request *request;

         int                     queue_size;
+       u32                     maxh2cdata;
         size_t                  cmnd_capsule_len;
         struct nvme_tcp_ctrl    *ctrl;
         unsigned long           flags;
@@ -572,21 +575,24 @@ static int nvme_tcp_handle_comp(struct 
nvme_tcp_queue *queue,
         return ret;
  }

-static void nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
-               struct nvme_tcp_r2t_pdu *pdu)
+static void nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req)
  {
         struct nvme_tcp_data_pdu *data = req->pdu;
         struct nvme_tcp_queue *queue = req->queue;
         struct request *rq = blk_mq_rq_from_pdu(req);
         u8 hdgst = nvme_tcp_hdgst_len(queue);
         u8 ddgst = nvme_tcp_ddgst_len(queue);
+       u32 h2cdata_sent = req->pdu_len;

-       req->pdu_len = le32_to_cpu(pdu->r2t_length);
+       req->pdu_len = min(req->h2cdata_left, queue->maxh2cdata);
+       req->h2cdata_left -= req->pdu_len;
+       req->h2cdata_offset += h2cdata_sent;
         req->pdu_sent = 0;

         memset(data, 0, sizeof(*data));
         data->hdr.type = nvme_tcp_h2c_data;
-       data->hdr.flags = NVME_TCP_F_DATA_LAST;
+       if (!req->h2cdata_left)
+               data->hdr.flags = NVME_TCP_F_DATA_LAST;
         if (queue->hdr_digest)
                 data->hdr.flags |= NVME_TCP_F_HDGST;
         if (queue->data_digest)
@@ -595,9 +601,9 @@ static void nvme_tcp_setup_h2c_data_pdu(struct 
nvme_tcp_request *req,
         data->hdr.pdo = data->hdr.hlen + hdgst;
         data->hdr.plen =
                 cpu_to_le32(data->hdr.hlen + hdgst + req->pdu_len + ddgst);
-       data->ttag = pdu->ttag;
+       data->ttag = req->ttag;
         data->command_id = nvme_cid(rq);
-       data->data_offset = pdu->r2t_offset;
+       data->data_offset = cpu_to_le32(req->h2cdata_offset);
         data->data_length = cpu_to_le32(req->pdu_len);

         req->state = NVME_TCP_SEND_H2C_PDU;
@@ -643,7 +649,10 @@ static int nvme_tcp_handle_r2t(struct 
nvme_tcp_queue *queue,
                 return -EPROTO;
         }

-       nvme_tcp_setup_h2c_data_pdu(req, pdu);
+       req->h2cdata_left = r2t_length;
+       req->h2cdata_offset = le32_to_cpu(pdu->r2t_offset);
+       req->ttag = pdu->ttag;
+       nvme_tcp_setup_h2c_data_pdu(req);
         nvme_tcp_queue_request(req, false, true);

         return 0;
@@ -967,7 +976,10 @@ static int nvme_tcp_try_send_data(struct 
nvme_tcp_request *req)
                                 req->state = NVME_TCP_SEND_DDGST;
                                 req->offset = 0;
                         } else {
-                               nvme_tcp_done_send_req(queue);
+                               if (req->h2cdata_left)
+                                       nvme_tcp_setup_h2c_data_pdu(req);
+                               else
+                                       nvme_tcp_done_send_req(queue);
                         }
                         return 1;
                 }
@@ -1018,16 +1030,20 @@ static int nvme_tcp_try_send_data_pdu(struct 
nvme_tcp_request *req)
  {
         struct nvme_tcp_queue *queue = req->queue;
         struct nvme_tcp_data_pdu *pdu = req->pdu;
+       struct page *page = virt_to_page(pdu);
+       size_t offset = offset_in_page(pdu) + req->offset;
         u8 hdgst = nvme_tcp_hdgst_len(queue);
         int len = sizeof(*pdu) - req->offset + hdgst;
+       int flags = MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST;
         int ret;

         if (queue->hdr_digest && !req->offset)
                 nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));

-       ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-                       offset_in_page(pdu) + req->offset, len,
-                       MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
+       if (!req->h2cdata_left)
+               ret = kernel_sendpage(queue->sock, page, offset, len, 
flags);
+       else
+               ret = sock_no_sendpage(queue->sock, page, offset, len, 
flags);
         if (unlikely(ret <= 0))
                 return ret;

@@ -1064,7 +1080,10 @@ static int nvme_tcp_try_send_ddgst(struct 
nvme_tcp_request *req)
                 return ret;

         if (offset + ret == NVME_TCP_DIGEST_LENGTH) {
-               nvme_tcp_done_send_req(queue);
+               if (req->h2cdata_left)
+                       nvme_tcp_setup_h2c_data_pdu(req);
+               else
+                       nvme_tcp_done_send_req(queue);
                 return 1;
         }

@@ -1256,6 +1275,7 @@ static int nvme_tcp_init_connection(struct 
nvme_tcp_queue *queue)
         struct msghdr msg = {};
         struct kvec iov;
         bool ctrl_hdgst, ctrl_ddgst;
+       u32 maxh2cdata;
         int ret;

         icreq = kzalloc(sizeof(*icreq), GFP_KERNEL);
@@ -1339,6 +1359,14 @@ static int nvme_tcp_init_connection(struct 
nvme_tcp_queue *queue)
                 goto free_icresp;
         }

+       maxh2cdata = le32_to_cpu(icresp->maxdata);
+       if ((maxh2cdata % 4) || (maxh2cdata < NVME_TCP_MIN_MAXH2CDATA)) {
+               pr_err("queue %d: invalid maxh2cdata returned %u\n",
+                      nvme_tcp_queue_id(queue), maxh2cdata);
+               goto free_icresp;
+       }
+       queue->maxh2cdata = maxh2cdata;
+
         ret = 0;
  free_icresp:
         kfree(icresp);
diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
index 959e0bd9a913..75470159a194 100644
--- a/include/linux/nvme-tcp.h
+++ b/include/linux/nvme-tcp.h
@@ -12,6 +12,7 @@
  #define NVME_TCP_DISC_PORT     8009
  #define NVME_TCP_ADMIN_CCSZ    SZ_8K
  #define NVME_TCP_DIGEST_LENGTH 4
+#define NVME_TCP_MIN_MAXH2CDATA 4096

  enum nvme_tcp_pfv {
         NVME_TCP_PFV_1_0 = 0x0,
--

