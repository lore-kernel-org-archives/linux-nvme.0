Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058D9C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Oct 2023 21:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/xROL4WNRFfdCbROoju36U7GnE5wxs1O0DYFw1z01xg=; b=Gn+a3+UGVw689PKhX/I+a4iNT7
	r6quTnctuLfdckjkE3mCphkUwklHdn9Kie32hT9ByUSrHfMDaEYLkjFUvobG95K+fJW02bqxpneAe
	CFwhkYG3SZBJLykyvrsmO99PmCQDZjomYx1pMBU8UgRlkPjR/VCJ9jXupXKE+HQP/hZMF5S58CIQ2
	uMOj5WZun+FFtzAcLMRqMK+1qED+E5GLrAULDqnxPb+kfX5trRcBfOtwaE9Eho8Ve2zD9tupZ/7dp
	nPeFDf3TlYMo9G3tY6R7Wc89n2CPxh5F6vQ3FqhLq+eyoDQKrBKwlzXxIy94/VE9OaU9k0yC3d8at
	5q/IDWtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxZl9-0044GF-2j;
	Mon, 30 Oct 2023 21:25:19 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxZl6-0044FY-2r
	for linux-nvme@lists.infradead.org;
	Mon, 30 Oct 2023 21:25:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 11E1FCE19B9;
	Mon, 30 Oct 2023 21:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAFAC433C8;
	Mon, 30 Oct 2023 21:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698701114;
	bh=hzofDKiGjd6jXy/PnVdRPIXYvHmctTDMe4RQrG3lL0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dPQ2cNx+nf0zldx6hUWvHXnWXeCuEJx441hauvRDRt6MKXThszkTf4gfrU24nSrC0
	 p4X/Fn1v7pt+ROyfx1qK3h1Xoc57kH8H2v7mjdspHNYECqapBIYHd2W2PlZCEVYXd1
	 a4NNOXfbDLuoaU8GNVFEP0VkkMOdVkzZHbZxprwXo03QKG7U7TX4gtI9AuFYwlVIdk
	 2y3+7oa+de7PNNY1moaag5IXcmd4NkY3BUQftK15qsJe7c2dPRhoBjUzoO5UYMH4QJ
	 0Nq7H0uJN0pw62hfnQ/MDPzt4tT0xppeN8rIt1A6a98g8k7nnzaapP1V82PS3q+6zE
	 ds3aYJGO2K5ng==
Date: Mon, 30 Oct 2023 15:25:11 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Subject: Re: [PATCHv2 1/4] block: bio-integrity: directly map user buffers
Message-ID: <ZUAfNzhvp9KGysT2@kbusch-mbp.dhcp.thefacebook.com>
References: <20231027181929.2589937-1-kbusch@meta.com>
 <CGME20231027182017epcas5p1fb1f91bc876d9bc1b1229c012bcd1ea2@epcas5p1.samsung.com>
 <20231027181929.2589937-2-kbusch@meta.com>
 <c3a946f4-b2f8-c800-1573-1f87c9d637d7@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3a946f4-b2f8-c800-1573-1f87c9d637d7@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231030_142517_126584_A86AC0DE 
X-CRM114-Status: GOOD (  11.48  )
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

On Tue, Oct 31, 2023 at 02:32:48AM +0530, Kanchan Joshi wrote:
> On 10/27/2023 11:49 PM, Keith Busch wrote:
> > +
> > +	bip_for_each_vec(bv, bip, iter) {
> > +		if (dirty && !PageCompound(bv.bv_page))
> > +			set_page_dirty_lock(bv.bv_page);
> > +		unpin_user_page(bv.bv_page);
> > +	}
> > +}
> 
> Leak here, page-unpinning loop will not execute for the common (i.e., 
> no-copy) case...
> 
> > +	bip = bio_integrity_alloc(bio, GFP_KERNEL, folios);
> > +	if (IS_ERR(bip)) {
> > +		ret = PTR_ERR(bip);
> > +		goto release_pages;
> > +	}
> > +
> > +	memcpy(bip->bip_vec, bvec, folios * sizeof(*bvec));
> 
> Because with this way of copying, bip->bip_iter.bi_size will remain zero.

Good catch.
 
> Second, is it fine not to have those virt-alignment checks that are done 
> by bvec_gap_to_prev() when the pages are added using 
> bio_integrity_add_page()?

We're mapping a single user buffer. It's guaranteed to be virtually
congiguous, so no gaps.

