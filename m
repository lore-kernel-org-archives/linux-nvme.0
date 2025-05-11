Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF3FC3ABCB
	for <linux-nvme@archiver.kernel.org>; Sun, 11 May 2025 21:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RrNyqzWsoxW7PT7XBcAVPoXOI9p5Db8vQWoqbzcV3Bs=; b=qXQo1SpvVSW+lTj3gX7mKXzbbk
	Rart1rsURT5BYHuCBY+/hLIruKD8J+vL/mXuHbL1B3EEbaYogM+1Mz9YnwLyCGTon/eTyrhMkGYw0
	3pBYOe+VMGLQ8JgNVKR/3gURFgwXje5G5464AL4QsS1gvMYKHkQvy3E+pny/Hzqq8NHMVZ5ZaTdk2
	+iZW0RJzMvvpCywCWBL4XCO8ay2eHpTqm+jku3KC84LjXQmYDyascxVY6r2noVU+6nelVWuYHscQj
	bpOXvYE2B6PwO63ziOsKs/hvD7pI6+X+FDb3D4vos0kfEdn+TVCiumil7dowf8OpTE99G3Pkdjb+a
	4AECITpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEE7t-00000007tNy-0hjg;
	Sun, 11 May 2025 21:22:25 +0000
Received: from vps0.lunn.ch ([156.67.10.101])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEE7r-00000007tNV-0JTL
	for linux-nvme@lists.infradead.org;
	Sun, 11 May 2025 21:22:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RrNyqzWsoxW7PT7XBcAVPoXOI9p5Db8vQWoqbzcV3Bs=; b=MRsbE802EdcrNIsmJ9rJJrB3Gb
	J27nqulZChtl/IUzRLo3poP1dnDuJTs8ZhlIKJ8x9qAZ+/ZyE5k8nQ1WpXhwwKP/1iofIltl6bscw
	riU7Q4/Z1OGJ6K8fvVqPh8lhdHDfv9QaEDscHK/OeYuVs2oAX3HAEx5fYslxxk2ah4D0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uEE7l-00CHNm-T0; Sun, 11 May 2025 23:22:17 +0200
Date: Sun, 11 May 2025 23:22:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C computation
Message-ID: <fe9fdf65-8eb1-4e33-88ce-4856a10364b2@lunn.ch>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <b9b0f188-d873-43ff-b1e1-259e2afdda6c@lunn.ch>
 <20250511172929.GA1239@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250511172929.GA1239@sol>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250511_142223_113246_B9DFAD11 
X-CRM114-Status: GOOD (  14.87  )
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

On Sun, May 11, 2025 at 10:29:29AM -0700, Eric Biggers wrote:
> On Sun, May 11, 2025 at 06:30:25PM +0200, Andrew Lunn wrote:
> > On Sat, May 10, 2025 at 05:41:00PM -0700, Eric Biggers wrote:
> > > Update networking code that computes the CRC32C of packets to just call
> > > crc32c() without unnecessary abstraction layers.  The result is faster
> > > and simpler code.
> > 
> > Hi Eric
> > 
> > Do you have some benchmarks for these changes?
> > 
> > 	Andrew
> 
> Do you want benchmarks that show that removing the indirect calls makes things
> faster?  I think that should be fairly self-evident by now after dealing with
> retpoline for years, but I can provide more details if you need them.

I was think more like iperf before/after? Show the CPU load has gone
down without the bandwidth also going down.

Eric Dumazet has a T-Shirt with a commit message on the back which
increased network performance by X%. At the moment, there is nothing
T-Shirt quotable here.

	Andrew

