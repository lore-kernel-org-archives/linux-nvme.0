Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A81D12D72
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 05:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9bCh2K1tspn+QQTLxt908qGwctHxFA/o2mvI8qgWAYQ=; b=XZ/avzA5GRUfgjeCa5EbfBXibB
	LYegB1zDYyeHGVPNrhTa1EqKAncsQcao79j9NFBRYcXBbsQCo9YLJv9SAarh8dVUCciVy3OWal2QD
	mAgzbO1d5mu7NvT1ep6oQxnu5/AvNQqKVyVOlV7sJw4u0EfBFRPrheGw466HDvUmH7piVmmtc9QeF
	bkCKrLJGd4Lay8af6Zu6dVX22TyRnsHjjt0TyIEGyl7EYHYbP5L2t/rwGFmVJmjRfCXDkgovRs6pG
	RRehLbXjR9puB8KOJmWo4nCEPx3JV6/Uh3C1sXxsYAVvBvM2bj5hPfj+sdE4IZx7XYyI4E4aXuKU4
	ERWnz0zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tANBl-0000000GPZp-3Rjt;
	Mon, 11 Nov 2024 05:42:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tANBh-0000000GPZE-2DBQ
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 05:42:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1BFCF68C7B; Mon, 11 Nov 2024 06:42:00 +0100 (CET)
Date: Mon, 11 Nov 2024 06:41:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, m@bjorling.me,
	matias.bjorling@wdc.com, kch@nvidia.com, kanie@linux.alibaba.com
Subject: Re: [PATCHv4 13/13] nvmet: report ns's vwc not present
Message-ID: <20241111054159.GA22853@lst.de>
References: <20241107193849.995554-1-kbusch@meta.com> <20241107193849.995554-14-kbusch@meta.com> <20241108142743.GG6694@lst.de> <Zy45M1HRz8cKLPxf@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy45M1HRz8cKLPxf@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_214209_832410_828E75C3 
X-CRM114-Status: GOOD (  17.99  )
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

On Fri, Nov 08, 2024 at 09:15:47AM -0700, Keith Busch wrote:
> > > +	if ((req->ns->file && !req->ns->buffered_io) ||
> > 
> > I don't think this check is correct.  Direct I/O still requires cache
> > flushes for durability.
> 
> Oh, right. Would it be sufficient to check the file's block device for
> write caching?
> 
> 	if ((req->ns->file && !req->ns->buffered_io &&
> 		bdev_write_cache(file_inode(req->ns->file)->i_sb->s_bdev))

No, that's wrong for two reasons:

 1) sb->s_bdev is only really relevant for mounting and st_dev reported
    in stat.  It might not relate to where the file data is placed at
    all
 2) the presence of cache in the underlying block device only has a
    minimal relation to the need to fdatasync a file you wrote to.
    Except for the corner case of overwritting a fully allocated (and
    not just preallocated) extent on an in-place write file system there
    always is metadata for a write that needs to be synchronized.
    You could work around that with an O_DYNC write that does that
    sync per I/O, but performance would be awful (and nvmet donsn't
    support that anyway)

