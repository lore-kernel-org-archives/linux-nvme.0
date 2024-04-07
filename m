Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B732CD1292
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Apr 2024 21:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ot4ij1D6QTr/YIDHGHfghJIEALOsP9eeA7jh08aQX/o=; b=yTg5KHjqf+JSyB/4BVJLNpkKky
	R82Gde6Xnez8Xu6NVEiNHfsaB0ds2WmcfOSpHIi/QnaPbeqQQT/nxtmPqhQFHEeCaiZ4H1Sxxtak4
	Z9K+jQmKyLxvwyvzQJQdgbWDWQeh0GxC6AjmscFi66FPrL65A66VQPiKbD2oaWJTz0TNs1xUM0Yf/
	MRXaWcElGPEyuKhNQ32cWge8ZuuEHJ9LFM17KVbFvdhLHc31SovihfkHBkNHmw5ENAHaDfOtkd8J6
	Pigi6Vh/DK1hI//uCr/YKf2hCpebxpZRpVPf8uGsoFssWvN7b45hmuCQzaDtBlVdkgP1qpaNrWHvP
	/E9VhXZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtaNw-0000000Da8m-1a2w;
	Sun, 07 Apr 2024 21:49:08 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtaNt-0000000Da7P-2rZh
	for linux-nvme@lists.infradead.org;
	Sun, 07 Apr 2024 21:49:06 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4167082dabdso296155e9.0
        for <linux-nvme@lists.infradead.org>; Sun, 07 Apr 2024 14:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712526542; x=1713131342;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ot4ij1D6QTr/YIDHGHfghJIEALOsP9eeA7jh08aQX/o=;
        b=TdUaHjiUeMpZItV4AWJFJA2NB13Dfk72UEgU1GGztdH4J94b4d+iyvsZ/7wuMMhBp7
         7srZ5l3Vspmiy/7k3IQhvHH1MlDPOyF1EjqSqCEjgXF/31Y0K5PL7YJlFtGK12pwYQ6q
         lEJtqPk9OSnUIA2sQtWijHDpuSDtegaarPKOWxA25N+ofwcZDjRBSOUeM+gqZ0iuqKRk
         aUPndkNW8E0C56HFngTFxglIlpEFyk7PMGWMogIi+Vmn0i9imC1hdnQIlnmddps2z6lm
         MKUffwJtnFtEDrq0E8ZciydOKlqC/QanXjqSnBLM+Rn+9DGd97jek8WDZO1OUWegOP23
         49sA==
X-Forwarded-Encrypted: i=1; AJvYcCUTh69zOIHNcnJkDamEIJx87RZcHmh+xc5L/ozJCtRZLb6wPdW8+vByeKHigNow9WdjLXYsXWIJJ7EUnI8Prry7nCoxdXhaUSaMgq5C6WE=
X-Gm-Message-State: AOJu0YwR7om/BV7/SYQ7HKZ012h+fsRhpN2Cons1BAVJAMi3BbTuxqBY
	O1mceRywHPJb8mDfauWcQtDEZ0IYXZ9SGTlQlubu+BTzmu6dtKZe
X-Google-Smtp-Source: AGHT+IHH5dcE05hRyrWryTS22gMFSs4IfkfZtUkzbMqF122nh0ZHtDOSur9QPwH9gwuyux15r0X3zQ==
X-Received: by 2002:a5d:628f:0:b0:343:760d:29c8 with SMTP id k15-20020a5d628f000000b00343760d29c8mr4981834wru.1.1712526542534;
        Sun, 07 Apr 2024 14:49:02 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id p9-20020adff209000000b003432d61d6b7sm7393181wro.51.2024.04.07.14.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Apr 2024 14:49:02 -0700 (PDT)
Message-ID: <ddee2fd2-584c-42be-af5f-7e002b2d5441@grimberg.me>
Date: Mon, 8 Apr 2024 00:49:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] nvme-tcp: reset after recovery for secure
 concatenation
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240318150316.138501-1-hare@kernel.org>
 <20240318150316.138501-14-hare@kernel.org>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240318150316.138501-14-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_144905_773778_EC54434F 
X-CRM114-Status: GOOD (  19.79  )
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



On 18/03/2024 17:03, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> With TP8018 a new key will be generated from the DH-HMAC-CHAP
> protocol after reset or recovery, but we need to start over
> to establish a new TLS connection with the new keys.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/tcp.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 94152ded123a..3811ee9cd040 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2219,6 +2219,22 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
>   	}
>   }
>   
> +static bool nvme_tcp_reset_for_secure_concat(struct nvme_ctrl *ctrl)
> +{
> +	if (!ctrl->opts->concat)
> +		return false;
> +	/*
> +	 * If a key has been generated and TLS has not been enabled
> +	 * reset the queue to start TLS handshake.
> +	 */
> +	if (ctrl->opts->tls_key && !ctrl->tls_key) {
> +		dev_info(ctrl->device, "Reset to enable TLS with generated PSK\n");
> +		nvme_reset_ctrl(ctrl);
> +		return true;
> +	}
> +	return false;
> +}
> +
>   static void nvme_tcp_revoke_generated_tls_key(struct nvme_ctrl *ctrl)
>   {
>   	if (!ctrl->opts->concat)
> @@ -2321,6 +2337,9 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
>   	if (nvme_tcp_setup_ctrl(ctrl, false))
>   		goto requeue;
>   
> +	if (nvme_tcp_reset_for_secure_concat(ctrl))
> +		return;
> +
>   	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
>   			ctrl->nr_reconnects);
>   
> @@ -2396,6 +2415,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
>   	if (nvme_tcp_setup_ctrl(ctrl, false))
>   		goto out_fail;
>   
> +	nvme_tcp_reset_for_secure_concat(ctrl);

This is really strange. I'd imagine that this would be needed only if 
the derived psk expired no?

