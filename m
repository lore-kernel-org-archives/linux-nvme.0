Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC15EB64DA
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 16:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VmI3so5b9Uv275rlHS6GxiDuimwR9UYHvzNYBjFZRg8=; b=UNXwR6PVUb+/FDX3InNs7G718E
	5xcwKE4U1rwpQjObw/YhCkGrbj6GPwhKvL9UGPioxp0yJ11BZ4TZE7Y6luBeLnzsRDbI3uKO21izt
	1mzQRnNyKce0KtX7Rf/iQqOhG8n1T4odWYb4Yt90XvcEQtT5y0FbOdN4UKgbT4ce5r0wnhYZ5kddD
	vhT8jJXy0U4KZ8YPVJvAH/JSFXIgXkNyROPJod60+GhCoKg3ch1DymKK+xFoWH3ksGFMlDGFCRDpL
	/g+AHsqoN8INogawQ35D9oDW6KWO2sTBMFJY6zVTBR99Jydqm6dz8Ogmm3/5+MADEntFKNNKAIX3f
	twEvWKhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFGhu-0041Jn-2f;
	Fri, 30 Jun 2023 16:10:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFGhr-0041J8-2n
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 16:10:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 61E786178A;
	Fri, 30 Jun 2023 16:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10FFC433C8;
	Fri, 30 Jun 2023 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688141446;
	bh=65l3uxIkPZ2teqmqxsQP31N9JJV0zpume1JU++/LnAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dq19zYXMqF5Odo1p5GFM9j0nL2LZbW9qCerBaCPD8Oh6xhb8sATyqGZUXXM9H9unc
	 eRT4kJN5byP86KaZkhnglG8iXD2T0YGHFmLTrQrj3hvDckwk2jEc9VSNh2t9S/gxtJ
	 0Dx4t8ni/nfwppvYEAAUncwVBPXcvfHU7DJrXLg3fET5wHbfrq5/jlIApbGWZ57tzU
	 idF/ITTbqiOgio39UFgA608R07VkW9agfG8sIhl0EcPgKzi45w4hBlJ3dOUUDCHDjR
	 kxdILhNhzz3xw0Nm/HMh5YNMZKfqYFnsjYN/yyZRKtIIckltFJimgsA/AudefjbpOn
	 X66t6KgUID+dQ==
Date: Fri, 30 Jun 2023 09:10:43 -0700
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
Message-ID: <20230630161043.GA2902645@dev-arch.thelio-3990X>
References: <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <20230620145338.1300897-1-dhowells@redhat.com>
 <20230620145338.1300897-11-dhowells@redhat.com>
 <58466.1688074499@warthog.procyon.org.uk>
 <20230629164318.44f45caf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230629164318.44f45caf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_091047_971776_142CF36B 
X-CRM114-Status: GOOD (  16.07  )
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

On Thu, Jun 29, 2023 at 04:43:18PM -0700, Jakub Kicinski wrote:
> On Thu, 29 Jun 2023 22:34:59 +0100 David Howells wrote:
> >                 if (!sendpage_ok(page))
> > -                       msg.msg_flags &= ~MSG_SPLICE_PAGES,
> > +                       msg.msg_flags &= ~MSG_SPLICE_PAGES;
> 
> 😵️
> 
> Let me CC llvm@ in case someone's there is willing to make 
> the compiler warn about this.
> 

Turns out clang already has a warning for this, -Wcomma:

  drivers/nvme/host/tcp.c:1017:38: error: possible misuse of comma operator here [-Werror,-Wcomma]
   1017 |                         msg.msg_flags &= ~MSG_SPLICE_PAGES,
        |                                                           ^
  drivers/nvme/host/tcp.c:1017:4: note: cast expression to void to silence warning
   1017 |                         msg.msg_flags &= ~MSG_SPLICE_PAGES,
        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        |                         (void)(                           )
  1 error generated.

Let me do some wider build testing to see if it is viable to turn this
on for the whole kernel because it seems worth it, at least in this
case. There are a lot of cases where a warning won't be emitted (see the
original upstream review for a list: https://reviews.llvm.org/D3976) but
something is better than nothing, right? :)

Cheers,
Nathan

