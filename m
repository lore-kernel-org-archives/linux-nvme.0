Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181C0C4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Apr 2024 12:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9xe9rTaU2CFLsto6bzuoIqYUMyxBWNXHcGEUdkPjwoU=; b=1Sgn6+sCafbYQOFYtpo/92h+Lw
	9gQkuYuLctA9hrjLgnVy+dGTDQhFnCSAzI6gfeQp0FamRRyY5VPFE/lFnAofcRptmWdg7HSMzP7+K
	4PgIjyBanr/sfA8v3xrm9AwIHVoXkkO0K1c1w1vVnjUtFe+U/Rm+RhLB3FEdVSkryVdxX061K4tlX
	yq72ZaTqqwgTUMUNIWqkcnGb8W+qt4ICHOJfQeKd8E15zQSoM6c57u6fNz+p/BBcU0CstyVpse2HR
	6zyBdklCe6J/XkmSidnKdCVmYBLV6S0WaNPekwbe0gTBJbG7F/vKeU90t7VjgeTC8IQpMq85CaM1X
	Dm5j9nuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Pk8-00000002bA6-0UgD;
	Mon, 29 Apr 2024 12:04:24 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Pk4-00000002b95-3VBm
	for linux-nvme@lists.infradead.org;
	Mon, 29 Apr 2024 12:04:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0471DCE0B48;
	Mon, 29 Apr 2024 12:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5476C113CD;
	Mon, 29 Apr 2024 12:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714392258;
	bh=pq0lWaHsNtRjZLrmFVCuV7gCG3CV9wh1ghXCs79Y358=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c5JqlPe0hBfjXVVONCFuWNbafEdLcnJJ/BHAGEYlyTei08tqypytDGESojmRHUZeQ
	 T1di+VQmX+gAC7drHWz8Oehh8U1hYlnrJFH/nT793f1JKrsdB7JyxF7ms4cZRnZdEe
	 wHMm7fM0Gnf7VQ/+Q6pOQqN+NO1/XbTnYY1lWRd0MF9AqxjFIxexUilMX/IuzTEU++
	 AaoEZIoxE0oRO6JXBtiHrZyPO/wsqgJeM1lZoaQ0SWR0uMOmRb/WIv5iBicDiIx+fN
	 ExkL2u6FeipIU6tPDfIqtx+OFLxgy/boO078TCNJoyCkuGdybMchMaqZk5BjqEJlJS
	 1zQt7IdBKMi+A==
Date: Mon, 29 Apr 2024 13:04:12 +0100
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
	martin.petersen@oracle.com, brauner@kernel.org,
	asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 02/10] block: copy bip_max_vcnt vecs instead of bip_vcnt
 during clone
Message-ID: <Zi-MvOZ_bYVuiuBb@kbusch-mbp.mynextlight.net>
References: <20240425183943.6319-1-joshi.k@samsung.com>
 <CGME20240425184653epcas5p28de1473090e0141ae74f8b0a6eb921a7@epcas5p2.samsung.com>
 <20240425183943.6319-3-joshi.k@samsung.com>
 <20240427070331.GB3873@lst.de>
 <73cc82c3-fbf6-ea3e-94ec-3bdce55af541@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73cc82c3-fbf6-ea3e-94ec-3bdce55af541@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_050421_077279_CEF60DFC 
X-CRM114-Status: GOOD (  17.62  )
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

On Mon, Apr 29, 2024 at 04:58:37PM +0530, Kanchan Joshi wrote:
> On 4/27/2024 12:33 PM, Christoph Hellwig wrote:
> >> If bio_integrity_copy_user is used to process the meta buffer, bip_max_vcnt
> >> is one greater than bip_vcnt. In this case bip_max_vcnt vecs needs to be
> >> copied to cloned bip.
> > Can you explain this a bit more?  The clone should only allocate what
> > is actually used, so this leaves be a bit confused.
> > 
> 
> Will expand the commit description.
> 
> Usually the meta buffer is pinned and used directly (say N bio vecs).
> In case kernel has to make a copy (in bio_integrity_copy_user), it 
> factors these N vecs in, and one extra for the bounce buffer.
> So for read IO, bip_max_vcnt is N+1, while bip_vcnt is N.
> 
> The clone bio also needs to be aware of all N+1 vecs, so that we can 
> copy the data from the bounce buffer to pinned user pages correctly 
> during read-completion.

An earlier version added a field in the bip to point to the original
bvec from the user address. That extra field wouldn't be used in the far
majority of cases, so moving the user bvec to the end of the existing
bip_vec is a spatial optimization. The code may look a little more
confusing that way, but I think it's better than making the bip bigger.

