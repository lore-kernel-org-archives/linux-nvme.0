Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CCEE77188
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 22:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xXjl6NCzU8/+xWbSe1BvO+853drIOE1thrgjt8mYZ88=; b=fcEBe5CK7FslKywBy6Be6a3zv7
	nMc4MgJzxd4KzIteanL0IZizvrlKPFHhY2jdZlTsENMzZr0K/V6CVmG0TSC1ET06eHO+R3/s5xnLU
	k+ru7gaq1ccBWHm7QdRbTGfl00vVGB1QT+xIqukwY2azyPY531YrSSJntuYQDzSzNQKd2QrMBGpQt
	gZSNF3xnfoS+xgXBWuH+6aWzZ/fI7FZjT3etU7cTf+jCcJ6r6tm4soWlQ8acQgxk0C0H0FshqJ/PL
	zWt4/Jbv8bOO7NC1sOssMBlakg4Ns/7LqMc9GvjNp24wMGCO5CWIbQz1xdmqJDz1g0AqUrOTmSGaJ
	4lM9hU3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWNnY-0000000HB6Q-0RVo;
	Fri, 10 Jan 2025 22:48:12 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWNnU-0000000HB5L-2qcK
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 22:48:10 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385deda28b3so1543223f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 10 Jan 2025 14:48:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549286; x=1737154086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xXjl6NCzU8/+xWbSe1BvO+853drIOE1thrgjt8mYZ88=;
        b=FXZQJUKkFTe9GUbw3cifB3sgtwCcGMRqNLrU1lPQuvQykYQF3MAzdyysJ7V1qE8M9U
         34fkNFiHXaobu4LH2oYoQfGYmODbJzG3doU6jpRiwzXgk7CwVz4bm0mezx6vdcYC8IxR
         9G4tqpGumI4wxIHPzYuV/gXBPyHsehAdKlsg9yDoQATxzPLCMt51EVsYnSvRQVOHLp8l
         wG+cb9PXI6q9FRQbbKnso/MHbTbq/f3SezC3BkQdIx11Xi+UU5rHuCijs25R6+r8fYkd
         rQfAM7mdBWgPYMV/YuG1zUiMeaKzwUnrf+flo05Is/0PGSqNXNiMmJgolsk5K7BAbbTo
         KWNA==
X-Forwarded-Encrypted: i=1; AJvYcCWY99+whRW+NfcVsYUJu7eAhqnPYLAND7OiG0bbCu7h2wcJjUWsrNeqXZFoGQ4YUTwvbkwe6RE7R2vG@lists.infradead.org
X-Gm-Message-State: AOJu0Yz2Mw6Gm8JRRM+zpJeLpeUyEjCQWFGbN5V6MphxxK0rPrc86Udm
	1PbeoC72Ajg1Q/FgBVc7RqYtXvsRZ5TW1m2x0ApVYKbYddnjtlv0
X-Gm-Gg: ASbGncucBDskC+hPPjBiQZTjkkqGDIRi+SmeqHTbGpwDBQjBKBvY1fUU23UjUvdcImj
	DR3ezyzMewlUrxPTIW2M3NBUuegYilB2wrYsKuEMxYvjZp4VJ85qUmYx5jnsYHcOOZJ5pcKn7fV
	1bK3Ac8fU08ep9Eip+4bPBl6BCx2FOSqNinl9eGeugKUh5wOZwvHRMKkaadd0wQKUUnNcCdyV9r
	fX+DRKkpod1Nx+wvc2YK176KHKpgHsyo+GZnOv1dLKEeL7pwlOjkGRL2bnFZkgab7k0S3CWeNEe
	V78kq0a79iJtgsg8
X-Google-Smtp-Source: AGHT+IGYc8N/gcAP7PnuG/j0DKc1eirLxpiAJeO7d9uBE4KJoxK4qn5nWuj1er+xJFjeY/xE0Ba/fQ==
X-Received: by 2002:a05:6000:4020:b0:385:e3c1:50d5 with SMTP id ffacd0b85a97d-38a87338fa8mr12493719f8f.48.1736549286332;
        Fri, 10 Jan 2025 14:48:06 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e92f60sm99071155e9.40.2025.01.10.14.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 14:48:05 -0800 (PST)
Message-ID: <271ee0a1-431e-483d-80b1-72405b0728cc@grimberg.me>
Date: Sat, 11 Jan 2025 00:48:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-tcp: initialize the mq_map to NULL
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, kernel test robot <lkp@intel.com>
References: <20250109063043.95996-1-kch@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250109063043.95996-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_144808_727998_6B317CBF 
X-CRM114-Status: UNSURE (   8.93  )
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




On 09/01/2025 8:30, Chaitanya Kulkarni wrote:
> Initialize the local variable mq_map to NULL to remove the kernel
> test robot warning.
>
> drivers/nvme/host/tcp.c:1594:13: warning: variable 'mq_map' is used
> uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>
> Fixes: bd0f5c103101 ("nvme-tcp: Fix I/O queue cpu spreading for multiple controllers")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202501091328.r4kJ6xhy-lkp@intel.com/
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

We should probably just fold both this and the next one to the original 
patch.

