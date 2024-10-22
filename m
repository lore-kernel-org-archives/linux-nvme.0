Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5953D1CDA1
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 07:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bIO1uz6Iq3DMaIpzwgmHkCJvIXKIUei7m6Qdnl8bIfM=; b=bFAN9VDG4BjRmWvxIEw56u2hgJ
	mpgM4xCHKNzV3XXiMAq4bn16xxvyPzlqFyn0nBtmEaV0tNhB3eY80xMX1ShTyO1zCgwVW5jMm3FCa
	swl1fOU1r/AXEcvqFN3a6derqWxmGdx3kkEldjnd14gijhHik3tj8ySyrtEYNJjSWPtY6hoY4/bSZ
	89f/ChxXoZ+wYT4oj4cG+zrZSKNyCFbTLONaqccBxGJ4GtCxfP+w+r3g1cZ2xWV62bEzNBN+VUq6G
	1/jwJ47sYhr5dTZDR55pEdwqr5iV1RU9YPKiTd3OIPLBfk5FmqZKb6NSBZHBX6TQpmuroz3eCQw6W
	IA/3i70w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t39Lp-00000009yjb-0fsX;
	Tue, 22 Oct 2024 07:30:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t39KP-00000009yXO-2r1Q
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 07:29:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BAAD1227AA8; Tue, 22 Oct 2024 09:29:13 +0200 (CEST)
Date: Tue, 22 Oct 2024 09:29:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: After the memory is released, the
 corresponding pointer needs to point to empty
Message-ID: <20241022072913.GA12854@lst.de>
References: <20241021190150.5974-1-liujing@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021190150.5974-1-liujing@cmss.chinamobile.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_002917_883507_93BF2950 
X-CRM114-Status: GOOD (  10.90  )
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

On Tue, Oct 22, 2024 at 03:01:50AM +0800, Liu Jing wrote:
> The code frees memory pointed to by dev->queues. After freeing memory,
> dev->queues should be set to NULL to avoid dangling Pointers.

How claims that?  Clearing pointers clearly defeats redzoning in the
slab allocator so actually is counterproductive.


