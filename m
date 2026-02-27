Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356D1FEFB56
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 15:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fVxIgi4uSAszfCjHDHBNcOW4899pMrch6JmPWAM563g=; b=uIGPB1Ax+/pilrfiUpxx4Y3kMz
	7M6HnzBlpFK3Bbp9zdw4V/tBv6k7lzcuIfQeGDP79Niqdgd6//N7+t1vaOV05b2XjXxhUHc5US4Gv
	MuzTZOlO+4PeO4H0a4NHBpDLrlbcs0GGZUCAi4ZWVH9zii/SvkxoOLjPugA7W6/4cqAkYl+RRAMKW
	sRSL7h2/qhb7cYldX+V8t5kNxHzavllwFxyG98wNso3tYgVguVH/+QwAZcPwBz11hucvRSiaFo5Eo
	hFRlU3ogzImjC5xCaufJLb90tML9EwwnCsDL1RjjREd6QmQOLTZLa3Nq/A/6S2VsD7PLfL5G4b10c
	oQHgMEZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvzrD-00000008eSv-3TDc;
	Fri, 27 Feb 2026 15:34:23 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvzr8-00000008eS6-2eHW
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 15:34:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C9B89600CB;
	Fri, 27 Feb 2026 15:34:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3780BC116C6;
	Fri, 27 Feb 2026 15:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772206457;
	bh=XgvU22+GG3Oyq9B0g8tXqkGFh3/bE1hZ8SIX67+YJbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AR88bxd5mDf6abEf6w1cB4F0wLdQazwpI0njQDWtN2Mt0vc2e6qCcqi9yl9HcZcr5
	 SBp/aY7P+Jx4PhgKAk/v4c3PS6Z88FXiPFdo+gjjSZJzF9yY8UbOhOkGpb5ed3oOIn
	 rOf1TVeA/NOeH+PlU82+2aSdvu4lUdDduobIt8PWewA65o0QNhCQ2A+76C9d8bDCIz
	 iDIX9qvPEH4k8d/WT64qC7pGO1ZXJ2doPWh0kufujh5x/z5qWJzQBKpOtIjmpVdvj1
	 1fKjekKKB/HXM4AHnw1DVbUDYyLVyezTbEEMQvbuTV2QcG9GxmcQmNgjeRnlXyAFH8
	 R3CkHwd0t549A==
Date: Fri, 27 Feb 2026 08:34:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de
Subject: Re: [PATCHv2 2/3] nvme-multipath: rescan siblings on last path
 removal
Message-ID: <aaG5dpk_w16ZN4uO@kbusch-mbp>
References: <20260226183216.2098584-1-kbusch@meta.com>
 <20260226183216.2098584-3-kbusch@meta.com>
 <7797a6a3-d47d-440c-a580-40bae546728a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7797a6a3-d47d-440c-a580-40bae546728a@linux.ibm.com>
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

On Fri, Feb 27, 2026 at 12:29:00PM +0530, Nilay Shroff wrote:
> Should we consider reordering patches 2/3 and 3/3? It seems like this
> patch depends on the changes introduced in 3/3. 
> 
> Without the updates from 3/3, if delayed head removal is still in effect
> and the NSIDs are recycled with mismatched identifiers, a forced rescan
> of the sibling controller may still fail to instantiate the namespace.
> In that case, requeueing the scan alone might not be sufficient.

But the other way around, if we're racing with another controller's scan
to complete the last path removal, then the delayed work hasn't been
scheduled yet so patch 3 has a significant gap without patch 2 preceding
it.

