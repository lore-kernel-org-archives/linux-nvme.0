Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3875C36002
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 21:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gx31Xuauv5lcovVQ5lpjl/sztBs81A6P9TQ0U/Jv4XM=; b=gyM6gO7tx61bDagEPF3yXO5LQq
	dAh3pupKv+bcrNw4468hfPODnDK/HvEq2IReH3ZNtZNdVDa5Wl9BlG9a+vK7WkfIrigoS4bWCqBSN
	J1XWr8D0u3lGlJbaWOcBtEZaXnLlp+IqmGJ4BqyaMKsC6Oyr2yL0PNPrDw+/VZteeprAcBgCVI99Q
	nZEChz28i7Q0Ltct8yIYnx4TDk6Gb+kMClrqegxw97xiG/k021jKE5wLpS524vjCBB4hD4MqoXVox
	apIMI0kJE1BkD0Y39JcfU59y/j3xnqnVTr4gO9Xmc0JL5cSRpKnr61U+j/W9Gl5aKMqj6r3yb6xLV
	Y7skuDaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twoyB-00000004GFu-3guR;
	Mon, 24 Mar 2025 21:04:27 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twoy9-00000004GEO-3Kmx
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 21:04:27 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3912baafc58so3862226f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Mar 2025 14:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742850264; x=1743455064; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gx31Xuauv5lcovVQ5lpjl/sztBs81A6P9TQ0U/Jv4XM=;
        b=bKMlINjH52KlISXxjIZccjolckR2t/RjvXO0D30XCRcroWpnu7rxqG/onHoWkykMd8
         jfJ+bbLN5C1MntEqt1nLiLkmMbAQjRJzzssmxMTr6kk5L1J+b0Y3+nh6PJFZTm3Fdugd
         5ANFxnmTw6CWjhjUjEKy3Gybv1jThHeyZvJly+/n6042R8k1ze2LLFT+w8LF2owbZ85v
         KPzLnUZ4SfrgAH1HmImqAqXIgxho3cZmE51IJ1Aes0jws0rAmPMPkP2/KjT4TG5rJtEK
         YSSNfhHyB2qrv7/s8f/lDp+zDzwtvSke6m47NhZ4yBTAtZqZDo8gtGG1Szh66AIKC4xS
         WPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742850264; x=1743455064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gx31Xuauv5lcovVQ5lpjl/sztBs81A6P9TQ0U/Jv4XM=;
        b=g7BfroslZAYRk95pgv8YTOlnZPj4lNZnIjYkjvN7U8A45rwIQcuONyJ4zmIdDWCBMk
         UpN23WNm5aUdGagHK1UHuMIIbh0lt6G5dK81yWLsniWnUWlESNfqvDVz5Riy6V3lMor6
         M43qa84GLAG9UE7M3ls0mzXx+xacaEWaNinoh5qB7V2miuScGHAJ6iZqr4yc0I4F2o4q
         +noVLRBsXC6SspJ/TK8fPYL9sQVKgKKRNQxer7/+mSOKqzxXWfLJa5KIo3TZTFoTEr+r
         YLtwIjSvq0ukhVnL1vEChn6y6bAUYtVWyhX+4OQiQ2tn31YliG6Dv3obIJCEFp87vF/j
         DouA==
X-Forwarded-Encrypted: i=1; AJvYcCW91v7ssi2nde1GTy/ArGa8AagK2eAcYS3CTNUOBKhD8YHxo9z/rEiZq0nmA/az6IYm0bbVKhnh4zEA@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2AChV6zci6692xpC4n0PjRYL35RUzVGUVtLR+RJY1QAHZeU9x
	WkEWiOAlPW7fs7Km+AyhkLNnttr+xVoBPaWKqSLH3oRAPOcHmNz/
X-Gm-Gg: ASbGncvT3+dqog8u89/g1D1pDemPlhhbKDY8BZMT/WZxxVbbKz9Kh8A1WwH492ci3pM
	ad8P1aBPIlIbE6oTCSrhYbHqWuoLqP0toXHmWguWBa1l03hfX/15+OH/xfKEc3DyJAbK+nwH+CL
	osz9Fz6jRt18u6L0GwFWIfCoIIhLUmztYt1ibr0xpywOz+3BuR3ObNDbDozAf1hVdjJlUm5ufM/
	fRtJ2FdEgpZwbfb9mrasdprGubsrMYZCBYfB4QtUfP2wpo0/modP9fq6Zq0esyzIeDFIKJHxUZz
	jaqrTYLEvtlI8kMPcStF+AqfNW1pu1IuXotZP+Npe7IMZH9WFqO1eP3hYFLBURWQzItnw/1d9ox
	w+W1llns=
X-Google-Smtp-Source: AGHT+IG2bGELzVJtzL6ZA05ImdjYkIcn3Fz+Pgv8cOihRj5p03OjBONfcto0Y2QnYq7gotvv/mShbQ==
X-Received: by 2002:a05:6000:4187:b0:390:dfa1:3448 with SMTP id ffacd0b85a97d-3997f938a97mr8491408f8f.43.1742850263373;
        Mon, 24 Mar 2025 14:04:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3f81sm12132016f8f.35.2025.03.24.14.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:04:22 -0700 (PDT)
Date: Mon, 24 Mar 2025 21:04:21 +0000
From: David Laight <david.laight.linux@gmail.com>
To: shaopeijie@cestc.cn
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 zhang.guanghui@cestc.cn, gechangzhong@cestc.cn
Subject: Re: [PATCH] nvmet: Replace sock_create with sock_create_kern
Message-ID: <20250324210421.526c1729@pumpkin>
In-Reply-To: <20250324031708.1687164-1-shaopeijie@cestc.cn>
References: <20250324031708.1687164-1-shaopeijie@cestc.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_140425_835694_99A0C278 
X-CRM114-Status: GOOD (  17.36  )
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

On Mon, 24 Mar 2025 11:17:08 +0800
shaopeijie@cestc.cn wrote:

> From: Peijie Shao <shaopeijie@cestc.cn>
> 
> Replacing sock_create() with sock_create_kern()
> changes the socket object's label to kernel_t,
> thereby bypassing unnecessary SELinux permission
> checks. It also helps to avoid copy and paste bugs.

Does sock_create_kern() hold a reference on the namespace?
It hadn't used to and sock_create() will take one.

	David

> 
> Signed-off-by: Peijie Shao <shaopeijie@cestc.cn>
> ---
>  drivers/nvme/target/tcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 4f9cac8a5abe..216afacc8179 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -2049,7 +2049,8 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
>  	if (port->nport->inline_data_size < 0)
>  		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
>  
> -	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
> +	ret = sock_create_kern(current->nsproxy->net_ns,
> +				port->addr.ss_family, SOCK_STREAM,
>  				IPPROTO_TCP, &port->sock);
>  	if (ret) {
>  		pr_err("failed to create a socket\n");


