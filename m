Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086C9C3ABA9
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 10:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BosDS1XUHja2qaOxrSOl5G/tUYIKcHsFHhY5FtAb61E=; b=HfXmYthvN4mrgEj5w7cx3Rj554
	bz5vDYVhT7gMRrXrBsXsbCczjBhNHGmWhZQKW1msMEDBsl/vDGupW2xh0GY7rRMPY1pgrQoXtL/2O
	DFuRipd/lYYO7qbkWGv0Fp/9wdt3e+dik7vHo7GJonpD/WLjPOFkCtF6he0tg8L5QzqWmYOUPYaMs
	YFBnzC2AlStjFffcp5ydCnv2/5e3bDooaBr5nYUf8IgzZTa8ePWtUSW68s5ZLzhlPgMiIXDUL9eU3
	qMRHzH5TzYSw2sTuewHzKJQYfCDIucEoV6s4WVKZ8oNkKMUDgru6Tl7LvHLbn2AkiTUn5R5ePpmWc
	CjAymGSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9i0b-00000009Gm6-182F;
	Tue, 29 Apr 2025 10:16:13 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9h1l-000000094z1-2nXK
	for linux-nvme@bombadil.infradead.org;
	Tue, 29 Apr 2025 09:13:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=BosDS1XUHja2qaOxrSOl5G/tUYIKcHsFHhY5FtAb61E=; b=CyzAFFBPHGZ+5OOfIdA8stVJWz
	IkOSSDR1NZQNnYjrADWZl+hWN27cm2cRzcgLGP7CMKJdToRybwgwLpWUkxsDQ2uU3GqXfBlfxXAz4
	H+Jo1n8m1FQS2sHtUjeaGYSgovbeN0Ah8R4/QgH6+3DrPZdGzAIomEiWCMYAdmHNAAriYEoPGZcRn
	nYk4CfxgP3ON6k4sElFGbgRVyQc+y1REYVArXhMrTUPx+gUuH18QUEo/+9CE3kWVLzjDUQJOVCWyX
	4hfMB3O6KxG4x9bFlO/PrjLofkitDL65uN6wetI5g2/hqMPEGMM/tQkYGRHf3DYV9naJ8e5r8xHjM
	VpzdP7OQ==;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u9h1i-0000000DF3g-1mgQ
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 09:13:20 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so38207255e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 29 Apr 2025 02:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745917996; x=1746522796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BosDS1XUHja2qaOxrSOl5G/tUYIKcHsFHhY5FtAb61E=;
        b=QadEOFRkw43n0KCugcObUi6pXZoKEb2ekLwGWPZK3P4wmp2GmiUyn0OSA5s0BUyH7H
         k2auUDSNnPZ8q2mHTypxvrPbGKRrUxDLZVShsG+5qbh3JhHmYDU9Bmt37B/ezxHON73P
         Df4tQxsfTl68VxBszQHfk8oaz3Zg4u2N70Yn1YPaOu7rUb9TCVYO7q0NKkhyc0h6/dPN
         ZZZGEEjcFMw6wNRJhWesOBQD35cPvM7pNjM0T9+4mxF8+74h9mp/4lNloBPmud1Xgbwu
         v/QwzxGK8DT6orGHV6zv41hcJKIV5ZqiieAHbjtjaIUILfwY6u5eMoeFG4HU/MOiZYt9
         YkKA==
X-Forwarded-Encrypted: i=1; AJvYcCXZjdhbHpLKUr+s5lW6xTARhPPpU/cK72jb8hPHi5nDXRGRA2wUOpMgbsuOO5exm3+4/kB0x0E/5mNB@lists.infradead.org
X-Gm-Message-State: AOJu0YwbNBvvnO8HzDJaZ4MyLhQ/dg6tMb0A7wzRju8+dM27E6fFFoyc
	BWPWe5vxJ270+ZOGG4SrVuycB2JuzG0uLP7ZVt/WI73TZowRWGhh
X-Gm-Gg: ASbGncu9X5DATQkpWez+INoC2KkdllNfPKw4I6PjthzWWM3kL/B3/65ucZo1KmqZ++u
	j98y96RO2sI04HuRlrLf/GD38P5uo7F084TkuKEdNYIRcBgpf/ReFXTA/jCAaljAPv8zLAO0Kep
	PUfNDVgpR4nn3zlVqZ6PyOM0zSbpFjKcDNft9HNINi8Nb/uFiBJNpxmY+mdtnScvyp6vrqDxppn
	OdlJMJ/P1Foq+ix7HBISEEdV6GUOvEQbGQDTPQPcX82FSoTodDKXHXYU/ykBhHBt96o9KIekWZK
	5GIrmNtUUKz1a4SyLF45T5cE1cDyd/P9ineIEAeD/Z+asLMz/lvg66v71Uw8lzNND7obu5WrArA
	9W6HrUg==
X-Google-Smtp-Source: AGHT+IEm9eDcy+58BIdynCaoZdr86lAqQ42NKWCuvh7wSzCeYLrbALifKH88K9PvS7OiMcR6lztrlw==
X-Received: by 2002:a05:600c:35cf:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-441acadf4a7mr20008555e9.3.1745917995641;
        Tue, 29 Apr 2025 02:13:15 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a5287a94sm152710645e9.0.2025.04.29.02.13.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 02:13:15 -0700 (PDT)
Message-ID: <eb0ef09b-4266-4a3b-ad6f-0a6522a8d243@grimberg.me>
Date: Tue, 29 Apr 2025 12:13:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-tcp: fix I/O stalls on congested sockets
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Kamaljit Singh <Kamaljit.Singh1@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Chris Leech <cleech@redhat.com>
References: <20250429081739.44820-1-hare@kernel.org>
 <20250429081739.44820-3-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250429081739.44820-3-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_101318_600926_76EFF633 
X-CRM114-Status: UNSURE (   5.21  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

I want kamaljit to give his Tested-by tag.

