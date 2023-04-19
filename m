Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E400C77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 09:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z0Ki+yrYya/1+WhprlDMDeSQUZpYWApjqzOUYsxVvk4=; b=y63FMa1/dA4A9iKhF00ukQky2O
	j7NPlCmLG28mMut/nYTtZvPAhidrZ6tzYlhEpTw6kbGCbZ8sOkfgBNUa1HuxqyLSDmF2003hY7s4Z
	aqmjQZeNRGYi04638QCzm9tmt/yGbQ6uVv/D079C7FOgbyEN/Pe2zQnkK96jSjAUN7ktnBNt9NqiM
	SHO5JDCZixNoLCrJyHipzPtdZfKJBwE41SJ8NLSxJ0Q3QltX7n2AprDw+XTQmTQZhNyrDdqWjediK
	rlcR7LHrOAKwbDcpyu4wAVlAhZhcergIxJK8Q4bXLxxONfBmO/9xi2Uxzoc6Sx/sbnmq79TV92Oma
	jh8EQwlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp4Mq-004mv2-0W;
	Wed, 19 Apr 2023 09:44:48 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp4Mo-004mtj-0z
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 09:44:47 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-2f44739a2afso725185f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 19 Apr 2023 02:44:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681897483; x=1684489483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0Ki+yrYya/1+WhprlDMDeSQUZpYWApjqzOUYsxVvk4=;
        b=UYhkow/qbSPpBtp5ejL5XAcumPC2GdYxFWtoJ1s8v+uOjA5hdu0zw2OLlUbXS6rBSx
         NQFk4OzJd/gqa9ltrLbcJz44cBjvb50MkihheSpHXqPn81OMwCWYFLtxGbImpg9gIMUf
         mjVLAkaxS8kzeh1no3CgGGOiUm8fMVt1+XH0KNYJOSpvd0yrcrvqnnV7CL9978jJfiDF
         DrEeahgfP8r0UDWtIO19wa60E3CCJKjo/nUfUHUFkttLAvjAfp3rPI0oVkX/PZNuXB6Q
         K4V0pbwQvKycTyfEoX/dYQ52EX5hEkj1bHOziU+pC3MUyTtowdXDhWw0lj+TDB9ilLbz
         WF8g==
X-Gm-Message-State: AAQBX9fv7Qr6aiudPZk1xWwKgy2d+sDJEiiaqsaRUsdbO8blJWMf5tuK
	o5ifRsXYxvpkc/PLeh3M6XMsRYMlGs4=
X-Google-Smtp-Source: AKy350YBFr1LPGuBZcbadSoufhTh3lhlQvF26xHbA9eNc8m85K2TgGYF3yYUiNAk4Eu9OfMg9V2rwQ==
X-Received: by 2002:a5d:6905:0:b0:2f9:59a3:eb30 with SMTP id t5-20020a5d6905000000b002f959a3eb30mr7502143wru.0.1681897483633;
        Wed, 19 Apr 2023 02:44:43 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a12-20020a05600c224c00b003f1788eeffesm1581283wmm.43.2023.04.19.02.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 02:44:43 -0700 (PDT)
Message-ID: <3ec250a9-54c7-3e0d-2463-f8faf15cdb58@grimberg.me>
Date: Wed, 19 Apr 2023 12:44:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-3-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230419084757.24846-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_024446_342016_574DD005 
X-CRM114-Status: GOOD (  21.99  )
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


> Before we unload the module we should cleanup the fc resources first,
> basically reorder the shutdown sequence to be in reverse order of the
> setup path.

If this triggers a bug, then I think it is a good idea to have a
dedicated test that reproduces it if we are changing the default
behavior.

> 
> Also unload the nvme-fcloop after usage.
> 
> While at it also update the rdma stop_soft_rdma before the module
> unloading for the same reasoning.

Why? it creates the wrong reverse ordering.

1. setup soft-rdma
2. setup nvme-rdma

2. teardown nvme-rdma
1. teardown soft-rdma

I don't think we need this change. I mean it is a good test
to have that the rdma device goes away underneath nvme-rdma
but it is good for a dedicated test.

> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/rc | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index ec0cc2d8d8cc..41f196b037d6 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -260,18 +260,20 @@ _cleanup_nvmet() {
>   	shopt -u nullglob
>   	trap SIGINT
>   
> -	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
> -	if [[ "${nvme_trtype}" != "loop" ]]; then
> -		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
> -	fi
> -	modprobe -rq nvmet 2>/dev/null
>   	if [[ "${nvme_trtype}" == "rdma" ]]; then
>   		stop_soft_rdma
>   	fi
>   	if [[ "${nvme_trtype}" == "fc" ]]; then
>   		_cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
>   			        "${def_remote_wwnn}" "${def_remote_wwpn}"
> +		modprobe -rq nvme-fcloop
>   	fi
> +
> +	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
> +	if [[ "${nvme_trtype}" != "loop" ]]; then
> +		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
> +	fi
> +	modprobe -rq nvmet 2>/dev/null
>   }
>   
>   _setup_nvmet() {

