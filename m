Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349FFCCD1BC
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Oct 2025 14:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ccfZrZX5LAmsI2ZMlJTpNOvaGdYaJuvAwKA7TZxba7Y=; b=NA8ziY/KznRnspFgq/uEmyfc0J
	ou9/wfEK4lrv05E/6hb9yZEifR1VlGzpAudyORJmkAiC5mY/6NH874Uckk9qAJjnGgGMG3k/lgogz
	IkqHbvKIfiunryrjoNM5pHOhayKoTBG8PfvHHjNgq5+P4tX2gN8kSGAB575P2A+hhKB/z3BB8TGC6
	lh+n7HbOjf/j3sFJvGMhBjqQL+fHsKFzD02cCRMvB5vSiM+it4j/V4NuagcB8KctzBzjiWQlDpnvz
	jyL5gh0tWqAAkWGsaD9tEBfsPLncV3TN1qOUNo5AZK3hOSa2DcM507mQgtHUsc89SbBmPKiWVdlbO
	qjLJfcWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBwIQ-00000006aoo-2iLb;
	Thu, 23 Oct 2025 14:28:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBwIQ-00000006aoV-0IeE
	for linux-nvme@lists.infradead.org;
	Thu, 23 Oct 2025 14:28:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 497A264044;
	Thu, 23 Oct 2025 14:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39F0C4CEE7;
	Thu, 23 Oct 2025 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761229685;
	bh=yp+DjhoA2WPfcfQKNSGW4AXlNtHFAdB39HImq+qwGUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fwPEY6Xr1MneC+Hu9kCrmFhonCDoqj5TPu5/qpwzbokAAj0Gwg6jHXppm1QHNYm2H
	 P96uk8oU5GBHkw9uRiZyfwccpefAg+Ojl6U0a7N0txXqf7I+VUK3a30sBji+VrCOLB
	 U0kMgMX1MXLayxvmgLCo9NPmsVFFH5GPJ5XXmNDVCVLkM1+W+1GJg7AgCcC7wndwP3
	 SYPYBkLlbKrLYiX/77U+KpPcWnqr+12hXk48HcoSqIivsJmZYuA/bwMBZddNh9loc8
	 efQr6C40FK6ANFxk/bHjDYgCBPmfxq6QdVJ5KEX8uTxvTqGCjm1r4pCL2KkYc89INr
	 wyTQvy+xFqfBw==
Date: Thu, 23 Oct 2025 08:28:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvme-multipath: fix lockdep WARN due to partition scan
 work
Message-ID: <aPo7c8aZ7GDqHFEO@kbusch-mbp>
References: <20251023001937.218014-1-shinichiro.kawasaki@wdc.com>
 <aPnDLr2IiOQUQLKI@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPnDLr2IiOQUQLKI@infradead.org>
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

On Wed, Oct 22, 2025 at 10:54:54PM -0700, Christoph Hellwig wrote:
> On Thu, Oct 23, 2025 at 09:19:37AM +0900, Shin'ichiro Kawasaki wrote:
> > Blktests test cases nvme/014, 057 and 058 fail occasionally due to a
> > lockdep WARN. As reported in the Closes tag URL, the WARN indicates that
> > a deadlock can happen due to the dependency among disk->open_mutex,
> > kblockd workqueue completion and partition_scan_work completion.
> > 
> > To avoid the lockdep WARN and the potential deadlock, cut the dependency
> > by running the partition_scan_work not by kblockd workqueue but by
> > nvme_wq.
> 
> The partition_scan_work was added in 1f021341eef4 ("nvme-multipath:
> defer partition scanning") to get it out of the scan work to avoid
> deadlocks.  I suspect moving it to the same workqueue might reintroduce
> the deadlocks, so we might have to add a new workqueue here.  Keith
> might remember more.

I don't think it was a problem of the same workqueue, but because
partition scanning happened in the same work_struct as namespace
scanning. As long as the two happen in different work items, I believe
they can use the same workqueue and be fine.

