Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1479CC4345F
	for <linux-nvme@archiver.kernel.org>; Sun,  5 May 2024 13:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rrvLtBRdnyfwU9aizs+Isfc/56udF0KdsdKfdXm0Bhs=; b=NHQR8SA0x5jscW+HXrZncBWKtd
	sU377Q+JvgBuDAJmYdD0JlYfWWT/ngsnyh3qxxDgia7AVSj0H45vEqdqjQbe77JhYQpdgWUnR/1l9
	5tkY9qniuQbX4xjESz3uMe/Vupx7JS9qvjEBjBLyewQzCcNCvJf6X1K1cblzOu5BY9QwNVcCnW+3K
	oPHYHUvNxTyAjrkCPLAv5g9/1g5VGEq2allWc+zL2VBBJdvLV/3hoapTMjEdd8IDDNITIVzL0Of5Z
	1RuDkfKTAYrkfOaTRjZFwQLd07yPkuR2yrO8PL7ABXnmwMIH9++D7AoDxSzLFKGnXZiMINNZo4j5g
	RJ3Ib9qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3cCl-00000004NgM-0R5c;
	Sun, 05 May 2024 13:47:03 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s3cCh-00000004NeL-2BmK
	for linux-nvme@lists.infradead.org;
	Sun, 05 May 2024 13:47:01 +0000
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34aa836b948so288429f8f.3
        for <linux-nvme@lists.infradead.org>; Sun, 05 May 2024 06:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714916809; x=1715521609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rrvLtBRdnyfwU9aizs+Isfc/56udF0KdsdKfdXm0Bhs=;
        b=ZnlTC5sey3oqieHyQNnukz+cLreyVm9tJcJpu/594rjHbgpFdjga0AQ7V/d7npxVlw
         W9Lbfu0155S6ha4u2RWiPoGK5MQhat1gZJX+Dpx1qPy0SbT63r99os3OtJ5eohVgyWxn
         7MODtK5Vku17Oq4Gq5NO6Pr1FtEom1jTDr7y/zAXk5uYsYtu33nY6kXXE6hPjMHZKTcm
         3Wq93ZJ++TOy7iyND3QdaMgodSvVwQqEdtmaDwThrp8ahiWu6IBe1gVQ9muUWh1+SRkS
         aNVq6n+luRHGJdnxhY2XErdeQGXc1e+vOidCUO1FygF2FKfPrTFG3Wj+Y2a4IghsZN5/
         lKNg==
X-Forwarded-Encrypted: i=1; AJvYcCX/l5GnqywHn4pBnPJZrOBH8qI38FGPGh3nKovOUIoEPW0rYIYbkOkYc1W1DwqQ3IS+eEseEBXUyruDhrJ5cS6U8h2uuJLLf+ets925V+I=
X-Gm-Message-State: AOJu0YyVEW44z0VrL1hgCIEGxbGlh20zhjIC0IVTJf5HAwo6eJ174AJH
	zB/g2uyuXWtPjYw97zHKtLCdzJRtTCce/OxUMTq76c9UBxFACeS24/zzMg==
X-Google-Smtp-Source: AGHT+IFcyjV0i07knOXTL/KiKzZsxlxXwrRAXf897GllIPvrORf9Y0FykOTysXoE1+tV6PtzzynMRg==
X-Received: by 2002:a05:600c:a44:b0:41b:fdf9:98b5 with SMTP id c4-20020a05600c0a4400b0041bfdf998b5mr5635724wmq.4.1714916809267;
        Sun, 05 May 2024 06:46:49 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c358800b0041a1fee2854sm16336932wmq.17.2024.05.05.06.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 06:46:48 -0700 (PDT)
Message-ID: <cb2c0d9a-7f45-44d0-bb4d-e074870966f2@grimberg.me>
Date: Sun, 5 May 2024 16:46:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-rdma, nvme-tcp: include max reconnects for failed
 reconnect logging
To: Tokunori Ikegami <ikegami.t@gmail.com>, linux-nvme@lists.infradead.org
References: <20240505120324.20858-1-ikegami.t@gmail.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240505120324.20858-1-ikegami.t@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240505_064659_599374_95ABE939 
X-CRM114-Status: UNSURE (   5.36  )
X-CRM114-Notice: Please train this message.
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

>   requeue:
> -	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
> -			ctrl->ctrl.nr_reconnects);
> +	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d of %d\n",
> +		 ctrl->ctrl.nr_reconnects, ctrl->ctrl.opts->max_reconnects);

How about we do:
"Failed reconnect attempt %d/%d\n"

And the same for the successful reconnect:
"Successfully reconnected (attempt %d/%d)\n"

