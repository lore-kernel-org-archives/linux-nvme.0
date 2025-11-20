Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2A1CFC28C
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Nov 2025 16:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mIp1emodWmrQX+c6TjoXmEBGWcecINECr9nK+dGHBUw=; b=VWa7FwvCs8kKG3OiorYEUkT2OB
	7T7KXW54r+in9C2zYORjsCEZlUca/zZLqEeAKkLmodv1WCZFIrmk3a74ub18OumolEeXBKlhudWzY
	EHqCWHDnOEaeAbMSB3LlubvTfrpIMLB13p7JXgKosLl/4CRYIumBBwhDFOqd2+XSB5ZywrqsfNWNU
	osncytkNqQxOD7RhcywGuh5Moaoz9PzWGtYhsAg6MpbE+RyCrkV/IyULmYO846nkKlH852fXMxSga
	K3NbNR9u2jHNPG6Kjq8QLx3jK8fofZu7Brcz1GE1UvTzGNiX/32SDrlm8qndHa0DClBG+kqGEOj6x
	YH+XSelQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMU3s-00000008j6X-3BB8;
	Fri, 21 Nov 2025 16:32:40 +0000
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM61g-00000006sjg-2JsU
	for linux-nvme@lists.infradead.org;
	Thu, 20 Nov 2025 14:52:50 +0000
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-435a16798feso7420165ab.0
        for <linux-nvme@lists.infradead.org>; Thu, 20 Nov 2025 06:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763650367; x=1764255167; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIp1emodWmrQX+c6TjoXmEBGWcecINECr9nK+dGHBUw=;
        b=jAAyF8Z5gd7EvN1kDnRbZJW7eyfjT0am45AKeVKs01IM1CRRW3QjJujUlJDMY89efh
         g9/iOcXEMA9K/8r5UufPVVp2pZFEm+yUtX32bPASllGe6uHtY0BakXf53owBKxmNskJj
         Mc1dmYcpftrijwCFkmo+YQZRDiQ4AtHdQU2Q1KttGLxzSjOG+OpjB3eiQdzlcwDlxY/i
         4EagHYkrfPTmbAcT+svqYktSGua7edaSbI6dswWjj0Frv47iIoDkIKNNiYFicuQUtI3X
         3WXJKzjrn8R3oOstBzCTSRZ1BjkyMH374zbQ8ILMBvHCvyqlftcRZyCE56/f1SxahuZO
         pBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650367; x=1764255167;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mIp1emodWmrQX+c6TjoXmEBGWcecINECr9nK+dGHBUw=;
        b=muHUjSMtAZaxTDZO0pVeizKcv6hZxlWDrYyehiUltm8d8YUd2ZqvE8vG7ON13Po+QF
         NTEzLKC6Ifl4k7O2jN8WatR4+AsotCyTyphZNIpxHyUa2zMnROlqS8CfPdbbtumk/c6Z
         CmDf4tDAnamUdcOiKtfsZQQrkNnh7SWnQvKLDNDHgB7PoivexLOzoMEh8Pw0jov83lzT
         5UYnlxurtshyWgi6ZjT5/ojD1x5mMbj2nX0kcM8oRsxKO+2682bCOFnqIhPdWaS5hHe0
         pxMVwO4ntidtQ4bCVkk6QWVPKltTqyDg4jzRqMbFndM3/cJP8CT3CIXcBXa4X10pm9dO
         fpJw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ36lIb5qjSpCz6lQK+AH3CnezWynpQmk/g46k0R59dhhPOvh+ww1Z8Ha+ICJdCFfJxaNfLJX5ZFKC@lists.infradead.org
X-Gm-Message-State: AOJu0YxPbSVEU9L2eGAyCDMb4etSc/ZBopJZZPYFaxzaDh6c/YHMFGq7
	W9Uvq/JdALkgUAHM1ZG9WOW41HIhzp6kL5h8j7Too63g/LGMHIjKlj44a4t333q39TA=
X-Gm-Gg: ASbGncsC9vBz1xplboyogVQsTkIAbqOnn+kGNwz7Kzb4BfsT8BIq9KaeBCO39f5OJgn
	U28ltkPgIA+1cvSpT+STndXSeUDneloKriNJIJJ8ai8/A2xB9hUz6b1eiXKsyuAek1GyI5xpuDi
	8hge9Gz0E0IveL82CPtrEFDgAWS9TMgZzEqIOFYHKfF6VMWceddiz/rmnJuoOJ+CFFp9nSxeQLY
	0S2ugT7vks1IYf6KPI3cgX1uOPCtLcewglPEHCwlLxAa/4MCrma66pdRhT4872knJm6k52OHSTB
	zPDFdwkRrlXzT4nq/QjcY6Qct8fcOJBklo5g/Hte5mVpCJX4Xn3Z510oLabOo0tVDuw6s9/2mi3
	rUuQdW2pH6f20UhhoFEB8KLC2wQdp1V8UDOYkK9/C0C+UW+WTj6ps1u57PUQ5Mak1MeRleE4fES
	wY+Q==
X-Google-Smtp-Source: AGHT+IEmRlVKCe07qbgo1t2w3uFpBKsqx62crTftDC+8sZ0oUBIrcGL53VTRakva//fmnWvcfQrQww==
X-Received: by 2002:a05:6e02:1c01:b0:433:1d5a:5157 with SMTP id e9e14a558f8ab-435aa88e822mr21434775ab.6.1763650367018;
        Thu, 20 Nov 2025 06:52:47 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b954b207d7sm1008611173.33.2025.11.20.06.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 06:52:46 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, david.laight.linux@gmail.com
Cc: Alan Stern <stern@rowland.harvard.edu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Alexei Starovoitov <ast@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Andrew Lunn <andrew@lunn.ch>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Ard Biesheuvel <ardb@kernel.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Borislav Petkov <bp@alien8.de>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Christoph Hellwig <hch@lst.de>, Daniel Borkmann <daniel@iogearbox.net>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, David Ahern <dsahern@kernel.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 "David S. Miller" <davem@davemloft.net>, Dennis Zhou <dennis@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Jiri Slaby <jirislaby@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 John Allen <john.allen@amd.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Juergen Gross <jgross@suse.com>, Kees Cook <kees@kernel.org>, 
 KP Singh <kpsingh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Mika Westerberg <westeri@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Miklos Szeredi <miklos@szeredi.hu>, Namhyung Kim <namhyung@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, nic_swsd@realtek.com, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Olivia Mackall <olivia@selenic.com>, Paolo Abeni <pabeni@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Huewe <peterhuewe@gmx.de>, 
 Peter Zijlstra <peterz@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Sean Christopherson <seanjc@google.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>, 
 Theodore Ts'o <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>, 
 Tom Lendacky <thomas.lendacky@amd.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, x86@kernel.org, 
 Yury Norov <yury.norov@gmail.com>, amd-gfx@lists.freedesktop.org, 
 bpf@vger.kernel.org, cgroups@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, io-uring@vger.kernel.org, 
 kvm@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-cxl@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-mm@kvack.org, 
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org, 
 usb-storage@lists.one-eyed-alien.net, David Hildenbrand <david@kernel.org>
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Subject: Re: (subset) [PATCH 00/44] Change a lot of min_t() that might mask
 high bits
Message-Id: <176365036384.566630.2992984118137417732.b4-ty@kernel.dk>
Date: Thu, 20 Nov 2025 07:52:43 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251120_065248_600987_B401D0D9 
X-CRM114-Status: GOOD (  13.62  )
X-Mailman-Approved-At: Fri, 21 Nov 2025 08:32:39 -0800
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


On Wed, 19 Nov 2025 22:40:56 +0000, david.laight.linux@gmail.com wrote:
> It in not uncommon for code to use min_t(uint, a, b) when one of a or b
> is 64bit and can have a value that is larger than 2^32;
> This is particularly prevelant with:
> 	uint_var = min_t(uint, uint_var, uint64_expression);
> 
> Casts to u8 and u16 are very likely to discard significant bits.
> 
> [...]

Applied, thanks!

[12/44] block: use min() instead of min_t()
        commit: 9420e720ad192c53c8d2803c5a2313b2d586adbd

Best regards,
-- 
Jens Axboe




