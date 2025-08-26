Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D45CA0FEB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Aug 2025 14:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IYMJeWIUVTdMF9ufUJbkONvaEHUUMyL+ZQsPG4X0nEo=; b=T+L8Z/zc4hqUa4HxntESycNEur
	AH7FQDZtItamCo27YnrD+IIGs8PT4u9117UkpGIDmpCWAuiPkU3eqAG0/M4xxliIUbWXmENypTP1q
	+zdOFnsU4UtZTIMLmyWhJwDT3vUcBlK07pfpboqn3uFa/Kq4V/nQuIUsTPy8Hkn+wbs+usvdYi2en
	U0A3rzk8+YRueulFw0sTkmJ19xP1SV03mNAFmMtoZDJ2plTad1YmrNOLREDCImTbegsihvsfHNoFe
	8V+3c7CqPNmbZUGVpBYrANVn/u3o7nEprtBM3tzWBpoMplXfgjn3egd+mqb+D+X0bDuhJQ6UENlpo
	Gyb3y34Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uquPj-0000000CDQF-2GnA;
	Tue, 26 Aug 2025 14:12:43 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqu1k-0000000C99O-0ju1
	for linux-nvme@bombadil.infradead.org;
	Tue, 26 Aug 2025 13:47:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IYMJeWIUVTdMF9ufUJbkONvaEHUUMyL+ZQsPG4X0nEo=; b=qGtj+QAGsF1P4+963yOZhKcq+3
	FF8F5jrQUyd3Y0iX8lCF+zlWzoKok16v3EDXamBdRF6eZBIu1UX1IZF9k34nPsLWyJQlA6quCOFRv
	Zsg8mxLVUfgnaXexGBadc4M3QcHXcs7KUSB2Wzm0RUo4IlGGqHCdJp267gqTtUQlSMrsYYjq5Ccse
	dxv2baWUrNQ59NoAZZTfrNuWsHef9eWoxW7vSppgw0suI3yOkPbl889CX6dBe2/Pbf1F0MVeIpeNd
	YHOPH+S2OJRYgY//E9xmV7wuA5wgv4N0XNI2wLvWruQTKxZvz0rb1Zl8Jclic4l32rbiNqu7CQXJO
	QjBYc1oA==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqu1h-00000002Dn5-0Gsb
	for linux-nvme@lists.infradead.org;
	Tue, 26 Aug 2025 13:47:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1CD945C0565;
	Tue, 26 Aug 2025 13:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39448C4CEF1;
	Tue, 26 Aug 2025 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756216068;
	bh=SDKDv4TIVZyQwW8dTQHiERQW4dJY502u9RzkRSwZ3Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mo9ZjFu9/1/CcP8hVMF3bnP53wARLg7+h/L6a3vI8IJd84pXBNRA02aSWeokQiaDG
	 QrwfLKd210bym3D57v3yJI3kSpDRWiGBRxtuNa/MM9z0cDpIeRUwO5fwmyD+7fWE7k
	 GpX9dUJw7Psu9+9CV1/zip4Vf6DX3GcH+WjO0tZWDHNdf6WTjkfXB2gghQWc2jEWBH
	 7dpoIae6CY7BBRP925vLa57bf4B+uVMTZt9ghbGNaOgUltsik4SbvhXaGnjGBqFcQz
	 bqp+iNh/KYDgzksf+ch4yLETehjnvhTeBfP1V161FdMLyxJisyijIcFHjstCZCWkWq
	 FQfY0DjsyrWyg==
Date: Tue, 26 Aug 2025 07:47:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, iommu@lists.linux.dev
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <aK27AhpcQOWADLO8@kbusch-mbp>
References: <20250821204420.2267923-1-kbusch@meta.com>
 <20250821204420.2267923-2-kbusch@meta.com>
 <aKxpSorluMXgOFEI@infradead.org>
 <aKxu83upEBhf5gT7@kbusch-mbp>
 <20250826130344.GA32739@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826130344.GA32739@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_144753_393535_1461DCBF 
X-CRM114-Status: GOOD (  13.85  )
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

On Tue, Aug 26, 2025 at 03:03:44PM +0200, Christoph Hellwig wrote:
> On Mon, Aug 25, 2025 at 08:10:59AM -0600, Keith Busch wrote:
> > 
> > PAGE_SIZEs, iommu granules, and virt boundaries are all power-of-two
> > values, and PAGE_SIZE is always the largest (or tied for largest) of
> > these.
> 
> I just had an offlist conversation with someone trying to make a nvme
> device with a virt boundary larger than PAGE_SIZE work.  No idea
> where that device came from.

Currently, the virtual boundary is always compared to bv_offset, which
is a page offset. If the virtual boundary is larger than a page, then we
need something like "page_to_phys(bv.bv_page) + bv.bv_offset" every
place we need to check against the virt boundary.

