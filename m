Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165FEC433E7
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 21:47:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5622D22203
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 21:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kWvVcmTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5622D22203
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=mMz14x8N7et9e/68ddiCWzKb4lxpdSskEqcCg289OoA=; b=kWvVcmTMuH8yoAlWdHzB+5zk7
	7ioG+KFds542KV3/REBUUvanyTnlDxEWNBN7fRkV79n07CDLnXpVXmhs0SjgqziUtORth+0Y8luto
	K6SS6Zzl1sHpp4c4YcJBbNOOS7c8ufY9lcGuEiEyIj2t9gj+hWWx04uWDdaQEjXzoZ/qYyKiT0QGt
	fXv4fvOCyn4S3zxRryA62+lwxLtxcNwjpHZ3EHbd2NFp++6Eaz8u1LwMEcyrydUXgoCvnQIPlqgpP
	uSk/LSYkz4ecuySrQnh7ScMO4fNtvpe+1J7NMHKOcp5wNWU/j2IV/d9dQT2un3o2L99LGi5yuEVf+
	pOapGhYcw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQdkt-00088h-3N; Thu, 08 Oct 2020 21:47:19 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQdkq-00087c-Cz
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 21:47:17 +0000
Received: by mail-wm1-f67.google.com with SMTP id e2so7945777wme.1
 for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2020 14:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4B4g5hnbYWCHTDGBt86zrmzrjJpiFz12L3VKQD20aX8=;
 b=cTE/aTlzBbPsZqVaTSvw5ZzXNFb011C5/uDyCHPZvsNSZE19ZjR2pElG9SQBn4tKjx
 4sUH3EMt83cFkQbWzcHpXnmTOH38blMU1TZMCj16waEkMq28R/9Pd21ga/32rXt8ZVdk
 DmCWlLJ7ziOxsUoFghRNsBDlj4NTKhbuHlMQDKlT8rRmL9cw+x7Jj9rIulRYkd8GYD8T
 YKhk4dbokL8h9fFKrvLELDVscCtxQxYkVGT32FGWDdcEcRSgGGmrZgRkHzW4qYgPSAHc
 K1s+xuGG1S4E4uu83jMuoiJBsdhiXRWSn8UeOnTrXf31aLxaBzqROR6NFHnNQUMtGTDB
 wx3g==
X-Gm-Message-State: AOAM533+UyteVxauCXUQijW48+OCxTmrKgQN8FkhSKbzX5uYGqT3VoRb
 MsqlGTcH3R+GoJB+CQ35/EJ+pNS1pvs=
X-Google-Smtp-Source: ABdhPJweb0AWlp+iJvel5XjIhpIx9b7T7KLxeoFA3eZ14P9KaeqhKR+LY6wZnxr/eyncYTZCUlNwMA==
X-Received: by 2002:a1c:ed09:: with SMTP id l9mr11026420wmh.89.1602193634896; 
 Thu, 08 Oct 2020 14:47:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:68d6:3fd5:5a8b:9959?
 ([2601:647:4802:9070:68d6:3fd5:5a8b:9959])
 by smtp.gmail.com with ESMTPSA id c132sm8810656wmf.25.2020.10.08.14.47.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 14:47:14 -0700 (PDT)
Subject: Re: [PATCH net-next RFC v1 02/10] net: Introduce direct data
 placement tcp offload
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-3-borisp@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ab791897-6398-f38e-c2a6-f54c5ca5e1c5@grimberg.me>
Date: Thu, 8 Oct 2020 14:47:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930162010.21610-3-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_174716_465647_E4FCB666 
X-CRM114-Status: GOOD (  14.63  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Ben Ben-Ishay <benishay@mellanox.com>,
 boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> + * tcp_ddp.h
> + *	Author:	Boris Pismenny <borisp@mellanox.com>
> + *	Copyright (C) 2020 Mellanox Technologies.
> + */
> +#ifndef _TCP_DDP_H
> +#define _TCP_DDP_H
> +
> +#include <linux/blkdev.h>

Why is blkdev.h needed?

> +#include <linux/netdevice.h>
> +#include <net/inet_connection_sock.h>
> +#include <net/sock.h>
> +
> +/* limits returned by the offload driver, zero means don't care */
> +struct tcp_ddp_limits {
> +	int	 max_ddp_sgl_len;
> +};
> +
> +enum tcp_ddp_type {
> +	TCP_DDP_NVME = 1,
> +};
> +
> +struct tcp_ddp_config {
> +	enum tcp_ddp_type    type;
> +	unsigned char        buf[];

A little kdoc may help here as its not exactly clear what is
buf used for (at this point at least)...

> +};
> +
> +struct nvme_tcp_config {

struct nvme_tcp_ddp_config

> +	struct tcp_ddp_config   cfg;
> +
> +	u16			pfv;
> +	u8			cpda;
> +	u8			dgst;
> +	int			queue_size;
> +	int			queue_id;
> +	int			io_cpu;
> +};
> +

Other than that this looks good to me.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
