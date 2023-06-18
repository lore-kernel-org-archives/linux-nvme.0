Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C32EB64D7
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Jun 2023 16:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VPsd3RxvSK9akU38J5qW4D3wDnVV1+TTrRbY+MUugj8=; b=Tq8ymi+fyBKP4io074zoEemYS8
	HWrGdbnMxx7F8cav8ya3B2dHFCxbwevoZCFiB/Fxcll8959OFJ8azVR212K4YOfxn6RymcS6jsZEE
	6JH4tTOTDGr1MCMyDpgDvnKty0u5ajKBSEcEOG1FS//SjEcfXYip7/IlOezcqMXmKl67p9UPi/sbS
	5gkz8Jl/UnY3XYhXqIVflF1+6GzX0XtVPqozXBcEVMhofylxvTiwKUL3gGb5sAo/ShNanfq09kMol
	Cn2iCXd+01Yo8Nhw0jNFIc323QukGusngEGwtWkVmzlqM4f40AxlmCr2SZ2KAoFs6qFAFTwq6UN80
	6g1O3XIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qAvZO-006IVN-0a;
	Sun, 18 Jun 2023 16:48:06 +0000
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qAvZH-006ITM-1Q
	for linux-nvme@lists.infradead.org;
	Sun, 18 Jun 2023 16:48:01 +0000
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f9f523c70bso11827761cf.0
        for <linux-nvme@lists.infradead.org>; Sun, 18 Jun 2023 09:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687106877; x=1689698877;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPsd3RxvSK9akU38J5qW4D3wDnVV1+TTrRbY+MUugj8=;
        b=Cfj0sc49fEerL20hzENwz8PtcItwwSbnaClH5NS/pVHzmM/dvwLvhEaT6FYCNl0dmR
         OKA9zNJyQSpEsphH2tw/CmB52MYtdWASeDtaWkyUm3LzO0GqY0RFWBEMNwQKgRY1gte/
         hFMC/AS9uLs82RUEb9AvmdAHt4dHGLIlvQtI1Qr2qE9QAJ1KEPOoriAEOnrDHQkQ+d6+
         gYyzxf6y0xuGX7Gw8XirNiB3R4dTioKlXECEhHMm60fL4/KIEzIlvrrC3HawxafPHOPi
         CkcKx2T+h62Q42tysZQtLYJz8kH1cDimH+ATSgv62GnlbyeLcPaoPKDyV/U0EqAyz9T6
         O39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687106877; x=1689698877;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VPsd3RxvSK9akU38J5qW4D3wDnVV1+TTrRbY+MUugj8=;
        b=c6CBGXMOv0Npx+FkDgNX9UHFMeo0XoWgu9EsWNXVf0eza1P6mB6wqnBBlAJZ9eEDOl
         bDoMS6iNzJStDN09/H+adYBpPfKFfzO/dh1HHs0G2bvMwnGTVKkV/P3i2i+WdpatVn6C
         KbgxOciizpn0In2Bv1TckKEBmBQjU+PqtOB4nxwGmas3oahrijokdu/AuXH+LHR6bXC5
         jKyD0Xcz63qVBDyljr5iJ2K7iIv/S7Zm4R11XslGpFfRBEGnVdkgWq+Fe0FJ49MYESrw
         byXBqXYMYx3m4UEsQpJtTLS8BH1AAH1bqRmAu4kty1Cz3y0jjvi+thjdgqpGAXdHVkKC
         36WA==
X-Gm-Message-State: AC+VfDwMCZqIJLwJuh72+9RHIwhAuN4tKqhXlDojH556bUOIDlX1KvAS
	VcALEmrlKKmHjBMwaU5souQ=
X-Google-Smtp-Source: ACHHUZ6JDA42tEVXmLhshxtfb/9NVBPcW7rIpixWMOPq33WSJX3rYKh2qwYXdHkZVaM5I6lap7+ZYQ==
X-Received: by 2002:a05:622a:195:b0:3f8:2a37:20f with SMTP id s21-20020a05622a019500b003f82a37020fmr15741005qtw.34.1687106876943;
        Sun, 18 Jun 2023 09:47:56 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id bc14-20020a05622a1cce00b003fe8a96fb3bsm571571qtb.54.2023.06.18.09.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 09:47:56 -0700 (PDT)
Date: Sun, 18 Jun 2023 12:47:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: David Howells <dhowells@redhat.com>, 
 netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, 
 Alexander Duyck <alexander.duyck@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, 
 Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@fb.com>, 
 Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>, 
 linux-nvme@lists.infradead.org
Message-ID: <648f353c55ce8_33cfbc29413@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230617121146.716077-11-dhowells@redhat.com>
References: <20230617121146.716077-1-dhowells@redhat.com>
 <20230617121146.716077-11-dhowells@redhat.com>
Subject: RE: [PATCH net-next v2 10/17] nvme: Use sendmsg(MSG_SPLICE_PAGES)
 rather then sendpage
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230618_094759_525738_D84949E2 
X-CRM114-Status: GOOD (  21.13  )
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

David Howells wrote:
> When transmitting data, call down into TCP using a single sendmsg with
> MSG_SPLICE_PAGES to indicate that content should be spliced rather than
> performing several sendmsg and sendpage calls to transmit header, data
> pages and trailer.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Keith Busch <kbusch@kernel.org>
> cc: Jens Axboe <axboe@fb.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Sagi Grimberg <sagi@grimberg.me>
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
>     ver #2)
>      - Wrap lines at 80.
> 
>  drivers/nvme/host/tcp.c   | 46 ++++++++++++++++++++-------------------
>  drivers/nvme/target/tcp.c | 46 ++++++++++++++++++++++++---------------
>  2 files changed, 53 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index bf0230442d57..6f31cdbb696a 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -997,25 +997,25 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
>  	u32 h2cdata_left = req->h2cdata_left;
>  
>  	while (true) {
> +		struct bio_vec bvec;
> +		struct msghdr msg = {
> +			.msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES,
> +		};
>  		struct page *page = nvme_tcp_req_cur_page(req);
>  		size_t offset = nvme_tcp_req_cur_offset(req);
>  		size_t len = nvme_tcp_req_cur_length(req);
>  		bool last = nvme_tcp_pdu_last_send(req, len);
>  		int req_data_sent = req->data_sent;
> -		int ret, flags = MSG_DONTWAIT;
> +		int ret;
>  
>  		if (last && !queue->data_digest && !nvme_tcp_queue_more(queue))
> -			flags |= MSG_EOR;
> +			msg.msg_flags |= MSG_EOR;
>  		else
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
>  		if (ret <= 0)
>  			return ret;
>  
> @@ -1054,22 +1054,24 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>  {
>  	struct nvme_tcp_queue *queue = req->queue;
>  	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
> +	struct bio_vec bvec;
> +	struct msghdr msg = { .msg_flags = MSG_DONTWAIT | MSG_SPLICE_PAGES, };
>  	bool inline_data = nvme_tcp_has_inline_data(req);
>  	u8 hdgst = nvme_tcp_hdgst_len(queue);
>  	int len = sizeof(*pdu) + hdgst - req->offset;
> -	int flags = MSG_DONTWAIT;
>  	int ret;
>  
>  	if (inline_data || nvme_tcp_queue_more(queue))
> -		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
> +		msg.msg_flags |= MSG_MORE;
>  	else
> -		flags |= MSG_EOR;
> +		msg.msg_flags |= MSG_EOR;
>  
>  	if (queue->hdr_digest && !req->offset)
>  		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
>  
> -	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
> -			offset_in_page(pdu) + req->offset, len,  flags);
> +	bvec_set_virt(&bvec, (void *)pdu + req->offset, len);
> +	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
> +	ret = sock_sendmsg(queue->sock, &msg);
>  	if (unlikely(ret <= 0))
>  		return ret;
>

    struct bio_vec bvec;
    struct msghdr msg = { .msg_flags = MSG_SPLICE_PAGES | ... };

    ..

    bvec_set_virt
    iov_iter_bvec
    sock_sendmsg

is a frequent pattern. Does it make sense to define a wrapper? Same for bvec_set_page.

