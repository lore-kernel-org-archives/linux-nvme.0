Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A677C54FB3
	for <linux-nvme@archiver.kernel.org>; Mon, 26 May 2025 05:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r7TnUs9Y6q5QJtRnxyjKblo4JNawa1RKko7Pi1lwNhM=; b=l5HjFz/T1e8+/BHZ1RLQ9a/isg
	BQBk5HnSHT3DfzSP/0KXwZgDLf3kEndqIy9y7K2cHXKqbFOlMDyt8kMbszJ7wdXFJelnSrAbt1mmA
	LbEb8LmK5Ni6DbCv8obd3pYkX4vWTtCQRE0QHBveih1RM90HwwwJ7x6tQNQnmqS/8QAKCcjAIVzsU
	MZeTmf2jWSNlFi4HJq+2NJpxB+WCVSAjzE0itVwLFDTvU5E8s5TjEWTWn6JeGqUejjns+0AbNDxm+
	peEKdPw+V5RLZZEQvry51O/O+5eLVGkE5i30DhsXHqzqJfCB5CBB8DeIMNTquSFaA0Ym8i6exV6XJ
	YEcVhRyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJQTs-000000087YM-0lNU;
	Mon, 26 May 2025 05:34:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJQRu-000000087Ha-08pI
	for linux-nvme@lists.infradead.org;
	Mon, 26 May 2025 05:32:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 494D968AFE; Mon, 26 May 2025 07:32:27 +0200 (CEST)
Date: Mon, 26 May 2025 07:32:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Steve French <sfrench@samba.org>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 net-next 3/7] socket: Restore sock_create_kern().
Message-ID: <20250526053227.GD11639@lst.de>
References: <20250523182128.59346-1-kuniyu@amazon.com> <20250523182128.59346-4-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523182128.59346-4-kuniyu@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250525_223234_216260_7759A0EE 
X-CRM114-Status: GOOD (  18.13  )
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

On Fri, May 23, 2025 at 11:21:09AM -0700, Kuniyuki Iwashima wrote:
> Let's restore sock_create_kern() that holds a netns reference.
> 
> Now, it's the same as the version before commit 26abe14379f8 ("net:
> Modify sk_alloc to not reference count the netns of kernel sockets.").
> 
> Back then, after creating a socket in init_net, we used sk_change_net()
> to drop the netns ref and switch to another netns, but now we can
> simply use __sock_create_kern() instead.
> 
>   $ git blame -L:sk_change_net include/net/sock.h 26abe14379f8~
> 
> DEBUG_NET_WARN_ON_ONCE() is to catch a path calling sock_create_kern()
> from __net_init functions, since doing so would leak the netns as
> __net_exit functions cannot run until the socket is removed.

Is reusing the name as the old sock_create_kern a good idea?  It can
lead to bugs by people used to the old semantics.  It's also
not really an all that descriptive name for either variant.  I'm
not really a net stack or namespace expert, but maybe we can come
up with more descriptive version for both this new sock_create_kern
and the old sock_create_kern/__sock_create_kern?


