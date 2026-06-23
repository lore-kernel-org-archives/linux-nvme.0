Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CACCDB46F
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 15:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QsWqcAoSJUbbr5g4gu335g27eTBAN4Ee3NvL2USPRbY=; b=Kl+eptL5aptM2rwO73e1ZRuQ9Q
	uDkKJfkAZqxed8eLWJj6jFFn2m9E/zd2/uOOPL3cCxTgFBvuvZ1rA62Ofmv97kdxZwVj4km+day+z
	XZxhzfYNJddkAEcNWHkumFcuYhLaS2LrOD6XYooYThx0ebwQ5Een0Ym3WwiieHATZ/Imwqfi8Qywb
	rSV0Zf11fplx6Aevygu3s8lhCiM4kLvz7wOtGuL2MGVU+5giHt678x1xB9PczZxIp0DrurZZXaAgN
	Ck02ADv45WKzhjjG/WY4TQdatoyzqMbbdAI2HjjTTZRxQt0s2uq1Y8c43wRYlQSaQc3Jmv8UtTxIc
	HOUVdy+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc2iL-00000006VRL-0U3w;
	Tue, 23 Jun 2026 15:07:01 +0000
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc2iI-00000006VQH-0XJc
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 15:06:59 +0000
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-69d8f70cb0cso4275411eaf.0
        for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2026 08:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782227216; x=1782832016; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QsWqcAoSJUbbr5g4gu335g27eTBAN4Ee3NvL2USPRbY=;
        b=t7diqVhixcEAzeJ87S9CZ4o1vruvAs0QE7M3f19VNK50hayOL+V5GcZnAu4noQMGO7
         ZHsZWqA1kFWk+KDpGap7kJJkgxoR9jx2d3DcM4pgncse/yhfQ6DOTYiOpA+ICgBOVG+w
         3hM+R8qn7GJDpT6i/IeVhuDcVkIwNZOKibGYjfzDlGubsk7ZhiaTCtdqVrZsnXvAhjml
         rvCUVf+fQjMegFM7YKNemfg7j7cXSak5MUcOrfw9yKogANRBwFkmK0iaFMWlylkPlgux
         n8wUFTz/6/IaYG9bWKrHqhHcgas6AzRGf8PKCjqPiZsQg7ILSESBD9bJ+cSNtVexibLy
         O+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782227216; x=1782832016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsWqcAoSJUbbr5g4gu335g27eTBAN4Ee3NvL2USPRbY=;
        b=aqHAZ473xjv6PPaxMl6PeALBe2OLzUol5nIOp/hlwg8S0Jq27cKA8h3BKm3ANFxOai
         mbtGEm+Yzk3xFHzbFjjf7qNXzOi3nSPYV4ZULUmQWr7EJ/eqTPY+g2FN4lzp7JYNfSMQ
         JGH1KKspjMQi9iCf22hpy4pLolcXDuskZWxwHFhvkCVhs3HpUTSwP/QXWdhA7527qC0U
         xxDmSJjBXqTj7Fwtfz9Jm8uarCuO5szxEzlQPuNp38pvt+vDOcJXiwfQQg332VE8Fl0t
         h09EI4m8uA8/iDyQulmv76hsTSi4Wd0qBpA2h7yYJjB/WimyS4Vh3dxonsAZjU61j+AO
         tZFA==
X-Forwarded-Encrypted: i=1; AFNElJ8r109YzQ+z/gd7R3sQrVPWN4bwPwXNVOmKeF8CL3QRZxQp4ac6v1ovDirGR/WWBTUmQE8GBB6HtOy1@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1kxfXxtTPqF69bB6ruZTC0oISxZa6F4tkE8St4QtFvC+nxRzY
	/21WKki2kvV4UfiySu1/jkJzqfeQoheSpFYB0J3ZNsLmhE5PGiwL+qyqWhD7Zl1o5wM=
X-Gm-Gg: AfdE7ck8OA7GJExjgGK2wPvu5dXjSJGrhWNtoTBaWlW64XtSlrxuAinQGAGLrsxBjjy
	syQk40TBlXYzThpVfwCitpEA8NwZSYicx5OlE773dkMWbMATcibUZ1zDp54WZAR76493ExQZoxy
	L7zCFdgXJp/M8WmtQLfSROezusByzPb84CxIEQ8WZc7VpDATr/pYPu+BcsXiajCUTp5unU1nh7q
	wtLjdq5pqhanrTTTmxeMeWvcYyzrCkcyRaa5Vaqfda0Mc7GdQzJadzRuVSguAhSzNU6vWYQ9sd0
	LF3MxTWclu4p3BUqQxAdN62J2CTlYHwWfh+MpPjI5fsdr9A9aves069z456DWmBlFIxSUKMP327
	nUiR4TSlcpztYXZ+FD3zSFyihHm+ybdB/8YsNmWusmC39TOeSc4e7XxxgAh2HKgXZqAlwvvUw/V
	meKUsvLN4eT5G7c9yTYZCEZJV1cP74Ky3n24VpgSVFuKStndqX3FaVLxU9dm/0Bvxgmd1IAZg=
X-Received: by 2002:a4a:e905:0:b0:6a0:ac70:ecf with SMTP id 006d021491bc7-6a0d8c17eabmr17207407eaf.17.1782227216474;
        Tue, 23 Jun 2026 08:06:56 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a0e9fae72csm7362926eaf.7.2026.06.23.08.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 08:06:55 -0700 (PDT)
Message-ID: <354f3f77-056c-4562-927d-4dfc36bd4a99@kernel.dk>
Date: Tue, 23 Jun 2026 09:06:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 7.2
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <ajqchuQAz534Erac@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ajqchuQAz534Erac@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_080658_418645_77ADD904 
X-CRM114-Status: GOOD (  11.36  )
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

On 6/23/26 8:47 AM, Keith Busch wrote:
> The following changes since commit 7ed4aab1381f3439f45032eb860f89d9da5e45c2:
> 
>   block: optimize I/O merge hot path with unlikely() hints (2026-06-08 07:46:58 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-7.2-2026-06-23
> 
> for you to fetch changes up to 7d953c75f0a3f905aadf3675c9394a5b9d9897bf:
> 
>   nvmet-tcp: handle TCP_CLOSING state in nvmet_tcp_state_change (2026-06-10 08:14:19 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 7.2
> 
>  - Apple A11 quirk for sharing tags across admin and IO queues (Nick)
>  - Target fix for short AUTH_RECEIVE buffers (Michael)
>  - Target fix for SQ refcount leak (Wentao)
>  - Target RDMA handling inline data with nonzero offset (Bryam)
>  - Target TCP fix handling the TCP_CLOSING state (Maurizio)
>  - FC abort fixes in early initialization (Mohamed)
>  - Controller device teardown fixes (Maurizio, John)
>  - Allocate the target ana_state with the port (Rosen)
>  - Quieten sparse and sysfs symbol warnings (John)

Pulled, thanks.

-- 
Jens Axboe


