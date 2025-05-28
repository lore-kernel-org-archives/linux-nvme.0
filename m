Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CB1C3ABB2
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 22:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=auuuOfYYnZnuboodVBti/Pz7Zc0vU3vj5lTMIurVY/0=; b=3eblW7OjazghvBkp9ub9UqI6Z6
	E++lQgasRAlI0OHjScQ8jyMadg2MfdZciYkqxIFMx6Gz6ppmGs+8DF8XZ+CXjpgI+nR1tYrHF/FhL
	zmLmKcu333GiXuMoVRgkZYpZqSuOoTosQUcAj3+6ipgG5JLFkNM1+5o3xx8PEhnY7Flx70k38lGjE
	j5UJLKd7qNk5N0kvFslFWYEm15AMTFvf/kycPwp17ORWcscCBqU2gzYreJDN+OKIf+KK4aqRCY79n
	iP4FLNeJQzOJ3s/jj1ZneI4T72S4pmJNQ7qQ5IQqSNkFXWmhfhXSsOEbgmspUthNw/Hfcv1YLLzHt
	i4NY54cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKPTK-0000000EHhA-0VLJ;
	Wed, 28 May 2025 22:42:06 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKPTH-0000000EHgQ-0NXd
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 22:42:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 365015C5BC8;
	Wed, 28 May 2025 22:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5349CC4CEE3;
	Wed, 28 May 2025 22:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748472121;
	bh=ODdciq5CPilvv2sX+jC3jzyer7v1cNd7rtqpkTLUeeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uBUnQcdiV6rTXTtXWA68kYP7PQFcmiykecdmy8GayayaBsdmstzouiE1O+OhYtthq
	 VqTsWOzUyj3/b4QwmMGkj+ipdgXVBwOkQ15kisgZdyUOBRFjjYnU+5KKxiUI0im0SF
	 mZMeVEgVa797NMSc4gbUjoosHXmV9hWMCatpHKiinefU2XfsN1RYeJ6ijfqLtt6tTe
	 5aZ7knEl62wwJFkGBKR9grmenMXdjf3QlVx6RelgNIb56SmHjC1wXozuPa5wmlwO2B
	 DTDfEZd2s1JzH9shqKQYfgMjAo4xymv3jOe796ltcglhQVq76I9Q56HcDJAWTLB2DL
	 ufErIPmsk9OHw==
Date: Wed, 28 May 2025 16:41:58 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Mark Harmstone <maharmstone@fb.com>
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aDeRNvT5x_qRj3kX@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
 <aDBt1qXj90JO1y2v@infradead.org>
 <aDCqGLY4irp-6N5M@kbusch-mbp>
 <aDP5o1qb02iwgw-V@infradead.org>
 <aDX6NjOuGvxhbw7C@kbusch-mbp>
 <aDa_O4HGWjy_35I7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDa_O4HGWjy_35I7@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_154203_165730_E3024F15 
X-CRM114-Status: GOOD (  16.28  )
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

On Wed, May 28, 2025 at 12:46:03AM -0700, Christoph Hellwig wrote:
> On Tue, May 27, 2025 at 11:45:26AM -0600, Keith Busch wrote:
> > Just fyi, the initial user I was planning to target with the block
> > layer's copy fallback isn't in kernel yet. Just an RFC at this moment on
> > btrfs:
> > 
> >   https://lore.kernel.org/linux-btrfs/20250515163641.3449017-10-maharmstone@fb.com/
> > 
> > The blk-lib function could easily replace that patch's "do_copy()"
> > without to much refactoring on the btrfs side.
> 
> Well, that code would be much better off using a long living buffer,
> because the frequent allocations are worse.  

No argument against that. I'm just adding context for where this blk lib
patch was targeted. I'm happy to help on both sides to make it more
usable, though refactoring other block copy implementations (splice,
kcopyd, xfs gc) to a common api looks like a much longer term project.

