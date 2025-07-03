Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D4E1C83030
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ISH9f5CKaVPrC2GKKnCwojLCZwq4NDgsiFMJRSp+Txg=; b=xIMvvYOhTsXgYs66Kum8x41DG4
	ABTRdjNk1G6t0h9G01CAraaEenrPrajwfpTNlrbxVVcM2UJ7jJlNPRJV6ISYrnhTMK6bMsFc01L3h
	j+48hP/GVb9ZIqYITZb9PEu6IyODuUl7FVbiAitYVMStQwRMZeDRk5/BeNVAvfNSWQpnWMBZxfMmi
	pMd4NnDyamt5KKL6uJG8cNlJuOf45SPN6xsPVmO/zB9Txen4ZxfCmfibuOcL3FgykhFY6H2NVJ0yy
	djh4crYrumyA0ebFC61sr/B4Z3yVTutWlZCqR5DD7NQhkxmWPj9SwxKhFqq7pxtCbq/yDIE9bHwDL
	/J0xQSOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXFk4-0000000AkQb-2Mla;
	Thu, 03 Jul 2025 08:56:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXFig-0000000Ak8P-3DTR
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 08:55:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D8EDB68C7B; Thu,  3 Jul 2025 10:54:51 +0200 (CEST)
Date: Thu, 3 Jul 2025 10:54:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Richard Weinberger <richard@nod.at>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, kch@nvidia.com, sagi@grimberg.me,
	hch@lst.de, upstream+nvme@sigma-star.at
Subject: Re: [PATCH v2] nvmet: Make blksize_shift configurable
Message-ID: <20250703085451.GA4459@lst.de>
References: <20250630191341.1263000-1-richard@nod.at> <132c1bdf-e100-4e3a-883f-27f9e9b78020@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <132c1bdf-e100-4e3a-883f-27f9e9b78020@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_015502_955876_636694C4 
X-CRM114-Status: GOOD (  22.63  )
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

On Tue, Jul 01, 2025 at 09:34:00AM +0900, Damien Le Moal wrote:
> Even if internally you use the block size bit shift, I think it would be better
> if the user facing interface is the block size as that is much easier to
> manipulate without having to remember the exponent for powers of 2 values :)

Yeah, block sizes are probably a nice user interface indeed.

> 		pr_err("Configured blksize needs to be at least %u for device %s\n",
> 			bdev_logical_block_size(ns->bdev),
> 			ns->device_path);
> 		return -EINVAL;
> 	}
> 
> Also, if the backend is an HDD, do we want to allow the user to configure a
> block size that is less than the *physical* block size ? Performance will
> suffer on regular HDDs and writes may fail with SMR HDDs.

I don't think we should babysit the user like that, just like we allow
creating file systems with block size smaller than the physical block
size.

> > +			if (!vfs_getattr(&ns->file->f_path, &st, STATX_DIOALIGN, 0) &&
> > +			    (st.result_mask & STATX_DIOALIGN) &&
> > +			    (1 << ns->blksize_shift) < st.dio_offset_align)
> > +				return -EINVAL;
> > +
> > +			if (sb_bdev && (1 << ns->blksize_shift < bdev_logical_block_size(sb_bdev)))
> > +				return -EINVAL;
> 
> I am confused... This is going to check both... But if you got STATX_DIOALIGN
> and it is OK, you do not need (and probably should not) do the second if, no ?
> 
> Also, the second condition of the second if is essentially the same check as
> for the block dev case. So maybe reuse that by creating a small helper function ?

This code is copy and pasted from loop, so it's originally my fault.
It just missed the comment that explains why it is there:

	/*
         * In a perfect world this wouldn't be needed, but as of Linux 6.13 only
         * a handful of file systems support the STATX_DIOALIGN flag.
         */

The situation has unfortunately not improved since 6.13.  Maybe we
just need to do a sweep and fix this up?


