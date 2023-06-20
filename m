Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F556EB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 13:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M0gIgvDtcmYiR+ujZPiaQl78n9DjwDyLMnh3WVrRmj8=; b=2l2jnFxAsHaiYR487AQlnwkUcH
	cqtwafBBTEACOENta9TgPg3yUX68tNG8y6u7t1RvtW/BgGqjXHK8jBEReMAXDBa133Nh6MKNdKMxA
	wjMExk9R2sVxlrxR4dsUVR/jPqw+tEOMYW6H8f0l/YV6nJWpkQ9XS611pO6lDDEq6JE1CFKAU6mCG
	0HuezF9JqSkqNBaizyyylvajVpV+AxKqh/F+L9MPJmS5rHC5fZb6j0QGlVzS2opQvKlSTFvH/S34g
	KIBC3FBzonGCQNEGXkDF5KswxycFIEM+SaafQ5KuUlPwNfvcBzoppaUkyvensgBTc5jJZm/eivImX
	2WySpeEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbIZ-00BMvs-1y;
	Tue, 20 Jun 2023 13:21:31 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbIV-00BMux-3A
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 13:21:29 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f90ab8e841so6672855e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 20 Jun 2023 06:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687267286; x=1689859286;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0gIgvDtcmYiR+ujZPiaQl78n9DjwDyLMnh3WVrRmj8=;
        b=IWXFCpv2FplcpP9TD+RRuYfoRVy8OJEOnpxQJAiL5K0ULyLFICIdn6t8ChYXqlhA4U
         mg3thfM7h63fPlzdF+ETEAPdLHHR+y4QQ3123Kmyh+U2YWABeiMdph//LfzEodEiZGBy
         zqDjbNWTyxd+qhc1iUOtqVnC7WezhtBfpA62PcVmZr5rIzxI3euJNdORGDD49TN+uvrm
         ffkL84H5e4EzOmO4zvnFX/ASZsAojBbtsZV9HNXNkQoYp2fxM5uwpGr4ip6vQT6DkOdz
         11awrkT4hDbkR+lly+ELa51iR4gDFushipfzpVvPYRuC4xgmSETCFtIZ59H8kBW9QPsv
         1KqQ==
X-Gm-Message-State: AC+VfDzKPxCMJYVHISQW2UPOnSQnLYlB+Ta2IsdOiUxmGC1G4DFSJ+16
	2fGeG2euuGFqIH4/9E9tsac=
X-Google-Smtp-Source: ACHHUZ7zg4z9RjgldGtqe8IpCuU8GFLSgMUFIdBFIlkfgwmzKEOXqIww85lq8+Mo0Ec4dDibVER4JA==
X-Received: by 2002:adf:f7c5:0:b0:30a:f103:1f55 with SMTP id a5-20020adff7c5000000b0030af1031f55mr8724379wrq.0.1687267285850;
        Tue, 20 Jun 2023 06:21:25 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p9-20020adfcc89000000b003113f0ba414sm2006920wrj.65.2023.06.20.06.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 06:21:25 -0700 (PDT)
Message-ID: <5bbb6ce4-a251-a357-3efc-9e899e470b9c@grimberg.me>
Date: Tue, 20 Jun 2023 16:21:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] net/tls: implement ->read_sock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230620102856.56074-1-hare@suse.de>
 <20230620102856.56074-5-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230620102856.56074-5-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_062128_021387_3C3A3791 
X-CRM114-Status: GOOD (  18.90  )
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
>   net/tls/tls_sw.c   | 78 ++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 82 insertions(+)
> 
> diff --git a/net/tls/tls.h b/net/tls/tls.h
> index d002c3af1966..ba55cd5c4913 100644
> --- a/net/tls/tls.h
> +++ b/net/tls/tls.h
> @@ -114,6 +114,8 @@ bool tls_sw_sock_is_readable(struct sock *sk);
>   ssize_t tls_sw_splice_read(struct socket *sock, loff_t *ppos,
>   			   struct pipe_inode_info *pipe,
>   			   size_t len, unsigned int flags);
> +int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
> +		     sk_read_actor_t read_actor);
>   
>   int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
>   void tls_device_splice_eof(struct socket *sock);
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index 7b9c83dd7de2..1a062a8c6d33 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -963,10 +963,12 @@ static void build_proto_ops(struct proto_ops ops[TLS_NUM_CONFIG][TLS_NUM_CONFIG]
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
> index 97379e34c997..e918c98bbeb2 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -2231,6 +2231,84 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
>   	goto splice_read_end;
>   }
>   
> +int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
> +		     sk_read_actor_t read_actor)
> +{
> +	struct tls_context *tls_ctx = tls_get_ctx(sk);
> +	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
> +	struct strp_msg *rxm = NULL;
> +	struct tls_msg *tlm;
> +	struct sk_buff *skb;
> +	ssize_t copied = 0;
> +	int err, used;
> +
> +	err = tls_rx_reader_lock(sk, ctx, true);
> +	if (err < 0)
> +		return err;

Unlike recvmsg or splice_read, the caller of read_sock is assumed to
have the socket locked, and tls_rx_reader_lock also calls lock_sock,
how is this not a deadlock?

I'm not exactly clear why the lock is needed here or what is the subtle
distinction between tls_rx_reader_lock and what lock_sock provides.

