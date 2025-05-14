Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9326C3ABC5
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 05:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mj3vG0zd/E2CBgRXIW49AoXjT5SE3ItyhjFEYisCuno=; b=VXwSdQwifkWg3q6pqhg02UR+lF
	M1S1Yq4SAMlf/6I/8+k7BeU03O/odJ4hy3yyC0MLDr2eloI2tLxi2D8bWsu0FXX7YSl0ok+nQFOrP
	ZImGXyT/a6r1W8URPuvz7Pkx1JSxuaFKV/632Dln4QqXxjSzZe2XYV8jhoJUiUW6Xv8sdCHNFntNf
	GfRMaTMxdKHkOhx7M7WuDEE9L7JFOJhxndw9VAZAeOhXGC0UiKgDYXjE2S7Co23HVBJp+iBYxzPY6
	vVHqZqchNwWiFlneFArNb0MJpRmmLDNIlVHFdIDJFnFxz/e6kDjI79r5QzDTIiZPpXRGguCRyGkud
	cZQdIeXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF4KT-0000000E2vo-3oDV;
	Wed, 14 May 2025 05:06:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uF4KR-0000000E2vT-2L4w
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 05:06:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D2D968C4E; Wed, 14 May 2025 07:06:45 +0200 (CEST)
Date: Wed, 14 May 2025 07:06:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi/Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Leon Romanovsky <leon@kernel.org>, linux-nvme@lists.infradead.org,
	Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH 2/7] nvme-pci: store aborted state in flags variable
Message-ID: <20250514050645.GC24101@lst.de>
References: <20250513070025.830930-1-hch@lst.de> <CGME20250513070151epcas5p3f9a1f857f6d7e5433b3281dccebd0dc2@epcas5p3.samsung.com> <20250513070025.830930-3-hch@lst.de> <c6e9b2bb-6e32-43da-8a8a-29775c21c853@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6e9b2bb-6e32-43da-8a8a-29775c21c853@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_220651_736897_BFE16DF7 
X-CRM114-Status: GOOD (  14.89  )
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

On Tue, May 13, 2025 at 07:43:43PM +0530, Kanchan Joshi/Kanchan Joshi wrote:
> On 5/13/2025 12:30 PM, Christoph Hellwig wrote:
> > From: Leon Romanovsky<leon@kernel.org>
> > 
> > Instead of keeping dedicated "bool aborted" variable, let's reuse
> > newly introduced flags variable and save space.
> 
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> 
> Nit: I would not call it 'reuse' as flags (within iod) did not exist 
> before this patch.

It was when Leon wrote the patch, but my patch reshuffling changed that.
I'll fix it up to match the reality.

