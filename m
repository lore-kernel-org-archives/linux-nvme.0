Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7E81C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SLbUWdsVkoJ7W1ID9cXPzFHB8tA7OxZfpINoAt9+e1Y=; b=orzvh6zhYTXVDqBql0NdLQwTKR
	Mwf41RBoIYKOd5g90xU6BMRgoeke4A6K6U+zFIb1nNj1sHAGaWRTqFbrUlSdn3y8pha9yju8WN3Of
	2DscizJxFCIZEax6iAgccg35F21NuEyLzRmQXFBPduqwvK5iOmNlXL1XYxkBPcXAOz9kWQeK7+zHw
	ugaYUIwuj2v3PdayWHzdkshP8XRmmlJmmwyP9FU5J7Bh0/4urC/OiHaYlg/PcYGO/gLPEjXjcthYK
	SU3rUkf0L9Ivx0dWHytfU9Sgdyl054y19Pm979DJvDHu0pWQtPZYVPdv7FIoETuF4Cf2ubOeQQYgA
	iteYpA3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pecNQ-00CbA0-2r;
	Tue, 21 Mar 2023 13:50:12 +0000
Received: from mail-ed1-f43.google.com ([209.85.208.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pecNN-00Cb8h-1M
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 13:50:10 +0000
Received: by mail-ed1-f43.google.com with SMTP id o12so59921861edb.9
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 06:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679406605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLbUWdsVkoJ7W1ID9cXPzFHB8tA7OxZfpINoAt9+e1Y=;
        b=pAA79XhgBJ0TlCpKWjpiaR1G6Vblsm1xOy1SVhSYNU4zbsfTgrLevGVwYZSf4SkbJH
         LL/af5poPUWtlSdCQFhHn4DCLQX0PR4WvASNOBguvs3DUxskCkzSBuXR1rCiifeVGpov
         Crxg+o4To4edcUsHShg9a4oB4PkYpjoX2Me1bSob5qXfLBLP+k4CWf7YuGULDFs2zCiS
         Cc9IO3aqYdd0DYfw73Ja5QosBHaZXJPLTXOWV3FOxfKpPHLuMhfAijPPiOFD9TS+B2F4
         wvs0TAWQNuBIuUeH3Q63S7VSaPkHrsyDn6mmRp8gJ+QZk5FpjzK4CLWW0N2atFH3MqqP
         XrEg==
X-Gm-Message-State: AO0yUKXG4Gam4o++e3+8X22Ux5yAMmNR+KyVLQKHp9c+Sxw+++71RMDs
	rZ/l2WTCjCTW/YXv2eLZebBLL0go/P8=
X-Google-Smtp-Source: AK7set8R4uP67AmZxemG5DllKx9Oj3m5rfKH6IRzU3rQHiFbWNkX9zQuXMiS/jWz9bJX9SRJ6dooMg==
X-Received: by 2002:a17:906:5307:b0:931:5145:c51d with SMTP id h7-20020a170906530700b009315145c51dmr2482227ejo.0.1679406605490;
        Tue, 21 Mar 2023 06:50:05 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id u8-20020a170906b10800b008c9b44b7851sm5826227ejy.182.2023.03.21.06.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 06:50:05 -0700 (PDT)
Message-ID: <08f5a168-3a15-2276-f472-dee926378e65@grimberg.me>
Date: Tue, 21 Mar 2023 15:50:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/18] nvme-keyring: register '.nvme' keyring
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <cel@kernel.org>, kernel-tls-handshake@lists.linux.dev
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321124325.77385-2-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_065009_460764_912E29C8 
X-CRM114-Status: GOOD (  25.00  )
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



On 3/21/23 14:43, Hannes Reinecke wrote:
> Register a '.nvme' keyring to hold keys for TLS and DH-HMAC-CHAP.
> We need a separate keyring as for NVMe the might not be a userspace
> process attached (eg during reconnect), and so the use of a session
> keyring or any other process-related keyrings might not be possible.

So the keys will be stored in the ring such that on any reconnect
userspace will have access to these keys? How does this affect 
dh-hmac-chap keys?

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/common/Makefile  |  2 +-
>   drivers/nvme/common/keyring.c | 36 +++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/core.c      | 10 +++++++++-
>   include/linux/nvme-keyring.h  | 12 ++++++++++++
>   4 files changed, 58 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/nvme/common/keyring.c
>   create mode 100644 include/linux/nvme-keyring.h
> 
> diff --git a/drivers/nvme/common/Makefile b/drivers/nvme/common/Makefile
> index 720c625b8a52..c4e3b312d2cc 100644
> --- a/drivers/nvme/common/Makefile
> +++ b/drivers/nvme/common/Makefile
> @@ -4,4 +4,4 @@ ccflags-y			+= -I$(src)
>   
>   obj-$(CONFIG_NVME_COMMON)	+= nvme-common.o
>   
> -nvme-common-y			+= auth.o
> +nvme-common-y			+= auth.o keyring.o
> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> new file mode 100644
> index 000000000000..3a6e8a0b38e2
> --- /dev/null
> +++ b/drivers/nvme/common/keyring.c
> @@ -0,0 +1,36 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 Hannes Reinecke, SUSE Linux
> + */
> +
> +#include <linux/module.h>
> +#include <linux/nvme.h>
> +#include <linux/seq_file.h>
> +#include <linux/key-type.h>
> +#include <keys/user-type.h>
> +
> +static struct key *nvme_keyring;
> +
> +int nvme_keyring_init(void)
> +{
> +	int err;
> +
> +	nvme_keyring = keyring_alloc(".nvme",
> +				     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
> +				     current_cred(),
> +				     (KEY_POS_ALL & ~KEY_POS_SETATTR) |
> +				     (KEY_USR_ALL & ~KEY_USR_SETATTR),
> +				     KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
> +	if (IS_ERR(nvme_keyring))
> +		return PTR_ERR(nvme_keyring);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvme_keyring_init);
> +
> +void nvme_keyring_exit(void)
> +{
> +	key_revoke(nvme_keyring);
> +	key_put(nvme_keyring);
> +}
> +EXPORT_SYMBOL_GPL(nvme_keyring_exit);
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d4be525f8100..839bc7587f54 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -25,6 +25,7 @@
>   #include "nvme.h"
>   #include "fabrics.h"
>   #include <linux/nvme-auth.h>
> +#include <linux/nvme-keyring.h>
>   
>   #define CREATE_TRACE_POINTS
>   #include "trace.h"
> @@ -5415,11 +5416,17 @@ static int __init nvme_core_init(void)
>   		goto unregister_generic_ns;
>   	}
>   
> -	result = nvme_init_auth();
> +	result = nvme_keyring_init();
>   	if (result)
>   		goto destroy_ns_chr;
> +
> +	result = nvme_init_auth();
> +	if (result)
> +		goto keyring_exit;
>   	return 0;
>   
> +keyring_exit:
> +	nvme_keyring_exit();
>   destroy_ns_chr:
>   	class_destroy(nvme_ns_chr_class);
>   unregister_generic_ns:
> @@ -5443,6 +5450,7 @@ static int __init nvme_core_init(void)
>   static void __exit nvme_core_exit(void)
>   {
>   	nvme_exit_auth();
> +	nvme_keyring_exit();
>   	class_destroy(nvme_ns_chr_class);
>   	class_destroy(nvme_subsys_class);
>   	class_destroy(nvme_class);
> diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
> new file mode 100644
> index 000000000000..a875c06cc922
> --- /dev/null
> +++ b/include/linux/nvme-keyring.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2021 Hannes Reinecke, SUSE Software Solutions
> + */
> +
> +#ifndef _NVME_KEYRING_H
> +#define _NVME_KEYRING_H
> +
> +int nvme_keyring_init(void);
> +void nvme_keyring_exit(void);
> +
> +#endif

