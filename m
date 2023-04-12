Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E13C77B6E
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 15:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jVIUX30CHSeuMRIZ4MbX/VFPgD+9bUpANKvI3RmLVRc=; b=J8vXzXXhjyd+Xd2o6B2jmhlU/B
	k3Oe4at4VozRng+1amtAj5+3lsAGczURw7lvWxG2xf0obis6mQ5jxhB1zgE6oY8d/Z6ROaXmJN2Zv
	qNo35jySlhWYRpgaQ3NUq8T1mybKIb7/0C03oWLQZhzF6UO9ppOhj/6v0fd/dWuqTbH+i9riTl65q
	thLoQpJvRy2H7PWT7+BUISUP76I3DgSZM/Q2pb7BYvypTSKVSzJHyqRUHqvIN9ntH55ozTPYxgJkt
	UUvkoV6i5J5pF0TYenG5mMy5RBAWwPPoNUEr/GazLG+MY3DcsdcLpQ3ZGPjO2Ey9lcoMl1ocreXys
	asu8AVEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmcSS-003dzs-0C;
	Wed, 12 Apr 2023 15:32:28 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pmcRi-003dp9-1Q;
	Wed, 12 Apr 2023 15:31:42 +0000
Date: Wed, 12 Apr 2023 08:31:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Jeroen de Borst <jeroendb@google.com>,
	Catherine Sullivan <csully@google.com>,
	Shailend Chand <shailend@google.com>, Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH net-next v6 04/18] mm: Make the page_frag_cache allocator
 use per-cpu
Message-ID: <ZDbO3haK/1+7xdRC@infradead.org>
References: <20230411160902.4134381-1-dhowells@redhat.com>
 <20230411160902.4134381-5-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411160902.4134381-5-dhowells@redhat.com>
X-Mailman-Approved-At: Wed, 12 Apr 2023 08:32:25 -0700
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

On Tue, Apr 11, 2023 at 05:08:48PM +0100, David Howells wrote:
> Make the page_frag_cache allocator have a separate allocation bucket for
> each cpu to avoid racing.  This means that no lock is required, other than
> preempt disablement, to allocate from it, though if a softirq wants to
> access it, then softirq disablement will need to be added.

Can you show any performance numbers?

> Make the NVMe, mediatek and GVE drivers pass in NULL to page_frag_cache()
> and use the default allocation buckets rather than defining their own.

Let me ask a third time as I've not got an answer the last two times:
why are these callers treated different from the others?


