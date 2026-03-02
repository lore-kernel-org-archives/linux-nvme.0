Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25095EA4E22
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 15:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1cwJVjSQcRPZ0OC63DzZLRnCinKsSDhWlUwV/o8PMZc=; b=Q9GteDmqxSot7+l88YPlSjfVqn
	uH4auci/hMZC/yKXRP4aj62lT+hyQ8gYebLomrqawexjwRmMPNwFeJKYx3mAaBhAZ6EfdEVeOHoMG
	awN7/FFuvf33SaZIawBgB9y3yd6jCCXiytU6SOjZoJlz/NsDh9NPSU7r0JWwnjPUiHxKymT3QsIsi
	dvNw07KBQhSgxvQDNo2Y+JEfstzy93/vk6N/6P6vvcp/rhmXbmFX63pLmIY+gz8geCtM16y04KhyQ
	8Ms0cn8Wg1Wxbh+ZEIQzJnEtN5KCYYdR6mzCOMCfi432THIM2F8L3kOQWLYB4HvlySGQ84yIU//Rb
	Q+hjyuvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx5aL-0000000DPLp-2ks4;
	Mon, 02 Mar 2026 15:53:29 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx5aJ-0000000DPL7-03On
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 15:53:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 53F8844420;
	Mon,  2 Mar 2026 15:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6324DC4AF09;
	Mon,  2 Mar 2026 15:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772466806;
	bh=3lki4m9ACKTljBn/+/7u9CsGZfEzbpHbNhJXjkcTkjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcUfmaePhUuQIb2wan2ORwktOm/ZgZJ7adnrXIJRgycKCLR5oBeSvgIl+EdBUN9Sr
	 8o0mOfDJe18L+dCP+ZkJqriPU/YPu+zQNAUFgUL9DAXNEmhxMVXWwCO//OyqN5hFge
	 PSd3hWgDxvzZNoYuweubq4uI1ohATzcXQarPuyoTmpM20YNlMkrOWBFNUrNrVhh4u2
	 xqyra5voehnCKfmA8m5O6B2213BSSdVgmSsPgnAG4p7NuYQ0o5/H0fIyg3XDRBRYeB
	 jDvMXikNBc953EiOQHLn1ZrSSFadZDwrZEOMVKfVmE9N05ufwXQefpD7ofO6bEgWqf
	 jnF5Y7lApuvdg==
Date: Mon, 2 Mar 2026 08:53:22 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Chao Shi <cshi008@fiu.edu>,
	Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme: fix memory allocation in nvme_pr_read_keys()
Message-ID: <aaWycq3ZLraaG2Ny@kbusch-mbp>
References: <20260228001927.382810-3-iam@sung-woo.kim>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228001927.382810-3-iam@sung-woo.kim>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_075327_075644_D5FF5C05 
X-CRM114-Status: GOOD (  12.23  )
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

On Fri, Feb 27, 2026 at 07:19:28PM -0500, Sungwoo Kim wrote:
> nvme_pr_read_keys() takes num_keys from userspace and uses it to
> calculate the allocation size for rse via struct_size(). The upper
> limit is PR_KEYS_MAX (64K).
> 
> A malicious or buggy userspace can pass a large num_keys value that
> results in a 4MB allocation attempt at most, causing a warning in
> the page allocator when the order exceeds MAX_PAGE_ORDER.

Thanks, applied to nvme-7.0.

