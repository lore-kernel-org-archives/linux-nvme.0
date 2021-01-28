Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1766BC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 07:55:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8066064DD9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 07:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8066064DD9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YjxYr0EYD/gF5yo7YTEWoyoE7C/47ikLh+exhIyrKg4=; b=yZQGXxoGzoRlb946qS1751Nz2
	Ui9k6Yr6QlJDeGDb6q6FT+c4Mz3c9iQouhvq/dfdoQGZefO1LcNtOmnoEqM3izDNfA46U6ZCs5Nda
	hKJzTl5vd7llkxjZ20dyERzRvtNji8usHMKiZ25w5O1ExpnuHBTy7AcjWCQ3o36Sx4XU1rgy3ugJe
	w0eq/WWhIEmHKRTOtHtDGwTOV6fXcHVWIh+eGDTwAPqUWTvZgqAyJSM2t2xZicZbfyRnDgze9y9jT
	Wp+eDr7mgtVw43rmNZcSEIvlkr8jziLFL2MZaQ1h7XxWCxyrWkGwpNjiMqGSHrUDNMzbFL6+/IdK1
	fmZTFNLfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l528z-0004ja-0n; Thu, 28 Jan 2021 07:55:09 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l528w-0004i6-3E
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 07:55:06 +0000
Received: by mail-wr1-f51.google.com with SMTP id c12so4401209wrc.7
 for <linux-nvme@lists.infradead.org>; Wed, 27 Jan 2021 23:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tk3/d/fziPYi4qxjDI5ZBo9PMnGfBOtgwZ8r11JK9Lw=;
 b=F2x749ggFAQJ9wg7CF8JxtG32e1Zz4VPmtGzeAR06/39R4QGRqCpN9hkwskjPrAksg
 1FVa3kMq809VAGBDziL3OprHg53DaoilE1eDe4txvw00xXtNyGwDM8eDZ5DCTyRGa+Ed
 G8SySrQgg5KuKOwxbuGQsyilF4Xkhbf+cGccKQCwb0yMKV6AZl2Hn9dB2QLbR2Qr2HXW
 fkDQUcUtyZA8+V9qTV+e6slbF+9oPR3+M9OcXCCHQr8bB5YLJpX0I+Aa9/uQB2i1Khhz
 ZYrl33xkWo012H2pOMO42jNDEe6Ho6GEnQssydcmYxLnF5Of7wU7Pq3L0MSxtOT89F24
 zFvQ==
X-Gm-Message-State: AOAM533wg+GsjAQW8ZI2S6rzefvelhyYsonYViGTtVasWJmuqgVF7ekf
 kHRHJIVv7t+Xz1YWOnA5isxyz9JEuuo=
X-Google-Smtp-Source: ABdhPJz/lO9oqv42QQqcSDX7xbCP2mqE4DN1DedCEaozTRmGxO2J66xGlveDlgu08dEVxM+OFo0Z4g==
X-Received: by 2002:a5d:69ce:: with SMTP id s14mr14454128wrw.206.1611820502880; 
 Wed, 27 Jan 2021 23:55:02 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:4d86:226e:ca4b:6bef?
 ([2601:647:4802:9070:4d86:226e:ca4b:6bef])
 by smtp.gmail.com with ESMTPSA id h14sm1056847wmq.45.2021.01.27.23.55.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Jan 2021 23:55:02 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
To: elad.grupi@dell.com, linux-nvme@lists.infradead.org
References: <20210126153757.99451-1-elad.grupi@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8eead62d-a96b-46b7-fc87-71e599d3d83d@grimberg.me>
Date: Wed, 27 Jan 2021 23:54:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126153757.99451-1-elad.grupi@dell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_025506_162200_9411D6B2 
X-CRM114-Status: GOOD (  22.47  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> From: Elad Grupi <elad.grupi@dell.com>
> 
> avoid calling nvmet_tcp_release_queue_work if tcp socket was closed
> before setting the sk callbacks.

But we need to call the release_queue work, not sure I understand
how this works.

> 
> prevent io_work from enqueuing while closing the tcp queue to
> avoid race with nvmet_tcp_release_queue_work.

io_work is going to run with release_queue_work, because
it is also coming from the backend completion. The right
way to solve this is to correctly fence them.

Can you describe the exact race you are referring to?

> 
> Signed-off-by: Elad Grupi <elad.grupi@dell.com>
> ---
>   drivers/nvme/target/tcp.c | 26 +++++++++++++++++++++-----
>   1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index d535080b781f..937f2a746d8b 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -647,7 +647,7 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
>   	struct nvmet_tcp_cmd *cmd = queue->snd_cmd;
>   	int ret = 0;
>   
> -	if (!cmd || queue->state == NVMET_TCP_Q_DISCONNECTING) {
> +	if (!cmd) {
>   		cmd = nvmet_tcp_fetch_cmd(queue);
>   		if (unlikely(!cmd))
>   			return 0;
> @@ -1196,7 +1196,7 @@ static void nvmet_tcp_io_work(struct work_struct *w)
>   	/*
>   	 * We exahusted our budget, requeue our selves
>   	 */
> -	if (pending)
> +	if (pending && queue->state != NVMET_TCP_Q_DISCONNECTING)
>   		queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
>   }
>   
> @@ -1453,9 +1453,27 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
>   	sock->sk->sk_state_change = nvmet_tcp_state_change;
>   	queue->write_space = sock->sk->sk_write_space;
>   	sock->sk->sk_write_space = nvmet_tcp_write_space;
> +
> +	switch (sk->sk_state) {
> +	case TCP_FIN_WAIT1:
> +	case TCP_CLOSE_WAIT:
> +	case TCP_CLOSE:
> +		/* FALLTHRU */
> +		sock->sk->sk_data_ready =  queue->data_ready;
> +		sock->sk->sk_state_change = queue->state_change;
> +		sock->sk->sk_write_space = queue->write_space;
> +		sk->sk_user_data = NULL;
> +		queue->state = NVMET_TCP_Q_DISCONNECTING;
> +		ret = -ENOTCONN;
> +		break;
> +	default:
> +		queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
> +		ret = 0;
> +	}
> +
>   	write_unlock_bh(&sock->sk->sk_callback_lock);
>   
> -	return 0;
> +	return ret;
>   }
>   
>   static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
> @@ -1506,8 +1524,6 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>   	if (ret)
>   		goto out_destroy_sq;
>   
> -	queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
> -
>   	return 0;
>   out_destroy_sq:
>   	mutex_lock(&nvmet_tcp_queue_mutex);
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
