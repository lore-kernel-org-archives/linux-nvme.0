Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC58D4922B
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 13:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=X1OCGeG+Wy1x5YvubnFwzcm59F
	U9YKuGrIKnf33nYsJA+qKLwpgaKb9M+r0uvZxzEdrE1ta2UuphWercqNfpmVm4525wBDfrZ6HcAEZ
	f44sjmEdwulKXug6pQ9GxWp/o7A9qvMakkbMMkWoXhu6arWru+o9/nariNuKsiO3e6B0rseVRbhhs
	yCZ4oPJFUOqUMTwEBlmHU8nhS0Pb5gF7VHFa7+979hV7qvqmfUJDPtD1ja6JgaXRDL2a7NDPgjQ38
	GcOpELt73OScaBmI7mtDFAm1aIMD6GwUMK2BpG/x9jxuIhAmaqgKiqT4LVkegFcdY+jnfZ3nZoN49
	VBh9zwdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU3Xg-00000000aKk-0QUC;
	Fri, 12 Dec 2025 13:50:44 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU3Xd-00000000aJb-1Vva
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 13:50:42 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-477aa218f20so8643125e9.0
        for <linux-nvme@lists.infradead.org>; Fri, 12 Dec 2025 05:50:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765547439; x=1766152239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=YT2DZwD8t5awAMluUoVBeXkqUzRjFjh0Hr0Ku1OoiGfBjqZ4+X8WLH1U4UjQIL6oN0
         yn38CnKY79HNAKiewg0AZyvoe8ZnB2V1OGTVDdSmdrjLBnqQzfN1ITkxeaEgfUYzl/4M
         GBob42DINcjGBYn34K7SXPE84L0VKOgQ+WBSb55iPoERWWu3ktoJj5sF9YD8cPmMT7jo
         MPe/1DEAoaLKxFV5wbqoPItPAbTsDnJTZNJPWmNFFgeWkb7QqLll4Qs02dUfQCoS5Iwj
         f4OCD+k96WwubDVRbErSaq/ykDwT0eAu5oSAtPfikUSKCeZR+tfIRlJ1f6hh7RVx0R22
         2NHg==
X-Forwarded-Encrypted: i=1; AJvYcCW7AFTipUvxI7DyOr5ZgBVoY7DuqLdJx/ko8D7TJkmwzItP4qM9/4Q9PRokLbirTIpSIgE9pdIqwVOm@lists.infradead.org
X-Gm-Message-State: AOJu0YzSNN6nJIIFhZajdvrtMwnX5wc7byxF/P4IVBU3yO0zqAmzIxtK
	XNW1a9fzpM5OqxRDO6cdUn8+bXQvTruuRe2xGo6IRGwqwAX7wYLwQXHc
X-Gm-Gg: AY/fxX508nsuy08Zo0RRsu87/MDixHy0C213OeUQ/qd8ydgvytSe7Pz17zu5oXnYraR
	Wctp0mGwCNz1Ht5ANfh55Fa74/jCEWrpGO0GCjO6NswFm4O0NI1C1qwLa3JkQvcgjSyn9rsZ8IF
	ec8vx2a8KyHKRRCceaToPb8Dk8ZN2P9asy3r+45mNOIZOn5T3UCoHcC8ZrIf8oVB3m2rAGcyMio
	ScLVRsBCjm9bp4LJKVd6BUU/5CkgnaOtJKO1FCUY4dism1TfoDangxIyKt9mjY60MmHdX3Ba0ja
	nyRiRkdCSZaTjJijGawRmCS0wCxxRglMMwYOEl/4HrZQcmrsCXM51Ys1mNtbMJHNPPFOBhj7fiB
	rSi8N5Ib5eWx5ocC4U3xU7R0dbG8G5XpLhu4sw7MnMeP+1kiV84uFFyRC5RouEIa5qk5qvk/t80
	Kj2ynelMSUjT/jlLoDnTrJN6wW7ioI387IZqL3lf5anrMPiU7odcCvAg/x
X-Google-Smtp-Source: AGHT+IFeVw7KGI6Z94h6YsR3oaEpULijMS03FPqZgjgQQUDu0C2mW6MM7oIdXcLHpa1upQ26gsXq0A==
X-Received: by 2002:a05:600c:4711:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-47a8f8c13a4mr18892325e9.14.1765547439409;
        Fri, 12 Dec 2025 05:50:39 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f4af065sm12355435e9.6.2025.12.12.05.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 05:50:39 -0800 (PST)
Message-ID: <3e2186f5-38b2-46c7-975b-99da7cf9ff65@grimberg.me>
Date: Fri, 12 Dec 2025 15:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] nvme: Expose the tls_configured sysfs for secure
 concat connections
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis
 <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20251202051755.1312158-1-alistair.francis@wdc.com>
 <20251202051755.1312158-4-alistair.francis@wdc.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251202051755.1312158-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_055041_396594_024F5CC0 
X-CRM114-Status: UNSURE (   4.30  )
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

