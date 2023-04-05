Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99EAC76188
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Apr 2023 15:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=48zfX+R4D/KjMsx+hDA/cvkhA+0xsbJ5NdemC9lhYPY=; b=QpL7HeDPGrVLfBqCgQA+XuPw1s
	jVVITZjQ9OAhAEp+hd4hqj/gZwIVU0qbgcZxLp5U5BBBUYwwPmJ1BcPciqnCGayqtlBB27Fe4rM/J
	CTX0nAlaopjaGIhA/BrdZks4A3vVhQ7Up4lnEfiXiqwfbW7VbrjIxe/q3a/Z6LHFNqRAqdkZcqTwp
	FHu6Fn4YJiyxV6sSb28YlU22FKgcdqob4vZ44cHRaN6InIfntKP4mcvd/2iyixMFjJ1nws5AelX4U
	mled+Gf1IyuWmSalaSBN03kZoH7I8FxyVRrP9kfvRXzmfgej17gFA/P3RzfJQaiv6ZvfmzE+1Za97
	6xI6paMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pk4h1-004kwQ-0D;
	Wed, 05 Apr 2023 15:04:59 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1pk4gy-004kve-08;
	Wed, 05 Apr 2023 15:04:56 +0000
Date: Wed, 5 Apr 2023 08:04:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever III <chuck.lever@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 06/55] mm: Make the page_frag_cache allocator use
 per-cpu
Message-ID: <ZC2OGCxXj2QfQhtJ@infradead.org>
References: <20230331160914.1608208-1-dhowells@redhat.com>
 <20230331160914.1608208-7-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331160914.1608208-7-dhowells@redhat.com>
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

On Fri, Mar 31, 2023 at 05:08:25PM +0100, David Howells wrote:
> Make the page_frag_cache allocator have a separate allocation bucket for
> each cpu to avoid racing.  This means that no lock is required, other than
> preempt disablement, to allocate from it, though if a softirq wants to
> access it, then softirq disablement will need to be added.

Can you split this into a separte series?  Right now I only see this
patch in mbox and miss the context on why wed want this.

> Make the NVMe and mediatek drivers pass in NULL to page_frag_cache() and
> use the default allocation buckets rather than defining their own.

Can you explain why?

