Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F140BC00140
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 13:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=egjVfBfP2+DSAflfWi9iG7KkzeybtXGdm366A4iau4Y=; b=hZCEaiy0WWMjq+ZACY/t7HNNcc
	4OmC7vC7uZSbFxM+phJUvAMBbiuQ+0d+NKbdfbo9D72uXa9uLnIUcpNzRwGTQOMsefAjpXbOeBsfT
	sPDC07ONErJtDwZ/z+hlxWnGS9qstUjluzlx3rllPHz1Bff1NpyD3nVTz/IYJ6FVXD1M1s/ZUNTvQ
	ipq0zomWyLCJF9l6US1nY38agK9qMb7HfJ9+su4z2DJwe3xY7nnoWvVTt0+HGmbQyJIfiwme56Vco
	6S7eWRFKUvVnfSscc2EwdERw+6KCWWpdLNoYVXf89XBqJwXHYlceRojQ5ux0Sv5N5cNgzZne+7yb2
	t2BCL4ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLlQv-00Burj-9U; Wed, 10 Aug 2022 13:07:37 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLlQr-00Bupk-J5
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 13:07:34 +0000
Received: by mail-wr1-f41.google.com with SMTP id j7so17724087wrh.3
        for <linux-nvme@lists.infradead.org>; Wed, 10 Aug 2022 06:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=egjVfBfP2+DSAflfWi9iG7KkzeybtXGdm366A4iau4Y=;
        b=bz9B2jA3khiJe53X9CmaLqEJF1n+vB+tqa1VaW6X3/CR1ebzbbZOtzpoYpJbhh1M/6
         uz7+tOTwan3hX9kKk6sKtZ6fOVJpRECqMOE6Gjqa5xoRVyhF+kegOdVoLo3dUSKLCzTK
         fb329vV9PMLQ+LWMAHgYLNVX5creQJY3UOqjrg8jpyxHg90In4ngTIj84A5y2cjAOmta
         JWI6Eod+MHK3nYxlcIfw2geEBw63+FJuEdYHAvuzUNDgUhHy5Ks0rxb2cZVwkxeP4S+A
         M2qE65zI5Ag8fc3TchZjreUGdMJXzsMXDDY9PDYjZkZKgBc6C2UM4ZD0ouwdBztL1zth
         Uh0g==
X-Gm-Message-State: ACgBeo2z4yFNf82xf1aGV9EPC5RJzT5YBroVgWQSbjFZ940T16GXT6vb
	iZaUOn7y5AKfyZZWyN+H90zxytcSiiU=
X-Google-Smtp-Source: AA6agR4E3GOk2GttBpA2LPnnZ6Zr3Jh6YYcHoSIGcoEgSONAh4MOJ5RDIENj+c5XGZLvVG3ZpmhL6A==
X-Received: by 2002:a5d:4205:0:b0:223:654d:a2f8 with SMTP id n5-20020a5d4205000000b00223654da2f8mr5366405wrq.114.1660136850739;
        Wed, 10 Aug 2022 06:07:30 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c4fc400b003a310fe1d75sm126850wmq.38.2022.08.10.06.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 06:07:30 -0700 (PDT)
Message-ID: <ad5af636-7baa-9915-7eae-d8d244eb4fc2@grimberg.me>
Date: Wed, 10 Aug 2022 16:07:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-target tcp: fix unhandled tcp states in
 nvmet_tcp_state_change()
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org
References: <20220802151922.480571-1-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220802151922.480571-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_060733_667773_7D8937B0 
X-CRM114-Status: GOOD (  16.27  )
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


> TCP_FIN_WAIT2 and TCP_LAST_ACK were not handled, the connection is closing
> so it's safe to call nvmet_tcp_schedule_release_queue() and avoid printing
> the "unhandled state" warning message.
> 
> [ 1298.852386] nvmet_tcp: queue 2 unhandled state 5
> [ 1298.879112] nvmet_tcp: queue 7 unhandled state 5
> [ 1298.884253] nvmet_tcp: queue 8 unhandled state 5
> [ 1298.889475] nvmet_tcp: queue 9 unhandled state 5
> 
> Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
> ---
>   drivers/nvme/target/tcp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 5f9303232e86..b06a58eb02fc 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1524,6 +1524,8 @@ static void nvmet_tcp_state_change(struct sock *sk)
>   
>   	switch (sk->sk_state) {
>   	case TCP_FIN_WAIT1:
> +	case TCP_FIN_WAIT2:
> +	case TCP_LAST_ACK:
>   	case TCP_CLOSE_WAIT:
>   	case TCP_CLOSE:
>   		/* FALLTHRU */

I know that nvmet_tcp_schedule_release_queue is safe, but I think we
for sure called it before these events, so won't it be better for
readability to just do nothing when we get these events?

