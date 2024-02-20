Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82957C48BC3
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Feb 2024 08:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z/oYH4+I2fRdmT/gAXThrAHr9XzHkbRk7PwWUHjL5tU=; b=LCsbjuYskaRZEwOJvmBzwwv0fo
	WiJkh41LDYO+pvCuQ481fVE05Z5/fhEOQdsTBTDaPPk0uW9UL2w3z3EA/QjwlPpyfPZjkKZGzSH1F
	TT/2zEi32BYlD18hKojcHyyXX7FLYN37+PTddRRoDkFIMylJAxIs1GGCQlmTQY5SZoo7/zxr71i8m
	fCCrKlPHGVubai+rOUB/c8/mm4VrnucYfoGZIcSwJ3bFwuim6utFLrPm6YEk3kVzPKa+MBejbOTZp
	ftC4jEd4w0iPMadua5BwmBS1GiDzSMEInnCl5bMZJGBeWZzYoYVi/MOBWclUawCOtfhTAo0K1i6O4
	OLmb8beg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcLV3-0000000DiVL-1qEC;
	Tue, 20 Feb 2024 08:29:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcLV0-0000000DiTr-1OI0
	for linux-nvme@lists.infradead.org;
	Tue, 20 Feb 2024 08:29:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 01C1868D08; Tue, 20 Feb 2024 09:29:03 +0100 (CET)
Date: Tue, 20 Feb 2024 09:29:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com,
	Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH v4 06/11] block: Add atomic write support for statx
Message-ID: <20240220082902.GC13785@lst.de>
References: <20240219130109.341523-1-john.g.garry@oracle.com> <20240219130109.341523-7-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219130109.341523-7-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_002910_536052_8804E7B3 
X-CRM114-Status: GOOD (  15.54  )
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

> +#define BDEV_STATX_SUPPORTED_MASK (STATX_DIOALIGN | STATX_WRITE_ATOMIC)

> +	if (!(request_mask & BDEV_STATX_SUPPORTED_MASK))
> +		return;

BDEV_STATX_SUPPORTED_MASK is misleading here.  bdevs support a lot more
fields, these are just the ones needing special attention.  I'd do away
with the extra define and just open code it.

> +	/* If this is a block device inode, override the filesystem
> +	 * attributes with the block device specific parameters
> +	 * that need to be obtained from the bdev backing inode
> +	 */

This is not the normal kernel multi-line comment format.

> +	if (S_ISBLK(d_backing_inode(path.dentry)->i_mode))
> +		bdev_statx(path.dentry, stat, request_mask);

I know I touched this last, but does anyone remember why we have
various random fixups in vfs_statx and not in vfs_getattr_nosec, where
they we have more of them and also the inode at hand?

