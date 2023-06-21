Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398ABEB64DC
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 10:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ufw3XdlG8f50ui3w7eQOIJRzxVEkWkebHT8qYe+C8qE=; b=IqtBkZ24ZexOFFC9JocOVLggib
	uAgddyRDfIml9hFzsxfWtLH096wRb6aNrYM+HMIHpP/02jvgc5yM5fyAtH+Xu3kjFZqqQPD1G2AOF
	EO4C+V/b6jmzjjqf7rd3RpjoY9vOEZ/jydIIMJ+k0eQziD+p4RLjqvjfhSfxrLQ/cxeyXDx2mDVs1
	7IwDVWsIc2ObedaZZ6D5cqQt06PofXg46NSbRtQOWVou4fNa4IMYzH8xZcMiv3Pgb0fL3k49AVP4N
	qgDDEvkwj8Fg7iUsq29mlhCiilL5Lo/TkVGL/qvP5JQ96Z6k70dVssbssRVARlz9xTtkSHtPTYGLT
	F9UPAAXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBus0-00E00M-2V;
	Wed, 21 Jun 2023 10:15:24 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBurx-00Dzyr-1k
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 10:15:22 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3110f94915eso1276963f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 21 Jun 2023 03:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687342520; x=1689934520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufw3XdlG8f50ui3w7eQOIJRzxVEkWkebHT8qYe+C8qE=;
        b=OxU3cgSR+ljyxljvsjLBE+DewAZp5fCLfftES9ocqL0SJsVGYX+gGdEWTigVBJbmdx
         OuHdZSUgrMWD7rSDInE4BjG2nzRRlQY3k6n8Ypqokzc+P2DyuG403SpbIF8GecrCaKRG
         cvOCfZBJ7Dn/bP5/IkTaOrrdLruPA0mHu0J8ogCHZFC0TfEvkVc8xdE8W0l4pubtAqVV
         suoJo0TtWG6J/uIuVj6NIoICYm3RkzWR1bd4yt/SfdoG1lAbHSxwu8EHs8GldciGFYnb
         wqMv+isF3Ko4KOZv3IH8jCirrQrcJddNU+4TG28rKg6pMZ0EQw2Rjyo/bDM4/djSwBbf
         kPvw==
X-Gm-Message-State: AC+VfDyyDPBJ2eiLY+ZWG0PCD718hqVkDH8RTRLPMj3jPbgNKQvlESgj
	hx5lY9wJbCXsYZJytDEdC5Y=
X-Google-Smtp-Source: ACHHUZ4tsTabGuEP0pusOoHjithDqeGTXPlhvE5IPuJ0eWoLH8lfxNjVcT1Icfws8enUiCQS9OC42A==
X-Received: by 2002:a5d:468d:0:b0:30a:d0a0:266e with SMTP id u13-20020a5d468d000000b0030ad0a0266emr14265990wrq.2.1687342519535;
        Wed, 21 Jun 2023 03:15:19 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p9-20020adfcc89000000b003113f0ba414sm4082968wrj.65.2023.06.21.03.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 03:15:18 -0700 (PDT)
Message-ID: <87f547b0-7826-b232-cd01-c879b6829951@grimberg.me>
Date: Wed, 21 Jun 2023 13:15:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use
 sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Content-Language: en-US
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: Alexander Duyck <alexander.duyck@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org
References: <20230620145338.1300897-1-dhowells@redhat.com>
 <20230620145338.1300897-11-dhowells@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230620145338.1300897-11-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_031521_584659_DDAB500F 
X-CRM114-Status: GOOD (  23.74  )
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

One comment:

format for title in nvme-tcp is:

"nvme-tcp: ..." for host patches, and
"nvmet-tcp: ..." for target patches.

But this can be fixed up when applying the patch set.

Other than that, for both nvme patches:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

What tree will this be going from btw?

On 6/20/23 17:53, David Howells wrote:
> When transmitting data, call down into TCP using a single sendmsg with
> MSG_SPLICE_PAGES to indicate that content should be spliced rather than
> performing several sendmsg and sendpage calls to transmit header, data
> pages and trailer.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Tested-by: Sagi Grimberg <sagi@grimberg.me>
> Acked-by: Willem de Bruijn <willemb@google.com>
> cc: Keith Busch <kbusch@kernel.org>
> cc: Jens Axboe <axboe@fb.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Chaitanya Kulkarni <kch@nvidia.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: linux-nvme@lists.infradead.org
> cc: netdev@vger.kernel.org
> ---
> 
> Notes:
>      ver #2)
>       - Wrap lines at 80.
>      
>      ver #3)
>       - Split nvme/host from nvme/target changes.
> 
>   drivers/nvme/host/tcp.c | 46 +++++++++++++++++++++--------------------
>   1 file changed, 24 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index bf0230442d57..6f31cdbb696a 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -997,25 +997,25 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>   	u32 h2cdata_left = req->h2cdata_left;
>   
>   	while (true) {
> +		struct bio_vec bvec;
> +		struct msghdr msg = {
> +			.msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES,
> +		};
>   		struct page *page = nvme_tcp_req_cur_page(req);
>   		size_t offset = nvme_tcp_req_cur_offset(req);
>   		size_t len = nvme_tcp_req_cur_length(req);
>   		bool last = nvme_tcp_pdu_last_send(req, len);
>   		int req_data_sent = req->data_sent;
> -		int ret, flags = MSG_DONTWAIT;
> +		int ret;
>   
>   		if (last && !queue->data_digest && !nvme_tcp_queue_more(queue))
> -			flags |= MSG_EOR;
> +			msg.msg_flags |= MSG_EOR;
>   		else
> -			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
> +			msg.msg_flags |= MSG_MORE;
>   
> -		if (sendpage_ok(page)) {
> -			ret = kernel_sendpage(queue->sock, page, offset, len,
> -					flags);
> -		} else {
> -			ret = sock_no_sendpage(queue->sock, page, offset, len,
> -					flags);
> -		}
> +		bvec_set_page(&bvec, page, len, offset);
> +		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
> +		ret = sock_sendmsg(queue->sock, &msg);
>   		if (ret <= 0)
>   			return ret;
>   
> @@ -1054,22 +1054,24 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>   {
>   	struct nvme_tcp_queue *queue = req->queue;
>   	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
> +	struct bio_vec bvec;
> +	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES, };
>   	bool inline_data = nvme_tcp_has_inline_data(req);
>   	u8 hdgst = nvme_tcp_hdgst_len(queue);
>   	int len = sizeof(*pdu) + hdgst - req->offset;
> -	int flags = MSG_DONTWAIT;
>   	int ret;
>   
>   	if (inline_data || nvme_tcp_queue_more(queue))
> -		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
> +		msg.msg_flags |= MSG_MORE;
>   	else
> -		flags |= MSG_EOR;
> +		msg.msg_flags |= MSG_EOR;
>   
>   	if (queue->hdr_digest && !req->offset)
>   		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
>   
> -	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
> -			offset_in_page(pdu) + req->offset, len,  flags);
> +	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
> +	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
> +	ret = sock_sendmsg(queue->sock, &msg);
>   	if (unlikely(ret <= 0))
>   		return ret;
>   
> @@ -1093,6 +1095,8 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
>   {
>   	struct nvme_tcp_queue *queue = req->queue;
>   	struct nvme_tcp_data_pdu *pdu = nvme_tcp_req_data_pdu(req);
> +	struct bio_vec bvec;
> +	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_MORE, };
>   	u8 hdgst = nvme_tcp_hdgst_len(queue);
>   	int len = sizeof(*pdu) - req->offset + hdgst;
>   	int ret;
> @@ -1101,13 +1105,11 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
>   		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
>   
>   	if (!req->h2cdata_left)
> -		ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
> -				offset_in_page(pdu) + req->offset, len,
> -				MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
> -	else
> -		ret = sock_no_sendpage(queue->sock, virt_to_page(pdu),
> -				offset_in_page(pdu) + req->offset, len,
> -				MSG_DONTWAIT | MSG_MORE);
> +		msg.msg_flags |= MSG_SPLICE_PAGES;
> +
> +	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
> +	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
> +	ret = sock_sendmsg(queue->sock, &msg);
>   	if (unlikely(ret <= 0))
>   		return ret;
>   
> 

