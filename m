Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A85D2F7FC
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 08:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sfOiQyRXbG1/96DE6zBPYZn7zj79QJp3qwujojtmOwA=; b=jGF5F2UOGOcXw9xLXy8wtYWacT
	qbtIRSRpny9aB5tJlqIibKdKI4tdoERtwVs7aVqvvBSC8RBrs1gfgxfFuCQ7x3IH3OVm6mEclRnuo
	QTZt2lJkFJIK5ihSK8ktK3/NCwrygMMHHEJpUTyevB2SJwflV7laU5tH4GNkdW9JrdVJHmdpfWAjb
	Ekp9o66JHTghYWkWZQPmgyGiNrfmSzsGoyUy03pLZtlGgD2P+eaZdkP0Qy4/lw9B2ipVOAxImhCRe
	V0KyTeGqsMEfbHArpK++feEbxuSpGv1QUmnaWkdaCN96JSA7QXHeTrF21H/G06Isl8WN1zHbkftGr
	7QWMrOVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Lfi-0000000E87H-2hyi;
	Thu, 17 Oct 2024 08:15:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Lb3-0000000E6nV-3UpQ
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 08:11:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 28397227A87; Thu, 17 Oct 2024 10:10:58 +0200 (CEST)
Date: Thu, 17 Oct 2024 10:10:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v4 07/11] io_uring/rw: add support to send meta along
 with read/write
Message-ID: <20241017081057.GA27241@lst.de>
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113747epcas5p4e276eb0da2695ba032ce1d2a3b83fff4@epcas5p4.samsung.com> <20241016112912.63542-8-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016112912.63542-8-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_011102_108521_0E6B5346 
X-CRM114-Status: GOOD (  18.47  )
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

s/meta/metadata/ in the subject.

> +	const struct io_uring_meta *md = (struct io_uring_meta *)sqe->big_sqe_cmd;

Overly long line.

> +	if (!meta_type)
> +		return 0;
> +	if (!(meta_type & META_TYPE_INTEGRITY))
> +		return -EINVAL;

What is the meta_type for?  To distintinguish PI from non-PI metadata?
Why doesn't this support non-PI metadata?  Also PI or TO_PI might be
a better name than the rather generic integrity.  (but I'll defer to
Martin if he has any good arguments for naming here).

>  static bool need_complete_io(struct io_kiocb *req)
>  {
> +	struct io_rw *rw = io_kiocb_to_cmd(req, struct io_rw);
> +
> +	/* Exclude meta IO as we don't support partial completion for that */
>  	return req->flags & REQ_F_ISREG ||
> -		S_ISBLK(file_inode(req->file)->i_mode);
> +		S_ISBLK(file_inode(req->file)->i_mode) ||
> +		!(rw->kiocb.ki_flags & IOCB_HAS_METADATA);
>  }

What partial ocmpletions aren't supported?  Note that this would
trigger easily as right now metadata is only added for block devices
anyway.

> +	if (unlikely(kiocb->ki_flags & IOCB_HAS_METADATA)) {

For a workload using metadata this is everything but unlikely.  Is
there a specific reason you're trying to override the existing
branch predictor here (although on at least x86_64 gcc these kinds
of unlikely calls tend to be no-ops anyway).

> +		struct io_async_rw *io = req->async_data;
> +
> +		if (!(req->file->f_flags & O_DIRECT))
> +			return -EOPNOTSUPP;

I guess you are forcing this here rather in the file oerations instance
because the union of the field in struct io_async_rw.  Please add comment
about that.

> +	/* wpq is for buffered io, while meta fields are used with direct io*/

missing whitespace before the closing of the comment.

