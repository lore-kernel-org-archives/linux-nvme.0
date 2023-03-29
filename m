Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CF6C74A5B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 15:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2oRJvBk1aRhWUXZpzrDEBepxU3iynjIqSJhsVPHzuxE=; b=GMFoMQv2jPjKZbJpInx/s75fol
	wszIopVBf0/PEgI+dTCfLx4vwfQoVqgC0O2ho9Ezn4XkLIjCAyWu4EDZoMIFxJA9NcxJKSzCO+qDh
	NOlMf6OesWkYk3oqb4o2SKxjqbY+2GghCFMvZzSMJlPpIpS+vmTMZpD/CCLbeIzZXCh2Oj+QXUIDx
	xJvGOreezGKfKgnMRpTzJsIb698NqPPcpj4UztdkzNWs9KUrxoAoJ5fLr48FRvuAZvRAxPkMUrrff
	X83/NB3yyPwzxTfHU6/O8RjTS2WdN6axHz14oyfs+D2qzvHWrBtlHiyx8iux5ORiiZMBeGoLH0UJv
	eqgJy/7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phXrq-000oqp-2B;
	Wed, 29 Mar 2023 15:37:42 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phXrn-000opc-39
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 15:37:41 +0000
Received: by mail-wm1-f50.google.com with SMTP id p34so9195940wms.3
        for <linux-nvme@lists.infradead.org>; Wed, 29 Mar 2023 08:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2oRJvBk1aRhWUXZpzrDEBepxU3iynjIqSJhsVPHzuxE=;
        b=xseLB+pV+Nyprh3aWG4DJOGEyU4RkNoS3BOVsWqmMaetQYRFdsVNeREFS4ZTuaaT3A
         xmhH56G2jbb1YZSsjKjuJxsF2h8WyFSFWXc3JiZEJ3AfUwvf9ADiaqkIk6pxH6YJSXRX
         iJU5Z3CiSSeh+EFz7+9cIHokLZdKMYpCgk3oLVnJuH7E3SnTZOy848WGJZNzusqKk8Q9
         SAjcz0q5V/2DRqkHTnxUKJet/LTk5J8+f9mSJPSIYQPhRGQywKx4ZZyDPbXkv6VrfAAr
         ys7qd9Xu51AZoVc4MaQk6imRnEZOmbYvSZG5lQdEiaoPMoxB2ynDlgcmopE/EFGDHjx5
         jyyA==
X-Gm-Message-State: AO0yUKXVWxHMSdXr/pnGQySXR0eA7Jac9eHHwL6uGLcK7xhkty0dsbj/
	a7wnpl8RKd3vYHjEPv4hanM=
X-Google-Smtp-Source: AK7set9DJD5O37K3/4K5wCZSeXkekmic0BIeRAkHgwFejMT0MDC/1ZUnqIK9AJXT5CCQVsyw/1afcA==
X-Received: by 2002:a05:600c:1e86:b0:3ed:ebcb:e2c6 with SMTP id be6-20020a05600c1e8600b003edebcbe2c6mr16453850wmb.3.1680104257151;
        Wed, 29 Mar 2023 08:37:37 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v26-20020a05600c215a00b003ed2433aa4asm2535844wml.41.2023.03.29.08.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 08:37:36 -0700 (PDT)
Message-ID: <d177a5d6-3f76-4eee-0cc5-2c6d995c2e8a@grimberg.me>
Date: Wed, 29 Mar 2023 18:37:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 05/18] net/tls: implement ->read_sock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chuck Lever <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230329135938.46905-1-hare@suse.de>
 <20230329135938.46905-6-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230329135938.46905-6-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_083740_010142_AC697C34 
X-CRM114-Status: UNSURE (   8.29  )
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


> Implement ->read_sock() function for use with nvme-tcp.

Nice.

> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Cc: Boris Pismenny <boris.pismenny@gmail.com>

Would be great to see a tls_device implementation as well.

