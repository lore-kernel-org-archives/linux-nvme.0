Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0FBC5CFC1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 07:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ICfq/A89vGwwI/ZNeZjvAwwT+bZkobqs9W9zzbxiRvU=; b=xfMgHXdu3aZIvHwAOwW8KoOn+5
	PY4tXUJ27oRKwOhFWD5zb6UJkZA2AfXNklFWxeew2PFhGfkkS9nCE0H3PuGag60qQ+XsoAkkRJVo0
	raZ12dKNTSg3gE164TECgEJ6l2DnxOx4HD2WIfeQyw8dm+froddjaIDU7pt+UAJSjX3e+tgGFTRlH
	TedIN0PdRZVKfsZDOeCyauB191yCthKYdYWw36j9eJo+iAPQKp7z7laVzPlnUkNn4A2dEVtVBijuY
	+LISPR/4WAHiFlltRC+qDqAHNKe/ws4fYy5wiq1ywHnk5jJoPwGy9gvBqERl0fKthxDKZW/dol4pR
	JpGoXe2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsEA-00000005bxR-3r6y;
	Mon, 17 Aug 2026 07:57:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvsE8-00000005bwn-3fXs
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 07:57:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2F2D568CFE; Mon, 17 Aug 2026 09:57:44 +0200 (CEST)
Date: Mon, 17 Aug 2026 09:57:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Saravanan D <saravanand@crusoe.ai>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: pin io_cpu to submitter cpu
Message-ID: <20260817075743.GA20887@lst.de>
References: <20260806023947.94680-2-saravanand@crusoe.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806023947.94680-2-saravanand@crusoe.ai>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_005749_071538_5416180F 
X-CRM114-Status: GOOD (  17.22  )
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

On Wed, Aug 05, 2026 at 07:39:44PM -0700, Saravanan D wrote:
> Adopt the submitting CPU of non passthrough requests as io_cpu. The
> submitter is a member of the map group by construction, and the
> nvme_tcp_cpu_queues accounting moves with each adoption. Passthrough
> commands do not participate since the io queue Connect arrives from an
> arbitrary group CPU via blk_mq_alloc_request_hctx(), so the first real
> read or write decides.

connect isn't the only passthrough command.  All your above reasoning
would apply to at least user passthrough commands as well.  Maybe
special casing connect is the better idea here?

> 
> Queues outlive the workloads that submit through them, so adoption
> re-arms after 30 seconds of queue quiet. An idle queue is reclaimed by
> its next submitter, while a busy queue keeps a stable io_cpu and
> cannot ping pong between two live submitters. Concurrent writers
> on different CPUs serialize on a cmpxchg on io_cpu.
> 
> The behavior is opt in via the new wq_adopt module parameter, default
> off and runtime writable. wq_unbound takes precedence when both are
> set.

I think you want this as an option at queue connect time.  Any specific
reason you picked the global module parameter?


