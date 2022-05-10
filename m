Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8076C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 18:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MfIWWmfaqB/x1V6jdydJXmcwxXWdReNqnTvC1YlvmMM=; b=1Lahg75DT7DHCHFcIDrXkNXgas
	uCTJVxJiehGx06yOLIWgW5Z3UKlBVQFbwnZzWiirdPc/XDxVLU006f1sc2z8uH/tLSN4jJHU2nztc
	HdoED6ZrKmguzogSeriHfYpilQbsaEKyZVT5/0ROHD/T0MmuAhvysYtrKRyZbhuWsHWV9jqeiFpZO
	KEQwyZHn5Znig181fCYlgdTRwYc6/MDt+UbaBQcLUcVy8wYxmjoo1pBeRxwG2h83FwJAupEzG+dPT
	ryjnke6poH0Ta3ZL8LfAYBaniswibXiFfoxOsv3EfuUEg7b3Tz20kdfTwPWvJGGRb5RC0F37o1HD9
	muJmLNUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noUpA-003h87-LC; Tue, 10 May 2022 18:43:08 +0000
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noUp7-003h6G-Kn
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 18:43:07 +0000
Received: by mail-pj1-f41.google.com with SMTP id
 t11-20020a17090ad50b00b001d95bf21996so2734350pju.2
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 11:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=MfIWWmfaqB/x1V6jdydJXmcwxXWdReNqnTvC1YlvmMM=;
 b=FHsuYe/Du1fcHWD0itfYB6YCphc/X9lMZpzXWTym60v26vrgmQGKQr5MLvit8b3cZv
 P+6AU1mdWqyA/1PMOvrRH+RGrg2SOaV5NepboY34WVgj9qboq2aQVILM2nhmYK17Cgcp
 C0Os80jbmG6MJ4mgoxNch+0gcnnzouEadPwoU+IlOoIzR4si5wf+fmYVu1WGbossz36U
 Hbfvn1l+RjXw5seuZh4K5+I+qWcct/4OhwtxP1k+YMwzRlhJ/L9sf3r99OmbMGT5osMU
 iR3w24SXyiBcH1qDdFcTGJIhqPs2b1Njtr9KwUGgXp24OfzWmQpaNaZwoCWpCnWWftdU
 5vpg==
X-Gm-Message-State: AOAM530JEWMCS0gFVHP9OrDuZM5StWjZPD/iwsKu0vxLbjuJzQHu9PoO
 Fp9+nccOYQnRillIAOGZHvQ=
X-Google-Smtp-Source: ABdhPJzQSOXT9K/U5rAnW/FeBHh7GsCHJbU4wK50odbrP6toqip4lfup7haYHqwgT3Q7U+ZB+L/QYg==
X-Received: by 2002:a17:90b:314c:b0:1dc:767d:a7d9 with SMTP id
 ip12-20020a17090b314c00b001dc767da7d9mr1225560pjb.99.1652208183506; 
 Tue, 10 May 2022 11:43:03 -0700 (PDT)
Received: from [172.16.228.60] ([65.122.177.243])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a65564d000000b003c66480613esm37290pgs.80.2022.05.10.11.43.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 May 2022 11:43:03 -0700 (PDT)
Message-ID: <21c3b2b9-3d66-66cc-2216-d027f4b0885f@grimberg.me>
Date: Tue, 10 May 2022 11:43:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] nvmet: include all configured ports in the discovery
 log page
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20220420092730.35101-1-hare@suse.de>
 <20220420092730.35101-4-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220420092730.35101-4-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_114305_728874_DEFEF66E 
X-CRM114-Status: GOOD (  26.30  )
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



On 4/20/22 12:27, Hannes Reinecke wrote:
> When a per-port discovery subsystem is used we should include
> all configured ports in the discovery log page, not just that one
> through which the controller was connected.
> 
> - /
>    o- ports
>    | o- 1 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=8009]
>    | | o- subsystems
>    | |   o- nqn.discovery
>    | o- 2 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=4420]
>    | | o- subsystems
>    | |   o- nqn.discovery
>    | |   o- nqn.io-1
>    | o- 3 .. [trtype=tcp, traddr=127.0.0.1, trsvcid=4421]
>    |   o- subsystems
>    |     o- nqn.io-2
>    o- subsystems
>      o- nqn.discovery
>      o- nqn.io-1
>      | o- namespaces
>      o- nqn.io-2
>        o- namespaces
> 
> A discovery on port 8009 will return information about
> - nqn.discovery at port 8009
> - nqn.discovery at port 4420
> - nqn.io-1 at port 4420
> A discovery on port 4420 will return the same information.
> A discovery on port 4421 will return information about
> - standard discovery subsystem on port 4421
> - nqn.io-2 on port 4421
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/target/discovery.c | 53 +++++++++++++++++++++++++++------
>   1 file changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
> index 6b8aa6c4e752..ea8fce538342 100644
> --- a/drivers/nvme/target/discovery.c
> +++ b/drivers/nvme/target/discovery.c
> @@ -149,6 +149,30 @@ static void nvmet_set_disc_traddr(struct nvmet_req *req, struct nvmet_port *port
>   		memcpy(traddr, port->disc_addr.traddr, NVMF_TRADDR_SIZE);
>   }
>   
> +/*
> + * discovery_port_match - filter eligible ports for discovery log page
> + *
> + * If the port through which the controller is connected has no discovery
> + * subsystem linked, use the original behaviour of just including information
> + * about that port in the discovery log page.
> + * Otherwise include information about all ports into which the specified
> + * discovery subsystem is linked.
> + */
> +
> +static bool discovery_port_match(struct nvmet_req *req, struct nvmet_port *r)
> +{
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +
> +	if (!req->port->disc_subsys) {
> +		if (r != req->port)
> +			return false;
> +	} else {
> +		if (ctrl->subsys != r->disc_subsys)
> +			return false;

What is this condition for? What is this filtering out?

