Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16C6C02195
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k7uWWyPg0R03bjdST5Zc2dUNM9r9KX+8pTGH8E/driU=; b=wnAu9oocgTMGKttd/tEVQK3BKM
	aBQ+vMaIvnp9kUc53Mg6cBWezRWnh0FrjH61RMDJ+WAlVBvuGgcHc8IJCnrFGwnfyczT/BLCWjN6I
	1drFJD8K8pw16YugEqU7PMQTplndTnZIOqjHL1lObWc94NH+tmFqKNC6wx92/+QQlSS/t5Ps+YCYn
	6IQQIwaWgsi5HyZ3ljYrWvYmAP5K0VVD0MnnKtoWHn9ZIDC/uLvS4jqJTjrsj6u+l5ULE+HhXDWzE
	g1SgcfRVdpZcVE4OQOirHWnDiSZlLCgPRotVL/yfeNdpEXZBDC1iVeieitJLaX8uDTdX8mD69ntND
	6qJudhVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tezB6-0000000FyUz-2BZ2;
	Mon, 03 Feb 2025 16:20:04 +0000
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tezAp-0000000FySV-0Lc0
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 16:19:48 +0000
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3a7dd54af4bso11183715ab.2
        for <linux-nvme@lists.infradead.org>; Mon, 03 Feb 2025 08:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1738599586; x=1739204386; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k7uWWyPg0R03bjdST5Zc2dUNM9r9KX+8pTGH8E/driU=;
        b=zUGJKfdaQe/VKI+P5z8ozjIrxa5SpHZVNVm3XRx4Nx3gsW9AgWgGEQWdcrQjgLZsOR
         O3pYOwR0BLKYOavObpbeSr6rs9GhNc8DwggwnEkluAjY8C0LZ1GtGC832FlwO0/Rd3WN
         ehgAVlBTNy7sP4WIi22jZEjHm2PaqamV9L7wHcA11592dkJzYPY+FfypDyhdjzUnsRo7
         0oWWV8WlDYttKaHQEJGcvQnxOUy+2NsHQ1wQ4KjHi5iwt5bWGz3ULagJURcxBcuYTXcE
         0CAYGSTNSrzK7IxWaqHYbYD0+oVp7osWc1nrzBNdZT1Sbl0AP7/+764+iYG6RKtDc8Rk
         8e8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738599586; x=1739204386;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7uWWyPg0R03bjdST5Zc2dUNM9r9KX+8pTGH8E/driU=;
        b=ZWV9kqu4JfTaKHg5lUraRPmi3s6sEoCHYUWMeOF8q9l3hU4/borOa5Fbe8O85oJXWG
         lrUpDFVa4vX9TsC2oQ8QDt1uhlvLI8noSmxUbKNJwCjPRBWxjSGLe2mzGi/XE03xTEDc
         xAGyTwu9xhFqIGJOb8y4+2tWXVa5QW75jihBVp8yZo4QfOOn44aXGKT6JRosNvnOdhCA
         yYKsIRgpu9tkeQ2vqFJNxLG/ETSyFQxpE2dwTGDTzgRI7Ysy4johPtucPeunnNU5nr9J
         0X3ephZGk6fPrMCCmZtFceiIa4tLbzdJXfu5ystJwpmQZrZ4i39OG/P5y2qo6opdCYiE
         hzXA==
X-Forwarded-Encrypted: i=1; AJvYcCW4v5gtscxSdbzHt/8nULKGsqmmFs+5i6mi2eqcjO8yh6dsDAybqr4oC6j65CvDkhE5WRboSzX5SRZl@lists.infradead.org
X-Gm-Message-State: AOJu0YwnMCyptgPEtThJPcQBsGXUzalfVF2nX9YSKmaNsWWBDQu2FvuW
	oHTUbbmdQMXfK9Rxt60CDV8aE+YL6wQGVnameKN+bx4KS8eTyPZ9v6/rJqQIxgQ=
X-Gm-Gg: ASbGncuoThKtKz6SG1rfAYs+AXsOYiKOA3XIePGRUhOrjw3YchqrXGSnn1v+dWJ+MZK
	zYb0imKi5DU6WtBLlQVO2xi3JpXjlSvEFHUkHgBUXUmSBWps3lgZuAuIbf2i06KjYHOLqlpayIP
	8FEtbMQQCJvMckNcNVDDy6PE0Kv1QvSGfIvwYiB3mYJ0vQkEqxrwsLcur/TdEAYK1lebda9w/0o
	iJPox+PmxEjnD+r0snYhmWiwvbfExQPfgCb6C8OCQhVNDu1aI1IetTKZqxY7OSRUXMrPXud4xCG
	PihVcGW8Txo=
X-Google-Smtp-Source: AGHT+IG+6zpWucmgBruOJkpJJXQt3lS0fO/RYHp+Ol6h/3FckztHdzlAhXhbZ2t5Npp38+Kjs0PL4w==
X-Received: by 2002:a05:6e02:20e2:b0:3cf:fd28:852 with SMTP id e9e14a558f8ab-3cffe37bfd1mr202015895ab.3.1738599586187;
        Mon, 03 Feb 2025 08:19:46 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d00a51a99asm24387755ab.41.2025.02.03.08.19.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 08:19:45 -0800 (PST)
Message-ID: <a609766c-3095-4354-8402-16ca047314b1@kernel.dk>
Date: Mon, 3 Feb 2025 09:19:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.14
To: Keith Busch <kbusch@kernel.org>, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
References: <Z6DavvYWWh5eWDjr@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z6DavvYWWh5eWDjr@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_081947_389953_9FC2EA07 
X-CRM114-Status: GOOD (  10.93  )
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

On 2/3/25 8:03 AM, Keith Busch wrote:
> [now with linux-nvme list copied]
> 
> The following changes since commit e7b94c5c6f3b6435206f0e4ef7c5aa4eceae42f9:
> 
>   Merge tag 'md-6.14-20250113' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into for-6.14/block (2025-01-13 10:30:33 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.14-2025-01-31
> 
> for you to fetch changes up to c8ed6cb5d37bc09c7e25e49a670e9fd1a3bd1dfa:
> 
>   nvme-fc: use ctrl state getter (2025-01-31 10:14:36 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.14
> 
>  - Connection fixes for fibre channel transport (Daniel)
>  - Endian fixes (Keith, Christoph)
>  - Cleanup fix for host memory buffer (Francis)
>  - Platform specific power quirks (Georg)
>  - Target memory leak (Sagi)
>  - Use appropriate controller state accessor (Daniel)

Pulled, thanks.

-- 
Jens Axboe


