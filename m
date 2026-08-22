Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9168C5B572
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 22:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HeO8qz7gI/PQdjAfS1WIWNrGC+sH7zaBOZAEPxSZsz0=; b=MdTnn0wjx6smmP4i63jHNy7Pn2
	+XUfqUjNhC/YmlGkO+IwqKOr0NCuHV9sLGNOYVOs2gQJvknSSwwEV7nP8vTVBOMXSXz6lMC2WIHGj
	Hj8ONr/kINnVAqN6KfV7iORkSTU2Q5PnCB4BYDQAOx119e20EqusSHUwTkZ1wuHUHbcDH9V06xmK2
	XO+QNBpF2Mwxcs5T9GNAOj+q6mmm9pyuyAqN5LyZxiG4+lt91cKZP4fQqtZw6JzsQy2e/yGj9YEfS
	FeB2pFPze5uZAxmDIrnECw7WPbp/odJgYpO2hQbi5xNmDKda2RNSMU7ptDhsykfswpIhhJHoAazMH
	pBwEcTSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxu40-0000000EqNg-4ARk;
	Sat, 22 Aug 2026 22:19:44 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxu3y-0000000EqMx-2pzs
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 22:19:43 +0000
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a422090b2fso3362792a12.0
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 15:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787437181; x=1788041981;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HeO8qz7gI/PQdjAfS1WIWNrGC+sH7zaBOZAEPxSZsz0=;
        b=L3WDBfBnGy30W7yemV0oag1u4PTCFjDG3gJ09JrPbEr6pxWSd48DWILh4iVw4lC1wt
         403+QupBtKipch0RRvbL4g1BArC+ThI+7PyrUcfmh65Y7pYWAB8JBR7Iony1Y0OSeOHV
         hrbMN8FSvOrxv6KSTpfRJnNQFjvNnfzQCZBJ9NNO0e15pDgNyGRGoOPJp9u3u4qo255m
         MtmOTvezxGlO5eHto9EYFGCKklgvHqCbP80ZtvdZmuhbfA8+ekMae+k1kkGgHLcnaWN3
         J4u0c0M0cCroLvLw4fJQb/xvzjEBL8GNjEA/AW3Vfh95AGtd9EkgstiLUjragANjWJOu
         ZvMA==
X-Forwarded-Encrypted: i=1; AHgh+RqACknLhx8JFr69NZARKWUySm47CjaZ9UgNySL7b2B2pzZ4Zd+geYdZxAGDP8RjJ0qFg1k6sYsgRL7r@lists.infradead.org
X-Gm-Message-State: AFuF++mmiwy5+yrN8SEot7wHFUkjRl8Z4OjW63yXd5xoaOiOrrUMq3tk
	JVAdRwHDrLzpceXG4U1Ii/BPauPj6fTsGuVVctRAtqwpQTKEPkCdtG6u
X-Gm-Gg: AR+sD10vbWypeM1Nw4zp8NhHrBCSFnjEK9Bwx4kJByM3m/vGfjeABKyKREYR95n2tnV
	aP5X88wfI0MqxoUE8XO9tUGXiZabl+474+3W6LzGYAl9rBVOJD4QFg00N/shg5NPKARye1yjkBV
	6qxhD5xwrUiUkyuphHvbT9DeQ4NTsSg9bLXMXqkDL91hDZARcCFL8pLXmTTFOrahAMOHTmZMdr7
	VIDLFQzLnyssyljO8C4CLkScYsDSU5p9E8gYQFNzHMd+V3uj9AjsLDoBZN9wLPif/jKbQhemUVG
	KJrtIlZ9JHwhjtcaQt9LsxV+SNn6A+27IgZjzpZIuvrsnCcC1NXs/jc8FeZbAI/8lggfiPamAI6
	z6DabNIuNRvuTNZpJIpGsCMP+Dkc+H1czT2pPm5w/5Xod/8IazoFD76gpIvWa17vhG9oaZlIGRe
	4ypnieYAMwrxUKh9thrzRj+urWStVPaPANJaWfFG3sMBW9gETdBnZ33lhlvITDoUZJShO7g6Xpb
	2kcsdCEqXl0k1iz1WJO1SA=
X-Received: by 2002:a17:906:fe49:b0:c24:b11c:6bf9 with SMTP id a640c23a62f3a-c24b11c6d84mr220160966b.6.1787437180599;
        Sat, 22 Aug 2026 15:19:40 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24967383e5sm483628966b.45.2026.08.22.15.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 15:19:40 -0700 (PDT)
Message-ID: <904ec61e-17e1-42f6-8215-63a806aeca76@grimberg.me>
Date: Sun, 23 Aug 2026 01:19:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] nvme-tcp: support IPv6 traffic class
To: Geliang Tang <geliang@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Hannes Reinecke <hare@suse.de>, Stanislav Fomichev <sdf@fomichev.me>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev
References: <cover.1786947923.git.tanggeliang@kylinos.cn>
 <d6095cd3809af7addc44ed162d70d6327dc237ac.1786947923.git.tanggeliang@kylinos.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d6095cd3809af7addc44ed162d70d6327dc237ac.1786947923.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_151942_721296_9B2770C5 
X-CRM114-Status: GOOD (  19.95  )
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



On 18/08/2026 9:03, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Currently, nvme-tcp host only supports setting the IPv4 TOS value when a
> TOS is specified, but does not handle the IPv6 traffic class.
>
> Extend the queue socket setup to handle AF_INET6 sockets by applying the
> TOS value to both IPv4 and IPv6 sockets. For IPv6, the TOS value is set
> as the IPv6 traffic class via IPV6_TCLASS using do_sock_setsockopt().
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   drivers/nvme/host/tcp.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 025cade370b2..5f30be04a9dd 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1815,6 +1815,17 @@ static int nvme_tcp_sock_set_tos(struct sock *sk, int tos)
>   				  KERNEL_SOCKPTR(&tos), sizeof(tos));
>   }
>   
> +static int nvme_tcp_sock_set_tclass(struct sock *sk, int tclass)
> +{
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (sk->sk_family == AF_INET6)
> +		return do_sock_setsockopt(sk->sk_socket, false, SOL_IPV6,
> +					  IPV6_TCLASS, KERNEL_SOCKPTR(&tclass),
> +					  sizeof(tclass));
> +#endif
> +	return 0;
> +}
> +
>   static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>   				key_serial_t pskid)
>   {
> @@ -1909,6 +1920,15 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>   				qid, ret);
>   			goto err_sock;
>   		}
> +
> +		ret = nvme_tcp_sock_set_tclass(queue->sock->sk,
> +					       nctrl->opts->tos);

Won't it just be cleaner to add a generic ip_sock_set_tclass() that 
hides the IS_ENABLED(CONFIG_IPV6) ifdef? Why do we need to wrap all 
these generic helpers?

