Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E81C3ABCB
	for <linux-nvme@archiver.kernel.org>; Sun, 11 May 2025 23:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uEjUKWNDXYIxFU3RNtMOk7TBXdEzqaQgDW3e1L/qCn4=; b=glC1bHuY2Yhdixdj6VgF5hOrRj
	E6ZsVJFXYfjOHSi6c6+pqNT9h+86HdVs30AJ+bbng1zAdpu+UQyQTKjA2/qYiO15Sxwbq+e5DQUTN
	MG/4pyryxL+2/hBLRKubo8FgGbibvQXqulmJ03t+KgSBMWtRkxk6zv2otrWOu4aUsFpadKcsDDDys
	hTTWdQnmpxMGLlQWaH2Sag8NVwBdhes+POrRAN9PHYa56eFHy4a24Nzsz0rdnDJxDBH4kovkeukF2
	YGOairFJ+n7mOJb5WVFIbInybNaZkJCsewBJEaY2Ht2ir8k4EfwRCEkqIaD7FqJfLGzAB5yMiThzn
	NYOgY55w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEFm7-00000007zlP-0ch0;
	Sun, 11 May 2025 23:08:03 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEFm4-00000007zkH-1Euz
	for linux-nvme@lists.infradead.org;
	Sun, 11 May 2025 23:08:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 64D62A4C6AB;
	Sun, 11 May 2025 23:07:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DECFC4CEE4;
	Sun, 11 May 2025 23:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747004878;
	bh=fiuu/FAQbicG4pdW+3WAgdDwC1anxMimVItK7oW/vC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3CfWdaUa/SHoDzg4TcXAnERwVXpypQXogaXwYM5lOY2y39H91goJLk96QHhbLGkp
	 ljSDBxeGI49fJId8Tw+agR7ZDo5WPjA3EmU2ojOPkmx4/f5fVSv7CzFtsh3Jf4hCET
	 sgGOwE8+iAAQZ9Sk5szx0OhOcUIzZASVN8qoEoiVhvWF2MJYOEPq0z4c1o1UwzRtJs
	 zk/ddWU7qDv6eR1dvd4m9IReHzL6ioABxXB8wpR3Wck6/eeGXf7rQnOVoMfYtVL/QG
	 woW1DAsjjbS9dpYQLhQO/TZKQAXuRmUUTLAiR215LAELHXL/6DbcXX7XykTsY2K0b9
	 lfi34PmvbTiwQ==
Date: Sun, 11 May 2025 16:07:50 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C computation
Message-ID: <20250511230750.GA87326@sol>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <b9b0f188-d873-43ff-b1e1-259e2afdda6c@lunn.ch>
 <20250511172929.GA1239@sol>
 <fe9fdf65-8eb1-4e33-88ce-4856a10364b2@lunn.ch>
 <CAMj1kXFSm9-5+uBoF3mBbZKRU6wK9jmmyh=L538FoGvZ1XVShQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFSm9-5+uBoF3mBbZKRU6wK9jmmyh=L538FoGvZ1XVShQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250511_160800_467906_F6EF9A23 
X-CRM114-Status: GOOD (  25.69  )
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

On Sun, May 11, 2025 at 11:45:14PM +0200, Ard Biesheuvel wrote:
> On Sun, 11 May 2025 at 23:22, Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Sun, May 11, 2025 at 10:29:29AM -0700, Eric Biggers wrote:
> > > On Sun, May 11, 2025 at 06:30:25PM +0200, Andrew Lunn wrote:
> > > > On Sat, May 10, 2025 at 05:41:00PM -0700, Eric Biggers wrote:
> > > > > Update networking code that computes the CRC32C of packets to just call
> > > > > crc32c() without unnecessary abstraction layers.  The result is faster
> > > > > and simpler code.
> > > >
> > > > Hi Eric
> > > >
> > > > Do you have some benchmarks for these changes?
> > > >
> > > >     Andrew
> > >
> > > Do you want benchmarks that show that removing the indirect calls makes things
> > > faster?  I think that should be fairly self-evident by now after dealing with
> > > retpoline for years, but I can provide more details if you need them.
> >
> > I was think more like iperf before/after? Show the CPU load has gone
> > down without the bandwidth also going down.
> >
> > Eric Dumazet has a T-Shirt with a commit message on the back which
> > increased network performance by X%. At the moment, there is nothing
> > T-Shirt quotable here.
> >
> 
> I think that removing layers of redundant code to ultimately call the
> same core CRC-32 implementation is a rather obvious win, especially
> when indirect calls are involved. The diffstat speaks for itself, so
> maybe you can print that on a T-shirt.

Agreed with Ard.  I did try doing some SCTP benchmarks with iperf3 earlier, but
they were very noisy and the CRC32C checksumming seemed to be lost in the noise.
There probably are some tricks to running reliable networking benchmarks; I'm
not a networking developer.  Regardless, this series is a clear win for the
CRC32C code, both from a simplicity and performance perspective.  It also fixes
the kconfig dependency issues.  That should be good enough, IMO.

In case it's helpful, here are some microbenchmarks of __skb_checksum (old) vs
skb_crc32c (new):

    Linear sk_buffs

        Length in bytes    __skb_checksum cycles    skb_crc32c cycles
        ===============    =====================    =================
                     64                       43                   18
                   1420                      204                  161
                  16384                     1735                 1642

    Nonlinear sk_buffs (even split between head and one fragment)

        Length in bytes    __skb_checksum cycles    skb_crc32c cycles
        ===============    =====================    =================
                     64                      579                   22
                   1420                     1506                  194
                  16384                     4365                 1682

So 1420-byte linear buffers (roughly the most common case) is 21% faster, but
other cases range from 5% to 2500% faster.  This was on an AMD Zen 5 processor,
where the kernel defaults to using IBRS instead of retpoline; I understand that
an even larger improvement may be seen when retpoline is enabled.

But again this is just the CRC32C checksumming performance.  I'm not claiming
measurable improvements to overall SCTP (or NVME-TLS) latency or throughput,
though it's possible that there are.

- Eric

