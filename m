Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741A2C77B7A
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 07:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p9VnTBxUfbgN/9foJR6iyloks5c6wdugCZ7HhQe+r5I=; b=tYK4SfbgCobyiMBDDjSMYcVitY
	+naZ6NzTvbrs7ejJF9yeSGDxvrWzh9dHPWObcAkDIQflAxghUZbLQ1xbiIDn8wBOxQXEDXd95wLDk
	23QpuLJctI2rlNpIV6g8W05HJIXMxNBHY3mIbY9Wl/k6d1LIgbAFqyfp226Yb2BbZnIec6mJsruDk
	jOwzapSdJm5cU2y4B6R+gvIWKnxhBrHb84DKapeZiIOG5+T8Cf4bLkaYoPv/H5BEMf4wppFgx9GFJ
	rbcdwzStRiZ7VZ/NrudNOMGzZcSHLuSbtykmsHtXrRZZOM6pT/WtW59EckjD3um9+ry7cnv/4sAc/
	Xggvsmog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8yuv-007Ify-1f;
	Tue, 13 Jun 2023 07:58:17 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8yut-007Ies-0Z
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 07:58:16 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-30fb90c52ffso583481f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Jun 2023 00:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686643092; x=1689235092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9VnTBxUfbgN/9foJR6iyloks5c6wdugCZ7HhQe+r5I=;
        b=juhrqGQIDpMTHjy8BcGaJ9KmooZ9+GnoikqyHqjJI0Vr9Y6/qH+hNjxeuE/OUCC3AV
         TevW/7BDs7K4hO7d9dtd+rdw9ob6vN/dA+mUKiDa9Do4+LeztVVraEpD8aXMb1aS5vHq
         bqnljwE64LlTVx/0whGRJnvlv3kJU7upb/bk6O7UoVxtebp1hLvLA/Pdag2/iWGEXCwS
         vl/aBO+cAH3zWaNfRAVse2iRPHpqFB8SinKFqDt6h0QUtXsYo3gec6UqzcxXcVdd/iNc
         1lZ383ko7XbgjvKvPyBs0pDz4t679mWepg4ewDFp1IrlSmFRKMzyHWZ5UxEGBwrbDNyE
         Y7GA==
X-Gm-Message-State: AC+VfDzLYwjfOCJKBWQnaaefUHaacRnU9iLqn03Emj3LzFx1WcP7CAVr
	bS9huhu0puQgSV9FUbXNZnU=
X-Google-Smtp-Source: ACHHUZ4uQhNINzWeLB440wOoJ04ma4DPbOWLtoFzjj9Srpn71qsS4k1OHoP+F5t5b5pbI0jiEsOBFQ==
X-Received: by 2002:adf:f581:0:b0:30e:460b:bede with SMTP id f1-20020adff581000000b0030e460bbedemr7574011wro.5.1686643092260;
        Tue, 13 Jun 2023 00:58:12 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o16-20020a1c7510000000b003f7e6d7f71esm13611058wmc.36.2023.06.13.00.58.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 00:58:11 -0700 (PDT)
Message-ID: <f560c8fa-d6a1-7bd2-3fd7-728f90207322@grimberg.me>
Date: Tue, 13 Jun 2023 10:58:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] net/tls: handle MSG_EOR for tls_device TX flow
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20230612143833.70805-1-hare@suse.de>
 <20230612143833.70805-3-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230612143833.70805-3-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_005815_216796_A4354F16 
X-CRM114-Status: GOOD (  21.16  )
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



On 6/12/23 17:38, Hannes Reinecke wrote:
> tls_push_data() MSG_MORE / MSG_SENDPAGE_NOTLAST, but bails
> out on MSG_EOR.
> But seeing that MSG_EOR is basically the opposite of
> MSG_MORE / MSG_SENDPAGE_NOTLAST this patch adds handling
> MSG_EOR by treating it as the absence of MSG_MORE.
> Consequently we should return an error when both are set.
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   net/tls/tls_device.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
> index a7cc4f9faac2..0024febd40de 100644
> --- a/net/tls/tls_device.c
> +++ b/net/tls/tls_device.c
> @@ -448,10 +448,6 @@ static int tls_push_data(struct sock *sk,
>   	int copy, rc = 0;
>   	long timeo;
>   
> -	if (flags &
> -	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST))
> -		return -EOPNOTSUPP;
> -
>   	if (unlikely(sk->sk_err))
>   		return -sk->sk_err;
>   
> @@ -529,6 +525,10 @@ static int tls_push_data(struct sock *sk,
>   				more = true;
>   				break;
>   			}
> +			if (flags & MSG_EOR) {
> +				more = false;
> +				break;
> +			}
>   
>   			done = true;
>   		}
> @@ -573,6 +573,14 @@ int tls_device_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>   	union tls_iter_offset iter;
>   	int rc;
>   
> +	if (msg->msg_flags &
> +	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_EOR))
> +		return -EOPNOTSUPP;
> +
> +	if ((msg->msg_flags & MSG_MORE) &&
> +	    (msg->msg_flags & MSG_EOR))
> +		return -EOPNOTSUPP;

EINVAL is more appropriate I think...

> +
>   	mutex_lock(&tls_ctx->tx_lock);
>   	lock_sock(sk);
>   
> @@ -601,9 +609,17 @@ int tls_device_sendpage(struct sock *sk, struct page *page,
>   	struct kvec iov;
>   	int rc;
>   
> +	if (flags &
> +	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST | MSG_EOR))
> +		return -EOPNOTSUPP;
> +
>   	if (flags & MSG_SENDPAGE_NOTLAST)
>   		flags |= MSG_MORE;
>   
> +	if ((flags & MSG_MORE) &&
> +	    (flags & MSG_EOR))
> +		return -EOPNOTSUPP;

EINVAL?

