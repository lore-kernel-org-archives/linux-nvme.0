Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA95DC5DF6D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 09:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uEQja2fMn5Jy6OIdEB2XghK8YPZmIjUAswc+iTVOh50=; b=WKiXfyclih6jmpdTwfJpAorFxZ
	/zafybRS9azsVB6ddKwndB8UeTo3xZwn8hTkC8YFgh9V7FE7MvUW8zzA/Quaxn8P1iR98A35grxcP
	ewoq9JsyolcjI52ZQgfI6GQT0k5wM3znUNw+4Jrhpw83/BMoOVGm44aJS3OP9zyyY4Ranyn0Kralu
	qRd502vsW3VAh5z1wRXbfJF7lT+CFpcEAuk5cvw7OLR2jEBx6+VAAscp21KMN5mSgo0+DQq/RnmDK
	/MsvvB7ylzjC6CmYfAGP3doK1r1jo2ISOILvm11alizCVl0lMrH03/BqdbkI2ABjRF+hlFi8Bmh8E
	gju1ZR9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwcE3-00000009Mw1-0Clq;
	Wed, 19 Aug 2026 09:04:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwcE0-00000009MvA-2D38
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 09:04:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC4A468C7B; Wed, 19 Aug 2026 11:04:39 +0200 (CEST)
Date: Wed, 19 Aug 2026 11:04:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geliang Tang <geliang@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	mptcp@lists.linux.dev, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v4 1/4] nvmet-tcp: unify sockopt with do_sock_setsockopt
Message-ID: <20260819090439.GB9267@lst.de>
References: <cover.1786947923.git.tanggeliang@kylinos.cn> <010e6810cc4c10b30237c964b2bb9dfa7a3c740c.1786947923.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010e6810cc4c10b30237c964b2bb9dfa7a3c740c.1786947923.git.tanggeliang@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_020444_766263_8A17CA73 
X-CRM114-Status: GOOD (  17.53  )
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

On Tue, Aug 18, 2026 at 02:03:00PM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch consolidates socket option settings in nvmet-tcp by utilizing
> the generic do_sock_setsockopt() helper for options including SO_LINGER,
> SO_PRIORITY, SO_REUSEADDR, TCP_NODELAY, and IP_TOS. This change eliminates
> the need to export and use specialized helpers for each individual socket
> option.

Hmm.  I see that do_sock_setsockopt is exported, but it really should
not be.  It's really just an internal helper exposed for io_uring
and no modular code should be using it (never mind the non-GPL export).

> A key benefit of this refactoring is that it decouples the socket option
> configuration from the underlying transport protocol. This makes it
> easier to extend nvmet-tcp to support other protocols, such as MPTCP, in
> the future, as do_sock_setsockopt() abstracts away protocol-specific
> differences without requiring per-option protocol-specific wrappers.

We really should have generic helpers in the networking code for this
and not duplicate them in driver using socket options.


