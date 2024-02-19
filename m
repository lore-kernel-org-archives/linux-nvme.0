Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56714C48BF8
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 18:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MfOS2FHgx7cQdMCJWPyLcoKyeYGdzcj+CLOLLLLFzRk=; b=00DVxC5XYVG5K0/k6FdP21r7Cp
	dkCv/HCL8C+Ytg/MFVcOe7QNnoL/DU6eeAKX2r5lXG0x2JFkD2w+s0SvwFhGLBBYAxO1TWlxMInj6
	MbeTW/W5SHpxm/H9ulBYiDJWypvwIgn/pt1Oud12AhayacH/9ub0k4kVE6w5/DXrjT8BtZd5qDgOx
	E3ThWUTDb/WOPUA3HX/m/07SclN2yvt8MO2mK3s/k1eoSwJl4/bTUfTYlk0zlB2BkWbPlGNAhIFNg
	apyJjeW8+x6SpQt8ZrH2LVk8PS65uA/Z5i/iAq2nYCJrwcEHwmoXvcDCdex+JiYlNLUUKemuQUEJY
	7ilr3Iuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc8pX-0000000Bnm2-3yBr;
	Mon, 19 Feb 2024 18:57:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc8pW-0000000BnlR-0bcn
	for linux-nvme@lists.infradead.org;
	Mon, 19 Feb 2024 18:57:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5142260F0F;
	Mon, 19 Feb 2024 18:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D1EC433C7;
	Mon, 19 Feb 2024 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708369049;
	bh=hlzNv0HneAFcj8iXq6Qfn9/TqgvN+CXJ8vpN0bhvzuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VYGRxYfHz+G5gsqE/kZ4an8+k6ihso+suEPttoEPqHlHRsbjJ/rGY14ni7lhoobG7
	 x+RoZnTABT4BQwrVYlT9CDUxYlvONcW+6VGDuq6Rr76NAUgnuMMosQhFmbVcChmM3L
	 phR4ndzdjB31okSWC7FD7Qd/49kwDaGyasfOFFjkVslnlcmLOFy3HlMtn6gGJMtkmL
	 h4z5S2vA+7TQDbiY7i3IQZAYMeFkhAdA8aGt6RGmGurZtO7kovYuEKhtXLuNt8XWYV
	 w+Ocv832w1rwRR6AMOuIPW9Dz71gwFlL+G9dCYWCrYOGLqbkUqj//z7JztyDntVXE6
	 vQ70wA0mNgV2Q==
Date: Mon, 19 Feb 2024 11:57:25 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
	jack@suse.cz, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com,
	linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
	io-uring@vger.kernel.org, nilay@linux.ibm.com,
	ritesh.list@gmail.com
Subject: Re: [PATCH v4 02/11] block: Call blkdev_dio_unaligned() from
 blkdev_direct_IO()
Message-ID: <ZdOklTSG9tHuYtGi@kbusch-mbp>
References: <20240219130109.341523-1-john.g.garry@oracle.com>
 <20240219130109.341523-3-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219130109.341523-3-john.g.garry@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_105730_250966_A56D1B6D 
X-CRM114-Status: GOOD (  11.86  )
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

On Mon, Feb 19, 2024 at 01:01:00PM +0000, John Garry wrote:
> @@ -53,9 +53,6 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
>  	struct bio bio;
>  	ssize_t ret;
>  
> -	if (blkdev_dio_unaligned(bdev, pos, iter))
> -		return -EINVAL;
> -
>  	if (nr_pages <= DIO_INLINE_BIO_VECS)
>  		vecs = inline_vecs;
>  	else {
> @@ -171,9 +168,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>  	loff_t pos = iocb->ki_pos;
>  	int ret = 0;
>  
> -	if (blkdev_dio_unaligned(bdev, pos, iter))
> -		return -EINVAL;
> -
>  	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
>  		opf |= REQ_ALLOC_CACHE;
>  	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
> @@ -310,9 +304,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>  	loff_t pos = iocb->ki_pos;
>  	int ret = 0;
>  
> -	if (blkdev_dio_unaligned(bdev, pos, iter))
> -		return -EINVAL;
> -
>  	if (iocb->ki_flags & IOCB_ALLOC_CACHE)
>  		opf |= REQ_ALLOC_CACHE;
>  	bio = bio_alloc_bioset(bdev, nr_pages, opf, GFP_KERNEL,
> @@ -365,11 +356,16 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>  
>  static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
>  {
> +	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
> +	loff_t pos = iocb->ki_pos;
>  	unsigned int nr_pages;

All three of the changed functions also want 'bdev' and 'pos', so maybe
pass on the savings to them? Unless you think the extended argument list
would harm readibilty, or perhaps the compiler optimizes the 2nd access
out anyway. Either way, this looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

