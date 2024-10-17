Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FE0D2F7CE
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KfuXh1zWSF9g7AFqbLSP+KmVd0c5Ho0DGTyfxuWw480=; b=Xtly9gmzdR0zKljxY4mwE1eQ76
	WyT/j5Sk7MOsdl+CQBeJV18pqvQ4QFGfe2uLxOPCG+tupYi1m+Degt+jXAHynVbBwHcJ1P/tIoFzf
	v2QBnxbihgnmB7qYkn43gFg7G4cIA5U4pfTQGipE8Xfu5ruH0/H12z6GCNqveWlBDtANYa8kkUZnX
	AtbUxJGW8E5CiBOGsEKa3gEJUnWn0Im/bBaki5uQIfCvyuXll8/k6GWbBxGS2FEN1EF1Uf6RT4eBh
	UjrUVA9H32XrtKGircoh+EP/IfYvCASTVLPaA+Z8tUhFh94/Tl+wEaMY5n1/3GFbk6+hs4RwoyvQh
	TvZoNxzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1PDC-0000000EiZ0-2B9L;
	Thu, 17 Oct 2024 12:02:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1PBl-0000000EiNK-0ACU
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 12:01:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 85593227A87; Thu, 17 Oct 2024 14:01:02 +0200 (CEST)
Date: Thu, 17 Oct 2024 14:01:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com
Subject: Re: [PATCH v4 06/11] block: add flags for integrity meta
Message-ID: <20241017120102.GA10883@lst.de>
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113745epcas5p1723d91b979fd0e597495fef377ad0f62@epcas5p1.samsung.com> <20241016112912.63542-7-anuj20.g@samsung.com> <20241017080015.GD25343@lst.de> <20241017104502.GA1885@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017104502.GA1885@green245>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_050109_366884_B0A24C7B 
X-CRM114-Status: GOOD (  16.28  )
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

On Thu, Oct 17, 2024 at 04:15:02PM +0530, Anuj Gupta wrote:
> On Thu, Oct 17, 2024 at 10:00:15AM +0200, Christoph Hellwig wrote:
> > On Wed, Oct 16, 2024 at 04:59:07PM +0530, Anuj Gupta wrote:
> > > Add flags to describe checks for integrity meta buffer. These flags are
> > > specified by application as io_uring meta_flags, added in the next patch.
> > 
> > These are now blkdev uapis, but io_uring ones even if currently only
> > the block file operations implement them.  I do plan to support these
> > through file systems eventually.
> 
> Are these flags placed correctly here or you see that they should be
> moved somewhere else?

They are not as they aren't blkdev apis.  They are generic for io_uring,
or maybe even VFS-wide.


