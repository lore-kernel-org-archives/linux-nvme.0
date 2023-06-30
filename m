Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47452EB64DC
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 19:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cSiCW/KaiQdJa3PcW0Gh5S6jFmVUK5U5vgrkY1SeBVY=; b=n2K8SoguGGsebPEQKHX2YIatz2
	EPLfRHqEiiTXvHhfYdt7+ZhYC9csyDV3uMpKoz/b95P+o04+b5X4U5JUYDsygqWQtG0LykVZKr9jc
	QfOVSkkYLhaqcBv+EbD31M+QfijUicnGHANLuRzAgCdk3jtm5E1+gk9QQbKtFOYsnwLwXF7JtrBJJ
	wxiWQmufHDGwBnO0BEi0JXxSns33Eh7jfL2oJ8e8Yv4DpvOBamVjp5J+M5pkFU/xNHnl1M4O5t0LM
	vV/risnejISpylWsl0GAneayFN4g9lijLpBvPq92BkJ4sk2nqMnPD+p2M0jEqBKvbGe1gb+6eluaN
	Xf/dTQ6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFJnE-004PNe-1f;
	Fri, 30 Jun 2023 19:28:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFJnB-004PMc-1L
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 19:28:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9BC2F617F4;
	Fri, 30 Jun 2023 19:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE726C433C0;
	Fri, 30 Jun 2023 19:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688153308;
	bh=zX7DtgKaXqa8tSnrkMuQTXY6UheSPHRSG4DhhcbKq+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ryup1iNS7cnCw2wiYI3YEs2N7PeCMaMxWV1gkQER97KVMF9lUTjIK9fzk3DQSkk6q
	 M+MqgMxaw01mt5CQJkyVoO9FEbADys+v/GY8cYOOAo8cGz0mR5z1t2Z2jbWiWBHe3a
	 2SUPqi1E9SO46ZJpEI6KSX8OMAPW2qgfncFFfHniX5QNV9jHuH2YBR0CH4Oe9KVhoC
	 Mi4/QItY+2LBUukkmIeMd8s+nPBYMevX7Wwbj1GsdziHcoAtWeZDF/tFvAn8Ar88eI
	 RjrS0eVk052IzxtszvnH8y3/MNlfF+v+hiJeG9qiwYwudNCWMxPTjEBAgyj6rmJdq9
	 JLEUuTBhVG9vA==
Date: Fri, 30 Jun 2023 12:28:25 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Aurelien Aptel <aaptel@nvidia.com>,
	netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Willem de Bruijn <willemb@google.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use
 sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Message-ID: <20230630192825.GA2745548@dev-arch.thelio-3990X>
References: <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <20230620145338.1300897-1-dhowells@redhat.com>
 <20230620145338.1300897-11-dhowells@redhat.com>
 <58466.1688074499@warthog.procyon.org.uk>
 <20230629164318.44f45caf@kernel.org>
 <20230630161043.GA2902645@dev-arch.thelio-3990X>
 <20230630091442.172ec67f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630091442.172ec67f@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_122829_533031_7DC9D39B 
X-CRM114-Status: GOOD (  25.81  )
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

On Fri, Jun 30, 2023 at 09:14:42AM -0700, Jakub Kicinski wrote:
> On Fri, 30 Jun 2023 09:10:43 -0700 Nathan Chancellor wrote:
> > > Let me CC llvm@ in case someone's there is willing to make 
> > > the compiler warn about this.
> > 
> > Turns out clang already has a warning for this, -Wcomma:
> > 
> >   drivers/nvme/host/tcp.c:1017:38: error: possible misuse of comma operator here [-Werror,-Wcomma]
> >    1017 |                         msg.msg_flags &= ~MSG_SPLICE_PAGES,
> >         |                                                           ^
> >   drivers/nvme/host/tcp.c:1017:4: note: cast expression to void to silence warning
> >    1017 |                         msg.msg_flags &= ~MSG_SPLICE_PAGES,
> >         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >         |                         (void)(                           )
> >   1 error generated.
> > 
> > Let me do some wider build testing to see if it is viable to turn this
> > on for the whole kernel because it seems worth it, at least in this
> > case. There are a lot of cases where a warning won't be emitted (see the
> > original upstream review for a list: https://reviews.llvm.org/D3976) but
> > something is better than nothing, right? :)

Well, that was a pipe dream :/ In ARCH=arm multi_v7_defconfig alone,
there are 289 unique instances of the warning (although a good number
have multiple instances per line, so it is not quite as bad as it seems,
but still bad):

$ rg -- -Wcomma arm-multi_v7_defconfig.log | sort | uniq -c | wc -l
289

https://gist.github.com/nathanchance/907867e0a7adffc877fd39fd08853801

Probably not a good sign of the signal to noise ratio, I looked through
a good handful and all the cases I saw were not interesting... Perhaps
the warning could be tuned further to become useful for the kernel but
in its current form, it is definitely a no-go :/

> Ah, neat. Misleading indentation is another possible angle, I reckon,
> but not sure if that's enabled/possible to enable for the entire kernel

Yeah, I was surprised there was no warning for misleading indentation...
it is a part of -Wall for both clang and GCC, so it is on for the
kernel, it just appears not to trigger in this case.

> either :( We test-build with W=1 in networking, FWIW, so W=1 would be
> enough for us.

Unfortunately, even in its current form, it is way too noisy for W=1, as
the qualifier for W=1 is "do not occur too often". Probably could be
placed under W=2 but it still has the problem of wading through every
instance and it is basically a no-op because nobody tests with W=2.

Cheers,
Nathan

