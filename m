Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF89C87FD3
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Aug 2025 15:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=McM7w5Vn72a46Ln8I8COq5G7vkKZi03J8gCEuohmFP4=; b=KgSuZbaVk24ZRzi+Q6BXiOkzxW
	NFtjTOZfIJEZq9pu5cZ3a1rTUZYi+y1VaYevwrKXnvlbXywWMW2HOhbyqH0IARSGup4DPLJKTP4D+
	mn5lqe8aqosO81Tf+rzw8tQTTqph5vMAtONYdbmVJFYEhchkNORFs+cWFS6gh8l+rh7SEFlA49jdg
	CLXmfoG1Llg2oBKP0RXBwTeCnjFIU/T1MvxayRu2EHU/ar7G0io14sdwncEcV+q15IFLG7VOMvCav
	x7dTcTrDffaxYcxZ6YImjlSDPEOp9yjNTlK4JcTazk8gg8p53iFI412JmemPyXoZHoHczOaRDQc7S
	sA5gkebg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujgAU-0000000Fcgj-0W3Q;
	Wed, 06 Aug 2025 15:35:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujftj-0000000FaAS-41XV
	for linux-nvme@lists.infradead.org;
	Wed, 06 Aug 2025 15:17:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F0BD4601E7;
	Wed,  6 Aug 2025 15:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E85AC4CEEB;
	Wed,  6 Aug 2025 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754493466;
	bh=055cYutF//gSOGKlpgY1emhdHH+SAYQKA84BfsmOBPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZEAEAklZdtIb3rZXD2+57NUU+8kvotAAcckeFsWXkeUrCatVtQwFyvNFc4DNVHrLp
	 iTypXJ7zP5kgRcCbWf91DbgQRJ2/MGKj5A/Y2BvYkpCv+uGyakjDCTTGPrElMEjuiu
	 1Jz1ZsqavRRN6DiqPFW413WlQ++RfcLTeRX0owUsOBs6beP0hwx2SlHrQ0aMinttXr
	 gzyoqYwc9i5Z7vsDDt/FRvVc2Zl9Mr45S+RDO+wIOwxW4KbTCyxQO3AVbUZJ/KOClH
	 eU6iaeEvLU/oVcS3mMit6dgMmHDbpf1WFXj2PVkMGa8zietIG1x9FPdazFU0U+dbgD
	 yMBv2l7Fv2gow==
Date: Wed, 6 Aug 2025 09:17:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <aJNyGArqwjujoouU@kbusch-mbp>
References: <20250805195608.2379107-1-kbusch@meta.com>
 <aJKLGy9UkVjJTIIQ@kbusch-mbp>
 <20250806145333.GA20102@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806145333.GA20102@lst.de>
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

On Wed, Aug 06, 2025 at 04:53:34PM +0200, Christoph Hellwig wrote:
> On Tue, Aug 05, 2025 at 04:52:11PM -0600, Keith Busch wrote:
> > On Tue, Aug 05, 2025 at 12:56:07PM -0700, Keith Busch wrote:
> > > +	bv = next->bio->bi_io_vec[0];
> > > +	bvprv = req->biotail->bi_io_vec[req->biotail->bi_vcnt - 1];
> > 
> > Hm, commit 7bcd79ac50d9d8 suggests I missed something obvious about not
> > being allowed to use 'bi_vcnt - 1' for the tail bvec of the previous
> > bio. I guess it's some stacking thing.
> 
> It is bio cloning and splitting.  bi_io_vec is the original payload added
> to a bio, and directly accessing it is only allowed for the submitter,
> i.e. usually the file system.  The I/O stack always need to go through
> the bio_iter to deal with split/cloned/truncated/partially completed and
> resubmitted bios.

Yeah, I knew about the splitting, but I am only using this for merging,
and bio's split off the front can't merge, so thought I was okay.

But the cloning, yes, I messed that up. v2 is sent with a fix for it.
Sorry for the rapid fire versions; I realized you were travelling, so I
didn't expect more feedback on v1. But thank you for finding some time
to review anyway.

