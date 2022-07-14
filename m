Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70939C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 14:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D0tBUl7jmkGZSpDYBVI9uFaVKkeY85lU64vwagN2oyo=; b=oSriPiDPW6bs6mt9tyVKYeHK7y
	KMB24wXYwXrSqTSrjakpd6kq3vH1ejRJRHOkbOlOWEqUG6lpPPcHCJ1Jfnackp4scFG84/+ArpOht
	cmZO6YPiRMbDDfphNeNgTmsZoDnzWkBtEQ8zfgpGcztiK/QiiJp/+8JI6JSMiidsjGWP8wLHXZhy/
	OwD/1cTE2SakidxXEPVhLmsHSvJFOBH3ycV0dYQmcQNGMCY9NEjxgsq9XS+0mhBsnPshOWpFX9QQd
	wVx2lGRKedaaRDjGfHjwMqDcz/IfcmKjmA8Tt8u2+U75bdPQ/CT4XNW0N8rvibzI1cdtr7pq+Kxxu
	iVXfkl1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBzZR-00F3ii-MS; Thu, 14 Jul 2022 14:12:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBzZP-00F3fa-AD
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 14:12:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2D41C608CD;
	Thu, 14 Jul 2022 14:11:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1327CC34114;
	Thu, 14 Jul 2022 14:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657807916;
	bh=6PoLw4KIaRxQPgf9VCoApKOIpvempuJxYpBUKrcYo4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WkHcs1s16484jk8D5J/H4j+r8ZH2OP5gBPdOkGWuhmomRE3pxhQkPrCbTHN81uci4
	 5ZnRImg2DdKRWJNMyUtJVrQDYXl0RRxKmeRpf2d9FhmUacwXKWDbZ5PVzDZpgFYxx6
	 Eq6Sqb05BajXcLisGdJQ1L4cHaY7fOV1ljUh5zms4Z7Ex5gzHXLSvxVyOl2Y7kxkzu
	 Mr6SUpS4TmmgLnNXBJje3INYdG5m/knibnvaKf8WcAbnqtqNQgVqUDVqHNo1oyo3+r
	 v3he+RA1HU3gQRj/J4I8wYx0dDt56Q2UIBgfkguvaH6Tp0g6u2qKEN3QsxeDpqgnYW
	 RR4LIIaoXmMGA==
Date: Thu, 14 Jul 2022 08:11:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Linux-nvme <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Nitzan Carmi <nitzanc@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] nvme: Fix block device naming collision
Message-ID: <YtAkKZHd/qIuTVT1@kbusch-mbp.dhcp.thefacebook.com>
References: <1657802530-364205-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1657802530-364205-1-git-send-email-israelr@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_071159_415332_D7CB8E6C 
X-CRM114-Status: GOOD (  12.53  )
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

On Thu, Jul 14, 2022 at 12:42:10PM +0000, Israel Rukshin wrote:
> The issue exists when multipath is enabled and the namespace is
> shared, but all the other controller checks at nvme_is_unique_nsid()
> are false. The reason for this issue is that nvme_is_unique_nsid()
> returns false when is called from nvme_mpath_alloc_disk() due to an
> uninitialized value of head->shared. The patch fixes it by setting
> head->shared before nvme_mpath_alloc_disk() is called.
> 
> Fixes: 5974ea7ce0f9 ("nvme: allow duplicate NSIDs for private namespaces")
> Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

