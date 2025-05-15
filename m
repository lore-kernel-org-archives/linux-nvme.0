Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1EDC3ABDD
	for <linux-nvme@archiver.kernel.org>; Thu, 15 May 2025 19:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mDgKha8Mvg0JAQ/SjGW3x+GqfdnE0RD9BNggcIcuKkc=; b=mHOMcuzFe9OszxoM5EG8nU3Lwo
	HIwJIMtoKv9gDwAHXUBsehUuqS1EnDIDMNLjIhd3L5Oxofi790VRv40EHgqVuEJuZW8d9u52TO5R9
	L1PZB00/CpRfXfLWE6NF4PV3zGIz6Lx1el7YoLjr7kQ+QEG3dH70GKy4zfEUZLW/bXUzRXPblVWH+
	1523IZ7fXU+hjaAsx5b2PXkXDDD2eQRNjiMszhmiqnfUvvCH38GNL7R3flFhAutu9yU+XRbo/NeeT
	FaRJ7x3s1c9n8hwNOFOsvAXtb4uL9qDocpVxAkHc3eN8u5zlVGRwLTdd5RGN/ph/Anh6HFTSUcJDa
	/3kFoURQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFe9O-00000001flv-1YXe;
	Thu, 15 May 2025 19:21:50 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFe9K-00000001fjs-2DfV
	for linux-nvme@lists.infradead.org;
	Thu, 15 May 2025 19:21:49 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3a0bd7f4cd5so1147823f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 15 May 2025 12:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747336904; x=1747941704; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDgKha8Mvg0JAQ/SjGW3x+GqfdnE0RD9BNggcIcuKkc=;
        b=Jnsg7ZyCZ1S9o4Tt+5EAzGNx8rpC0B0Q3Wnoj8E0S7CNIBjZZVUWfwsqr1z5PnOoQS
         3M7rGLviPLZ3swKQIS9xMJbKf6FByzw/7oDI8DZII7vap8qcMyPlH5FuRdd52pW3aT6J
         erm5qnsoZHumrYimsjTf9rZ8uXG7xrFRToK/s8X0pjKbrV7TgWJ4Rj+lQyukCl4Dbo1k
         2yaQWz3NVpr+vmUiSJQCJMBfBd1PHN0QdjaCL24ZkjLNPDzBnS/nuM89uy9ToPd6T7u7
         12JHiriEuEgwMqdLZm7LUlm53TVxQkhQEitARck6UQNv5xnlw+LlxqbcUHKqaTbaZON9
         4A3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747336904; x=1747941704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDgKha8Mvg0JAQ/SjGW3x+GqfdnE0RD9BNggcIcuKkc=;
        b=tCDeaeO9pGZ1BTRxM4p2yJ5p6BRjOZsDRcewhoY0M8s8W66mWeTtfvrHRLhE16Sma5
         g+8foE1g8kLKH1Yuf+ywp32u15bncNeoDyUbFBOPSJ67VEAdTrEGGD9Dd7UX5msox3OM
         m4qSFvmHj53xZillQKltBctD889JJ4akQbWM06T3Zc06VcXRwtXFTY07x3DLk4/YYYoO
         Sz7A+CrrSeYQzI9CB9cgzfXgU3dDPgQv+agH9PslZ8LQ1QNQVvVkUORG/+9zQNvewvOi
         3DYVxDs0P7lNNZ9j9/xqkSUs3RlOJ+oFbqK1AGyTLIep7odgc2SyZOnmmeq/5pP35P6t
         Yd3A==
X-Forwarded-Encrypted: i=1; AJvYcCU51qEPkq0617Krxnpo1PpxHwA3tIz2cUXDNsRQSfnJYMPBMVvCr0Vr61o3n9KlqkXmi9D6IrS8sEYB@lists.infradead.org
X-Gm-Message-State: AOJu0Yw++GYEU2NFBdJPIuDRbR8KHaVETCaDjvkm01eh62pa4FzJMYrX
	ctHb5gEtpv8k4R2G81edr0x8BxnbJTgEoTVqjaql0EYVycKbrMIxj9Ls
X-Gm-Gg: ASbGncuIY1boTOCO2MBvITw4Mqtn+05TjpX64+tDEfzBbPtcHxTLgbjxAYDL9+KJ2h0
	MlO/AoVnpJi3OhiqP9U2iDjAdRaOKPN27upWNul2iCGRrJVR7Hrbm0OWkMDeC9lsH3bNOZfgYBi
	xrUPRf93QB2773u/WGwefzzkOPZWKmXdDnxu1VNiI6bz1qSBgDnbnNva9hSMVFbhN8rsdUpNiMT
	xBLNQUB4kuL0Qn44vUh0EnlA1c8W3D95aI17YViLK1f1Bmm7xGP/9UlegKb19s4oJrMgnZKcKzl
	amkOF0RQfw02XXelAqGKRSsXZFuLQV4yByy8RlN8vk7CfYmCqxc8RxFJUY9QlQxnwE63o//jEmC
	qJELysda0ueTfsw==
X-Google-Smtp-Source: AGHT+IEErv75ySz7SPIWQxReFuvVqrBn08S2Tj1lWQLN0bVqYJE1NAor3PrV0mVxMNg0j179PRXNjQ==
X-Received: by 2002:a05:6000:2af:b0:3a0:ad55:c9f2 with SMTP id ffacd0b85a97d-3a35c808d10mr1223950f8f.1.1747336904253;
        Thu, 15 May 2025 12:21:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd583fb7sm6501185e9.32.2025.05.15.12.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 12:21:43 -0700 (PDT)
Date: Thu, 15 May 2025 20:21:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Sagi Grimberg
 <sagi@grimberg.me>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C
 computation
Message-ID: <20250515202136.32b4f456@pumpkin>
In-Reply-To: <20250511230750.GA87326@sol>
References: <20250511004110.145171-1-ebiggers@kernel.org>
	<b9b0f188-d873-43ff-b1e1-259e2afdda6c@lunn.ch>
	<20250511172929.GA1239@sol>
	<fe9fdf65-8eb1-4e33-88ce-4856a10364b2@lunn.ch>
	<CAMj1kXFSm9-5+uBoF3mBbZKRU6wK9jmmyh=L538FoGvZ1XVShQ@mail.gmail.com>
	<20250511230750.GA87326@sol>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_122146_574092_9FF3C733 
X-CRM114-Status: GOOD (  36.76  )
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

On Sun, 11 May 2025 16:07:50 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> On Sun, May 11, 2025 at 11:45:14PM +0200, Ard Biesheuvel wrote:
> > On Sun, 11 May 2025 at 23:22, Andrew Lunn <andrew@lunn.ch> wrote:  
> > >
> > > On Sun, May 11, 2025 at 10:29:29AM -0700, Eric Biggers wrote:  
> > > > On Sun, May 11, 2025 at 06:30:25PM +0200, Andrew Lunn wrote:  
> > > > > On Sat, May 10, 2025 at 05:41:00PM -0700, Eric Biggers wrote:  
> > > > > > Update networking code that computes the CRC32C of packets to just call
> > > > > > crc32c() without unnecessary abstraction layers.  The result is faster
> > > > > > and simpler code.  
> > > > >
> > > > > Hi Eric
> > > > >
> > > > > Do you have some benchmarks for these changes?
> > > > >
> > > > >     Andrew  
> > > >
> > > > Do you want benchmarks that show that removing the indirect calls makes things
> > > > faster?  I think that should be fairly self-evident by now after dealing with
> > > > retpoline for years, but I can provide more details if you need them.  
> > >
> > > I was think more like iperf before/after? Show the CPU load has gone
> > > down without the bandwidth also going down.
> > >
> > > Eric Dumazet has a T-Shirt with a commit message on the back which
> > > increased network performance by X%. At the moment, there is nothing
> > > T-Shirt quotable here.
> > >  
> > 
> > I think that removing layers of redundant code to ultimately call the
> > same core CRC-32 implementation is a rather obvious win, especially
> > when indirect calls are involved. The diffstat speaks for itself, so
> > maybe you can print that on a T-shirt.  
> 
> Agreed with Ard.  I did try doing some SCTP benchmarks with iperf3 earlier, but
> they were very noisy and the CRC32C checksumming seemed to be lost in the noise.
> There probably are some tricks to running reliable networking benchmarks; I'm
> not a networking developer.  Regardless, this series is a clear win for the
> CRC32C code, both from a simplicity and performance perspective.  It also fixes
> the kconfig dependency issues.  That should be good enough, IMO.
> 
> In case it's helpful, here are some microbenchmarks of __skb_checksum (old) vs
> skb_crc32c (new):
> 
>     Linear sk_buffs
> 
>         Length in bytes    __skb_checksum cycles    skb_crc32c cycles
>         ===============    =====================    =================
>                      64                       43                   18
>                    1420                      204                  161
>                   16384                     1735                 1642
> 
>     Nonlinear sk_buffs (even split between head and one fragment)
> 
>         Length in bytes    __skb_checksum cycles    skb_crc32c cycles
>         ===============    =====================    =================
>                      64                      579                   22
>                    1420                     1506                  194
>                   16384                     4365                 1682
> 
> So 1420-byte linear buffers (roughly the most common case) is 21% faster,

1420 bytes is unlikely to be the most common case - at least for some users.
SCTP is message oriented so the checksum is over a 'user message'.
A non-uncommon use is carrying mobile network messages (eg SMS) over the IP
network (instead of TDM links).
In that case the maximum data chunk size (what is being checksummed) is limited
to not much over 256 bytes - and a lot of data chunks will be smaller.
The actual difficulty is getting multiple data chunks into a single ethernet
packet without adding significant delays.

But the changes definitely improve things.

	David


> but other cases range from 5% to 2500% faster.  This was on an AMD Zen 5 processor,
> where the kernel defaults to using IBRS instead of retpoline; I understand that
> an even larger improvement may be seen when retpoline is enabled.
> 
> But again this is just the CRC32C checksumming performance.  I'm not claiming
> measurable improvements to overall SCTP (or NVME-TLS) latency or throughput,
> though it's possible that there are.
> 
> - Eric
> 


