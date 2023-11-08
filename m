Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80B6C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 17:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c5F8kMntyFbtyyZ5q4UaNNtaqSNSXsuGzAds0G+FSNI=; b=zKMBOVP1pN2qsGlL3HN6SMePd3
	qFH32EKXYO3AE3M4VmUEA6Z79uJxmZJ6VePVZfVRlGVJW6wvW6uDkAJzQTwr3c/If804kYkzs4GVm
	zujL4NpQeG32YnRHEHbJXgL6RQD5Hei5l8cCLuLts3nS3LpSuLn3RyVhyyKo6ih/Ynma6JSOxS+cX
	qMTmrGxNv2gE8pA77lEXwA36nkPCNFrtI7nA1ij3iccgEanbSUMcfX9REpGUp7xMwmc1CBZ1C2gaI
	WvW3vfQ/1M201nJyxadMhld3wEDjPQNBSb8Z38/2f/PpPLbyVppuWcW9tGjHExEelJNuMpMKNIWnu
	/ILXtvDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0mDQ-004ObC-3A;
	Wed, 08 Nov 2023 17:19:45 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0mDO-004Oaa-2H
	for linux-nvme@lists.infradead.org;
	Wed, 08 Nov 2023 17:19:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1EEA6CE1117;
	Wed,  8 Nov 2023 17:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C447BC433C8;
	Wed,  8 Nov 2023 17:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699463980;
	bh=8WcnBJph0nMP59ZVY5tLRagWAAWuVVxQRfQlzNm6mRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdg0tia1FBXF/KLhUIKMag4zrdSAYyQ+HQSZVYM9Qv4uAR0Cx5ol1WoZiqYgcBWU8
	 eDSTN0qYHoVkwsZc8Bh25K2gzGUP/GumjOZ20y15Ig3SK1Efz4SYck8IL5+g7qnxki
	 aPFDxwJ22kM6hNCuwVWQAZQANymORWWF9dXjnVP75M9G6ypqVqgfqadlWYWe1tWwpf
	 NAnlHre/NYaEQOCTpP7cD5B741VlO6PnAfmMWK1OAwPWfOjRyIkkPnQPjznhfsSqsh
	 VE2ZkGBNis9L333ci426+aYSN9nxn1ZY7mxZPUT5/7ij+9VX2e+5ycGLRl80odVeiY
	 T4d+3Q9R0y1kA==
Date: Wed, 8 Nov 2023 10:19:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Subject: Re: [PATCHv2 1/4] block: bio-integrity: directly map user buffers
Message-ID: <ZUvDKbe87fhYajcT@kbusch-mbp.dhcp.thefacebook.com>
References: <20231027181929.2589937-1-kbusch@meta.com>
 <CGME20231027182010epcas5p36bcf271f93f821055206b2e04b3019a6@epcas5p3.samsung.com>
 <20231027181929.2589937-2-kbusch@meta.com>
 <40ac82f5-ce1b-6f49-3609-1aff496ae241@samsung.com>
 <ZUkAH258Ts0caQ5W@kbusch-mbp.dhcp.thefacebook.com>
 <1067f03f-e89b-4fc8-58bb-0b83b6c5c91d@samsung.com>
 <ZUpS150ojGIJ-bkP@kbusch-mbp.dhcp.thefacebook.com>
 <3e14f4c8-482d-df2c-f802-ebc74bd12664@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e14f4c8-482d-df2c-f802-ebc74bd12664@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231108_091942_917527_C8CC6A96 
X-CRM114-Status: GOOD (  23.62  )
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

On Wed, Nov 08, 2023 at 05:45:19PM +0530, Kanchan Joshi wrote:
> On 11/7/2023 8:38 PM, Keith Busch wrote:
> > On Tue, Nov 07, 2023 at 03:55:14PM +0530, Kanchan Joshi wrote:
> >> On 11/6/2023 8:32 PM, Keith Busch wrote:
> >>> On Mon, Nov 06, 2023 at 11:18:03AM +0530, Kanchan Joshi wrote:
> >>>> On 10/27/2023 11:49 PM, Keith Busch wrote:
> >>>>> +	for (i = 0; i < nr_vecs; i = j) {
> >>>>> +		size_t size = min_t(size_t, bytes, PAGE_SIZE - offs);
> >>>>> +		struct folio *folio = page_folio(pages[i]);
> >>>>> +
> >>>>> +		bytes -= size;
> >>>>> +		for (j = i + 1; j < nr_vecs; j++) {
> >>>>> +			size_t next = min_t(size_t, PAGE_SIZE, bytes);
> >>>>> +
> >>>>> +			if (page_folio(pages[j]) != folio ||
> >>>>> +			    pages[j] != pages[j - 1] + 1)
> >>>>> +				break;
> >>>>> +			unpin_user_page(pages[j]);
> >>>>
> >>>> Is this unpin correct here?
> >>>
> >>> Should be. The pages are bound to the folio, so this doesn't really
> >>> unpin the user page. It just drops a reference, and the folio holds the
> >>> final reference to the contiguous pages, which is released on
> >>> completion.
> >>
> >> But the completion is still going to see multiple pages and not one
> >> (folio). The bip_for_each_vec loop is going to drop the reference again.
> >> I suspect it is not folio-aware.
> > 
> > The completion unpins once per bvec, not individual pages. The setup
> > creates multipage bvecs with only one pin remaining per bvec for all of
> > the bvec's pages. If a page can't be merged into the current bvec, then
> > that page is not unpinned and becomes the first page of to the next
> > bvec.
> > 
> 
> Here is a test program [2] that creates this scenario.
> Single 8KB+16b read on a 4KB+8b formatted namespace. It prepares 
> meta-buffer out of a huge-page in a way that it spans two regular 4K pages.
> With this, I see more unpins than expected.

I understand now. The bip_for_each_bvec is using single page vector
iterators. Will fix it up for next time.

