Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A65EB64DC
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 10:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DhORNoU3ciKX2xP8peaOJGSJDkiRCI9EgxfOrsQf3GA=; b=ZQrAYGar2pz1k3P/27UxHs580z
	1QMPBnOF+LRfsAbo2iSXJtjChXtolX6Ef6u3tRZ3a53ikNJ+yifGFI7v+HoQDcCl8G8B33eyU2lqa
	OrR2gwy2gChh2x4VQqgBhMeL9UzDUbNKEwaEsvJwlk2B3KfuvKJifjqSO3u5yf/dMJhmKp7DhnyNN
	osFDg1bEY2hhhQGxStBSrpSIHOZi3ggF6A9/fqdo3x/9cPPYU5sJfXgtQwd170cr0DCPcqBodmjFw
	IWRymD63L5Jr6j4qrviiSzMw9kUZ5IBTKfzCQcNC7D8XSGPnTq4HRwEKf41miYX6H0dwBV+ESCvGt
	W1srMXrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGGSZ-00A3RW-01;
	Mon, 03 Jul 2023 10:07:07 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGGSW-00A3Qh-2k
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 10:07:06 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-31422f20399so796403f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Jul 2023 03:07:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688378821; x=1690970821;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DhORNoU3ciKX2xP8peaOJGSJDkiRCI9EgxfOrsQf3GA=;
        b=l6f/dK0ey+YtPuD54fTMgWDgDgT1GPT0MhA2IUzjsAOFmqnAuQnPG6G8Obeg0v1kRc
         HphZ+bmWtaAEsNRAi+dlWOvN4tDz26fW/pC4V/DJAlsmWhSDim72Z8cmDbZGNdzcT+Fp
         dQPJTbcEElGJI5+o/qVETg863th308oR1H9T8jznZRe29C9BIDVipARdqQre4czHfhzN
         XPsUMZz7G8eHcsDS7XygE4foAmYm+8dR/P85nuH1sg6ju1xrdpGdDaQTc5N/wkaa4zcJ
         ZSXKdvTLM3+rcC2rgFM1bHTC5lVsPSI5sJzP/znuBSYaQ+yQvOxNxIJv2RYMDDQl5lPn
         bd5w==
X-Gm-Message-State: ABy/qLYNRTx00gfq1cmsRktssi9LZ99D75UvF5cE3kw1aB1XmuOdIW+i
	Z33oeUjmGeNzy9vgWVXX0Vo=
X-Google-Smtp-Source: APBJJlHZsBsOfb54U+00VvImXcEPKqtex2r/HSSKxS0kYmdww2Zo1jSovvBgwP2qMZFtPyfWBNq4TQ==
X-Received: by 2002:adf:eece:0:b0:313:edb0:e8a8 with SMTP id a14-20020adfeece000000b00313edb0e8a8mr8349414wrp.2.1688378820796;
        Mon, 03 Jul 2023 03:07:00 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w11-20020adfec4b000000b0031437ec7ec1sm1914654wrn.2.2023.07.03.03.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 03:07:00 -0700 (PDT)
Message-ID: <1ebc60c1-c094-98a0-5735-635a8af5bf63@grimberg.me>
Date: Mon, 3 Jul 2023 13:06:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/5] net/tls: split tls_rx_reader_lock
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20230703090444.38734-1-hare@suse.de>
 <20230703090444.38734-5-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230703090444.38734-5-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_030704_911714_C1D01198 
X-CRM114-Status: GOOD (  14.53  )
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



On 7/3/23 12:04, Hannes Reinecke wrote:
> Split tls_rx_reader_{lock,unlock} into an 'acquire/release' and
> the actual locking part.
> With that we can use the tls_rx_reader_lock in situations where
> the socket is already locked.
> 
> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   net/tls/tls_sw.c | 38 ++++++++++++++++++++++----------------
>   1 file changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 9aef45e870a5..d0636ea13009 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1848,13 +1848,10 @@ tls_read_flush_backlog(struct sock *sk, struct tls_prot_info *prot,
>   	return sk_flush_backlog(sk);
>   }
>   
> -static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx *ctx,
> -			      bool nonblock)
> +static int tls_rx_reader_acquire(struct sock *sk, struct tls_sw_context_rx *ctx,
> +				 bool nonblock)

Nit: I still think tls_rx_reader_enter/tls_rx_reader_exit are more
appropriate names.

