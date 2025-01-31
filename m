Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD61C02190
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 07:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B+6RWyPdzua33wrpC4jHQwS/hrcoeEUAI9guq2dWdtU=; b=bMlK8qd+QullnkyjpGnOdXkJQn
	VCULU/or05d2d7VEUupi8rxd5T7oX1o5RxAXIG7Layhj9BVi5E5Cjl5NgSRbTHQXJKBSWqhDSSGAy
	Qvptz4eQc9i49NcORis9P9D9vZwVC3C5cABTjlzNNHfdS6+AfXjaG+nncPnavEL7nh7mnJUE7E745
	emN/naJXBd3gfUbyXJkSIVJIYF6eEeoul1CqIsgGtH3C20IWItdIkSLDafxd0BulLeQ/Xbhg5nvmz
	TS7xBsSLf5AWw8IgtZBXepNi1wrGxhEv+GZHYpjCszmaCRg6YJ2NaZStNR9TrNXfvynMecScSG/z3
	Es1K/5Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdlhY-0000000A8fN-1w2x;
	Fri, 31 Jan 2025 07:44:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdlhW-0000000A8eL-0Uqe
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 07:44:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id ED57768B05; Fri, 31 Jan 2025 08:44:24 +0100 (CET)
Date: Fri, 31 Jan 2025 08:44:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, josef@toxicpanda.com,
	dsterba@suse.com, clm@fb.com, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de, linux-btrfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <20250131074424.GA16182@lst.de>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com> <20250129140207.22718-1-joshi.k@samsung.com> <yq134h0p1m5.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq134h0p1m5.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_234430_303335_3FBD6FEF 
X-CRM114-Status: GOOD (  16.63  )
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

On Thu, Jan 30, 2025 at 03:21:45PM -0500, Martin K. Petersen wrote:
> So to me, it's a highly desirable feature that btrfs stores its
> checksums elsewhere on media.

Except for SSDs it generally doesn't - the fact that they are written
at the same time means there is a very high chance they will end up
on media together for traditional SSDs designs.  This might be different
when explicitly using some form of data placement scheme, and SSD
vendors might be able to place PI/metadata different under the hood
when using a big enough customer aks for it (they might not be very
happy about the request :)).


> But that's obviously a trade-off a user
> can make. In some cases media WAR may be more important than extending
> the protection envelope for the data, that's OK. I would suggest you
> look at using CRC32C given the intended 4KB block use case, though,
> because the 16-bit CRC isn't fantastic for large blocks.

One thing that I did implement for my XFS hack/prototype is the ability
to store a crc32c in the non-PI metadata support by nvme.  This allows
for low overhead data checksumming as you don't need a separate data
structure to track where the checksums for a data block are located and
doesn't require out of place writes.  It doesn't provide a reg tag
equivalent or device side checking of the guard tag unfortunately.

I never could come up with a good use of the app_tag for file systems,
so not wasting space for that is actually a good thing.

