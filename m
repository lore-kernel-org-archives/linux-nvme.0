Return-Path: <SRS0=G3e6=FS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A234C4361B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Dec 2020 06:38:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82ACC22583
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Dec 2020 06:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82ACC22583
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EyYLtXmDRkFzenWU3IM6QKr6sytUmoAR7KlC0YW5XpU=; b=vexV+kVnNmmo2g2S4YIuFucC9
	uS/e2M/c83rjlUXWvIRdj/cTHwQHO2AR3KG2SdPo+lwKAJ7WdH0bO9xqYiLuKKcf7Xo57G9HCIv5L
	Ra3lR/Zqn7EkoQRKCEUtL7/Pmtx4w1PJ2axmNeu0AzIBlGl63iaEnD43GSNnLFDtgX0ATrO8gWjTH
	B4XDAIDT67QlCYFBz8jbC7oWmT+dYLbOi6dXsu2m9GiW1VcpTgplNqL0XyyDh73NXCTtb2u0Nnw92
	YIXGJ2xKRYPY9lg+zWfYldCCri8C87UMAMvReReZ/6iZuWDjJql1dZByFLPiwOxzAhFCJPd5GJSDi
	2doWYXw3A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kohV4-0007Zj-GV; Mon, 14 Dec 2020 06:38:26 +0000
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kohUy-0007ZJ-1e
 for linux-nvme@lists.infradead.org; Mon, 14 Dec 2020 06:38:20 +0000
Received: by mail-ej1-x641.google.com with SMTP id w1so16309657ejf.11
 for <linux-nvme@lists.infradead.org>; Sun, 13 Dec 2020 22:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aOHfkm0teAcnfRNG4mO8qFxgF/Cu1iIFNonJtBdSO2U=;
 b=BqARR727KmD+lU7B5EuZO7ICDgpOZbXaKDosuAm8eRYvCyDRbSWpuJnMprO0gzjkyj
 xyGSQdoZBajDOQPTH8l4wvvLw1FYea9X4G5W/mmZHjvEM1GJ/doTerdozwunzA62Bvo+
 rimOM7lZC+18I5YjWKt+NICD2brqQd7LlUR0G9ufKkx1WVxfMRiWR0aOpTv5cUh3Bxcu
 sa2dJmyoIay302Sh+jGjXrOAZJSbtpyUyCcoS7TyfhKHMetmPeWNlkkLwWWFtXtMMvH1
 PW4S69sLu4cakpz4F/GY/Nl8/8dtHmISThFRHh8LMkXCljCTLxf9QXZJq0GNrcJzIfIQ
 nXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aOHfkm0teAcnfRNG4mO8qFxgF/Cu1iIFNonJtBdSO2U=;
 b=RStlT/n4IxkALxCMZ/G3l601iDAFQIomByBlewVrJZyoVhHcOjueF73CCLtxDIUEn1
 3uAOBSQXpZnWtMIg8C3yqlLRUChob7gfIsIJcA4duVuLHe1SS0rAZdrfSP6Ms61uhlYj
 aG9zbEeoXTa8XFoiGnGLv45i/dDR35FiT9YTLCsy2aogoKd19AM2xLD0lU9loFeuXsRO
 xwp0UHDz4qQ399JP5odZ9env2MwrfNVAhUEMqvhuRwlVVXgE8JOmRFhcmgZsfE5jPVtY
 PoZ5QZ6qNe4CjVMFXL/rumVjiMrLX2KKDEaq/y1V33elHilp0qYfJC0EtkydkH4Tdl8T
 WbsA==
X-Gm-Message-State: AOAM532NrTDH6uIXM2Cj7SKR+rhoGZU/UvWyVLQcZpG0RkIT4PWYEBGV
 WXvhBQWH6VXoLalCEMCdTDo=
X-Google-Smtp-Source: ABdhPJyxpmDnVB7y0lo7iNWp+ekNybe8pS6suLmdxh4aWjTkORzRnfvp67TYc+FBlMfLwCSAgX1FSg==
X-Received: by 2002:a17:906:234d:: with SMTP id
 m13mr21439016eja.270.1607927897498; 
 Sun, 13 Dec 2020 22:38:17 -0800 (PST)
Received: from [132.68.43.153] ([132.68.43.153])
 by smtp.gmail.com with ESMTPSA id d3sm11042141edt.32.2020.12.13.22.38.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Dec 2020 22:38:15 -0800 (PST)
Subject: Re: [PATCH v1 net-next 05/15] nvme-tcp: Add DDP offload control path
To: Shai Malin <smalin@marvell.com>, Boris Pismenny <borisp@mellanox.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "saeedm@nvidia.com" <saeedm@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "axboe@fb.com" <axboe@fb.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "edumazet@google.com" <edumazet@google.com>
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-6-borisp@mellanox.com>
 <PH0PR18MB3845486FF240614CA08E7B4CCCCB0@PH0PR18MB3845.namprd18.prod.outlook.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <0a272589-940c-6488-9cb9-1833400f38b3@gmail.com>
Date: Mon, 14 Dec 2020 08:38:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <PH0PR18MB3845486FF240614CA08E7B4CCCCB0@PH0PR18MB3845.namprd18.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201214_013820_170096_5A1C6A1F 
X-CRM114-Status: GOOD (  17.67  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Ariel Elior <aelior@marvell.com>,
 Ben Ben-Ishay <benishay@mellanox.com>, Michal Kalderon <mkalderon@marvell.com>,
 "boris.pismenny@gmail.com" <boris.pismenny@gmail.com>,
 "yorayz@nvidia.com" <yorayz@nvidia.com>,
 "malin1024@gmail.com" <malin1024@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "benishay@nvidia.com" <benishay@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Or Gerlitz <ogerlitz@mellanox.com>,
 "ogerlitz@nvidia.com" <ogerlitz@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 10/12/2020 19:15, Shai Malin wrote:
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c index c0c33320fe65..ef96e4a02bbd 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -14,6 +14,7 @@
>  #include <linux/blk-mq.h>
>  #include <crypto/hash.h>
>  #include <net/busy_poll.h>
> +#include <net/tcp_ddp.h>
>  
>  #include "nvme.h"
>  #include "fabrics.h"
> @@ -62,6 +63,7 @@ enum nvme_tcp_queue_flags {
>  	NVME_TCP_Q_ALLOCATED	= 0,
>  	NVME_TCP_Q_LIVE		= 1,
>  	NVME_TCP_Q_POLLING	= 2,
> +	NVME_TCP_Q_OFFLOADS     = 3,
>  };
> 
> The same comment from the previous version - we are concerned that perhaps 
> the generic term "offload" for both the transport type (for the Marvell work) 
> and for the DDP and CRC offload queue (for the Mellanox work) may be 
> misleading and confusing to developers and to users.
> 
> As suggested by Sagi, we can call this NVME_TCP_Q_DDP. 
> 

While I don't mind changing the naming here. I wonder  why not call the
toe you use TOE and not TCP_OFFLOAD, and then offload is free for this?

Moreover, the most common use of offload in the kernel is for partial offloads
like this one, and not for full offloads (such as toe).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
