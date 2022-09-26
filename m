Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9307C07E9D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 14:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y4udOmf5rAfRrKehJGL/rqjoqKJBoALxewa/J2Xbkgc=; b=TuesqLCgRmZg2BP/Rs3dWWclJ7
	VWwJgklXsD+9BjuuTAiP/kPrHGi3tIBipndUQdyWIM0+MND3raedeYP2czBvf+SwTnrIevjhKsEKb
	JeT5r53SYiM943r7cZBlrgQqrEAJQgV3Ja3LNIn12pdA3gnJmVFmxD+H5QtrONjOKE3Z11/72Ja0X
	Ik2QH8w1QwzseOhe0cnt97KhM4OtPctN1RtXmPsA+0esgPXq9OtOtykv2RdiTaRZD5wXntacpte2q
	wqqeS7EfwxUmx21+py9OjWlhgvAk/VE8FZVU1EfU5qgMZA2AT2veiyaqNDLNxoBKfhsXaSGpKxnWd
	fMBMkkTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpRX-005V5u-Bv; Mon, 26 Sep 2022 14:50:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpRU-005V1k-L6
	for linux-nvme@lists.infradead.org; Mon, 26 Sep 2022 14:50:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA18068AFE; Mon, 26 Sep 2022 16:50:40 +0200 (CEST)
Date: Mon, 26 Sep 2022 16:50:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	asml.silence@gmail.com, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH for-next v7 4/5] block: add helper to map bvec iterator
 for passthrough
Message-ID: <20220926145040.GA20424@lst.de>
References: <20220909102136.3020-1-joshi.k@samsung.com> <CGME20220909103147epcas5p2a83ec151333bcb1d2abb8c7536789bfd@epcas5p2.samsung.com> <20220909102136.3020-5-joshi.k@samsung.com> <20220920120802.GC2809@lst.de> <20220922152331.GA24701@test-zns> <20220923152941.GA21275@lst.de> <20220923184349.GA3394@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923184349.GA3394@test-zns>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220926_075044_851240_5D162CF1 
X-CRM114-Status: GOOD (  16.03  )
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

On Sat, Sep 24, 2022 at 12:13:49AM +0530, Kanchan Joshi wrote:
> And efficency is the concern as we are moving to more heavyweight
> helper that 'handles' weird conditions rather than just 'bails out'.
> These alignment checks end up adding a loop that traverses
> the entire ITER_BVEC.
> Also blk_rq_map_user_iov uses bio_iter_advance which also seems
> cycle-consuming given below code-comment in io_import_fixed():

No one says you should use the existing loop in blk_rq_map_user_iov.
Just make it call your new helper early on when a ITER_BVEC iter is
passed in.

> Do you see good way to trigger this virt-alignment condition? I have
> not seen this hitting (the SG gap checks) when running with fixebufs.

You'd need to make sure the iovec passed to the fixed buffer
registration is chunked up smaller than the nvme page size.

E.g. if you pass lots of non-contiguous 512 byte sized iovecs to the
buffer registration.

>> We just need to implement the equivalent functionality for bvecs.  It
>> isn't really hard, it just wasn't required so far.
>
> Can the virt-boundary alignment gap exist for ITER_BVEC iter in first
> place?

Yes.  bvecs are just a way to represent data.  If the individual
segments don't fit the virt boundary you still need to deal with it.

