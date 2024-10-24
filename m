Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A04CE8E8A
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 15:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T68PMnDTG1Ta1biGmWMW77kDzKhmeHO+EFTBVppL2p0=; b=Oa2GqWXNt7z+yVp1csMFoCyLrv
	OzX4zQcpSmJJpG4pLda6n2/wP9S80QuvdduvBhKSO6k0Z0NxL9J9aTuk6sdRHWaaGdf459vhSMn6r
	i2mtaN99OngM7MaHu9TJR3jkoE51lW6ylWF9L/wpo88/KW2tL1/Of5AtWTvS+qMoMDVU/5cSp3Rm6
	+GFd9/SMfkg+mKFqmNYzO0jBIQSb3WRhBtFNi8V+QETXXTEzp6TlQM72OT5TuD6Jrc2LmWajpLwlI
	44zo41BxNfE3rKTDjw5VYA3sgKQlATRaJ9JkuiiYysilaj89NDYL/pq+antkM3MTlLpivVKRiJDJQ
	q4lUrJQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3zuk-00000000wKo-1k6L;
	Thu, 24 Oct 2024 15:38:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3zcF-00000000tCS-29Wx
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 15:19:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5DBAD5C5FEB;
	Thu, 24 Oct 2024 15:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A60FC4CEE3;
	Thu, 24 Oct 2024 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729783150;
	bh=68D6uLfpTWkcO7b+rAM9kIuSN1wz0cxyY+uvsbspens=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTsl/YOmwo70mR8aDV9oPtfQjL5fCWdWNq5CdYq9Hvl1jHAj9dBoUoKI3qJGEd/dL
	 +AxJ53bwvlk5YQn0uNpYbKyOWPQQ4kFuOSWkXJ/jh+YSrcJinFHYsSwQGS5WK1yn1a
	 wK6A+h0Km+AH2jtPKddj4jnwpMxOo2OGnJv378vMluBTjdncdU+i/90h9okvGdDSph
	 yZf8qbAncoPCBhIqjrFcy3Al+FJmjiiTzxDKousiWalS1l8criWuydxrddGgOIqIbU
	 ScHIzOMLKxwDmtl7Uvacr36OqgPhOioabuHw8UOtvoMMKhlkFvLr3Z1JVgDTMbgCxk
	 uEeCucYaBLmLg==
Date: Thu, 24 Oct 2024 09:19:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, martin.petersen@oracle.com, David Wei <dw@davidwei.uk>
Subject: Re: [PATCH] nvme: module parameter to disable pi checks
Message-ID: <Zxpla3bf6xuuNXb1@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20241023162331epcas5p17398e6453b275a480ace5ae5a0176001@epcas5p1.samsung.com>
 <20241023155048.634988-1-kbusch@meta.com>
 <f4995460-61d3-495d-bed2-0e64d7fe0211@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4995460-61d3-495d-bed2-0e64d7fe0211@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_081911_627449_64846B73 
X-CRM114-Status: GOOD (  16.59  )
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

On Thu, Oct 24, 2024 at 11:40:11AM +0530, Kanchan Joshi wrote:
> On 10/23/2024 9:20 PM, Keith Busch wrote:
> > @@ -1763,6 +1767,7 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
> >   		struct queue_limits *lim, struct nvme_ns_info *info)
> >   {
> >   	struct blk_integrity *bi = &lim->integrity;
> > +	int pi_type = head->pi_type;
> >   
> >   	memset(bi, 0, sizeof(*bi));
> >   
> > @@ -1777,7 +1782,10 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
> >   	    !(head->features & NVME_NS_METADATA_SUPPORTED))
> >   		return nvme_ns_has_pi(head);
> >   
> > -	switch (head->pi_type) {
> > +	if (disable_pi)
> > +		pi_type = 0;
> 
> I think this will not give the desired outcome. Since, regardless of the 
> nop profile, driver continues to send PRCHK_GUARD/REF to the device 
> during nvme_setup_rw. And you will continue to see read-failures.

Oh, I tested this and I thought it was working, but that was only
because it was a freshly formated drive. Yeah, I see what you're saying.
I'll fix it up.

> Also in current boolean form, "disable_pi" will do its thing on all 
> connected nvme devices. Should we make this fine granular. Like this 
> patch [2]?

Let's just make it specific to pi offsets. That's the only format that
I'm hearing problems with, so no need to make this a solution to a
problem no one has.

