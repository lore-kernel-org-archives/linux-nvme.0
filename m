Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD111C001B0
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 13:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o1ebpl5NxHbK12xs55CEp48/oVbgsK3Wk7Vvj0Ronr8=; b=Pb2lgrDXKgTORUwQ0qtePR1Pel
	hT/nNUUIRRZPFXN5HdV/d/Ifd2aw/gNeKwmGjGbHPWlrugdr3SdQiP6QOqT9MC22J1KOuK2+k4gyS
	HPEwjRfoH7mRq5dgSCVpDvqYnUrJdfh6nhE9m6/l5RSALYVoyq9DsW3C9++wv1Nd+xyXdv+Gut1JY
	8C1xPt/ZL6PNXvgr6tisJ2VMJA/Sud+NnMvrYQn28q7274oeqqMAu8Oc5sbd4CViQ3QZ4FgUOTzLQ
	XPuNE6RFJ4PUvMr/8yBlyPaPoYGs+FvwkvYYwWD/HyfF/g5cHSBTTBYF3Tktmw1ffk5VG7M8gXZaR
	atV5Gbuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNvAO-004Nd6-20;
	Mon, 24 Jul 2023 13:00:00 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNvAL-004Nb5-33
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 12:59:59 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fa99b4f71fso4895515e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jul 2023 05:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690203595; x=1690808395;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1ebpl5NxHbK12xs55CEp48/oVbgsK3Wk7Vvj0Ronr8=;
        b=OJpT8wSNndCrPfpXuVMaXlrGnIYxWzbQmL6JDMcLdjEcIXvj4UI4exi3AjY6l9ORJo
         Zg2XWzcaPbqjd/BRvtYZUv0qqAhGmDw8bkv9VTuU/+U7muX9mu7lvkvJJ5ieHBELuVwx
         Ew+3eS8dzdWEgV+ZdekwsdjffFW4creAzRRTpM4Tq4/KeWQILD3lCmOOfT10Qcdq3vaJ
         oqUjrrwGjU5sdebfSW3SZ+4AlTJ1qWrqK0Rh6MnMJoOdMf3RH6DsQasibyV/umY+mC0g
         OcaXIbwDVyJi7IX0Aa6Z310lW1s5fYSIAhrnHvad7figmanLkMMh6aYr7N7Z7VonwYCf
         tBzw==
X-Gm-Message-State: ABy/qLYgEkqrgiM9PmfcdPAiEYfmLoCcEIrbubXD0PSmuXFBhSHWois2
	v8meXM+qus55w9Mn/ns/2Xs=
X-Google-Smtp-Source: APBJJlGYzj5Cyhk0zoVvabeGklRVYZ1E/0sg49CwkkRJjz60K6uZEp3QvudqftgNPAHPAovsC4Rdow==
X-Received: by 2002:a05:600c:3b99:b0:3fb:3dd9:89c with SMTP id n25-20020a05600c3b9900b003fb3dd9089cmr7873825wms.0.1690203594929;
        Mon, 24 Jul 2023 05:59:54 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k8-20020a7bc408000000b003fa95f328afsm12805442wmi.29.2023.07.24.05.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 05:59:54 -0700 (PDT)
Message-ID: <5196edbd-45dc-8542-975b-1a49e4061668@grimberg.me>
Date: Mon, 24 Jul 2023 15:59:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/6] net/tls: implement ->read_sock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230721143523.56906-1-hare@suse.de>
 <20230721143523.56906-7-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230721143523.56906-7-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_055957_979091_37DE0E7E 
X-CRM114-Status: GOOD (  21.37  )
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



On 7/21/23 17:35, Hannes Reinecke wrote:
> Implement ->read_sock() function for use with nvme-tcp.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Cc: Boris Pismenny <boris.pismenny@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org
> ---
>   net/tls/tls.h      |  2 ++
>   net/tls/tls_main.c |  2 ++
>   net/tls/tls_sw.c   | 89 ++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 93 insertions(+)
> 
> diff --git a/net/tls/tls.h b/net/tls/tls.h
> index 86cef1c68e03..7e4d45537deb 100644
> --- a/net/tls/tls.h
> +++ b/net/tls/tls.h
> @@ -110,6 +110,8 @@ bool tls_sw_sock_is_readable(struct sock *sk);
>   ssize_t tls_sw_splice_read(struct socket *sock, loff_t *ppos,
>   			   struct pipe_inode_info *pipe,
>   			   size_t len, unsigned int flags);
> +int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
> +		     sk_read_actor_t read_actor);
>   
>   int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
>   void tls_device_splice_eof(struct socket *sock);
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index b6896126bb92..7dbb8cd8f809 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -962,10 +962,12 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
>   	ops[TLS_BASE][TLS_SW  ] = ops[TLS_BASE][TLS_BASE];
>   	ops[TLS_BASE][TLS_SW  ].splice_read	= tls_sw_splice_read;
>   	ops[TLS_BASE][TLS_SW  ].poll		= tls_sk_poll;
> +	ops[TLS_BASE][TLS_SW  ].read_sock	= tls_sw_read_sock;
>   
>   	ops[TLS_SW  ][TLS_SW  ] = ops[TLS_SW  ][TLS_BASE];
>   	ops[TLS_SW  ][TLS_SW  ].splice_read	= tls_sw_splice_read;
>   	ops[TLS_SW  ][TLS_SW  ].poll		= tls_sk_poll;
> +	ops[TLS_SW  ][TLS_SW  ].read_sock	= tls_sw_read_sock;
>   
>   #ifdef CONFIG_TLS_DEVICE
>   	ops[TLS_HW  ][TLS_BASE] = ops[TLS_BASE][TLS_BASE];
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index d0636ea13009..f7ffbe7620cb 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -2202,6 +2202,95 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
>   	goto splice_read_end;
>   }
>   
> +int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
> +		     sk_read_actor_t read_actor)
> +{
> +	struct tls_context *tls_ctx = tls_get_ctx(sk);
> +	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
> +	struct strp_msg *rxm = NULL;
> +	struct sk_buff *skb = NULL;
> +	struct sk_psock *psock;
> +	struct tls_msg *tlm;
> +	ssize_t copied = 0;
> +	int err, used;
> +
> +	psock = sk_psock_get(sk);
> +	if (psock) {
> +		sk_psock_put(sk, psock);
> +		return -EINVAL;
> +	}
> +	err = tls_rx_reader_acquire(sk, ctx, true);
> +	if (err < 0)
> +		return err;
> +
> +	/* If crypto failed the connection is broken */
> +	err = ctx->async_wait.err;
> +	if (err)
> +		goto read_sock_end;
> +
> +	do {
> +		if (!skb_queue_empty(&ctx->rx_list)) {
> +			skb = __skb_dequeue(&ctx->rx_list);
> +			rxm = strp_msg(skb);
> +			tlm = tls_msg(skb);
> +		} else {
> +			struct tls_decrypt_arg darg;
> +
> +			err = tls_rx_rec_wait(sk, NULL, true, true);
> +			if (err <= 0)
> +				goto read_sock_end;
> +
> +			memset(&darg.inargs, 0, sizeof(darg.inargs));
> +
> +			rxm = strp_msg(tls_strp_msg(ctx));
> +			tlm = tls_msg(tls_strp_msg(ctx));
> +
> +			err = tls_rx_one_record(sk, NULL, &darg);
> +			if (err < 0) {
> +				tls_err_abort(sk, -EBADMSG);
> +				goto read_sock_end;
> +			}
> +
> +			sk_flush_backlog(sk);

Question,
Based on Jakub's comment, the flush is better spaced out.
Why not just do it once at the end? Or alternatively,
call tls_read_flush_backlog() ? Or just count by hand
every 4 records or 128K (and once in the end)?

I don't really know what would be the impact though, but
you are effectively releasing and re-acquiring the socket
flushing the backlog every record...

