Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3166CD4F3C
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 10:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HqBDj90Kc3B5RL3RITDRmt05U20tIBaa43CY99Xd9RQ=; b=ibesMc2k3OO2SmM7GZr1yN8UVj
	WjrQ08ljLYGzIVmyDTg55T8hqCDj6y1qTX/PeB1wmk1g4j9hkultgYyOKqIMrAtEsOWPfSs503B55
	jEOyg3UwUcR/X7zwjNvvppZbExYnUJ8qre2+Z64uIsqx3XrqNQ6IhzZowwPSQRn7iV7QtismDKUgO
	Kcv8MDc2OVyThuRBs5K6aPff3qZ0Pu9yy1S2QY8JIfQdV9XvDoKx41yHGrBa4jITXyNvMjrs52PBO
	pxciNqUNc11wHxKVb3xhj+O9nPAM0rQD7t2UF5bUyZWlEKS6t3EY+rE2gYjO5Ff1dWprxneuZ9wQe
	EguE70iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuzI-0000000FAg9-0u2X;
	Mon, 18 May 2026 10:14:16 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuzG-0000000FAfM-1qlF
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 10:14:15 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so31091715e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 18 May 2026 03:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779099252; x=1779704052; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqBDj90Kc3B5RL3RITDRmt05U20tIBaa43CY99Xd9RQ=;
        b=gC1x1dQzup2XJcyTasHjyjxSCX958ZhrRzwRQQDgFyK1xrWRAoMvsxTxP5AUitTYb1
         KYc/N5y4t2s0QkkOAbe8BTFlVMj1DpRIYc9pckti06AEmT8qTVG3sBw1FYMQPnkoxEro
         tnXY0/bPT83qW0+U1T4GnQwHmrkFit5sTS1ltf7GL3xMrS2SAfl3jESggI+cGTghtPyC
         hV5i0TVVaoJElUKy0BEVDajxPpCcU6DKvHvyZvCq30RbZkJp3cFpo900BlXW7fKiawUl
         alQnq6bnKumrEdIMKZsZtshXLwlv/EBO0Qoue4OcEUIVpw8wSih9yXy5M8f8ijwkgF+Y
         BY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779099252; x=1779704052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqBDj90Kc3B5RL3RITDRmt05U20tIBaa43CY99Xd9RQ=;
        b=g+xrLvZuUgijbJb8m2/3dezD+qVuEr80YaLUn+UgaZfGpYjdWdZAKsosluq02cvWC9
         Nk9+WzChvTESomWVMG+ZOFN+f2elw0RMlM4ezjb6N2W229oAzyeIXslz6BFiLqSnd+BI
         kA1W5n5WqxN6oHoUQk6/pjt/xdDKz8LCbABy5Lono/9/9nJ55j/HVSoI6UWIO7IMv0Y/
         Kr37b4SR9AfD3npLwGRiJH9/lWvk3z7bwxla1mUsM+yd9RUeu/bbm1oIRkd+7bTtM3sc
         zCWtKPn0cNvONUhQXtz1uN72D3yKUyyG5yfRfzJ+VX45FNC3N991z9B5lgxffpWHQKmy
         Uvyw==
X-Forwarded-Encrypted: i=1; AFNElJ/7GcvFmRIZLepoaUuQMy69EMTG0tanEo1fRnXOwOLWqwLYFhmTlpM2Eu44Z9/OvZeF6Zs/olOZJs73@lists.infradead.org
X-Gm-Message-State: AOJu0YzzXy7nEtFBKENPhQrWQNMLt0GI8xOeKWlXv6TcDK4iS6k7Mg4b
	rgXD5BZz9WHTl17HwfRZnvkWFVIiviS1nc/TkE5gUTiaBN2EHJCV1UBEae528w==
X-Gm-Gg: Acq92OEcWgUb2x4RmR1LW0KjfcKBPbeuOgCN0Tdb3+AF2s1IBWzunyFg6rn0THoC+8e
	rnYt/2KjjhlonrNyIyBHpa3d6yPGJe1+17vz2y6WB9a5abXVvgpMaXcfgO2eJQYMOIxmoQDOLvx
	Gcvp5X+ePy52DYdqmn6RHk5og5E8d42n9HfcH3WiW+VAdG9PL6JC4ByX/yj9XgSe3lfSyfyZkEz
	UPjdpJXEd4R9dkRfTRvGfOuMxgPbZZlsjNf96NI63oTYxIFArkkw5Bd46dhQNtMF41/p5qYIhvG
	dWuANic14ygfbkmzMSlNEpojTiscGJjns5CyV3mwuiNbWSfl+iGCiSKoXuFtFmley3OxqGuAkcC
	YYoMDlbSIMA5FXW/e0DQQgv6sIOxD+0ne0JnR8Xt4HyJO1xNC5jxTU/6Ettkat36K4JCAau/Hag
	uxwxMXPNtd9nE9z1nt35yv85NkPVAW16Rj6AnTP0fxySjDDCp138M1rZzD0x/rocNHKq6fkH99Y
	O8LmSI1F9kZOcoycumk2QQGeqnWWNluVKLeyusZnkRv4/6OpiO+U05LiJY=
X-Received: by 2002:a05:600c:3b12:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-48fe59ab80emr218398395e9.0.1779099252361;
        Mon, 18 May 2026 03:14:12 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:6e9b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0f72sm38877974f8f.25.2026.05.18.03.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 03:14:11 -0700 (PDT)
Message-ID: <ebf41920-5852-428f-b98a-e0f44c8f3315@gmail.com>
Date: Mon, 18 May 2026 11:14:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] lib: add dmabuf token infrastructure
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com>
 <20260513082431.GA6461@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260513082431.GA6461@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_031414_541209_DB0C594C 
X-CRM114-Status: GOOD (  21.52  )
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

On 5/13/26 09:24, Christoph Hellwig wrote:
> Naming and placement:
> 
> This is about dma-buf based I/O.  So I'd expect it to be named dma-buf-io
> and no io-dmabuf, and live in drivers/dma-buf and not the unrelated lib/.
> But I'd like to hear from the dma-buf maintainers about that.

Looking at what Ming is saying, it'd make more sense to keep some of the
parts like iterator and the file op more flexible and not automatically
imply dma-buf even if it's the main and for now the only medium. I.e.
ublk/fuse can use a similar interface for mapping buffers to the server
even without dma mappings.

I don't know how the API should look like, maybe passing memfd, and dma-buf
supports mmap, but I think it's better to call the op something like
"register_buffer" instead and keep all it in lib/ for the same reasons.

> Config option:  as this unconditionally when DMA_SHARED_BUFFER is enabled,
> why does it need a separate config option?

More clearly marking relevant code, easier to make optional if needed,
and gives some introspection via /proc/config.

> Interface:  io_dmabuf_token_create / ->create_dmabuf_token filling
> in a structure allocated by the caller feels odd.

It's minimising pointer chasing. "token" is mainly used by io_uring in
the hot path, and io_uring just keeps it as a part of a larger struct.
For the same reasons "map" is allocated by the driver.

I can add an extra parameter to io_dmabuf_token_create() for how
many extra bytes to allocate for the caller's use, if that makes
things any better for you, but it was easier to just pass an
already allocated struct.

   My gut feeling
> would be to move most of io_dmabuf_token_create into a helper called
> by ->create_dmabuf_token so that the token is allocated in the
> driver data structure and returned from create_dmabuf_token.

-- 
Pavel Begunkov


