Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D46C3ABDD
	for <linux-nvme@archiver.kernel.org>; Thu, 15 May 2025 19:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/348H6EpqpOhG/eSBNtuzWB0J+LetiABoKaHQtr7rzs=; b=h9B1u1F6DqOvf/eT/9bkLGOR7A
	GVnRNMriJEIGZIPYRUpNvm6Mlso6oVJ//HtiJdT5gcV8tMYwezTb5+IdlbkUthTAcRXpO9J9VDoj9
	EGCGZEpPaj3dEvqMv+3ik7PL9i+BxW3C6IhrsfHt+Zf1H0RArXK5dbrjkExvpJsnWAwl8Jaw+q7SY
	bjaxARRwn6fmw8JolWYrvhchniwpcDdI5kgnqPvfnUhtgjYsf9/u6Xs05GG4/di0Psfxzjoaky+yl
	pMr8Wxucm2YUW58O6ltHttjLSeqbBu7q7HfGbpZL2QkFWdAUoA4jjfhfvK4fe1o4AQBzj4uoIk6ut
	0KYyyW0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFeee-00000001jPK-3VPa;
	Thu, 15 May 2025 19:54:08 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFebW-00000001ipP-1OXa
	for linux-nvme@lists.infradead.org;
	Thu, 15 May 2025 19:50:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BD88949D63;
	Thu, 15 May 2025 19:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066A2C4CEE7;
	Thu, 15 May 2025 19:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747338653;
	bh=kgfQ2FYbZjCZ/XYEQ8hsCXz1xRoSlsf5qPC9Zb25Quc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJCeGa03u+MXVXzYiYmzNrtGorUIgN+I8l+9BnFinR/vITYyXYIubK5Kngc0mb38l
	 7GNSrffkIG/TzhCgqLFYv5nlsDsXaQc4b6yI1esbaZRMFOnIqCxAqc3DsIlWvVdU4C
	 nUcD/bbgcll5ZALu3MLXl7eyzrBoiR5qUjU1zViVAiKDw9BAE0Qoigj0EE3YDuiLH5
	 rrhJnpvHfZcIBqZfWx0Eu1MTWmrC/UreYIh2/fwLkbrjsXurvvPL97ePeT6cs91MvV
	 X0N/2CNlUnuuZcAYnss/gPnJULUCnANZuEIGJq2ysIQj0uct/g8D4OGqFFcbxzCYpY
	 aeiWvnpn9MUoA==
Date: Thu, 15 May 2025 12:50:51 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C computation
Message-ID: <20250515195051.GK1411@quark>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <b9b0f188-d873-43ff-b1e1-259e2afdda6c@lunn.ch>
 <20250511172929.GA1239@sol>
 <fe9fdf65-8eb1-4e33-88ce-4856a10364b2@lunn.ch>
 <CAMj1kXFSm9-5+uBoF3mBbZKRU6wK9jmmyh=L538FoGvZ1XVShQ@mail.gmail.com>
 <20250511230750.GA87326@sol>
 <20250515202136.32b4f456@pumpkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515202136.32b4f456@pumpkin>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_125054_409148_2626F5A5 
X-CRM114-Status: GOOD (  36.13  )
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

On Thu, May 15, 2025 at 08:21:36PM +0100, David Laight wrote:
> On Sun, 11 May 2025 16:07:50 -0700
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > On Sun, May 11, 2025 at 11:45:14PM +0200, Ard Biesheuvel wrote:
> > > On Sun, 11 May 2025 at 23:22, Andrew Lunn <andrew@lunn.ch> wrote:  
> > > >
> > > > On Sun, May 11, 2025 at 10:29:29AM -0700, Eric Biggers wrote:  
> > > > > On Sun, May 11, 2025 at 06:30:25PM +0200, Andrew Lunn wrote:  
> > > > > > On Sat, May 10, 2025 at 05:41:00PM -0700, Eric Biggers wrote:  
> > > > > > > Update networking code that computes the CRC32C of packets to just call
> > > > > > > crc32c() without unnecessary abstraction layers.  The result is faster
> > > > > > > and simpler code.  
> > > > > >
> > > > > > Hi Eric
> > > > > >
> > > > > > Do you have some benchmarks for these changes?
> > > > > >
> > > > > >     Andrew  
> > > > >
> > > > > Do you want benchmarks that show that removing the indirect calls makes things
> > > > > faster?  I think that should be fairly self-evident by now after dealing with
> > > > > retpoline for years, but I can provide more details if you need them.  
> > > >
> > > > I was think more like iperf before/after? Show the CPU load has gone
> > > > down without the bandwidth also going down.
> > > >
> > > > Eric Dumazet has a T-Shirt with a commit message on the back which
> > > > increased network performance by X%. At the moment, there is nothing
> > > > T-Shirt quotable here.
> > > >  
> > > 
> > > I think that removing layers of redundant code to ultimately call the
> > > same core CRC-32 implementation is a rather obvious win, especially
> > > when indirect calls are involved. The diffstat speaks for itself, so
> > > maybe you can print that on a T-shirt.  
> > 
> > Agreed with Ard.  I did try doing some SCTP benchmarks with iperf3 earlier, but
> > they were very noisy and the CRC32C checksumming seemed to be lost in the noise.
> > There probably are some tricks to running reliable networking benchmarks; I'm
> > not a networking developer.  Regardless, this series is a clear win for the
> > CRC32C code, both from a simplicity and performance perspective.  It also fixes
> > the kconfig dependency issues.  That should be good enough, IMO.
> > 
> > In case it's helpful, here are some microbenchmarks of __skb_checksum (old) vs
> > skb_crc32c (new):
> > 
> >     Linear sk_buffs
> > 
> >         Length in bytes    __skb_checksum cycles    skb_crc32c cycles
> >         ===============    =====================    =================
> >                      64                       43                   18
> >                    1420                      204                  161
> >                   16384                     1735                 1642
> > 
> >     Nonlinear sk_buffs (even split between head and one fragment)
> > 
> >         Length in bytes    __skb_checksum cycles    skb_crc32c cycles
> >         ===============    =====================    =================
> >                      64                      579                   22
> >                    1420                     1506                  194
> >                   16384                     4365                 1682
> > 
> > So 1420-byte linear buffers (roughly the most common case) is 21% faster,
> 
> 1420 bytes is unlikely to be the most common case - at least for some users.
> SCTP is message oriented so the checksum is over a 'user message'.
> A non-uncommon use is carrying mobile network messages (eg SMS) over the IP
> network (instead of TDM links).
> In that case the maximum data chunk size (what is being checksummed) is limited
> to not much over 256 bytes - and a lot of data chunks will be smaller.
> The actual difficulty is getting multiple data chunks into a single ethernet
> packet without adding significant delays.
> 
> But the changes definitely improve things.

Interesting.  Of course, the data I gave shows that the proportional performance
increase is even greater on short packets than long ones.  I'll include those
tables when I resend the patchset and add a row for 256 bytes too.

- Eric

