Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39988C61D90
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Nov 2023 15:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zp9CDf4lkflupK8DqC3rwLgLdSVS+T9huCMiRxeIR1w=; b=1tpBlPyEqmBd6O+54jKS8/bTEQ
	1eNroK8OQr22gBiGNha3Gj7PwvTZ2BouNzIbFsZ5YoLFk3wVnaIKKxeWkSE2KKYZNENNc0/QVZDyY
	9M8HsneYxZ5GWWFPKmHmgMHeJ2xC4gKJUjit3ADkImQNBDnyKKZHI5t4vOUOyPC7ovlfkttlAH615
	CfyLkGxlQdAG8xfnySVmegYSdrjZLiI9JZuuHdfFJ7s62Wn8620Q5hA4IC7ob5lqOe5B5wtRncBAy
	f8pArgPXMXUI42lhdUwezEhZya7U0zaYKiHd1lYULxZgG1fZZL0W/6wHD6oZ2Vty8T7uXjGnsZnxC
	vSg3bbTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5T0c-00HCdZ-2p;
	Tue, 21 Nov 2023 15:49:54 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5T0a-00HCcE-2u
	for linux-nvme@lists.infradead.org;
	Tue, 21 Nov 2023 15:49:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id CDB92CE1C66;
	Tue, 21 Nov 2023 15:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FFBC433C8;
	Tue, 21 Nov 2023 15:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700581788;
	bh=w3W5UVYnDU5SknGmgkYDoqIuEo08Ln34K8LjDwMjRM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBKskHHZ9bM8ojDRB0pTKGpJrBDeIh1Pg4PcJFuKF07T7/obBuJbrK61V+lmPRF1l
	 jqa3PPHIbOjoL20uWpX0GwAGOL/UxtMJekbQpC4xLuF175W5JdfsZcDDYeAmXdig10
	 Nx5U/RN7eWJY1NbsRdEI+4nQ9rQjTvvci3cUWf2qtl3uMsKHhc+No+1P1A7YVNOOyR
	 cEObz9yjYJmMwmgpX7iiV1P09YQqjixs/FXmPIAHAsAgw75f4khdZu2+a+dXgrZDrC
	 UBWV9J6AIk7S/dFHFhE258fZg/fbnC5x8VrX82wkFm4R4swzvFja/M/bkVLDM3T0zk
	 rjll7TU1zHriQ==
Date: Tue, 21 Nov 2023 08:49:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, joshi.k@samsung.com,
	martin.petersen@oracle.com
Subject: Re: [PATCHv3 1/5] bvec: introduce multi-page bvec iterating
Message-ID: <ZVzRmQ66yRDJWMiZ@kbusch-mbp>
References: <20231120224058.2750705-1-kbusch@meta.com>
 <20231120224058.2750705-2-kbusch@meta.com>
 <ZVxsLYj9oH+j3RQ8@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVxsLYj9oH+j3RQ8@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_074953_116521_E3991005 
X-CRM114-Status: GOOD (  16.40  )
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

On Tue, Nov 21, 2023 at 04:37:01PM +0800, Ming Lei wrote:
> On Mon, Nov 20, 2023 at 02:40:54PM -0800, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Some bio_vec iterators can handle physically contiguous memory and have
> > no need to split bvec consideration on page boundaries.
> 
> Then I am wondering why this helper is needed, and you can use each bvec
> directly, which is supposed to be physically contiguous.

It's just a helper function to iterate a generic bvec.
 
> > diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> > index 555aae5448ae4..9364c258513e0 100644
> > --- a/include/linux/bvec.h
> > +++ b/include/linux/bvec.h
> > @@ -184,6 +184,12 @@ static inline void bvec_iter_advance_single(const struct bio_vec *bv,
> >  		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
> >  	     bvec_iter_advance_single((bio_vec), &(iter), (bvl).bv_len))
> >  
> > +#define for_each_mp_bvec(bvl, bio_vec, iter, start)			\
> > +	for (iter = (start);						\
> > +	     (iter).bi_size &&						\
> > +		((bvl = mp_bvec_iter_bvec((bio_vec), (iter))), 1);	\
> > +	     bvec_iter_advance_single((bio_vec), &(iter), (bvl).bv_len))
> > +
> 
> We already have bio_for_each_bvec() to iterate over (multipage)bvecs
> from bio.

Right, but we are not dealing with a bio here. We have a bip bvec
instead, so can't use bio_for_each_bvec().

