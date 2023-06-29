Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF701C0015E
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 23:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8DbnrhrxbHk10usug3uWD49kSFa46KFkJtYysT+9Mvs=; b=H4QkIz+z50O6M+EsBZDX/+p15x
	IGSzisBJMtJH5h2071WQchoxyCp9KzY9whAT94jjjsUt3zHEGwTCioDOGdmodWJucBmJxFvTUyqSf
	9F2KX3F5wXAyGg1bmWz07tbEsg9HesqD/K8dH4jQGJaO6dvZgA8rGsereDi/yK7SvrY6KkxjQHZ/L
	V/zXl8bFsKVrCIUVBKf5MUMGKPU1WhGei98A6C+I2TIrDEVxvExduU48Yt53Q3Y+J6lc5X4ypMVZ8
	yMg8vEQKytG8fFIKdZXBe5xb5e3vtf5Tm9ZSSqZPfP1wst5zmDqK+J8vj64AaqqJClP2hvFcMMR71
	Krl+tJHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qF1IK-002U6u-2G;
	Thu, 29 Jun 2023 23:43:24 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qF1IH-002U4q-2v
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 23:43:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B6816615A0;
	Thu, 29 Jun 2023 23:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DA5C433C9;
	Thu, 29 Jun 2023 23:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688082200;
	bh=KIYW1lUTJeQEkbIElm6us4axZkg9EmgFSwq92AAsf6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FAwxhF/sxTGaYZAjCNqCnXzM7+1IK6BDzDB725t8iS0GHPDcS1bhTM8BwwZl6JeVx
	 61w93PxTHNhifhYhOawcWoYmxCqnzubKSubp9DLbQgU5P8G5Z/IdzpHEVRCTKsikYr
	 I7EkcgcYNjVcKq2Id/oC2GgeGbmBqOPfYQqZC7PtYzGfRG+4O34EytEQW0oF0aqKAQ
	 803uYRUYut+Nfy4yz0+l6nAZLT68yUufkg5pNe0mCuD15bJ0+Q2Vj1FQ3H5TtaMdTm
	 SmurcO0ub7iNkhFWFvhRR4LvPCC0uoam7AqUJfZjdPBphlYAfCZynAHlsqyoRcpell
	 xnaG0uRIZVnag==
Date: Thu, 29 Jun 2023 16:43:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Aurelien Aptel <aaptel@nvidia.com>, netdev@vger.kernel.org, Alexander
 Duyck <alexander.duyck@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern
 <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jens Axboe
 <axboe@kernel.dk>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Sagi
 Grimberg <sagi@grimberg.me>, Willem de Bruijn <willemb@google.com>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
 <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next v3 10/18] nvme/host: Use
 sendmsg(MSG_SPLICE_PAGES) rather then sendpage
Message-ID: <20230629164318.44f45caf@kernel.org>
In-Reply-To: <58466.1688074499@warthog.procyon.org.uk>
References: <253mt0il43o.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
	<20230620145338.1300897-1-dhowells@redhat.com>
	<20230620145338.1300897-11-dhowells@redhat.com>
	<58466.1688074499@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230629_164322_005554_A34EADA7 
X-CRM114-Status: UNSURE (   8.77  )
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

On Thu, 29 Jun 2023 22:34:59 +0100 David Howells wrote:
>                 if (!sendpage_ok(page))
> -                       msg.msg_flags &=3D ~MSG_SPLICE_PAGES,
> +                       msg.msg_flags &=3D ~MSG_SPLICE_PAGES;

=F0=9F=98=B5=EF=B8=8F

Let me CC llvm@ in case someone's there is willing to make=20
the compiler warn about this.

