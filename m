Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D0AC04FFE
	for <linux-nvme@archiver.kernel.org>; Tue, 14 May 2024 05:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V8BLKEDjVLSYCeIAVSa2UNwbV9pR9h6kyjxXY8EtniY=; b=iVh1xh1MEd19qSf33IKRbcm55l
	qQaq2goM7PtyUAoiJxRc+y1whivJhG13q9KU4mtw6zrAyZb3AEuhzCZbx9kSqDHEHtxsOMqM7pqGQ
	bwDw5g3FvDstl0aw5ptmIcgMC0bTzgZBqMCLSIQ4a6a/YX3Wt2uEHljaDPIaAJV77Z/kibIKA5g+x
	wLruIHR/1apmNMvDVn6hZeWVMr+v9JzyBNofVMsHLgI8aOvG8J14Ez488/hHc4FBXxDDbVEjHb4PK
	W/9DvyJCbkS46pcwfoYbTdW/tKk9Nbq+xSBCpGok9diInYYV7+qIxIqnRxcXLU/ZCtfJD3ZClvyFt
	ULqoFgaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6kP2-0000000F0gy-3jt4;
	Tue, 14 May 2024 05:08:40 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6kOt-0000000F0gk-2Aqf
	for linux-nvme@bombadil.infradead.org;
	Tue, 14 May 2024 05:08:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V8BLKEDjVLSYCeIAVSa2UNwbV9pR9h6kyjxXY8EtniY=; b=c1IcnK+e5fUSdoqZLyvbrU8Ygc
	2nqiAtWrFNYDhiHPZoshYlYeJdUgQyyTfFlqq6ddCUGNOHQEJ68l/WSFeztaa20+eyKxUzzwDxIRd
	oc9/5OnwSASoCAuhsj+iIDnRbP9eTc5Gya5KGXS1L5H39oMzPsZa9E1QZctVXsG/53/s+bb8QZs+Y
	TjhWAnbgCR/heuhtMokjJqPhjp9m4d8rPknIVJTTc/O6mmPWHvOb9iZZ4XM/ZQZkzUpt/13+2N5Yd
	fCk8FuDBPjZ3QA1p9dqMDFxCjraCzhl4Zsi0Lq+HWnFtnQhjQ3eD+FoJQBmrBCyP5BGp9ylYHbUUk
	DtlTlsqw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6kOp-00000008kBQ-0ekQ;
	Tue, 14 May 2024 05:08:27 +0000
Date: Tue, 14 May 2024 06:08:27 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>, hare@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Message-ID: <ZkLxy6QUc5BB_adf@casper.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
 <Zj_6vDMwyb2O6ztI@bombadil.infradead.org>
 <Zj__oIGiY8xzrwnb@casper.infradead.org>
 <ZkAEhFLVD9gSk0y0@bombadil.infradead.org>
 <ZkAszpvBkb5_UUiH@bombadil.infradead.org>
 <ZkCI_21z_h1ez4sN@bombadil.infradead.org>
 <993991e6-7f06-4dfd-b5d7-554b9574384c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <993991e6-7f06-4dfd-b5d7-554b9574384c@suse.de>
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

On Mon, May 13, 2024 at 06:07:55PM +0200, Hannes Reinecke wrote:
> On 5/12/24 11:16, Luis Chamberlain wrote:
> > On Sat, May 11, 2024 at 07:43:26PM -0700, Luis Chamberlain wrote:
> > > I'll try next going above 512 KiB.
> > 
> > At 1 MiB NVMe LBA format we crash with the BUG_ON(sectors <= 0) on bio_split().
> 
> Ah. MAX_BUFS_PER_PAGE getting in the way.

That doesn't make sense.  We will need something like this patch for
filesystems which use large folios with buffer_heads.  But for a 1MB
block size device, we should have one buffer_head per folio.


