Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2688CEACEF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Nov 2025 16:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WKlgkFj/mBbPKLnBMXpHXHOgvY7MU7CCLVUYRReH7O0=; b=yXF7F3wQN4bGNjK0GupwYaH3tw
	7/PVsoSjFbtH2ucx85o9nfISN0KyqUj90oOyx63SGNIEp/ytlzo69PauxL8DcYxO7qoEJLVLR9BKH
	AVyPyxLtL+IGsjPndFfM/jCfGz03lVgsnMQxlHqxzlu1n5ZLlwmct4M4CgsZ+VCuMNkM0+yRQBg+W
	bnZFPpIHutZccACZsP5WnhK8a9GzJIS8l4+s4ODFKFwDqX/tvMVSfXkKDn6m/6nXH8KHqEj3hwmQl
	3gLuHdI7SDk93jEhl89L0ofIouTm/bvhRPaii1umYRrcLVisgVie06kQth5AELd7+Ugw17e46jtuA
	/IiiEiAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL1s7-0000000GNus-1Y7u;
	Mon, 17 Nov 2025 16:14:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL1s6-0000000GNui-0LGh
	for linux-nvme@lists.infradead.org;
	Mon, 17 Nov 2025 16:14:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4100A60239;
	Mon, 17 Nov 2025 16:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1328C4CEF1;
	Mon, 17 Nov 2025 16:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763396068;
	bh=QMLB80LthzmP7m5zk3AVFsaycW8SdugAFEL6NKAWmlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQPoZgO8UADPwA8wOlMbD47vGCWktMuLHw/xWReL4lwo7ZWHtKFk6KllkGzeUOLLt
	 o2LUrseSoiwIZHh4GcOd7XRrZ4pj1oV+6tB3/aTeI5l0C6t3jyIdgr9VV3i9eR8Pq8
	 /c4HEeZVIZoxEijkp+xQ9Cb310M0oNM6SI6n5ZUqHoHXfcynRw/RBbHEC08T+iABlD
	 2KroMzFwOi0lyTYaMF3NNzg7MWz9ujWOQQ6kaP4xs5JBY4ATLpmDh4TPFUN+qQ52yW
	 l1MDgHx+Hlgjc7P/SsLF7eUNK+gvPnqfxlGn++D4vw2zFzlFZKtuvcGmYmzTR+afoO
	 dLN7XbBLCE/bA==
Date: Mon, 17 Nov 2025 09:14:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH v2] nvme-multipath: fix lockdep WARN due to partition
 scan work
Message-ID: <aRtJ4u-xuhJ3xC_r@kbusch-mbp>
References: <20251117022339.35992-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117022339.35992-1-shinichiro.kawasaki@wdc.com>
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

On Mon, Nov 17, 2025 at 11:23:39AM +0900, Shin'ichiro Kawasaki wrote:
> Blktests test cases nvme/014, 057 and 058 fail occasionally due to a
> lockdep WARN. As reported in the Closes tag URL, the WARN indicates that
> a deadlock can happen due to the dependency among disk->open_mutex,
> kblockd workqueue completion and partition_scan_work completion.
> 
> To avoid the lockdep WARN and the potential deadlock, cut the dependency
> by running the partition_scan_work not by kblockd workqueue but by
> nvme_wq.

Thanks, applied to nvme-6.18.

