Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0667C54FB9
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Nov 2023 05:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jt1nZ/78+gHT+29Z5fbY17Xlie/jo1sXaIcMn9q8o/8=; b=qdMHQmZwtDcJBmPSj+mFZ1Ue++
	LHHvzLg2t+31YWJvbxE1X6DdYyRmMfKAsHoSTjsjPYzOwnUqjaAJ8zW7ZNDtzm0CUWvF3L2pQrgHF
	h+UDbc2g88FQ26f+kcxfdx/d6VTZtnzAEAqm36QyeJ2HSKvYrCDW+XusO33S0UITCJOe7nlv97x8g
	96dx0qdsRE6wxgyfKbfS/wyu1oJX/5bqXW7Ap22k46YMCZgQY4tQcKCGcVSA5RvN2NhNGPQOhWUON
	PYTj6c8tQWPMlJoNXanIXTCMz77yLbTKGM+iU4usIny0brstYnE3/njzdmotzfkS/UysWOH4/5yYR
	e+i0WkMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5It7-00FdWv-1F;
	Tue, 21 Nov 2023 05:01:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5It3-00FdVf-2O
	for linux-nvme@lists.infradead.org;
	Tue, 21 Nov 2023 05:01:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4DF2E6732A; Tue, 21 Nov 2023 06:01:13 +0100 (CET)
Date: Tue, 21 Nov 2023 06:01:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	joshi.k@samsung.com, martin.petersen@oracle.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 1/5] bvec: introduce multi-page bvec iterating
Message-ID: <20231121050112.GA2865@lst.de>
References: <20231120224058.2750705-1-kbusch@meta.com> <20231120224058.2750705-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120224058.2750705-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_210125_920785_505176B2 
X-CRM114-Status: GOOD (  15.63  )
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

On Mon, Nov 20, 2023 at 02:40:54PM -0800, Keith Busch wrote:
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index 555aae5448ae4..9364c258513e0 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -184,6 +184,12 @@ static inline void bvec_iter_advance_single(const struct bio_vec *bv,
>  		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
>  	     bvec_iter_advance_single((bio_vec), &(iter), (bvl).bv_len))
>  
> +#define for_each_mp_bvec(bvl, bio_vec, iter, start)			\
> +	for (iter = (start);						\
> +	     (iter).bi_size &&						\
> +		((bvl = mp_bvec_iter_bvec((bio_vec), (iter))), 1);	\
> +	     bvec_iter_advance_single((bio_vec), &(iter), (bvl).bv_len))

Hope thjis isn't too much bike-shedding, but in the block layer
we generally used _segment for the single page bvecs and just bvec
for the not page size limited.  This isn't the best naming either,
but i wonder if it's worth to change the existing 4 callers and be
consistent.  (and maybe one or two of them doesn't want the limit anyway?)

Otherwise this looks good to me.


