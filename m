Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9672CC3ABD8
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IrcvmfnMcmMgYQvBgzP1gkvwHVTWBhEuAowHSxsqLok=; b=QosB0g0rwwP3dwTQ6IAf9xVDp8
	QSsiH6c/cD+qjbBq9Q15I45Zl1JN95x4CfI8E4PZL6vAJD0AAKSvWjwchdXwVoItvUiG+InfrMRdi
	3Q2FO5K5CJrajflNctSestTIckHd4mxolHaS/EHXAOZEyzo0vCaosFyHEU8e6DN/tIPFseFtJ6wVy
	ajGO8j421m41Sc8bFEaLW+7YA5R5fHBdkvVQnsabZMqtREUuzpY/8YCknemVTz1ehjRrzvTtm05GD
	zh8xBgfWtLcx2bsvvQ6lb5GZGhSXBOBlTl16T2Ku2wDsWIckItu0Dpqil5itrx1HIIfmc3bSgg7CT
	UQ4Ognaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFCZL-0000000FJlq-3bN2;
	Wed, 14 May 2025 13:54:47 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFBoU-0000000F9tG-1KZZ
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 13:06:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 00795A4DB68;
	Wed, 14 May 2025 13:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDB6C4CEE9;
	Wed, 14 May 2025 13:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747227980;
	bh=NFcsQsRZ5S9euQYtpkep7jz+DaqGG34nkmnWsuv+Kwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JJdoPLA8jK/hWSK4bdF9kT1FXKE93xjB6V4tyN0lfpsryEO7ZGF5kuR90XK2fT1Dw
	 RojElXXuyR2aUMdhU4CGcfOdJ3/CDm/GfwFyCkCCVQIV5k71nE5umKc5NIqN0qOuVz
	 0q9DWMZgqWaiFpLRS1eo5UpcH+uapTh8nvO93S+0miQKahUeRewPgsYvkL7xMNpDlO
	 UkVidJcdIHwnsXP+X2FktNqNyaggIijVhZx5o4T8ACPbYsR0hIJdFaV6Y/xz+0zV6q
	 6JY13syK1tuBCKt3f++u3fzj2xYBZVARsZ5qMcK94nze7e0NFbbHA4n7etmp1ihDXH
	 icpSv1AgzIu/g==
Date: Wed, 14 May 2025 07:06:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Leon Romanovsky <leon@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/7] nvme-pci: use a better encoding for small prp pool
 allocations
Message-ID: <aCSVSecpQ63y7g_A@kbusch-mbp>
References: <20250513070025.830930-1-hch@lst.de>
 <20250513070025.830930-6-hch@lst.de>
 <aCNf_rHaLdS-WTEO@kbusch-mbp>
 <20250514051221.GD24101@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514051221.GD24101@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_060622_418055_EBF1D6E7 
X-CRM114-Status: GOOD (  13.74  )
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

On Wed, May 14, 2025 at 07:12:21AM +0200, Christoph Hellwig wrote:
> 
> Something only vaguely related:  do you remember why the metadata SGL
> descriptors are limited to just the small pool?  It would be nice
> to support as many metadata as data entries, which we'd almost get
> by using the larger one (we'd still be one off).

The only way I'd expect to exceed what the small pool provides is
through merging, but that feature was more of an afterthought.

My intended use case was to support zero-copy for user passthrough. The
metadata there is a virtually contiguous buffer. You'd need very large
IO in order for metadata to require more than few segments, so the small
pool's 15 segments  was sufficient. If you are doing large passthrough
IO (>2MB), then you should be using huge pages, in which case we'd still
only see one or two segments for the metadata.

But if you are trying to merge dozens of requests with metadata into
one, then yeah, the small pool isn't large enough to accomodate. If you
want to support that use case, then we can certainly change the driver
to use the large pool when more than 15 integrity segments are required.

