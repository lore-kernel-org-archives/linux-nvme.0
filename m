Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B20C3ABCB
	for <linux-nvme@archiver.kernel.org>; Sun, 11 May 2025 21:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e3BFrqyRphSjhqqOFqTIeqDEoOkelHeTvU+2xNSsOTQ=; b=DUlc+flLlJ7ltp8ArBLdZa6bE0
	RhyNuI56unGrWHrE4n1TIY86teVX4zcq4Ha4dvwLItL2gWmwY/MkiJhCrD7AzLRPlnCLuMuMyWdwG
	Ash0jG/5Y0Wwu2Dsw5WJkYdK4y1F5WRz2KgjRiRgb0YFcLQMwlPoJkab/QXKUIJuzdwfYx6LUapzU
	dB+YVWBX3nZS8JWIqfOsSsp0zX22ieFOoVTCAyUwKgQnW7v5PS7QLB2Q48d268vvDhz3qGqWiK+Is
	o5RLGKXOP/pyUSpY+ItMX68EzdMUbHIUrgTzT9S5Nvb4QV/LNZU029tK9F998sQgN06bF+mTohkHp
	4lLV3urQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEEUF-00000007uud-1lWz;
	Sun, 11 May 2025 21:45:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEEUD-00000007uuW-2BBr
	for linux-nvme@lists.infradead.org;
	Sun, 11 May 2025 21:45:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B157E61154
	for <linux-nvme@lists.infradead.org>; Sun, 11 May 2025 21:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3C4C4AF09
	for <linux-nvme@lists.infradead.org>; Sun, 11 May 2025 21:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746999927;
	bh=n6VR74UUrkjd7Li7mn4MUpvTWHM+Fg3QJMysU96a2vU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=D/ZRTasQquFXwKbPNKCYUM1NIuMwA6+YLiybYZawOMprx3ipPqVo6VWG2Ilfj52GF
	 Rr5XraDpe8fZyBTv3Noz21dBSrlpDmrQZd91yutike+MoWlDi4GxDIv2dKHWnYdlVC
	 4c8AsLyPsmHKuooiYd6PEd0mzGIo6qyWt/zFztGM79ib+cL5O6LqOvQvD/DKNUjVFn
	 O9smap/BiePuv1E1/pL7tAOcu/ws2OzMultORce4EgQ5aKaVfJAbjxOHtllEn/sDyH
	 RgYUbhjQsNpGB2FtShM4/G31GhUKnPZ+bTkBXxWFZs2TxVPOobN1ecSLXQodU+TONE
	 AV+k1my09wI0Q==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3105ef2a071so43720431fa.1
        for <linux-nvme@lists.infradead.org>; Sun, 11 May 2025 14:45:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUq15rf472YO+Q3xMKe9tluuABR74Eso2VEDW1G0+Le6o5w3QHWSKR+2KjVxr3wXu578FyiGTtGs4Gv@lists.infradead.org
X-Gm-Message-State: AOJu0YwXjhKXSafDVSrutOBL0tiWN2JtX+PSzzK26/N37GzhCOEia8EK
	n9wmrU44jYLZG+5iEkHjhjiZnkgxCGf9jn68yTfMJXBdaBDz3lu+qSqxY5iQZeDFdHlNTo5mocL
	I7oJrclino3KqffKhy0YFq3U/YYI=
X-Google-Smtp-Source: AGHT+IGXAKwBmsQgT+onQCTrcyVQm05O0hzEhnj9ZJ3lSI582XXe3FX+xmXCeVd+5a8Bm7iJP57f+ZUkw11acThSHag=
X-Received: by 2002:a2e:bc08:0:b0:31e:261a:f3e2 with SMTP id
 38308e7fff4ca-326c459db3amr41790571fa.1.1746999925705; Sun, 11 May 2025
 14:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250511004110.145171-1-ebiggers@kernel.org> <b9b0f188-d873-43ff-b1e1-259e2afdda6c@lunn.ch>
 <20250511172929.GA1239@sol> <fe9fdf65-8eb1-4e33-88ce-4856a10364b2@lunn.ch>
In-Reply-To: <fe9fdf65-8eb1-4e33-88ce-4856a10364b2@lunn.ch>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 11 May 2025 23:45:14 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFSm9-5+uBoF3mBbZKRU6wK9jmmyh=L538FoGvZ1XVShQ@mail.gmail.com>
X-Gm-Features: AX0GCFsoD-9jiD_NH_ReLAgqqMRiIecG31oMhtVBxXbocF6ZydM3nWnbvTXpTTA
Message-ID: <CAMj1kXFSm9-5+uBoF3mBbZKRU6wK9jmmyh=L538FoGvZ1XVShQ@mail.gmail.com>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C computation
To: Andrew Lunn <andrew@lunn.ch>
Cc: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 11 May 2025 at 23:22, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, May 11, 2025 at 10:29:29AM -0700, Eric Biggers wrote:
> > On Sun, May 11, 2025 at 06:30:25PM +0200, Andrew Lunn wrote:
> > > On Sat, May 10, 2025 at 05:41:00PM -0700, Eric Biggers wrote:
> > > > Update networking code that computes the CRC32C of packets to just call
> > > > crc32c() without unnecessary abstraction layers.  The result is faster
> > > > and simpler code.
> > >
> > > Hi Eric
> > >
> > > Do you have some benchmarks for these changes?
> > >
> > >     Andrew
> >
> > Do you want benchmarks that show that removing the indirect calls makes things
> > faster?  I think that should be fairly self-evident by now after dealing with
> > retpoline for years, but I can provide more details if you need them.
>
> I was think more like iperf before/after? Show the CPU load has gone
> down without the bandwidth also going down.
>
> Eric Dumazet has a T-Shirt with a commit message on the back which
> increased network performance by X%. At the moment, there is nothing
> T-Shirt quotable here.
>

I think that removing layers of redundant code to ultimately call the
same core CRC-32 implementation is a rather obvious win, especially
when indirect calls are involved. The diffstat speaks for itself, so
maybe you can print that on a T-shirt.

