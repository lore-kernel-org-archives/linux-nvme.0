Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A2A6CFD313
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 13:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E4Kvahk4sfkEzDMtaEQ+7t96X+5OMROz94rsckBU8Tk=; b=egAf84B2mD7BJHFx8CFMh/H+a3
	erWnzil2mimowh0YvCW5Wm44xbs/yrR/7zlMtPSfFpNvCk/f1mTZ/6Pqc06qRPXekntxPPZmcdqBP
	kkCiJPhe/7DaR+YLzrMA0js8T6nVNRhLmzWse1Z3FhRublY7OsMGLEydwDbILSn8jkqxWqz8+iQMn
	BmOb3rkjH/rFu1IDWF1QBub2hcyA+eG19gTsXJsPwRT5HUUrYu19dEz04QhHmbkBfmw8A5c2HMQNB
	eamKFfJubrmMUFDAZVBWGLMq0ZLjzKjwHC++StTbLVnNiz0YrDhlolmpfQCPfIw3gIiKJB1fFi/Gt
	YTASHJKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNWkA-0000000BlIU-0NkF;
	Mon, 24 Nov 2025 13:36:38 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNWk7-0000000BlI7-0xn2
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 13:36:36 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-645a13e2b17so2433644a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 24 Nov 2025 05:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763991393; x=1764596193; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E4Kvahk4sfkEzDMtaEQ+7t96X+5OMROz94rsckBU8Tk=;
        b=LT9pBBSDZQVo7E+NH8OSufxkhBL1WVG94kT+nnm3az2CF5J3eAtdQa6d/3X+QsrF6v
         8sBzI+krQD/+xTnLFsDl+KpOa6jA6lQWCjt21MdhjgoakGSClISX8xUf3N1ffkouYile
         qFgCotL/6SxkLaWwnvBm3Q+lMAwUexuQcWeu/9uoh56ZhVbGL0/tyaiuj2tVjuJtkVVZ
         XxKnHCUpPxU6VuJQDqdkffXh22VwViA76FnqXrC3G6AJqQMVe1t9r5G1d4Ax81+XGjrJ
         BsPfHr3v0kp8UgQg4inHNQHHmpgEwfTDbnHj6+/ewaIs9kRmexK/P5gbuzNFf73rYLgo
         yOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763991393; x=1764596193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4Kvahk4sfkEzDMtaEQ+7t96X+5OMROz94rsckBU8Tk=;
        b=jjs0JTs/lnk4LZxW5OILYusTPrmm2S60Th5deUcKU4RUUXH3xx2qLsGD74kBKHNsC+
         GqSxo2Bu0ZsJqTfplqesbLHON3OyzGqF2E9TNIOCK/uocfHdkrV3yW4kNrGtuwLDNFKN
         pkgLesvLT3ykbDlMpgkOjTfpFm3pgMwOHWsG7CapHNfDj4di23zLVT8+1jgsVDAqvHNy
         895LwncWjHRV4R6/4TK0B1wXoL0HXGI0A2f9eQEj4K7fv2fnXOXt3KiG/Sg7FlqJzCN6
         tscjr+QKbhPR2j1nrJMRd6ZAWVQ899SUCpnU5VoXhx2xw40zRJ8kIl+1x29SeSytupNh
         kJMw==
X-Forwarded-Encrypted: i=1; AJvYcCV2FSTCVMkVwMosuwJ09Een8P2IQZRmw/aHgSz6wP8nM0a4k9zJlEoEQ3VrikPdSiclKOh405CFNvQj@lists.infradead.org
X-Gm-Message-State: AOJu0YzlT2WcfI7mxboJAzpfPehPZ821EZgAz3hhcKNK15dtVUxcvnpJ
	mWu78wWYF0V7empUf+/dE+HlwB4rGSzRmRZTm3DDWToqKOCrgJTJazU59HxoIbxzbJPTn98g6D3
	W7go98jPz5g2tLBVquY9TUkDmabqICg==
X-Gm-Gg: ASbGncu6TfsGEA9+e465GyLn4UuuslDXb9VCCKyU39sXBD0ru05dCi8/C2+gkw0yIz9
	4cZltx+xd24pAHUkTfnfcVkw/ifdbo+hONvtQzaka3xktZv0GdOoaEifNwT/Ss1P0NI1TM2dRuk
	8RJQ3OTBWT8vPo2bTIMGB9Uv3fCLrUxjQPGCfadu5N9ebQO4zqqwdl5iIuWqJKSHJvVoxk6WCl7
	BtjDbS5et9aMgyLdrBbOjIhkfjmF6Jxt9D/feqzbMq7w4yAw7BnALzEkYR856Scp00SCiNLSPbB
	6dDKeQ4/7dyKTWgjGx0aUdzIKBvGIebWW8Osj5gKd2l30yDQNBYFZ0n3sUCxzksz60Y=
X-Google-Smtp-Source: AGHT+IEnG4Z6JyAnZPsc9zRPIurpTL3mzwNg7U8txyPxgdZYEAlachoenhHzENGex2kidp1+A4wUbZCJxBRlVZeptSQ=
X-Received: by 2002:a05:6402:34c7:b0:640:edb3:90b5 with SMTP id
 4fb4d7f45d1cf-645543493b7mr10042269a12.7.1763991392543; Mon, 24 Nov 2025
 05:36:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1763725387.git.asml.silence@gmail.com>
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 24 Nov 2025 19:05:54 +0530
X-Gm-Features: AWmQ_bkynwx2lMdwns4GsIfVtYmI6CqY40r8-Afst6-_o29b3r6t6sfqC-dnOGU
Message-ID: <CACzX3Au7PW2zFFLmtNgW10wq+Kp-bp66GXUVCUCfS4VvK3tDYw@mail.gmail.com>
Subject: Re: [RFC v2 00/11] Add dmabuf read/write via io_uring
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_053635_298256_D42A2893 
X-CRM114-Status: UNSURE (   8.48  )
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

This series significantly reduces the IOMMU/DMA overhead for I/O,
particularly when the IOMMU is configured in STRICT or LAZY mode. I
modified t/io_uring in fio to exercise this path and tested with an
Intel Optane device. On my setup, I see the following improvement:

- STRICT: before = 570 KIOPS, after = 5.01 MIOPS
- LAZY: before = 1.93 MIOPS, after = 5.01 MIOPS
- PASSTHROUGH: before = 5.01 MIOPS, after = 5.01 MIOPS

The STRICT/LAZY numbers clearly show the benefit of avoiding per-I/O
dma_map/dma_unmap and reusing the pre-mapped DMA addresses.
--
Anuj Gupta

