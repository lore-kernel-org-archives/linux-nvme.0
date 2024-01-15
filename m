Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2DFC3DA79
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jan 2024 12:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PX4w1eO8SQ4miExZH1g1NHHO884JSkp7W4e0LRAChEM=; b=Ov8SC9YBWtOvJ4n8kWAn/dyMPN
	K6kURiyaKG/3zYM/D4S56Pb8XoFaIEnC/DJdzrtfKa5kZYM1l2CQVHcpHjmEWsHHZ6sjEEYMx60EC
	Azw1PvtWJ0ogPAkjA5izWGR5I5i4q2Tnin329krriwAo1tQQOPOqPuVr6TixRnBJedJnzL5oTq43y
	ozOnftHb96x8ckLnx49w5TR4vFiCHsA/CAIiL4UkysMMMWaRC/XVYPJ+/PJ0kO+gLgdH1PCLP9eJO
	3n0Ev5WMyxzZ5IR/Tg/ngQwQS0BBOTscV07ldBySj6yRn32twSUD2fLOr6aa9oTivF9vJ9z3QZ6GN
	sWRSMYJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPMRQ-008wWx-2d;
	Mon, 15 Jan 2024 12:51:48 +0000
Received: from mail-ed1-f48.google.com ([209.85.208.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPMRN-008wWW-1X
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jan 2024 12:51:46 +0000
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55760f84177so1736676a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 15 Jan 2024 04:51:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705323101; x=1705927901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PX4w1eO8SQ4miExZH1g1NHHO884JSkp7W4e0LRAChEM=;
        b=oKBK8UsBgmtd1lE/srlfK1lE6Fo+IdvQo9bha2WkbhJmGcdBaLDmgGFH9IFwjakTIo
         mWi8Vnx/Z+aG4/pZ8KJg+G8Ihplr5plTvFriS00kPRZ2+cmDemN4tkNKRxut+ECf5Krv
         Dm7my8Msl7URDow8JxbSArTnrqBMaGFarIohSmv6oz2VGyQ0KpYu29CqWWpdW2v1NJV2
         jv1/wtYP3WHX3dpbHSDjbDoTo+mB+4ftCBxsUtQXVn+AcDUXUl8ctqX1dCKEDh4/PB9a
         0S6YBL8saCEUmNV9j8tSFoPxOGXeAuNv16AA/YZdsQ8LLae5Y52ere9xo7eXwwkpeuxT
         xSdQ==
X-Gm-Message-State: AOJu0Ywx7XOpbXq6dgyb0hSvC22hw2HbnZAxfQJLgHLdWTZymFPzzzfZ
	H+yQ1kOcX8/7XP1zVptZDJ4=
X-Google-Smtp-Source: AGHT+IEfK6avEZem+pRkHHZunH+Pl4RVkxYgQRbCbCnUJ9HnI1xylja2qQdlAg0A0Ss/urlYNoB4eA==
X-Received: by 2002:aa7:da4a:0:b0:558:f40b:4581 with SMTP id w10-20020aa7da4a000000b00558f40b4581mr4126744eds.1.1705323101613;
        Mon, 15 Jan 2024 04:51:41 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j7-20020aa7ca47000000b00556ee10cfe3sm5395358edt.92.2024.01.15.04.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 04:51:41 -0800 (PST)
Message-ID: <4ad9d0a8-00b6-4970-9127-ccbe1d2f26bf@grimberg.me>
Date: Mon, 15 Jan 2024 14:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme/auth: optimize code redundancy and provide code
 quality
Content-Language: en-US
To: mengfanhui <mengfanhui@kylinos.cn>, kbusch@kernel.org, axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240115065231.12733-1-mengfanhui@kylinos.cn>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240115065231.12733-1-mengfanhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_045145_531196_80FB3997 
X-CRM114-Status: GOOD (  13.74  )
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


> Improve code quality. Reduce code redundancy.

Why does this improve code quality? Why does this
reduce code redundancy?

It's just a different style, seems like a useless change to me.

> 
> Signed-off-by: mengfanhui <mengfanhui@kylinos.cn>
> ---
>   drivers/nvme/common/auth.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index a23ab5c968b9..4f9d06afdc38 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -250,9 +250,7 @@ struct nvme_dhchap_key *nvme_auth_transform_key(
>   	if (key->hash == 0) {
>   		key_len = nvme_auth_key_struct_size(key->len);
>   		transformed_key = kmemdup(key, key_len, GFP_KERNEL);
> -		if (!transformed_key)
> -			return ERR_PTR(-ENOMEM);
> -		return transformed_key;
> +		return transformed_key ? transformed_key : ERR_PTR(-ENOMEM);
>   	}
>   	hmac_name = nvme_auth_hmac_name(key->hash);
>   	if (!hmac_name) {
> 
> base-commit: c29901006179c4c87f9335771e50814ec5707239

