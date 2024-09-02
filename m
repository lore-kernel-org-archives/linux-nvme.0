Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7252CA0ED3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 17:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lznb3xTQoicrAXo6yOHWF4t2TnQtzTvR2XB7PT38rrY=; b=sHCvrZzrPofeLKxgszFIFcBWMY
	nq5NWVJ5RCMy6bOQAaurPKuCzrUbEdQc7HY9TpSOF1DcRQZDI/icDQd/QRortPO2SUlgWgtBySa1m
	OnN9wGOJS+XHQgq/ozGdfb+ddSUjvjnmyCIFOpFeP+yFMPqwood6LtGqO3WJiZ70EPe5qMnWV6ayq
	Kr7l15+5Zn+l9fUQw2o4rL1nyhs5098qL67Z03/N9ugI9CKj7RSk6tsP3V1KloXs8jtO8uSgYEN7L
	FCuNMwlXa4sCuaZ8krli5sLDK5y/4AIuPwp7FZEtpI71+7iQEs5lXIUPb+uCGguz73oAh55nxDQs0
	SikS73bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slATR-0000000F7VQ-2BAD;
	Mon, 02 Sep 2024 17:04:17 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slATO-0000000F7Sv-3rZ5
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 17:04:16 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42c5347b2f7so21710525e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Sep 2024 10:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725296653; x=1725901453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lznb3xTQoicrAXo6yOHWF4t2TnQtzTvR2XB7PT38rrY=;
        b=MyKCOvV8Hc8ymfWOXwwhvsyPuffqY3NGfU0APTwWaQeBqBx0ZbeauVBK+/F0+FkBYK
         0kGy1uzo1eGSdfbiNrd+4Nr+CjkAzIGn8iBm3ldlqbW0m4zAiQPJRsUBs5RytPIXfcCS
         pz0O3M1bzggo9yscX8LgOjTx8skdw+oYoshWO3UwJncMXbV5osJ5DZQx93C70IvtJJoJ
         ofKlpsryLFFdip2UWO6acVuLHB6X16RpWZzYJj2N2MiBH8DdTnc+H1NQHuc8m+1mWvr6
         A9I8+J9d+uv66CXDgI3aWcIWu50FLFhkwQt9xSlkBqz5ENnPZJnzjQ/ZCaQMKjIlUeXh
         1n4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3a2Y5WdDsY1LGamss+5RXBQWJxwbp0P/cAs/havNodbaopCWctSPPo7gHSQSRgB0PtTQBy1opAFfR@lists.infradead.org
X-Gm-Message-State: AOJu0Yys1dKTvahiSFGkgd2LKeLdOJtd+mYjhXr4ZR0M6wq4OM5MtW9g
	BSq4c7LB4qyj4ebu4P3FQnZOtXIR+HVTDXF+3mWgpdCHTG5ifqmV3aNOwg==
X-Google-Smtp-Source: AGHT+IEPGdlVFKLRRqIbRnoK73pnVjKZ8IRTz6q58p2U91A6kEn7IGtQX/mXElFthJ8gBj97W45+LA==
X-Received: by 2002:a05:600c:a06:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-42bb01c0f9fmr114166295e9.21.1725296652677;
        Mon, 02 Sep 2024 10:04:12 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-253.bb.netvision.net.il. [89.138.71.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e273eesm143637955e9.32.2024.09.02.10.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 10:04:12 -0700 (PDT)
Message-ID: <d916ae67-fd43-403d-8053-4a5c0a472738@grimberg.me>
Date: Mon, 2 Sep 2024 20:04:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: check for valid request when polling for
 completions
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240902130728.1999-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240902130728.1999-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_100414_992119_D14487E4 
X-CRM114-Status: GOOD (  11.61  )
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




On 02/09/2024 16:07, Hannes Reinecke wrote:
> When polling for completions from the timeout handler we traverse
> over _all_ cqes, and the fetching the request via blk_mq_tag_to_rq().
> Unfortunately that function will always return a request, even if
> that request is already completed.
> So we need to check if the command is still in flight before
> attempting to complete it.

Hannes, are you able to trigger a use-after-free here? That is the
inevitable outcome of completing an already completed request.
So, why are you not calling it as it is?

Was this seen in practice? do you have a stack trace?
I ask for this because it makes the review a lot clearer.

