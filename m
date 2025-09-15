Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93B1CAC592
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Sep 2025 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DZJvqKAM3Hvb9HfRLPv4gph8Ip9G/Crr1sDVleQwT0Q=; b=yU2gVvIW1gCa3xSGrEag3UvnVM
	VK/1w1rjKlVhrTMuo2RbwwHAtB8sVrKsnhLJDJ/fYawkhFt/4UA9qMNVmRPq7LcJDUUgnqY6dN8Ro
	LuAxP75g/ekWwHgXhpavD9eTe1XPqrBdckzHjrCQHpWE3TiKOUKWkcX/nLb60ZDrs7vcRssmTzs9U
	6uciLz3ehmKHixAJC6/6i/GEb6yYRar9CDz+TvKu8Nu7kRdLoH+/dhdCOlNTYnJ17KPySUUpQhxt7
	CMq2xGKvB3enks57QVAZvHt80zCAv2pxaAvXuCVvpzBE4ouy5CwBBFPd4o6a1CwyUvjAkbUeJI6Am
	9553DsRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyBXH-000000051NF-2lqm;
	Mon, 15 Sep 2025 15:54:35 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyBXF-000000051MK-0T1f
	for linux-nvme@lists.infradead.org;
	Mon, 15 Sep 2025 15:54:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1FA5B41991;
	Mon, 15 Sep 2025 15:54:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C0FC4CEF1;
	Mon, 15 Sep 2025 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757951672;
	bh=PU0OOPiAgbD+Iw9nQrDiwgBmr5LTIbyqLTo6qzwGXCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjyUCt8jr+g2CDJYU9PDyIz3JKdKpkvmSnINEGwkIHefL/J4iwWA42AanpSKglZDn
	 ikplR8F4zMe7fAt+9hBj6uBI3aY+twvZS//4THIsr2rCds5ul52yRmDXgzUdx1Qe48
	 Oir1h0rDknKdjzuiNK5dGC82iKk8PHtJek83UxNroAjMq6sKDExXLaLcj3n5jb9kVg
	 mFwSup0JeQpYd3idg6eBLUpDMsxeHrkNYdKkZ3cgp58xKiwgLNhHmAJw/8KtNEktAh
	 25uF4paR/es37oSYv6vPvnKxbV10ZEDUw1CQkX2yF93eEDKZFE53niwdEV42cOIyWl
	 NNrOBS7j0+dBg==
Date: Mon, 15 Sep 2025 09:54:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] nvmet-fc: fixes for blktests tests
Message-ID: <aMg2tdHWa0-dE5F8@kbusch-mbp>
References: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-fix-nvmet-fc-v3-0-1ae1ecb798d8@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_085433_166465_F9A73E95 
X-CRM114-Status: GOOD (  13.48  )
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

On Tue, Sep 02, 2025 at 12:21:59PM +0200, Daniel Wagner wrote:
> I've added the other two patches I've recenetly send out to this series
> for getting blktests with FC more stable. So this series containts all
> the latest versions of the patches flying around.
> 
> What is missing are the changes for nvme/041. These patches need some
> more work and more review.

Thanks, applied to nvme-6.18.

