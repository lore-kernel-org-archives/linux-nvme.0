Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0999FC54FB3
	for <linux-nvme@archiver.kernel.org>; Mon, 26 May 2025 05:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lty3opDyvOSKgO5TDv9/JBceonUwAzrcj6BTrEpiKYk=; b=mOrYpTPrYUjUjhA+/M1xKUiZZD
	yff70v5Ejd/Z4BDxSRY7gULIAVk09cxjEuHchTVHFR2BbROXa/2ovzYtJwxrH/fl9Q66uCAI4umz2
	5fFZw8QVFukvYPLj4MRiVGmHLdJMubJeGCUiooxFxApdIAh4/PdthJvLQ34au7v7XWm4T3wwHmf3S
	23gfm+0hkc5NrNj7bgfy8LmYs8lbntqX4gGpY3fJMqbAMuDUt4CUqFv478uEn/r7bI3r8CmiNdmWE
	Qf7F6asPEtzIVGmVlAPfHSAJkTSu9u+OMTJd4f3i87Ce7kCwdwjDR4sL8p0CrW1XGjWTFy1TCX3th
	oNEp6XCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJQOo-000000086ka-0rEx;
	Mon, 26 May 2025 05:29:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJQOl-000000086jG-1c90
	for linux-nvme@lists.infradead.org;
	Mon, 26 May 2025 05:29:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2DF8068AFE; Mon, 26 May 2025 07:29:07 +0200 (CEST)
Date: Mon, 26 May 2025 07:29:07 +0200
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
Subject: Re: [PATCH v2 net-next 1/7] socket: Un-export __sock_create().
Message-ID: <20250526052907.GB11639@lst.de>
References: <20250523182128.59346-1-kuniyu@amazon.com> <20250523182128.59346-2-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523182128.59346-2-kuniyu@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250525_222919_913472_B7C348BF 
X-CRM114-Status: GOOD (  15.27  )
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

On Fri, May 23, 2025 at 11:21:07AM -0700, Kuniyuki Iwashima wrote:
> Since commit eeb1bd5c40ed ("net: Add a struct net parameter to
> sock_create_kern"), we no longer need to export __sock_create()
> and can replace all non-core users with sock_create_kern().
> 
> Let's convert them and un-export __sock_create().

The changes looks good, but the commit log including subject line
is rather confusing.  What you do is to replace all uses of
__sock_create with sock_create_kern, which works because
sock_create_kern just calls __sock_create with the last argument set
to 1 as those callers do it.  This then allows marking __sock_create
static because all outside users are gone.

Please state that, i.e.

Subect: use sock_create_kern insteadf of opencoding it

Replace all callers of __sock_create that set the kernel argument to 1
with sock_create_kern, which is the improve interface for that.
Mark __sock_create static now that all users outside of socket.c
are gone.


