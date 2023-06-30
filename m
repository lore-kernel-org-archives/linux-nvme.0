Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30A7EB64D7
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 16:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kB33pndS5vV/ESSwLE8QYADv8BYywynVrNEBLXlX9Ng=; b=FxLpfDyc/u/s2CcOELacWLt0fX
	mGTTYK99zM6u1ceap2EavDKI3eAGGNIoL8l5WYk5jjFMacY2vLaN8h3WyEnPUawsacIjQEHGCy1Nn
	y+Ea9d9RcEj29xgvkPCheM5WVfOLpYXCnxAQlKwln14nWL9WiuAc7DdxMPVFdQe5hzOt2kArYuAe2
	8ZcR/0BSfsj21tsX5niG75j09uNy32JQRTBWBTIf8HPsU6iScxiYaysyQqqs/7fkutx8plLWidoKS
	JWD/sOb9wMAUtVRSFMIOtmqeYvEg3loGiQRZ6BQKrLBeF2yZF0xcexuQsgaHL1guILwvzHRdn9MJ9
	GtfDpSjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFGlj-0041fS-2c;
	Fri, 30 Jun 2023 16:14:47 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFGlg-0041ed-2E
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 16:14:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 069346178A;
	Fri, 30 Jun 2023 16:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C914CC433C8;
	Fri, 30 Jun 2023 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688141683;
	bh=OQ6W9Mf8SjuyriHv2gHrYTgggbQw7sK3MPN4gMZ87ZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WAwX+Yr1sAkgsIUXUcFV1FByBoFxm26kJ7kIXPDZuGZE6iqLBI4Ji4g8eHF9X4TSf
	 FZtftQgV87fi5h6nmkFhmUYeD4+za+zR5E2WkJqQVxhUmIEQOKUjm75ZQitaGSzk4J
	 0OrJqdu7MlktJKEdYMUYINhOzGyzvwS7S17WgDP1iUbaNYmxxfgBXY3DEyz+shCASI
	 ziTLDz9Y8rHUXBphJJXTXNIwHHHo4meZmPD/qhmizwVEX8m9VH+O/8vzoVL1+RILxf
	 yyLfKRBJM1M/Kl0fMmQn+t8c8s4Z/nZAuv8TJUfSnr1vtWj9rA1ccEucxd/97CeE9d
	 XUagxkK+qJVIQ==
Date: Fri, 30 Jun 2023 09:14:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Aurelien Aptel <aaptel@nvidia.com>,
 netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Sagi Grimberg
 <sagi@grimberg.me>, Willem de Bruijn <willemb@google.com>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
 <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use
 sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Message-ID: <20230630091442.172ec67f@kernel.org>
In-Reply-To: <20230630161043.GA2902645@dev-arch.thelio-3990X>
References: <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
	<20230620145338.1300897-1-dhowells@redhat.com>
	<20230620145338.1300897-11-dhowells@redhat.com>
	<58466.1688074499@warthog.procyon.org.uk>
	<20230629164318.44f45caf@kernel.org>
	<20230630161043.GA2902645@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_091444_767627_584190F5 
X-CRM114-Status: GOOD (  16.08  )
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

On Fri, 30 Jun 2023 09:10:43 -0700 Nathan Chancellor wrote:
> > Let me CC llvm@ in case someone's there is willing to make 
> > the compiler warn about this.
> 
> Turns out clang already has a warning for this, -Wcomma:
> 
>   drivers/nvme/host/tcp.c:1017:38: error: possible misuse of comma operator here [-Werror,-Wcomma]
>    1017 |                         msg.msg_flags &= ~MSG_SPLICE_PAGES,
>         |                                                           ^
>   drivers/nvme/host/tcp.c:1017:4: note: cast expression to void to silence warning
>    1017 |                         msg.msg_flags &= ~MSG_SPLICE_PAGES,
>         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         |                         (void)(                           )
>   1 error generated.
> 
> Let me do some wider build testing to see if it is viable to turn this
> on for the whole kernel because it seems worth it, at least in this
> case. There are a lot of cases where a warning won't be emitted (see the
> original upstream review for a list: https://reviews.llvm.org/D3976) but
> something is better than nothing, right? :)

Ah, neat. Misleading indentation is another possible angle, I reckon,
but not sure if that's enabled/possible to enable for the entire kernel
either :( We test-build with W=1 in networking, FWIW, so W=1 would be
enough for us.

