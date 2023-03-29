Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A373C6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 14:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RxkL036kcFDqMn3MovCPQPFhu8c5tldGj+zWJ18/JRY=; b=Inga4LRrm1QdfqbfSfBX8uFJRA
	i1HuKWvdwkwMdIulY/C1uNkhBN0A5aB24fGQspeF9fIIce+/TL3LZoMRq1SGs9+wUHFOMOIRXnC1D
	aykuhPryBpJAsScETxIGRdHkyQvXX/13l81gQ0Cnl1TjFg16fj0OJlKfRQRGMWETEjM3xEkZU7OKO
	e1dJjZkvN13mZf40rI2t+vXlS13a4jJc+832MP5N471DPxTX8RsckPKpeJdAIHg0pV7fSXWoKanjF
	1AElKnSLhnCrPTN721WvzQ6xSRxKg8nNen3rVu/hSUGYSU1J9k7yAwry7Hu9HDJMiWkwQ/p2xJn1j
	pRAkNrHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phX6q-000g4i-2y;
	Wed, 29 Mar 2023 14:49:08 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phX6n-000g3P-30
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 14:49:07 +0000
Received: by mail-wm1-f54.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso11654221wmb.0
        for <linux-nvme@lists.infradead.org>; Wed, 29 Mar 2023 07:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680101342;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxkL036kcFDqMn3MovCPQPFhu8c5tldGj+zWJ18/JRY=;
        b=WyhZn/UMgqdlUg+cpIqaf+eEPQanaMFfAeqIX/Dstv8QZ5Yr3k/SV6uNe7wSmh8L5v
         PQob3PFq4VQnX8W5Yqh15Y8AsXJXoac27wClFIuPyHluTK903CvBdQ8oH92N/GxpRLWh
         onISmKWkHRPQmUn7VgYB4J8YSQYsUdG1VmSveVgGKpT7jodDE70tKqc/87Vu0ztK8Yj8
         hwVCKrgt+XAJuC+kd26AdfEJftzukhZw1fXqWKw8pHHBs4uzoHvYtDdYc6cV18nHodwP
         cICvqpwBM+KySSPInDRGyU6EAeIXlVM2tgANGW47aAx3z5jCmz0gDBfWan1L4PM0MWlD
         Uqlw==
X-Gm-Message-State: AO0yUKUXIp0V4qZAX13jcvaEXO1Op2p9yl7efVKbxzLeiGFL1FUFtuX7
	bhbccyA6xYSX33RJS/xnM8o=
X-Google-Smtp-Source: AK7set/L7kry83fDQHx+LSN0MLhNEl+AoH9v13eokrgZpTWgLqgsUTKXYsLwtbW749lTVkM3ercUdQ==
X-Received: by 2002:a05:600c:468b:b0:3eb:f5a2:2d49 with SMTP id p11-20020a05600c468b00b003ebf5a22d49mr16354897wmo.0.1680101342429;
        Wed, 29 Mar 2023 07:49:02 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z3-20020a05600c0a0300b003ee6aa4e6a9sm2871660wmp.5.2023.03.29.07.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 07:49:02 -0700 (PDT)
Message-ID: <56ab2e76-1d5e-0002-cf23-6c7e9b82d233@grimberg.me>
Date: Wed, 29 Mar 2023 17:49:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/18] nvme-keyring: register '.nvme' keyring and add
 CONFIG_NVME_TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230329135938.46905-2-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_074905_963799_FFDF9712 
X-CRM114-Status: GOOD (  18.15  )
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


> Register a '.nvme' keyring to hold keys for TLS and DH-HMAC-CHAP and
> add a new config option NVME_TLS to enable support for NVMe-TCP/TLS.
> We need a separate keyring for NVMe as the configuration is done
> via individual commands (eg for configfs), and the usual per-session
> or per-process keyrings can't be used.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/common/Kconfig   |  9 +++++++++
>   drivers/nvme/common/Makefile  |  1 +
>   drivers/nvme/common/keyring.c | 36 +++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/core.c      | 19 +++++++++++++++---
>   include/linux/nvme-keyring.h  | 12 ++++++++++++
>   5 files changed, 74 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/nvme/common/keyring.c
>   create mode 100644 include/linux/nvme-keyring.h
> 
> diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
> index 4514f44362dd..b6fff16da1fb 100644
> --- a/drivers/nvme/common/Kconfig
> +++ b/drivers/nvme/common/Kconfig
> @@ -2,3 +2,12 @@
>   
>   config NVME_COMMON
>          tristate
> +
> +config NVME_TLS
> +	bool "NVMe/TCP TLS encryption support"
> +	depends on NVME_COMMON

depends on TLS as well? Or maybe select would be more appropriate?

> +	select KEYS
> +	help
> +	  Enables TLS encryption for NVMe/TCP using the netlink handshake API.
> +
> +	  If unsure, say N.

Would it not make sense to default it to y?

