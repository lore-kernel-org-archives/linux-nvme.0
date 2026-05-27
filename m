Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8BFCD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 14:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lrMy5XoTm7Lv1K0Dlmhz0gi4U1x6fuLBf5hx7iNa3gs=; b=0xX6bWZJLKkq1La/QeAcNSwiGw
	+oP8bhBOfVN2dtArMbPMy5WCTiUbVCSuoa3Ca5OLJJjwOtIasbe7JhWt07V70Q0aSPllb4v4YyQYC
	ckRhCy1my7dsmiYCljaztHk8KHOK2tUtLL8L3bxjhByeZ9YwlyKh+Sezw5MphybaEuA9/YKyX6pMq
	mNIo567rWu1ntXc/IPHzRTbwTp6jQ1QzqU7bIboNaMKH9ixC6mATYpSjwtmwGJlohEgSEyGu/xGTc
	jbOKN+l2IT3SjEFFXv7jwWv4hs49KijQ3WC2CMA6bzxul8kB6oq1CS9uT4JkTWqKyywWS9wS0zAE2
	nE9VNpUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSF50-00000004HKf-1wq1;
	Wed, 27 May 2026 14:17:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSF4v-00000004HJ3-3pqE
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 14:17:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7DFD143844;
	Wed, 27 May 2026 14:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F138D1F000E9;
	Wed, 27 May 2026 14:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779891468;
	bh=lrMy5XoTm7Lv1K0Dlmhz0gi4U1x6fuLBf5hx7iNa3gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rdj4CgeZipc486yIlgW65qVnSIWQsUUQe2vQ56tvYNkuzCjr9Oc77hwTCqqhdlrcQ
	 NEUWIJ6/0/Sbt4ccJIw++TYnpmFwYd3YbBBZTRvphE4oS8sJKf5psvGzjov8H3VuAv
	 2JAmIMV5xv4VxGqXVRoKcFGF9A+OQgyuzTouPAvKYw3OiJ4jl2A1hhr/IpREBVD/F3
	 aZ8eKxC5vNb6AndBh1MxS5IPdlM6sVKdaVLBmphXQ4L/T4iDSnTcyL6UGy26YxNEvx
	 0awWd1bjOm/h+6CisK9Iv0PWKMAw+Svtthh/O9j4eeFwIDsUOsRp5LSdey6xbut04m
	 YMFVbKqwLdGAg==
Date: Wed, 27 May 2026 08:17:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Roy Shterman <roys@lightbitslabs.com>,
	Solganik Alexander <sashas@lightbitslabs.com>,
	Hannes Reinecke <hare@suse.de>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet-tcp: fix page fragment cache leak in error path
Message-ID: <ahb9ClPIBPRTy3CO@kbusch-mbp>
References: <e4df8752611dc5914f849b1d17f5512434b954cb.1779787061.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4df8752611dc5914f849b1d17f5512434b954cb.1779787061.git.tanggeliang@kylinos.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_071750_035429_9D3A96F6 
X-CRM114-Status: GOOD (  13.34  )
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

On Tue, May 26, 2026 at 05:22:22PM +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> In nvmet_tcp_alloc_queue(), when a connection is closed during the
> allocation process (e.g., nvmet_tcp_set_queue_sock() returns -ENOTCONN),
> the error handling jumps to out_destroy_sq and then to out_ida_remove
> without draining the page fragment cache.
> 
> Although nvmet_tcp_free_cmd() is called in some error paths to release
> individual page fragments, the underlying page cache reference held by
> queue->pf_cache is never released. The first allocation using pf_cache
> is the call to nvmet_tcp_alloc_cmd() for queue->connect, which happens
> after ida_alloc() returns successfully. This results in a page leak each
> time a connection fails during allocation, which could lead to memory
> exhaustion over time if connections are repeatedly opened and closed.
> 
> Fix this by calling page_frag_cache_drain() before freeing the queue
> structure in the out_ida_remove label.

Thanks, applied to nvme-7.2 with the fixed up comment style suggestion.

