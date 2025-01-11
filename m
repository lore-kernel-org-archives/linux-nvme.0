Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C928EE7719A
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Jan 2025 03:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CoZcCNtrdFCCe1m+D0+Rs1CtGzyYComkSmQ+WRamy9k=; b=ygGIxVAoJH1+P0O4hSW+BR8FTq
	FUe7dl3JD6U0nvvqdokdZ8tVjlEtLVTqlQlVC5h9mxKRcEPWwdFhgeAUau6B9OrFte9wdlgncyzmc
	xacm4pLuOidylz6so7MoG+qxVi//nvIYzNWH0dVX1RVT304572dRgIt+EhDS9TomNqi3xyJYWZzPa
	GVmnO+VWACwC5MebigrQgcjBGxFP2Yo1mqeTaNEgWbWQqqtI5xXELPkGRbcOiFYqQM3yMR3iC8lND
	SDbN/pKI2WVNJi8jzyx/JeL1RiZkgpqtNW04El6hjJzMBfLUFhhNiAHHQIu++PvRzAyu7/OhJH5DP
	K5yePnfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWSdT-000000006oh-03wM;
	Sat, 11 Jan 2025 03:58:07 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWSdP-000000006nW-0nvh
	for linux-nvme@lists.infradead.org;
	Sat, 11 Jan 2025 03:58:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E2D27A42A79;
	Sat, 11 Jan 2025 03:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95AD9C4CED2;
	Sat, 11 Jan 2025 03:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736567882;
	bh=FzIRkdSwwlq7qKwvyzxhmtOXkx7dHh/k8ECgQR/NDBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGCzqhFASubTT29fc8rqL8f9cBuz/G1plnzRhbI3JsgHziSAFqjm5fVfSxDs13x1j
	 LAB84VhX6YHkqsCxTqWINqhrg07e2Dc0AVlYkVSrV2KiDkg1CjKr4GJerRB13gEEMc
	 p11xmk+JtKVy1nQTrnAwJZLfsd0wgHFq1KIDqWocK4U+vzBebspzpxHuWpiSuqRtxv
	 zma+97C08bdT0CH/0SWGQXpO8I9yggdW0gWBKYvjJqeNCoyGM5qUfzRoA7UpDeBJFm
	 mnq2dOXmaS2zWJlxzdS3tUVO7FAdiZRpGlUWaNDXLqQoaC7tWULzqoF5U4b0hgEEXE
	 roE0GcFVM6u0g==
Date: Fri, 10 Jan 2025 20:57:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] nvme-tcp: initialize the mq_map to NULL
Message-ID: <Z4HsR9kaAvRUQTw4@kbusch-mbp>
References: <20250109063043.95996-1-kch@nvidia.com>
 <271ee0a1-431e-483d-80b1-72405b0728cc@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <271ee0a1-431e-483d-80b1-72405b0728cc@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_195803_297722_AC6A7A62 
X-CRM114-Status: GOOD (  12.95  )
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

On Sat, Jan 11, 2025 at 12:48:04AM +0200, Sagi Grimberg wrote:
> 
> 
> 
> On 09/01/2025 8:30, Chaitanya Kulkarni wrote:
> > Initialize the local variable mq_map to NULL to remove the kernel
> > test robot warning.
> > 
> > drivers/nvme/host/tcp.c:1594:13: warning: variable 'mq_map' is used
> > uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> > 
> > Fixes: bd0f5c103101 ("nvme-tcp: Fix I/O queue cpu spreading for multiple controllers")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202501091328.r4kJ6xhy-lkp@intel.com/
> > Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> 
> We should probably just fold both this and the next one to the original
> patch.

Sure, folded in with an updated commit message to reflect Chaitanya's
changes.

