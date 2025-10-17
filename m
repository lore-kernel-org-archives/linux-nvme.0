Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A51CCD199
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Oct 2025 01:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GJlaeHc72bJK/OHdxZQxOEf8zxkBRPrHd9RdVzl6fgw=; b=PgOe5xBxJpGqfo7GZurN3WthfA
	J6RbGEzXIgtOWLQD1M3sHrvxj2+kWmlFgDLFpQH5eAaTGJKHhjyvOGSCRDTi+ethgTKpyvrRuj2Um
	zWy5tMBwlQQi3jGZbZPdPCcRvyvt4GBh+c1VoJDOsy1dxxSYHlnL8xtZHzUr4Yy+57ilrfImN3PAt
	zs7cP1xYUmqMwfpssAG406YOiR3Y+7eTmq4vQ2HD/2DpJj33X68qEApA8ClnrwfKl5gilUdZrv+8k
	uKJPte8niTNPRd6hkSGbusSafJrmhtNzdAgWDGHD9qjjEOa1v2UZxl4G0IyAIaHBfZX6ExmmAVydb
	ly/lVvzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9ZZY-00000006MHG-3eOU;
	Fri, 17 Oct 2025 01:48:00 +0000
Received: from mail-qk1-f176.google.com ([209.85.222.176])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9ZZW-00000006MGq-0IDa
	for linux-nvme@lists.infradead.org;
	Fri, 17 Oct 2025 01:47:59 +0000
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-856701dc22aso218292285a.3
        for <linux-nvme@lists.infradead.org>; Thu, 16 Oct 2025 18:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1760665676; x=1761270476; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJlaeHc72bJK/OHdxZQxOEf8zxkBRPrHd9RdVzl6fgw=;
        b=ppb94MxkQyy/z/kWoWZEhAgjQRWZAWUshv352g9csRSGUvK7OxbcD3G3+qHAOyNj7Q
         fuZT5GbkyXmhet1VMA5m2AdjuMWDzjTuDa4CtPnKU33yw2GrUj688YcJjKASaZ1tgipG
         DbOCxpkwayQGg9GdJtq6vFpfpIRz4+zu9OYEXxeh7jJUXBriV4TYvktTHZQWf1V/WhFV
         +6et1XSE0a9xqPtTghNvXUYkJMrW2NDIwXCVxTNhvrN1rwT/fRLMsc3KxCILw4QF2Rko
         923pIY4yLf//wvpbTqcQvop5zplKRcfhPFaHYtqVzznKxHqgCXOHQ4UAUrJmEhPUGbfw
         alow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760665676; x=1761270476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJlaeHc72bJK/OHdxZQxOEf8zxkBRPrHd9RdVzl6fgw=;
        b=w+gnWj5kmarSwq+ihwpTIKjl794OirHJxnpDXea8YPgobo9rPO2ppym3lF/8Gxh8TI
         ms5aY/R7E9Uzx0aMlVj4YDWGQOzsApX/82zySfkAO/xfiKjs1P3hN2DtZC17LAVx8xnl
         cpCu3tmdezG9B8JgcUIAUobfmP16gZGckWtw1bWSKJ7pprxfBmaiqxgncR2pYfXhJ959
         WGgVCLmtPGXm1u+e/qQ4W3InFGGYNqQA/9ihrGDh68lkitYZoD/ponxuTc8siIwZAePs
         OtMCcTLIfY+ys2JAcCWoY9iFBLAqh4kGyJRRgiY4qOSKL7zkuvNW7sG7TByN4VDzbRjR
         /YHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaatdD8rWMVdh25BPA48Z3BSeH46OIX1yvn/xNBXgbh4WacIW7bgVsaqAV25jzWQEEZcEScPfIc+xY@lists.infradead.org
X-Gm-Message-State: AOJu0YxJGdTvmC7EjOU+1wttnalMl/xpp6rVycT44p/B7kPGYIwlZraW
	AQBtYjdIAWHX9RDfJNjjfSHKOM72vSODdGTBlCMVtrr+Nzm6tZ+I2DbDYGfTbhxYRoQ=
X-Gm-Gg: ASbGncsYtRNfTM1+ln9GFQdi+/CzFNPNaUsyMBwFuwruFCYUu2KqOOL2eQr6+WA5CcF
	gnX608tI76K4LWUxQ7DmopvB2nQH6e+pwoqM72Kien0+4WkF92XUYODro7qDv77vhY+8dhaI9wn
	ET6Eb5v6l7JLWg1DEAtFKckq5OZdbGpT+YQHvaoKMQ6bFomXbp9kooDM6TYZr8liJKUwJlsbRJe
	quJ2yEvVYnkaPemiKEuoImnTD6q5KO4l0PfG0f365YBPmcdqAt0ESoXKebRpUTMoEadAiCK6R1u
	mwONwcGq9m9EAFNJ0QUKoKj4G7dH/QfOR7vyLb1Vo+v4XIin9i4IQB06PKl+9w4HemJ+Js0Gvmg
	gPbOvmCZksiSnr6l0d3jRWb/cV3lV6XdQIW5wC22O4/EDjeWHjDpUzGgvkGGLnPQ24dFqwBYwyR
	/M0VbhbY6CLOpZ5h0R08MTCu4L5p8davvOCTw0SKNzvlE67ZcFSczLwjsAROlR
X-Google-Smtp-Source: AGHT+IEv+GoB1C4WYV+vg/ViA3EwWNzoXqBNCx4NoGDNb2MvLtDYbrM7gWGsbdHFbs8zJbk2t60qMw==
X-Received: by 2002:a05:620a:1910:b0:86f:4009:dea6 with SMTP id af79cd13be357-89070cd82bemr266557185a.59.1760665676359;
        Thu, 16 Oct 2025 18:47:56 -0700 (PDT)
Received: from [192.168.158.66] (syn-024-169-078-030.biz.spectrum.com. [24.169.78.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f3587271dsm323621985a.8.2025.10.16.18.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 18:47:55 -0700 (PDT)
Message-ID: <39c522ab-1853-4a04-a5e9-d07e2a41256d@kernel.dk>
Date: Thu, 16 Oct 2025 19:47:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.18
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <aPE-64L5715o7FlW@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aPE-64L5715o7FlW@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251016_184758_353953_64D75CB1 
X-CRM114-Status: GOOD (  10.01  )
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

On 10/16/25 12:52 PM, Keith Busch wrote:
> The following changes since commit 455281c0ef4e2cabdfe2e8b83fa6010d5210811c:
> 
>   loop: remove redundant __GFP_NOWARN flag (2025-10-08 06:27:53 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.18-2025-10-16
> 
> for you to fetch changes up to 5a869d017793399fd1d2609ff27e900534173eb3:
> 
>   nvme/tcp: handle tls partially sent records in write_space() (2025-10-16 11:32:04 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.18
> 
>  - iostats accounting fixed on multipath retries (Amit)
>  - secure concatenation response fixup (Martin)
>  - tls partial record fixup (Wilfred)

Pulled, thanks.

-- 
Jens Axboe


