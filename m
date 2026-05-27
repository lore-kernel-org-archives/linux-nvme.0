Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F110CD5BD0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 13:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wm+eM7y+BngSGqC1i5WNshINxwy6aByOWcOFctDfxBA=; b=vK+DP4g7HlDjrnQz571OmFrlM6
	ofGisuMUtZIJwJBjPWbalfXOt0EqvyvMCC9QdlUqLp1I5rI9H6lrjBl0vR7v3aZ4bpnz8EhZ3HzUx
	t+4MgWQ2GioZevbY4LlcoeFVWhyiitivuG26fsg0fgqV2MjN7IWJPKctQ9PKtGwSvHA19HE7T9Dtw
	xVLw0xrKvBKAfPjOhCSFgTQ28jy2R0MFnc327UCjQ5GTZm+sTMzd3mux14K6e5qcw4FQA31QfZUD6
	HGKFwSMbgIggq+D4uj0rCqTeB6VcvWdpZ46wzzhdRmFrBxlZL3emAHXLNwnYA8//hjbzbcGUlwutJ
	ZnrDE8XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEdC-00000004Edg-0jVt;
	Wed, 27 May 2026 13:49:10 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEdB-00000004EdX-0Rqx
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 13:49:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 19F45602CC;
	Wed, 27 May 2026 13:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B7D1F000E9;
	Wed, 27 May 2026 13:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779889747;
	bh=Wm+eM7y+BngSGqC1i5WNshINxwy6aByOWcOFctDfxBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jCl/r5ZvFlVJU33CVxW5/drnFgjTtO60Hmf9qYBpUg2NW6gYyWmnmrg8yvFwYDHOR
	 sZl+o4Fa7AtRQNppaZxQpvdu5BvUDb7EVIRLyGcWqSjNRe0aHbqgi0jeCSK+/Gt8oO
	 7NImFb3NAc8/aOESr3bWuT09IBC7yqiVIFfwwi0tm6hKAsfKQHKQ31jLk62sdnskvB
	 te5TbzsKANqaZDSQ9YVPsOKOTopKwQiFgD9qJAPXXvVRYGFvg87p47r+eL6oyYbw7p
	 BbkaWJ9qX7nWC/uS14S/3VNphYVp4XpijKUNJiNZGWsbAmqgBseI+hOIE7qxsy3tlP
	 L/r1rVUOZK62Q==
Date: Wed, 27 May 2026 07:49:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, axboe@fb.com,
	sagi@grimberg.me, gjoyce@linux.ibm.com, mkchauras@linux.ibm.com
Subject: Re: [PATCH] nvme-multipath: fix flex array size in struct
 nvme_ns_head
Message-ID: <ahb2UTQsJywNagyk@kbusch-mbp>
References: <20260527062010.4036702-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527062010.4036702-1-nilay@linux.ibm.com>
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

On Wed, May 27, 2026 at 11:50:00AM +0530, Nilay Shroff wrote:
> Fix this by allocating the flexible array using nr_node_ids instead
> of num_possible_nodes(). Since nr_node_ids represents the maximum
> possible NUMA node IDs, indexing current_path[] using numa_node_id()
> becomes safe even on systems with sparse node IDs.

What is the largest nr_node_ids we can reasonably expect to see? I don't
want to end up trying to allocate a billion entry sparse array just to
index a tiny fraction of them. Not that we didn't have a similar problem
before, but this patch makes it clear we haven't been checking.

