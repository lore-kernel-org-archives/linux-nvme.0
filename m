Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C69AEDE9A0
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 15:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=71O1313ga02vhO3TVBYhvBvTB9Y9+k7QIFGmnylK5zM=; b=ulJ0IOrAFpnF52eJgG2+3ZzyM/
	ehNjE1Nd5OwBWQR8kj2t/LzTel7X3CEjaEddoWI/oTivt2XRZmiC159LrlsEzAu2lMBTJ1ANQ9Mlj
	OwBiqUcLHd+whpwj4M7VIfJ1vI7Ez4xb3JVrVMaxutYU3wnJtUwhTdqHZJHjuwLoa92GcfmpSPhFP
	+7dkEeIZPML19i6GHLTB0msFDRUdlpcijkgV43wzRw/pnDHz+t4PXiPJh3+P1xWRRNTlwMcZQf0xu
	dweVf2Tq1I9pD22YHt6AsOXa8H/yp6Qle8GPo33Y1gGSkdarVKNRcTzPoM69uCJexZVH3BV+I9+21
	iATm4pCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so38e-00000006E2v-28nb;
	Tue, 10 Sep 2024 15:50:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so323-00000006Byg-3gJx
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 15:43:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C83468AFE; Tue, 10 Sep 2024 17:43:52 +0200 (CEST)
Date: Tue, 10 Sep 2024 17:43:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 07/10] blk-integrity: simplify mapping sg
Message-ID: <20240910154351.GG23805@lst.de>
References: <20240904152605.4055570-1-kbusch@meta.com> <20240904152605.4055570-8-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904152605.4055570-8-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_084356_083003_3C139384 
X-CRM114-Status: GOOD (  13.95  )
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

On Wed, Sep 04, 2024 at 08:26:02AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The segments are already packed to the queue limits when adding them to
> the bio, so each vector is already its own segment. No need to attempt
> compacting them even more.

Well.  For one the immutable bio API is explicitly designed so that
the callers don't need to know the limits, so this isn't really
true.

And the other thing the map_sg helpers for data and metadata do is
cross-bio merges, that is if the end of one bio is contiguous with
the start of the next, it will merge the segments.  I don't really
know how useful that is there days - maybe we can removed it with
a proper rational after a bit of testing.

Again the current code closely mirrors the code for mapping the data
bvecs, and I'd preferably keep them as close as possible.

