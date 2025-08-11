Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C338CA0EC4
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Aug 2025 22:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kYicCkvwMNH+xFzqFAZeYwU21/QDCpHEdPOuB+xLICY=; b=p1feWCideIEHEAHa/Thrw23yv4
	w3JGj3zB3OXfcEHvEmXqQc4uZtIePo+maiNTyuf1NIqljjbHj09/sBBvqYccrgepvmdnSer4F4tRf
	MtuAu1Aue2BwpvgnN3u2W1PvGd99ZAeQ6GdXy7l8DVj8RUY80K5mUqe61GHIJia1vXSC4IU3xmg8i
	BL4906A4gSkWOkp7GbsIAHL89oc0XWb0tbbi+4VI3XDlnpsKT1+9n1jAofza7/Qh1XscmaDEbF6BT
	4f7jg+h2odGFK4MZ8TBCvJd4gPXZeMZ2iLBqHRCdTMoG9bMw9xfk+zxbBdxc9PInA4ZO4KHXNO7jd
	1fzvoxgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulaaX-000000098zQ-0Idv;
	Mon, 11 Aug 2025 22:01:53 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulUQi-00000008CLt-3kKV
	for linux-nvme@lists.infradead.org;
	Mon, 11 Aug 2025 15:27:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 98A9D42B73;
	Mon, 11 Aug 2025 15:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A13DC4CEED;
	Mon, 11 Aug 2025 15:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754926040;
	bh=VpLhh5UIBa5WLWeWZ91IRhfl7lk6wwEiIrfIGeNP384=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESZVrbwu8vQ0/ZLULCITShyrmsSE4YnhQuKlM6sXRQavbKIMFKpKFZjBBSw5EpjML
	 CwCCWG+Y3h5+iQAHdgZHEf2fw++Qg/hfXpbSpFVKK3EgpHmH1SPgLFFF3XgWO7SQQv
	 VYmLiJ9aQtNtK7bdwoERwKSvX/UGVUJoanUXixiPok2NlRg2G9pjE5qFS+Zuq7d6jl
	 xGNvc/2OOoZoyPyS5hrE9PaKhX19gvSqurB9VfeOTPtVGqElV0wCPg2IrD81wwZ6eB
	 GRqGPD0Md9rGe9enDks2OPMLMUew/1vAjbrxgnYQ8F2NdBSsLAgyuwdiDq6vfhisWA
	 Dz0jniuxG7asQ==
Date: Mon, 11 Aug 2025 09:27:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <aJoL1rsvI5bXkod_@kbusch-mbp>
References: <20250805195608.2379107-1-kbusch@meta.com>
 <20250806145621.GC20102@lst.de>
 <aJN4b6GS30eJdQLd@kbusch-mbp>
 <20250810143112.GA4860@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810143112.GA4860@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_082720_952434_DB64479C 
X-CRM114-Status: GOOD (  18.93  )
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

On Sun, Aug 10, 2025 at 04:31:12PM +0200, Christoph Hellwig wrote:
> On Wed, Aug 06, 2025 at 09:44:47AM -0600, Keith Busch wrote:
> > 
> > Maybe, but I don't have anywhere else to put this. We split the bio to
> > its hardware limits at some point, which is where this field gets
> > initially set.
> 
> What we do for nr_segs is to just do it on stack while splitting,
> and then only record it in the request.  I think you could do the same
> here, i.e. replace the nr_segs output parameter to __bio_split_to_limits
> and it's helpers with a new struct bio_split_info that in the first
> version just contains nr_segs, but can be extended to other easily
> derived information like the page gaps.

I initially tried to copy the nsegs usage in the request, but there are
multiple places (iomap, xfs, and btrfs) that split to hardware limits
without a request, so I'm not sure where the result is supposed to go to
be referenced later. Or do those all call the same split function later
in the generic block layer, in which case it shouldn't matter if the
upper layers already called it?

