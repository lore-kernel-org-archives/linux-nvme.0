Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C190C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 15:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Qu+Jnc6noG6k3Q06ocjJ9P0zNIdKP3v6/WiOI0irQk=; b=N27s1rybQu8iH4/ahYD9u2h+Nt
	p4LgtsbqL8NvDwxXNiuJb7vady4Wj8vQHY2nJzN8bAn9C3oqIZczaYFppPEvtUqlVka3cKMumjRqF
	ti4JYMg7DeXjct393R/m3S7iDykpL1MJD+6FPzW4Z0B8ITSmGZY9b27B0hOTd6PmYM2qhC7pc0BZi
	FZIKFvt0zOI5jIv2GeqA0wDjawoWBihbXIdHYF/tkXQc0bzp4bLvIil5m6yrp1Dz1ValsXdxTpdSZ
	GzfO8VlfK+SQNtPwKgde+5BFwhwlS93o88QOfavrDk1n05YeTTPQ3v11f3YtxtpWdwT6PotNCxY/F
	aoZrMzRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0Ngd-001oo0-1p;
	Tue, 07 Nov 2023 15:08:15 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0NgZ-001omc-2N
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 15:08:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BD07661227;
	Tue,  7 Nov 2023 15:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7336C433C8;
	Tue,  7 Nov 2023 15:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699369690;
	bh=fqc1lydE+oFHnV5LoqF+kS/QVJ3sj84z6KacrNEic+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z2oU4we7TN18y1wBppFM0eVBJ/UT3jFlag1LTqKMKR5TBS6xVSuXqnN1kPozseGK7
	 pEEo2Eg0YXFL0PriNqrDKvrdmyusIKmUYBiAeH1+H3kWPWmOQDyJ4RX+O4TmT3JUfA
	 PDHbK6IPy3xr0eLM+0MICYVWeeO49VbaT5qS9GDXOyC9KsDGDBX9ZQQXb82ZQm/fO4
	 kLMraOt6+jIuSBBddnJoaiqLDB7ncJPHUenTLHvMl3UhkmePGYKPGG6gIAyLmbTvVc
	 Ob4hNb3A5MyrLjaCoE1+xho7t9Idd1G14D0hrlT3OFKY5PBhqIMT2Bi487Bii4td+a
	 lw4g0BYQmfLIg==
Date: Tue, 7 Nov 2023 08:08:07 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Subject: Re: [PATCHv2 1/4] block: bio-integrity: directly map user buffers
Message-ID: <ZUpS150ojGIJ-bkP@kbusch-mbp.dhcp.thefacebook.com>
References: <20231027181929.2589937-1-kbusch@meta.com>
 <CGME20231027182010epcas5p36bcf271f93f821055206b2e04b3019a6@epcas5p3.samsung.com>
 <20231027181929.2589937-2-kbusch@meta.com>
 <40ac82f5-ce1b-6f49-3609-1aff496ae241@samsung.com>
 <ZUkAH258Ts0caQ5W@kbusch-mbp.dhcp.thefacebook.com>
 <1067f03f-e89b-4fc8-58bb-0b83b6c5c91d@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067f03f-e89b-4fc8-58bb-0b83b6c5c91d@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_070811_836894_7BE40AB2 
X-CRM114-Status: GOOD (  17.48  )
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

On Tue, Nov 07, 2023 at 03:55:14PM +0530, Kanchan Joshi wrote:
> On 11/6/2023 8:32 PM, Keith Busch wrote:
> > On Mon, Nov 06, 2023 at 11:18:03AM +0530, Kanchan Joshi wrote:
> >> On 10/27/2023 11:49 PM, Keith Busch wrote:
> >>> +	for (i = 0; i < nr_vecs; i = j) {
> >>> +		size_t size = min_t(size_t, bytes, PAGE_SIZE - offs);
> >>> +		struct folio *folio = page_folio(pages[i]);
> >>> +
> >>> +		bytes -= size;
> >>> +		for (j = i + 1; j < nr_vecs; j++) {
> >>> +			size_t next = min_t(size_t, PAGE_SIZE, bytes);
> >>> +
> >>> +			if (page_folio(pages[j]) != folio ||
> >>> +			    pages[j] != pages[j - 1] + 1)
> >>> +				break;
> >>> +			unpin_user_page(pages[j]);
> >>
> >> Is this unpin correct here?
> > 
> > Should be. The pages are bound to the folio, so this doesn't really
> > unpin the user page. It just drops a reference, and the folio holds the
> > final reference to the contiguous pages, which is released on
> > completion. 
> 
> But the completion is still going to see multiple pages and not one 
> (folio). The bip_for_each_vec loop is going to drop the reference again.
> I suspect it is not folio-aware.

The completion unpins once per bvec, not individual pages. The setup
creates multipage bvecs with only one pin remaining per bvec for all of
the bvec's pages. If a page can't be merged into the current bvec, then
that page is not unpinned and becomes the first page of to the next
bvec.

