Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23735CDB474
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 21:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=woZ/KZQPlnIyuAgXoRWnrGIgnE0ehbTdZeFjYuXTHg4=; b=caxtFafTe32GJLjBjim1ChPvhj
	+UKDlO7ZS0kDY4ed7N4lpXMArSZyv2GBnaR6z/z9LHZCEdNQj13GX7lXyeRr5kGm0tgPTp8iXemqI
	9iWFlpUILl2P2GIzBkfnSGEpcpZvQIWS2m2dyp7Uptr1ebeZG0JvGQmZMTgc4OpMKUagb6JLdDQyU
	jul+ylpJzmgtXc7LjAK2Ph82BKn13PqN6t65ure3qMSIxPW41ekEseVatFyWqq0JAlXV9COytRz0k
	AwFya/4Rm4hrONyvk4TCjS9+ki/SekU4IjMQsipRjg+9/CzksEOgjgPlgaOG6UJVZTZYMWqXuUxv8
	ge3dlL6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsrV4-00DHuB-26;
	Tue, 17 Oct 2023 21:21:14 +0000
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsrV2-00DHtj-07
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 21:21:13 +0000
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7a2874d2820so78035039f.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Oct 2023 14:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697577671; x=1698182471; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=woZ/KZQPlnIyuAgXoRWnrGIgnE0ehbTdZeFjYuXTHg4=;
        b=xiugu0dy9xuq+3cSePBc0kUf+Vpip6FcWwc4IfLmIOGbL28B8M90fh1kxG03n7CwLE
         jFd+kTaCLnTJD2R2vhgtHqwsMI8IzLwyoJ/xqkTmmklbHveEVfWrYYoIwoOnPIIhJphZ
         dkN5vZamHmpY8+k3GxULAndLIe+afwfq7L8pyLhRZiQEYOqYxHJXoyQNGXUbf/6XcNit
         2H46mu7qNtOl+kph62fucGGHE9JLagcSFxRef5Y6JGmo9JSd0aI7gd8KlmTXnSWiiZwg
         QSceSqHEZ+9BcvR/khr++nv/14b+KHFMgBgIRhOLorJfPpk4+MkuVXy1/Xh5fKylADOj
         LyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697577671; x=1698182471;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woZ/KZQPlnIyuAgXoRWnrGIgnE0ehbTdZeFjYuXTHg4=;
        b=HF2ze9f5oiJIAK4XLgTChZm9WNWDzqrqwMdQ+AA+d41B5DiMLAqCr2oGJoHwbUJvGx
         Iw3+fxK6JGoULLygnCStnXJFRXOu2uZ29wuSALFdUsWrdxe7Re7yPJyqqb3nNaooABzI
         ElFWEnohcUzV4NUFDrdjTZd9jJQiBsuOoZ9yssyRGXbkRwCFOGu5wnimvpr1P1XUH7zS
         9Wz0vJRmjYJuEMI0imh/0G7knLTyzt2/Qnzpt88AVeKsHP4Li7Lq0coQZAOXdgFUz2Hl
         UxX/Fqi2C0+chAK39f/GfH/vZghzKVnoowboFHdF/Ny9wcPZ2Ug8p+tO9WBRCVh183+2
         u+Tg==
X-Gm-Message-State: AOJu0Yzt5wsas/zp7wLG91VV9Ldn0WEDubHyZvg2rY5470hsBoeHJzjS
	sM0JgH9HQbhsDUay2qlIK5K8eq6HUYAUxZhTKzPpwg==
X-Google-Smtp-Source: AGHT+IHqrf+H2LRfDm1l4y4nqZaHpFw+1uCLCuZbWTbFfIBxtm/2Mmnvb5tNsl4gMtpIxvOtvyqY0A==
X-Received: by 2002:a05:6602:340f:b0:790:958e:a667 with SMTP id n15-20020a056602340f00b00790958ea667mr4421362ioz.2.1697577670942;
        Tue, 17 Oct 2023 14:21:10 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y3-20020a029503000000b00418a5e0e93esm743606jah.162.2023.10.17.14.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 14:21:10 -0700 (PDT)
Message-ID: <7e806e61-94d4-4756-b37d-050a8cfb04b5@kernel.dk>
Date: Tue, 17 Oct 2023 15:21:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.7
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
References: <ZS7376V7Q6-6cgxD@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZS7376V7Q6-6cgxD@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231017_142112_076720_87F049D0 
X-CRM114-Status: GOOD (  10.01  )
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

On 10/17/23 3:09 PM, Keith Busch wrote:
> The following changes since commit 5e9b7cfc209b84d135993b8cb75ea383f24b2bba:
> 
>   aoe: replace strncpy with strscpy (2023-10-03 18:23:48 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.7-2023-10-17
> 
> for you to fetch changes up to 32445526d836f827ea7e74ef933610b531d239df:
> 
>   nvme-auth: allow mixing of secret and hash lengths (2023-10-17 13:57:55 -0700)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.7
> 
>  - nvme-auth updates (Mark)
>  - nvme-tcp tls (Hannes)
>  - nvme-fc annotaions (Kees)

Pulled, thanks.

-- 
Jens Axboe


