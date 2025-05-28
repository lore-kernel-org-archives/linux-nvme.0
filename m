Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9287DC3ABB2
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 07:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o/VdYcODh0fa0SIBn/lhS7SE19ATz1ug168wcXxFUPY=; b=jI51ja4CySoPADDdAXKoGIbCRA
	hUFtjkQAS53o6ipia9liT3W1XormO9VnWurn3BQkH8v0f3w9ezblA/u01JAyNcHwT9/NxPaWMhAMb
	Z8NR7a7u6Eh7IkV4h9+uExMa4uN1kzM9ZKE9APGLKlSYuopRhI/fOCV/CmUUlChYZCTbpUHIySvwj
	mR5VmghQsPkUc/KDEg5vbI3xHj/TpWV1ucLh99/v1GGJFq3xsHQNZarwalQOTzMS2Q7t5QPm8er7S
	XouJCVipyZ2PnFCOXMsPw5dJVIIPXZ7XXzaOefGe8cqru4HunCKsFMhQUZAnc3ua/aLJxOFivSxyw
	7Q405Yrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKBUD-0000000CT02-18No;
	Wed, 28 May 2025 07:46:05 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKBUB-0000000CSzm-2e8O;
	Wed, 28 May 2025 07:46:03 +0000
Date: Wed, 28 May 2025 00:46:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Mark Harmstone <maharmstone@fb.com>
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aDa_O4HGWjy_35I7@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
 <aDBt1qXj90JO1y2v@infradead.org>
 <aDCqGLY4irp-6N5M@kbusch-mbp>
 <aDP5o1qb02iwgw-V@infradead.org>
 <aDX6NjOuGvxhbw7C@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDX6NjOuGvxhbw7C@kbusch-mbp>
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

On Tue, May 27, 2025 at 11:45:26AM -0600, Keith Busch wrote:
> Just fyi, the initial user I was planning to target with the block
> layer's copy fallback isn't in kernel yet. Just an RFC at this moment on
> btrfs:
> 
>   https://lore.kernel.org/linux-btrfs/20250515163641.3449017-10-maharmstone@fb.com/
> 
> The blk-lib function could easily replace that patch's "do_copy()"
> without to much refactoring on the btrfs side.

Well, that code would be much better off using a long living buffer,
because the frequent allocations are worse.  Also from talking to a btrfs
guys sitting next to me at least the classic relocation can actually be
in the normal write path, so you probably also don't want it to fail
because a large memory allocation fails.

What we did for the GC code in XFS that exists to basically do the same
is to do a large allocation at mount time, and then just keep reusing
it.

